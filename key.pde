
class Keys {
  Game g;
  boolean[] sk, lk; // small_key, large_key
  boolean ks, ku, kd, kr, kl; // space, up, down, right, left
  boolean md;
  
  Keys(Game g) {
    this.g = g;
    
    sk = new boolean[26];
    lk = new boolean[26];
    
  }
  
  void reset() {
    for(int i=0;i<26;i++) {
      sk[i] = false;
      lk[i] = false;
    }
    
    ks = false;
    ku = false;
    kd = false;
    kr = false;
    kl = false;
    
  }
  
  boolean sk(char k) {
    return this.sk[k-'a'];
  }
  
  boolean lk(char k) {
    return this.lk[k-'A'];
  }
  
  void keyPressed() {
    boolean f=true;
    if(key==CODED) {
      if(g.d)println("press: keyCode");
      switch(keyCode) {
        case UP:ku=f;break;
        case DOWN:kd=f;break;
        case LEFT:kl=f;break;
        case RIGHT:kr=f;break;
      }
    }else {
      if(g.d)println("press: "+key);
      if(key==' ')ks=f;
      else if('a'<=key && key<='z')sk[key-'a']=f;
      else if('A'<=key && key<='Z')lk[key-'A']=f;
    }
  }
  
  void keyReleased() {
    boolean f=false;
    if(key==CODED) {
      if(g.d)println("release: keyCode");
      switch(keyCode) {
        case UP:ku=f;break;
        case DOWN:kd=f;break;
        case LEFT:kl=f;break;
        case RIGHT:kr=f;break;
      }
    }else {
      if(g.d)println("release: "+key);
      if(key==' ')ks=f;
      else if('a'<=key && key<='z')sk[key-'a']=f;
      else if('A'<=key && key<='Z')lk[key-'A']=f;
    }
  }
  
  void mousePressed() {
    
  }
  
  void mouseReleased() {
    
  }
  
}