import http.requests.*;

void setup() {
  JSONObject json;
  GetRequest get = new GetRequest("http://192.168.1.118:8080/api/neurobrainget/");

  get.addHeader("Accept", "application/json");
  get.send();
  println(get.getContent());
  
  json = loadJSONObject((get.getContent()));
  JSONArray items = json.getJSONArray("obj");
  JSONObject firstItem = items.getJSONObject(0);
  println(firstItem);

}