// Render Cubehelix color scheme with noise dithering
import grough.cubehelix.*;

PVector previewSize;
PVector outputSize;
PGraphics graphics;
Cubehelix cubehelix;
Saver saver;

void setup() {
  noLoop();
  noSmooth();
  outputSize = getPixelSizeFromMillimeters(SIZE_120_MM, 300);
  previewSize = new PVector(outputSize.x / 2, outputSize.y / 2);
  windowResize((int)previewSize.x, (int)previewSize.y);
  graphics = createGraphics((int)previewSize.x, (int)previewSize.y);
  saver = new Saver(this);
}

void draw() {
  render(previewSize);
  image(graphics, 0, 0, (int)(previewSize.x * 1), (int)(previewSize.y * 1));
}

void render(PVector size) {
  graphics.setSize((int)size.x, (int)size.y);
  graphics.beginDraw();
  graphics.clear();
  graphics.fill(255, 0, 0);
  graphics.rect(0, 0, size.x, size.y);

  cubehelix = new Cubehelix();

  for (int i = 0; i < size.x; i++) {
    for (int j = 0; j < size.y; j++) {
      float x = i / size.x;
      float y = j / size.y;
      float distance = dist(0, 0, x, y);
      float dither = random(-1, 1);
      float dsr = distance / sqrt(2);
      graphics.stroke(cubehelix.color(dsr + dither / 200.0));
      graphics.point(i, j);
    }
  }

  graphics.endDraw();
}

// Right click to save image
void mouseClicked() {
  if (mouseButton == LEFT) {
    redraw();
  }
  if (mouseButton == RIGHT) {
    println("Saving…", outputSize);
    render(outputSize);
    println("Saved", saver.save(graphics, "png"));
  }
}
