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
  D = -75;
  V = -(4-1/2-1);
  float[] raws = {1.5/2,0.002439,0.0060518,0.006371,0.0033895,0.069911,0.000670};
  int[] colors = {#FFF412,#868686,#C9BB8C,#383A6F,#EA542B,#E3BA79,#E87D3F};

  // Cria os astros manualmente
  {
    int p=-1;
    p++;
    float vSol = -6;
    astros[p] = new Astro(nomes[0],100000.0,0.0,0.0,vSol,0.0);
    astros[p].funcRaw(1);
    astros[p].isStar = true;
    astros[p].cor = #FFF412;

    d = -57.9;
    v = (double) (-(Math.SqRt((float) (Math.Pow(V,2) * (D/d)))) * Math.SqRt(astros[0].massa/10000) -vSol)* (-1);
    p++;
    astros[p] = new Astro(nomes[2],3.3,0.0,d,v,3.141593);astros[p].funcRaw(2);

    d = -108.2;
    v = (double) (-(Math.SqRt((float) (Math.Pow(V,2) * (D/d)))) * Math.SqRt(astros[0].massa/10000) -vSol)* (-1);
    p++;
    astros[p] = new Astro(nomes[3],48.675,0.0,d,v,3.141593);
    astros[p].funcRaw(2);

    d = -149.6;
    v = (double) (-(Math.SqRt((float) (Math.Pow(V,2) * (D/d)))) * Math.SqRt(astros[0].massa/10000) -vSol)* (-1);
    p++;
    astros[p] = new Astro(nomes[4],59.7237,0.0,d,v,3.141593);
    astros[p].funcRaw(2);

    d = -227.9;
    v = (double) (-(Math.SqRt((float) (Math.Pow(V,2) * (D/d)))) * Math.SqRt(astros[0].massa/10000) -vSol)* (-1);
    p++;
    astros[p] = new Astro(nomes[5],6.4171,0.0,d,v,3.141593);
    astros[p].funcRaw(2);
    d = -778.3;
    v = (double) (-(Math.SqRt((float) (Math.Pow(V,2) * (D/d)))) * Math.SqRt(astros[0].massa/10000) -vSol)* (-1);
    p++;
    astros[p] = new Astro(nomes[6],1000.0,0.0,d,v,3.141593);
    astros[p].funcRaw(2);

    d -= 20;
    v = (double) -astros[p-1].vel-1.8267867965;
    p++;
    astros[p] = new Astro(nomes[8],0.009999999776482582,0.0,d,v,3.141593);
    astros[p].funcRaw(3);
  }

  // Retira os nulos
  int quantidade=0;
  for (Astro ast : astros) quantidade++;
  int novaQuantidade=0;
  for (int i=0;i<quantidade;i++){
    if (astros[i] == null){
      for (int j=i+1;j<quantidade;j++) astros[j-1] = astros[j];
      continue;
    }
    novaQuantidade++;
  }
  print(novaQuantidade);
  Astro[] newAstros = new Astro[novaQuantidade];
  for (int i=0;i<novaQuantidade;i++){
    newAstros[i] = astros[i];
  }
  astros = newAstros;
  int i=0;
  for (Astro astro : astros){
    astro.r = raws[i];
    astro.cor = colors[i];
    i++;
  }
  //print(ind(astros));
  // Inicia os astros
  for (Astro ast : astros){
    ast.init(qt);
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
  allTheThings(!(intoAstro));
  if (intoAstro) toShowInAstro();
  ecrivent();
  // mousePosition();
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
  background(0);
  
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
  double ang, dist;
  Astro astroInto_obj = astros[astroInto];
  for (Draw dr : astroInto_obj.show(coeTemp)){
    dr.build();
  }
  for (Astro ast : astros){
    if (ast != astroInto_obj){
      ang = -angulo(astroInto_obj,ast);
      dist = distLin(astroInto_obj,ast);
      float px1,py1,px2,py2,px3,py3,px4,py4,px,py;
      px1 = (float) ((-width/2+100)*cos((float) ang*PI/180)+astroInto_obj.x);
      py1 = (float) ((-width/2+100)*sin((float) ang*PI/180)+astroInto_obj.y);
      px2 = (float) ((-width/2+30)*cos((float) ang*PI/180)+astroInto_obj.x);
      py2 = (float) ((-width/2+30)*sin((float) ang*PI/180)+astroInto_obj.y);
      
      px = (float) ((-width/2+20)*cos((float) ang*PI/180)+astroInto_obj.x);
      py = (float) ((-width/2+20)*sin((float) ang*PI/180)+astroInto_obj.y);

      px3 = (float) ((-width/2+30)*cos((float) (ang-1)*PI/180)+astroInto_obj.x);
      py3 = (float) ((-width/2+30)*sin((float) (ang-1)*PI/180)+astroInto_obj.y);
      px4 = (float) ((-width/2+30)*cos((float) (ang+1)*PI/180)+astroInto_obj.x);
      py4 = (float) ((-width/2+30)*sin((float) (ang+1)*PI/180)+astroInto_obj.y);

      stroke(#00FF00);
      line((float) px1,(float) py1,(float) px2,(float) py2); // reta
      line((float) px,(float) py,(float) px3,(float) py3);// seta lado esquero
      line((float) px,(float) py,(float) px4,(float) py4);//seta lado direito
      float angle = (float) (((-ang-180)+360)%360)*PI/180;

      float x,y;
      if (90 >= angle*180/PI || 270 <= angle*180/PI){
      px1 = (float) ((-width/2+100+textWidth(ast.nome))*cos((float) ang*PI/180)+astroInto_obj.x);
      py1 = (float) ((-width/2+100+textWidth(ast.nome))*sin((float) ang*PI/180)+astroInto_obj.y);
      }
      x = (float) (px1-astroInto_obj.x);
      y = (float) (py1-astroInto_obj.y);
      angle = atan(y/x);
      translate((float) astroInto_obj.x,(float) astroInto_obj.y);
      rotate((float) angle);
      //Out.println(px1-astroInto_obj.x);
      //dist = round((float) dist)/1000;
      float distShowed = round((float) dist*1000);
      distShowed /= 1000;
      fill(ast.cor);
      text(ast.nome+"\n"+distShowed,(float) (x/cos(angle)),(float) (0));
      rotate((float) -angle);
      translate((float) -astroInto_obj.x,(float) -astroInto_obj.y);

    }
  }
}

boolean showAstroByDistance(Astro ast){
  if (ast.isStar) return true;
  if (ast.r*2*coeDil <= 4) return false;
  return true;
}

void ecrivent(){

  scale(1/coeDil);
  translate(-(width/2+tx),-(height/2+ty));
  String texto = "coeDil : " + coeDil;

  float tam = 50;
  float padding = 10;
  textSize(tam);
  fill(#FFFFFF);
  text(texto,(padding),height-tam-padding);


  ecri2("Fps : "+fps,#FFFFFF,10,10,50,10);
  ecri2("FraRat : "+FraRat,#FFFFFF,10,10+50+5,50,10);
  ecri2("coeTemp : "+coeTemp,#00FF00,width-200,10,25,10);


  translate(width/2+tx,height/2+ty);
  scale(coeDil);
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
    if (intoAstro)
      astroInto -= 1;
    else 
      posObj -= 1;
  }else if (keyCode == RIGHT){
    if (intoAstro)
      astroInto += 1;
    else 
      posObj += 1;
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
  }else if (key == 'e'){
    gotoAstro(astros[posObj]);
  }
  
  if (posObj <-1){
    posObj += qt+1;
  }else if (posObj >= qt){
    posObj = -1;
  }
  astroInto = (astroInto+qt)%qt;
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
  int tam_vals = 45;
  float[] vals = {0.001, 0.0015, 0.00225, 0.0033749999, 0.0050625, 0.00759375, 0.011390625, 0.017085936, 0.025628904, 0.038443357, 0.057665035, 0.08649755, 0.12974633, 0.1946195, 0.29192924, 0.43789387, 0.6568408, 1.0, 1.4778918, 2.2168376, 3.3252563, 4.9878845, 7.481827, 11.22274, 16.83411, 25.251165, 37.876747, 56.81512, 85.22268, 127.834015, 191.75102, 287.62653, 431.4398, 647.1596999999999, 970.73955, 1456.109325, 2184.1639875, 3276.24598125, 4914.368971875, 7371.5534578125,7500,8000,9000,9500,10000};
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
void ecri2(String texto,int cor,float x,float y,float tam,float padding){
  textSize(tam);
  fill(cor);
  text(texto,(x),(y+tam));
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
