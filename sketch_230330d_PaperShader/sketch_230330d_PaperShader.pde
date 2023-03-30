// Render a shader. Off-screen it will render at a high resolution. It is scaled down for display on screen.
import com.jogamp.opengl.GLProfile;
{
  GLProfile.initSingleton();
}

Paper paper;
Paper display;
PVector paperSize;
PVector displaySize;
PGraphics pg1;
PShader myShader;

Saver saver;

void settings() {
  PVector pageSize = new PVector(120, 120);

  paper = new Paper();
  paper.setSizeInMillimeters(pageSize);
  paper.setDotsPerInch(300 / 1);

  display = new Paper();
  display.setSizeInMillimeters(pageSize);
  display.setDotsPerInch(300 / 4);
  displaySize = display.getPixelSize();
  size((int)displaySize.x, (int)displaySize.y, P2D);
  pixelDensity(1);

  saver = new Saver(this); 
}

void setup() {
  paperSize = paper.getPixelSize();
  pg1 = createGraphics((int)paperSize.x, (int)paperSize.y, P2D);
  myShader = loadShader("test.glsl");
}

void draw() {  
  float t = millis() / 1000.0;
  float w = sin(TWO_PI * t * 0.1);
  myShader.set("time", t);
  myShader.set("seed", 100);
  myShader.set("resolution" , pg1.width, pg1.height);
  myShader.set("start", 0.5 + w * 4);
  myShader.set("rotations", 1.5);
  myShader.set("hue", 1.0);
  myShader.set("gamma", 1.0);

  pg1.beginDraw();

  pg1.rect(0, 0, pg1.width, pg1.height);
  pg1.shader(myShader);
  pg1.endDraw();

  image(pg1, 0, 0, (int)displaySize.x, (int)displaySize.y);
}

// Right click to save image
void mouseClicked() {
  if (mouseButton == RIGHT) {
    saver.save("png", pg1);
  }
}
