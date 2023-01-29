import processing.sound.*;

class MySoundFile extends SoundFile {
  int start;
  int size;

  MySoundFile(PApplet applet, String path) {
    super(applet, path);
    start = 0;
    size = this.frames();
  }

  void setRange(int start, int frames) {
    this.start = start;
    size = frames;
  }
  
  float scan(float x, int channel) {
    int index = floor(trunc(x) * size + start);
    if (index < 0) {
      return 0;
    }
    if (index >= frames()) {
      return 0;
    }
    return read(index, channel);
  }
}

float trunc(float x) {
  if (x < 0) {
    return 0;
  }
  if (x > 1) {
    return 1;
  }
  return x;
}
