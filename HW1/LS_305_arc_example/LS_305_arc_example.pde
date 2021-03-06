//From Sol Lewitt's Wall Drawing #305:

//The Eighth point is located halfway between the two points

//where an arc with its center at the first point and with a 
//radius equal to the distance between the first and the seventh 
//points would cross 

//a line from the upper right corner to a point halfway 
//between the midpoint of the bottom side and the lower 
//right corner.

void setup(){
  size(500,500);
}
void draw(){
  arc(width /2, height /2, 50, 50, radians(180), TWO_PI);
  //ellipse(width /2, height /2, 50, 50);
}
