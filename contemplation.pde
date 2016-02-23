import http.requests.*;

void setup() {
  size(200, 200);
  frameRate(1);
}

void draw() {
  JSONArray json;
  GetRequest get = new GetRequest("http://192.168.1.118:8080/api/neurobrainget/");

  get.addHeader("Accept", "application/json");
  get.send();
  println(get.getContent());
  
  json = parseJSONArray(get.getContent());
  
  for (int i = 0; i < json.size(); i++) {
    
    JSONObject items = json.getJSONObject(i); 
    
    JSONObject item = items.getJSONObject("obj");
    
    String time = items.getString("key");
    String attention = item.getString("attention");
    String meditation = item.getString("meditation");
    String delta = item.getString("delta");
    String theta = item.getString("theta");
    String alpha = item.getString("alpha");
    String beta = item.getString("beta");
    String gamma = item.getString("gamma");

    println("\nTime:" + time);
    println("Attention:" + attention);
    println("Meditation:" + meditation);
    println("Delta:" + delta);
    println("Theta:" + theta);
    println("Alpha:" + alpha);
    println("Beta:" + beta);
    println("Gamma:" + gamma);
  }

}