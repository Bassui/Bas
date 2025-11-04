class Person
{
  String naam;
  String geslacht ; 
  int leeftijd; 
  
  public Person (String naam , String geslacht  , int leeftijd ){
    this.naam = naam ;
    this.geslacht = geslacht;
    this.leeftijd = leeftijd;
  }
  public void tooInformatie(){
    println("naam:" + naam);
    println("geslacht:"+geslacht);
    println("leeftijd:"+ leeftijd);
  }
}
void setup(){
  size(500,500);
  Person myPerson = new Person("Bas", "man", 16);
myPerson.tooInformatie();
}
