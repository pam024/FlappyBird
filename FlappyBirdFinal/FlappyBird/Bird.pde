import processing.sound.*;

class Bird{
  //Imagen del flappy bird
  PImage bird_ph;
  
  //variables para posicion y moviento del pajaro
  float xPos;
  float yPos;
  float radius;
  float ySpeed; 
  float maxSpeed = 5; //velocidad maxima
  float bounce = -3.9; //valor de cuanto salta en el eje Y
    
  //constructor
  Bird(float xPos, float yPos, float radius, float ySpeed){
    //inicializacion de la imagen
    bird_ph = loadImage("Bird.png");
    this.xPos = xPos; 
    this.yPos = yPos; 
    this.radius = radius;
    this.ySpeed = ySpeed;
    
  }
  
  //dibuja la elipse = pajaro
  void drawBird(){
    //reemplaza elipse por imagen pajaro
    image(bird_ph, xPos, yPos);
    bird_ph.resize(int(radius), int(radius));
    
    //stroke(236,183,83);
    //fill(255,255,0);
    //strokeWeight(1);
    //ellipse(xPos, yPos, radius, radius);
  }
  
  //efecto de gravedad sobre el pajaro
  void gravity(){
    if(ySpeed < maxSpeed){
      ySpeed += 0.4;//cae 
    }
    //cuando toca los bordes superiores e inferiores de la pantalla
    if((yPos<height-radius/2 || ySpeed<maxSpeed)&& (yPos>radius/2 || ySpeed>0)){
       yPos += ySpeed;
    }    
  }

  //efecto del salto sobre el pajaro
  void jump(){
    //llega hasta bordes superiores e inferiores y vuelve a caer
    if(yPos < height-radius/2 || yPos > radius/2){
      bird_1.play(); 
      ySpeed = bounce;
    }       
  } 
}
