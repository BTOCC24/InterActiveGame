class Start {
  String[] mp3list = loadStrings("mp3list.txt");
  String[] characterlist = loadStrings("characterlist.txt");
  AudioPlayer character_sound[];
  AudioPlayer model_s;
  AudioPlayer bgm[];
  String front, middle, back; 
  int listpos = 1;
  int textAlpha = 1;
  int textFade = 5;
  boolean gamestart  = false;
  boolean dotitle = false;
  boolean characterbt = false;
  boolean photo = false;
  boolean photocheck = false;
  boolean levelsetbt = false;
  boolean howtobt = false;
  CharacterImage myimage[];
  CharacterImage selected_image;
  Button level, record, start, close, howtoplay, character;
  PImage body;
  boolean recordbt = false;

  Start() {
    bgm = new AudioPlayer[mp3list.length-2];
    body = loadImage("body.png");
    photocheck = false;
    character_sound = new AudioPlayer[characterlist.length-2];
    front = mp3list[0];
    middle = mp3list[1];
    back = mp3list[2];
    stagelevel = 0.01;
    fill(0, 0, 0);
    rect(0, 0, width, height);
    level = new Button(width/10, height*5/10, width*4/10, height/8, "        Level");
    character = new Button(width*9/17, height*5/10, width*4/10, height/8, "       Character");
    start = new Button(width/10, height*5/6, width*4/10, height/8, "        Start");
    howtoplay = new Button(width/10, height*8/12, width*4/10, height/8, "     How to play");
    record = new Button(width*9/17, height*8/12, width*4/10, height/8, "      Record");
    close = new Button(width*9/17, height*5/6, width*4/10, height/8, "        Close");

    myimage = new CharacterImage[characterlist.length-2];
    for (int i=0, j=0, p=0; p<myimage.length; i++, p++) {
      myimage[p] = new CharacterImage(i*width/4, 20+j, width/4-10, 100, loadImage(characterlist[p+1]+".png"), minim.loadFile(characterlist[p+1]+"_s.MP3", 2048)); 
      if (i>0) {
        i=-1;
        j+=120;
      }
    }
    for (int i=0; i<bgm.length; i++) {
      bgm[i] = minim.loadFile(mp3list[i+1]+".MP3");
    }
    bgm[listpos-1].cue(0);
    bgm[listpos-1].play();

    myimage[0].select= true;
    selected_image = myimage[0];
  }

  void title() {
    if (!dotitle) {
      fill(0, 0, 0);
      rect(0, 0, width, height);
      textSize(width/10);
      fill(255, 255, 255, textAlpha);
      text("Shake Hands !", width/6, height/2);
      delay(1);
      textAlpha+=textFade;
      if (textAlpha>=255) {
        delay(2000);
        textFade = -5;
      }
      if (textAlpha <0) {   
        dotitle = true;
      }
    } else if (characterbt) {
      showcharacter();
    } else if (levelsetbt) {
      showlevelset();
    } else if (startbt) {
      hp = 30;
      if (stagelevel == 0.015) {
        hp= 15;
      }
      if (stagelevel == 0.01) {
        hp=20;
      }
      go = new Game(bgm[listpos-1], selected_image);
      startbt = false;
    } else if (go!=null) {
      go.show();
    } else if (finishbt) {
      showending();
    } else if (recordbt) {
      showrecord();
    } else if (howtobt) {
      showhowto();
    } else {
      showselect();
    }
  }

  void showselect() {
    showmp3list();
    level.Set();
    if (level.clickevent) {
      levelsetbt = true;
      level.clickevent = false;
      delay(300);
    }
    character.Set();
    if (character.clickevent) {
      bgm[listpos-1].pause();
      characterbt = true;
      character.clickevent = false;
    }
    howtoplay.Set();
    if (howtoplay.clickevent) {
      howtobt=true;
      howtoplay.clickevent = false;
    }
    record.Set();
    if (record.clickevent) {
      recordbt = true;
      record.clickevent = false;
    }
    close.Set();
    start.Set();
    if (start.clickevent) {
      start_s.cue(0);
      start_s.play();
      start.clickevent=false;
      startbt = true;
    }
    if (close.clickevent) {
      exit();
    }
  }

  void showhowto() {
    fill(0, 0, 0);
    rect(0, 0, width, height);
    Button back = new Button(20, height-80, 200, 70, " Back");
    PImage view= loadImage("explain.png");
    image(view, 10, 10, width-20, height-100);
    back.Set();
    if (back.clickevent) {
      howtobt=false;
      delay(300);
    }
  }
  void showrecord() {
    fill(0, 0, 0);
    rect(0, 0, width, height);

    noStroke();
    int j =-30;

    Button back = new Button(20, height-80, 200, 70, " Back");
    back.Set();
    if (back.clickevent) {
      recordbt=false;
      delay(300);
    }
    textSize(20);
    fill(255, 255, 255);
    String[] reco = loadStrings("record.txt");
    for (int i=0; i<reco.length; i++) {
      if (i>4) {
        textSize(13);
      }
      if (i%5==0) {
        j+=60;
      }
      text(reco[i], i*120%600+30, j);
    }
  }

  void showending() {
    if (shadec<80) {
      noStroke();
      fill(0, 0, 0, 10);
      rect(0, 0, width, height);
      textSize(300);
      shadec++;
    } else {
      if (success) {
        textSize(40);
        fill(255, 255, 255);
        String str;
        if (stagelevel == 0.008) {
          str = "Easy";
        } else if (stagelevel == 0.01) {
          str = "Normal";
        } else {
          str = "Hard";
        }
        text("SUPER GREAT ! SUCCESS!", 100, 80);
        text("BGM :" + mp3list[listpos], 100, 160);
        text("Level :" + str, 100, 240); 
        text("Score :" + score, 100, 320);
        text("Time :" + str(time/1000)+"sec", 100, 400);
        String[] lines = loadStrings("record.txt");
        String[] imsilist = new String[lines.length+5];
        int i=0;
        for (i =0; i<lines.length; i++) {
          imsilist[i]=lines[i];
        }
        imsilist[i++] = "success";
        imsilist[i++] = mp3list[listpos];
        imsilist[i++] = str;
        imsilist[i++] = str(score);
        imsilist[i] = str(time/1000)+"sec";
        saveStrings("record.txt", imsilist);
        noLoop();
      } else {
        textSize(40);
        fill(255, 255, 255);
        String str;
        if (stagelevel == 0.008) {
          str = "Easy";
        } else if (stagelevel == 0.01) {
          str = "Normal";
        } else {
          str = "Hard";
        }

        text("F A I L...", 100, 80);
        text("BGM :" + mp3list[listpos], 100, 160);
        text("Level :" + str, 100, 240); 
        text("Score :" + score, 100, 320);
        text("Time :" + str(time/1000)+"sec", 100, 400);
        String[] lines = loadStrings("record.txt");
        String[] imsilist = new String[lines.length+5];
        int i=0;
        for (i =0; i<lines.length; i++) {
          imsilist[i]=lines[i];
        }
        imsilist[i++] = "fail";
        imsilist[i++] = mp3list[listpos];
        imsilist[i++] = str;
        imsilist[i++] = str(score);
        imsilist[i] = str(time/1000)+"sec";
        saveStrings("record.txt", imsilist);
        noLoop();
      }
    }
  }
  void showlevelset() {      
    noStroke();
    fill(0, 0, 0);
    rect(0, 0, width, height);
    Button easy = new Button(width/4, height/7, width/2, height/7, "                  Easy");
    Button normal = new Button(width/4, height*3/7, width/2, height/7, "               Normal");
    Button hard = new Button(width/4, height*5/7, width/2, height/7, "                 Hard");
    easy.Set();
    normal.Set();
    hard.Set();
    if (easy.clickevent) {
      stagelevel = 0.008;
      levelsetbt = false;
      easy.clickevent = false;

      fill(0, 0, 0);
      rect(0, 0, width, height);
      delay(100);
    }    
    if (normal.clickevent) {
      stagelevel = 0.01;
      levelsetbt = false;
      normal.clickevent = false;

      fill(0, 0, 0);
      rect(0, 0, width, height);
      delay(100);
    }    
    if (hard.clickevent) {
      stagelevel = 0.015;
      levelsetbt = false;
      hard.clickevent = false;

      fill(0, 0, 0);
      rect(0, 0, width, height);
      delay(100);
    }
  }

  void showcharacter() {
    if (!photo) {
      Button cambbt = new Button(20, height-100, width/2-30, 80, "            Cam");
      Button ok = new Button(width/2, height-100, width/2-30, 80, "              Select");
      noStroke();
      fill(0, 0, 0);
      rect(0, 0, width, height);
      cambbt.Set();
      ok.Set();
      for (int i=0; i<myimage.length; i++) {
        myimage[i].show();
      }

      if (mousePressed) {
        for (int s=0; s<myimage.length; s++) {
          if (!ok.clickevent) {
            myimage[s].select = false;
          }
          myimage[s].select(mouseX, mouseY);
        }
      }
      for (int i=0; i<myimage.length; i++) {
        if (myimage[i].select) {
          selected_image = myimage[i];
        }
      }
      if (photocheck) {
        stroke(0, 0, 255);
        strokeWeight(5);
        fill(0, 0, 0);
        rect(width/2+20, 20, width/2-40, height*2/3);
        image(selected_image.img, width*2/3, 40, width*0.18, height*0.3);
        noFill();
        stroke(0, 0, 0);
        strokeWeight(30);
        //ellipse(width*2/3 + width*0.09, 40+height*0.15, width*0.20, height*0.35);
        image(body, width*0.56, height*0.35, width*0.4, height*0.33);
        selected_image.img = get( width/2+25, 25, width/2-50, height*2/3-10);
        selected_image.img.save("mymodel.png");
        photocheck=false;
      }
      if (selected_image!=null) {
        stroke(0, 0, 255);
        strokeWeight(5);
        noFill();
        image(selected_image.img, width/2+20, 20, width/2-40, height*2/3);
        rect(width/2+20, 20, width/2-40, height*2/3);
      }

      if (cambbt.clickevent) {
        delay(100);
        cambbt.clickevent = false;
        photo = true;
      }
      if (ok.clickevent) {
        fill(0, 0, 0);
        rect(0, 0, width, height);
        for (int i=0; i<myimage.length; i++) {
          if (myimage[i].select)
            selected_image=myimage[i];
        }
        delay(500);
        bgm[listpos-1].cue(0);
        bgm[listpos-1].play();
        character.clickevent = false;
        characterbt = false;
        ok.clickevent = false;
      }
    } else {
      Button click = new Button(width/5, height-100, width*3/5, 80, "                            Click");
      if (cam.available() == true) {
        cam.read();
      }
      image(cam, 0, 0);
      opencv = new OpenCV(refer, cam);
      opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
      faces = opencv.detect();
      image(opencv.getInput(), 0, 0);
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      for (int i = 0; i < faces.length; i++) {
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      }   
      click.Set();
      if (click.clickevent && faces.length == 1) {
        selected_image = new CharacterImage(width/4, 380, width/4-10, 100, get(faces[0].x+10, faces[0].y+10, faces[0].width-12, faces[0].height-12), minim.loadFile("laugh.MP3"));
        model_s = selected_image.character_sound;
        model_s.cue(0);
        model_s.play();

        photo = false;
        photocheck = true;
        click.clickevent = false;
      }
    }
  }

  void showmp3list() {

    fill(0, 0, 0);
    rect(0, 0, width, height);
    fill(0, 0, 0);
    strokeWeight(5);
    stroke(100);
    rect(width/15, height/14, width*13/15, height/3);
    stroke(0, 0, 255);
    strokeWeight(10);
    rect(width/15, height/6, width*13/15, height/8);

    textSize(20);
    fill(100);
    text(front, width/2-front.length()*5, height/8);
    text(back, width/2-back.length()*5, height*6/17);
    textSize(40);
    fill(0, 0, 255);
    text(middle, width/2-middle.length()*10, height*1/4);


    if (keyPressed) {
      if (key ==CODED) {
        if (keyCode == DOWN) {
          move_s.cue(0);
          move_s.play();
          if (listpos<mp3list.length-2) {
            listpos++;
            bgm[listpos-2].pause();
            bgm[listpos-1].cue(0);
            bgm[listpos-1].play();
          }

          delay(100);
        } else if (keyCode ==UP) {
          move_s.cue(0);
          move_s.play();
          if (listpos>1) {
            listpos--; 
            bgm[listpos].pause();
            bgm[listpos-1].cue(0);
            bgm[listpos-1].play();
          }
          delay(100);
        }
        front = mp3list[listpos-1];
        middle = mp3list[listpos];
        back = mp3list[listpos+1];
      }
      delay(100);
    }
  }
}
