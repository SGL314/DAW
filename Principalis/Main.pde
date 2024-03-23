//Dengoso 2
int corMosqNor = #000000;
int corMosqInf = #BC1EAD;
int corPersNor = #4873DE;
int corPersInf = #FF0000;

int tamP = 20;
int tamM = 4;

int qt_i_P = 100;
int qt_i_M = 10;

class Person{
    String state = "normal";
    float px = 0;
    float py = 0;
    public Person(float ipx, float ipy){
        px = ipx;
        py = ipy;
    }
}

class Mosq{
    String state = "normal";
    float px = 0;
    float py = 0;
    boolean did = false;
    Person set;
    public Mosq(float ipx, float ipy){
        px = ipx;
        py = ipy;
    }
}

Person[] Ps = new Person[0];
Mosq[] Ms = new Mosq[0];

void setup(){
    size(800,800);
    create_init();
    thread("runner");
}

int Rpx(){
    int px = (int) ((width+1)*random(1));
    return px;
}
int Rpy(){
    int py = (int) ((height+1)*random(1));
    return py;
}
int rd(int num){
    return (int) (random(num));
}

void create_init(){
    Ps = new Person[qt_i_P];
    Ms = new Mosq[qt_i_M];
    for (int i=0;i<qt_i_P;i++){
        Ps[i] = new Person(Rpx(),Rpy());
        if (i==0){
            Ps[i].state = "infec";
        }
    }
    for (int i=0;i<qt_i_M;i++){
        Ms[i] = new Mosq(Rpx(),Rpy());
    }
}

void draw(){
    background(255,255,255);
    runner();
    for (Person p : Ps){
        stroke(1000);
        if (p.state == "normal"){
            fill(corPersNor);
        }else{
            fill(corPersInf);
        }

        p.px += rd(3)-1;
        p.py += rd(3)-1;

        if (p.px < tamP/2){
            p.px += 1;
        }
        if (p.px > width-tamP/2){
            p.px -= 1;
        }
        if (p.py < tamP/2){
            p.py += 1;
        }
        if (p.py > height-tamP/2){
            p.py -= 1;
        }

        circle(p.px,p.py,tamP);
    }

    for (Mosq m : Ms){
        stroke(1000);
        if (m.state == "normal"){
            fill(corMosqNor);
        }else{
            fill(corMosqInf);
        }
        circle(m.px,m.py,tamM);
    }
}

void runner(){
    int num,rd;
    boolean didXp = false;
    boolean didYp = false;
    boolean didXn = false;
    boolean didYn = false;

    for (Mosq m : Ms){
        if (!(m.did)){
            num = (int) random(Ps.length);
            m.set = Ps[num];
            m.did = true;
        }else{
            rd = rd(2);
            if (rd==0){
                if (m.px > m.set.px){
                    m.px -= 1;
                }else if (m.px < m.set.px){
                    m.px += 1;
                }
            }else{
                if (m.py > m.set.py){
                    m.py -= 1;
                }else if (m.py < m.set.py){
                    m.py += 1;
                }
            }

            if (m.px == m.set.px && m.py == m.set.py){
                if (m.set.state == "infec"){
                    m.state = m.set.state;
                }else if (m.state == "infec"){
                    m.set.state = m.state;
                }
                m.did = false;
            }
        }

    }
    

}