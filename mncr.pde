
Game game;

void setup() {
  size(640, 480, P3D);
  
  game = new Game();
}

void draw() {
  background(128, 255, 255);
  
  game.update();
  game.draw();
}

void keyPressed() {
  game.keyPressed();
}

void keyReleased() {
  game.keyReleased();
}

void mousePressed() {
  game.mousePressed();
}

void mouseReleased() {
  game.mouseReleased();
}