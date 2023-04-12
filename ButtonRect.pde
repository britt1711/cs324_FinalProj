// Group #: 11
// Author: Brittany Given
// File Description: class defines a button that is a rectangle

class ButtonRect extends Button {
  int x, y; // center of button 
  int w, h; // width and height of the button
  
  ButtonRect(int _x, int _y, int _w, int _h, String _label, color[] _colors) {
    super(_label, _colors);
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  // checks mouse position relative to the button
  void update(int mX, int mY) {
    if (((mX >= (x - (w/2))) && (mX <= (x + (w/2)))) && ((mY >= (y - (h/2))) && (mY <= (y + (h/2))))) {
      hovering = true;
    } else {
      hovering = false;
    }
  }

  // draws the button shape
  void drawButton() {
    rectMode(CENTER);
    rect(x, y, w, h, 10);
    drawLabel(x, y);
  }
}
