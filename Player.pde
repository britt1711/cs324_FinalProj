// Group #: 11
// Author: Brittany Given
// File Description: defines player objects

class Player {
  float x, y, r; // used for the creation of the square
  color c = #000000; // black color
  int livesLeft = 5;
  int points = 0;
  
  Player(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    r = constrain(_r, 10, 20);
  }
  
  // draws the enemy object to screen
  void display() {
    rectMode(RADIUS);
    // set fill to be black and slightly transparant
    fill(c, 171);
    stroke(c);
    // draw the square
    rect(x, y, r, r);
  }
  
  // updates the position of the object
  void update(int mX, int mY) {
    x += mX;
    y += mY;
  }
  
  // increases points gained
  void plusPoint(int p) {
    points += p;
  }
  
  // decrease life
  void loseLife() {
    livesLeft -= 1;
  }
  
  // check if the player has died (ran out of lives)
  boolean checkIsDead() {
    return (livesLeft > 0);
  }
  
}
