class Ball{
  int size;
  int xpos, ypos,cx,cy;
  color ballcol;
  Ball(color fillcol){
    ballcol = fillcol;
    xpos = 100;
    ypos = 100;
    size = 10;
  }
  
  Ball(color fillcol, int size){
    cx = xpos+size/2;
    cy = ypos+size/2;
    ballcol = fillcol;
    this.size = size;
    xpos = 0;
    ypos = 0;
  }
  
  void show(){
    noStroke();
    fill(ballcol);
    ellipse(xpos,ypos,size,size);
  }
  
  void setpos(int x,int y){
    xpos = x;
    ypos = y;
    cx=xpos+5;
    cy=ypos+5;
  }
}
