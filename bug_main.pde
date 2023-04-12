float screenWidth = 1000;
float screenHeight = 500;
color yellow = #EFF07E;
color purple = #9E79E3;
color gray = #B2ACAC;
color red = #D84A54;
color green = #518B3B;
color brown = #9B763B;

Bug bee;
Bug dragonfly;


void setup(){
  size(1000, 500);
  PVector bee_direction = new PVector(5, 1);
  PVector dragonfly_direction = new PVector(5, 5);
  bee = new Bug(yellow, gray, red, bee_direction);
  dragonfly = new Bug(purple, brown, green, dragonfly_direction); 
}

void draw(){
  background(#9DCFFF);
  bee.display();
  bee.move();
  bee.fly();
  dragonfly.display();
  dragonfly.fly();
  dragonfly.move();
}
