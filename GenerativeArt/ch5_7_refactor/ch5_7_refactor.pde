float xStart;
float yStart;
float zStart, zNoise;

int sideLength = 200;
int spacing = 5;

void setup() {
  size(500, 300, P3D);
  background(0);
  sphereDetail(8);
  noStroke();

  xStart = random(10);
  yStart = random(10);
  zStart = random(10);
}


void draw() {
  background(0);

  xStart += 0.01;
  yStart += 0.01;
  zStart += 0.01;

  translate(150, 20, -150);
  rotateZ(frameCount * 0.1);
  rotateY(frameCount * 0.1);

  int steps = sideLength / spacing + 1;
  float zNoiseStart = zNoise;

  for (int i = 0; i < steps * steps * steps; i++) {
    int xi = i % steps;
    int yi = (i / steps) % steps;
    int zi = i / (steps * steps);
    float x = xi * spacing;
    float y = yi * spacing;
    float z = zi * spacing;
    float xN = xStart + (xi + 1) * 0.1;
    float yN = yStart + (yi + 1) * 0.1;
    float zN = zNoiseStart + (zi + 1) * 0.1;
    drawPoint(x, y, z, noise(xN, yN, zN));
  }

  zNoise = zNoiseStart + steps * 0.1;
}

void drawPoint(float x, float y, float z, float noiseFactor) {
  pushMatrix();
  translate(x, y, z);
  float grey = noiseFactor * 255;
  fill(grey, 10);
  box(spacing, spacing, spacing);
  popMatrix();
}
