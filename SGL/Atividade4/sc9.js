function ord(array,type){
    for (var t=array.length-1;t>0;t--){
        for (var i=0;i<t;i++){
            switch (type){
                case "cr":
                    if (cr(array[i],array[i+1])){
                        var a = array[i];
                        array[i] = array[i+1];
                        array[i+1] = a;
                    }
                    break;
                case "de":
                    if (de(array[i],array[i+1])){
                        var a = array[i];
                        array[i] = array[i+1];
                        array[i+1] = a;
                    }
                    break;
                default:
                    if (cr(array[i],array[i+1])){
                        var a = array[i];
                        array[i] = array[i+1];
                        array[i+1] = a;
                    }
                    break;
            }
        }
    }
    return array;
}

function cr(a,b){
    return a>b;
}

function de(a,b){
    return a<b;
}

function crip(str,key){
    var lets = "abcdefghijklmnopqrstuvwxyz";
    var cri = "";
    for (var i=0;i<str.length;i++){
        var ind = 0;
        for (var j=0;j<str.length;j++){
            if (str[i] == lets[j]){
                ind = j;
                break;
            }
        }
        cri += lets[(j+key)%26];
    }
    return cri;
}

function ver(number,str){
    switch (str){
        case "par":
            console.log(number%2==0)
            break;
        case "imp":
            console.log(number%2==1)
            break;
        case "pri":
            console.log(primo(number))
            break;
        default:
            console.log("Função não detectada: "+str);
            break;
    }
}

function primo(number){
    if (number%2==0) return false;
    for (var d=3;d<Math.sqrt(number);d+=2){
        if (number%d==0) return false;
    }
    return true;
}

function tra(string,type){
    var vog = "aeiouAEIOU";
    var res = "";
    for (var i=0;i<string.length;i++){
        switch (type){
            case "uv":
                if (contains(string[i],vog)){
                    res += string[i].toUpperCase();
                }else{
                    res += string[i];
                }
                break;
            case "uc":
                if (!(contains(string[i],vog))){
                    res += string[i].toUpperCase();
                }else{
                    res += string[i];
                }
                break;
            case "dv":
                if ((contains(string[i],vog))){
                    res += string[i].toLowerCase();
                }else{
                    res += string[i];
                }
                break;
            case "dc":
                if (!(contains(string[i],vog))){
                    res += string[i].toLowerCase();
                }else{
                    res += string[i];
                }
                break;
            default:
                console.log("Função não detectada: "+type);
                break;
        }
    }
    return res;
}

function contains(char,lista){
    for (var i=0;i<lista.length;i++){
        if (char == lista[i]) return true;
    }
    return false;
}

function funMatx(matriz,type){
    var nova = [[]];
     switch (type){
        case "a":
            nova = a(matriz); 
            break;
        case "b":
            nova = b(matriz); 
            break;
        case "c":
            nova = c(matriz); 
            break;
        case "d":
            nova = d(matriz); 
            break;
        case "e":
            nova = e(matriz); 
            break;
        default:
            console.log("Função não detectada: "+type);
            break;
    }
    return nova;
}

function a(m){
    for (var i=0;i<mat.length;i++){
        for (var j=0;j<mat[i].length;j++){
            m[i][j] = i+j;
        }
    }
    return m;
}

function b(m){
    for (var i=0;i<mat.length;i++){
        for (var j=0;j<mat[i].length;j++){
            m[i][j] = i*j;
        }
    }
    return m;
}

function c(m){
    for (var i=0;i<mat.length;i++){
        for (var j=0;j<mat[i].length;j++){
            m[i][j] = i == j ? 1 : 0;
        }
    }
    return m;
}

function d(m){
    for (var i=0;i<mat.length;i++){
        for (var j=0;j<mat[i].length;j++){
            m[i][j] = i^2/(j+1);
        }
    }
    return m;
}

function e(m){
    for (var i=0;i<mat.length;i++){
        for (var j=0;j<mat[i].length;j++){
            m[i][j] = i > j ? 1 : (i < j ? 5 : 0);
        }
    }
    return m;
}

// • m[i][j] = i + j
// • [i][j] = i * j
// • m[i,j] = i == j ? 1 : 0
// • [i,j] = i^2/(j+1)
// • m[i,j] = i > j ? 1 : (i < j ? 5 : 0)