import simpleML.*;
import org.json.*;
import java.util.Map;

// initrequest: initialize the game
HTMLRequest startGameRequest, findAllGamesRequest, listRequest;


// Game world variables
int gameID = 0;
int lastGameID = 0;




int startTime;     // for the timer to make request ever N seconds
String source = "";  // String to hold data from request
int counter = 0;   // Counter to animate rectangle across window
color back = color(0, 255, 100);    // Background brightness

void setup() {
  size(400,400);
  background(0);
  
  // Create and make an asynchronous request
//  initRequest = new HTMLRequest(this,"http://api.alacenski.ny4dev.etsy.com/v2/makerfaire/");
  startGameRequest = new HTMLRequest(this,"http://api.alacenski.ny4dev.etsy.com/v2/makerfaire/games/?method=POST&theme=kittens&player=1");
  
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
     
       
      
      // initialize new game
    } else { // still playing the same game
      println("playing game");
    }
  } // if game id is set
  
  
  
  /*
  
  // Every 5 seconds, make a new request
  int now = millis();
  if (now - startTime > 5000) {
    htmlRequest.makeRequest();
    println("Making request!");
    startTime = now;
  }

  // Draw some lines with colors based on characters from data retrieved
  for (int i = 0; i < width; i++) {
    if (i < html.length()) {
      int c = html.charAt(i);
      stroke(c,150);
      line(i,0,i,height);
    }
  }

  // Animate rectangle and dim rectangle
  fill(255);
  noStroke();
  rect(counter,0,10,height);
  counter = (counter + 1) % width;
  back = constrain(back - 1,0,255);
  */
  
}

void mousePressed() {
    startGameRequest.makeRequest();
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
    if (method.equals("startGame")) { // get a game ID to initialize the new game
      // set game ID
      // required to start game
      println("yes");
      JSONObject result = (JSONObject)results.get(0);
      String id = result.get("game_id").toString();
      gameID = Integer.parseInt(id);
    }     
  } catch (JSONException e) {
    e.printStackTrace();
  }
  
  
  /*
    HELL OF OLD PARSER CODE
    JSONObject response = new JSONObject(source);
    JSONArray results = response.getJSONArray("results");
    ArrayList resultData = new ArrayList();
    /*
    println(results);
    for(int i = 0; i < results.length(); i++) {
      JSONObject result = (JSONObject)results.get(i);
      println(result.get("create_date"));
    }
    //String[] data = new String[(results.length())];
    // read out returned data

    for (int i = 0; i < response.length(); i++) {
      JSONObject o = (JSONObject)response.get("results);
      data[i] = o.getString();
    }

    String type = (String)response.get("type"); 
    //String method = (String)response.get("api_method"); 
    String method = "foo";
    
    // Make assignments for game state based on response
    // TODO: MAKE SURE THESE ARE RESET ELSEWHERE
    /*
    if (method == "startGame") {
      for(int i = 0; i < results.length(); i++) {
        JSONObject result = (JSONObject)results.get(i);
        println(result.get("create_date"));
      }
    }
    */
    /*
    switch(type) {
      case "MakerFaire_Game" :
        println(results.size());
        break;
      default : 
        println("no type");
        break;
    }
    
    println(type);
    
  } catch (JSONException e) {
    e.printStackTrace();
  }
  */
}

class MakerFaire_Game {
  int create_date, game_id, update_date;
  
  MakerFaire_Game(int cDate, int gID, int uDate) {
    create_date = cDate;
    game_id = gID;
    update_date = uDate;
  }
}
