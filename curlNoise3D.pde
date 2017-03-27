import peasy.*;

ParticleSystem particleSystem;
float depth = 500;

PeasyCam cam;
//HScrollbar SBFieldWeight;
//HScrollbar SBNoiseScl;

PFont f;
float fieldW = 1;
float minFieldW = 0.5;
float maxFieldW = 10;
float fieldWStep = 0.5;

float noiseScale = 0.001;
float minNoiseScale = 0.001;
float maxNoiseScale = 0.1;
float noiseScaleStep = 0.001;

void setup() {
  size(800, 600, P3D);
  background(0);
  //camera(400, 500, 0, 
  //  width/2, height/2, depth/2, 
  //  0, 1, 0);

  cam = new PeasyCam(this, width/2, height/2, depth/2, 400);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(100000);
  particleSystem = new ParticleSystem();

  //SBFieldWeight = new HScrollbar(0, 10, width, 16, 16);
  //SBNoiseScl = new HScrollbar(0, 30, width, 16, 16);

  f = createFont("Arial", 16, true);
}

void draw() {
  //background(0);
  fill(0, 5);
  //noFill();
  noStroke();
  //stroke(150);
  pushMatrix();
  translate(width/2, height/2, depth/2);
  //rotateY(0.5);
  box(width, height, depth);
  popMatrix();

  //translate(width/2, height/2, depth/2);
  particleSystem.fieldWeight = fieldW;
  particleSystem.noiseScl = noiseScale;
  particleSystem.update();
  particleSystem.draw();
  println(floor(frameRate), particleSystem.particles.size());

  cam.beginHUD();
  fill(50);
  rect(0, 0, 175, 100);
  fill(255);
  textFont(f, 16);
  text("Field Weight: " + fieldW, 10, 40);
  text("Noise Scale:  " + noiseScale, 10, 70);
  cam.endHUD();
}

void incFieldWeight() {
  if (fieldW  + fieldWStep <= maxFieldW) fieldW += fieldWStep;
}

void decFieldWeight() {
  if (fieldW > fieldWStep) fieldW -= fieldWStep;
}

void incNoiseScale() {
  if (noiseScale + noiseScaleStep <= maxNoiseScale) noiseScale += noiseScaleStep;
}

void decNoiseScale() {
  if (noiseScale > noiseScaleStep) noiseScale -=  noiseScaleStep;
}

void keyPressed() {
  if (key == 'z')
    decFieldWeight();
  else if (key == 'x')
    incFieldWeight();
  else if (key == 'c')
    decNoiseScale();
  else if (key == 'v')
    incNoiseScale();
}