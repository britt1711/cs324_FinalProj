class Turtle {
  float w, h;
  PVector pos, vel;
  PShape shell,nose;
  boolean right;

  color tan = (#F0DE3A);
  color green_shell = (#4FD823);
  color white = (#FFFFFF);
  color black = (#000000);

  PShape turtle = createShape(GROUP);


  Turtle(PVector pos, float w, float h, boolean right) {
    this.pos = pos.copy();
    this.w = w;
    this.h = h;
    vel = new PVector(-2, 0);
    
    //for debugging purposes
    this.right = right;
  }

  void buildTurtle() {

    ellipseMode(CENTER);

    shell = createShape(ARC, 0, 0, w, h, PI, PI*2); //shell of turtle
    shell.setFill(green_shell);

    PShape head = createShape(ELLIPSE, -(w/2), -(h/2), w/2, h/1.5); //draw head
    head.setFill(tan);

    nose = createShape(ELLIPSE, -(w/1.4), -(h/2.2), w/3, h/3); //nose of turtle
    nose.setFill(tan); 
    //----------THIS IS ENEMY OBJECT POSITION WHICH WE SHOULD CHECK IF MARIO INTERSECTS
    // ALSO SHOULD BE USED TO BOUNCE OFF OF PIPES AND TURN POSITIONS

    PShape eye = createShape(ELLIPSE, -(w/1.7), -(h/1.8), w/4, h/3.5);
    eye.setFill(white);

    PShape iris = createShape(ELLIPSE, -(w/1.5), -(h/1.8), w/10, h/5);
    iris.setFill(black);

    turtle.addChild(shell);
    turtle.addChild(nose);
    turtle.addChild(head);
    turtle.addChild(eye);
    turtle.addChild(iris);
  }
  
  
  
  void update(){
    
    //displays the turtle by switching position across y axis
    /*----------------NOTE---------------------
    issue here is that when i scale the shape -1.0 it displays turtle at pos.x*-1.0
    which is not where I want to display the turtle. I want to still display turtle
    at same x position now moving in opposite velocity so I can multiple vel*-1
    */
    
    
    if (right){
      pushMatrix();
      translate(pos.x,pos.y);
      scale(-1.0,1.0);
      //vel.x=vel.x*-1;
      pos.add(vel);
      shape(turtle,0,0);
      popMatrix();
    }else{
      pos.add(vel);
      shape(turtle,pos.x,pos.y);
    }
    //println(pos);
  }
  
  
  
  //GET POSITION OF TURTLES NOSE TO SEE IF TURTLES TOUCHES ANYTHING
  PVector getNosePosition(){
    PVector nosePos;
    if (right){
      nosePos = new PVector((pos.x+(w/1.4)+ (w/6)) , (pos.y - (h/2.2) - (h/6)));
    }else{
      nosePos = new PVector((pos.x-(w/1.4) - (w/6)) , (pos.y - (h/2.2) - (h/6)));
    }
    return nosePos;
  }
  
  
  
}
