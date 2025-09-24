float y1 = 500;
float x1 = 0;
float x2 = 100;
void setup() {
size(500,500);   
} 

 void draw() { 
 background(255,0,255);
 rect(mouseX,mouseY,30,30);
 println(mouseY);
 y1 = y1 -6;
 x1= x1 + 4;
 x2 = x2 + 4;
 ellipse(250,y1,50,30);
 line(x1,200,x2,200);
 if( y1<=0) {
 y1 = 500; 
 if ( x1>=500){
   x1=0;
   x2=100;
 }
 }
}
