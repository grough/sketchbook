class Hand {
  float t = 0;
  float ecc = 1;
  float xo = 0;
  float yo = 0;
  float theta = 0;
  float steep = 1;

  float x = 0;
  float y = 0;

  float sig(float x, float steepness) {
    float L = 1;
    float k = steepness;
    float x0 = 0;
    return L / (1 + exp(-k * (x - x0)));
  }

  float[] next() {
    float x = cos(theta) * ecc * cos(t) - sin(theta) * sin(t);
    float y = sin(theta) * ecc * cos(t) + cos(theta) * sin(t);
    //float x = sig(cos(theta), steep) * ecc * sig(cos(t), steep) - sig(sin(theta), steep) * sig(sin(t), steep);
    //float y = sig(sin(theta), steep) * ecc * sig(cos(t), steep) + sig(cos(theta), steep) * sig(sin(t), steep);
    this.x = x;
    this.y = y;
    return new float[] {x + xo, y + yo};
  }
}
