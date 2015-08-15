import processing.opengl.*;
import gifAnimation.*;

GifMaker gif;
int frames = 0;
int totalFrames = 120;

float xstart, ystart, xnoise, ynoise;

void setup() {
  size(500, 300, OPENGL);
  background(0);
  sphereDetail(8);
  noStroke();
  
  gif = new GifMaker(this, "generative19.gif", 100);
  gif.setRepeat(0);
  
  xstart = random(10);
  ystart = random(10);
}

void draw() {
  background(255);
  
  xstart += 0.01;
  ystart += 0.01;
  
  xnoise = xstart;
  ynoise = ystart;
  
  for (int y = 0; y <= height; y += 5) {
    ynoise += 0.1;
    xnoise = xstart;
    for (int x = 0; x <= width; x += 5) {
      xnoise += 0.1;
      drawPoint(x, y, noise(xnoise, ynoise));
    }
  }
  export();
}

void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, 250 - y, -y);
  float sphereSize = noiseFactor * 35;
  float grey = 150 + (noiseFactor * 120);
  float alph = 150 + (noiseFactor * 120);
  fill(grey, alph);
  sphere(sphereSize);
  popMatrix();
}

void export() {
  if (frames < totalFrames) {
    gif.setDelay(20);
    gif.addFrame();
    frames++;
  } else {
    gif.finish();
    println("gif exported");
    exit();
  }
}
