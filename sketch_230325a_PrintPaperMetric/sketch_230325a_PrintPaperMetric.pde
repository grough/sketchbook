// The Paper class is used to maintain different sets of image dimensions for screen and print

Paper paper;
Paper display;
PGraphics pg1;
Saver saver;

void settings() {
  //PVector A4_LANDSCAPE = new PVector(297, 210);
  //PVector pageSize = A4_LANDSCAPE;
  PVector pageSize = new PVector(120, 120);

  // Dimensions for print resolution
  paper = new Paper();
  paper.setSizeInMillimeters(pageSize);
  paper.setDotsPerInch(300 / 1);
  
  // Dimensions for display resolution 
  display = new Paper();
  display.setSizeInMillimeters(pageSize);
  display.setDotsPerInch(300 / 4);
  PVector displaySize = display.getPixelSize();
  size((int)displaySize.x, (int)displaySize.y);
  pixelDensity(2);

  saver = new Saver(this);
}

void setup() {
}

void draw() {
  PVector paperSize = paper.getPixelSize();
  pg1 = createGraphics((int)paperSize.x, (int)paperSize.y);
  pg1.beginDraw();
  pg1.translate(pg1.width/2, pg1.height/2);
  pg1.scale(pg1.width/2, -pg1.height/2);
  pg1.noStroke();
  pg1.fill(0);
  pg1.circle(0, 0, 2);
  pg1.endDraw();
  
  PVector displaySize = display.getPixelSize();
  image(pg1, 0, 0, (int)displaySize.x, (int)displaySize.y);
}

// Right click to save image
void mouseClicked() {
  if (mouseButton == RIGHT) {
    saver.save("png", pg1);
  }
}
