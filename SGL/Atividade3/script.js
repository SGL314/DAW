var nums = [];
const qtd = 4;
const vari = [1,20];


function create(){
    for (var i=0;i<qtd;i++){
        nums[i] = Math.floor(Math.random()*(vari[1])+vari[0]);
    }
    //
    show("start");
}

function show(where){
    document.getElementById(where).innerHTML = where+":";
    for (var i=0;i<qtd;i++){
        document.getElementById(where).innerHTML += " "+nums[i];    
    }
}

function sorting(){
    merge();
    //
    show("end");

}

function merge(){

    nums = frac(nums);
}

function frac(lista){
    var array = lista;
    var len = array.length;

    if (len == 2){
        if (array[0] > array[1]){
            return [array[1],array[0]];
        }else{
            return array;
        }
    }

    var a =[],b=[],c=[];

    for (var i=0;i<len/2;i++){
        a.push(array[i]);
    }
    for (var i=len/2;i<len;i++){
        b.push(array[i]);
    }    

    a = frac(a);
    b = frac(b);

    console.log(a);
    console.log(b);

    var put_ia = true,put_ib = true;

    for (var i=0;i<len;i++){
        sleep(500);
        console.log(i+"> a: "+a+" b: "+b+"("+put_ia+","+put_ib+")");
        if (put_ia){
            if (!(put_ib)){
                c.push(a[0]);
                a.shift();
            }else{
                if (a[0] < b[0]){
                    c.push(a[0]);
                    a.shift();
                    
                }else if (a[0] == b[0]){
                    c.push(a[0]);
                    a.shift();
                }
            }
            // console.log("a: "+a);
            if (a.length == 0){
                put_ia = false;
            }
        }

        if (put_ib){
            if (!(put_ia)){
                c.push(b[0]);
                b.shift();
            }else{
                if (a[0] > b[0]){
                    c.push(b[0]);
                    b.shift();  
                }
            }
            if (b.length == 0){
                put_ib = false;
            }         
        }    
        
    }
    nums = [...c];
    return c;

}

function sleep(tempo){
    var a = millis();
    while (true){
        b = millis();
        if (b-a>=tempo) break;
    }
}

function bubble(){
    var res = [];
    
    for (var i=0;i<qtd;i++){
        var min = vari[1]+1;
        var ind = 0;
        for (var j=0;j<qtd;j++){
            if (nums[j]<min){
                min = nums[j];
                ind = j;
            }
        }
        res.push(min);
        nums.splice(ind,1);
    }
    
    nums = res;    
}

function setup(){
    createCanvas(600,600);
    
}

function draw(){
    background("#aa0a0a");
    for (var i=0;i<qtd;i++){
        rect(i*width/qtd,(vari[1]-nums[i])*height/(vari[1])+10,width/qtd,height/(vari[1])*nums[i]-12);
    }
}
