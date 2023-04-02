package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
	"text/template"
)

type Entry struct {
	Name           string
	Description    string
	ImagePath      string
	SmallImagePath string
}

func main() {
	entries, err := Extract(os.Args[1])
	if err != nil {
		fmt.Println(err)
	}
	html, err := Format(entries)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Print(html)
}

func Extract(srcDir string) ([]Entry, error) {
	// Get the sketchbook directory path from the command line argument
	if len(os.Args) < 2 {
		return nil, fmt.Errorf("Usage: go run main.go /path/to/sketchbook")
	}
	sketchbookDir := os.Args[1]

	// Initialize a collection of sketch titles, descriptions, and images
	var entries []Entry

	// Read the contents of the sketchbook directory
	files, err := ioutil.ReadDir(sketchbookDir)
	if err != nil {
		return nil, fmt.Errorf("Error reading directory:", err)
	}

	// Loop through each file in the sketchbook directory
	for _, file := range files {
		if !file.IsDir() {
			continue
		}
		if !strings.HasPrefix(file.Name(), "sketch_") {
			continue
		}
		sketchDir := filepath.Join(sketchbookDir, file.Name())
		sketchFile := filepath.Join(sketchDir, file.Name()+".pde")
		imagePath := filepath.Join(sketchDir, "example.png")
		smallImagePath := filepath.Join(sketchDir, "example-small.png")
		description := "<!--no description-->"
		content, err := ioutil.ReadFile(sketchFile)
		if err != nil {
			return nil, err
		}
		contentString := string(content)
		endOfLine := strings.Index(contentString, "\n")
		if endOfLine == -1 {
			continue
		}
		firstLine := string(content[:endOfLine])
		if strings.HasPrefix(firstLine, "//") {
			description = strings.TrimPrefix(firstLine, "//")
			description = strings.TrimSpace(description)
		}

		// Check if the image file exists
		_, err = os.Stat(smallImagePath)
		var smallImage, image string
		if err == nil {
			smallImage = smallImagePath
			image = imagePath
		} else {
			smallImage = ""
			image = ""
		}

		// Add the title, description, and image to the sketches collection
		entries = append(entries, Entry{file.Name(), description, image, smallImage})
	}

	return entries, nil
}

func Format(entries []Entry) (string, error) {
	tmpl, err := template.New("example").Parse(`<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>👁️</th>
  </tr>
  {{range .}}
  <tr>
    <td><a href="{{.Name}}/">{{.Name}}</a></td>
    <td>{{.Description}}</td>
    <td>{{if eq .SmallImagePath ""}}<!--no image-->{{else}}<a href="{{.Name}}/example.png"><img src="{{.Name}}/example-small.png" /></a>{{end}}</td>
  </tr>
  {{end}}
</table>`)
	if err != nil {
		return "", err
	}

	// Execute the template and store the output in a buffer
	var buf bytes.Buffer
	err = tmpl.Execute(&buf, entries)
	if err != nil {
		return "", err
	}

	// Convert the buffer to a string and print it
	return buf.String(), nil
}
