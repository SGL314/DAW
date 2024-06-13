class Astro{
  float dist;
  float r;
  float ang;
  float omega;
  color cor;
  
  Astro(){
    this.omega = ((float)random(1000) +1)/50;
    this.ang = 0;
    this.r = (int)random(50)+5;
    this.dist = (float)random(width/3)+75+this.r/2;
    this.cor = color((int)random(256),(int)random(256),(int)random(256));
  }

  Astro(int coe){
    this.omega = ((float)random(1000) +1)/50;
    this.ang = 0;
    this.r = 10*coe+5;
    this.dist = 75 + 20 + 100;
    this.cor = color((int)random(256),(int)random(256),(int)random(256));
  }
  
  void update(){
    this.ang += this.omega/frameRate*10;
    if (this.ang > 360) ang -= 360;
    if (this.ang < 0) ang += 360;
  }
  
  void show(){
    fill(this.cor);
    float x = this.dist * cos(radians(this.ang));
    float y = - this.dist * sin(radians(this.ang));
    ellipse(x,y,r,r);
  }
}