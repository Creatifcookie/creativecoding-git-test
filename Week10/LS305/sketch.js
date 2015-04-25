function setup() {
  // put setup code here
  createCanvas (windowWidth,windowHeight);
}

function draw() {
  // put drawing code here
  var x1, y1;
    x1=(windowWidth +(windowWidth /2))/2;
  y1=windowHeight /2;
  line(windowWidth,0,windowWidth /2,windowHeight);
  noFill();
  //arc(x1,y1,500,500, PI+QUARTER_PI, OPEN);
  arc(x1,y1,500,500, radians(-90), PI); 
}