var nums = [];
const qtd = 64;
const vari = [1,20];
var pivot = -1,veri = -1,compareer=-1;


function create(){
    for (var i=0;i<qtd;i++){
        nums[i] = Math.floor(Math.random()*(vari[1])+vari[0]);
    }
    //
    show("e_a");
}

function show(where){
    document.getElementById(where).innerHTML = where+":";
    for (var i=0;i<qtd;i++){
        document.getElementById(where).innerHTML += " "+nums[i];    
    }
}

function sorting(){
    
    //
    // merge();
    console.log("ordenando ...");
    // bubble();
    // strangeSort();
    merge();    
    console.log("ordenado");
    //
    show("e_e");

}

async function frac(lista){
    var len = lista.length;
    console.log(">"+lista)
    var res = [];

    if (len == 2){
        colorama(lista[0],lista[1]);
        await delay(250);
        res = [lista[0],lista[1]];
        if (nums[lista[0]] > nums[lista[1]]){
            var a = nums[lista[0]];
            nums[lista[0]] = nums[lista[1]];
            nums[lista[1]] = a;
        }
        console.log("<"+res);
        return res;
    }

    var a =[],b=[];

    for (var i=0;i<len/2;i++){
        a.push(lista[i]);
    }
    for (var i=len/2;i<len;i++){
        b.push(lista[i]);
    }    

    a = await frac(a);
    b = await frac(b);

    var ra = [],rb=[];
    for (var i=0;i<a.length;i++){
        ra.push(nums[a[i]]);
    }
    for (var i=0;i<b.length;i++){
        rb.push(nums[b[i]]);
    }

    console.log(">a>"+a+" = "+ra);
    console.log(">b>"+b+" = "+rb);
    var all = [];
    var t_all = a.length+b.length;
    for (var i = 0;i<t_all/2;i++){
        all.push(nums[a[i]]);
    }
    for (var i = 0;i<t_all/2;i++){
        all.push(nums[b[i]]);
    }

    console.log("<inicio>: "+all);

    var all_i = [...a];
    for (var i=0;i<b.length;i++){
        all_i.push(b[i])
    }
    // console.log("<<<all_i>>>"+all_i);

    var put_ia = true,put_ib = true;

    for (var i=0;i<len;i++){
        
        await delay(250);
        // console.log(i+"> a: "+a+" b: "+b+"("+put_ia+","+put_ib+")");
        if (put_ib && put_ia){
            colorama(a[0],b[0]);

            if (nums[a[0]] > nums[b[0]]){
                
                res.push(b[0]);
                console.log("b_"+b[0])  
                // console.log("<>"+nums)

                b.shift();
            }else{
                res.push(a[0]);
                console.log("a_"+a[0])
                // console.log("<>"+nums)

                a.shift();
            }
            
        }else if (put_ib==false){
            colorama(a[0],-1);
            res.push(a[0]);
            console.log("a_"+a[0])
            // console.log("<>"+nums)

            a.shift();
        }

        if (a.length == 0){
            put_ia = false;
        }

        if (put_ia == false && b.length > 0){
            res.push(b[0]);
            console.log("b_"+b[0])
            // console.log("<>"+nums)

            b.shift();

            
            colorama(-1,b[0]);         
        }
        if (b.length == 0){
            put_ib = false;
        }   
        
    }
    var saida = [];
    for (var i=0;i<t_all;i++){
        nums[all_i[i]] = all[res[i]%(all.length)];
        saida.push(all[res[i]%(all.length)]);
        console.log("-"+all[res[i]%(all.length)]+"("+res[i]%(all.length));
    }

    console.log("<saida: "+saida);
    return all_i;
}

function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function bubble(){
    var indexs = [];
    for (var i=0;i<nums.length;i++){
        indexs.push(i);
    }
    //
    var len = indexs.length;
    
    for (var i=0;i<len;i++){
        for (var j=i;j<len;j++){
            var a = i;
            var b = j;
            //
            colorama(a,b); 
            //
            if (nums[a] > nums[b]){
                var r = nums[a];
                nums[a] = nums[b];
                nums[b] = r;
            }
            //
            // setTimeout(nada,500);  
            await delay(250); 
        } 
    }
        
     
}

async function strangeSort(){
    var indexs = [];
    for (var i=0;i<nums.length;i++){
        indexs.push(i);
    }
    //
    var len = indexs.length;
    
    for (var i=len-1;i>0;i--){
        for (var j=0;j<i;j++){
            var a = j;
            var b = j+1;
            //
            colorama3(a,b,i); 
            //
            if (nums[a] > nums[b]){
                var r = nums[a];
                nums[a] = nums[b];
                nums[b] = r;
            }
            //
            // setTimeout(nada,500);  
            await delay(250); 
        } 
    }
        
     
}

async function merge(){
    var indexs = [];
    for (var i=0;i<nums.length;i++){
        indexs.push(i);
    }
    //
    await frac(indexs);
    // bubble(indexs);
}

function nada(){}

function colorama(c, v){
    compareer = (c!=-1) ? c : compareer;
    veri = (v!=-1) ? v : veri;
    // draw();
}

function colorama3(c, v, p){
    compareer = (c!=-1) ? c : compareer;
    veri = v;
    pivot = p;
    // draw();
}

function setup(){
    createCanvas(600,600);
    
}

function draw(){
    background("#aa0a0a");
    for (var i=0;i<qtd;i++){
        if (i == pivot && pivot != -1){
            fill("#0000ff");
        }else if (i == veri && veri != -1){
            fill("#00ff00");
        }else if (i == compareer && compareer != -1){
            fill("#ff0000");
        }else{
            fill("#ffffff");
        }
        //
        rect(i*width/qtd,(vari[1]-nums[i])*height/(vari[1])+10,width/qtd,height/(vari[1])*nums[i]-12);
    }
}
