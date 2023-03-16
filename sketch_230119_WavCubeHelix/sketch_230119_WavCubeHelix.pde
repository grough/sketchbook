import controlP5.*;
import grough.cubehelix.*;

MySoundFile w;
GUI gui;
Cubehelix h;
Saver saver;
int[] pal;
int t = 0;

void setup() {
  size(640, 640);
  pixelDensity(1);
  background(0);
  stroke(255, 255);
  w = new MySoundFile(this, "Untitled.wav");
  gui = new GUI(this);
  h = new Cubehelix();
  saver = new Saver(this);
}

void draw() {
  clear();

  //w.setRange(
  //  int(ui.getValue("start")),
  //  int(ui.getValue("frames"))
  //  );
  if (t > w.frames()) {
    t = 0;
  }

  w.setRange(t, 256);
  int i = 0;
  for (int row = 0; row < height; row++) {
    for (int col = 0; col < width; col++) {
      float x = col / float(height) * 2 - 1;
      float y = row / float(height) * 2 - 1;
      float d = sqrt(x * x + y * y);
      float a = atan2(y, x);
      
      float radial = w.scan(a / TWO_PI + 0.5, 1) / 2 + 0.5;
      float distance = w.scan(d / 1.414, 1);
      
      float z = sig(radial * 1, 1) * 2 + sig(distance * 4, 1);
      

      h
        .start(gui.getValue("start"))
        .rotations(gui.getValue("rotations"))
        .hue(gui.getValue("hue"))
        .gamma(gui.getValue("gamma"));

      stroke(h.color(z + noise(i + t) / 16));
      point(col, row);
      i++;
    }
  }
  //saver.save("png");

  t+= 64;
}

float sig(float x, float steepness) {
  float L = 1;
  float k = steepness;
  float x0 = 0;
  return L / (1 + exp(-k * (x - x0)));
}



void mouseClicked() {
  if (mouseButton == RIGHT) {
    saver.save("png");
  }
  clear();
}
