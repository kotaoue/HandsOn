void setup() {
  size(300, 300);
  smooth();
}


void draw() {
  background(255);

  float xstart = random(10);
  float ynoiseInit = random(10);
  int cols = width + 1;

  for (int i = 0; i < cols * height; i++) {
    int x = i % cols;
    int y = i / cols;
    float xnoise = xstart + (x + 1) * 0.01;
    float ynoise = ynoiseInit + (y + 1) * 0.01;
    int alph = int(noise(xnoise, ynoise) * 255);
    stroke(0, alph);
    line(x, y, x+1, y+1);
  }
}
