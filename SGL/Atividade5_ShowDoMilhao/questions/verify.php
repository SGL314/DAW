<?php
    $ans = $_POST["answer"]-1;
    $qst = $_POST["question"];
    
    require_once "../perguntas.inc";
    $perg = carregaPergunta($qst);
    session_start();
    if ($perg["resposta"]==$ans){
        echo "Resposta correta!";
        $_SESSION["qst"] += 1;
        $cod = "<br><button onclick=\"window.location.href='../index.php'\">Próxima</button>";
        echo $cod;
    }else{
        echo "Resposta incorreta!";
        $_SESSION["qst"] = 0;
        $cod = "<br><button onclick=\"window.location.href='../index.php'\">Voltemos ao Início</button>";
        echo $cod;
    }
?>
