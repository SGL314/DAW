<?php

function carregaPergunta($id){
    $json_str = file_get_contents("../questions.json");
    $dados = json_decode($json_str, true);
    $qt = count($dados);
    if ($id+1>$qt){
        return -1;
    }else{
        return $dados[$id];
    }
}

function getDados(){
    $json_str = file_get_contents("questions.json");
    $dados = json_decode($json_str, true);
    return $dados;
}

function getUsers(){
    $json_str = (!file_get_contents("users.json")) ? file_get_contents("../users.json") : file_get_contents("users.json");
    $dados = json_decode($json_str, true);
    return $dados;
}

function head($i,$string){
    echo "<h$i>$string</h$i>";
}

function dorme($tempo){
    usleep($tempo*1000000);
}


?>