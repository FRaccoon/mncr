
Game game;

void setup() {
  size(640, 480, P2D);
  game = new Game();
}

void draw() {
  background(0);
  game.loop();
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