Astro[] astros = new Astro[0];
int coeVel = 10;
int qtCentr = 5;
int qtBlHl = 1;
int qtMoons = 1;
int qtStars = 2;
int qt = qtCentr+qtMoons+qtBlHl+qtStars;
double G = 6.6743*pow(10,-2);
float tx=0,ty=0;
int posObj = 0; // Posição de u astro em astros
float coeDil = 1;
int count = 0;
int lineTraj = 0;
int loop = -1;
float fps = 0;
boolean do_passFrame = false;
int FraRat =100;
double coeTemp = 1;
// shows
int show_lineVel = 0;
int show_lineFor = 0;
int astroInto = 0;
// booleans
boolean passFrame = false;
boolean run = false;
boolean do_FraRat = false;
boolean intoAstro = false;
// prints
boolean print_loop = false;
//Clicking
int lastTimeClicked;
Astro lastAstroClicked = null;
int butaoDireitoMouse = 37;
int butaoEsquerdoMouse = 39;

void setup(){
  size(1000,1000);
  background(#000000);
  createAstros();
  
  tx = width/2;
  ty = height/2;
  coeDil = 1;
  thread("counterFps");
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
  boolean createAnotherSars = false;
  String[] nomes = {"Sol","Betelguese","Mercúrio","Venus","Terra","Marte","Júpter","Sirius","Europa","k"};
  // io: 2.7Mkm
  // calisto: 1.8827Mkm
  // ganímedes: 1.074Kkm
  // europa: 670.9Kkm
  if (!(createAnotherSars)){
    astros = new Astro[qt-2];
    qt-=2;
    qtStars -=1;
    qtBlHl -=1;
  }
  // for (int i=0;i<astros.length;i++){
  //   if (i==1){
  //     D = -75-(i-1)*coeDist;
  //     V = -(4-i/2-1);
  //   }
  //   if (!(createAnotherSars) && (i==1 || i==7)) continue;
  //   if (i < qtStars){
  //     astros[i] = new Astro(nomes[i],100000,0,0,velStar,0);
      
  //     astros[i].massa = (1*pow(10,5)-0.00001)*CoemassStar + 0.001;
  //     astros[i].init(qt);
  //     astros[i].cor = #FFF412;
  //     if (i == 1){
  //       astros[i] = new Astro(nomes[i],100000,0,0,velStar2,180);
  //       astros[i].y = -30000;
  //       astros[i].massa = (5*pow(10,6)-0.00001)*CoemassStar2 + 0.001;
  //       astros[i].init(qt);
  //       astros[i].cor = #F23918;
  //     }
  //     astros[i].funcRaw(1);
  //     astros[i].isStar = true;
  //   }else if (i < qtCentr+qtStars){
  //     d = -100-(i-qtStars)*coeDist;
  //     v = (double) -(Math.SqRt((float) (Math.Pow(V,2) * (D/d)))) * Math.SqRt(astros[0].massa/10000) -velStar;
  //     astros[i] = new Astro(nomes[i],1000,0,(float) d,(float) v,180);
  //     astros[i].init(qt);
  //     if (do_simulation)
  //       if (i != qtCentr+qtStars-1){
  //         astros[i].velX = -100;
  //         astros[i].massa = 0.0001;
  //       }else{
  //         astros[i].velX = 0;
  //         velStar = 0;
  //       }
  //     astros[i].funcRaw(2);
  //   }else if (i < qtCentr+qtStars+qtBlHl){
  //     v = 0;
  //     d = -15000;
  //     astros[i] = new Astro(nomes[i],1000000,0,(float) d,(float) v,180);
  //     astros[i].cor = #6BD1F7;
  //     astros[i].massa = (10*pow(10,6)-1)*CoemassBlHl + 1;
  //     astros[i].funcRaw(0);
  //     astros[i].init(qt);
  //     astros[i].isStar = true;
  //   }else if (i < qtCentr+qtStars+qtBlHl+qtMoons){
  //     velOrbit = 1.8267867965;
  //     int pos = 5;
  //     d = -100-(i-qtStars-qtBlHl-qtCentr+pos-1)*coeDist-20;
  //     v = (double) -(Math.SqRt((float) (Math.Pow(V,2) * (D/d)))) * Math.SqRt(astros[0].massa/10000) -velStar-velOrbit;
  //     astros[i] = new Astro(nomes[i],0.01,0,(float) d,(float) v,180);
  //     astros[i].funcRaw(2);
  //     astros[i].init(qt);
  //   }else{
  //     d = -75-(qt-qtCentr-qtBlHl-qtStars)*coeDist;
  //     v = (double) (Math.SqRt((float) (Math.Pow(V,2) * (D/d)))) * Math.SqRt(astros[0].massa/10000);
  //     a = 360/((qt-qtCentr-qtBlHl-qtStars)) * (i-(qt-qtCentr-qtBlHl));

  //     dx = cos((float)(a*PI/180))*d;
  //     dy = sin((float)(a*PI/180))*d;
  //     if (i%2 == 1){
  //       a+=0; 
  //     }
  //     setAngVel = a+90;
  //     if (setAngVel >= 360){
  //       setAngVel -= 360;
  //     }
  //     //print(a + "\n");
      
      
      
  //     astros[i] = new Astro(nomes[i],1,dx,dy,(float) v,setAngVel);
  //     astros[i].init(qt);
  //   }
  //   Out.println("new Astro(nomes["+i+"],"+astros[i].massa+","+astros[i].x+","+astros[i].y+""+astros[i].vel+","+astros[i].angVel+");");
  // }
  // cria tudo
  int p=-1;
  // -14
  // -6
  // -8
  // 
  p++;
  astros[p] = new Astro(nomes[0],100000.0,0.0,0.0,-6.0,0.0);
  astros[p].funcRaw(1);
  astros[p].isStar = true;
  astros[p].cor = #FFF412;
  p++;
  astros[p] = new Astro(nomes[2],1000.0,0.0,-100.0,-6+(-14.215838432312012+6)*(-1),3.141593);astros[p].funcRaw(2);
  p++;
  astros[p] = new Astro(nomes[3],1000.0,0.0,-350.0,-6+(-10.391550064086914+6)*(-1),3.141593);astros[p].funcRaw(2);
  p++;
  astros[p] = new Astro(nomes[4],1000.0,0.0,-600.0,-6+(-9.35410213470459+6)*(-1),3.141593);astros[p].funcRaw(2);
  p++;
  astros[p] = new Astro(nomes[5],1000.0,0.0,-850.0,-6+(-8.818009376525879+6)*(-1),3.141593);astros[p].funcRaw(2);
  p++;
  astros[p] = new Astro(nomes[6],1000.0,0.0,-1100.0,-6+(-8.477168083190918+6)*(-1),3.141593);astros[p].funcRaw(2);
  p++;
  astros[p] = new Astro(nomes[8],0.009999999776482582,0.0,-1120.0,-6+(-10.28173828125+6)*(-1),3.141593);
  astros[p].funcRaw(3);
  for (Astro ast : astros){
    ast.init(qt);
  }

  // Retira os nulos
  int quantidade=0;
  for (Astro ast : astros) quantidade++;
  int novaQuantidade=0;
  for (int i=0;i<quantidade;i++){
    if (astros[i] == null){
      for (int j=i+1;j<quantidade;j++) astros[j-1] = astros[j];
    }
    novaQuantidade++;
  }
  Astro[] newAstros = new Astro[novaQuantidade];
  for (int i=0;i<novaQuantidade;i++){
    newAstros[i] = astros[i];
  }
  newAstros = astros;
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
  allTheThings(!(intoAstro));
  if (intoAstro) toShowInAstro();
  ecrivent();
  mousePosition();
}

void allTheThings(boolean showAstros){
  boolean onLux = false;
  
  if (coeDil < 0.063){
    onLux = true;
  }
  
  
  // Engine
  ArrayList<Draw[]> showAfter = new ArrayList<Draw[]>();
  if (run || do_passFrame){
    loop += 1;
    if (print_loop) print(loop + "\n");
    background(0);
    forces();
    for (Astro ast : astros){
      ast.update(coeTemp);
      showAfter.add(ast.show(coeTemp));
      ast.lineTraj = lineTraj;
      ast.lineVel = show_lineVel;
      ast.lineFor = show_lineFor;
      ast.onLux = onLux;
      if (showAstros && showAstroByDistance(ast)){
        collision(ast);
        Draw[] addIt = new Draw[1];
        addIt[0] = new Draw(ast.nome,ast.cor,(float) (ast.x*coeDil+(width/2))+Math.SqRt(ast.r/2*coeDil),(float) (ast.y*coeDil+(height/2))+Math.SqRt(ast.r/2*coeDil),20*Math.SqRt(coeDil),10,"text");
        showAfter.add(addIt);
      }
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
      if (showAstros && showAstroByDistance(ast)){
        Draw[] addIt = new Draw[1];
        addIt[0] = new Draw(ast.nome,ast.cor,(float) (ast.x*coeDil+(width/2))+Math.SqRt(ast.r/2*coeDil),(float) (ast.y*coeDil+(height/2))+Math.SqRt(ast.r/2*coeDil),20*Math.SqRt(coeDil),10,"text");
        showAfter.add(addIt);
      }
    }
  }
  // Posição de foco
  if (posObj != -1){
    tx = (float)(-astros[posObj].x*coeDil);
    ty = (float)(-astros[posObj].y*coeDil);
  }
  translate(width/2+tx,height/2+ty);
  scale(coeDil);
  // After
  if (showAstros)
  for (Draw[] drs : showAfter){
    for (Draw dr : drs){
      if (dr.type.equals("text")){
        dr.x += tx;
        dr.y += ty;
      }
      dr.build();
    }
  }
}

void toShowInAstro(){
  posObj = astroInto;
  int corFundoIntoAstro = #000000;//#6ED9ED
  background(corFundoIntoAstro);
  for (Draw dr : astros[astroInto].show(coeTemp)){
    dr.build();
  }
  ecri(astros[astroInto].nome,#FFFFFF,width/2-textWidth(astros[astroInto].nome),50,50,2); // nome em cima
  ecri(""+astros[astroInto].massa,#FFFFFF,50,height*4/5,25,2);
}

boolean showAstroByDistance(Astro ast){
  if (ast.isStar) return true;
  if (ast.r*2*coeDil <= 4) return false;
  return true;
}

void ecrivent(){
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
  if (key == ' '){
    passFrame = true;
    do_FraRat = true;
  }
}

void keyReleased(){
  if (key == ' '){
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
  }else if (key == 't'){
    lineTraj = (lineTraj == 1) ? 0 : 1;
  }else if (key == 's'){
    intoAstro = false;
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
// MOUSE
void mouseDragged(){
  tx += mouseX - pmouseX;
  ty += mouseY - pmouseY;
}
void mouseWheel(MouseEvent event) {
  float e = -event.getCount(); 
  if (coeDil < 0.001){
    coeDil = 0.001;
  }
  int tam_vals = 33;
  float[] vals = {0.001, 0.0015, 0.00225, 0.0033749999, 0.0050625, 0.00759375, 0.011390625, 0.017085936, 0.025628904, 0.038443357, 0.057665035, 0.08649755, 0.12974633, 0.1946195, 0.29192924, 0.43789387, 0.6568408, 1.0, 1.4778918, 2.2168376, 3.3252563, 4.9878845, 7.481827, 11.22274, 16.83411, 25.251165, 37.876747, 56.81512, 85.22268, 127.834015, 191.75102, 287.62653, 431.4398}; // 33
  int i=0;
  for (float val : vals){
    if (val == coeDil){
      if (i+e>=0 && i+e<tam_vals) coeDil = vals[i+(int) e];
      break;
    }
    i++;
  }
}
void mousePressed(){
  // Verifica se clicou no astro
  
  int x = (int) (mouseX-width/2-tx),y = (int) (mouseY-height/2-ty);
  for (Astro ast : astros){
    if (ast.x-ast.r <= x/coeDil && x/coeDil <= ast.x+ast.r && ast.y-ast.r <= y/coeDil && y/coeDil <= ast.y+ast.r ){
      Out.print(ast.nome);
      if (millis()-lastTimeClicked <= 500 && lastAstroClicked != null){
        if (lastAstroClicked.nome == ast.nome){
          if (mouseButton==butaoDireitoMouse) focusAstro(ast);
          else gotoAstro(ast);
        }
      }
      lastTimeClicked = millis();
      lastAstroClicked = ast;
    }
  }
}
void mousePosition(){
  ecri("("+mouseX+","+mouseY+")",#FF0000,mouseX,mouseY+20,15,10);
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

void focusAstro(Astro ast1){
  int i = 0;
  for (Astro ast2 : astros){
    if (ast1.nome == ast2.nome) posObj = i;
    i++;
  }
}

void gotoAstro(Astro ast){
  intoAstro = true;
  int pos = 0;
  for (Astro ast2 : astros){
    if (ast2 == ast) break;
    pos ++;
  }
  astroInto = pos;
  background(#000000);
}


// Y : Auxiliadores
// Z : Classes em de objetos usuais
