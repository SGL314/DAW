function rangi(min,max){
    var arr = [];
    for (var i=min+1;i<max;i++){
        arr.push(i);
    }
    return arr;
}

function range(min,max,t){
    var arr = [];
    for (var i=min+t;i<max;i+=t){
        arr.push(i);
    }   
    return arr;
}

function reverseArray(arr){
    var arr2 = [];
    for (var i=arr.length-1;i>=0;i--){
        arr2.push(arr[i]);
    }
    return arr2;
}

function toList(array){
    var lista = {
        value:array[0],
        rest:null
    };
    var resting = null,a=null;
    for (var i=array.length-1;i>0;i--){
        a = {
            value: array[i],
            rest: resting
        };
        resting = a;
    }
    lista.rest = a; 
    
    return lista;
}

function deepEquals(obj1, obj2){
    var a = Object.keys(obj1).sort();
    var b = Object.keys(obj2).sort();
    if (a.length != b.length) return false;

    for (var i=0;i<a.length;i++){
        if (a[i] != b[i]){
            return false;
        }
    }

    return true;

}








