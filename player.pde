
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
    c.t = 0.0;
    c.p = 0.0;
    
    s = 50.0;
    cs = 0.07;
    
    st.p.set(0, g.map.scl*(g.map.o.y()-g.map.s.y()), 0);
    
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
    Vect gd = new Vect();
    gd.set_pc(c.t, c.p, c.l);
    
    Vect dx = new Vect(), dy = new Vect();
    
    dx.set_pc(0, c.p-HALF_PI, 1);
    dy.set_pc(c.t+HALF_PI, c.p, 1);
                                      
    dx.mul(mouseX-width/2);
    dy.mul(mouseY-height/2);
    
    Vect pos = st.p.copy().add(1, -st.h*.8);
    pos.add(gd).add(dx).add(dy);
    
    g.gra.pg.pushMatrix();
    g.gra.pg.translate(pos.x(), pos.y(), pos.z());
    g.gra.pg.stroke(0);g.gra.pg.fill(0);
    g.gra.pg.sphere(5);
    g.gra.pg.popMatrix();
    
  }
  
  void cam() {
    c.cam();
  }
  
  void mu() {st.mp(c.p, s);}
  void md() {st.mp(c.p+PI, s);}
  void mr() {st.mp(c.p-HALF_PI, s);}
  void ml() {st.mp(c.p+HALF_PI, s);}
  
  void jump() {
    if(st.gr)st.a.add(1, -80.0);
  }
  
}

class Chara {
  Game g;
  Vect p, v, a;
  float h; // hight
  float gms;
  boolean gr;
  
  Chara(Game g) {
    this.g = g;
    h = 160;
    p = new Vect();
    v = new Vect();
    a = new Vect();
    gr = false;
    
    gms = 9.8;
  }
  
  void update() {
    v.add(a);
    
    IVec m = g.map.gp(p), m_ = g.map.gp(p.copy().add(v));
    g.debug(p.show()+"\n"+m.show());
    
    gr=false;
    if(g.map.is_pass( m.copy().set(0, m_.x()) ))p.add(0, v.x());
    if(g.map.is_pass( m.copy().set(1, m_.y()) ) && m_.y()>=0)p.add(1, v.y());
    else gr=true;
    if(g.map.is_pass( m.copy().set(2, m_.z()) ))p.add(2, v.z());
    
    v.set();
    
    if(gr)a.set(1, 0);
    else a.add(1, gms);
  }
  
  void move(float mx, float my, float mz) {
    v.add(new Vect(mx, my, mz));
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
    Vect pos = pl.st.p.copy();
    pos.add(1, -pl.st.h*.8);
    
    Vect gd = new Vect(); // gaze direction
    pl.g.debug(t+", "+p+", "+l);
    gd.set_pc(t, p, l).add(pos);
    
    pl.g.gra.cam(pos, gd, this.c_up());
    
  }
  
  Vect c_up() {
    return (new Vect(0, 1, 0));
  }
  
  void mu(float s) {if(t>0.05-HALF_PI)t-=s;}
  void md(float s) {if(t<HALF_PI-0.05)t+=s;}
  void mr(float s) {p-=s;if(p<PI)p+=TWO_PI;}
  void ml(float s) {p+=s;if(p>PI)p-=TWO_PI;}
  
}

class Vect {
  int n=3;
  float[] a;
  
  Vect() {
    a = new float[n];
    for(int i=0;i<n;i++)a[i]=0;
  }
  
  Vect(float[] b) {
    a = new float[n];
    for(int i=0;i<n;i++)a[i]=b[i];
  }
  
  Vect(float x, float y, float z) {
    a = new float[n];
    a[0] = x;
    a[1] = y;
    a[2] = z;
  }
  
  float x() {return a[0];}
  float y() {return a[1];}
  float z() {return a[2];}
  
  Vect copy() {
    return (new Vect(this.a));
  }
  
  Vect set(int i, float v) {a[i]=v;return this;}
  Vect set() {for(int i=0;i<n;i++)a[i]=0;return this;}
  Vect set(float v) {for(int i=0;i<n;i++)a[i]=v;return this;}
  Vect set(Vect v) {for(int i=0;i<n;i++)a[i]=v.a[i];return this;}
  Vect set(float x,float y,float z) {a[0]=x;a[1]=y;a[2]=z;return this;}
  
  Vect add(int i, float v) {a[i]+=v;return this;}
  Vect add(float v) {for(int i=0;i<n;i++)a[i]+=v;return this;}
  Vect add(Vect v) {for(int i=0;i<n;i++)a[i]+=v.a[i];return this;}
  
  Vect mul(int i, float v) {a[i]*=v;return this;}
  Vect mul(float v) {for(int i=0;i<n;i++)a[i]*=v;return this;}
  Vect mul(Vect v) {for(int i=0;i<n;i++)a[i]*=v.a[i];return this;}
  
  Vect set_pc(float t, float p, float l) {
    return this.set(l*cos(t)*sin(p), l*sin(t), l*cos(t)*cos(p));
  }
  
  float dot(Vect v){
    float r=0;
    for(int i=0;i<n;i++)r+=this.a[i]+v.a[i];
    return r;
  }
  
  Vect cross(Vect v) {
    Vect r = new Vect();
    r.set(0, this.a[1]*v.a[2]-this.a[2]*v.a[1]);
    r.set(1, this.a[2]*v.a[0]-this.a[0]*v.a[2]);
    r.set(2, this.a[0]*v.a[1]-this.a[1]*v.a[0]);
    return r;
  }
  
  float magsq() {
    return sqrt(this.dot(this));
  }
  
  Vect normalize() {
    return this.mul(1/this.magsq());
  }
  
  String show() {
    return ("("+this.x()+", "+this.y()+", "+this.z()+")");
  }
  
}