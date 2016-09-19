
class Game {
  Data data;
  Graphics gra;
  Gui gui;
  Keys keys;
  Map map;
  Player pl;
  
  boolean d; //debug
  int fc; //frameCount
  
  Game() {
    d = true;
    fc = 0;
    
    data = new Data(this);
    gra = new Graphics(this);
    gui = new Gui(this);
    
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
    gra.beginDraw();
    pl.cam();
    pl.draw();
    map.draw();
    gra.endDraw();
    
    gra.draw();
    gui.draw_gui();
    
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