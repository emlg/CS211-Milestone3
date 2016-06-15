//Définition de la rotation
float change = 1;
float valueX, valueZ;
float angleX = 0, angleZ = 0;

//Définition de la boîte
static final float boxX = 100, boxY = 10, boxZ = 100;
PVector upLeft = new PVector(width/2f - boxX/2f, height/2f - boxZ/2f), 
   bottomRight = new PVector(width/2f + boxX/2f, height/2f + boxZ/2f);

//Définition de la balle
Mover ball = new Mover();
float r = 10;
static final float gravityCst = 0.9, normalForce = 1, mu = 0.15;
float frictionMagnitude = normalForce * mu;

//Définition des cylindres
boolean shiftMode = false;
static final int cylinderResolution = 8;
static final float cylinderBaseSize = 8, cylinderHeight = 25;
ArrayList<PVector> cylinders = new ArrayList<PVector>();

//Définition de la caméra
HScrollBar scrollBar;
PImage sVid, sDetect;
Boolean isPaused = false;

//Définition des fonctions utilitaires
float round2(float nb){
  return (float) Math.round(nb*100)/100;
}


 