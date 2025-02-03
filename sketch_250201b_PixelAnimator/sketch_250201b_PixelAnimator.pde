// First attempt to port my pixel animator library

class MyAnimation extends PixelAnimator<Boolean> {
  Boolean populate() {
    return false;
  }

  Boolean evolve() {
    if (random(0,1) < 0.005) {
      return true;
    }
    if (random(0,1) < 0.05) {
      return false;
    }
    return self();
  }

  color shade() {
    return color(self() ? 127 + 15 : 127 + 30);
  }
}

MyAnimation animation;

void setup() {
  size(540, 540);
  frameRate(12);
  animation = new MyAnimation();
  animation.size(24, 24);
  animation.dimensions(540, 540);
}

void draw() {
  fill(255,0,0);
  rect(0,0,540,540);
  image(animation.next(), 2, 10, 540, 540);
}
