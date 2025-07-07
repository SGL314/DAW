function mod2_(){
    var a = Number(document.getElementById("a").value);
    console.log(mod2(a));

    
}

function mod_(){
    var a = Number(document.getElementById("a").value); 
    var b = Number(document.getElementById("b").value);

    console.log(mod(a,b));
    
}

function mod2(a){
    return a%2==0;
}

function mod(a,b){
    return a%b==0;
}


