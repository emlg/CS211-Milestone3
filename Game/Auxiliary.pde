//Définition de la rotation
float change = 1;

//Définition de la boite
float boxX = 100, boxY = 10, boxZ = 100;

//Définition de la balle
float gravityCst = 0.9, normalForce = 1, mu = 0.15;
float frictionMagnitude = normalForce * mu;

//Définition de hough
float discretizationStepsPhi = 0.06f, discretizationStepsR = 2.5f;
int phiDim = (int) (Math.PI / discretizationStepsPhi);
PImage houghImg ;

//Calcul de la table des cosinus et sinus
float[] tabSin = new float[phiDim], tabCos = new float[phiDim];
float ang = 0, inverseR = (1.f / discretizationStepsR);
{
  for(int accPhi = 0; accPhi < phiDim; ang += discretizationStepsPhi, accPhi++){
    tabSin[accPhi] = (float) (Math.sin(ang) * inverseR);
    tabCos[accPhi] = (float) (Math.cos(ang) * inverseR);
  }
}

float round2(float nb){
  return (float) Math.round(nb*100)/100;
}