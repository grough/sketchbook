// First attempt to port my pixel animator library

class MyAnimation extends Animation<Boolean> {
  Boolean populate() {
    return is(2, 3);
  }

  Boolean evolve() {
    return !self();
  }

  color shade() {
    return color((self() ? 1 : 0) * 255);
  }
}

MyAnimation animation;

void setup() {
  size(540, 540);
  noSmooth();
  frameRate(8);
  animation = new MyAnimation();
  animation.size(16, 16);
}

void draw() {
  image(animation.next(), 0, 0, 540, 540);
}
