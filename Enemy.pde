// Group #: 11
// Author: Brittany Given
// File Description: defines enemy objects

class Enemy {
  float x, y, r; // used for the creation of the circle
  float speed; // used to control movement of the circle
  color c = #f3959a; // light pink color
  
  Enemy(float _x, float _y, float _r, float _s) {
    x = _x;
    y = _y;
    r = constrain(_r, 10, 20);
    speed = _s;
  }
  
  // draws the enemy object to screen
  void display() {
    ellipseMode(RADIUS);
    // set fill and make slightly transparant
    fill(c, 171);
    stroke(c);
    // draw the circle
    ellipse(x, y, r, r);
    // draw G in middle of circle for "guard"
    textAlign(CENTER, CENTER);
    textSize(20);
    text("G", x, y);
  }
  
  // updates the position of the object
  void update() {
    y += speed;
  }
}
