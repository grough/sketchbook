.PHONY: table_of_contents # Print an HTML table of contents for the given sketchbook directory
.PHONY: web # Create a website for the given sketchbook directory

dir ?= $(abspath .)

table_of_contents:
	@cd make_table_of_contents && go run main.go "$(dir)"

web:
	@cd make_web && go run main.go "$(dir)" "$(dir)/web" > "$(dir)/web/index.html"
