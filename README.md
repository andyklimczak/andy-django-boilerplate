# Django boilerplate

## Local setup

1. Install docker
2. Copy `.env.example` to `.env`
3. Run `make run`
4. Migrate with `make migrate`
5. Run tests with `make test`
6. Create a superuser with `make createsuperuser`
7. See all commands able to be run locally with `make`
8. Visit http://localhost:8000
9. Signin with superuser at http://localhost:8000/adminz
10. Health check at http://localhost:8000/healthz

### Delete local data

To delete all data locally while keeping the tables themselves, run:

```shell
make purge
```

### Django shell

To start up, access, and see data through the shell, start the server and run:

```shell
make shell
```

### Run tests

```shell
make test
```

### Add dependency

1. Add to `requirements.txt`
2. `make build`
