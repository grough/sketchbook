import java.util.Calendar;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

Saver saver;

void setup() {
  saver = new Saver(this);
}

void draw() {
  println(saver.name());
}

class Saver {
  PApplet sketch;
  int i = 0;
  String session;

  Saver(PApplet sketch) {
    this.sketch = sketch;
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS");
    session = now.format(formatter);
  }
  
  String name() {
    String name = session + "_" + nf(i, 4) + "_" + sketch.toString().split("@")[0];
    i++;
    return name;
  }
}
