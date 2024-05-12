PVector getPixelSizeFromMillimetersAtDpi(PVector sizeInMillimeters, int dotsPerInch) {
  return new PVector(
    ceil(dotsPerInch * sizeInMillimeters.x / 25.4),
    ceil(dotsPerInch * sizeInMillimeters.y / 25.4)
    );
}

PVector SIZE_120_MM = new PVector(120, 120);
PVector SIZE_A4_MM = new PVector(297, 210);
PVector SIZE_4K_LANDSCAPE = new PVector(3840, 2160);
PVector SIZE_HD_PORTRAIT = new PVector(1080, 1920);
PVector SIZE_SQUARE_2K = new PVector(2160, 2160);

// The following code was written by ChatGPT
class NormalizedCoordinates {
  float x, y, xb, yb, r, a, rb, ab;

  // Constructor to set the properties
  NormalizedCoordinates(float x, float y, float xb, float yb, float r, float a, float rb, float ab) {
    this.x = x;
    this.y = y;
    this.xb = xb;
    this.yb = yb;
    this.r = r;
    this.a = a;
    this.rb = rb;
    this.ab = ab;
  }
}

NormalizedCoordinates normalize(int width, int height, int column, int row) {
  float aspectRatio = (float) width / height;
  float x, y, xb, yb, r, a, rb, ab;

  if (aspectRatio >= 1) {
    // Width is the longer dimension
    float scaleW = width;
    float scaleH = height * aspectRatio; // Adjust height to match the scale of width
    xb = 2 * (column / scaleW) - 1;
    yb = 2 * ((row - (height - scaleH) / 2) / scaleH) - 1;

    x = column / scaleW;
    y = (row - (height - scaleH) / 2) / scaleH;
    y = y < 0 ? 0 : (y > 1 ? 1 : y);
  } else {
    // Height is the longer dimension
    float scaleH = height;
    float scaleW = width / aspectRatio; // Adjust width to match the scale of height
    xb = 2 * ((column - (width - scaleW) / 2) / scaleW) - 1;
    yb = 2 * (row / scaleH) - 1;

    x = (column - (width - scaleW) / 2) / scaleW;
    x = x < 0 ? 0 : (x > 1 ? 1 : x);
    y = row / scaleH;
  }

  // Calculating radius and angle for 0..1 coordinates
  r = sqrt(x * x + y * y);
  a = atan2(y, x);

  // Calculating radius and angle for -1..1 coordinates
  rb = sqrt(xb * xb + yb * yb);
  ab = atan2(yb, xb);

  return new NormalizedCoordinates(x, y, xb, yb, r, a, rb, ab);
}
