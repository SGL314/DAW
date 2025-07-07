function create(){
    var a = Number(document.getElementById("a").value); 
    var b = Number(document.getElementById("b").value);

    console.log("Min: "+min(a,b));
    console.log("Max: "+max(a,b));
}

function min(a,b){
    if (a<b) return a;
    return b;
}

function max(a,b){
    if (a>b) return a;
    return b;
}


