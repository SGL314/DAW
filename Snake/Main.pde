int n = 21;
int[][] grid = new int[n][n];
int[][] snake = new int[0][0];

int corSnakeBody = #2B2FD6;
int corSnakeHead = #BC1EAD;
int corFood = #FF0000;

boolean run = true;
boolean auto = true;
boolean canRun = true;
int del = 200;
int pontuation = 0;
int[] dirs = new int[0];

int ns = 0;
int nb = 1;
int nh = 2;
int nf = 3;
int dir = -1;
int px = (n-1)/2;
int py = (n-1)/2;

class Sim{
    int[][] gridS;
    int dirS;
    int pxS,pyS;
    int[] movements = new int[0];
    public Sim(int[][] IgridS,int IdirS,int IpxS,int IpyS){
        gridS = IgridS;
        dirS = IdirS;
        pxS = IpxS;
        pyS = IpyS;
    }
    public void movement(){
        int val,apx=0,apy=0,lx=0,ly=0,slx=0,sly=0;
        int[][] gridA = new int[n][n];
        gridA = this.gridS;
        for (int i=0;i<n;i++){
            for (int j=0;j<n;j++){
                if (this.gridS[i][j] == nb){
                    this.gridS[i][j] = ns;
                }
            }
        }

        if (this.pxS >= 0 && this.pxS < n && pyS >= 0 && pyS < n){
            val = this.gridS[this.pxS][this.pyS];
            this.gridS[this.pxS][this.pyS] = 0;
            apx = this.pxS;
            apy = this.pyS;
            switch (dirS){
                case 0:
                    this.pxS++;
                    break;
                case 1:
                    this.pyS--;
                    break;
                case 2:
                    this.pxS--;
                    break;
                case 3:
                    this.pyS++;
                    break;
            }
            if (this.pxS >= 0 && this.pxS < n && this.pyS >= 0 && this.pyS < n){
                if (this.gridS[this.pxS][this.pyS] == nf){
                    

                }else if (gridA[this.pxS][this.pyS] == nb){
                    //print("VOCE PERDEU");
                    //run = false;
                }
                this.gridS[this.pxS][this.pyS] = val;
            }else{
                //print("VOCE PERDEU");
                //run = false;
            }
        }else{
            //print("VOCE PERDEU");
            //run = false;
        }

        lx = apx;
        ly = apy;
        for (int p=pontuation-1;p>=0;p--){
            slx = snake[p][0];
            sly = snake[p][1];
            snake[p][0] = lx;
            snake[p][1] = ly;
            lx = slx;
            ly = sly;
            // if (p==0){
            //     snake[0][0] = 0;
            //     snake[0][0] = 0;
            // }
        }
        

        for (int p=pontuation-1;p>=0;p--){
            this.gridS[snake[p][0]][snake[p][1]] = nb;
            if (p==0){
                lx = snake[p][0];
                ly = snake[p][1];
            }
        }
    }
    public boolean veri(){
        boolean found = false;
        for (int i=0;i<n;i++){
            for (int j=0;j<n;j++){
                if (this.gridS[i][j] == nh){
                    found = !(found);
                    break;
                }
            }
        }
        if (found){
            if (this.pxS >= 0 && this.pxS < n && this.pyS >= 0 && this.pyS < n){
                if (this.gridS[pxS][this.pyS] == nb){
                    return false;
                }
            }else{
                return false;
            }
        }
        return found;
    }
    public boolean logus(){
        boolean found = false;
        int fi=0,fj=0;
        for (int i=0;i<n;i++){
            for (int j=0;j<n;j++){
                if (this.gridS[i][j] == nf){
                    found = !(found);
                    fi = i;
                    fj = j;
                    break;
                }
            }
        }
        if (found){
            if (fi==pxS){
                
                if (fj>this.pyS && dirS!=1){
                    dirS = 3;
                }else if (fj<pyS && dirS!=3){
                    dirS = 1;
                }else{
                    dirS = 2*rd(2);
                }
            }else if (fj==pyS){
                if (fi>pxS && dirS!=2){
                    dirS = 0;
                }else if(fi<pxS && dirS!=0){
                    dirS = 2;
                }else{
                    dirS = 1+2*rd(2);
                }
            }
            if (fi>pxS && dirS!=0 && dirS!=2){
                dirS = 0;
            }else if (fi<pxS && dirS!=2 && dirS!=0){
                dirS = 2;
            }
            if (fj>pyS && dirS!=3 && dirS!=1){
                dirS = 3;
            }else if (fj<pyS && dirS!=1 && dirS!=3){
                dirS = 1;
            }
            // Não bate na cauda
            boolean changed = true;
            int turns = 0;
            int teto = 1000;
            while (changed){
                turns++;
                if (turns >= teto){
                    return false;
                }
                changed = false;
                switch (dirS){
                    case 0:
                        //print("\n" + dirS + ">");
                        if (pxS+1<n){
                            if (this.gridS[pxS+1][pyS] == nb){
                                dirS = 1+2*rd(2);
                                changed = true;
                            }
                        }else{
                            dirS = 1+2*rd(2);
                            changed = true;
                        }
                        //print(dirS);
                        break;
                    case 2:
                        //print("\n" + dirS + ">");
                        if (pxS-1>=0){
                            if (this.gridS[pxS-1][pyS] == nb){
                                dirS = 1+2*rd(2);
                                changed = true;
                            }
                        }else{
                            dirS = 1+2*rd(2);
                            changed = true;
                            
                        }
                        //print(dirS);
                        break;
                    case 1:
                        //print("\n" + dirS + ">");
                        if (pyS-1<n){
                            if (this.gridS[pxS][pyS-1] == nb){
                                dirS = 2*rd(2);
                                changed = true;
                            }
                        }else{
                            dirS = 2*rd(2);
                            changed = true;
                            
                        }
                        //print(dirS);
                        break;
                    case 3:
                        //print("\n" + dirS + ">");
                        if (pyS+1>=0){
                            if (this.gridS[pxS][pyS+1] == nb){
                                dirS = 2*rd(2);
                                changed = true;
                            }
                        }else{
                            dirS = 2*rd(2);
                            changed = true;
                            
                        }
                        //print(dirS);
                        break;
                }
            }
            return true;
        }else{
            return true;
        }
    }
    public void moves(){
        append(movements, this.dirS);
    }
}

void setup(){
    size(816,816);
    init();
}

void createSnakes(int qt,boolean sinceFoundFood){
    boolean result = false;
    int maximum = n*n;
    Sim[] sims = new Sim[qt]; 
    for (int i = 0;i<qt;i++){
        sims[i] = new Sim(grid,dir,px,py);
    }
    for (int i = 0;i<qt;i++){
        for (int j = 0;j<maximum;j++){
            if (sims[i].dirS%2==0){
                sims[i].dirS = 1+2*rd(2);
            }else{
                sims[i].dirS = 2*rd(2);
            }
            switch (sims[i].dirS){
                case 0:
                    sims[i].pxS++;
                    break;
                case 1:
                    sims[i].pyS--;
                    break;
                case 2:
                    sims[i].pxS--;
                    break;
                case 3:
                    sims[i].pyS++;
                    break;
            }
            result = sims[i].logus();
            if (result == false){
                break;
            }
            sims[i].movement();
            result = sims[i].veri();
            if (result == false){
                break;
            }
            sims[i].moves();
            if (j == maximum-1){
                dirs = new int[qt];
                dirs = sims[i].movements;
                break;
            }
        }
    }
}
void createSnakes(int qt,int posi){
    Sim[] sims = new Sim[qt]; 
    for (int i = 0;i<qt;i++){
        sims[i] = new Sim(grid,dir,px,py);
    }
    // for (int i = 0;i<qt;i++){
    //     for (in)
    // }
}

int rd(int num){
    return (int) (random(num));
}

void init(){
    grid[px][py] = nh;
    dir = 1;
}

int mod(int num){
    if (num < 0){
        return 4+num;
    }
    return num;
}

void keyReleased(){
    if (keyCode == DOWN){
        dir = (dir == 1) ? dir : 3;
    }else if (keyCode == UP){
        dir = (dir == 3) ? dir : 1;
    }else if (keyCode == RIGHT){
        dir = (dir == 2) ? dir : 0;
    }else if (keyCode == LEFT){
        dir = (dir == 0) ? dir : 2;
    }else if (keyCode == CONTROL){
        run = (run) ? false : true;
    }else if (keyCode == SHIFT){
        auto = (auto) ? false : true;
    }
}

void toDraw(){
    int cor = #00FF00;
    float c = width/n;
    float h = height/n;
    for (int i=0;i<n;i++){
        for (int j=0;j<n;j++){
            stroke(225);
            switch (grid[i][j]){
                case 0:
                    cor = #FFFFFF;
                    break;
                case 1:
                    cor = corSnakeBody;
                    break;
                case 2:
                    cor = corSnakeHead;
                    break;
                case 3:
                    cor = corFood;
                    break;
            }
            fill(cor);
            rect((int)h*i,(int)c*j,(int)c,(int)h);
        }
    }
}

void movement(){
    int val,apx=0,apy=0,lx=0,ly=0,slx=0,sly=0;
    print("\nPontuation : " + pontuation);
    int[][] gridA = new int[n][n];
    gridA = grid;
    for (int i=0;i<n;i++){
        for (int j=0;j<n;j++){
            if (grid[i][j] == nb){
                grid[i][j] = ns;
            }
        }
    }

    if (px >= 0 && px < n && py >= 0 && py < n){
        val = grid[px][py];
        grid[px][py] = 0;
        apx = px;
        apy = py;
        switch (dir){
            case 0:
                px++;
                break;
            case 1:
                py--;
                break;
            case 2:
                px--;
                break;
            case 3:
                py++;
                break;
        }
        if (px >= 0 && px < n && py >= 0 && py < n){
            if (grid[px][py] == nf){
                grid[apx][apy] = nb;
                pontuation++;

                int[][] Nsnake = new int[pontuation][2];
                for (int p=0;p<pontuation-1;p++){
                    Nsnake[p] = snake[p];
                }
                Nsnake[pontuation-1][0] = apx;
                Nsnake[pontuation-1][1] = apy;
                snake = Nsnake;

            }else if (gridA[px][py] == nb){
                print("VOCE PERDEU");
                run = false;
            }
            grid[px][py] = val;
        }else{
            print("VOCE PERDEU");
            run = false;
        }
    }else{
        print("VOCE PERDEU");
        run = false;
    }

    lx = apx;
    ly = apy;
    for (int p=pontuation-1;p>=0;p--){
        slx = snake[p][0];
        sly = snake[p][1];
        snake[p][0] = lx;
        snake[p][1] = ly;
        lx = slx;
        ly = sly;
        // if (p==0){
        //     snake[0][0] = 0;
        //     snake[0][0] = 0;
        // }
    }
    

    for (int p=pontuation-1;p>=0;p--){
        grid[snake[p][0]][snake[p][1]] = nb;
        if (p==0){
            lx = snake[p][0];
            ly = snake[p][1];
        }
    }
    //grid[lx][ly] = ns;
}

void newFood(){
    int pi,pj;
    boolean found = false;
    for (int i=0;i<n;i++){
        for (int j=0;j<n;j++){
            if (grid[i][j] == 0){
                found = !(found);
                break;
            }
        }
    }
    if (!(found)){
        print("VOCE GANHOU");
    }else{
        while (true){
            pi = rd(n);
            pj = rd(n);
            if (grid[pi][pj] == 0){
                grid[pi][pj] = nf;
                break;
            }
        }
    }
}

void automat(){
    boolean found = false;
    int fi=0,fj=0;
    
    for (int i=0;i<n;i++){
        for (int j=0;j<n;j++){
            if (grid[i][j] == nf){
                found = !(found);
                fi = i;
                fj = j;
                break;
            }
        }
    }
    if (found){
        if (fi==px){
            
            if (fj>py && dir!=1){
                dir = 3;
            }else if (fj<py && dir!=3){
                dir = 1;
            }else{
                dir = 2*rd(2);
            }
        }else if (fj==py){
            if (fi>px && dir!=2){
                dir = 0;
            }else if(fi<px && dir!=0){
                dir = 2;
            }else{
                dir = 1+2*rd(2);
            }
        }
        if (fi>px && dir!=0 && dir!=2){
            dir = 0;
        }else if (fi<px && dir!=2 && dir!=0){
            dir = 2;
        }
        if (fj>py && dir!=3 && dir!=1){
            dir = 3;
        }else if (fj<py && dir!=1 && dir!=3){
            dir = 1;
        }
        //print("\n" + px + " " + py + ":" + fi + " " + fj);
        // Não bate na cauda
        boolean changed = true;
        while (changed){

            //createSnakes(10,true);
            //dir = dirs[0];
            //delay(100);

            changed = false;
            switch (dir){
                case 0:
                    //print("\n" + dir + ">");
                    if (px+1<n){
                        if (grid[px+1][py] == nb){
                            dir = 1+2*rd(2);
                            changed = true;
                        }
                    }else{
                        dir = 1+2*rd(2);
                        changed = true;
                    }
                    //print(dir);
                    break;
                case 2:
                    //print("\n" + dir + ">");
                    if (px-1>=0){
                        if (grid[px-1][py] == nb){
                            dir = 1+2*rd(2);
                            changed = true;
                        }
                    }else{
                        dir = 1+2*rd(2);
                        changed = true;
                        
                    }
                    //print(dir);
                    break;
                case 1:
                    //print("\n" + dir + ">");
                    if (py-1<n){
                        if (grid[px][py-1] == nb){
                            dir = 2*rd(2);
                            changed = true;
                        }
                    }else{
                          dir = 2*rd(2);
                        changed = true;
                        
                    }
                    //print(dir);
                    break;
                case 3:
                    //print("\n" + dir + ">");
                    if (py+1>=0){
                        if (grid[px][py+1] == nb){
                            dir = 2*rd(2);
                            changed = true;
                        }
                    }else{
                          dir = 2*rd(2);
                        changed = true;
                        
                    }
                    //print(dir);
                    break;
            }
        }
        
    }else{
        print("VOCE GANHOU");
    }
}

void veri(){
    boolean found = false;
    for (int i=0;i<n;i++){
        for (int j=0;j<n;j++){
            if (grid[i][j] == nh){
                found = !(found);
                break;
            }
        }
    }
    if (found == false){
        print("\nVOCE PERDEU");
        canRun = false;
    }
}

void draw(){
    boolean found = false;
    background(#FFFFFF);
    delay(del);
    if (run && canRun){
        del = 200;
        if (auto){
          automat();
          del=80;
        }
        movement();
        veri();
        
        for (int i=0;i<n;i++){
            for (int j=0;j<n;j++){
                if (grid[i][j] == nf){
                    found = !(found);
                    break;
                }
            }
        }
        if (!(found)){
            newFood();
        }
    }
    toDraw();
}
