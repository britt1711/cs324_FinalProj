// Author: Jonathan Liu
// File Description: class defines a coin

class Coin {
  PVector pos;
  int size;
  int rotation;
  boolean collected;
  int sparkleInterval;
  int lastSparkleTime;
  ArrayList<Sparkle> sparkles;
  float angle = 1;
  float increment = 0.025;
  AudioPlayer coinSound;
  
  Coin(float x, float y, int s, AudioPlayer sound) {
    pos = new PVector(x, y);
    size = s;
    rotation = 0;
    collected = false;
    sparkleInterval = 10; // emit sparkles every 30 frames
    lastSparkleTime = frameCount;
    sparkles = new ArrayList<Sparkle>();
    angle = 1.0;
  
    coinSound = sound;
  }

  void display() {
    fill(255, 215, 0); // gold color
    pushMatrix();
    translate(pos.x, pos.y);
    scale(angle, 1.0);
    ellipse(0, 0, size, size);
    popMatrix();
    emitSparkles();
    displaySparkles();

    if (angle <= -1) {
      increment = abs(increment);
    } else if (angle >= 1) {
      increment = -(abs(increment));
    }
    angle += increment;
  }

  void emitSparkles() {
    if (frameCount - lastSparkleTime > sparkleInterval) {
      float sparkleX = random(pos.x - size/2, pos.x + size/2);
      float sparkleY = random(pos.y - size * 2, pos.y - size/1.5);
      float sparkleSize = random(3, 6) * (0.5);
      sparkles.add(new Sparkle(sparkleX, sparkleY, sparkleSize));
      lastSparkleTime = frameCount;
    }
  }

  void displaySparkles() {
    for (int i = sparkles.size() - 1; i >= 0; i--) {
      Sparkle sparkle = sparkles.get(i);
      sparkle.display();
      sparkle.update();
      if (sparkle.isDead()) {
        sparkles.remove(i);
      }
    }
  }

  void collect() {
    collected = true;
    angle = 1;
    if (!isMuted) {
      coinSound.play();
      coinSound.rewind(); 
    }
    // Set final position and size of coin to make it disappear
    pos.y = -9999;
    size = 0;
  }
  
  
  // return whether coin is collected
  boolean isCollected() {
    return collected;
  }
}
