// Group #: 11
// Author: Brittany Given
// File Description: defines hero objects

class Hero {
  float x, y, r; // used for the creation of the circle
  float speed; // used to control movement of the circle
  color c = #fee293; // light yellow color
  int v; // value of catching the hero
  boolean caught = false; // whether the hero has been intersected or not
  
  Hero(float _x, float _y, float _r, int _v, int _s) {
    x = _x;
    y = _y;
    r = constrain(_r, 10, 20);
    v = _v;
    speed = _s;
  }
  
  // draws the enemy object to screen
  void display() {
    // only show hero object if player has not intersected yet
    if (!caught) {
      ellipseMode(RADIUS);
      // set fill and make slightly transparant
      fill(c, 171);
      stroke(c);
      // draw the circle
      ellipse(x, y, r, r);
    }
  }
  
  // updates the position of the object
  void update() {
    y += speed;
  }
  
  // get the value of the hero
  int getValue() {
    return v;
  }
}
