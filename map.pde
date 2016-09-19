
class Map {
  Game g;
  
  IVec o, s;
  int scl;
  int l; //view area
  
  IVec[] d = new IVec[6];
  
  
  Block[][][] t; //terrain
  
  Map(Game g) {
    this.g = g;
    
    o = new IVec(-30, 5, -30);
    s = new IVec(60, 10, 60);
    
    d[0]=new IVec( 1, 0, 0);d[1]=new IVec( 0, 1, 0);d[2]=new IVec( 0, 0, 1);
    d[3]=new IVec( 0, 0,-1);d[4]=new IVec( 0,-1, 0);d[5]=new IVec(-1, 0, 0);
    
    scl = 100;
    l = 32;
    
    t = new Block[s.x()][s.y()][s.z()];
    
    for(int i = 0; i < s.x(); i++) {
      for(int j = 0; j < s.z(); j++) {
        for(int k = 0; k < s.y(); k++) {
          t[i][k][j] = new Block(this);
        }
      }
    }
    
    this.gen_terrain();
    
  }
  
  void update() {
  }
  
  void draw() {
    for(int i = -l; i < l; i++) {
      for(int j = -l; j < l; j++) {
        for(int k = -l; k < l; k++) {
          this.drawBlock(gp(g.pl.st.p).add(new IVec(i, k, j)));
        }
      }
    }
  }
  
  void del_terrain() {
    for(int i = 0; i < s.x(); i++) {
      for(int j = 0; j < s.z(); j++) {
        for(int k = 0; k < s.y(); k++) {
          t[i][k][j].reset();
        }
      }
    }
    
  }
  
  void gen_terrain() {
    this.del_terrain();
    if(g.d) {
      for(int i = 0; i < s.x(); i++) {
        for(int j = 0; j < s.z(); j++) {
         int h = (int)(noise(i * 0.1, j * 0.1) * s.y());
          for(int k = 0; k < h; k++) {
            this.set_block( new IVec(i, k, j), int(random( g.data.num() )) );
          }
        }
      }
    }else {
      for(int i = 0; i < s.x(); i++) {
        for(int j = 0; j < s.z(); j++) {
         int h = (int)(noise(i * 0.1, j * 0.1) * (s.y()-1));
          for(int k = 0; k < h; k++) {
            this.set_block( new IVec(i, k, j), 3 );
          }
          this.set_block( new IVec(i, h, j), 4 );
        }
      }
    }
  }
  
  boolean is_area(IVec v) {
    return ((0<=v.x() && v.x()<s.x()) && (0<=v.y() && v.y()<s.y()) && (0<=v.z() && v.z()<s.z()));
  }
  
  Block get_block(IVec v) {
    if(this.is_area(v))return t[v.x()][v.y()][v.z()];
    else return null;
  }
  
  void set_block(IVec v, int id) {
    Block b = this.get_block(v);
    if(b==null)return ;
    b.id = id;
    boolean op = this.is_opac(v);
    for(int i=0;i<6;i++) {
      IVec r = v.copy().add(d[i]);
      this.set_surface_opac( v, i, !this.is_opac(r) );
      if(op) {
        this.set_surface_opac(r, 5-i, !op);
      }
    }
  }
  
  void set_surface_opac(IVec v, int i, boolean d) {
    Block b = this.get_block(v);
    if(b!=null)b.d[i] = d;
  }
  
  boolean is_opac(IVec v) {
    Block b = this.get_block(v);
    if(b==null)return false;
    else return g.data.is_opac(b.id);
  }
  
  boolean is_pass(IVec v) {
    Block b = this.get_block(v);
    if(b==null)return true;
    else return g.data.is_pass(b.id);
  }
  
  IVec gp(Vect v) {
    return (new IVec( this.gpx(v.x()), this.gpy(v.y()), this.gpz(v.z()) ));
  }
  
  int gpx(float x) {
    int p = int(x/scl);
    p -= o.x();
    if(x<0)p-=1;
    return p;
  }
  
  int gpy(float y) {
    int p = int(-y/scl);
    p += o.y();
    if(y>0)p-=1;
    return p;
  }
  
  int gpz(float z) {
    int p = int(z/scl);
    p -= o.z();
    if(z<0)p-=1;
    return p;
  }
  
  void drawBlock(IVec v) {
    Block b = this.get_block(v);
    if(b==null)return ;
    g.gra.pg.pushMatrix();
    
    g.gra.pg.scale(scl);
    g.gra.pg.translate(o.x()+v.x(), o.y()-v.y(), o.z()+v.z());
    g.data.draw_block(b);
    
    g.gra.pg.popMatrix();
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

class IVec {
  int n=3;
  int[] a;
  
  IVec() {
    a = new int[n];
    for(int i=0;i<n;i++)a[i]=0;
  }
  
  IVec(int[] b) {
    a = new int[n];
    for(int i=0;i<n;i++)a[i]=b[i];
  }
  
  IVec(int x, int y, int z) {
    a = new int[n];
    a[0] = x;
    a[1] = y;
    a[2] = z;
  }
  
  int x() {return a[0];}
  int y() {return a[1];}
  int z() {return a[2];}
  
  IVec copy() {
    return (new IVec(this.a));
  }
  
  IVec set(int i, int v) {a[i]=v;return this;}
  IVec set() {for(int i=0;i<n;i++)a[i]=0;return this;}
  IVec set(IVec v) {for(int i=0;i<n;i++)a[i]=v.a[i];return this;}
  IVec set(int x,int y,int z) {a[0]=x;a[1]=y;a[2]=z;return this;}
  
  IVec add(int i, int v) {a[i]+=v;return this;}
  IVec add(int v) {for(int i=0;i<n;i++)a[i]+=v;return this;}
  IVec add(IVec v) {for(int i=0;i<n;i++)a[i]+=v.a[i];return this;}
  
  IVec mul(int i, float v) {a[i]*=v;return this;}
  IVec mul(int v) {for(int i=0;i<n;i++)a[i]*=v;return this;}
  IVec mul(IVec v) {for(int i=0;i<n;i++)a[i]*=v.a[i];return this;}
  
  String show() {
    return ("("+this.x()+", "+this.y()+", "+this.z()+")");
  }
  
}