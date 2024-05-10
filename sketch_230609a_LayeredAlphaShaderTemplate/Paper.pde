class Paper {
  PVector sizeInMillimeters;
  int dotsPerInch;
  
  void setSizeInMillimeters(PVector size) {
    this.sizeInMillimeters = size;
  }
  
  void setDotsPerInch(int dpi) {
    this.dotsPerInch = dpi;
  }
  
  PVector getPixelSize() {
    return new PVector(
      dotsPerInch * sizeInMillimeters.x / 25.4,
      dotsPerInch * sizeInMillimeters.y / 25.4
    );
  }
}
