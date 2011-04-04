// This is the number of the game that we're currently on. It should be provided by the server connection.
int gameCount;
// The current game in progress
Game g;
Coord curPos;
ListingImage curListing;

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
  g = new Game(1);
  timer = new Timer(1000); // display image for one second
  curPos = origins[(int)random(0, 8)];
  timer.start();
}

void draw() {

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
    renderImage(curPos, curListing);
  } else {
    curPos = origins[(int)random(0, 8)];
    curListing = g.getNextListing();
    
    //println("done");
    // todo: figure out how to end 
    
    
    timer.start();
  }
    
  /*
  // Endgame condition: start a new one
  if (false) { // actual condition: if current game has completed a treasury
    // request next game ID from the server
    int nextGameID = 1;
    if (nextGameID > g.gameID) {
      g = new Game(nextGameID);
    }
  }
  */
}

void renderImage(Coord pos) {  
  int offsetX = (pos.x * 5 * offset) + offset;
  int offsetY = (pos.y * 5 * offset) + offset;
  //println("Running at " + pos.x + ", " + pos.y);
  stroke(0, 100, 255);
  // get next image from 
  
  // need a PImage here
  
  //rect(offsetX, offsetY, 20, 20); 

  
} 

/*
void mousePressed() {
  g.drawImage();
}
*/
// Whenever there is a serial event, compare it with the state of the current game
