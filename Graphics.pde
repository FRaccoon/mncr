
class Graphics {
  Game g;
  PGraphics pg;
  
  Graphics(Game g) {
    this.g = g;
    pg = createGraphics(width, height, P3D);
    
  }
  
  void update() {
  }
  
  void beginDraw() {
    pg.beginDraw();
    pg.background(128, 255, 255);
  }
  
  void endDraw() {
    pg.endDraw();
  }
  
  void draw() {
    image(pg, 0, 0);
  }
  
}