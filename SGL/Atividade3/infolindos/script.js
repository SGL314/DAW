var words = [
    "lapis",
    "carro",
    "junte",
    "campo",
    "coisa"
];

var word = "";

var ind = Math.floor(Math.random()*5);
word = words[ind];

function verify(){
    var ver = document.getElementById("verify").value;
    
    while (true){
        var geral = document.getElementById("geral");
        var block = document.getElementById("block").cloneNode(true);
        var copy = document.getElementById("copy").cloneNode(true);

        copy.id = "copia";
        block.id = "bloco";

        for (var i=0;i<5;i++){
            var div = copy.querySelector(''+i).cloneNode(true);
            var result = see(ver[i],i);
            if (result == 2) div.style = "color: green;";
            if (result == 1) div.style = "color: yellow;";
            if (result == 0) div.style = "color: gray;";

            div.value = ver[i];

            block.appendChild(div);
        }
    }    
}

function see(look,ind){
    for (var i=0;i<5;i++){
        if (word[i] == look && ind == i){
            return 2;
        }
        if (word[i] == look){
            return 1;
        }
    }
    return 0;
}



