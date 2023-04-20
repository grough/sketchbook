package main

import (
	"bytes"
	"fmt"
	"html/template"
	"io"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
)

type Entry struct {
	Name           string
	Description    string
	ImagePath      string
	SmallImagePath string
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println(fmt.Errorf("usage: go run main.go /path/to/sketchbook /path/to/website"))
		os.Exit(1)
	}
	sketchbookDir := os.Args[1]
	webDir := os.Args[2]
	entries, err := Extract(sketchbookDir)
	if err != nil {
		fmt.Println(err)
	}
	html, err := Format(entries)
	if err != nil {
		fmt.Println(err)
	}
	CopyImages(entries, webDir)
	fmt.Print(html)
}

func Extract(sketchbookDir string) ([]Entry, error) {
	var entries []Entry

	files, err := ioutil.ReadDir(sketchbookDir)
	if err != nil {
		return nil, fmt.Errorf("Error reading directory:", err)
	}

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

		_, err = os.Stat(smallImagePath)
		var smallImage, image string
		if err == nil {
			smallImage = smallImagePath
			image = imagePath
		} else {
			smallImage = ""
			image = ""
		}

		entries = append(entries, Entry{file.Name(), description, image, smallImage})
	}

	return entries, nil
}

func Format(entries []Entry) (string, error) {
	fileContent, err := ioutil.ReadFile("template.tmpl")
	if err != nil {
		fmt.Println("Error reading file:", err)
		return "", err
	}
	tmpl, err := template.New("example").Parse(string(fileContent))
	if err != nil {
		return "", err
	}
	var buf bytes.Buffer
	err = tmpl.Execute(&buf, entries)
	if err != nil {
		return "", err
	}
	return buf.String(), nil
}

func CopyImages(entries []Entry, webDir string) {
	for _, entry := range entries {
		if entry.ImagePath == "" {
			continue
		}
		imageName := filepath.Base(entry.ImagePath)
		imagePath := filepath.Join(webDir, imageName)
		err := CopyFile(entry.ImagePath, imagePath)
		if err != nil {
			fmt.Println(err)
		}
	}
}

func CopyFile(src, dst string) error {
	in, err := os.Open(src)
	if err != nil {
		return err
	}
	defer in.Close()
	out, err := os.Create(dst)
	if err != nil {
		return err
	}
	defer out.Close()
	_, err = io.Copy(out, in)
	if err != nil {
		return err
	}
	err = out.Close()
	if err != nil {
		return err
	}
	return nil
}
