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

  w.setRange(t, 64);
  int i = 0;
  for (int row = 0; row < height; row++) {
    for (int col = 0; col < width; col++) {

      float x = col / float(height) * 2 - 1;
      float y = row / float(height) * 2 - 1;
      float d = sqrt(x * x + y * y);
      //fill(int(255 * w.scan(d, 1)));
      //stroke(int(255 * w.scan(d, 1)));

      float ww = w.scan(d, 1);
      //float www = ww;
      float www = sig(ww * .5, 16);
      //float wwww = www / 2 + 0.5;
      float wwww = www;

      h
        .start(gui.getValue("start"))
        .rotations(gui.getValue("rotations"))
        .hue(gui.getValue("hue"))
        .gamma(gui.getValue("gamma"));

      //h.rotations(0 + pow(1- d, 2) * 4.5);
      //h.hue(pow(d, 1));
      //h.gamma((d * 2 + 0) * 1);
      //int ss = 8;
      //int[] cs =  h.array(ss);
      //cs[(int)Math.floor(wwww * 16)];
      stroke(h.color(wwww + noise(i + t) / 20));
      //stroke(cs[(int)Math.floor(wwww * ss)]);
      point(col, row);
      i++;
    }
  }

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
