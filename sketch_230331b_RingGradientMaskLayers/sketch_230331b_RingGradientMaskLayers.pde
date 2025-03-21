// Render multiple circular alpha masks as separate layers
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
int N = 7;
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
  sh = new PShader[N];
  g = new PGraphics[N];
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

  for (int i = 0; i < N; i++) {
    float inner = i / (float)N * 0.55 + 0.3;
    float outer = inner + 0.08;
    sh[i].set("time", t);
    sh[i].set("resolution", g[i].width, g[i].height);
    sh[i].set("inner", inner);
    sh[i].set("outer", outer);
    sh[i].set("phase", TWO_PI * i / (float)N);
    sh[i].set("index", i * 1.0);

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
    String[] tags = {"preview"};
    saver.save("png", tags);
    for (int i = 0; i < N; i++) {
      String[] layerTags = {"layer", str(i)};
      saver.save("png", layerTags, g[i]);
    }
  }
}
