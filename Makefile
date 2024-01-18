.PHONY: help run build stop migrate createsuperuser nuke test lint reindex flush purge shell

default: help

help: ## Show this help.
	@echo
	@fgrep -h " ## " $(MAKEFILE_LIST) | fgrep -v fgrep | sed -Ee 's/([a-z.]*):[^#]*##(.*)/\1##\2/' | sort -k 1 | column -t -s "##"
	@echo

run: ## Start the server
	@docker compose up

build: ## Build the server. Use this when dependencies are updated
	@docker compose build

stop: ## Stop the server
	@docker compose down

migrate: ## Migrate the database
	 @docker compose run --rm web python manage.py migrate

createsuperuser: ## Creates a super user. Server must be running to run this
	@docker compose run --rm web python manage.py createsuperuser

nuke: ## Stops the server and deletes all docker volumes (ie: nukes all data)
	 @docker compose down -v

flush: ## Deletes all data without deleting the database tables
	@docker compose run --rm web python manage.py flush

test: ## Runs the tests
	@docker compose run --rm web python manage.py test

lint: ## Lints the project. Uses ruff
	docker compose run --rm web ruff check . --fix && \
	docker compose run --rm web ruff format .

shell: ## Run django shell
	@docker compose run --rm web python manage.py shell
