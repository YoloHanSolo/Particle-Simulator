class Particle {
  float x = 0;
  float y = 0;
  float vx = 0;
  float vy = 0;
  float m = 0;
  float r = 0;
  int min_size = 3;
  int size = min_size;
  String name = "no_name";
  
  int attraction = 0;
  
  ArrayList<Integer> shadow_x = new ArrayList<Integer>();
  ArrayList<Integer> shadow_y = new ArrayList<Integer>();
  
  Particle(float x, float y, float vx, float vy, float m, float r, String name) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.m = m;
    this.r = r;
    this.name = name;
    this.setSize();
  }
    
  void setSize() {
    int new_size = int(log(this.m));
    if (new_size > size) {
      this.size = new_size; 
    }
  }
  
  void display() {
    noStroke();
    for(int i=0; i<shadow_x.size(); i++) {
      fill(255, i);
      circle(shadow_x.get(i), shadow_y.get(i), size/2);
    }
    fill(255, 255);
    circle(x, y, size);
    if (!this.name.equals("")) {
      text(this.name, x + size, y + size);
    }
    
  }
  
  void process_velocity() { 
    // GRAVITY/ATTRACTION
    Particle p;
    for(int i=0; i<particles.size(); i++) {
      p = particles.get(i);
      if (p == this) {
        continue;
      }
      if (p.m == 0) {
        continue; 
      }
      float distance = sqrt(pow(p.x - this.x, 2) + pow(p.y - this.y, 2));
      if (distance < (this.size + p.size) / 2) {
        continue;    
      }
      float gravity = p.m / pow(distance, 2);  
      float angle = atan((p.y - this.y) / (p.x - this.x));  
      int sign = 1;
      if (this.x > p.x) { 
        sign = -1;
      }   
      if (this.attraction == p.attraction) {
        //gravity = -gravity;
      }

      this.vx += sign * cos(angle) * gravity * e.dt;
      this.vy += sign * sin(angle) * gravity * e.dt; 
      if (this.vx > 0) {
        this.vx -= this.r; 
      } else if (this.vx < 0) {
        this.vx += this.r;  
      }
      if (this.vy > 0) {
        this.vy -= this.r; 
      } else if (this.vy < 0) {
        this.vy += this.r;  
      }
    } 
    // RESISTANCE
    if (this.r != 0) {
      if (this.vx > 0) {
        this.vx -= this.r;
      } else if (this.vx < 0) {
        this.vx += this.r;
      }
      if (this.vy > 0) {
        this.vy -= this.r;
      } else if (this.vy < 0) {
        this.vy += this.r;
      }
    }
  }
  
  void process_position() {
    if (shadow_x.size() < e.trail) {
      shadow_x.add(int(this.x));
      shadow_y.add(int(this.y));     
    } else if (e.trail > 0){
      shadow_x.remove(0);
      shadow_y.remove(0);
      shadow_x.add(int(this.x));
      shadow_y.add(int(this.y)); 
    }
    
    this.x += this.vx * e.dt;
    this.y += this.vy * e.dt;  
  }
  
}
