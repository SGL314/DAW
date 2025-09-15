<?php
    $ans = $_POST["answer"];
    $qst = $_POST["question"];
    
    require_once "../perguntas.inc";
    $perg = carregaPergunta($qst);
    if ($perg["resposta"]==$ans){
        
    }


?>