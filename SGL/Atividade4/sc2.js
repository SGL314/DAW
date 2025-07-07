function create(){
    var tam = document.getElementById("tamanho").value;
    var text = "";
    var t = [[" ","#"],["#"," "]];
    var ind = 0;

    for (var i =0;i<tam;i++){
        for (var j =0;j<tam;j++){
            text += t[ind][j%2];
        }
        text += "\n";
        ind=(ind==0)?1:0;
    }

    console.log(text);
}

