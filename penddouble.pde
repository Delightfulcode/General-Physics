float l1 = 100;
float l2 = 100;
float m1 = 10;
float m2 = 10;
float teta1 = PI/2; //angle
float teta2 = PI/2;
float w1 = 0; 
float w2= 0;
float w1_p = 0;
float w2_p = 0;
float g = 1;

float xp = 0;
float yp = 0;

PGraphics dessin; 
 
void setup (){
  size (800,800); //creation de fenetre graphique
  dessin = createGraphics (width,height);
  dessin.beginDraw();
  dessin.background(255);
  dessin.endDraw();
}
  
void draw (){
 
  //equation de mouvement du pendule double separe en plusieurs termes
  
  float num1 = -g * (2 * m1 + m2) * sin(teta1);
  float num2 = -m2 * g * sin(teta1 - 2 * teta2);
  float num3 = -2 * sin(teta1 - teta2) * m2;
  float num4 = w2 * w2 * l2 + w1 * w1 * l1 * cos(teta1 - teta2);
  float den = l1 * (2 * m1 + m2 - m2 * cos(2 * teta1 - 2 * teta2));
  float w1_p = (num1 + num2 + num3 * num4) / den; // acceleration angulaire du premier pendule

  num1 = 2 * sin(teta1 - teta2);
  num2 = (w1 * w1 * l1 * (m1 + m2));
  num3 = g * (m1 + m2) * cos(teta1);
  num4 = w2 * w2 * l2 * m2 * cos(teta1 - teta2);
  den = l2 * (2 * m1 + m2 - m2 * cos(2 * teta1 - 2 * teta2));
  float w2_p = (num1 * (num2 + num3 + num4)) / den; // acceleration angulaire du deuxieme pendule
  
  background(255);
  image(dessin,0,0);
  stroke(0);
  strokeWeight(1);
  
  translate(350,300);
  
  float x1 = l1 * sin(teta1); // position du 1er pendule
  float y1 = l1 * cos(teta1);
  
  float x2 = x1 + l2 *sin(teta2); // position du 2e pendule
  float y2 = y1 +l2 * cos(teta2);

  line (0,0, x1, y1);    
  fill(0);
  ellipse (x1,y1,10,10);

  line (x1,y1, x2, y2);  
  fill(0);
  ellipse (x2,y2,10,10);


  w1 += w1_p; // incremente la vitesse grave à l'acceleration
  w2 += w2_p;
  teta1 += w1; // incremente le mouvement grace à la vitesse
  teta2 += w2;

 // w1 *=0.999; // friction
 // w2 *=0.999;

  dessin.beginDraw();
  dessin.translate (350,300);
  dessin.strokeWeight(1);
  dessin.stroke(0);
  if (frameCount > 1){ 
   dessin.line(xp,yp,x2,y2);}
  dessin.endDraw();

  xp= x2;
  yp= y2;

}

//Cadran Jeremy
