
class Keys {
  Game g;
  boolean[] sk, lk; // small_key, large_key
  boolean sp, ku, kd, kr, kl; // space, up, down, right, left
  boolean md; // mouse_drag
  
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
    
    sp = false;
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
      g.debug("press: keyCode");
      switch(keyCode) {
        case UP:ku=f;break;
        case DOWN:kd=f;break;
        case LEFT:kl=f;break;
        case RIGHT:kr=f;break;
      }
    }else {
      g.debug("press: '"+key+"'");
      if(key==' ')sp=f;
      else if('a'<=key && key<='z')sk[key-'a']=f;
      else if('A'<=key && key<='Z')lk[key-'A']=f;
    }
  }
  
  void keyReleased() {
    boolean f=false;
    if(key==CODED) {
      g.debug("release: keyCode");
      switch(keyCode) {
        case UP:ku=f;break;
        case DOWN:kd=f;break;
        case LEFT:kl=f;break;
        case RIGHT:kr=f;break;
      }
    }else {
      g.debug("release: "+key);
      if(key==' ')sp=f;
      else if('a'<=key && key<='z')sk[key-'a']=f;
      else if('A'<=key && key<='Z')lk[key-'A']=f;
    }
  }
  
  void mousePressed() {
    md=true;
  }
  
  void mouseReleased() {
    md=false;
  }
  
}