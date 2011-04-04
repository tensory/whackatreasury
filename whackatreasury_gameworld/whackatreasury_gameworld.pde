// This is the number of the game that we're currently on. It should be provided by the server connection.
int gameCount;
// The current game in progress
Game g;

// x and y coord possibilities
Coord[] origins = new Coord[9];
int offset = 60;

// Treasury size goal
int treasurySize = 12;
// Time limit to display current image (in msec)
int timeLimit = 5000;
int timer = timeLimit;

void setup() {
  frameRate(1);
  size(500, 500);
  
  // start with game 0
  g = new Game(0);

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
  
}

void draw() {
  background(200);
  Coord curPos = origins[(int)random(0, 8)];
  renderImage(curPos);
  
  delay(4000);
  
  
    
  
  
  
  
  
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
  while (timer > 0) {
    g.displayImage((pos.x * 10) + offset, (pos.y * 10) + offset);
    timer--;    
  }
  // Reset timer
  timer = timeLimit;
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

  int imageSize = 10; // Size of image rectangle
  
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



