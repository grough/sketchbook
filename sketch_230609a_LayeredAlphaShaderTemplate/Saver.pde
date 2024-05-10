import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

class Saver {
  PApplet sketch;
  String session;
  int i = 0;
 
  Saver(PApplet sketch) {
    this.sketch = sketch;
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS");
    session = now.format(formatter);
  }
  
  String filename(String extension, String[] tags) {
    String index = nf(i, 4);
    String sketchName = sketch.toString().split("@")[0];
    String tagsString = String.join("_", tags);
    String name = session + "_" + tagsString + "_" + index + "_" + sketchName;
    return name + "." + extension;
  }
  
  String save(String extension, String[] tags) {
    String filename = this.filename(extension, tags);
    sketch.save("output/" + filename);
    i++;
    return filename;
  }
  
  String save(String extension, String[] tags, PGraphics graphics) {
    String filename = this.filename(extension, tags);
    graphics.save("output/" + filename);
    i++;
    return filename;
  }
}
