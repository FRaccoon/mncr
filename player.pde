
class Player {
  Game g;
  Chara st;
  Cam c;
  float s, cs; // speed, cam_speed
  
  Player(Game g) {
    this.g = g;
    st = new Chara(g);
    c = new Cam(this);
    
    c.l = (height/2.0) / tan(PI*30.0 / 180.0);
    c.t = 0.4;
    c.p = PI;
    
    s = 50.0;
    cs = 0.07;
    
    st.x = 0;
    st.y = g.map.s*(g.map.oy-g.map.sy);
    st.z = 0;
    
  }
  
  void update() {
    if(g.keys.ku)this.mu();
    if(g.keys.kd)this.md();
    if(g.keys.kl)this.ml();
    if(g.keys.kr)this.mr();
    
    if(g.keys.sk('w'))c.mu(cs);
    if(g.keys.sk('s'))c.md(cs);
    if(g.keys.sk('a'))c.ml(cs);
    if(g.keys.sk('d'))c.mr(cs);
    
    if(g.keys.sp)this.jump();
    
    st.update();
    
  }
  
  void draw() {
    int r = 10;
    noStroke();
    fill(255, 0, 0);
    ellipse(mouseX, mouseY, r, r);
  }
  
  void cam() {
    c.cam();
  }
  
  void mu() {st.mp(c.p, s);}
  void md() {st.mp(c.p+PI, s);}
  void mr() {st.mp(c.p-HALF_PI, s);}
  void ml() {st.mp(c.p+HALF_PI, s);}
  
  void jump() {
    if(st.gr)st.ay -= 80.0;
  }
  
}

class Chara {
  Game g;
  float x, y, z;
  float h; // hight
  float vx, vy, vz;
  float ax, ay, az;
  float gms;
  boolean gr;
  
  Chara(Game g) {
    this.g = g;
    x = 0; y = 0; z = 0;
    h = 160;
    vx = 0; vy = 0; vz = 0;
    ax = 0; ay = 0; az = 0;
    gr = false;
    
    gms = 9.8;
  }
  
  void update() {
    vx += ax;
    vy += ay;
    vz += az;
    
    int mx = g.map.gpx(x), my = g.map.gpy(y), mz = g.map.gpz(z);
    g.debug("("+mx+", "+my+", "+mz+")");
    
    int mx_ = g.map.gpx(x+vx), my_ = g.map.gpy(y+vy), mz_ = g.map.gpz(z+vz);
    
    gr=false;
    if(g.map.is_pass(mx_, my, mz))x+=vx;
    if(g.map.is_pass(mx, my_, mz) && my_>=0)y+=vy;
    else gr=true;
    if(g.map.is_pass(mx, my, mz_))z+=vz;
    
    vx = 0;
    vy = 0;
    vz = 0;
    
    if(gr)ay=0;
    else ay += gms;
  }
  
  void move(float mx, float my, float mz) {
    vx += mx;
    vy += my;
    vz += mz;
  }
  
  void mp(float p, float s) { // move by polar coord
    this.move(s*sin(p), 0, s*cos(p));
  }
  
  void draw() {
    
  }
  
}

class Cam {
  Player pl;
  float l, t, p; // len, theta, phi
  
  Cam(Player pl) {
    this.pl = pl;
    l = 0;
    t = 0;
    p = 0;
  }
  
  void cam() {
    float x = pl.st.x, y = pl.st.y - pl.st.h*.8, z = pl.st.z;
    pl.g.gra.pg.camera(
    x, y, z, 
    x+l*cos(t)*sin(p),
    y+l*sin(t),
    z+l*cos(t)*cos(p),
    0, 1, 0);
  }
  
  void mu(float s) {if(t>-HALF_PI+0.05)t -= s;}
  void md(float s) {if(t<HALF_PI-0.05)t += s;}
  void mr(float s) {p -= s;}
  void ml(float s) {p += s;}
  
}