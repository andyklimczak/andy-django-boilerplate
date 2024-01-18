# Django boilerplate

## Local setup

1. Install docker
2. Run `make run`
3. Migrate with `make migrate`
5. Run tests with `make test`
6. Create a superuser with `make createsuperuser`
7. See all commands able to be run locally with `make`

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
