// Author: Brittany Given
// File Description: defines the game class

class Game {
  int top;
  int bottom;
  int left;
  int right;
  boolean active;
  Turtle turtle;
  Level level;
  AudioPlayer sound;
  int maxLevels = 5; // set the max levels
  
  Game(int _t, int _b, int _l, int _r, AudioPlayer _s) {
    top = _t;
    bottom = _b;
    left = _l;
    right = _r;
    active = true;
    sound = _s;
    // instantiate and build turtle
    turtle = new Turtle(new PVector(0,height/2),50,50,true);
    turtle.buildTurtle();
    // instantiate the level for first level
    level = new Level(1, top, bottom, left, right, turtle, sound);
  }
  
  // function to get the level
  int getLevel() {
    return level.levNum;
  }
  
  // function to move to the next level
  void nextLevel() {
    if (!isOnLastLevel()) {
      // reset the turtle to middle bottom of screen at start of levels
      turtle.changePosition(new PVector((right-left)/2,bottom));
      turtle.right=true;
      // increment the new level
      level = new Level(level.levNum + 1, top, bottom, left, right, turtle, sound);
    }
  }
  
  // function to see if we move to next level
  boolean isOnLastLevel() {
    if (level.levNum < maxLevels) {
      return false;
    }
    // if on last level, game is over
    active = false;
    return true;
  }
  
  // function to get player stays for the game summary screen
  int[] getPlayerStats() {
    int[] stats = {turtle.getPoints(), turtle.getLives()};
    return stats;
  }
  
  // function defines the players score based on the points and lives they have left
  int getPlayerScore() {
    int[] stats = this.getPlayerStats();
    // score = points plus number of lives * half of points
    return round(stats[0] + (stats[1]*(stats[0]/2)));
  }
  
  // function to check health of the player
  boolean isPlayerAlive() {
    if (!turtle.isAlive()) {
      // if player dies, game is over
      active = false;
    }
    return turtle.isAlive();
  }
  
  // function to display the game
  void display() {
    level.display();
  }
}
