//1 pixel = 10ˆ3 m 
//1 unidade de massa = 10ˆ22 kg 
//1 segundo de simulação corresponde a aproximadamente 10ˆ6 s 
PImage earth;  
PImage moon;  
PImage sky;  
PShape globe1;  
PShape globe2;  
PShape globe3;  
   
PVector p1, p2, pc; //posições iniciais de Terra, Lua e "câmera", respectivamente 
float dist;  
float M = 597.2;//massa da Terra  
float G = 0.7;// constante de gravitação (unidade (10^3 m)^3 / (10^22 kg) (10^6 s)^2) 
PVector v1, a1; // velocidade e aceleração iniciais da Lua 
float t1,t2,dt; //tempo 
float teta,fi,raio;  
   
void setup() {  
  size(1100, 700, P3D);  
  
  p1 = new PVector(-384.4,0,0);//vetor posição inicial da Terra  
  p2 = new PVector(0, 0, 0); //vetor posição inicial da Lua 
  v1 = new PVector(0,0,1); //vetor velocidade inicial da Lua 
  a1 = new PVector(0,0,0); //vetor aceleração da Lua  
  t1 = millis()/1000.0; 
   
//parâmetros para posicionamento da câmera 
  teta = PI;  
  fi = 0;  
  raio = 500;  
  
//esferas 
  earth = loadImage("https://www.solarsystemscope.com/textures/download/2k_earth_daymap.jpg");  
  globe1 = createShape(SPHERE, 64); //10 vezes maior que o tamanho real  
  globe1.setStroke(false); 
  globe1.setTexture(earth);  
  moon = loadImage("https://www.solarsystemscope.com/textures/download/2k_moon.jpg");  
  globe2 = createShape(SPHERE, 17); //10 vezes maior que o tamanho real 
  globe2.setStroke(false); 
  globe2.setTexture(moon);  
  sky = loadImage("https://www.solarsystemscope.com/textures/download/2k_stars_milky_way.jpg");  
  globe3 = createShape(SPHERE, 2000);  
  globe3.setStroke(false); 
  globe3.setTexture(sky);  
  
}  
  
void draw() {  
//atualização da posição da Lua 
  t2 = millis()/1000.0; 
  dt = t2 - t1; 
  t2 = t1; 
  dt=1;  
  a1 = p2.copy().sub(p1);  
  dist = a1.magSq();  
  a1.setMag(G * M / dist); //vetor aceleração da Lua baseado na lei de gravitação 
  v1.add(a1.copy().mult(dt));  
  p1.add(v1.copy().mult(dt));  

//atulização dos parâmetros da câmera
  if (keyPressed){  
    if (key == 'w'){teta+=PI/72;}  
    else if(key == 's'){teta+=(-PI)/72;}  
    else if(key == 'd'){fi+=(PI)/72;}  
    else if(key == 'a'){fi+=(-PI)/72;}  
    else if(key == 'm'){raio+=5;}  
    else if(key == 'n'){raio+=(-5);}  
  }  
   
  background(255); 
  pc = new PVector(raio*cos(teta)*cos(fi),raio*sin(teta),raio*sin(fi)*cos(teta));  
  if (floor((teta - PI/2)/PI)%2==0){camera(pc.x, pc.y, pc.z, 0, 0, 0, 0, 1, 0);}  
  else{camera(pc.x, pc.y, pc.z, 0, 0, 0, 0, -1, 0);}  
  
  translate(p2.x,p2.y,p2.z);  
  shape(globe1); //Terra 
    
  translate(p1.x,p1.y,p1.z);  
  shape(globe2); //Lua 
  
  translate(0,0,0);  
  shape(globe3); //Céu 
} 
