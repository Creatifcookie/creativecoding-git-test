

void setup(){
  size(displayWidth,displayHeight);
  
}
  void draw(){
 int x1, y1;
    x1=(displayWidth +(displayWidth /2))/2;
  y1=displayHeight /2;
  line(displayWidth,0,displayWidth /2,displayHeight);
  noFill();
  //arc(x1,y1,500,500, PI+QUARTER_PI, OPEN);
  arc(x1,y1,500,500, radians(-90), PI); 
}
