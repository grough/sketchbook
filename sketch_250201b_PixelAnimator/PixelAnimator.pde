int mod(int x, int n) {
  return ((x % n) + n) % n;
}

int index(int column, int row, int columns, int rows) {
  return mod(row, rows) * columns + mod(column, columns);
}

abstract class Animation<T> {
  int cols, rows, col, row;
  ArrayList<T> cells, cellsNext;
  PGraphics graphics;

  Animation() {
    size(16, 16);
  }
  
  // Bug: Setting the size causes unexpected mutation
  void size(int cols, int rows) {
    this.cols = cols;
    this.rows = rows;
    cells = new ArrayList<T>(this.cols * this.rows);
    cellsNext = new ArrayList<T>(this.cols * this.rows);
    graphics = createGraphics(this.cols, this.rows);

    for (int i= 0; i < this.cols * this.rows; i++) {
      cells.add(null);
      cellsNext.add(null);
    }

    for (int row = 0; row < this.rows; row++) {
      for (int col = 0; col < this.cols; col++) {
        this.col = col;
        this.row = row;
        cellsNext.set(row * this.rows + col, populate());
      }
    }
  }

  PGraphics next() {
    cells = new ArrayList<T>(cellsNext);
    graphics.beginDraw();
    graphics.clear();
    for (int row = 0; row < this.rows; row++) {
      for (int col = 0; col < this.cols; col++) {
        this.col = col;
        this.row = row;
        T cell = evolve();
        cellsNext.set(row * this.rows + col, cell);
        graphics.stroke(shade());
        graphics.point(col, row);
      }
    }
    graphics.endDraw();
    return graphics;
  }
  
  T self() {
    return cells.get(index(this.col, this.row, this.cols, this.rows));
  }
  
  T abs(int col, int row) {
    return cells.get(index(col, row, this.cols, this.rows));
  }
  
  T rel(int col, int row) {
    return cells.get(index(this.col + col, this. row + row, this.cols, this.rows));
  }
  
  int col() {
    return this.col;
  }
  
  int row() {
    return this.row;
  }
  
  boolean is(int col, int row) {
    return this.col == col && this.row == row;
  }

  abstract T populate();

  abstract T evolve();

  abstract color shade();
}
