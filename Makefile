.PHONY: lint lint-spell lint-markdown

lint: lint-spell lint-markdown

lint-spell:
	npx -y cspell "**/*.md" --config cspell.config.yaml

lint-markdown:
	npx -y markdownlint-cli2 "**/*.md"
