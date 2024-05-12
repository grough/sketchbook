// Bands in one dimension and smooth in the other
import java.util.Random;
import grough.cubehelix.*;

PVector previewSize;
PVector outputSize;
PGraphics graphics;
Cubehelix cubehelix;
Saver saver;

Random random;
long seed;
OpenSimplex2S noise;

void setup() {
  noLoop();
  noSmooth();
  outputSize = SIZE_HD_PORTRAIT;
  previewSize = new PVector(outputSize.x / 4, outputSize.y / 4);
  windowResize((int)previewSize.x, (int)previewSize.y);
  graphics = createGraphics((int)previewSize.x, (int)previewSize.y);
  random = new Random();
  seed = random.nextLong();
  noise = new OpenSimplex2S();
  saver = new Saver(this);
}

void draw() {
  render(previewSize, seed);
  image(graphics, 0, 0, (int)(previewSize.x * 1), (int)(previewSize.y * 1));
}

float band(float x, float b) {
  float bandSize = 1 / (b - 1);
  x = map(x, 0, 1, -bandSize / 2, 1 + bandSize / 2);
  return round(x * (b - 1)) / (b - 1);
}

void render(PVector size, long seed) {
  graphics.setSize((int)size.x, (int)size.y);
  graphics.beginDraw();
  graphics.clear();

  cubehelix = new Cubehelix();

  for (int i = 0; i < size.x; i++) {
    for (int j = 0; j < size.y; j++) {
      NormalizedCoordinates p = normalize((int)size.x, (int)size.y, i, j);
      float dither = random(-1, 1) / 100.0;
      float xBands = lerp(0, 1, band(p.y, 7));
      graphics.stroke(cubehelix.color(xBands / 2 + p.x / 2 + dither));
      graphics.point(i, j);
    }
  }

  graphics.endDraw();
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    redraw();
  }
  if (mouseButton == RIGHT) {
    println("Saving…", outputSize);
    render(outputSize, seed);
    println("Saved", saver.save(graphics, "png"));
  }
}
