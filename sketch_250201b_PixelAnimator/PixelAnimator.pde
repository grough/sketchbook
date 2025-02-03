class Grid<T> {
  int cols, rows;
  ArrayList<ArrayList<T>> cells;

  Grid(int cols, int rows) {
    this.cols = cols;
    this.rows = rows;
    cells = new ArrayList<ArrayList<T>>(this.cols);
    for (int col = 0; col < this.cols; col++) {
      cells.add(new ArrayList<T>(rows));
      for (int row = 0; row < rows; row++) {
        cells.get(col).add(null);
      }
    }
  }

  void setRaw(int col, int row, T value) {
    cells.get(col).set(row, value);
  }

  void set(int col, int row, T value) {
    setRaw(mod(col, cols), mod(row, rows), value);
  }

  T getRaw(int col, int row) {
    return cells.get(col).get(row);
  }

  T get(int col, int row) {
    return getRaw(mod(col, cols), mod(row, rows));
  }

  Grid<T> copy() {
    Grid<T> newGrid = new Grid<T>(cols, rows);
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        newGrid.setRaw(col, row, getRaw(col, row));
      }
    }
    return newGrid;
  }

  int mod(int x, int n) {
    return ((x % n) + n) % n;
  }
}

class Box {
  int top, left, width, height;
  Box(int top, int left, int width, int height) {
    this.top = top;
    this.left = left;
    this.width =width;
    this.height = height;
  }
}

abstract class PixelAnimator<T> {
  int cols, rows, col, row;
  int width, height;
  int frame;
  Grid<T> grid;
  PGraphics graphics;

  PixelAnimator() {
    frame = 0;
    size(16, 16);
  }

  void size(int cols, int rows) {
    this.cols = cols;
    this.rows = rows;
    graphics = createGraphics(this.cols, this.rows);
    grid = new Grid(this.cols, this.rows);
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        this.col = col;
        this.row = row;
        grid.setRaw(col, row, populate());
      }
    }
  }

  void dimensions(int width, int height) {
    this.width = width;
    this.height = height;
    graphics = createGraphics(width, height);
  }

  PGraphics next() {
    Grid<T> gridNext = grid.copy();
    for (int row = 0; row < this.rows; row++) {
      for (int col = 0; col < this.cols; col++) {
        this.col = col;
        this.row = row;
        gridNext.setRaw(col, row, evolve());
      }
    }
    grid = gridNext;
    graphics.beginDraw();
    graphics.clear();
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        this.col = col;
        this.row = row;
        graphics.fill(shade());
        graphics.noStroke();
        Box box = box();
        graphics.rect(box.top, box.left, box.width, box.height);
        paint();
      }
    }
    graphics.endDraw();
    frame = frame + 1;
    return graphics;
  }

  Box box() {
    int w = width / cols;
    int h = height / rows;
    int x = col * w;
    int y = row * h;
    return new Box(x, y, w, h);
  }

  T self() {
    return grid.get(col, row);
  }

  T abs(int col, int row) {
    return grid.get(col, row);
  }

  T rel(int colOffset, int rowOffset) {
    return grid.get(col + colOffset, row + rowOffset);
  }

  int col() {
    return col;
  }

  int row() {
    return row;
  }

  boolean is(int col, int row) {
    return this.col == col && this.row == row;
  }

  float scale(float v, float a, float b, float c, float d) {
    return (-v * c + c * b + v * d - a * d) / (b - a);
  }

  float x() {
    return scale(col, 0, cols - 1, -1, 1);
  }

  float y() {
    return scale(row, 0, rows - 1, -1, 1);
  }

  float angle() {
    float theta = atan2(y(), x());
    float angle = theta > 0 ? theta : theta + 2 * PI;
    return angle;
  }

  float radius() {
    float x = x();
    float y = y();
    return sqrt(x * x + y * y);
  }

  int frame() {
    return frame;
  }

  T populate() {
    return null;
  }

  T evolve() {
    return null;
  };

  color shade() {
    return color(127);
  }

  void paint() {
  }
}
