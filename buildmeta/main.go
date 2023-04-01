// I have a collection of Processing .pde sketches in a sketchbook directory
// Each sketch file lives inside a directory of the same name
// An example sketch filepath is $SKETCHBOOK/sketch_mySketch/sketch_mySketch.pde
// For each sketch file, store the name of the sketch, not including the .pde extension
// Extract and store the first comment found in the file. If there is no comment, ignore this sketch
// The name of the sketch represents the title. The comment represents the description
// Gather the title and description of each sketch file into a collection
// Write a Go program that accepts a path to the sketchbook directory
// and prints a collection of titles and descriptions to stdout

package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	if len(os.Args) != 2 {
		fmt.Fprintf(os.Stderr, "Usage: %s [sketchbook directory]\n", os.Args[0])
		os.Exit(1)
	}
	sketchbookPath := os.Args[1]
	sketches, err := findSketches(sketchbookPath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
	// fmt.Printf("Found %d sketches in %s:\n", len(sketches), sketchbookPath)
	for _, sketch := range sketches {
		fmt.Printf("  %s: %s\n", sketch.name, sketch.description)
	}
}

type sketch struct {
	name        string
	description string
}

func findSketches(sketchbookPath string) ([]sketch, error) {
	sketchDirs, err := ioutil.ReadDir(sketchbookPath)
	if err != nil {
		return nil, err
	}

	var sketches []sketch

	for _, dir := range sketchDirs {
		if dir.IsDir() {
			// fmt.Printf("Processing %s...\n", dir.Name())
			sketchPath := filepath.Join(sketchbookPath, dir.Name(), dir.Name()+".pde")
			// fmt.Println(sketchPath)
			file, err := os.Open(sketchPath)
			if err != nil {
				// fmt.Println("Could not open", sketchPath)
				continue
			}
			defer file.Close()

			scanner := bufio.NewScanner(file)
			var name, description string
			for scanner.Scan() {
				line := strings.TrimSpace(scanner.Text())
				if strings.HasPrefix(line, "//") {
					description = strings.TrimPrefix(line, "//")
					// fmt.Println("Description:", description)
				}
				if strings.HasPrefix(line, "void setup") {
					name = strings.TrimPrefix(dir.Name(), "sketch_")
					// fmt.Println("Name:", description)
					break
				}
			}

			if name != "" || description != "" {
				sketches = append(sketches, sketch{name, description})
			}
		}
	}

	return sketches, nil
}
