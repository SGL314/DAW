class Player{
    int px,py;
    int thick,length;
    int pontuation = 0;
    public Player(int x,int y,int thi,int len){
        px = x;
        py = y;
        thick = thi;
        length = len;
    }
    public void pontuation(){
        this.pontuation++;
    }
}