// Draw sine wavesSaver saver;
void setup() {
  size(640, 640);
  frameRate(8);
}

float ph = 0;

void draw() {
  stroke(0);
  noFill();
  background(255);
  for (float x = 0; x < width; x++) {
    float t1 = x / width * TWO_PI;
    float t2 = (x + 1) / width * TWO_PI;
    float x1 = x;
    float y1 = height / 2 + height / 4 * sin(t1 / 4 + ph);
    float x2 = x + 1;
    float y2 = height / 2 + height / 4 * sin(t2 / 4 + ph);
    line(
      x1, 
      y1, 
      x2, 
      y2
      );
  }
  ph += TWO_PI / 16;
  noLoop();
}

void mouseClicked() {
  loop();
}
