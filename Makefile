.PHONY: toc # Print an HTML table of contents for the given sketchbook directory

dir ?= $(abspath .)

toc:
	@cd toc2html && go run main.go $(dir)
