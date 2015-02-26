// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


class Mover {

  PVector location;
  PVector velocity;
  PVector windy;
  PVector acceleration;
  float mass;
  float reverb = 0.0; //adding noise
  float increment = 0.1; //adding noise increment


  Mover(float m, float x , float y) {
    mass = m;
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    stroke(200,100,250);
  
        ellipse(location.x,location.y,mass*16,mass*16);
         //changes the position of the circles to the mouse location picked
          if (mousePressed) {
          location.x = mouseX;
          location.y = mouseY;
        }
        //makes the velocity go a bit faster when the f key is pressed
         if (key == 'f'){
          velocity.x = velocity.x *1.001;
          velocity.y = velocity.y * 1.001;
    }
       //makes the velocity go slower when the s key is pressed
         if (key == 's'){
          velocity.x = velocity.x /2;
          velocity.y = velocity.y /2;
    }
    
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = width-10;
      velocity.x *= -1;
      float n = noise (reverb);//etablishing noise variable
    reverb += increment;
    //adding noise to circle when it hits the side walls
    ballColor = color(150,206,245);//changes circle colors when hits side walls
    ellipse (location.x, location.y, (n+0.75)*mass*16, (n+0.75)*mass*16);
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
      float n = noise (reverb);
    reverb += increment;
     ballColor = color(150,206,245);//changes circle colors when hits side walls
     //adding noise to circle when it hits the side walls
    ellipse (location.x, location.y, (n+0.75)*mass*16, (n+0.75)*mass*16);
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height-10;
      float n = noise (reverb);
    reverb += increment;
     ballColor = color(104,53,245);//changes circle colors when hits side walls
     //adding noise to circle when it hits the side walls
    ellipse (location.x, location.y, (n+0.75)*mass*16, (n+0.75)*mass*16);
    }

  }

}



