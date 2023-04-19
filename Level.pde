class Level {
  int top;
  int left;
  int right;
  int bottom;
  int level;
  Turtle turtle;
  int SPEED = 5;
  Bug bug1;
  Bug bug2;
  Timer timer = new Timer(millis(), interval)
  coins = new ArrayList<Coin>();
  int numCoins;
  int COINSIZE = 15;
  int binSize = COINSIZE*3;



  
  Level(int _level, int t, int l, int r, int b, Turtle _turtle, Minim minim){
    level = _level;
    top = t;
    left = l;
    right = r;
    bottom = b;
    turtle = _turtle;
    PVector bug1speed = new PVector(_level*SPEED, _level*SPEED/5);
    PVector bug2speed = new PVector(_level*SPEED, _level*SPEED);
    bug1 = new Bug(yellow, gray, red, bug1speed);
    bug2 = new Bug(purple, brown, green, bug2speed); 
    // code to decide placement of coins
    int binXnum = 0;
    int binYnum = 0;
    int binX = floor((r-l-(2*COINSIZE)) / (binSize);
    int binY = floor((b-t-(2*COINSIZE)) / (binSize);
    numCoins = binX * binY;
    // keep looping through bins and creating a coin until at last bin
    while (coins.size() < numCoins) {
      // if at the last bin in the row, move to next row
      if (binXnum => binX) {
        // move to next row and reset the binX
        binXnum = 0;
        binYnum += 1;
      }
      // create the coin
      int startX = (binXnum*binSize)+COINSIZE;
      int startY = (binYnum*binSize)+COINSIZE;
      coins.add(new Coin(random(startX, startX+binSize), random(startY, startY+binSize), minim)
    }
  }
  
  void display(){
    bug1.display();
    bug1.move();
    bug2.display();
    bug2.move();
    for (Coin c : coins) {
       c.display(); 
    }
  }
  
  // check health of the player in comparison to the coins and bug objects
  void checkHealth() {
    // add points to player for coin collisions
    if (checkCoinCollision()) {
      // add a value to the points
      turtle.plusPoint(5);
    }
    // remove life if runs into bug object
    if (checkBugCollision()) {
      // remove a life
      turtle.loseLife();
    }
  }
    
  // function to check if player runs into a coin object
  boolean checkCoinCollision() {
  }
  
  // function to check if player runs into a bug object
  boolean checkBugCollision() {
  
  }
  
}
