//Définition de la boite
float boxX = 100, boxY = 10, boxZ = 100;

//Définition de la rotation
float change = 1;

//Définition de hough
float discretizationStepsPhi = 0.06f, discretizationStepsR = 2.5f;
int phiDim = (int) (Math.PI / discretizationStepsPhi);
PImage houghImg ;

float round2(float nb){
  return (float) Math.round(nb*100)/100;
}