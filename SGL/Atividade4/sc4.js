function create(){

    for (var i =1;i<100;i++){
        var text = "";
        var sh = true;
        if (i%3==0){
            text+= "Fizz";
            sh = false;
        }
        if (i%5==0){
            text+= "Buzz";
            sh = false;
        }
        if (sh){
            text += i;
        }
        console.log(text+"\n");
    }   
  
}


