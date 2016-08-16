
class Game {
  Cam cam;
  Map map;
  Data data;
  Keys keys;
  
  boolean d;
  
  Game() {
    d = true;
    data = new Data(this);
    map = new Map(this);
    cam = new Cam(this);
    keys = new Keys(this);
    
  }
  
  void update() {
    cam.update();
    cam.cam();
  }
  
  void draw() {
    //lights();
    map.draw();
    if(d)cam.draw();
  }
  
  void keyPressed() {
    keys.keyPressed();
  }
  
  void keyReleased() {
    keys.keyReleased();
  }
  
  void mousePressed() {
    keys.mousePressed();
    
  }
  
  void mouseReleased() {
    keys.mouseReleased();
    
  }
  
}