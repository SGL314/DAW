class Draw{
    int stroke;
    int fill;
    int cor;
    int padding;
    float tam;
    float x,y,r;
    float a,b;
    String text;
    String type;
    boolean fixed= false;

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
    Draw(String text,int cor,float x,float y,float tam,int padding,String type){ // texto
        this.type = type;
        this.text = text;
        this.cor = cor;
        this.x = x;
        this.y = y;
        this.tam = tam;
        this.padding = padding;
    }
    Draw(int cor,int stroke,float x,float y,String type){
        this.cor = cor;
        this.stroke = stroke;
        this.x = x;
        this.y = y;
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
            case "ellipseNsT":
                noStroke();
                fill(this.stroke);
                ellipse(this.x,this.y,this.a,this.b);
                break;
            case "line":
                stroke(this.stroke);
                line(this.x,this.y,this.a,this.b);
                break;
            case "text":
                ecri(this.text,this.cor,this.x,this.y,this.tam,this.padding);
                break;
            case "point":
                fill(this.cor);
                stroke(this.stroke);
                point(this.x,this.y);
                break;
            case "None":
                break;
        }
        
    }
}