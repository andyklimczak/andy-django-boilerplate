# Django boilerplate

## Requirements

- [Docker](https://www.docker.com/) for Postgres
- [mise](https://mise.jdx.dev/) to manage tool versions (respects `.tool-versions`)
- [uv](https://docs.astral.sh/uv/) (installed automatically by `mise install` when the plugin is available, or manually if you prefer)

## Local setup

1. Install dependencies with `mise install`
2. Copy `.env.example` to `.env`
3. Create the virtual environment: `bin/sync`
4. Start both the app and database: `bin/dev` (press `Ctrl+C` to stop)
5. Apply migrations when needed: `bin/migrate`
6. Run tests with `bin/test`
7. Optional: start only Postgres with `bin/db-up` or stop it with `bin/db-down`

### Manage dependencies

Use [uv](https://docs.astral.sh/uv/) to add or remove packages. Examples:

```shell
uv add <package>
uv remove <package>
```

After changing dependencies, refresh the lockfile and rebuild the local environment:

```shell
bin/lock
bin/sync
```

### Editor autocomplete

Stay local and share the same dependency graph as Docker:

```shell
bin/sync
```

This wraps `uv sync --extra dev`, building `.venv/` so your editor can see the environment. In VS Code/VSCodium run `Python: Select Interpreter` and pick `.venv/bin/python`.

### Daily workflow

Prefer `bin/dev` to run both the Django server and Postgres in one terminal. If Foreman is unavailable, the script falls back to installing and using Honcho via `uv tool install`.

If you need to manage the database separately, the helper scripts under `bin` (`db-up`, `db-down`, `db-logs`, `nuke`) wrap the `docker compose` commands.

All application commands (`run`, `migrate`, `test`, `shell`, etc.) run directly on the host through `uv` via the scripts in `bin`.
