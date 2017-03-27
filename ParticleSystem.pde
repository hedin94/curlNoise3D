class ParticleSystem {

  float spawnRate = 1;
  float spawnMult = 20;
  float maxSpawns = 10000;

  float fieldWeight = 2;
  float viscosity = 0.8;

  float t = 0;
  float timeStep = 0.001;
  float noiseScl = 0.005;

  ArrayList<Particle> particles;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }

  void update() {
    spawn();
    cleanup();
    for (Particle p : particles) {
      PVector pos = p.pos.copy();
      pos.mult(noiseScl);
      //pos.z = t;
      //p.acc.add(curl2D(pos).mult(fieldWeight));
      //p.acc.mult(1-viscosity);
      p.vel = curl3D(pos).mult(fieldWeight);
      p.update();
    }
    t += timeStep;
  }

  void draw() {
    for (Particle p : particles)
      p.draw();
  }

  void spawn() {
    if (particles.size() < maxSpawns)
      if (random(1) < spawnRate)
        for (int i = 0; i < spawnMult; i++)
          particles.add(new Particle());
  }

  void cleanup() {
    int i = 0;
    while (i < particles.size()) {
      PVector pos = particles.get(i).pos;
      if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height || pos.z < 0 || pos.z > depth)
        particles.remove(i);
      else
        i++;
    }
  }

  PVector curl2D(float x, float y) {
    return curl2D(new PVector(x, y));
  }

  PVector curl2D(float x, float y, float z) {
    return curl2D(new PVector(x, y, z));
  }

  PVector curl2D(PVector v) {
    float e = 0.001;
    float n1, n2, x, y;

    n1 = noise(v.x, v.y + e, v.z);
    n2 = noise(v.x, v.y - e, v.z);
    x = (n1-n2)/(2*e);

    n1 = noise(v.x + e, v.y, v.z);
    n2 = noise(v.x - e, v.y, v.z);
    y = (n1-n2)/(2*e);

    return new PVector(x, -y);
  }

  PVector curl3D(float x, float y, float z) {
    return curl3D(new PVector(x, y, z));
  }

  PVector curl3D(float x, float y, float z, float t) {
    return curl3D(new PVector(x, y, z), t);
  }

  PVector curl3D(PVector v) {
    return curl3D(v, 0);
  }

  PVector curl3D(PVector v, float t) {
    float e = 0.01;
    float n1, n2, a, b; 
    float x, y, z;

    // x = dz1/dy - dy1/dz
    n1 = noise(v.x, v.y + e, v.z);
    n2 = noise(v.x, v.y - e, v.z);
    a = (n1-n2)/(2*e);

    n1 = noise(v.x, v.y, v.z + e);
    n2 = noise(v.x, v.y, v.z - e);
    b = (n1-n2)/(2*e);

    x = a-b;

    // y = dx1/dz - dz1/dx
    n1 = noise(v.x, v.y, v.z + e);
    n2 = noise(v.x, v.y, v.z - e);
    a = (n1-n2)/(2*e);

    n1 = noise(v.x + e, v.y, v.z);
    n2 = noise(v.x - e, v.y, v.z);
    b = (n1-n2)/(2*e);

    y = a-b;

    // z = dy1/dx - dx1/dy
    n1 = noise(v.x + e, v.y, v.z);
    n2 = noise(v.x - e, v.y, v.z);
    a = (n1-n2)/(2*e);

    n1 = noise(v.x, v.y + e, v.z);
    n2 = noise(v.x, v.y - e, v.z);
    b = (n1-n2)/(2*e);

    z = a-b;

    return new PVector(x, y, z);
  }
}