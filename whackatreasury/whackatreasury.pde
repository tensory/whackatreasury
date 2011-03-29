/* Image drawing vars */
char imgW, imgH;
char offset = 40;

int imgCount = 4; // number of inputs to choose from
int treasurySize = 12;

int numHits = 0; // number of successful hits (clicks)

/* Image selecting vars */
int[] imgIDsToDisplay = new int[imgCount];
PImage[] imgs = new PImage[imgCount];

// Keeps track of loaded images (true or false)
boolean[] loadStates = new boolean[imgCount];

int[] outputIDs = new int[treasurySize];

void setup() {
  size(400, 400);  
  // Set image dimensions
  imgW = 48;
  imgH = 48;
  
  //initialize imgIDsToDisplay with 0, 1, 2...
  for (int i = 0; i < imgCount; i++) {
    imgIDsToDisplay[i] = i;
  }
  
  //open file stream for source file -- LATER. For now, just mock the object
 
 
  //what you need is a mapping between array positions (0, 1, 2, 3) and temporary IDs (3,4,5,6)
  
   // Load first group of images asynchronously
  loadImages();
}





void draw() {  
  /* image loading and drawing */
  for (int i = 0; i < imgs.length; i++){
    // Check if individual images are fully loaded
    if ((imgs[i].width != 0) && (imgs[i].width != -1)){
      // As images are loaded set true in boolean array
      loadStates[i] = true;
    }
  }
  // When all images are loaded draw them to the screen
  if (checkLoadStates()){
    drawImages();
  }
  

}

// this will eventually become the handler for serial input
void mouseClicked() {
  // eventually 
  numHits++;
  
  // get random id of image index
  // unset image from array
  // so, undraw it
  print(getRandomInputValue());
  // call output script to put the image in the treasury
  
  // when clicked, undraw element
  //imgs[index] = new PImage();
  updateImgIDsToDisplay(numHits);
  
  for (int i = 0; i < imgCount; i++) {
    print(imgIDsToDisplay[i] + " ");
  }
  print("\n");
  
  loadImages();
}

void drawImages() {
  // draw rows
    // draw columns
    int offsetX;
    
    for (int i = 0; i < imgs.length; i++) {
      offsetX = (i * (offset + imgW)) + offset; 
      image(imgs[i], offsetX, offset, imgW, imgH);
    }
}

// Return true when all images are loaded - no false values left in array 
boolean checkLoadStates(){
  for (int i = 0; i < imgs.length; i++){
    if (loadStates[i] == false){
      return false;
    } 
  }
  return true;
}

int getRandomInputValue() {
  return int(random(0, 3));
}

void updateImgIDsToDisplay(int hits) {
  for (int i = 0; i < imgCount; i++) {
    imgIDsToDisplay[i] = (i + (hits * imgCount));
  } 
}

void loadImages() {
  /*
  for (int i = 0; i < imgCount; i++) {
    if ((i + 1) <= treasurySize) {  
      imgs[i] = loadImage((imgIDsToDisplay[i] + 1) + ".gif");
    } else {
      // remove 
    }
  }
  */
  
 
}

class ListingImage {
  int listingID; // ex: 3423453
  char sourceID; // ex: 1 (input pillow #2)
  String localFilename;
  
  ListingImage(int listing, char source) {
    listingID = listing;
    sourceID = source;
  }
}
