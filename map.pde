
class Map {
  Game g;
  
  int ox, oy, oz;
  int sx, sy, sz;
  int s;
  
  int[][] d = {
    { 1, 0, 0}, { 0, 1, 0}, { 0, 0, 1},
    { 0, 0,-1}, { 0,-1, 0}, {-1, 0, 0}
  };
  
  Block[][][] t; //terrain
  
  Map(Game g) {
    this.g = g;
    
    ox = -30;
    oy = 10;
    oz = -30;
    
    sx = 60;
    sy = 10;
    sz = 60;
    
    s = 100;
    
    t = new Block[sx][sy][sz];
    
    for(int i = 0; i < sx; i++) {
      for(int j = 0; j < sz; j++) {
        for(int k = 0; k < sy; k++) {
          t[i][k][j] = new Block(this);
        }
      }
    }
    
    this.gen_terrain();
    
  }
  
  void draw() {
    for(int i = 0; i < sx; i++) {
      for(int j = 0; j < sz; j++) {
        for(int k = 0; k < sy; k++) {
          this.drawBlock(i, k, j);
        }
      }
    }
  }
  
  void del_terrain() {
    for(int i = 0; i < sx; i++) {
      for(int j = 0; j < sz; j++) {
        for(int k = 0; k < sy; k++) {
          t[i][k][j].reset();
        }
      }
    }
    
  }
  
  void gen_terrain() {
    this.del_terrain();
    for(int i = 0; i < sx; i++) {
      for(int j = 0; j < sz; j++) {
        int h = (int)(noise(i * 0.1, j * 0.1) * sy);
        for(int k = 0; k < h; k++) {
          this.set_block(i, k, j, int(random(2)));
        }
      }
    }
    
  }
  
  boolean is_area(int x, int y, int z) {
    return ((0<=x && x<sx) && (0<=y && y<sy) && (0<=z && z<sz));
  }
  
  Block get_block(int x, int y, int z) {
    if(this.is_area(x, y, z))return t[x][y][z];
    else return null;
  }
  
  void set_block(int x, int y, int z, int id) {
    if(!this.is_area(x, y, z))return;
    t[x][y][z].id = id;
    for(int i=0;i<6;i++) {
      this.set_surface_opac(x, y, z, i, !this.is_opac(x+d[i][0], y+d[i][1], z+d[i][2]));
      this.set_surface_opac(x+d[i][0], y+d[i][1], z+d[i][2], 5-i, !this.is_opac(x, y, z));
    }
  }
  
  void set_surface_opac(int x, int y, int z, int i, boolean d) {
    if(this.is_area(x, y, z))t[x][y][z].d[i] = d;
  }
  
  boolean is_opac(int x, int y, int z) {
    if(this.is_area(x, y, z)) {
      return g.data.is_opac(t[x][y][z].id);
    }else {
      return false;
    }
  }
  
  boolean is_pass(int x, int y, int z) {
    if(this.is_area(x, y, z)) {
      return g.data.is_pass(t[x][y][z].id);
    }else {
      return true;
    }
  }
  
  int gpx(float x) {
    int p = int(x/s);
    p -= ox;
    if(x<0)p-=1;
    return p;
  }
  
  int gpy(float y) {
    int p = int(-y/s);
    p += oy;
    if(y>0)p-=1;
    return p;
  }
  
  int gpz(float z) {
    int p = int(z/s);
    p -= oz;
    if(z<0)p-=1;
    return p;
  }
  
  void drawBlock(int x, int y, int z) {
    pushMatrix();
    
    scale(s);
    translate(ox+x, oy-y, oz+z);
    g.data.draw_block(t[x][y][z]);
    
    popMatrix();
  }
  
}

class Block {
  Map m;
  int id;
  boolean[] d = new boolean[6];
  
  Block(Map m) {
    this.m = m;
    this.reset();
  }
  
  void reset() {
    id = -1;
    for(int i=0;i<6;i++)d[i] = true;
  }
  
}
