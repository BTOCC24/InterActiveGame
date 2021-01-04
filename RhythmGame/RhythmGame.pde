import processing.video.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import gab.opencv.*;
import java.awt.Rectangle;

FFT fft;

Minim minim;
OpenCV opencv;
Rectangle[] faces;
AudioPlayer move_s, start_s;
int shadec=0;
ArrayList<Note> mynote = new ArrayList<Note>();
Capture cam;
Start start;
int hp = 30;
int score = 0;
float stagelevel=0.01;
Ball ball1, ball2;
boolean finishbt;
boolean startbt = false;
boolean success = false;
Game go;
int time = 0;
BeatDetect bts = new BeatDetect();

RhythmGame refer = this;
void setup() {
  bts.setSensitivity(1);
  //fullScreen(); 
  size(640, 480,P3D);
  minim = new Minim(this);
  move_s = minim.loadFile("move.MP3");
  start_s = minim.loadFile("start.MP3");
  smooth();
  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++) {
    println(i+" "+cameras[i]);
  }
  cam = new Capture(this, cameras[6]);
  cam.start();
  frameRate(30);
  start = new Start();
}

void draw() {
  start.title();
}
