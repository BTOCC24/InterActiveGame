class Game {
  AudioPlayer mybgm;
  CharacterImage myimg;

  Game(AudioPlayer bgm, CharacterImage img) {
    ball1 = new Ball(color(255, 0, 0)); //red ball
    ball2 = new Ball(color(0, 0, 255)); //blue ball
    mybgm=bgm;
    myimg=img;
    mybgm.cue(0);
    mybgm.play();
    time = millis();
  }
  void show() {
    noStroke();
    fill(0, 0, 0, 40);
    rect(0, 0, width, height);
    bts.detect(mybgm.mix);
    stroke(0, 255, 0);
    strokeWeight(2);
    image(myimg.img, width/2-50, height/2-60, 100, 100);
    rect(width/2-50, height/2-60, 100, 100);
    detect();
    ball1.show(); //red
    ball2.show(); //blue
    fill(#ffcc33);
    stroke(#ffcc33);
    line(0, height-20, width, height-20);
    text("HP", 2, height-5);
    rect(30, height-15, map(hp, 0, 30, 0, width-200), 10);
    text("score : ", width-150, height-5);
    text(score, width-100, height-5);


    int posran = (int)random(4);
    int generran = (int)random(15);
    if (generran==0) {
      switch(posran) {
      case 0://위
        mynote.add(new Note((int)random(20, width-20), 0, stagelevel, 20, (int)random(2)));
        break;
      case 1:
        mynote.add(new Note(width, (int)random(30, height-70), stagelevel, 20, (int)random(2)));
        break;
      case 2:
        mynote.add(new Note((int)random(20, width-20), height, stagelevel, 20, (int)random(2)));
        break;
      case 3:
        mynote.add(new Note(0, (int)random(30, height-70), stagelevel, 20, (int)random(2)));
      }
    }


    for (int i=0; i<mynote.size(); i++) {
      mynote.get(i).show();
      mynote.get(i).update();
    }

    if ((hp<=0 || !mybgm.isPlaying())) {
      if (hp>=1) {
        success = true;
      }
      if (mybgm.isPlaying()) {
        mybgm.pause();
      }
      startbt=false;
      go=null;
      finishbt=true;
      time = millis()-time;
    }
  }
  void detect() {
    int lux=3*width+1, luy=3*height+1, rdx=-1, rdy=-1; //카메라 탐색.
    int lux2=3*width+1, luy2=3*height+1, rdx2=-1, rdy2=-1; //카메라 탐색.
    if (cam.available() == true) {
      cam.read();
    }
    for (int x=0; x<width; x++) { 
      for (int y=0; y<height; y++) {
        color c = cam.get(x, y);
        if (red(c)>(green(c)+blue(c))&&red(c)>100) {
          color c1, c2, c3, c4;
          c1=cam.get(x+20, y+20);
          c2=cam.get(x+20, y-20);
          c3=cam.get(x-20, y-20);
          c4=cam.get(x-20, y+20);
          if ((red(c1)>(green(c1)+blue(c1))&&red(c1)>100) &&(red(c2)>(green(c2)+blue(c2))&&red(c2)>100) &&(red(c3)>(green(c3)+blue(c3))&&red(c3)>100) &&(red(c4)>(green(c4)+blue(c4))&&red(c4)>100)) {
            if (x<lux) {
              lux=x;
            }
            if (x>rdx) {
              rdx=x;
            }
            if (y<luy) {
              luy=y;
            }
            if (y>rdy) {
              rdy=y;
            }
          }
        } else if (blue(c)>(red(c)+green(c))&&blue(c)>100) {
          color c1, c2, c3, c4;
          c1=cam.get(x+20, y+20);
          c2=cam.get(x+20, y-20);
          c3=cam.get(x-20, y-20);
          c4=cam.get(x-20, y+20);
          if ((blue(c1)>(green(c1)+red(c1))&&blue(c1)>100) &&(blue(c2)>(green(c2)+red(c2))&&blue(c2)>100) &&(blue(c3)>(green(c3)+red(c3))&&blue(c3)>100) &&(blue(c4)>(green(c4)+red(c4))&&blue(c4)>100)) {
            if (x<lux2) {
              lux2=x;
            }
            if (x>rdx2) {
              rdx2=x;
            }
            if (y<luy2) {
              luy2=y;
            }
            if (y>rdy2) {
              rdy2=y;
            }
          }
        }
      }
    }
    ball1.setpos(width-(lux+rdx)/2, (luy+rdy)/2);
    ball2.setpos(width-(lux2+rdx2)/2, (luy2+rdy2)/2);
    if (rdx==-1 && rdx2 == -1) {
      fill(255, 0, 0);
      textSize(15);
      text("Red ball is undetected or too many detected !", 20, 20);
      fill(0, 0, 255);
      text("Blue ball is undetected or too many detected !", 20, 40);
    } else if (rdx==-1) {
      textSize(15);
      fill(255, 0, 0);
      text("Red ball is undetected or too many detected !", 20, 20);
    } else if (rdx2==-1) {
      textSize(15);
      fill(0, 0, 255);
      text("Blue ball is undetected or too many detected !", 20, 20);
    } else {
      if (!mybgm.isPlaying()) {
        mybgm.play();
      }
    }
  }
}
