class CharacterImage {
  PImage img;
  int x, y, w, h;
  boolean select =false;
  AudioPlayer character_sound;
  CharacterImage(int x, int y, int w, int h, PImage img, AudioPlayer audio) {
    this.img = img;
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    character_sound = audio;
  }

  void show()
  {
    image(img, x, y, w, h);
  }

  void select(int x, int y) {
    if (this.x < x && this.x+this.w >x && this.y <y && this.y+this.h>y) {
      stroke(255, 0, 0);
      strokeWeight(3);
      noFill();
      rect(this.x, this.y, w, h);
      image(img, width/2+20, 20, width/2-40, height/2);
      character_sound.cue(0);
      character_sound.play();
      select= true;
    } else {
      stroke(0, 0, 0);
      strokeWeight(3);
      noFill();
      rect(this.x, this.y, w, h);
    }
  }
}
