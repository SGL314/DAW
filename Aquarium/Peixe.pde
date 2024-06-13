class Peixe{
  float vx = 0;
  float vy = 0;
  float px,py;
  int it = 600;
  color corbody;
  color corcauda;
  int dx = 0;
  int dy = 0;


  Peixe(int distX,int distY){
    this.dx = distX;
    this.dy = distY;
    this.px = random(dx,width-dx);
    this.py = random(dy,height-dy);
    corbody = color((int) random(255),(int) random(255),(int) random(255));
    corcauda = color((int) random(255),(int) random(255),(int) random(255));
  }

  void Move(){
    if (it==600){
      vx = random(9)+1 * (2*random(2)-1);
      vy = random(9)+1 * (2*random(2)-1);
      it -=600;
    }
    it++;
    this.px += vx;
    this.py += vy;
    if (this.px < dx) this.vx *= -1;
    if (this.px > width-dx) this.vx *= -1;
    if (this.py < dy) this.vy *= -1;
    if (this.py > height-dy) this.vy *= -1;
  }

  void Desenha(){
    int tamx = 60;
    int tamy = 30;
    int tamcauda = 18;
    fill(corbody);
    ellipse(px,py,tamx,tamy);
    fill(corcauda);
    if (this.vx < 0){
      fill(corcauda);
    triangle(px+tamx/2,py,
    px+tamx/2+tamcauda,py-tamy/2,
    px+tamx/2+tamcauda,py+tamy/2);
    }else{
      fill(corcauda);
      triangle(px-tamx/2,py,
    px-tamx/2-tamcauda,py-tamy/2,
    px-tamx/2-tamcauda,py+tamy/2);
    
    
  }
  }
}