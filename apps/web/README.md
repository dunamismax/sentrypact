# SentryPact Web

Rails website, backend, and future customer dashboard for SentryPact.

## Stack

- Ruby 4.0.3
- Rails 8.1.3
- Hotwire with importmap
- Propshaft
- Tailwind CSS
- SQLite for local scaffold data
- Solid Queue, Solid Cache, and Solid Cable
- Kamal and Thruster for deploy scaffolding
- Minitest, RuboCop, Brakeman, and bundler-audit

## Development

```sh
bin/setup
bin/dev
```

Open [http://localhost:3000](http://localhost:3000).

## Checks

```sh
bin/ci
bin/rails test
bin/rubocop
bin/brakeman --no-pager
bin/bundler-audit
```

`bin/ci` is the canonical local and GitHub Actions gate. It prepares the app,
builds Tailwind assets, runs Ruby style checks, audits gems and importmap
dependencies, runs Brakeman, executes the Rails tests, and verifies seeds.

## Production Configuration

The production app is configured to be secure-by-default behind an SSL
terminating proxy.

Required or expected environment variables:

- `RAILS_MASTER_KEY`: decrypts Rails credentials.
- `APP_HOST`: canonical host for generated links, defaulting to `sentrypact.com`.
- `RAILS_HOSTS`: comma-separated allowed hosts, defaulting to `APP_HOST` and `www.sentrypact.com`.
- `RAILS_FORCE_SSL`: set to `false` only for non-browser production smoke tests.
- `RAILS_ASSUME_SSL`: set to `false` only when Rails receives direct HTTP traffic.
- `MAIL_FROM`: product sender address, defaulting to `SentryPact <support@sentrypact.com>`.

The checked-in Kamal deploy file is still scaffold configuration until real
hosts, registry, secrets, and backup policy are assigned.
