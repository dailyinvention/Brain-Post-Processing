import http.requests.*;

JSONObject items1;
JSONObject item1;
JSONObject items2;
JSONObject item2;
JSONArray json;
int n = 0;
int y = 20;
int xvals;
float attention;
float meditation;
float delta;
float theta;
float alpha;
float beta;
float gamma;
float gamma_new;
float height_ratio;
String time;

void setup() {
  size(800, 600);
  //frameRate(1);

  background(#ffffff);
  GetRequest get = new GetRequest("http://192.168.1.118:8080/api/neurobrainget/");

  get.addHeader("Accept", "application/json");
  get.send();
  println(get.getContent());
  
  json = parseJSONArray(get.getContent());

}

void draw() {
  
    if (n < json.size() - 1) { 
      if(n-1 > 0) {
        
      items1 = json.getJSONObject(n); 
      item1 = items1.getJSONObject("obj");
    
      time = items1.getString("key");
      attention = Float.parseFloat(item1.getString("attention"));
      meditation = Float.parseFloat(item1.getString("meditation"));
      delta = Float.parseFloat(item1.getString("delta"));
      theta = Float.parseFloat(item1.getString("theta"));
      alpha = Float.parseFloat(item1.getString("alpha"));
      beta = Float.parseFloat(item1.getString("beta"));
      gamma = Float.parseFloat(item1.getString("gamma"));
    
      
      //println(xvals * (n-1) + ", " + alpha2 + ", " + xvals * n + ", " + alpha1);
    
      println("\nTime:" + time);
      println("Attention:" + attention);
      println("Meditation:" + meditation);
      println("Delta:" + delta);
      println("Theta:" + theta);
      println("Alpha:" + alpha);
      println("Beta:" + beta);
      println("Gamma:" + gamma);
      
      if ((gamma < 500000) || (theta < 500000)) {
        float gamma_remapped = map(gamma, 0, 500000, 0, displayHeight);
        float theta_remapped = map(theta, 0, 500000, 0, displayHeight);
        println("Gamma Scaled: " + gamma_remapped);
        stroke(0);
        strokeWeight(4);
        point(displayWidth/n, gamma_remapped);
        
        stroke(#E81A1A);
        strokeWeight(4);
        point((displayWidth/n) * 2, theta_remapped);
      }  
      }
    }
    n++;
    

    
}