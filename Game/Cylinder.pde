class Cylinder {
  int tableSize = cylinderResolution + 1;
  PShape openCylinder = new PShape(), closeUp = new PShape(), closeBottom = new PShape();

  Cylinder() {
    float angle;
    float[] x = new float[tableSize], y = new float[tableSize];

    //get the x and y position on a circle for all the sides
    for (int i = 0; i < x.length; i++) {
      angle = (TWO_PI / cylinderResolution) * i;
      x[i] = sin(angle) * cylinderBaseSize;
      y[i] = cos(angle) * cylinderBaseSize;
    }

    //Création du cylindre
    openCylinder = createShape();
    openCylinder.beginShape(QUAD_STRIP);
    for (int i = 0; i < x.length; i++) {
      openCylinder.vertex(x[i], 0, y[i]);
      openCylinder.vertex(x[i], cylinderHeight, y[i]);
    }
    openCylinder.endShape();

    //Fermeture du bas
    closeBottom = createShape();
    closeBottom.beginShape(TRIANGLES);
    for (int i = 0; i < x.length; i++) {
      closeBottom.vertex(x[i], 0, y[i]);
      closeBottom.vertex(0, 0, 0);
      closeBottom.vertex(x[(i+1)% x.length], 0, y[(i+1) % x.length]);
    }
    closeBottom.endShape();

    //Fermeture du haut
    closeUp = createShape();
    closeUp.beginShape(TRIANGLES);
    for (int i = 0; i < x.length; i++) {
      closeUp.vertex(x[i], cylinderHeight, y[i] );
      closeUp.vertex(0, cylinderHeight, 0);
      closeUp.vertex(x[(i+1)% x.length], cylinderHeight, y[(i+1) % x.length]);
    }
    closeUp.endShape();
  }

  void display(float x, float y, float z) {
    pushMatrix();
    translate(x, y, z);
    if (shiftMode) rotateX(PI/2);
    shape(openCylinder);
    shape(closeBottom);
    shape(closeUp);
    popMatrix();
  }
}