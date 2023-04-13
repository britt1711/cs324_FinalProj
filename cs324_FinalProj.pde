// Authors: Brittany Given, Brynne Jackson, Jonathan Liu, Kailtin Shin
// Assignment: Final Project
// Date: 4/16/2023
/* File Description: 
This program runs our game "Capture the Coin!", where the user has to 
navigate around enemies while collecting points. The user advances to
new levels where the enemies move faster, resulting in the
user having to move faster to not get caught by enemies.
*/

// define colors
color black = #000000;
color white = #FFFFFF;
color darkBlue = #33506e;
color medBlue = #81a4c8;
color lightBlue = #afd2e9;
color green = #80966f;
color lightGreen = #b7c9af;
color yellow = #E3CE62;
color red = #BF231B;
color gray = #939496;
color lightGray = #b7b9b3;
color cEnemy = #f3959a; // color used for enemy
color cHero = #fee293; // color used for hero
color[] colors = {medBlue, lightBlue, darkBlue};

// initialize variable for font
PFont font;
// set font sizes for different headers
int h0 = 70; // title size
int h1 = 50; // header 1 size
int h2 = 35; // header 2 size
int h3 = 18; // header 3 size
int h4 = 15; // header 4 size

// define order of screens user can be on
String[] page = {"Welcome", "Background", "Instructions", "LevelIntro", "Game", "Summary", "UserName", "Scoreboard"};
String currPage; // variable for current page displayed to user

// variable to determine if game is paused or not
Game game;
boolean isPaused = false;

// EXTRA: timer for blinking text
// variables for the animation timer
Timer textOff;
Timer textOn;
int textInterval = 2500; // denotes how long to not display text for

// EXTRA: timer for countdown before each level starts
Timer levelCountdown;
// EXTRA: timer for countdown during each level
Timer playCountdown;

// variables for wrapping large amount of text to the screen
float textX; // tracks y value of text placement
float textY; // tracks x value of text placement
float m = 10; // margin around the screen
boolean wrap = false; // boolean if last word didn't fit on screen and need to wrap to newline
String word; // word being written to screen
int wordIdx; // index of the word in words array
String[] words; // variable for file upload

// menu buttons
ButtonRect bPause;
ButtonRect bCont;
ButtonRect bRestart;
ButtonRect bEnd;

// initialize variables for the userInput for username
String typing = ""; // defines text being typed
String savedUserName = ""; // defines saved text

// initialize PrintWriter to write scoreboard
PrintWriter scoreboard;

void setup() {
  // set canvas size
  size(1000,800);
  
  // create a new file in the sketch directory
  scoreboard = createWriter("scoreboard.txt"); 
  
  // set font for the program
  font = createFont("LemonMilk-Regular.otf", h4); 
  textFont(font);
  
  // read in "gameBackground.txt" file
  words = loadStrings("allWordsBackground.txt");
  // define first word
  wordIdx = -1;
  
  // set current page to the welcome screen when program is first ran
  currPage = page[0];
  
  // instantiate timer for blinking text
  textOff = new Timer(millis(), 300);
  textOn = new Timer(millis(), 2000);
  
  // instantiate timer for level countdown - appears as though user gets 3 seconds
  levelCountdown = new Timer(millis(), 4000);
  
  // instantiate timer for play countdown - each level lasts about 10 seconds
  playCountdown = new Timer(millis(), 11000);
  
  // instantiate the buttons for the menu options
  int w = 80;
  int h = 50;
  bPause = new ButtonRect(width/4, height-50, w, h, "Pause", colors);
  bCont = new ButtonRect(width/4, height-50, w+40, h, "Continue", colors);
  bRestart = new ButtonRect(width/2, height-50, w*3, h, "Restart from Level 1", colors);
  bEnd = new ButtonRect((3*width/4), height-50, w, h, "End", colors);
}

void draw() {
  // CASE: on welcome page
  if (currPage == page[0]) {
    displayWelcome();
  } 
  // CASE: on background page page
  else if (currPage == page[1]) {
    displayBackground();
  }
  // CASE: on game instructions page
  else if (currPage == page[2]) {
    displayInstructions();
  }
  // CASE: on level intro page
  else if (currPage == page[3]) {
    displayLevelIntroduction();
    isPaused = false;
  }
  // CASE: on the game page
  else if (currPage == page[4]) {
    
    //println("Active =", playCountdown.isRunning());
    // update play countdown
    playCountdown.checkActivation(millis());
    
    // CASE: game is paused
    if (isPaused) {
      // draw the box to hold the "paused" message
      rectMode(CENTER);
      fill(lightBlue);
      stroke(darkBlue);
      rect(width/2, height/2, width/3, height/3);
      // display "game is paused" text
      fill(darkBlue);
      textSize(h2);
      textAlign(CENTER,CENTER);
      text("Game is Paused",width/2, height/2, width/3, height/3);
    } 
    // CASE: game is playing
    else {
      // TODO: this may be able to be changed with game.display();
      displayLevel();
    }
    
    // draw user menu that displays user information
    drawUserMenu();
    // draw menu options for user to pause/continue, restart, or end and go back to welcome page
    drawOptionsMenu();
    
    // if playCountdown is 0, then move to next page
    if (playCountdown.checkActivation(millis())) {
      // TODO: delete below line and uncomment lines after
      currPage = page[5];
      /*
      // CASE: player has not made it through all levels yet
      if (!game.isOnLastLevel()) {
        // move to next level and restart play countdown clock
        game.moveToNextLevel();
        playCountdown.reset(millis());
      } 
      // CASE: finished all levels, move to summary page
      else {
        currPage = page[5];
      }
      */
    }
  }
  // CASE: on the game summary page, which occurs after all levels have been played
  else if (currPage == page[5]) {
    displaySummary();
  }
  // CASE: on the create username page
  else if (currPage == page[6]) {
    displayCreateUsername();
  }
  // CASE: on the scoreboard page
  else if (currPage == page[7]) {
    displayScoreboard();
  }
}

// describes and draws the welcome page
void displayWelcome() {
  background(white);
  
  // display title of game
  fill(darkBlue);
  textSize(h0);
  textAlign(CENTER,BOTTOM);
  text("Capture The Coin!",width/2,350);
  
  // display tagline of game
  fill(medBlue);
  textSize(h2);
  textAlign(CENTER,TOP);
  rectMode(CENTER);
  text("the game of getting rich",width/2,400,800,80);
  
  // display instructions to move to next page
  fill(gray);
  textSize(h4);
  // allow text to blink
  blinkText("Press any key to start",width/2,height-50,800,80, textOff, textOn);
}

// describes and draws the game instruction page
void displayBackground() {
  background(white);
  
  // display header
  fill(darkBlue);
  textSize(h1);
  textAlign(CENTER,BOTTOM);
  text("Background",width/2,150);
  
  // display story
  fill(medBlue);
  textSize(h3);
  textAlign(LEFT,TOP);
  rectMode(CENTER);
  writeBackgroundStory();

  // display instructions to move to next page
  fill(gray);
  textSize(h4);
  textAlign(CENTER,TOP);
  rectMode(CENTER);
  // allow text to blink
  blinkText("Press any key to continue",width/2,height-50,800,80, textOff, textOn);
}

// writes the words from gameBackground.txt (converted into allWordsBackground.txt) to the screen
void writeBackgroundStory() {
  // set text alignment
  textAlign(LEFT, TOP); 
  // define first line's height
  textY = 200;
  // define wordIdx to start at
  wordIdx = 0;
  // loop through coordinates of text placement to fill screen with words
  while (textY < height - (h3 + (m * 2)) && wordIdx < (words.length)) {
    // set starting width for each new line (sets the margin on the left side)
    textX = m*5;
    // CASE: last word needed to be moved to a new line
    // we still need to write that word to the screen
    if (wrap && !word.equals("***")) {
      // write last word to screen
      text(word, textX, textY);
      // update new width to track
      textX += textWidth(word + " "); 
      // set wrap variable back to false
      wrap = false;
    }
    // sets margin for the right side of the screen
    while(textX < width - (m*5) && wordIdx < (words.length)) {
      // get the word from the words list
      word = words[wordIdx];
      // if word is a newline character, move to a new line
      if (word.equals("***")) {
        // set w to a width that will break the while loop
        textX = width;
        // set wrap boolean to true
        wrap = true;
      }
      // check if adding word to the line will make it go out of screen
      // CASE: word fits on current line
      else if ((textX + textWidth(word)) < width - (m * 5)) {
          // write word to screen
          text(word, textX, textY);
          // update new width to track
          textX += textWidth(word + " "); 
      }
      // CASE: word does not fit on current line; need to move to next line
      else {
          // set w to a width that will break the while loop
          textX = width;
          // set wrap boolean to true
          wrap = true;
      }
      // update wordIdx to move on to next word
      wordIdx += 1;
    }
    // at this point, we finished one line and need to move to the next line
    textY += (h3 + m);
  }
  wrap = false;
}

// describes and draws the game instruction page
void displayInstructions() {
  background(white);
  
  // display header
  fill(darkBlue);
  textSize(h1);
  textAlign(CENTER,BOTTOM);
  text("Game Instructions",width/2,150);
  
  // display legend of objects
  fill(medBlue);
  textSize(h2);
  textAlign(LEFT,TOP);
  rectMode(CENTER);
  text("Game Objects",width/2,240,800,80);
  
  // define col1 and row1 to align the text for objects
  int col1 = 120;
  int row1 = 230;
  float space = (h3 + (2.5*m));
  
  // TODO: change the game objects to the ones we will be using
  // draw game objects
  textAlign(LEFT,CENTER);
  // user object
  // TODO: create and display the enemy object here. write it around the position (col1, row1+space)
  
  fill(medBlue);
  textSize(h3);
  text("You, the player",col1+space,row1+space);
  // enemy object
  // TODO: create and display the enemy object here. write it around the position (col1, row1+(2*space))
  
  textAlign(LEFT,CENTER);
  fill(medBlue);
  textSize(h3);
  text("Bugs, be sure to avoid them!",col1+space,row1+(2*space));
  // coin object
  // TODO: create and display the coin object here. write it around the position (col1, row1+(3*space))
  
  textAlign(LEFT,CENTER);
  fill(medBlue);
  textSize(h3);
  text("Coins, collect by moving player over them!",col1+space,row1+(3*space));
  
  // display key strokes to move
  fill(medBlue);
  textSize(h2);
  textAlign(LEFT,TOP);
  rectMode(CENTER);
  text("How to Move",width/2,470,800,80);
  
  // update reference points for the keys
  col1 -= 15;
  row1 = 470;
  int col2 = width/2;
  int row2 = row1 + 80;
  int spaceX = 120;
  int spaceY = 15;
  
  // draw key stroke moves
  textAlign(LEFT,BOTTOM);
  textSize(h3);
  // up arrow
  pushMatrix();
  translate(col1,row1+spaceY);  
  drawArrowKeys(0);
  popMatrix();
  fill(medBlue);
  text("move player up",col1+spaceX,row1+(5*spaceY));
  // down arrow
  pushMatrix();
  translate(col1,row2+spaceY);  
  drawArrowKeys(2);
  popMatrix();
  fill(medBlue);
  text("move player down",col1+spaceX,row2+(5*spaceY));
  // left arrow
  pushMatrix();
  translate(col2,row1+spaceY);  
  drawArrowKeys(1);
  popMatrix();
  fill(medBlue);
  text("move player left",col2+spaceX,row1+(5*spaceY));
  // right arrow
  pushMatrix();
  translate(col2,row2+spaceY);  
  drawArrowKeys(3);
  popMatrix();
  fill(medBlue);
  text("move player right",col2+spaceX,row2+(5*spaceY));
  
  // display instructions to move to next page
  fill(gray);
  textSize(h4);
  textAlign(CENTER,TOP);
  rectMode(CENTER);
  // allow text to blink
  blinkText("Are you ready? Press any key to begin your venture outside.",width/2,height-50,800,80, textOff, textOn);
}

// describes and draws the Level Introduction page
void displayLevelIntroduction() {
  background(white);
  
  // display header
  fill(darkBlue);
  textSize(h1);
  textAlign(CENTER,BOTTOM);
  // TODO: once game is created, uncomment next line
  //text("Level " + game.level,width/2,(height/2)-150);
  text("Level #",width/2,300);
  
  // display countdown clock
  fill(medBlue);
  textSize(h2);
  textAlign(CENTER,BOTTOM);
  levelCountdown.checkActivation(millis());
  text("Starting in ..." + levelCountdown.secondsLeft(),width/2,350);
  
  // the game is on level intro and has a timer that counts down to start, once timer runs out, move to next page
  if (levelCountdown.checkActivation(millis())) {
    currPage = page[4];
    // update the play countdown
    playCountdown.reset(millis());
  }
}

// describes and draws the level page
void displayLevel() {
  background(white);
  
  // TODO: once game and level classes completed, run necessary calls to play the game in space below
  
  
  
  
  // TODO: run check that if all lives are lost, need to set currPage = page[5];
  
}

// describes and draws the Summary
void displaySummary() {
  background(white);
  // display header
  fill(darkBlue);
  textSize(h1);
  textAlign(CENTER,BOTTOM);
  text("Game Summary",width/2,150);
  
  // display comment on whether user won or lost
  fill(medBlue);
  textSize(h3);
  textAlign(CENTER,TOP);
  rectMode(CENTER);
  if (game.isPlayerAlive()) {
    text("Oh no :( Looks like you died trying to collect coins.",width/2,240,800,80);
  }
  else {
    text("Congrats on venturing out and getting back safely!",width/2,240,800,80);
  }

  // define columns to keep track of text placement
  int col1 = width/2-300;
  int col2 = width/2;
  int col3 = width/2+300;
  // define rows to keep track of text placement
  int row = 280;
  
  // display subheaders
  fill(medBlue);
  textSize(h2);
  textAlign(CENTER,BOTTOM);
  text("Total Coins Collected",col1,row);
  text("Lives Left",col2,row);
  text("Score",col3,row);
  
  
  // get and display player stats
  int[] playerStats = game.getPlayerStats();
  fill(medBlue);
  textSize(h3);
  textAlign(CENTER,BOTTOM);
  text(playerStats[0], col1, row+50);
  text(playerStats[1], col2, row+50);
  text(game.getPlayerScore(), col3, row+50);
  
  // display instructions to move to next page, which is the scoreboard, or back to the home page
  fill(gray);
  textSize(h4);
  textAlign(CENTER,TOP);
  // allow text to blink
  blinkText("Press 'TAB' to return to home page or 'ENTER' to view scoreboard.",width/2,height-50,800,80, textOff, textOn);
}

// describes and draws out the UserName page, which prompts user to choose a username and save their score
void displayCreateUsername() {
  background(white);
  // display header
  fill(darkBlue);
  textSize(h1);
  textAlign(CENTER,BOTTOM);
  text("Create a Username",width/2,150);
  
  // display instructions for username
  fill(medBlue);
  textSize(h3);
  textAlign(CENTER,TOP);
  rectMode(CENTER);
  text("Make it creative! You can only use 20 characters max.",width/2,240,800,80);
  
  // draw the line that shows under the username being typed
  stroke(gray);
  line(width/2-330, height/2, width/2+330, height/2);
  
  // display the typing text
  textAlign(CENTER, BOTTOM);
  textSize(h2);
  fill(darkBlue);
  text(typing,width/2,height/2);
  
  // display instructions to move to save username or go back to home page
  fill(gray);
  textSize(h4);
  textAlign(CENTER,TOP);
  // allow text to blink
  blinkText("Press 'ENTER' to save username 'TAB' to return to home page.",width/2,height-50,800,80, textOff, textOn);
}

// describes and draws out the Scoreboard page
void displayScoreboard() {
  background(white);
  // display header
  fill(darkBlue);
  textSize(h1);
  textAlign(CENTER,BOTTOM);
  text("Scoreboard",width/2,150);
  
  // define columns to keep track of text placement
  int col1 = width/2-300;
  int col2 = width/2;
  int col3 = width/2+300;
  // define rows to keep track of text placement
  int row = 240;
  
  // display subheaders
  fill(medBlue);
  textSize(h2);
  textAlign(CENTER,BOTTOM);
  text("Place",col1,row);
  text("Username",col2,row);
  text("Score",col3,row);
  
  String[] places = {"1st", "2nd", "3rd", "4th", "5th"};
  
  //TODO: write out the scoreboard text to this page
  // display the top 5 scores to the scoreboard
  fill(medBlue);
  textSize(h3);
  textAlign(CENTER,BOTTOM);
  IntDict scores = readScoreboardTextFile();
  // get the usernames and scores in individual lists
  String[] k = scores.keyArray();
  int[] v = scores.valueArray();
  for (int i=0; i<min(scores.size(), 5); i++) {
    row += 50;
    text(places[i], col1, row);
    text(k[i], col2, row);
    text(v[i], col3, row);
  }
  
  // display instructions to move to home page
  fill(gray);
  textSize(h4);
  textAlign(CENTER,TOP);
  // allow text to blink
  blinkText("Press 'TAB' to return to home page.",width/2,height-50,800,80, textOff, textOn);
}

// function will read the scoreboard text file
IntDict readScoreboardTextFile() {
  // read in the scoreboard text file
  String[] lines = loadStrings("scoreboard.txt");
  // initialize list to hold username and score as a dictionary
  IntDict scores = new IntDict();
  for (int i=0; i < lines.length; i++) {
    String[] record = split(lines[i], '\t');
    scores.set(record[0], parseInt(record[1]));
  }
  // sort the dictionary in descending order
  scores.sortValuesReverse();
  return scores;
}

// draws the game menu
// includes pause/continue, restart, or end and go back to welcome page
// menu is drawn in lower 100 pixels of the screen
void drawOptionsMenu() {
  rectMode(CORNERS);
  fill(lightGray);
  noStroke();
  rect(0,height-100,width,height);
  
  // button to pause/continue
  if (isPaused) {
    bCont.update(mouseX, mouseY);
    bPause.update(0,0); // move mouse for pause button out of bounds so hover is off
    bCont.display();
  } else {
    bPause.update(mouseX, mouseY);
    bCont.update(0,0); // move mouse for cont button out of bounds so hover is off
    bPause.display();
  }
  // button to restart from level 1
  bRestart.update(mouseX, mouseY);
  bRestart.display();
  // button to go back to welcome page
  bEnd.changePosition((3*width/4), height-50);
  bEnd.update(mouseX, mouseY);
  bEnd.display();
}

// draws the user info menu
// includes time left in level, points, and lives left
// menu is drawn in upper 100 pixels of the screen
void drawUserMenu() {
  // background bar
  rectMode(CORNERS);
  fill(darkBlue);
  noStroke();
  rect(0,0,width,100);
  // update colors and text alignment/size
  textAlign(CENTER,BOTTOM);
  rectMode(CENTER);
  stroke(white);
  fill(white);
  textSize(h4);
  // level
  text("Current Level", width/4, 30);
  rect(width/4, 60, 150, 50, 10);
  // coins gained
  text("Value Collected", 2*(width/4), 30);
  rect(2*(width/4), 60, 150, 50, 10);
  // time left in level
  text("Time to Next Level", 3*(width/4), 30);
  rect(3*(width/4), 60, 165, 50, 10);
  
  // add user information
  textAlign(CENTER,CENTER);
  textSize(h2);
  fill(medBlue);
  // TODO: after game class is done, update lives displayed and lives remaining 
  // TODO: (aka delete next 3 lines and uncomment the 3 lines following that)
  text("#",width/4,55); 
  text("#",2*(width/4),55); 
  if (playCountdown.secondsLeft() == 1) {
    text(playCountdown.secondsLeft() + " sec",3*(width/4),55);
  } else {
    text(playCountdown.secondsLeft() + " secs",3*(width/4),55);
  }
  // TODO: example code to be called once game class is completed
  //text(game.getLevel(),width/5,55);
  //text(game.user.getLivesLeft(),2*(width/5),55);
  //text(game.user.getPoints(),3*(width/5),55;)
}

// function allows text to appear as tho it is blinking
void blinkText(String s, int start, int stop, float x, float y, Timer off, Timer on) {
  // text is shown for the duration of "on" and not shown for the duration of "off"
  if (off.checkActivation(millis())) {
    text(s,start,stop,x,y);
  } else {
    on.reset(millis());
  }
  // once the duration of the text being "on" has been met, reset the timer to be "off"
  if (on.checkActivation(millis())) {
    off.reset(millis());
  }
}

// function draws the four arrow keys, passing in which one should be highlighted (0: up, 1: left, 2: down, 3: right)
// takes up a space of 100 wide and 65 height with each key about 30 pixels height/width
void drawArrowKeys(int k) {
  color highlighted = medBlue;
  color norm = black;
  int w = 100;
  int h = 65;

  // using a PVector to note position of each arrow
  PVector upArrow = new PVector(3*(w/6), h/4);
  PVector leftArrow = new PVector(w/6, 3*(h/4));
  PVector downArrow = new PVector(3*(w/6), 3*(h/4));
  PVector rightArrow = new PVector(5*(w/6), 3*(h/4));
  PVector[] arrows = {upArrow, leftArrow, downArrow, rightArrow};

  for (int i=0; i<arrows.length; i++) {
    rectMode(RADIUS);
    // draw square with curved corners
    if (k == i) {
      stroke(highlighted);
      fill(highlighted);
    } else {
      stroke(norm);
      fill(norm);
    }
    rect(arrows[i].x, arrows[i].y, 15, 15, 10);
    pushMatrix();
    translate(arrows[i].x, arrows[i].y);
    rotate(i*(-PI/2));
    fill(white);
    arrow();
    popMatrix();
  }
}

// outline the arrow shape for the arrow key image
void arrow() {
  fill(white);
  beginShape();
  vertex(0, -10);
  vertex(10, 10);
  vertex(0, 5);
  vertex(-10, 10);
  endShape(CLOSE);
}

void keyPressed() {
  // CASE: user is on welcome page
  // if on the welcome page, any key allows user to move to next page, which is the background
  if (currPage == page[0] && keyPressed) {
    currPage = page[1];
  }
  // CASE: user is on the background page
  // if on the background page, any key allows user to move to next page, which is the game instructions
  else if (currPage == page[1] && keyPressed) {
    currPage = page[2];
  }
  // CASE: user is on the game instructions page
  // if on the game instructions page, any key allows user to move to next page, which is the level intro
  else if (currPage == page[2] && keyPressed) {
    currPage = page[3];
    // TODO: instantiate a new game
    game = new Game();
    // reset the level countdown
    levelCountdown.reset(millis());
  }
  // CASE: user is on the game page
  else if (currPage == page[4]) {
      // TODO: define keystrokes that allow player to move
      
  }
  // CASE: user is on the summary page
  // if on the summary page, user has options on what to do 
  else if (currPage == page[5]) {
    // if user presses 'ENTER', move to next page, which is the enter user name
    if (key == '\n') {
      currPage = page[6];
    }
    // if user presses 'TAB', go back to the home page
    else if (key == TAB) {
      currPage = page[0];
    }
  }
  // CASE: user is on the scoreboard page
  // if on the summary page, user has options on what to do 
  else if (currPage == page[6]) {
    // if user presses 'TAB', go back to the home page
    if (key == TAB) {
      typing = "";
      currPage = page[0];
    }
    // if user presses 'ENTER' button, save the username
    else if (key == '\n') {
      // save the user names
      savedUserName = typing;
      typing = "";
      // move to next page
      currPage = page[7];
      // save the username to the scoreboard file
      // TODO: delete next line and uncomment one following it to display true score
      scoreboard.println(savedUserName + "\t" + "SCORE #");
      //scoreboard.println(savedUserName + "\t" + game.getPlayerScore());
      scoreboard.flush();
    }
    // other keys go into writing out the user's username
    // delete last character typed if user presses BACKSPACE
    else if (key == BACKSPACE) {
        // can only remove a character typing variable is populated
        if (typing != "") {
          typing = typing.substring(0, typing.length()-1);
      }
    }
    // ignore shift key if pressed
    else if (key == CODED && keyCode == SHIFT) {
    } 
    // add any other key pressed to the typing variable
    else {
      // make sure that the username is less than 25 characters
      if (typing.length() < 20) {
        typing += key;
      }
    }
  }
  // CASE: user is on the scoreboard page
  // if on the scoreboard page, 'TAB' allows user to go back to the home page
  else if (currPage == page[7] && key == TAB) {
    currPage = page[0];
  }
}

// action on buttons occur when mouse is pressed over the button
void mousePressed() {
  if (isPaused) {
    // user sees button to continue game
    if (bCont.isSelected()) {
      bCont.isSelected();
      isPaused = false;
      playCountdown.cont();
    }
  } else {
    // user sees button to pause game
    if (bPause.isSelected()) {
      bPause.isSelected();
      isPaused = true;
      playCountdown.pause();
    }
  }
  if (bRestart.isSelected()) {
    bRestart.isSelected();
    // TODO: instantiate a new game
    game = new Game();
    currPage = page[3];
    levelCountdown.reset(millis());
  } 
  if (bEnd.isSelected()) {
    bEnd.isSelected();
    currPage = page[0];
  }
}

// reset buttons when mouse is released
void mouseReleased() {
  bPause.isReleased();
  bCont.isReleased();
  bRestart.isReleased();
  bEnd.isReleased();
}
