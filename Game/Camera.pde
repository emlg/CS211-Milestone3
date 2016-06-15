import processing.video.*;

void setupCam() {
  cam = new Movie(this, "/Users/emma/Cours/Sem4/Informatique visuelle/InfoVis-Projet/Game/testVideo.mp4");
  cam.loop();
  angles = new PVector(0, 0, 1);
}


void computeAngles() {

  cam.read();
  vid = cam.get();

  detect = saturationMap(brightnessMap(hueMap(vid, 50, 130), 50, 180), 120, 255);
  detect = sobel(brightnessMap(convolute(detect), 100, 255));
  lines = hough(detect, 5);
  
  quadGraph.build(lines, detect.width, detect.height);
  quads = quadGraph.findCycles();
  float min_area = detect.width * detect.height * (1/10);
  float max_area = detect.width * detect.height * (9/10);

  Boolean quadFound = false;

  for (int[] quad : quads) {
    PVector l1 = lines.get(quad[0]), l2 = lines.get(quad[1]), l3 = lines.get(quad[2]), l4 = lines.get(quad[3]);
    PVector c12 = getIntersection(l1, l2), c23 = getIntersection(l2, l3), c34 = getIntersection(l3, l4), c41 = getIntersection(l4, l1);
    float area = quadGraph.area(c12, c23, c34, c41);

    if(area < max_area && area > min_area && quadGraph.isConvex(c12, c23, c34, c41)){
      quadFound = true;
      min_area = area;

      corners.clear(); corners.add(c12); corners.add(c23); corners.add(c34); corners.add(c41);
    }
  }

  if (!quadFound)
    return;

  angles = (new TwoDThreeD(detect.width, detect.height)).get3DRotations(quadGraph.sortCorners(corners));
}