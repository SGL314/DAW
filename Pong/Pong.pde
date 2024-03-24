
// Setted
Ball ball;
Player pl1;
Player pl2;
float lastPx = 0;
// Adjusts
int thick = 50;
int length = 100;
int velMax = 50;
int diameter = 20;

void setup(){
    size(400,800);
    createThings();
}

void createPlayers(){
    pl1 = new Player(0,height/2-length/2,thick,length);
    pl2 = new Player(width-thick,height/2-length/2,thick,length);
}

void createBall(){
    int vx,vy;
    vx = -velMax;
    if ((int) (random(2)) == 0){
        vx = velMax;
    }
    vy = velMax;
    ball = new Ball(width/2,diameter/2,vx,vy,diameter);
}

void createThings(){
    createPlayers();
    createBall();
}

float distLinear(float a,float b){
    float res = a-b;
    if (res<0){
        return -res;
    }
    return res;
}

void engine(){
    
    float timeScale = 0.07f;
    // Field
    if (ball.px < ball.diameter/2 || ball.px > width-ball.diameter/2){
        ball.vx *= -1;
    }
    if (ball.py < ball.diameter/2 || ball.py > height-ball.diameter/2){
        ball.vy *= -1;
    }
    //Players
    Player[] pls = {pl1,pl2};
    for (Player pl : pls){
        if (ball.py >= pl.py && ball.py <= pl.py+pl.length){
            if (distLinear(ball.px,pl.px) <= ball.diameter/2 || distLinear(ball.px,pl.px+pl.thick) <= ball.diameter/2){
                ball.vx *= -1;
            }
        }
        if (pl.py < 0){
            pl.py = 0;
        }else if (pl.py+pl.length > height){
            pl.py = height-pl.length;
        }
    }

    ball.px += ball.vx * timeScale;
    ball.py += ball.vy * timeScale;
}

void keyPressed(){
    int move = 10;
    if (keyCode == SHIFT){
        pl1.py-= move;
    }else if (keyCode == CONTROL){
        pl1.py+= move;
    }
    if (keyCode == UP){
        pl2.py-= move;
    }else if (keyCode == DOWN){
        pl2.py+= move;
    }
}
void keyReleased(){
    int move = 10;
    if (keyCode == SHIFT){
        pl1.py-= move;
    }else if (keyCode == CONTROL){
        pl1.py+= move;
    }
    if (keyCode == UP){
        pl2.py-= move;
    }else if (keyCode == DOWN){
        pl2.py+= move;
    }
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
    pontuation();
    Write();

    Algus();
}

void Algus(){
    float move = 4.9f;
    if (ball.vx < 0){
        if (pl1.py+pl1.length/2 < ball.py){
            pl1.py += move;
        }else if (pl1.py+pl1.length/2 > ball.py){
            pl1.py -= move;
        }
    }
}

void Write(){
    textSize(50);
    fill(#FFFFFF);
    text(pl1.pontuation,50,50);
    fill(#FFFFFF);
    text(pl2.pontuation,width-50,50);
}

void pontuation(){
    if (ball.px <= ball.diameter/2){
        pl2.pontuation();
        createBall();
    }else if (ball.px >= width-ball.diameter/2){
        pl1.pontuation();
        createBall();
    }
}