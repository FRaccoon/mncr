
class Gui {
  Game g;
  
  Gui(Game g) {
    this.g = g;
  }
  
  void update() {
  }
  
  void draw_gui() {
    float r = 10;
    if(g.d) {
      stroke(0);
      line(0, height/2, width, height/2);
      line(width/2, 0, width/2, height);
    }
    noStroke();fill(255, 0, 0);
    ellipse(mouseX, mouseY, r, r);
  }
  
}