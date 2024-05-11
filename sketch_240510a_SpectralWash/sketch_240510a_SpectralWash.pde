// Slow colour wash
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
  outputSize = getPixelSizeFromMillimeters(SIZE_120_MM, 300);
  previewSize = new PVector(outputSize.x / 2, outputSize.y / 2);
  windowResize((int)previewSize.x, (int)previewSize.y);
  graphics = createGraphics((int)previewSize.x, (int)previewSize.y);
  
  Random random = new Random();
  seed = random.nextLong();
  noise = new OpenSimplex2S();
  
  saver = new Saver(this);
}

void draw() {
  render(previewSize, seed);
  image(graphics, 0, 0, (int)(previewSize.x * 1), (int)(previewSize.y * 1));
}

float band(float x, float bands) {
  return round(x * bands) / bands;
}

void render(PVector size, long seed) {
  graphics.setSize((int)size.x, (int)size.y);
  graphics.beginDraw();
  graphics.clear();

  cubehelix = new Cubehelix();
  cubehelix.rotations(8);  
  
  float time = millis() / 1000.0;
  
  cubehelix.start(time / 4);

  for (int i = 0; i < size.x; i++) {
    for (int j = 0; j < size.y; j++) {
      NormalizedCoordinates p = normalize((int)size.x, (int)size.y, i, j);
      float nScale = .6; 
      float n = map(noise.noise4_ImproveXYZ(seed, p.xb * nScale, p.yb * nScale, 0 * nScale, time/50), -1, 1, 0, 1);
      float dither = random(-1, 1);
      graphics.stroke(cubehelix.color(map(p.y + n / 1 + dither / 100.0, 0, 1, 0.5, .75)));
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
