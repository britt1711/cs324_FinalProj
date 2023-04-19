class Bug {
  float x = 500;
  float y = 250;
  PVector direction;
  color wingColor;
  color bodyColor;
  color eyeColor;
  int wingDown1= -30;
  int wingDown2= -50;
  int counter = 0;
  int bodyHeight = 12;
  int bodyLength = 60;
  int screenWidth = 1000;
  int screenHeight = 700;

  Bug(color c, color b, color e, PVector _direction) {
    wingColor = c;
    bodyColor = b;
    eyeColor = e;
    direction = _direction;
  }
  
  
  void display() {
    if(x>screenWidth || x < 0){
      direction.x *= -1;
    } 
    if(y>screenHeight || y < 0){
      direction.y *= -1;
    } 
    fill(bodyColor);
    
    PShape bug = createShape(GROUP);
    PShape body = createShape(ELLIPSE, x, y, bodyLength, bodyHeight);
    PShape stinger = createShape(TRIANGLE, x - bodyLength/2, y-3, x - bodyLength/2, y+3, x - bodyLength/2 - 15, y);
    fill(eyeColor);
    PShape eye = createShape(ELLIPSE, x + 12, y - 1, 3, 3);
    PShape stripe = createShape(RECT, x-10, y-bodyHeight/2, 5, bodyHeight);
    bug.addChild(body);
    bug.addChild(stinger);
    bug.addChild(eye);
    bug.addChild(stripe);
    shape(bug);
    fill(wingColor);
    beginShape();
    curveVertex(x+30, y);
    curveVertex(x-20, y-bodyHeight/2);
    curveVertex(x-60, y-bodyHeight/2+wingDown1);
    curveVertex(x-15, y-bodyHeight/2+wingDown2);
    curveVertex(x, y-bodyHeight/2);
    curveVertex(x-20, y);
    endShape();
    beginShape();
    curveVertex(x-30, y);
    curveVertex(x+20, y-bodyHeight/2);
    curveVertex(x+60, y-bodyHeight/2+wingDown1);
    curveVertex(x+15, y-bodyHeight/2+wingDown2);
    curveVertex(x, y-bodyHeight/2);
    curveVertex(x+20, y);
    endShape();
  }

  void move() {
    x += direction.x;
    y += direction.y;
    
  }
  
  void fly(){
    counter += 1;
    if (counter % 25 == 0){
      wingDown1 *= -1;
      wingDown2 *= -1;
    }
  }
  
}