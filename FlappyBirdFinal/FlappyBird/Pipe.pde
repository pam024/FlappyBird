import processing.sound.*;

class Pipe{
  //Imagenes de los tubos
  PImage pipe1;
  PImage pipe2;
    
  //variables para posicion y moviento de los tubos
  float xPipe;
  float yPipe;  
  float speedX;
  float size;
  float wallWidth;//ancho de los tubos
  boolean scored;//para saber si aumenta punto
  color wallColors = color(0,255,0);
  
  //constructor
  public Pipe(){
    //inicializacion imagenes
    pipe1 = loadImage("Pipe.png"); 
    pipe2 = loadImage("Pipe2.png");
    xPipe = width+200;
    yPipe = (int) random(100,500);//posicion de los tubos es aleatoreo
    size = 100;
    speedX = -2;//Valor negativo porque se mueve hacia la izq en el eje X.
    wallWidth = 55;  
    scored = false; 
  }
  
  //dibuja los tubos = 2 rect(arriba y abajo)
  void drawPipes() {
    stroke(0,143,57);
    fill(wallColors);
    
    //reemplaza rectas por imagenes
    //dibuja el tubo superior
    image(pipe1, xPipe-wallWidth, 0);
    pipe1.resize(int(wallWidth), int(yPipe-75));
    
    //dibuja el tubo inferior
    image(pipe2, xPipe-wallWidth, yPipe+size);
    pipe2.resize(int(wallWidth), int(height-(yPipe+size)));
    
    //rect(xPipe-wallWidth, 0, wallWidth, yPipe-100);
    //rect(xPipe-wallWidth, yPipe+size, wallWidth, height-(yPipe+size));
    
    xPipe += speedX;//movimiento hacia izq
  }
  
  //Si pasa por cada tubo gana 1 punto
  void scored(Bird b){
   if(xPipe < b.xPos && scored == false){
      bird_pt.play();
      scored = true;
      points++;//variable del FlappyBird
   }   
  }  
 
  //Revisa limites del pajaro y tubos para ver si choco con ellos 
  //Si esto pasa retorna un booleano 
  boolean collision(Bird b){
    if(b.xPos+20 < xPipe-wallWidth){      
      return false;
    }
    
    if(b.xPos > xPipe){      
      return false;
    }
    
    if(b.yPos > yPipe-75 && b.yPos+20 < yPipe+size){
      return false;
    }
    
    else{
      bird_ht.play();//sonido cuando golpea un tubo
      bird_d.play();//sonido de muerte del pajaro
      return true;
    }
  }

}
