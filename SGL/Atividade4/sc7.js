function main(){
    var frase = document.getElementById("a").value; 
    var c = document.getElementById("b").value[0];

    console.log(countChars(frase,c))
    
}

function countChars(frase, c){
    var qt = 0;
    for (var i=0;i<frase.length;i++){
        if (frase[i] == c){
            qt++;
        }
    }
    return qt;
}


