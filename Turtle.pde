// Author: Brynne Jackson
// File Description: class defines the main player, a turtle object

class Turtle {

  //deals with lives and logic of game
  int livesLeft = 5;
  int points = 0;
  float startTime;
  float lifespan = 3000; //amount in miliseconds the turtle is inacrtive after a collision

  
  //deals with appearance of turtle
  float w, h;
  PVector pos, vel;
  PShape shell, nose, legs, circ;
  boolean right;

  color tan = (#F0DE3A);
  color green_shell = (#4FD823);
  color white = (#FFFFFF);
  color black = (#000000);
  color green_circle = color(201, 255, 210, 170);
  color red_circle = color(237,34,40, 100);

  //OPTIONAL BULLET CLASS
  ArrayList<Bullet> bullets;
  float bulletSpeed = 10;
  float bulletSize = 10;
  color bulletColor = color(255, 0, 0);
  boolean shot, isAlive, isActive;

  PShape turtle = createShape(GROUP);


  Turtle(PVector pos, float w, float h, boolean right) {
    this.pos = pos.copy();
    this.w = w;
    this.h = h;
    vel = new PVector(4, 4); //DO WE WANT TO CHANGE VELOCITY WITH DIF LEVELS? if so put this in parameter
    this.right = right;

    // initialize bullets array
    bullets = new ArrayList<Bullet>();
    isActive = true;
  }

  void changePosition(PVector _pos) {
    pos = _pos;
  }
  
  void changeSpeed(int speed){
    vel = new PVector(speed, speed);
  }

  boolean isActive(){
    return isActive;
  }

  //change the color of the circle around the turtle if it is hit to red
  void deactivate(){
    isActive = false;
    circ.setFill(red_circle);
  }
  
  void activate(){
    isActive = true;
    circ.setFill(green_circle);
  }

  //moves turtle when player presses keys
  void move(int _t, int _b, int _l, int _r) {
    if (keyPressed) {
      if (keyCode == LEFT || key == 'a') {
        right = false;
        if ((pos.x - w) > _l) {
          pos.x -= vel.x;
        }
      } else if (keyCode == RIGHT || key == 'd') {
        right = true;
        if ((pos.x + w) < _r) {
          pos.x += vel.x;
        }
      } else if (keyCode == UP || key == 'w') {
        if ((pos.y-h-(h/3.2)) > _t) {
          pos.y -= vel.y;
        }
      } else if (keyCode == DOWN || key == 's') {
        if ((pos.y+ h-(h/2.1)) < _b) {
          pos.y += vel.y;
        }
      }
    }
  }


  //shows turtle 
  void display() {
    // sway the legs back and forth
    float legAngle = sin(frameCount * 0.1) * PI / 210;
    legs.rotate(legAngle);

    //show transparent circle around turtle
    shape(circ, pos.x, pos.y);

    if (right) {
      pushMatrix();
      translate(pos.x, pos.y);
      scale(-1.0, 1.0);
      shape(turtle, 0, 0);
      popMatrix();
    } else {
      shape(turtle, pos.x, pos.y);
    }


    //ONLY RELEVANT IF WE DECIDE TO DO BULLETS
    // display bullets
    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.move();
      b.display();
      if (b.outOfBounds) {
        bullets.remove(i);
      }
    } 
  }

  // increases points gained
  void plusPoint(int p) {
    points += p;
  }

  // decrease life
  void loseLife() {
    livesLeft -= 1;
  }

  int getPoints() {
    return points;
  }

  int getLives() {
    return livesLeft;
  }

  boolean isAlive() {
    return (livesLeft > 0);
  }

  //OPTIONAL BULLET CLASS .... POSSIBLY ADD AFTER COLLECTS CERTAIN AMOUNT OF COINS?
  void shoot() {
    float bulletX, bulletY;
    if (right) {
      bulletX = pos.x + w/2;
    } else {
      bulletX = pos.x - w/2;
    }
    bulletY = pos.y;
    Bullet newBullet = new Bullet(bulletX, bulletY, 10, 10, right); // pass in the right value
    bullets.add(newBullet);
  }

  void shootBullet() {
    if (keyPressed && key == ' ') {
      if (!shot) {
        shoot(); // create and add new bullet to array
        shot = true; // set shot to true
      }
    } else {
      shot = false; // reset shot to false when space bar is not pressed
    }
  }

  //only build turtle once in setup
  void buildTurtle() {

    ellipseMode(CENTER);

    shell = createShape(ARC, 0, 0, w, h, PI, PI*2); //shell of turtle
    shell.setFill(green_shell);

    PShape head = createShape(ELLIPSE, -(w/2), -(h/2), w/2, h/1.5); //draw head
    head.setFill(tan);

    //PShape ear = createShape(ARC, -(w/2.2), -(h/1.2), w/4, h/3, PI, PI*2); //ear
    //ear.setFill(tan);

    nose = createShape(ELLIPSE, -(w/1.4), -(h/2.2), w/3, h/3); //nose of turtle
    nose.setFill(tan);

    PShape eye = createShape(ELLIPSE, -(w/1.7), -(h/1.8), w/4, h/3.5);
    eye.setFill(white);

    PShape iris = createShape(ELLIPSE, -(w/1.5), -(h/1.8), w/10, h/5);
    iris.setFill(black);

    //create legs
    legs = createShape(GROUP);
    for (int i = 0; i < 4; i++) {
      PShape leg = createShape(RECT, -(w/3) + (w/5 * i), (h)-h*1.1, w/8, h/1.8);
      leg.setFill(tan);
      legs.addChild(leg);
    }

    turtle.addChild(legs);
    turtle.addChild(shell);
    turtle.addChild(nose);
    turtle.addChild(head);
    turtle.addChild(eye);
    turtle.addChild(iris);

    noStroke();
    ellipseMode(CENTER);
    circ = createShape(ELLIPSE, 0, 0-(h/4.2), w * 2, h * 2); // draw circle with diameter larger than turtle size
    circ.setFill(green_circle);
  }
}
