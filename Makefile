.PHONY: help
help:
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: install
install:
	spago install


.PHONY: test
test: ## Run the test watcher
	spago test


.PHONY: test-watch
test-watch: ## Run the tests once
	spago test --watch


.PHONY: build-watch
build-watch: ## Incrementally compile the project
	spago build --watch


.PHONY: build
build: ## Compile the project once
	spago build


.PHONY: clean
clean: ## Delete compiled artefacts
	rm -fr output
