//Draw rings using trig functions
Saver saver;

Hand h1;
Hand h2;
float t = 0;
float sw = 0;
float op = 0;
float TAU = 2 * PI;

void setup() {
  size(640, 640);
  //pixelDensity(2);
  saver = new Saver(this);
  h1 = new Hand();
  h2 = new Hand();
  //frameRate();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  scale(width/2, -height/2);
  fill(0, 0, 0, 255);
  noStroke();
  h1.next();
  h1.t += TAU / pow(2,9);
  
  h2.ecc = pow(noise(h1.t), 1/8.0);
  //h2.xo = h1.x / 2;
  //h2.yo = h1.y / 2;
  h2.theta = noise(h1.t) * TAU * 2;
  
  //noise(h1.t, h1.t, h1.t);
  float stroke = pow(noise(h1.t, 10), 8);

  for (t = 0; t < TAU; t += TAU / pow(2, 5)) {
    float[] p = h2.next();
    circle(p[0] / 2, p[1] / 2, stroke + 0.01);
    h2.t = t;
  }

  if (h2.theta > TAU) {
    h2.theta = 0;
  }
}

void mouseClicked() {
  if (mouseButton == RIGHT) {
    saver.save("png");
  }
}
