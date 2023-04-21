// Author: Brittany Given
/* File Description:
class that creates a timer
will be used in our program to determine when to move on to the next level
*/

class Timer {
  int startTime;
  int interval;
  int currTime;
  boolean active = true; // used to control pause
  int timePaused = 0; // used to note how long timer is paused for
  int pauseStartTime = 0; // notes time when pause starts
  
  Timer(int _startTime, int _interval) {
    startTime = _startTime;
    currTime = _startTime;
    interval = _interval;
  }
  
  // checks if the timer has been activated
  boolean checkActivation(int _currTime) {
    currTime = _currTime;
    // animation is running
    if (active) {
      // interval time has been met
      if (currTime - startTime >= interval) {
        return true;
      }
    }
    // animation is paused
    else if (!active) {
      timePaused = (currTime - pauseStartTime);
    }
    return false;
  }
  
  // "pause" (deactivate) the timer
  void pause() {
    pauseStartTime = millis();
    active = false;
  }
  
  // start timer after timer has been paused
  void cont() {
    active = true;
    startTime += timePaused;
    timePaused = 0;
  }
  
  // resets the timer, which serves as a "repeat" function for the timer
  void reset(int _currTime) {
    startTime = _currTime;
    currTime = _currTime;
  }
  
  // returns whether the timer is active or not
  boolean isRunning() {
    return active;
  }
  
  // returns the number of seconds left, rounded up
  int secondsLeft() {
    int ellapsedTime = currTime - startTime - timePaused;
    return ceil((interval - ellapsedTime)/1000);
  }
}
