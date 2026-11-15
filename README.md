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

## CI and dependency auto-merge

`.github/workflows/ci.yml` validates the locked dependency graph on Python 3.13, runs Ruff and Django system/migration checks, and runs the tests against Postgres 17. The `validate` check is required on `master` before merging.

Dependabot schedules and ecosystems remain in `.github/dependabot.yml`. The auto-merge workflow calls the shared [dependabot-auto-merge-action](https://github.com/andyklimczak/dependabot-auto-merge-action), pinned to a reviewed release commit. It uses the **`DEPENDABOT_AUTOMERGE_PAT`** secret to approve verified Dependabot updates and enable squash auto-merge **after required CI passes**.

The current policy is `max-update-type: minor`, which allows patches and minors but leaves major updates manual. Set it to `patch` for patches only, `major` to include majors, or `none` to disable auto-merge on processed PRs. Other shared options include `merge-method`, `approve`, and `dry-run`; see the action's README. Keep the privileged `pull_request_target` job free of PR code checkouts and PR scripts.

The repository must have auto-merge and squash merging enabled, with `validate` required in branch protection. Store the token under the same name in Actions and Dependabot secrets (or selected-repository organization secrets). Use a repository-scoped PAT/GitHub App token with Contents and Pull requests write access, plus Workflows write access for workflow update PRs. Never commit the token or print it. PAT/App merges can trigger follow-up workflows, unlike merges authenticated with `GITHUB_TOKEN`.

```shell
gh secret set DEPENDABOT_AUTOMERGE_PAT --repo andyklimczak/andy-django-boilerplate
gh secret set DEPENDABOT_AUTOMERGE_PAT --app dependabot --repo andyklimczak/andy-django-boilerplate
```
