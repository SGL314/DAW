
// Setted
Ball ball;
Player pl1;
Player pl2;
// Adjusts
int thick = 50;
int length = 100;
int velMax = 50;
int diameter = 20;
// Game Variables


void setup(){
    size(800,800);
    craeteThings();
}

void createThings(){
    int vx,vy;
    pl1 = new Player(0,height/2-length/2);
    pl2 = new Player(width-thick,height/2-length/2);
    vx = (int) ((random(2)-1));
    vy = velMax;
    ball = new Ball(width/2,daimeter/2,vx,vy,diameter);
}

void draw(){
    Player pls = {pl1,pl2};
    int colors = {#FF0000,#0000FF};
    int pos = 0;
    for (Player pl : pls){
        fill(colors[pos]);
        rect(pl.px,pl.py,pl.thick,pl.length);
        pos++;
    }
}