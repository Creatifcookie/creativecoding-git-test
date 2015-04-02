import ddf.minim.*;
 
Minim minim;
AudioPlayer song;
AudioMetaData meta;

 
void setup()
{
  size(displayWidth, displayHeight);
 
  minim = new Minim(this);
 
  // this loads mysong.wav from the data folder and specifies the length of sample buffers
  song = minim.loadFile("Beyonce711.wav", displayWidth);
  song.play();
  
  // an FFT needs to know how 
  // long the audio buffers it will be analyzing are
  // and also needs to know 
  // the sample rate of the audio it is analyzing
 
}
 
void draw()
{
  background(0);
  stroke(255);
  // we draw the waveform by connecting neighbor values with a line
  // we multiply each of the values by 50 
  // because the values in the buffers are normalized
  // this means that they have values between -1 and 1. 
  // If we don't scale them up our waveform 
  // will look more or less like a straight line.
  for(int i = 0; i < song.bufferSize() - 1; i++)
  {
    line(i, 150 + song.left.get(i)*50, i+1, 150 + song.left.get(i+1)*50);
    line(i, 650 + song.right.get(i)*50, i+1, 650 + song.right.get(i+1)*50);
  }
}
  
  void showMeta() {
  int time =  meta.length();
  textSize(50);
  textAlign(CENTER);
  text( (int)(time/1000-millis()/1000)/60 + ":"+ (time/1000-millis()/1000)%60, -7, 21);
}

