void setup() {
  size(300, 300);
  smooth();
}


void draw() {
  background(255);

  float xstart = random(10);
  float ynoiseInit = random(10);
  int cols = width / 5 + 1;
  int rows = height / 5;

  for (int i = 0; i < cols * rows; i++) {
    int xi = i % cols;
    int yi = i / cols;
    int x = xi * 5;
    int y = yi * 5;
    float xnoise = xstart + (xi + 1) * 0.1;
    float ynoise = ynoiseInit + (yi + 1) * 0.1;
    drawPoint(x, y, noise(xnoise, ynoise));
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  float len = 10 * noiseFactor;
  rect(x, y, len, len);
}
