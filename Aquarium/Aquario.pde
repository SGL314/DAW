int qt = 20;
int dx = 100;
int dy = 100;

Peixe[] peixes = new Peixe[0];

void setup(){
    size(800,800);
    createPeixes();
}

void createPeixes(){
    peixes = new Peixe[qt];
    for (int i =0;i<qt;i++){
        peixes[i] = new Peixe(dx,dy);
    }
}

void draw(){
  background(#000000);
  fill(#F00000);
  rect(dx-10,dy,width-dx*2+10*2,height-dy*2+10);
  fill(#1FC5ED);
  rect(dx,dy,width-dx*2,height-dy*2);
    
    for (Peixe p : peixes){
        p.Move();
        p.Desenha();
    }
}