import simpleML.*;
import org.json.*;
import java.util.Map;

// initrequest: initialize the game
HTMLRequest findAllGamesRequest, listRequest;


// Game world variables
Game g;
int gameID = 0;
int lastGameID = 0;
Coord[] origins = new Coord[9];
 // Set up origins of rectangles on the board   

boolean endImageDisplay = false;


int startTime;     // for the timer to make request ever N seconds
String source = "";
color back = color(0, 255, 100);    // Background brightness

void setup() {
  size(400,400);
  background(0);
  
  // set up target origins
  origins[0] = new Coord(0, 0);
  origins[1] = new Coord(1, 0);
  origins[2] = new Coord(2, 0);
  origins[3] = new Coord(0, 1);
  origins[4] = new Coord(1, 1);
  origins[5] = new Coord(2, 1);
  origins[6] = new Coord(0, 2);
  origins[7] = new Coord(1, 2);
  origins[8] = new Coord(2, 2);
  
  // Create and make an asynchronous request
  // set up request types
  findAllGamesRequest = new HTMLRequest(this,"http://api.alacenski.ny4dev.etsy.com/v2/makerfaire/games?status=ready&limit=1");
  // set up the animation world
 /* int gameID = ???;
  if (gameID) {
    // initialize the game
    Game g = new Game(gameID);
  }
  */
}

void draw() {
  // Fill background
  background(back);
  
  // if game state ID is set
  if (gameID > 0) {    
    if (gameID != lastGameID) {
      // if game is new
      // should this run during the endgame state or at init?
      lastGameID = gameID; // get this out of the way
      g = new Game(gameID); // start that game up
       
      
      // initialize new game
    } else { // still playing the same game
      // run the game
      
      print("game is running");
      
      
      
      // endgame state lives here
      // endgame: make API requests to start a game
    }
  } // if game id is set
}

void keyPressed() {
    findAllGamesRequest.makeRequest();
    println("requested");
}

// When a request is finished
void netEvent(HTMLRequest ml) {
  source = ml.readRawSource();  // Read the raw data
  println(source);
  //Parse response for type, get data out
  try {
    JSONObject response = new JSONObject(source);
    JSONArray results = response.getJSONArray("results");
    String method = (String)response.get("api_method");

    // set game state based on method called
    /*
    if (method.equals("startGame")) { // get a game ID to initialize the new game
      // set game ID
      // required to start game
      JSONObject result = (JSONObject)results.get(0);
      String id = result.get("game_id").toString();
      gameID = Integer.parseInt(id);
    }
    */
    if (method.equals("findAllGames")) { // get a game ID to initialize the new game
      // set game ID
      // required to start game
      JSONObject jsonGame = (JSONObject)results.get(0);
      String id = jsonGame.get("game_id").toString();
      gameID = Integer.parseInt(id);
    }
      
  } catch (JSONException e) {
    e.printStackTrace();
  }
}
