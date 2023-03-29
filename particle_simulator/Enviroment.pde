class Enviroment {
  float dt = 0.0;
  int trail = 0;
  String border = "";
  String collision = "";
  boolean kill = false;
  float resistance = 0.0;
  
  // border - open, closed, repeat
  Enviroment(float dt, int trail, String border, String collision, float resistance) {
    this.dt = dt;
    this.trail = trail;
    this.border = border;
    this.collision = collision;
    this.resistance = resistance;
  }
  
  void process() {
    process_collision(); 
    process_border();
  }
  
  void process_border() {
    if (border.equals("open")) {
      return; 
    }
    
    Particle p;
    
    for(int i=0; i<particles.size(); i++) {
      p = particles.get(i);
        
      if (border.equals("closed")) {
        if (p.x >= width) {
          p.x = width-1;
          p.vx = -p.vx; 
        } else if (p.x < 0) {
          p.x = 0;
          p.vx = -p.vx; 
        }
        if (p.y >= height) {
          p.y = height-1;
          p.vy = -p.vy;
        } else if (p.y < 0) {
          p.y = 0;
          p.vy = -p.vy;
        }     
        
      } else if (border.equals("repeat")) {
        if (p.x >= width) {
          p.x = p.x - width;
        } else if (p.x < 0) {
          p.x = width + p.x; 
        }
        if (p.y >= height) {
          p.y = p.y - height;
        } else if (p.y < 0) {
          p.y = height + p.y; 
        }       
      }
    }
  }
  
  void process_collision() {
    if (this.collision.equals("combine")) {
      Particle p1;
      Particle p2;
      Particle n;
      float distance;
      float vx;
      float vy;
      float ratio1;
      float ratio2;
      boolean done = false;
      
      while (!done) {
        done = true;
        for(int i=0; i<particles.size(); i++) {
          for(int k=i+1; k<particles.size(); k++) {
            p1 = particles.get(i);
            p2 = particles.get(k);
            distance = sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));   
            if (distance > (p1.size + p2.size) / 2) {
              continue;    
            }
            if (p2.m > p1.m) {
              p1 = particles.get(k);
              p2 = particles.get(i);        
            }
            ratio1 = p1.m / (p1.m + p2.m);  
            ratio2 = p2.m / (p1.m + p2.m);
            if (p1.m == 0 && p2.m == 0) {
              ratio1 = 1;
              ratio2 = 1;  
            }
            vx = (p1.vx * ratio1) + (p2.vx * ratio2);
            vy = (p1.vy * ratio1) + (p2.vy * ratio2);
            n = new Particle(p1.x, p1.y, vx, vy, p1.m + p2.m, this.resistance, "");  
            particles.remove(k);
            particles.remove(i);
            particles.add(n);
            done = false;
          }
          if (!done) {
            break; 
          }
        }    
      }  
    } else if (this.collision.equals("stop")) {
      Particle p1;
      Particle p2;
      float distance;
      
      for(int i=0; i<particles.size(); i++) {
        for(int k=i+1; k<particles.size(); k++) {
          p1 = particles.get(i);
          p2 = particles.get(k);
          distance = sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));   
          if (distance > (p1.size + p2.size) / 2) {
            continue;    
          }
          p1.vx = p1.vx * (1 - 0.01);
          p1.vy = p1.vy * (1 - 0.01);
          p2.vx = p2.vx * (1 - 0.01);
          p2.vy = p2.vy * (1 - 0.01);
        }
      }         
    } 
  } 
}
