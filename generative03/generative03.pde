import gifAnimation.*;

GifMaker gifExport;
int frames = 0;
int totalFrames = 80;

int diam = 10;
float centX, centY;

void setup() {
  size(500, 300);
  frameRate(24);
  smooth();
  background(180);
  
  gifExport = new GifMaker(this, "generative03.gif", 100);
  gifExport.setRepeat(0);

  centX = width / 2;
  centY = height / 2;
  stroke(0);
  strokeWeight(5);
  fill(255, 50);
}

void draw() {
  if (diam <= 400) {
    //background(180);
    ellipse(centX, centY, diam, diam);
    diam += 10;
  }
//  export();
}

void export() {
  if (frames < totalFrames) {
    gifExport.setDelay(20);
    gifExport.addFrame();
    frames++;
  } else {
    gifExport.finish();
    frames++;
    println("gif exported");
    exit();
  }
}
