int x[] = new  int[50];
int y[] = new int[50];
// The statements in the setup() function 
// execute once when the program begins
void setup(){
  
  // Size made to the full width and height of the screen
  size(displayWidth,displayHeight);  
  background(255);
  stroke(255); //makes stroke white
  smooth(8);
}
void draw(){
  background(0);
// Nested for() loops can be used to
// generate two-dimensional patterns
for (int i = 0; i < 50; i++) {
  x[i] = int(random(50, width));
  y[i] = int(random(50, height));
  for (int j = 0; j < i; j++) {
 
    line(x[i], y[i], x[j], y[j]);
  }
}
noLoop();
}
