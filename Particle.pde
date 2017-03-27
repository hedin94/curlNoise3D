class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector oldPos;

  float maxSpeed = 2;

  float colour;
  float lifetime = 0;
  float timeStep = 0.1;
  
  float s = 40;

  Particle() {
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
    //pos = new PVector(random(width), random(height));
    pos = new PVector(width/2-s/2+random(s), height/2-s/2+random(s), depth/2-s/2+random(s));
    //pos = new PVector(random(width/2), random(height/2), random(depth/2));
    oldPos = pos.copy();
    colour = 250 + random(30);
  }

  void update() {
    oldPos = pos.copy();
    pos.add(vel);
    vel.add(acc);
    //vel.limit(maxSpeed);
    lifetime += timeStep;
   }

  void draw() {
    colorMode(HSB, 360, 100, 100, 100);
    stroke(colour, 100, 75, lifetime);
    //fill(colour);
    strokeWeight(2);
    line(oldPos.x, oldPos.y, oldPos.z, pos.x, pos.y, pos.z);
   //point(pos.x, pos.y, pos.z);
    colorMode(RGB, 255, 255, 255, 100);
  }
}