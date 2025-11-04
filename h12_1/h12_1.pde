class Rectangle {
float x;
float y;
float x1;
float y1;


Rectangle(float x, float y , float x1,float y1){
this.x = x;
  this.y = y;
  this.x1 = x1;
  this. y1 = y1;
  }
  
  void display(){
   rect(x,y,x1,y1);
   }
}
void setup(){
  size (500,500);
  Rectangle myRectangle=new Rectangle(400,400,40,40);
  myRectangle.display();
}
