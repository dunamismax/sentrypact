# SentryPact Web

Rails website, backend, and future customer dashboard for SentryPact.

## Stack

- Ruby 4.0.1
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
bin/rails test
bin/rubocop
bin/brakeman --no-pager
bin/bundler-audit
```
