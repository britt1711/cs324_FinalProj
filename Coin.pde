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
  
    String filePath = dataPath(
      "coin_collect.mp3"
      );
    //minim = new Minim(this);
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

class Sparkle {
  float x;
  float y;
  float radius;
  color c;
  int lifespan;

  Sparkle(float x_, float y_, float radius_) {
    x = x_;
    y = y_;
    radius = radius_;
    //TODO: change back to white when background is added
    //c = color(255, 255, random(200, 255)); //white color for sparkles
    c = color(255, 215, 0);
    lifespan = 255;
  }

  void display() {
    noStroke();
    fill(c, lifespan);
    ellipse(x, y, radius, radius);
  }

  void update() {
    lifespan -= 5;
  }

  boolean isDead() {
    return lifespan <= 0;
  }
  
}
