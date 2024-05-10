PVector SIZE_120_MM = new PVector(120, 120);
PVector SIZE_A4_MM = new PVector(297, 210);
PVector SIZE_4K_LANDSCAPE = new PVector(3840, 2160);

PVector getPixelSizeFromMillimeters(PVector sizeInMillimeters, int dotsPerInch) {
  return new PVector(
    ceil(dotsPerInch * sizeInMillimeters.x / 25.4),
    ceil(dotsPerInch * sizeInMillimeters.y / 25.4)
  );
}
