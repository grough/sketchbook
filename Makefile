.PHONY: toc # Print an HTML table of contents for the given sketchbook directory

dir ?= $(abspath .)

table_of_contents:
	@cd make_table_of_contents && go run main.go $(dir)
