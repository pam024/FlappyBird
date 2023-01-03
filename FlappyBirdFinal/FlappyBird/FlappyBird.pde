import processing.sound.*;//Importa libreria para usar efectos sonido
SoundFile bird_1, bird_pt, bird_ht, bird_d;//files de sonidos

Bird bird;//pajaro
ArrayList<Pipe> pipes;//tubos 
PImage background, bird_ft, floor;//imagenes para juego y pantalla incial
PFont font;//Font del juego

//variables que se pasan como parametros en el bird
float xBird = 200;
float yBird = 400;
float speed = 1.0;
float radius = 50.0;
float overflowX = 0.0;

int points, counter;
int highScore = 0; 
String page = "MENU";//manejador pantallas

//Inicializacion de variables y objetos
void setup(){
  size(800, 800);
  font = createFont("FlappyBirdy.ttf", 120);//carga font del directorio 'data'
  background = loadImage("Background.png");//fondo pantalla y juego
  bird_ft = loadImage("Bird.png");//pajaro
  floor = loadImage("Floor.png");//imagen del suelo en movimiento
  bird = new Bird(xBird, yBird, radius, speed);
  pipes = new ArrayList<Pipe>(); 
  counter = 0;
  page = "MENU";
  //carga sonidos del directorio 'data'
  bird_1 = new SoundFile(this, "bird_jump.wav");
  bird_pt = new SoundFile(this, "bird_point.wav");
  bird_ht = new SoundFile(this, "bird_hit.wav");
  bird_d = new SoundFile(this, "bird_die.wav");
}

//Switch que verifica el caso especifico 'page'
void draw(){
  switch(page){
    case "GAME":
      gamePage();
      break;
    case "MENU":
      menuPage();  
      points = 0;
      break;
  }
}

//Pantalla del juego
void gamePage(){
  bird.gravity();//gravedad pajaro
          
  image(background, 0, 0);//pantalla fondo del juego
  background.resize(width, height);
        
  //moviemiento del suelo hacia la izq      
  overflowX += speed;
  if(overflowX > background.width/2) {
     overflowX = 0;
  }
  
  //imagen del suelo
  image(floor, floor.width*0-overflowX, height-floor.height,
        floor.width*4, floor.height*2);
        
   //muestra los tubos en pantalla
   showPipes();
   bird.drawBird(); 
   checkGameOver();
   textSize(30);
   fill(0);     
   checkScore();
   text("Score = "+points, 100, 100);//texto que muestra los puntos conseguidos
   
   //texto que muestra el puntaje mas alto hasta el ultimo juego
   textSize(25);
   fill(0);
   bestScore();
   text("Best Score = " +highScore, 100, 150);
}

//Pantalla del menu inicial del juego
void menuPage(){
  image(background, 0, 0);
  background.resize(width, height);
  
  //moviemiento del suelo hacia la izq 
  overflowX += speed;
  if(overflowX > background.width/2) {
     overflowX = 0;
  }
  
  //imagen del suelo
  image(floor, floor.width*0-overflowX, height-floor.height,
        floor.width*4, floor.height*2);
  
  //texto inicial del juego
  textFont(font);     
  textAlign(CENTER);
  fill(0);
  text("FlappyBird", width/2, height/5);
  
  //texto para iniciar el juego
  textFont(font);
  textSize(50);
  textAlign(CENTER);
  fill(255);
  text("Enter to Play", width/2, height/3);
  
  //imagen del pajaro
  image(bird_ft, width/2.33, height/2.5);
  bird_ft.resize(100, 100);    
  
}

//Muestra los tubos moviendose hacia la izquierda
void showPipes(){
  // Para cada pipe 'p' dentro de pipes, muestra 'p'
  for(Pipe p: pipes){
    p.drawPipes();
  }
  
  ArrayList<Pipe> thePipes = new ArrayList<Pipe>();
  
  // Para cada tubo 'p' dentro de la lista thePipes
  // elimina 'p' de la lista
  for(Pipe p : thePipes){
    pipes.remove(p);
  }
  
  counter++;
 
  if(counter == 100){//Se muestran 100 tubos y luego reinicia el valor
      Pipe newPipe = new Pipe();
      pipes.add(newPipe);
      counter = 0;
      
  } 
}

//Cuando presiona ENTER se cambia a la segunda pantalla (juego) 
//o regresa al menu principal
void keyPressed(){
  if(keyCode == ENTER){//no interviene mousePressed
    page = "GAME";   
  }else{
    page = "MENU";
  }
}

//Cuando presiona el mouse llama al efecto de salto del pajaro 
public void mousePressed() {
  bird.jump();  
}

//Revisa si el pajaro colisiona con un tubo, acaba el juego volviendo 
//a la 1era pantalla
void checkGameOver() {
  for (Pipe p : pipes) {
    if (p.collision(bird) == true){ //llama a la funcion collision
      resetGame();//reinicia los valores del juego
      page = "MENU";
    }
  }
}
 
//Revisa si el pajaro paso un tubo y aumenta los puntos  
void checkScore() {
  for (Pipe p : pipes){
    p.scored(bird);   
    
  }  
}

//Revisa si el score es el mejor hasta ahora y lo cambia
void bestScore(){     
    highScore = max(points, highScore);      
}

//Reinicia el juego
void resetGame(){
  bird = new Bird(xBird, yBird, radius, speed);
  pipes = new ArrayList<Pipe>(); 
  counter = 0;
  page = "MENU";
  points = 0;
}
