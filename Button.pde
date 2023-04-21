// Author: Brittany Given
/* File Description: 
button class checks when mouse is over it and when mouse clicks on it
this button class is extended to the specific shape in ButtonRect
*/

class Button {
  boolean selected; // on when mouse clicks on it
  boolean hovering; // on when hovering
  color defaultC, hoverC, selectedC; // color of the button when no mouse, mouse hovering, mouse selected
  String label; // label of the button

  Button(String _label, color[] _colors) {
    label = _label;
    selected = false;
    hovering = false;
    defaultC = _colors[0];
    hoverC = _colors[1];
    selectedC = _colors[2];
  }
  
  // display button
  void display() {
    noStroke();
    // set fill
    if (selected) {
      fill(selectedC);
    } else if (hovering) {
      fill(hoverC);
    } else {
      fill(defaultC);
    }
    drawButton();
  }
  
  // drawButton in this class is empty bc determined by subclass
  void drawButton() {}
  
  // boolean for mouse being pressed on button
  boolean isSelected() {
    // if hovering over button, button can be selected
    if (hovering) {
      selected = true;
      return true;
    }
    // if not hovering over button, button cannot be selected
    return false;
  }
  
  // boolean for mouse being released on button
  boolean isReleased() {
    selected = false;
    return false;
  }
  
  // draw label on center of button
  void drawLabel(float _x, float _y) {
    textSize(15);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, _x, _y-3);
  }

}
