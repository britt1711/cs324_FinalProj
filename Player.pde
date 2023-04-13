// Group #: 11
// Author: Brittany Given
// File Description: defines player objects

// TODO: Brynne add the functions of logic in this class to your Turtle class

class Player {
  int livesLeft = 5;
  int points = 0;
  
  Player(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    r = constrain(_r, 10, 20);
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
  boolean isAlive() {
    return (livesLeft > 0);
  }
  
  // get function for the lives left
  int getLives() {
    return livesLeft;
  }
  
  // get function for the points
  int getPoints() {
    return points;
  }

}
