// Render Cubehelix color scheme with noise dithering
import grough.cubehelix.*;

// Output dimensions
Paper paper;
PVector paperSize;

// Preview dimensions
Paper display;
PVector displaySize;

// Graphics surface
PGraphics graphics;

Cubehelix cubehelix;

Saver saver;

void settings() {
  noLoop();
  noSmooth();

  PVector pageSize = new PVector(120, 120);

  paper = new Paper();
  paper.setSizeInMillimeters(pageSize);
  paper.setDotsPerInch(300 / 1);

  display = new Paper();
  display.setSizeInMillimeters(pageSize);
  display.setDotsPerInch(300 / 4);
  displaySize = display.getPixelSize();
  size((int)displaySize.x, (int)displaySize.y);
  pixelDensity(1);

  saver = new Saver(this);
}

void setup() {
  graphics = new PGraphics();
  paperSize = paper.getPixelSize();
  graphics = createGraphics((int)paperSize.x, (int)paperSize.y);

  cubehelix = new Cubehelix();
}

void draw() {
  graphics.beginDraw();
  graphics.clear();
  graphics.fill(255, 0, 0);
  graphics.rect(0, 0, paperSize.x, paperSize.y);

  float t = millis() / 1000.0;

  for (int i = 0; i < paperSize.x; i++) {
    for (int j = 0; j < paperSize.y; j++) {
      float x = i / paperSize.x;
      float y = j / paperSize.y;
      float distance = dist(0, 0, x, y);
      float dither = pow(random(1), 1) * (random(1) > 0.5 ? 1 : -1);
      float dsr = distance / sqrt(2);
      graphics.stroke(cubehelix.color(lerp(0, 1, dsr) + dither / 200.0));
      graphics.point(i, j);
    }
  }

  graphics.endDraw();

  image(graphics, 0, 0, (int)(displaySize.x * 1), (int)(displaySize.y * 1));
}

// Right click to save image
void mouseClicked() {
  String[] tags = {};
  if (mouseButton == RIGHT) {
    saver.save("png", tags, graphics);
  }
}
