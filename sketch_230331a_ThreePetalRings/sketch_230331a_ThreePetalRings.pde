// Render multiple alpha mask layers in high resolution
import com.jogamp.opengl.GLProfile;
{
  GLProfile.initSingleton();
}

Paper paper;
Paper display;
PVector paperSize;
PVector displaySize;
PGraphics g[];
PShader[] sh;
int num = 13;
Saver saver;

void settings() {
  PVector pageSize = new PVector(500, 500);
  paper = new Paper();
  paper.setSizeInMillimeters(pageSize);
  paper.setDotsPerInch(300 / 1);
  display = new Paper();
  display.setSizeInMillimeters(pageSize);
  display.setDotsPerInch(300 / 8);
  displaySize = display.getPixelSize();
  size((int)displaySize.x, (int)displaySize.y, P2D);
  pixelDensity(1);
  saver = new Saver(this);
}

void setup() {
  sh = new PShader[num];
  g = new PGraphics[num];
  paperSize = paper.getPixelSize();
  for (int i = 0; i < sh.length; i++) {
    g[i] = createGraphics((int)paperSize.x, (int)paperSize.y, P2D);
    sh[i] = loadShader("shader.glsl");
  }
}

void draw() {
  clear();
  fill(255);
  rect(0, 0, width, height);

  float t = millis() / 1000.0;
  float w = sin(TWO_PI * t * 0.1);
  float ww = w / 2.0 + 0.5;
  //float f = 0.0;

  for (int i = 0; i < num; i++) {
    float f = i / (float)num * 0.5 + 0.25;
    sh[i].set("time", t);
    sh[i].set("resolution", g[i].width, g[i].height);
    //shaders[i].set("inner", factors[i]);
    //shaders[i].set("outer", factors[i] + 0.01);
    sh[i].set("inner", f);
    sh[i].set("outer", f + 0.01 + ww/64.0);
    sh[i].set("phase", TWO_PI * i / (float)num);
    //f += 0.123;

    g[i].beginDraw();
    g[i].clear();
    g[i].rect(0, 0, g[i].width, g[i].height);
    g[i].shader(sh[i]);
    g[i].endDraw();
    
    image(g[i], 0, 0, (int)(displaySize.x * 1), (int)(displaySize.y * 1));
  }
}

// Right click to save image
void mouseClicked() {
  if (mouseButton == RIGHT) {
    String[] tags = {};
    saver.save("png", tags);
    for (int i = 0; i < num; i++) {
      String[] layerTags = {"layer", str(i)};
      saver.save("png", layerTags, g[i]);
    }
  }
}
