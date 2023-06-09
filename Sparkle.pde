// Author: Jonathan Liu
// File Description: class defines the sparkle that is on the coin object

class Sparkle {
  float x;
  float y;
  float radius;
  color c;
  int lifespan;

  Sparkle(float x_, float y_, float radius_) {
    x = x_;
    y = y_;
    radius = radius_;
    c = color(255, 215, 0);
    lifespan = 255;
  }

  void display() {
    noStroke();
    fill(c, lifespan);
    ellipse(x, y, radius, radius);
  }

  void update() {
    lifespan -= 5;
  }

  boolean isDead() {
    return lifespan <= 0;
  }
}
