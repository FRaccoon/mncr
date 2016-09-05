
class Game {
  Data data;
  Graphics gra;
  Player pl;
  Map map;
  Keys keys;
  
  boolean d; //debug
  int fc; //frameCount
  
  Game() {
    d = true;
    fc = 0;
    
    data = new Data(this);
    gra = new Graphics(this);
    
    keys = new Keys(this);
    
    map = new Map(this);
    pl = new Player(this);
    
  }
  
  void loop() {
    fc++;
    this.update();
    this.draw();
  }
  
  void update() {
    map.update();
    pl.update();
    this.debug("frameRate: "+frameRate);
  }
  
  void draw() {
    //lights();
    if(true) {
      gra.beginDraw();
      pl.cam();
      map.draw();
      gra.endDraw();
    }
    gra.draw();
    pl.draw();
  }
  
  void debug(String str) {
    if(this.d)println(str);
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