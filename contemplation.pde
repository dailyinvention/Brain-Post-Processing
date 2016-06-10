import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import http.requests.*;


HColorPool colors;
HDrawablePool pool;
HTimer timer;
HSwarm swarm;
int i=0;
HCanvas canvas;

JSONObject items1;
JSONObject item1;
JSONObject items2;
JSONObject item2;
JSONObject items3;
JSONObject item3;
JSONObject items4;
JSONObject item4;
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
float gamma4;
float height_ratio;
String time;

void drawLines(float raw, float raw2, float raw3, float raw4, int n, int lineColor) {
  
  float raw_remapped = map(raw, 0, 500000, 0, displayHeight);
  float raw2_remapped = map(raw2, 0, 500000, 0, displayHeight);

  /*
  stroke(lineColor);
  strokeWeight(1);
        
 if (raw < 500000) {
    line((displayWidth/(n-1)) * 2, raw2_remapped, (displayWidth/n) * 2, raw_remapped);
  }
  else {
    line((displayWidth/(n-1)) * 2, raw2_remapped, (displayWidth/n+3) * 2, raw3_remapped);
  }
  */
  /*
  println(raw + ',' + raw2 + ',' + raw3);
  fill(lineColor, 50);
  beginShape();
  vertex(raw_remapped,raw2_remapped);
  vertex(raw2_remapped,raw3_remapped);
  vertex(raw3_remapped,raw4_remapped);
  vertex(raw_remapped,raw2_remapped);
  endShape();
  */
  swarm.addGoal(raw_remapped,raw2_remapped); 
  
  //bezier(raw_remapped, 100, raw2_remapped, 100, raw3_remapped, 100, 100, 50);
 
}

void setup() {
  size(800, 600);
  //frameRate(1);

  background(#000000);
  
  H.init(this).background(#000000);
  smooth();

  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

  canvas = new HCanvas().autoClear(false).fade(40);
  H.add(canvas);

  swarm = new HSwarm()
    .speed(4)
    .turnEase(0.1f)
    .twitch(15)
    .idleGoal(width/2,height/2)
  ;

  pool = new HDrawablePool(10);
  pool.autoAddToStage()
    .add (
      new HRect(10).rounding(5)
    )

    .onCreate (
      new HCallback() {
        public void run(Object obj) {
          final HDrawable d = (HDrawable) obj;
          d
            .strokeWeight(2)
            .stroke(#ECECEC)
            .fill( #111111 )
            .loc( (int)random(100,540), (int)random(100,540) )
            .anchorAt( H.CENTER )
            .rotation(45)
          ;

          final HTween tween = new HTween()
            .target(d).property(H.LOCATION)
            .start(d.x(), d.y())
            .end((int)random(width), (int)random(height))
            .ease(0.01).spring(0.9)
          ;

          final HCallback onAnim = new HCallback() {
            public void run(Object obj) {
              tween
                .start(d.x(), d.y())
                .end( (int)random(100,540), (int)random(100,540) )
                .ease(0.01)
                .spring(0.9)
                .register()
              ;
            }
          };

          timer = new HTimer().interval(2000).callback(onAnim);
        }
      }
    )

    .requestAll();

}

void draw() {
       
        
      swarm.addTarget(
      canvas.add(
        new HRect(2,2)
        .rounding(4)
        .anchorAt( H.CENTER )
        .noStroke()
        .fill(colors.getColor())
      )
      );
      
      H.drawStage();
      
      GetRequest get = new GetRequest("http://192.168.1.118:8080/api/neurobrainget/");

      get.addHeader("Accept", "application/json");
      get.send();
      println(get.getContent());
  
if (n < json.size() - 1) { 
   if(n-1 > 0) {
        
      json = parseJSONArray(get.getContent());
        
      items1 = json.getJSONObject(n); 
      item1 = items1.getJSONObject("obj");
      
      items2 = json.getJSONObject(n-1); 
      item2 = items2.getJSONObject("obj");
      
    
      time = items1.getString("key");
      attention = Float.parseFloat(item1.getString("attention"));
      meditation = Float.parseFloat(item1.getString("meditation"));
      delta = Float.parseFloat(item1.getString("delta"));
      theta = Float.parseFloat(item1.getString("theta"));
      theta2 = Float.parseFloat(item2.getString("theta"));
      alpha = Float.parseFloat(item1.getString("alpha"));
      beta = Float.parseFloat(item1.getString("beta"));
      gamma = Float.parseFloat(item1.getString("gamma"));
      gamma2 = Float.parseFloat(item2.getString("gamma"));

 
      drawLines(gamma, gamma2, gamma3, gamma4, n, #AF5C5C);
 
      }
    }
    n++;
    

    
}