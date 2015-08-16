import gifAnimation.*;

GifMaker gif;
int frames = 0;
int totalFrames = 240;

int _numChildren = 4;
int _maxLevels = 7;

Branch _trunk;

void setup() {
  size(750, 500);
  size(750, 500);
  background(255);
  noFill();
  smooth();
  
//  gif = new GifMaker(this, "generative27.gif", 100);
//  gif.setRepeat(0);
  
  newTree();
}

void draw() {
  background(255);
  _trunk.updateMe(width / 2, height / 2);
  _trunk.drawMe();
//  export();
}

void newTree() {
  _trunk = new Branch(1, 0, width / 2, 50);
  _trunk.drawMe();
}

void export() {
  if (frames < totalFrames) {
    gif.setDelay(20);
    gif.addFrame();
  } else {
    gif.finish();
    println("gif exported");
    exit();
  }
  frames++;
}

//============= Objects ===================

class Branch {
  float level, index;
  float x, y;
  float endx, endy;
  float strokeW, alph;
  float len, lenChange;
  float rot, rotChange;
  Branch[] children = new Branch[0];
  
  Branch(float lev, float ind, float ex, float why) {
    level = lev;
    index = ind;
    strokeW = (1 / level) * 10;
    alph = 255 / level;
    len = (1 / level) * random(200);
    rot = random(360);
    lenChange = random(10) - 5;
    rotChange = random(10) - 5;
    updateMe(ex, why);
    
    if (level < _maxLevels) {
      children = new Branch[_numChildren];
      for (int x = 0; x < _numChildren; x++) {
        children[x] = new Branch(level + 1, x, endx, endy);
      }
    }
  }
  
  void updateMe(float ex, float why) {
    x = ex;
    y = why;
    
    // increase spin
    rot += rotChange;
    if (rot > 360) { rot = 0; }
    
    // increase length
    len -= lenChange;
    if (len < 0) { lenChange *= -1; }
    else if (len > 200) { lenChange *= -1; }
    
    float radian = radians(rot);
    endx = x + (len * cos(radian));
    endy = y + (len * sin(radian));
    
    for (int i = 0; i < children.length; i++) {
      children[i].updateMe(endx, endy);
    }
  }
  
  void drawMe() {
    strokeWeight(strokeW);
    stroke(0, alph);
    fill(255, alph);
    line(x, y, endx, endy);
    ellipse(endx, endy, len / 12, len / 12);
    for (int i = 0; i < children.length; i++) {
      children[i].drawMe();
    }
  }
}