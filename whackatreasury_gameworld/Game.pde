import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.io.IOException;

class Game {
  int gameID;
  boolean active = false;
  int totalHits;
  int successfulHits;
  int treasurySize;
  
  Listing curListing;
  Stack listings = new Stack();
  
  int imageSize = 60; // Size of image rectangle
  
  Game(int id) {
    gameID = id;
    active = true;
    totalHits = 0;
    successfulHits = 0;
    treasurySize = 0;
    
    // Load images asynchronously at init
    this.loadListings();
    
    // set up first listing for game
    if (listings.size() > 0 ) {
      this.curListing = (Listing)listings.pop();
      println("loaded game " + this.gameID); // Game is ready to go
    }
  }
  
  // Show an image from the 
  void displayImage(int originX, int originY) {
    stroke(0, 0, 255);
    rect(originX, originY, imageSize, imageSize); 
  }
  
  // Look through file system for image cache
  void loadListings() {
    BufferedReader reader = null;
    String absPath = "/Users/alacenski/Documents/Projects/whackatreasury/whackatreasury_gameworld/data/";
    File file = new File(absPath + this.gameID + "/source.csv");
    
    String line = "";
    
    // Open the source file
    try {
      // Currently the file reader expects a line pattern like:
      // listingID,localfileID
      
      reader = new BufferedReader(new FileReader(file));
      // As long as there are lines in the file, 
      // load up images from the filenames
      while ((line = reader.readLine()) != null) {
        
        if (line.length() > 0) { // if line is not blank
          String[] vals;
          // Split the string by ','
          vals = line.split(",");
          
          // Initialize Listing here and add it to array of listing images
          int id = Integer.parseInt(vals[0]);
          PImage i = loadImage(absPath + this.gameID + "/" + vals[1] + ".gif");
          
          listings.push(new Listing(id, i));
        } // end if (not blank)
      } // end while
    } catch (FileNotFoundException e) {
      e.printStackTrace(); // Show display error
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
  
  void drawImage() {
/*
    PImage img = (PImage)imgs.get(0);
    image(img, 20, 20);
    */
  }
  
  void setNextListing() {
    curListing = (Listing)listings.pop();
  }
}
