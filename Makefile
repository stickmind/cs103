# Makefile for Sphinx documentation

# You can set these variables from the command line.
SPHINXAUTO    = sphinx-autobuild
BUILD		  = sphinx-build
SRC           = srcs
PUBLISH       = docs

.PHONY: help clean

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  server    to run all doctests embedded in the documentation (if enabled)"

init:
	pip install -r requirements.txt

clean:
	-rm -rf $(PUBLISH)
	mkdir docs

build:
	$(BUILD) $(SRC) $(PUBLISH)
	cd $(PUBLISH) && touch .nojekyll && echo "cs103a.stickmind.com" > CNAME

	@echo
	@echo "Build finished. The HTML pages are in $(PUBLISH)."

server:
	make clean && make build
	$(SPHINXAUTO) $(SRC) $(PUBLISH)

publish:
	make clean
	make build
	git add .
	git commit -m "update"
	git push origin gh-pages

fix:
	make clean
	make build
	git add .
	git commit --amend --no-edit
	git push origin gh-pages --force
