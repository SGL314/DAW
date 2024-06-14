class Astro{
  float dist;
  float r;
  float ang;
  float omega;
  color cor;
  double massa;
  double x=0,y=0;
  double vel=0,angVel=0;
  double velX=0,velY=0;
  double cx = 0,cy =0;
  Vector[] Vets;
  private double G = 6.6743*pow(10,-11);
  int lineTraj = 0;
  boolean isStar = false;
  boolean onLux = false;
  String nome;
  int qtLines = 0;
  
  ArrayList<Point> rastro = new ArrayList<Point>();

  int lineVel = 0;
  int lineFor = 0;
  int typeFuncRaw = 0;

  public color padcolor(int sum){
    return color((int) random(255-sum)+sum,(int) random(255-sum)+sum,(int) random(255-sum)+sum);
  }

  private void funcRaw(int type){
    switch (type){
      case 0: // BlackHole
        this.r = (pow((float) this.massa/PI,0.5f)+5/0.5)*0.5f/3.1622776601683793319988935444327;
        break;
      case 1: // Star
        this.r = (pow((float) this.massa/PI,0.5f)+5/0.5)*0.5;
        break;
      case 2: // Planet
        this.r = (pow((float) this.massa/PI,0.5f)+5/0.3)*0.3f;
        break;
      case 3: // Asteroid
        this.r = (pow((float) this.massa/PI,0.5f)+5/0.5)*0.5*0.75;
        break;
    }
    this.typeFuncRaw = type;
  }
  private void funcRaw(){
    switch (this.typeFuncRaw){
      case 0: // Star
        this.r = (pow((float) this.massa/PI,0.5f)+5/0.3)*0.3f;
        break;
      case 1: // Planet
        this.r = (pow((float) massa/PI,0.5f)+5/0.5)*0.5;
        break;
      case 2: // Asteroid
        this.r = (pow((float) massa/PI,0.5f)+5/0.5)*0.5*0.75;
        break;
    }
  }
  
  Astro(String nome,double massa,double x,double y){
    this.omega = ((float)random(1000) +1)/50;
    this.ang = 0;
    //funcRaw(0);
    this.dist = (float)random(width/3)+75+this.r/2;
    this.cor = padcolor(128);
    this.massa = massa;
    this.x = x;
    this.y = y;
    this.nome = nome;
  }
  Astro(String nome,double massa,double x,double y,double vel,double angVel){
    this.omega = ((float)random(1000) +1)/50;
    this.ang = 0;
    //funcRaw(1);
    this.dist = (float)random(width/3)+75+this.r/2;
    this.cor = padcolor(128);
    this.massa = massa;
    this.x = x;
    this.y = y;
    this.vel = vel;
    this.angVel = angVel;
    this.nome = nome;
  }

  public void init(int qt){
    this.Vets = new Vector[qt];
    for (int i=0;i<qt;i++){
      Vets[i] = new Vector(0,0);
    }

    double descX=0,descY=0;
    float ang;
    ang = round((float) (this.angVel*1000000))/1000000;
    this.angVel *= PI/180;
    this.angVel = (double) round((float) (this.angVel*1000000))/1000000;

    if (ang != 90 && ang != 270){
      descX = vel*cos((float) this.angVel);
    }
    if (ang != 0 && ang != 180){
      descY = vel*sin((float) this.angVel);
    }

    //print(ang + ">" + descX + " : " + descY + "\n");

    this.velX += descX;
    this.velY += descY;

  }

  private void forces(){
    double compX=0,compY=0;
    float a;
    for (Vector v : Vets){
      a = round((float) v.a*180/PI*1000000)/1000000;
      if (a != 90 && a != 270)
        compX += v.v*cos((float) v.a);
      if (a != 0 && a != 180)
        compY += v.v*sin((float) v.a);
    }
    for (Vector vec : Vets){
      vec.a = 0;
      vec.v = 0;
    }
    //print("/" + compX + "/" + compY + "/\n");
    this.cx = compX;
    this.cy = -compY;

    this.velX += compX/this.massa;
    this.velY += -compY/this.massa;
  }
  
  private void update(double temp){
    double descX=0,descY=0;
    forces();
    this.x += this.velX * temp;
    this.y += this.velY * temp;
    
    synchronized(this){
      rastro.add(new Point(this.x,this.y));
      if(rastro.size() > 1000/temp) rastro.remove(0);
    }
  }

  private void sleep(float segs){
    int m = millis();
    while (millis()-m<segs*1000);
  }

  private Draw[] lux(int tam){
    stroke(0);
    float r1=0,r2=0,g1=0,g2=0,b1=0,b2=0,tot = (int) pow(16,6);
    int dist = 200,p=1,resCor;
    float varR,varG,varB;

    b1 = (tot+this.cor)%((int)pow(16,2));
    g1 = (tot+this.cor-b1)/((int)pow(16,2))%((int)pow(16,2));
    r1 = ((tot+this.cor-b1)/((int)pow(16,2))-g1)/((int)pow(16,2));

    float coeDiscolor = 0.75;
    float coeDist = 20;
    dist *= 1/coeDist*10;

    r1 *= coeDiscolor;
    g1 *= coeDiscolor;
    b1 *= coeDiscolor;

    varR = (r2-r1)/dist;
    varG = (g2-g1)/dist;
    varB = (b2-b1)/dist;

    r1=0;
    g1=0;
    b1=0;
    Draw[] draws = new Draw[dist];
    this.qtLines=0;
    while (p<=dist){
      r1 += -varR;
      g1 += -varG;
      b1 += -varB;
      draws[p-1] = new Draw(color(r1,g1,b1,5),(float) this.x,(float) this.y,r+dist*coeDist-p*coeDist,r+dist*coeDist-p*coeDist,"ellipseNsT");
      p++;
      this.qtLines++;
    }
    return draws;
  }

  public Draw[] show(double temp){
    Draw[] draws = new Draw[3];
    

    float coe = 1f;
    synchronized(this){
      int tam = 3;
      if (this.isStar && this.onLux){
        Draw[] res = lux(tam);
        draws = new Draw[tam+qtLines];
        int i =0;
        for (Draw dr : res){
          draws[3+i] = dr;
          i++;
        }
      }
      if (this.lineTraj == 1){
        draws = new Draw[3+rastro.size()];
        fill(this.cor);
        stroke(this.cor);
        for(int k = 0; k < rastro.size(); k++){
          draws[3+k] = new Draw(this.cor,this.cor,(float)rastro.get(k).x,(float)rastro.get(k).y,"point");
        }
      }
    }

    draws[0] = new Draw("None"); // força
    draws[1] = new Draw("None"); // velocidade
    draws[2] = new Draw("None"); // astro
    draws[0] = new Draw(0,this.cor,(float) this.x,(float) this.y,this.r,"ellipse");
    
    if (this.lineVel == 1){
      draws[1] = new Draw(#0000FF,(float) this.x,(float) this.y,(float) (this.x+this.velX*coe),(float) (this.y+this.velY*coe),"line");
    }
    if (this.lineFor == 1){
      coe /= temp;
      draws[2] = new Draw(#FF0000,(float) this.x,(float) this.y,(float) (this.x+this.cx*coe),(float) (this.y+this.cy*coe),"line");
    }
    
    
    return draws;
  }
}
