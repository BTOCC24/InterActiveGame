class Note {
  int xpos, ypos, len;
  float speed;
  color fcolor;
  boolean alldeleteNote = false;
  boolean notclearNote = false;
  boolean hpupNote = false;
  boolean hideable = false;
  boolean delete = false;
  int distx, disty;
  int angle;
  int cx, cy;
  Note(int xpos, int ypos, float speed, int len, int colran) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.speed=speed;
    this.len = len;
    cx=xpos+len/2;
    cy=ypos+len/2;
    if (colran == 0) {
      this.fcolor = color(255, 0, 0);
    } else {
      this.fcolor = color(0, 0, 255);
    }
    int ran = (int)random(50);
    if (ran < 2) {
      alldeleteNote = true;
      fcolor = color(255,51,153);
      this.speed = 0.03;
    } else if (ran < 7) {
      hpupNote = true;
      fcolor = color(255, 255, 255);
    }
    if (xpos>width/2) {
      if (ypos<height/2-10) {
        distx = xpos - (width/2); //1사
        disty = (ypos+len) - (height/2-10);
      } else { //2사
        distx = xpos - (width/2); //1사
        disty = (ypos) - (height/2-10);
      }
    } else {
      if (ypos<height/2-10) {
        distx = (xpos+len) - (width/2); //4사
        disty = (ypos+len) - (height/2-10);
      } else { //2사
        distx = (xpos+len) - (width/2); //3사
        disty = (ypos) - (height/2-10);
      }
    }
  }

  void show() {
    noStroke();
    fill(fcolor);
    rect(xpos, ypos, len, len);
  }

  void update() {

    if (dist(ball1.cx, ball1.cy, cx, cy)<20 && (red(fcolor)==255||color(fcolor)==color(255, 255, 255)||color(fcolor)==color(255, 51,153))) {
      if(color(fcolor)==color(255, 51,153)){
        score+=mynote.size();
        mynote.clear();
      }
      delete();
      score++;
    }
    if (dist(ball2.cx, ball2.cy, cx, cy)<20 && (blue(fcolor)==255||color(fcolor)==color(255, 255, 255)||color(fcolor)==color(255, 51,153))) {
      if(color(fcolor)==color(255, 51,153)){
        score+=mynote.size();
        mynote.clear();
      }
      delete();
      score++;
    }
    if ((Math.abs((xpos+len/2) - width/2)) < len/2+50 && (Math.abs((height/2-10)-(ypos+len/2))<len/2+50)) {
      if (color(fcolor) != color(255, 255, 255)) {
        hp--;
      } else {
        if (hp<=27) {
          hp+=3;
        }
      } 
      delete();
      noFill();
      stroke(255, 0, 0);
      rect(width/2-50, height/2-60, 100, 100);
    }
    if (!delete) {
      xpos = xpos - (int)(distx*speed);
      ypos = ypos - (int)(disty*speed);
    }
    cx = (xpos + len/2);
    cy = (ypos + len/2);
  }

  void delete() {
    mynote.remove(this);
    delete = true;
  }
}
