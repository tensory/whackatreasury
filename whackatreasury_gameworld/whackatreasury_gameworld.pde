// This is the number of the game that we're currently on. It should be provided by the server connection.
int gameCount;
// The current game in progress
Game g;
Coord curPos;

// x and y coord possibilities
Coord[] origins = new Coord[9];
int offset = 30;

// Timing image display
Timer timer;
boolean endImageDisplay = false;

// Treasury size goal
int treasurySize = 12;

int iterations;
void setup() {
  size(500, 500);
  frameRate(3);
  
  // Set up origins of rectangles on the board   
  origins[0] = new Coord(0, 0);
  origins[1] = new Coord(1, 0);
  origins[2] = new Coord(2, 0);
  origins[3] = new Coord(0, 1);
  origins[4] = new Coord(1, 1);
  origins[5] = new Coord(2, 1);
  origins[6] = new Coord(0, 2);
  origins[7] = new Coord(1, 2);
  origins[8] = new Coord(2, 2);

  // start with game 0
  g = new Game(0);
  timer = new Timer(1000); // display image for one second
  curPos = origins[(int)random(0, 8)];
  
  timer.start();
}

void draw() {
  //delay(3000);
  background(0, 255, 0);
  stroke(0);
  fill(40);
  for (int i = 0; i < 9; i++) {
    Coord coord = origins[i];
    int offsetX = (coord.x * 5 * offset) + offset;
    int offsetY = (coord.y * 5 * offset) + offset;
    rect(offsetX, offsetY, 60, 60);
  }
  
  fill(255);
  
 
  if (!timer.isFinished()) {
    renderImage(curPos);
  } else {
    curPos = origins[(int)random(0, 8)];
    println("done");
    timer.start();
  }
    
  
  // Endgame condition: start a new one
  if (false) { // actual condition: if current game has completed a treasury
    // request next game ID from the server
    int nextGameID = 1;
    if (nextGameID > g.gameID) {
      g = new Game(nextGameID);
    }
  }
  
  
}

void renderImage(Coord pos) {  
  int offsetX = (pos.x * 5 * offset) + offset;
  int offsetY = (pos.y * 5 * offset) + offset;
  println("Running at " + pos.x + ", " + pos.y);
  //while (timer > 0) {   
  stroke(0, 100, 255);
  rect(offsetX, offsetY, 20, 20); 

    //g.displayImage(offsetX, offsetY);
  
} 


void mousePressed() {
}

// Whenever there is a serial event, compare it with the state of the current game


class Game {
  int gameID;
  boolean active = false;
  int totalHits;
  int successfulHits;
  int treasurySize;

  int imageSize = 60; // Size of image rectangle
  
  Game(int id) {
    gameID = id;
    active = true;
    totalHits = 0;
    successfulHits = 0;
    treasurySize = 0;
  }
  
  // Show an image from the 
  void displayImage(int originX, int originY) {
    stroke(0, 0, 255);
    rect(originX, originY, imageSize, imageSize); 
  }  
}

class Coord {
  int x, y;
  
  Coord(int ix, int iy) {
    x = ix;
    y = iy;
  }
}

class Timer{
  int savedTime; //when timer started
  int totalTime; // how long timer should last
  boolean finished;
  Timer (int tempTotalTime){
    totalTime = tempTotalTime;
    finished=false;
  }
 
  //Starting the timer
  void start(){
    if(endImageDisplay == false)
    savedTime = millis(); //when the timer starts it stores the current time in milliseconds
  }
  void reset() {
    savedTime=0; 
  }
 
 boolean isFinished(){
   //Check how much time has passed
   int passedTime = millis() - savedTime;
   if(passedTime > totalTime){
     finished = true;
     return true;
   } else{
     finished = false;
     return false;
   }
 } 
}



