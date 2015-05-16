//import smile dection library
import processing.video.*;
import pSmile.PSmile;

//this will us to regulate and match the song with lyrics
import java.util.regex.Matcher;
import java.util.regex.Pattern;

// this is what we need to play sound
import ddf.minim.*;
import ddf.minim.analysis.*;

////makes the words geometric
//import processing.opengl.*;
//import geomerative.*;


PFont thefont;

Minim minim; // audio engine
AudioPlayer thesound; // soundfile
AudioInput in;
AudioMetaData meta;
BeatDetect beat;

float eRadius;
int b = 200;
float l = displayHeight/2 ; float r = displayWidth/2;

//start of smile dection variables
Capture cap;
PSmile smile;
PImage img2;
float res, factor;
PFont font2;
int w, h;
long lastTime = 0;

ArrayList<SubTitle> thelyrics; // lyrics!!!
float lyricfade = 255;
boolean started = false;

String[] playlist;

//Particle p;
//ArrayList particles;

//RFont font;
//RShape s;
//float distMin=40;


void setup()
{
  size(displayWidth, displayHeight, OPENGL);
  smooth();
//  particles = new ArrayList();
//  
//  RG.init(this);
//  RCommand.setSegmentLength(10);
thefont = createFont("FreeSans.tff", 45);
textFont(thefont);
//  RGroup maGroupe = thefont.toGroup("HEY");
//  RPoint[] points = maGroupe.getPoints();
//  
//  for (int i=0;i<points.length;i++) {
//    particles.add(new Particle(points[i].x, points[i].y, 3));
//  }

  w = width/2;
  h = height/2;
  background(0);
  cap = new Capture(this, width, height);
  cap.start(); // add this to start the device
  img2 = createImage(w,h,ARGB);
  smile = new PSmile(this,w,h);
  res = 0.0;
  factor = 0.0;
  font2 = loadFont("SansSerif.plain-16.vlw");
  //textFont(font,50);
  textAlign(CENTER, TOP);
  noStroke();
  fill(255,200,0);
  rectMode(CORNER);
  
  

  minim = new Minim(this); // this is the audio engine
  minim.debugOn();
  
  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);
  

  playlist = loadStrings("playlist.txt"); // this is the list of songs

  pickNewSong(); // picks the first song
  
  beat = new BeatDetect();
  noCursor();
  ellipseMode(RADIUS);
  eRadius = 20;
  
}

void draw()
{
  background(0);
  noFill();
  //fill(255, 0, 0);
  stroke(0, 255, 255);
  //strokeWeight(0.3);
  //stroke(0,255,255, 50);
  ellipse(random(width), random(height), 200, 200);
  
//  //will display audio input from user
//  for(int i = 0; i < in.bufferSize() - 1; i++)
//  {
//    stroke((1+in.left.get(i))*50,100,100);
//    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
//    stroke(white);
//    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
//  }
  img2.copy(cap,0,0,width,height,0,0,w,h);
  img2.updatePixels();
  image(cap,0,0);
  res = smile.getSmile(img2);
  if ( millis() - lastTime > 5000 ) {
    lastTime = millis();
    if (res<0){
    //need to add a delay before song starts
    
    
    thesound.play();
    //cap.stop();
      
  
  }
  
  
}



  if (started) {
    if (thesound.isPlaying())
    {
      float p = thesound.position()/1000.;
      String currentlyric = checkLyrics(p);
      fill(255, 0, 255, lyricfade); //color for the lyrics
      textAlign(CENTER);
      text(currentlyric, width/2, height/2);
      
      
       //displays audio beat as a circle
  beat.detect(thesound.mix);
  float a = map(eRadius, 20, 400, 0, eRadius*2);
  float n = noise (eRadius);
  float increment = 0.1;
  fill(255, 0, 0, a);
  
  //tracks beat and correlates beat to radius size
  if ( beat.isOnset() ) eRadius = 350;
  noFill();
  //ellipse(displayWidth/2, displayHeight/2, eRadius+n, eRadius+n);
  ellipse(random(width), random(height), eRadius+n, eRadius+n);
  eRadius *= 0.95;
  if ( eRadius < 20 ) eRadius = 20;
  
  //sets song buffer size to get continuous expanding data
  int bsize = thesound.bufferSize(); 
  
  //displays lines generated from audio data
  for (int i = 0; i < bsize - 1; i+=5)
  {
    r = (b)*cos(i*2*PI/bsize);
    l = (b)*sin(i*2*PI/bsize);
    float x2 = (b + thesound.left.get(i)*100)*cos(i*2*PI/bsize);
    float y2 = (b + thesound.left.get(i)*100)*sin(i*2*PI/bsize);
    line(r+ (displayWidth/2), l+(displayHeight/2), x2+(displayWidth/2), y2+(displayHeight/2));
  }
  beginShape();//creates custom shape
  noFill();
    }
  }
  
}

void keyReleased()
{
  pickNewSong();
  
}

void pickNewSong()
{

  if (started)
  {
    if (thesound.isPlaying())
    {
      thesound.close();
    }
  }

  int choice = int(random(0, playlist.length));
  String sfile = dataPath("./songs/"+playlist[choice]+".mp3");
  //println(sfile);
  thesound = minim.loadFile(sfile, 2048);
  
  thesound.play();
  parseLyrics("./songs/"+playlist[choice]+".lrc");
  started = true;
}
void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
  super.stop();
}
