# SentryPact Web

Rails website, backend, and future customer dashboard for SentryPact.

This is the only implemented app in the SentryPact monorepo today. It owns
the public site (`sentrypact.com`) and will grow into the control plane that
native clients depend on: accounts, devices, pact state, signed configuration,
and audit events.

## Stack

- Ruby 4.0.3
- Rails 8.1.3
- Hotwire with importmap
- Propshaft asset pipeline
- Tailwind CSS
- SQLite for local scaffold storage and current production storage
- Solid Queue, Solid Cache, and Solid Cable
- Puma cluster, Thruster, and Kamal scaffolding
- Minitest, RuboCop (Rails Omakase), Brakeman, and bundler-audit

The repo's `.mise.toml` pins Ruby `4.0.3` and Node `24.13.1`. Use
[mise](https://mise.jdx.dev) (or any tool that respects `.tool-versions`-style
configs) to match the toolchain.

## Development

From the repo root:

```sh
bin/setup
bin/dev
```

Or from this directory:

```sh
bin/setup
bin/dev
```

Then open [http://localhost:3000](http://localhost:3000).

`bin/setup` installs gems, prepares the SQLite databases, clears stale logs
and tempfiles, and (unless `--skip-server` is passed) execs into `bin/dev`.

`bin/dev` starts the Rails server alongside the Tailwind watcher via
`Procfile.dev`.

## Checks

The canonical local and CI gate is:

```sh
bin/ci
```

It prepares the app, builds Tailwind assets, runs RuboCop, audits gems and
importmap dependencies, runs Brakeman, executes the Rails tests, and
verifies seeds. The same script is what GitHub Actions runs, and the
release-blocking workflow also builds the production Docker image so
deployment regressions fail before a release.

Individual steps:

```sh
bin/rails test
bin/rubocop
bin/brakeman --no-pager
bin/bundler-audit
bin/rails tailwindcss:build
```

## Routes

Public marketing routes that exist today:

- `GET /`         - landing
- `GET /overview` - product overview
- `GET /pacts`    - Solo Pact explainer
- `GET /privacy`  - privacy commitments
- `GET /safety`   - safety / coercive-control note
- `GET /pricing`  - pricing draft
- `GET /faq`      - frequently asked questions
- `GET /support`  - contact / support
- `GET /up`       - Rails health check (excluded from SSL redirect and host auth)

## Production configuration

The production app is configured to be secure-by-default behind an
SSL-terminating proxy. It is HTTPS-only for browser traffic, with `/up`
exempted so a load balancer or uptime probe can hit the health endpoint
over plain HTTP.

Environment variables:

| Variable               | Default                                  | Notes |
| ---------------------- | ---------------------------------------- | ----- |
| `RAILS_ENV`            | `development`                            | Set to `production`. |
| `SECRET_KEY_BASE`      | (none)                                   | Required when `RAILS_MASTER_KEY` is not used. |
| `RAILS_MASTER_KEY`     | (none)                                   | Alternative to `SECRET_KEY_BASE`; decrypts `config/credentials.yml.enc`. |
| `APP_HOST`             | `sentrypact.com`                         | Canonical host for generated links. |
| `RAILS_HOSTS`          | `APP_HOST,www.sentrypact.com`            | Comma-separated allowed hosts (DNS rebinding protection). |
| `RAILS_FORCE_SSL`      | `true`                                   | Set to `false` only for non-browser smoke tests. |
| `RAILS_ASSUME_SSL`     | follows `RAILS_FORCE_SSL`                | Set to `false` only when Rails receives direct HTTP traffic. |
| `RAILS_SERVE_STATIC_FILES` | (unset)                              | Enable when no upstream is serving `public/`. |
| `RAILS_LOG_LEVEL`      | `info`                                   | Set to `debug` only in incident response. |
| `PORT`                 | `3000`                                   | Port Puma binds to. |
| `RAILS_MAX_THREADS`    | `3`                                      | Threads per Puma worker. |
| `WEB_CONCURRENCY`      | `1`                                      | Number of Puma workers. |
| `SOLID_QUEUE_IN_PUMA`  | `false`                                  | Run Solid Queue inside Puma for single-server deploys. |
| `MAIL_FROM`            | `SentryPact <support@sentrypact.com>`    | Product sender address. |

The checked-in Kamal deploy file (`config/deploy.yml`) is still scaffold
configuration until real hosts, registry, secrets, and backup policy are
assigned. The current production deployment does not use Kamal; see below.

## Production deployment (sentrypact.com)

`sentrypact.com` is self-hosted on a single Ubuntu box behind Caddy. The
shape is intentionally simple: Puma under systemd, SQLite on disk, Caddy
in front for TLS and HTTP/2.

Layout:

- App code: `/home/sawyer/github/sentrypact` (deployed in place via `git pull`)
- Toolchain: Ruby 4.0.3 + Node 24.13.1 installed by mise under
  `/home/sawyer/.local/share/mise/installs/`
- Gems: `apps/web/vendor/bundle` (`bundle config set --local deployment true`,
  `--local without development:test`)
- Databases: `apps/web/storage/production.sqlite3` plus `_cache`, `_queue`,
  `_cable` siblings
- Env: `/etc/sentrypact-web/env` (root:sawyer, mode 0640) — holds
  `SECRET_KEY_BASE`, `RAILS_ENV=production`, `PORT=8081`, `APP_HOST`,
  `RAILS_HOSTS`, `RAILS_SERVE_STATIC_FILES=1`, `WEB_CONCURRENCY=2`,
  `RAILS_MAX_THREADS=5`, `SOLID_QUEUE_IN_PUMA=true`
- Service: `/etc/systemd/system/sentrypact-web.service` (User=sawyer,
  enabled at boot), Puma listens on `127.0.0.1:8081`
- Caddy: vhost block in `/etc/caddy/Caddyfile` reverse-proxies
  `sentrypact.com` to `127.0.0.1:8081` and 301-redirects
  `www.sentrypact.com` to the apex

### First-time bootstrap

```sh
# 1. System dependencies (Ubuntu)
sudo apt-get update
sudo apt-get install -y build-essential autoconf bison \
  libssl-dev libreadline-dev zlib1g-dev libyaml-dev libffi-dev libgmp-dev \
  libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev \
  libgdbm-dev libncurses-dev libdb-dev pkg-config rustc \
  curl git ca-certificates

# 2. Toolchain via mise
curl -fsSL https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
cd /path/to/sentrypact
mise trust
mise install        # builds Ruby 4.0.3, fetches Node 24.13.1

# 3. Gems
cd apps/web
gem install bundler -v 4.0.11 --no-document
bundle config set --local deployment true
bundle config set --local without 'development test'
bundle config set --local path vendor/bundle
bundle config set --local frozen true
bundle install

# 4. Secrets and config
sudo install -d -m 0750 -o "$USER" -g "$USER" /etc/sentrypact-web
SECRET_KEY_BASE_DUMMY=1 RAILS_ENV=production bundle exec bin/rails secret
# Put the result, plus the env vars from the table above, into
# /etc/sentrypact-web/env (root:sawyer 0640).

# 5. Database and assets
set -a && . /etc/sentrypact-web/env && set +a
bundle exec bin/rails db:prepare
bundle exec bin/rails assets:precompile
```

### systemd unit (`/etc/systemd/system/sentrypact-web.service`)

```ini
[Unit]
Description=SentryPact Rails Web (Puma)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=sawyer
Group=sawyer
WorkingDirectory=/home/sawyer/github/sentrypact/apps/web
EnvironmentFile=/etc/sentrypact-web/env
Environment=HOME=/home/sawyer
Environment=PATH=/home/sawyer/.local/share/mise/installs/ruby/4.0.3/bin:/home/sawyer/.local/share/mise/installs/node/24.13.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
Environment=BUNDLE_GEMFILE=/home/sawyer/github/sentrypact/apps/web/Gemfile
ExecStart=/home/sawyer/.local/share/mise/installs/ruby/4.0.3/bin/bundle exec puma -C config/puma.rb -b tcp://127.0.0.1:8081
Restart=on-failure
RestartSec=5
KillMode=mixed
TimeoutStopSec=20

NoNewPrivileges=true
ProtectSystem=full
ProtectHome=read-only
ReadWritePaths=/home/sawyer/github/sentrypact/apps/web/storage
ReadWritePaths=/home/sawyer/github/sentrypact/apps/web/tmp
ReadWritePaths=/home/sawyer/github/sentrypact/apps/web/log
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

```sh
sudo systemctl daemon-reload
sudo systemctl enable --now sentrypact-web.service
sudo systemctl status sentrypact-web.service
```

### Caddy vhost (`/etc/caddy/Caddyfile`)

```caddyfile
www.sentrypact.com {
    redir https://sentrypact.com{uri} permanent
}

sentrypact.com {
    encode zstd gzip

    header {
        X-Content-Type-Options "nosniff"
        X-Frame-Options "DENY"
        Strict-Transport-Security "max-age=31536000; includeSubDomains"
        Referrer-Policy "strict-origin-when-cross-origin"
        X-XSS-Protection "0"
        Permissions-Policy "camera=(), microphone=(), geolocation=()"
        -Server
    }

    reverse_proxy 127.0.0.1:8081 {
        header_up X-Forwarded-Proto https
        header_up X-Real-IP {remote_host}
    }
}
```

```sh
sudo caddy validate --config /etc/caddy/Caddyfile
sudo systemctl reload caddy
```

Caddy will request and renew Let's Encrypt certificates automatically as
long as the apex and `www` records both resolve to the host.

### Redeploy / update flow

```sh
cd /home/sawyer/github/sentrypact && git pull
cd apps/web
eval "$(~/.local/bin/mise activate bash)"
bundle install
set -a && . /etc/sentrypact-web/env && set +a
bundle exec bin/rails db:prepare
bundle exec bin/rails assets:precompile
sudo systemctl restart sentrypact-web
```

### Health checks

```sh
curl -s http://127.0.0.1:8081/up                              # local Puma
curl -s --resolve sentrypact.com:443:127.0.0.1 \
     https://sentrypact.com/up                                # via Caddy
sudo journalctl -u sentrypact-web -f                          # tail logs
```

### Backups

The SQLite databases live in `apps/web/storage/`. Until they are moved to
PostgreSQL, an off-host backup of that directory is the entire backup
policy. Anything important should be snapshot before migrations or
schema changes.
