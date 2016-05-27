import http.requests.*;

JSONObject items1;
JSONObject item1;
JSONObject items2;
JSONObject item2;
JSONObject items3;
JSONObject item3;
JSONArray json;
int n = 0;
int y = 20;
int xvals;
float attention;
float meditation;
float delta;
float theta;
float theta2;
float theta3;
float alpha;
float beta;
float gamma;
float gamma2;
float gamma3;
float height_ratio;
String time;

void drawLines(float raw, float raw2, float raw3, int n, int lineColor) {
  
  float raw_remapped = map(raw, 0, 500000, 0, displayHeight);
  float raw2_remapped = map(raw2, 0, 500000, 0, displayHeight);
  float raw3_remapped = map(raw2, 0, 500000, 0, displayHeight);
  
  stroke(lineColor);
  strokeWeight(1);
        
  if (raw < 500000) {
    line((displayWidth/(n-1)) * 2, raw2_remapped, (displayWidth/n) * 2, raw_remapped);
  }
  else {
    line((displayWidth/(n-1)) * 2, raw2_remapped, (displayWidth/n+3) * 2, raw3_remapped);
  }  
        
}

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
      
      items2 = json.getJSONObject(n-1); 
      item2 = items2.getJSONObject("obj");
      
      items3 = json.getJSONObject(n+1); 
      item3 = items3.getJSONObject("obj");
    
      time = items1.getString("key");
      attention = Float.parseFloat(item1.getString("attention"));
      meditation = Float.parseFloat(item1.getString("meditation"));
      delta = Float.parseFloat(item1.getString("delta"));
      theta = Float.parseFloat(item1.getString("theta"));
      theta2 = Float.parseFloat(item2.getString("theta"));
      theta3 = Float.parseFloat(item3.getString("theta"));
      alpha = Float.parseFloat(item1.getString("alpha"));
      beta = Float.parseFloat(item1.getString("beta"));
      gamma = Float.parseFloat(item1.getString("gamma"));
      gamma2 = Float.parseFloat(item2.getString("gamma"));
      gamma3 = Float.parseFloat(item3.getString("gamma"));
    
      drawLines(gamma, gamma2, gamma3, n, #AF5C5C);
      drawLines(theta, theta2, theta3, n, #333CD3);
      //println(xvals * (n-1) + ", " + alpha2 + ", " + xvals * n + ", " + alpha1);
    
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
    n++;
    

    
}