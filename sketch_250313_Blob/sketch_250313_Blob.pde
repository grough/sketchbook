import com.grough.tools.*;
import static com.grough.tools.Util.*;
import com.grough.automata.*;

class W {
  float w1, w2;
}

class Animation extends Automaton<W> {

  W populate() {
    return new W();
  }

  W evolve() {
    W self = self();
    float t = clock.tau() * 1;
    self.w1 = sin(angle() * 2 - t * 4);
    self.w2 = sin(angle() * 3 + t * 1);
    return self;
  }

  color shade() {
    W self = self();
    float th = radius() * 1.5 - (self.w1 * .16 + self.w2 * .08);
    color c = th < 1 ? palette.get(30) : palette.get(31);
    return c;
  }
}

PVector hd = new PVector(1080, 1080);
PVector renderSize = hd.copy().div(2);
PVector previewSize = hd.copy().div(2);
PVector cellSize = hd.copy().div(20);

Animation animation = new Animation();
SeqSaver saver = new SeqSaver(this);
Clock clock = new Clock();
Palette palette;

void settings() {
  size((int)previewSize.x, (int)previewSize.y);
}

void setup() {
  frameRate(60);
  int frames = 60 * 8;
  saver.setFrames(frames);
  clock.divide(frames);

  palette = new Palette(dataPath("palette.txt"));

  animation.size((int)cellSize.x, (int)cellSize.y);
  animation.dimensions((int)renderSize.x, (int)renderSize.y);
}

void draw() {
  animation.next();
  clock.next();
  image(animation.graphics(), 0, 0, (int)previewSize.x, (int)previewSize.y);
  if (clock.tick()) {
    saver.startIfCued();
  }
  saver.save(animation.graphics());
}

void keyPressed() {
  if (key == 'R') {
    saver.cue();
  }
}
