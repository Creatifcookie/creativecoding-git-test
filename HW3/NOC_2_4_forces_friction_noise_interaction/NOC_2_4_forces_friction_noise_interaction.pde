// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers = new Mover[5];
color ballColor;

void setup() {
  size(500, 300);
  randomSeed(1);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(1, 7), random(width), 0);
  }
  colorMode(HSB);
  ballColor = color(34,100,250);
}


void draw() {
  background(255);

  for (int i = 0; i < movers.length; i++) {
    if (mousePressed) {
        //PVector wind = new Pvector(0.5, 0);
    }
    PVector wind = new PVector(0.01, 0);
    PVector gravity = new PVector(0, 0.1*movers[i].mass);
    
    float c = 0.05;
    PVector friction = movers[i].velocity.get();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);
    fill(ballColor);
    
    
 

    movers[i].applyForce(friction);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);

    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
    
    
    
    
  }
}









