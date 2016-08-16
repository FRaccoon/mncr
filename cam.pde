
class Cam {
  Game g;
  float cd, ct, cp;
  float l, cl, gms;
  float cx, cy, cz;
  float v;
  boolean j; // jump
  
  Cam(Game g) {
    this.g = g;
    cd = (height/2.0) / tan(PI*30.0 / 180.0);
    ct = 0.4;
    cp = PI;
    
    l = 50.0;
    cl = 0.07;
    gms = 9.8;
    
    cx = 0;
    cy = g.map.s*(g.map.oy-g.map.sy);
    cz = 0;
    
    v = 0;
    j = true;
    
  }
  
  void update() {
    
    if(g.keys.ku)this.mu();
    if(g.keys.kd)this.md();
    if(g.keys.kl)this.ml();
    if(g.keys.kr)this.mr();
    
    if(g.keys.sk('w'))this.cmu();
    if(g.keys.sk('s'))this.cmd();
    if(g.keys.sk('a'))this.cml();
    if(g.keys.sk('d'))this.cmr();
    if(g.keys.ks)this.jmp();
    
    v += gms;
    int x = g.map.gpx(cx),y = g.map.gpy(cy),z = g.map.gpz(cz);
    if(g.d)println("("+x+", "+y+", "+z+")");
    if(y<0) {
      cy = g.map.oy*g.map.s+1;
      j = true;
    }else if(!g.map.is_pass(x, y, z) && v>0) {
      while(!g.map.is_pass(x, y, z)) {
        y++;
      }
      cy = g.map.s*(g.map.oy-y)+1;
      v = 0;
      j = true;
    }else {
      cy += v;
      
    }
    
  }
  
  void draw() {
    tint(255, 255, 255);
    int x = g.map.gpx(cx),y = g.map.gpy(cy),z = g.map.gpz(cz);
    if(g.map.is_area(x, y, z))g.map.drawBlock(x, y, z);
    noTint();
  }
  
  void cam() {
    float cy_ = cy - 100;
    camera(
    cx, cy_, cz, 
    cx + cd * cos(ct) * sin(cp),
    cy_ + cd * sin(ct),
    cz + cd * cos(ct) * cos(cp),
    0, 1, 0);
  }
  
  void mu() {
    cx += l * sin(cp);
    cz += l * cos(cp);
  }
  
  void md() {
    cx -= l * sin(cp);
    cz -= l * cos(cp);
  }
  
  void mr() {
    cx += l * sin(cp-HALF_PI);
    cz += l * cos(cp-HALF_PI);
  }
  
  void ml() {
    cx += l * sin(cp+HALF_PI);
    cz += l * cos(cp+HALF_PI);
  }
  
  void cmu() {
    if(ct>-HALF_PI+0.05)ct -= cl;
  }
  
  void cmd() {
    if(ct<HALF_PI-0.05)ct += cl;
  }
  
  void cmr() {
    cp -= cl;
  }
  
  void cml() {
    cp += cl;
  }
  
  void jmp() {
    if(j) {
      v -= 80.0;
      j = false;
    }
  }
  
}