
class Data {
  Game g;
  
  BlockData[] bd;
  
  Data(Game g) {
    this.g = g;
    
    this.load_blocks();
  }
  
  void load_blocks() {
    XML xml;
    if(g.d)xml = loadXML("./debug_data/obj_data.xml");
    else xml = loadXML("./data/obj_data.xml");
    
    XML[] block = xml.getChildren("block");
    bd = new BlockData[block.length];
    for(int i=0;i<block.length;i++)bd[i] = new BlockData(block[i]);
    
  }
  
  boolean is_id(int id) {
    return (!(id<0) && id<bd.length);
  }
  
  void draw_block(Block b) {
    if(is_id(b.id))bd[b.id].draw(b.d);
  }
  
  boolean is_opac(int id) {
    if(is_id(id)) {
      return bd[id].o;
    }else return false;
  }
  
  boolean is_pass(int id) {
    if(is_id(id)) {
      return bd[id].p;
    }else return true;
  }
  
}

class BlockData {
  String name;
  Box box;
  boolean o, p; // opacity, pass
  
  BlockData(XML xml) {
    box = new Box();
    this.set_block(xml);
  }
  
  void set_block(XML xml) {
    name = xml.getString("name");
    o = (xml.getInt("opacity")>0); //almost true
    p = (xml.getInt("pass")>0); //almost false
    XML[] texture = xml.getChildren("texture");
    int[] t = {-1,-1,-1,-1,-1,-1,0};
    for(int i=0;i<texture.length;i++) {
      String d = texture[i].getString("direction");
      switch(d.charAt(0)) {
        case 'r':t[0]=i;break;
        case 'u':t[1]=i;break;
        case 'f':t[2]=i;break;
        case 'b':t[3]=i;break;
        case 'd':t[4]=i;break;
        case 'l':t[5]=i;break;
        default:t[6]=i;break;
      }
    }
    for(int i=0;i<6;i++) {
        String src = texture[t[i]<0?t[6]:t[i]].getString("src");
        PImage img = loadImage(src);
        box.set_surface(i, img);
    }
  }
  
  void draw(boolean[] d) {
    box.draw(d);
  }
  
}

class Box {
  PShape[] s; // surface
  
  Box() {
    s = new PShape[6];
  }
  
  void set_surface(int i, PImage texture) {
    int w = texture.width, h = texture.height;
    s[i] = createShape();
    s[i].beginShape(QUADS);
    s[i].noStroke();
    s[i].noFill();
    s[i].texture(texture);
    switch(i) {
      case 1: //up
        s[i].vertex(0, 0, 0, 0, 0);
        s[i].vertex(1, 0, 0, w, 0);
        s[i].vertex(1, 0, 1, w, h);
        s[i].vertex(0, 0, 1, 0, h);
      break;
      case 2: //front
        s[i].vertex(0, 0, 1, 0, 0);
        s[i].vertex(1, 0, 1, w, 0);
        s[i].vertex(1, 1, 1, w, h);
        s[i].vertex(0, 1, 1, 0, h);
      break;
      case 3: //behind
        s[i].vertex(1, 0, 0, 0, 0);
        s[i].vertex(0, 0, 0, w, 0);
        s[i].vertex(0, 1, 0, w, h);
        s[i].vertex(1, 1, 0, 0, h);
      break;
      case 4: // down
        s[i].vertex(1, 1, 0, 0, 0);
        s[i].vertex(0, 1, 0, w, 0);
        s[i].vertex(0, 1, 1, w, h);
        s[i].vertex(1, 1, 1, 0, h);
      break;
      case 5: //left
        s[i].vertex(0, 0, 0, 0, 0);
        s[i].vertex(0, 0, 1, w, 0);
        s[i].vertex(0, 1, 1, w, h);
        s[i].vertex(0, 1, 0, 0, h);
      break;
      default: // case 0: (right)
        s[i].vertex(1, 0, 1, 0, 0);
        s[i].vertex(1, 0, 0, w, 0);
        s[i].vertex(1, 1, 0, w, h);
        s[i].vertex(1, 1, 1, 0, h);
      break;
    }
    s[i].endShape();
  }
  
  void draw(boolean[] d) {
    for(int i=0;i<6;i++) {
      if(d[i])shape(this.s[i], 0, 0);
    }
  }
  
}