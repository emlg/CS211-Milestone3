void keyPressed(){
  if(key == CODED)
    if(keyCode == SHIFT){
      shiftMode = true;
      isPaused = true;
      cam.pause();
    }
}

void keyReleased(){
  if(key == CODED)
    if(keyCode == SHIFT){
      shiftMode = false;
      isPaused = false;
      cam.play();
    }
}

void mouseWheel(MouseEvent event) {
  change += event.getCount();
  change = change * 0.1;
  if(change > 1.5) change = 1.5;
  else if(change < 0.2) change = 0.2;
  println(change);
}

void mouseClicked(){
  if(shiftMode){
    PVector position = new PVector(mouseX, mouseY);
    PVector p2 = new PVector(mouseX - width/2, mouseY - height/2);
    if(position.x >= upLeft.x + cylinderBaseSize
    && position.x <= bottomRight.x - cylinderBaseSize
    && position.y >= upLeft.y +  cylinderBaseSize
    && position.y <= bottomRight.y -  cylinderBaseSize
    && ball.location.dist(p2) > r + cylinderBaseSize)
        cylinders.add(position);
  }
}