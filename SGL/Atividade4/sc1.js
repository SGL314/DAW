function create(){
    var tam = document.getElementById("tamanho").value;
    var text = "";

    for (var i =1;i<=tam;i++){
        for (var j=1;j<=i;j++){
            text+="*";
        }
        text+="\n";
    }

    console.log(text);
}

