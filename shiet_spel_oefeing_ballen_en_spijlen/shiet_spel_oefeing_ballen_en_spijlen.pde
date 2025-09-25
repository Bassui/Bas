float y = 500;
float x =500;


void setup() {
  size (500, 500);
}

void draw() {
 
 line(250,0,10,10);  


  background(255, 255, 250);
  y = y - 4;
  x  = x- 6;
  ellipse (250, y, 30, 30);
  ellipse (100, x, 30, 30);
  println(y);
  if (y <= 0)
    y = 500;
  println(x);
  if (x <= 0) {
    x= 500;
  }
}
