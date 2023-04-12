class Pipe {
  int w, h;
  PVector pos, vel;
  PImage pipeImg;

  Pipe(PVector pos, int w, int h) {
    this.pos = pos.copy();
    this.w = w;
    this.h = h;
    vel = new PVector(-2, 0);
    
    
    pipeImg = loadImage("pipe.png");
    pipeImg.resize(w,h);

  }
  
  void display(){
    //pipeImg.resize(w,h);
    image(pipeImg,pos.x,pos.y-h);
  }
  
  
  //RETURN X POSITION OF PIPE TO SEE IF PIPE TOUCHES ANYTHING (TURTLES)
  PVector getXPosition(){
    //Xposition 0 is x left position, 1 is x right position
    PVector Xposition = new PVector ((pos.x - w/2), (pos.x + w/2));
    return Xposition;
  }
  
  
}
