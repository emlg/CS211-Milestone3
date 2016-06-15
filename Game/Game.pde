void settings(){
  size(500, 500, P3D);
}

int border = 5;
PGraphics bottomSquare;
int bottomSquareHeight = 100;
PGraphics topView;
int topViewSize = bottomSquareHeight - 2*border;
float score = 0;
PGraphics scoreBoard;
int scoreBoardSize = topViewSize;

PGraphics barChart;
int barChartHeight = bottomSquareHeight - 3*border;
int barChartWidth = width - topViewSize - scoreBoardSize - 4 * border;

void setup(){
  noStroke();
  
  bottomSquare = createGraphics(width, bottomSquareHeight, P2D);
  topView = createGraphics(topViewSize, topViewSize, P2D);
  scoreBoard = createGraphics(scoreBoardSize, scoreBoardSize, P2D);
  barChart = createGraphics(barChartWidth, barChartHeight, P2D);
  scrollBar = new HScrollBar(3*border + topViewSize + scoreBoardSize, bottomSquareHeight - 2*border, barChartWidth, border);
  
  pushMatrix();
    translate(width/2, height/2, 0);
    valueX = width/2.0;
    valueZ = height/2.0;
  popMatrix();
  
  setupCam();
}

void draw(){
  computeAngles();

  if(angles == null){
    angleX = 0;
    angleZ = 0;
  } else {
    angleX = min(max(-angles.x, -PI/6), PI/6);
    angleZ = min(max(-angles.y, -PI/6), PI/6);
  }

  background(200);
  lights();
  
  if(!shiftMode){
    drawUnShiftMode();
  } else {
    drawShiftMode();
  } 
}