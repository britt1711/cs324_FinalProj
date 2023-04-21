// Author: Brittany Given, Brynne Jackson, Kaitlin Shin, Jonathan Liu
// File Description: class defines the logic for creating levels

class Level {
  int top;
  int left;
  int right;
  int bottom;
  int levNum;
  Turtle turtle;
  Bug bug1;
  Bug bug2;
  ArrayList<Coin> coins;
  int numCoins;

  // colors
  color yellow = #EFF07E;
  color purple = #9E79E3;
  color gray = #B2ACAC;
  color red = #D84A54;
  color green = #518B3B;
  color brown = #9B763B;

  // variables that can be changed by developer
  int COINSIZE = 20;
  int binSize = COINSIZE*5;
  // set speed; has to be an even number pls
  int SPEED = 4;
  int COINPOINTS=10;

  Level(int _level, int t, int b, int l, int r, Turtle _turtle, AudioPlayer sound) {
    levNum = _level;
    top = t;
    left = l;
    right = r;
    bottom = b;
    turtle = _turtle;
    // update the speed of the turtle
    turtle.changeSpeed((_level+1)*floor((SPEED-(SPEED/3))));
    coins = new ArrayList<Coin>();
    PVector bug1speed = new PVector(random(-_level*(SPEED)-(SPEED/2),_level*SPEED),random(-_level*(SPEED)-(SPEED/2),_level*SPEED));
    PVector bug2speed = new PVector(random(-_level*(SPEED)-(SPEED/2),_level*SPEED),random(-_level*(SPEED)-(SPEED/2),_level*SPEED));
    bug1 = new Bug(yellow, gray, red, bug1speed, 500, 250);
    bug2 = new Bug(purple, brown, green, bug2speed, 250, 250);
    // code to decide placement of coins
    int binXnum = 0;
    int binYnum = 0;
    int binX = floor((r-l-(2*COINSIZE)) / (binSize));
    int binY = floor((b-t-(2*COINSIZE)) / (binSize));
    numCoins = binX * binY;
    // keep looping through bins and creating a coin until at last bin
    while (coins.size() < numCoins) {
      // if at the last bin in the row, move to next row
      if (binXnum >= binX) {
        // move to next row and reset the binX
        binXnum = 0;
        binYnum += 1;
      }
      // create the coin
      int startX = (binXnum*binSize)+COINSIZE;
      int startY = t+(binYnum*binSize)+COINSIZE;
      coins.add(new Coin(random(startX, startX+binSize), random(startY, startY+binSize), COINSIZE, sound));
      // iterate to new bin
      binXnum += 1;
    }
  }

  void display() {
    // draw background
    tint(255, 30);
    image(imgs[levNum-1], left, top);
    // move bug
    bug1.move();
    bug2.move();
    // move turtle
    turtle.move(top, bottom, left, right);
    // display the coins
    for (int i=0; i<coins.size(); i++) {
      Coin c = coins.get(i);
      c.display();
    }
    // display the bugs
    bug1.display();
    bug2.display();
    // display the turtle
    turtle.display();
    // check that the turtle and coins collided
    // check that the turtle and bugs collided
    checkHealth();
  }

  // check health of the player in comparison to the coins and bug objects
  void checkHealth() {
    // add points to player for coin collisions
    // loop through each coin
    for (int i=coins.size()-1; i>=0; i--) {
      Coin c = coins.get(i);
      // check if collided
      if (checkCoinCollision(c) && turtle.isActive()) {
        //make coin inactive
        c.collect();
        // add a value to the points
        turtle.plusPoint(COINPOINTS);
      }
      // remove coin if collected
      if (c.isCollected()) {
        coins.remove(i);
      }
    }
    
    // remove life if runs into bug object 1
    if (checkBugCollision(bug1) && turtle.isActive()) {
      turtle.deactivate();
      turtle.startTime = millis();
      // remove a life
      turtle.loseLife();
    }
    // remove life if runs into bug object 2
    if (checkBugCollision(bug2) && turtle.isActive()) {
      // remove a life
      turtle.loseLife();
      turtle.deactivate();
      turtle.startTime = millis();
    }
  }

  // function to check if player runs into a coin object
  boolean checkCoinCollision(Coin c) {
    // turtle runs into a coin
    //int tPos = new PVector(turtle.x, turtle.y-(turtle.h/4.2));

    if (dist(turtle.pos.x, turtle.pos.y-(turtle.h/4.2), c.pos.x, c.pos.y) <= (c.size/2 + turtle.w)) {
      //c.collect();
      return true;
    }
    return false;
  }

  // function to check if player runs into a bug object
  boolean checkBugCollision(Bug b) {
    // turtle runs into a bug
    if (dist(turtle.pos.x, turtle.pos.y-(turtle.h/4.2), b.x, b.y) <= (b.bodyLength + turtle.w)) {
      //c.collect();
      return true;
    }
    return false;
  }
}
