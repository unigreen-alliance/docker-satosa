VERSION:=latest
VERSIONS:=$(shell test -f versions.txt && cat versions.txt) dev latest
NAME:=satosa
PACKAGE=SATOSA

.PHONY: requirements.txt

all: versions.txt
	@for v in $(VERSIONS); do make VERSION=$$v build push freeze; done

test:

versions.txt:
	@./scripts/list-versions.sh $(PACKAGE) > $@

requirements.txt:
	@if [ -s versions/$(VERSION)/requirements.txt ]; then cp versions/$(VERSION)/requirements.txt $@; else echo "$(PACKAGE)==$(VERSION)" > $@; fi

build: requirements.txt
	@docker build --build-arg version=$(VERSION) --no-cache=true -t $(NAME):$(VERSION) .
	@docker tag $(NAME):$(VERSION) docker.sunet.se/$(NAME):$(VERSION)

freeze:
	@mkdir -p versions/$(VERSION)
	@test -f versions/$(VERSION)/requirements.txt || docker run --entrypoint=pip3 $(NAME):$(VERSION) freeze > versions/$(VERSION)/requirements.txt

push:
	@docker push docker.sunet.se/$(NAME):$(VERSION)
