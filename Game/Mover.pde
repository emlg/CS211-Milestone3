class Mover {
  PVector location, velocity, gravity, friction;

  Mover(){
    location = new PVector(0, 0);
    velocity = new PVector(1, 1);
  }
  
  void update(float angleZ, float angleX){
    gravity = new PVector(sin(angleZ) * gravityCst, -sin(angleX) * gravityCst);
    friction = velocity.copy();
    friction.mult(-1).normalize().mult(frictionMagnitude);
    location.add(velocity.add(friction.add(gravity)));
  }
  
  void display(){
    pushMatrix();
      noStroke();
      fill(100, 0, 0);
      translate(location.x, -boxY/2-r, location.y);
      sphere(r);
    popMatrix();
  }

  void checkEdges(){
    if(location.x > boxX/2 - r/2){
      location.x = boxX/2 -r/2;
      velocity.x = -1*velocity.x;
      if(velocity.mag() > 1) score -= round2(ball.velocity.mag());
    } else if(location.x < r/2 - boxX/2){
      location.x = r/2 - boxX/2;
      velocity.x = -velocity.x;
      if(velocity.mag() > 1) score -= round2(ball.velocity.mag());
    }
    
    if(location.y > boxZ/2 - r/2){
      location.y = boxZ/2 - r/2;
      velocity.y = -velocity.y;
      if(velocity.mag() > 1) score -= round2(ball.velocity.mag());
    } else if(location.y < r/2 - boxZ/2){
      location.y = r/2 - boxZ/2;
      velocity.y = -velocity.y;
      if(velocity.mag() > 1) score -= round2(ball.velocity.mag());
    }
  }

  void checkCylinderCollision(){
    if(cylinders.size() != 0){
      for(int i = 0; i < cylinders.size(); i++) {
        PVector tmpL = location.copy();
        PVector cyl = new PVector(cylinders.get(i).x - width/2, cylinders.get(i).y - height/2);
        if(cyl.dist(location) <= r + Cylinder.cylinderBaseSize){
          if(velocity.mag() > 1) score += round2(ball.velocity.mag());
          PVector tmpV = velocity.copy();
          PVector n = (location.sub(cyl)).normalize();
          n = n.mult(2*tmpV.dot(n));
          velocity = tmpV.sub(n);
          location = tmpL.add(velocity);
          cylinders.remove(i);
        }
      }
    }
  }
}