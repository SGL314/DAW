class Draw{
    int stroke;
    int fill;
    float x,y,r;
    float a,b;
    String type;
    Draw(int stroke,int fill,float x,float y,float r,String type){
        this.stroke = stroke;
        this.fill = fill;
        this.x = x;
        this.y = y;
        this.r = r;
        this.type = type;
    }
    Draw(int stroke,float x,float y,float a,float b,String type){
        this.stroke = stroke;
        this.x = x;
        this.y = y;
        this.a = a;
        this.b = b;
        this.r = r;
        this.type = type;
    }
    Draw(String type){
        this.type = type;
    }

    void build(){
        switch (type){
            case "ellipse":
                stroke(this.stroke);
                fill(this.fill);
                ellipse(this.x,this.y,this.r,this.r);
                break;
            case "line":
                stroke(this.stroke);
                line(this.x,this.y,this.a,this.b);
                break;
            case "None":
                break;
        }
        
    }
}