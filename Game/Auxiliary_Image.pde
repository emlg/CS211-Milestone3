//Définition de la caméra
Movie cam;
PImage vid, detect;

//Définition des graphes
PVector angles;
List<int[]> quads;
List<PVector> corners, lines;
QuadGraph quadGraph = new QuadGraph();