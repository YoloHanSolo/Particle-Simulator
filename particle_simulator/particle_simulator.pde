ArrayList<Particle> particles = new ArrayList<Particle>();
Enviroment e;

int example = 2;

int frame = 0;
boolean recording = false;

void setup() {
  size(400, 400);
  background(0);
  textSize(12);
  
  // SOLAR
  if (example == 0) {
    e = new Enviroment(1, 256, "open", false, 0);
    particles.add(new Particle(width / 2, 500, 0, 0, 1000000, 0, "sun"));
    particles.add(new Particle(width / 2, 600, 120, 0, 1, 0, "tara"));
    /*
    particles.add(new Particle(width / 2, 525, 185, 0, 1, 0, "mercury"));
    particles.add(new Particle(width / 2, 555, 130, 0, 10, 0, "venus"));
    particles.add(new Particle(width / 2, 580, 110, 0, 10, 0, "earth"));
    particles.add(new Particle(width / 2, 620, 90, 0, 5, 0, "mars"));
    particles.add(new Particle(width / 2, 750, 65, 0, 15000, 0, "jupiter"));
    particles.add(new Particle(width / 2 - 15, 750, 66, 25, 0.01, 0, "ganymede"));
    particles.add(new Particle(width / 2, 735, 35, 0, 0.01, 0, "europa"));
    particles.add(new Particle(width / 2, 765, 95, 0, 0.01, 0, "callisto"));
    particles.add(new Particle(width / 2 + 15, 750, 55, -25, 0.01, 0, "io"));
    particles.add(new Particle(width / 2, 900, 50, 0, 3000, 0, "saturn"));
    particles.add(new Particle(width / 2, 910, 55, 0, 0.01, 0, "titan"));
    */   
  } else if (example == 1) {
    e = new Enviroment(0.01, 5, "repeat", true, 0);
    particles.add(new Particle(width / 2, height / 2, 0, 0, 1000000, 0, "sun"));
    float x, y, vx, vy;
    for (int i=0; i<500; i++) {
      x = random(width / 2 - 300, width / 2 + 300);
      y = random(height / 2 - 300, height / 2 + 300);
      vx = random(-50, 50);
      vy = random(-50, 50);
      particles.add(new Particle(x, y, vx, vy, 1, 0, ""));
    }
  }
  
  else if (example == 2) {
    Particle p;
    e = new Enviroment(0.1, 64, "repeat", false, 0);
    for (int i=0; i<20; i++) {
      p = new Particle(random(0, width), random(0, height), 0, 0, 100, 0, "1");
      p.attraction = 1;
      particles.add(p);
    }
    for (int i=0; i<20; i++) {
      p = new Particle(random(0, width), random(0, height), 0, 0, 100, 0, "2");
      p.attraction = 2;
      particles.add(p);
    }
  }
}

void draw() {
  background(0);
  
  Particle p;
  for(int i=0; i<particles.size(); i++) {
    p = particles.get(i);
    p.process_velocity();
    p.process_position();
    e.process();
    p.display();
    ;
  }
  
  frame += 1;
  if (recording && frame % 5 == 0) {
    saveFrame("images/img_####.png"); 
  }
  println(frame);
  
}
