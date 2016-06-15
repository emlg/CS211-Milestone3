void drawBottomSquare(){
  bottomSquare.beginDraw();
  bottomSquare.background(110, 111, 150);
  bottomSquare.endDraw();
}

void drawTopView(){
  topView.beginDraw();
  topView.background(200);
  topView.noStroke();
  if (!cylinders.isEmpty()) {
    topView.fill(250, 160, 25);
    for (int i = 0; i< cylinders.size(); i++) {
      float coordX = map(cylinders.get(i).x, width/2 - boxX/2, width/2 + boxX/2, 0, topViewSize);
      float coordY = map(cylinders.get(i).y, height/2 - boxZ/2, height/2 + boxZ/2, 0, topViewSize);
      topView.ellipse(coordX, coordY, cylinderBaseSize*2*topViewSize/boxX, cylinderBaseSize*2*topViewSize/boxX);
    }
  }
  topView.fill(100, 0, 0);
  topView.ellipse(topViewSize/2 + ball.location.x * topViewSize/boxX, 
    topViewSize/2 + ball.location.y * topViewSize/boxZ, 
    2 * r * topViewSize/boxX, 2 * r * topViewSize/boxX);
  topView.endDraw();
}

void drawScoreBoard(){
  scoreBoard.beginDraw(); 
  scoreBoard.background(110, 111, 150);
  pushMatrix();
    scoreBoard.noFill();
    scoreBoard.stroke(255);
    scoreBoard.strokeWeight(3);
    scoreBoard.rect(0, 0, scoreBoardSize, scoreBoardSize);
    scoreBoard.text("Total Score:\n" + round2(score) + "\nvelocity: \n" + round2(ball.velocity.mag()), 3, border + 5);
  popMatrix();
  scoreBoard.endDraw();
}

void drawBarChart() {
  barChart.beginDraw();
  //selecting the values and store
  int barWidth = (int) (5 * scrollBar.getPos());

  barChart.background(110, 111, 150);
  count += 1;
  if (count >= maxNb) {
    count = 0;
    barChartValues.add((int)Math.round(score));
    if (playerMax < score) playerMax = score;
  }

  for (int i = 0; i < barChartValues.size(); i++) {
    int currScore= 0; 
    if (barChartValues.get(i)> 0) currScore = barChartValues.get(i);
    barHeight = currScore* maxBarHeight/playerMax;
    barChart.noStroke();
    barChart.fill(130, 90, 50);
    barChart.rect(i*barWidth, maxBarHeight - barHeight, barWidth, barHeight);
  }
  barChart.endDraw();
}

void drawUnShiftMode() {
  sVid = vid.copy();
  sVid.resize(64*2, 48*2);
  image(sVid, 0, 0);

  sDetect = detect.copy();
  sDetect.resize(64*2, 48*2);
  image(sDetect, 64*2, 0);

  translate(width/2, height/2, 0);
  pushMatrix();
    translate(-width/2, height/2 -bottomSquareHeight, 0);
    drawBottomSquare();
    image(bottomSquare, 0, 0);
    drawTopView();
    image(topView, border, border);
    drawScoreBoard();
    image(scoreBoard, 2*border + topViewSize, border);
    drawBarChart();
    image(barChart, 3*border + topViewSize + scoreBoardSize, border);
    scrollBar.update();
    scrollBar.display();
  popMatrix();

  pushMatrix();
    rotateX(angleX - PI/2);
    rotateZ(angleZ);
    fill(150);
    box(boxX, boxY, boxZ);   
    for (int i = 0; i < cylinders.size(); i++) {
      fill(250, 160, 25);
      Cylinder newCylinder = new Cylinder();
      newCylinder.display(cylinders.get(i).x - width/2, - boxY/2 - cylinderHeight, cylinders.get(i).y - height/2);
    }
    pushMatrix();
      ball.update(angleZ, angleX);
      ball.checkEdges();
      ball.checkCylinderCollision();
      ball.display();
    popMatrix();
  popMatrix();
}

void drawShiftMode() {
  translate(width/2, height/2, 0);
  background(135, 7, 40);
  fill(150);
  box(boxX, boxZ, boxY);
  for (int i = 0; i < cylinders.size(); i++) {
    fill(250, 160, 25);
    Cylinder newCylinder = new Cylinder();
    newCylinder.display(cylinders.get(i).x - width/2, cylinders.get(i).y - height/2, boxY/2);
  }
}