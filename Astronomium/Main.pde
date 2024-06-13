Astro[] astros = new Astro[0];
int coeVel = 10;
int qtCentr = 5;
int qtBlHl = 1;
int qtMoons = 1;
int qtStars = 2;
int qt = qtCentr+qtMoons+qtBlHl+qtStars;
double G = 6.6743*pow(10,-2);
boolean run = false;
float tx=0,ty=0;
int posObj = 0;
float coeDil = 1;
int count = 0;
int lineTraj = 0;
boolean passFrame = false;
boolean do_passFrame = false;
int show_lineVel = 0;
int show_lineFor = 0;
int loop = -1;
float fps = 0;
int FraRat =100;
boolean do_FraRat = false;
double coeTemp = 1;

void setup(){
  size(1000,1000);
  background(#000000);
  createAstros();
  
  tx = width/2;
  ty = height/2;
  coeDil = 1;
  thread("counterFps");
}

double Pow(double a,double b){
  return (double) pow((float) (a), (float) (b));
}

float sqrt(double val){
  return sqrt((float) val);
}

void createAstros(){
  astros = new Astro[qt];
  int coeDist = 250;
  double D=0,V=0,d=0,v=0,a,dx,dy,setAngVel,velOrbit;
  double velStar = 6; // 6
  double velStar2 = 4;
  int CoemassBlHl = 0;
  int CoemassStar = 1;
  int CoemassStar2 = 0;
  boolean do_simulation = false;
  for (int i=0;i<astros.length;i++){
    if (i==1){
      D = -75-(i-1)*coeDist;
      V = -(4-i/2-1);
    }
    if (i < qtStars){
      astros[i] = new Astro(100000,0,0,velStar,0);
      
      astros[i].massa = (1*pow(10,5)-0.00001)*CoemassStar + 0.001;
      astros[i].init(qt);
      astros[i].cor = #FFF412;
      if (i == 1){
        astros[i] = new Astro(100000,0,0,velStar2,180);
        astros[i].y = -30000;
        astros[i].massa = (5*pow(10,6)-0.00001)*CoemassStar2 + 0.001;
        astros[i].init(qt);
        astros[i].cor = #F23918;
      }
      astros[i].funcRaw(1);
      astros[i].isStar = true;
    }else if (i < qtCentr+qtStars){
      d = -100-(i-qtStars)*coeDist;
      v = (double) -(sqrt((float) (Pow(V,2) * (D/d)))) * sqrt(astros[0].massa/10000) -velStar;
      astros[i] = new Astro(1000,0,(float) d,(float) v,180);
      astros[i].init(qt);
      if (do_simulation)
        if (i != qtCentr+qtStars-1){
          astros[i].velX = -100;
          astros[i].massa = 0.0001;
        }else{
          astros[i].velX = 0;
          velStar = 0;
        }
      astros[i].funcRaw(2);
    }else if (i < qtCentr+qtStars+qtBlHl){
      v = 0;
      d = -15000;
      astros[i] = new Astro(1000000,0,(float) d,(float) v,180);
      astros[i].cor = #6BD1F7;
      astros[i].massa = (10*pow(10,6)-1)*CoemassBlHl + 1;
      astros[i].funcRaw(0);
      astros[i].init(qt);
      astros[i].isStar = true;
    }else if (i < qtCentr+qtStars+qtBlHl+qtMoons){
      velOrbit = 1.8267867965;
      int pos = 5;
      d = -100-(i-qtStars-qtBlHl-qtCentr+pos-1)*coeDist-20;
      v = (double) -(sqrt((float) (Pow(V,2) * (D/d)))) * sqrt(astros[0].massa/10000) -velStar-velOrbit;
      astros[i] = new Astro(0.01,0,(float) d,(float) v,180);
      astros[i].funcRaw(2);
      astros[i].init(qt);
    }else{
      
      d = -75-(qt-qtCentr-qtBlHl-qtStars)*coeDist;
      v = (double) (sqrt((float) (Pow(V,2) * (D/d)))) * sqrt(astros[0].massa/10000);
      a = 360/((qt-qtCentr-qtBlHl-qtStars)) * (i-(qt-qtCentr-qtBlHl));

      dx = cos((float)(a*PI/180))*d;
      dy = sin((float)(a*PI/180))*d;
      if (i%2 == 1){
        a+=0; 
      }
      setAngVel = a+90;
      if (setAngVel >= 360){
        setAngVel -= 360;
      }
      //print(a + "\n");
      
      
      
      astros[i] = new Astro(1,dx,dy,(float) v,setAngVel);
      astros[i].init(qt);
    }
  }
}

void realloc(int p,int pObjSum){
  qt -= 1;

  if (p<posObj){
    posObj--;
  }else if (p==posObj){
    posObj = pObjSum;
    if (pObjSum > p){
      posObj--;
    }
  }
  
  for (int i = p;i<qt;i++){
    astros[i] = astros[i+1];
  }
  Astro[] Nastros = new Astro[qt];
  for (int j=0;j<qt;j++){
    Nastros[j] = astros[j];
  }
  astros = Nastros;
}

int ind(Astro a){
  for (int i=0;i<qt;i++){
    if (astros[i] == a){
      return i;
    }
  }
  return 0;
}

void collision(Astro a){
  Astro sum,sub;
  int p =0;
  for (Astro b : astros){
    if(a == b){
      continue;
    }
    if (distLin(a,b) < a.r/2 + b.r/2){
      if (a.massa >= b.massa){
        sum = a;
        sub = b;
      }else{
        sum = b;
        sub = a;
      }
      sum.massa += sub.massa;
      sum.velX += ((sub.velX - sum.velX)*sub.massa)/sum.massa;
      sum.velY += ((sub.velY - sum.velY)*sub.massa)/sum.massa;
      realloc(ind(sub),ind(sum));
      sum.funcRaw();
      break;
    }
  }
  p++;
}

double angulo(Astro a,Astro b){
  double dx = a.x - b.x;
  double dy = - a.y + b.y;
  double soma = 90;
  if (dx >= 0){
      soma += 180;
  }
  double ang = (atan((float) (dy/dx)) * 180 / PI + soma+ 90) % 360;
  return ang;
}

double distLin(Astro a1,Astro a2){
  return pow(pow((float) (a1.x - a2.x),2) + pow((float) (a1.y - a2.y),2),0.5f);
}

void forces(){
  //print("F:");
  double ang,dist;
  int p = 0;
  for (Astro a1 : astros){
    for (Astro a2 : astros){
      
      if (a1 == a2){
        continue;
      }
      
      ang = angulo(a1,a2);
      dist = distLin(a1,a2);
      
      a2.Vets[p].v = G*a1.massa*a2.massa/pow((float) dist,2) * coeTemp;
      a2.Vets[p].a = ang*PI/180;
      //print("|" + a1.Vets[p].v);
      
    }
    p+=1;

  }
  //print("|\n");
}

void draw(){
  boolean onLux = false;
  if (coeDil < 0.063){
    onLux = true;
  }
  
  translate(width/2+tx,height/2+ty);
  scale(coeDil);
  
  if (posObj != -1){
    tx = (float)(-astros[posObj].x*coeDil);
    ty = (float)(-astros[posObj].y*coeDil);
  }
  // Engine
  ArrayList<Draw[]> showAfter = new ArrayList<Draw[]>();
  if (run || do_passFrame){
    loop += 1;
    print(loop + "\n");
    background(0);
    forces();
    for (Astro ast : astros){
      ast.update(coeTemp);
      collision(ast);
      showAfter.add(ast.show(coeTemp));
      ast.lineTraj = lineTraj;
      ast.lineVel = show_lineVel;
      ast.lineFor = show_lineFor;
      ast.onLux = onLux;
    }
    do_passFrame = false;
  }else{
    background(0);
    for (Astro ast : astros){
      showAfter.add(ast.show(coeTemp));
      ast.lineTraj = lineTraj;
      ast.lineVel = show_lineVel;
      ast.lineFor = show_lineFor;
      ast.onLux = onLux;
    }
  }
  // After
  for (Draw[] drs : showAfter){
    for (Draw dr : drs){
      dr.build();
    }
  }
  // Ecrivent
  String texto = "coeDil : " + coeDil;
  float tam = 50;
  float padding = 10;
  textSize(tam/(coeDil));
  fill(#FFFFFF);
  float difX = -width/2-tx;
  float difY = -height/2-ty;
  text(texto,(padding+difX)/coeDil,(difY+height-tam-padding)/(coeDil));
  ecri("Fps : "+fps,#FFFFFF,10,10,50,10);
  ecri("FraRat : "+FraRat,#FFFFFF,10,10+50+5,50,10);
  ecri("coeTemp : "+coeTemp,#00FF00,width-200,10,25,10);
}

void keyPressed(){
  if (keyCode == CONTROL){
    passFrame = true;
    do_FraRat = true;
  }
}

void keyReleased(){
  if (keyCode == CONTROL){
    run = (run == false) ? true : false;
  }else if (keyCode == LEFT){
    posObj -= 1;
    print(posObj + "\n");
  }else if (keyCode == RIGHT){
    posObj += 1;
    print(posObj + "\n");
  }else if (keyCode == SHIFT){
    posObj = -1;
    print(posObj + "\n");
  }else if (keyCode == UP){
    coeTemp += (coeTemp <= 0.1) ? coeTemp/2 : 0.1;
    coeTemp = (double) round((float)coeTemp*100000)/100000;
  }else if (keyCode == DOWN){
    coeTemp -= (coeTemp <= 0.1) ? coeTemp/2 : 0.1;
    coeTemp = (double) round((float)coeTemp*100000)/100000;
  }else if (keyCode == ALT){
    lineTraj = (lineTraj==0) ? 1: 0;
  }
  
  if (key == 'n'){
    do_passFrame = true;
  }else if (key == 'v'){
    show_lineVel = (show_lineVel == 1) ? 0 : 1;
  }else if (key == 'f'){
    show_lineFor = (show_lineFor == 1) ? 0 : 1;
  }
  
  if (posObj <-1){
    posObj += qt+1;
  }else if (posObj >= qt){
    posObj = -1;
  }
  if (coeDil < 0.001){
    coeDil = 0.001;
  }
  if (coeTemp < 0){
    coeTemp = 0;
  }
  
}

void mouseDragged(){
  tx += mouseX - pmouseX;
  ty += mouseY - pmouseY;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount(); 
  coeDil-=(coeDil)/2 * (e/sqrt(pow(e,2)));
  if (coeDil < 0.001){
    coeDil = 0.001;
  }
}

void ecri(String texto,int cor,float x,float y,float tam,float padding){
  textSize(tam/(coeDil));
  fill(cor);
  text(texto,(x-width/2-tx)/coeDil,(-height/2-ty+y+tam)/(coeDil));
}

void counterFps(){
  int last;
  while (true){
    last = loop;
    delay(1000);
    fps = (loop - last);
  }
}
