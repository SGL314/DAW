function create(){
    var tam = document.getElementById("tamanho").value;
    // console.log(tam.length);
    
    for (var i =0;i<tam.length;i++){
        // console.log(i);
        if (tam[i] != tam[tam.length-i-1]){
            console.log(false);
            return;
        }
        if (i+1<=tam.length/2) break;
    }   

    console.log(true);    
}

