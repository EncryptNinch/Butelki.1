.PHONY: dev

PORT ?= 8000

dev:
	npx --yes serve -p $(PORT) -L .
