// defines the game class

class Game {
  int top;
  int bottom;
  int left;
  int right;
  boolean active;
  Turtle player;
  Level level;
  int maxLevels = 5; // set the max levels
  
  Game(int _t, int _b, int _l, int _r) {
    top = _t;
    bottom = _b;
    left = _l;
    right = _r;
    active = true;
    // TODO: Brynne instantiate the turtle later
    //player = new Turtle();
    // TODO: Kaitlin to instantiate the level for first level
    //Level = new Level(player, );
  }
  
  // function to get the level
  void getLevel() {
    return level.getLevel();
  }
  
  // function to move to the next level
  void moveToNextLevel() {
    if (checkNextLevel()) {
      // TODO: Kaitlin to increment the new level
      //Level = new Level(player, level.levNum + 1, );
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
    // TODO: Brynne to write a function in Turtle to return the stats of the player
    // include the number of lives left and points collected
    int[] stats = [player.getPoints(), player.getLives()];
    return stats;
  }
  
  // function defines the players score based on the points and lives they have left
  int getPlayerScore() {
    int[] stats = player.getPlayerStats()
    // score = points plus number of lives * half of points
    return round(stats[0] + (stats[1]*(stats[0]/2)));
  }
  
  // function to check health of the player
  boolean isPlayerAlive() {
    // TODO: Brynne to write a function in Turtle to return lives of the player
    if (!player.isAlive()) {
      // if player dies, game is over
      active = false;
    }
    return player.isAlive();
  }
  
  // function to display the game
  void display() {
    level.display();
  }
}
