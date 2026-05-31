.PHONY: crun

SRC := main.c

ifneq ($(filter crun,$(MAKECMDGOALS)),)
ifneq ($(word 2,$(MAKECMDGOALS)),)
SRC := $(word 2,$(MAKECMDGOALS))
endif
$(eval $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS)):;@:)
endif

crun:
	@tmp=$$(mktemp /tmp/main.XXXXXX); \
	gcc "$(SRC)" -o "$$tmp" && "$$tmp"; \
	rc=$$?; \
	rm -f "$$tmp"; \
	exit $$rc
