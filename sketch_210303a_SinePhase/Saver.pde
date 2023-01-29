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
  
  String save(String extension) {
    String name = session + "_" + nf(i, 4) + "_" + sketch.toString().split("@")[0];
    String filename = name() + "." + extension;
    sketch.save("output/" + filename);
    i++;
    return filename;
  }
}
