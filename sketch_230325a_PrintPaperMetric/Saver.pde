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
  
  String filename(String extension) {
    String index = nf(i, 4);
    String sketchName = sketch.toString().split("@")[0];
    String name = session + "_" + index + "_" + sketchName;
    return name + "." + extension;
  }
  
  String save(String extension) {
    String filename = this.filename(extension);
    sketch.save("output/" + filename);
    i++;
    return filename;
  }
  
  String save(String extension, PGraphics graphics) {
    String filename = this.filename(extension);
    graphics.save("output/" + filename);
    i++;
    return filename;
  }
}
