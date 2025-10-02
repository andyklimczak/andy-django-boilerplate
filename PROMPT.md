This project runs the Django app directly on your host machine using `uv`. Postgres is the only service running in Docker via `docker compose`.

Before working:
- Use `mise` with the `.tool-versions` file to install the pinned Python. Honcho is installed automatically when you run `bin/dev`.
- Run `bin/sync` to create `.venv` with uv.
- Prefer `bin/dev` to run the web server and database together (press `Ctrl+C` to stop both). The script installs and uses Honcho automatically via `uv`.
- Use the other scripts in `bin` only when you need finer control (for example `bin/db-logs`).

Common commands live in the executable scripts under `bin`. Host-side scripts call `uv` for Django tasks, while database lifecycle scripts wrap `docker compose`.
