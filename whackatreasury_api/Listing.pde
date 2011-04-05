class Listing {
  private int listingID;
  private PImage img; // Prevent image from being overwritten
  
  Listing (int id, PImage p) {
    listingID = id;
    img = p;
  }
 
  PImage getImage() {
    return img;
  }
 
 int getListingID() {
    return listingID;
 } 
}
