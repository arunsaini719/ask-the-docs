# Ask the Docs

A Rails application for asking questions about uploaded documentation.

## Requirements

- Ruby 4.0.9 (managed by asdf)
- Docker with Compose

## Setup

```sh
asdf install
docker compose up -d
bin/setup --skip-server
```

Start the application with:

```sh
bin/dev
```

## Checks

Run the same application checks configured by Rails with:

```sh
bin/ci
```

The generated GitHub Actions workflow separately runs Brakeman and Bundler Audit, Importmap Audit, RuboCop, Rails tests, and system tests.
