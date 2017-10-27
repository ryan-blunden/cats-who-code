DOCS_IMAGE_NAME=catswhocode-docs:latest
DOCS_PORT=8000

docs-container-build:
	docker image build -t $(DOCS_IMAGE_NAME) --force-rm docker/docs

docs-build: docs-container-build
	docker run --rm -v "$(CURDIR)/docs":/usr/src/app $(DOCS_IMAGE_NAME) mkdocs build --clean

docs-server: docs-container-build
	docker run --rm -it --init \
	    -v "$(CURDIR)/docs":/usr/src/app \
	    -p $(DOCS_PORT):$(DOCS_PORT) \
	    $(DOCS_IMAGE_NAME) \
	    mkdocs serve --dev-addr=0.0.0.0:$(DOCS_PORT)
