class Bullet {
  float x, y, speed;
  int r;
  boolean right,outOfBounds;

  Bullet(float x, float y, float speed, int r, boolean right) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.r = r;
    this.right = right; // store the right value
  }

  void move() {
    if (right) { // if right is true, move to the right
      x += speed;
    } else { // otherwise move to the left
      x -= speed;
    }
    if (x < -r || x > width+r || y < -r || y > height+r) {
      outOfBounds = true;
    }
  }

  void display() {
    fill(#F01111);
    ellipse(x, y, r, r);
  }
}
