
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
    createThings();
}

void createThings(){
    int vx,vy;
    pl1 = new Player(0,height/2-length/2,thick,length);
    pl2 = new Player(width-thick,height/2-length/2,thick,length);
    vx = -velMax;
    if ((int) (random(2)) == 0){
        vx = velMax;
    }
    vy = velMax;
    ball = new Ball(width/2,diameter/2,vx,vy,diameter);
}

void engine(){
    float timeScale = 0.05f;
    // Field
    if (ball.px < ball.diameter/2 || ball.px > width-ball.diameter/2){
        ball.vx *= -1;
    }
    if (ball.py < ball.diameter/2 || ball.py > height-ball.diameter/2){
        ball.vy *= -1;
    }
    //Players
    // Player[] pls = {pl1,pl2};
    // if (ball.px < ball.diameter/2 || ball.px > width-ball.diameter/2){
    //     ball.vx *= -1;
    // }
    // if (ball.py < ball.diameter/2 || ball.py > height-ball.diameter/2){
    //     ball.vy *= -1;
    // }


    ball.px += ball.vx * timeScale;
    ball.py += ball.vy * timeScale;
}

void draw(){
    engine();
    background(#000000);
    Player[] pls = {pl1,pl2};
    int[] colors = {#FF0000,#0000FF};
    int colorBall = #FFFFFF;
    int pos = 0;
    for (Player pl : pls){
        fill(colors[pos]);
        rect(pl.px,pl.py,pl.thick,pl.length);
        pos++;
    }
    fill(colorBall);
    circle(ball.px,ball.py,ball.diameter);
}