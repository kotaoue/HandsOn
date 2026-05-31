.PHONY: crun

crun:
	@tmp=$$(mktemp /tmp/main.XXXXXX); \
	gcc main.c -o "$$tmp" && "$$tmp"; \
	rc=$$?; \
	rm -f "$$tmp"; \
	exit $$rc
