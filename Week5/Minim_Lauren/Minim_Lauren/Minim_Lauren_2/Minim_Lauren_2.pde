import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
AudioMetaData meta;
BeatDetect beat;

float eRadius;
int b = 200;
float l = displayHeight/2 ; float r = displayWidth/2;

void setup()
{
  size (displayWidth,displayHeight)  ; smooth();
  background(0);
  minim = new Minim(this);
  //load song from folder
  song = minim.loadFile("Beyonce711.wav", 2048);
  //play song from folder
  song.play();
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  noCursor();
  
  ellipseMode(RADIUS);
  eRadius = 20;
  //noStroke();
}

void draw()
{
   //displays beat as a circle
  beat.detect(song.mix);
  float a = map(eRadius, 20, 400, 0, eRadius*2);
  float n = noise (eRadius);
  float increment = 0.1;
  fill(255, 0, 0, a);
  
  //tracks beat and correlates beat to radius size
  if ( beat.isOnset() ) eRadius = 350;
  ellipse(displayWidth/2, displayHeight/2, eRadius+n, eRadius+n);
  eRadius *= 0.95;
  if ( eRadius < 20 ) eRadius = 20;
  
//noStroke() ;
  //ellipse(0, 0, 2*eRadius, 2*eRadius);
  //stroke(-1, 50);
  
  //sets song buffer size to get continuous expanding data
  int bsize = song.bufferSize(); 
  
  //displays lines generated from audio data
  for (int i = 0; i < bsize - 1; i+=5)
  {
    r = (b)*cos(i*2*PI/bsize);
    l = (b)*sin(i*2*PI/bsize);
    float x2 = (b + song.left.get(i)*100)*cos(i*2*PI/bsize);
    float y2 = (b + song.left.get(i)*100)*sin(i*2*PI/bsize);
    line(r+ (displayWidth/2), l+(displayHeight/2), x2+(displayWidth/2), y2+(displayHeight/2));
  }
  beginShape();//creates custom shape
  noFill();
  //stroke(-1, 50);
  
  
  //displays points generated from audio data
  for  (int i = 0; i < bsize ; i+=30)
  {
    r = (b + song.right.get(i)*100)*cos(i*2*PI/bsize) ;
    l = (b + song.left.get(i)*100)*sin(i*2*PI/bsize) ;
  vertex(r+(displayWidth/2), l+(displayHeight/2));
    pushStyle();//start new style
    stroke(-1);
    strokeWeight(35);
    point(r+(displayWidth/2), l+(displayHeight/2));
    popStyle();//begin original style
    
  }
  endShape();


  
  if (mousePressed)
  {
    fill(10, 10,10, 255) ; // fills circle black with 100% opacity
    ellipse(mouseX, mouseY, r/2, r/2) ;
    strokeWeight(1);
    stroke(255,50,10,255) ;
    noFill() ;
    ellipse(mouseX, mouseY, r/2, r/2) ;
  }
  fill(255,50,10,50) ; // fills circle red with less opacity
  ellipse(mouseX, mouseY, r/6, r/6) ;
   
    
    //changes size of circle when "+" key is used
    for (int j = 1; j < 5; j++) {
   if (key == '+'){
     
          fill(0, 0, 0, 255) ; 
    ellipse(mouseX, mouseY, r/j, r/j) ;
    strokeWeight(1);
    stroke(255,50,10,255) ;
    noFill() ;
    ellipse(mouseX, mouseY, r/2, r/2) ;
    }
       

    }
  
}




