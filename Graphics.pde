
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
  
  void cam(Vect e, Vect c, Vect u) {
    pg.camera(
    e.x(), e.y(), e.z(), 
    c.x(), c.y(), c.z(), 
    u.x(), u.y(), u.z());
  }
  
  void draw() {
    image(pg, 0, 0);
  }
  
}