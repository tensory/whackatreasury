import org.json.*;

class Game {
  int gameID;
  String playerName = "";
  boolean active = false;
  int totalHits;
  int treasurySize;
  int successfulHits;
  boolean listingRequestSent = false;
  boolean ready = false;
  long timeInPlay;
  
  Listing curListing;
  Stack listings = new Stack();
  
  int imageSize = 60; // Size of image rectangle
  
  Game(int id) {
    gameID = id;
    active = true;
    totalHits = 0;
    successfulHits = 0;
    treasurySize = 3;
    ready = false;
    timeInPlay = millis();
  }
  
  void loadListings(JSONArray listings) {
    try {
      for (int j = 0; j < listings.length(); j++) {
        JSONObject listing = (JSONObject)listings.get(j); 
        
        String id = listing.get("listing_id").toString();
        this.listings.push(new Listing(Integer.parseInt(id))); // change this to initialize images differently
      }
      this.ready = true; // game is ready!
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  
  void setNextListing() {
    curListing = (Listing)listings.pop();
  }
  
  boolean isReady() {
    return this.ready;
  }
  
  void setRequestSent(boolean wasSent) {
    this.listingRequestSent = wasSent;
  }
  
  void updateGameTime() {
    this.timeInPlay = millis();
  }
}

