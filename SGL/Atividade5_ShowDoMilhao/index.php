<?php
    require_once "perguntas.inc";
    $menu = file_get_contents("menu.inc");
    $rodape = file_get_contents("rodape.inc");
    echo $menu;

    if (session_status() === PHP_SESSION_NONE) {
        session_start();
        $_SESSION["qst"] = 0;
        $_SESSION["logged"] = false;
    }
    if ($_SESSION["logged"] == false){
        header("Location: register/index.php");
        exit;
    }

    $id = $_SESSION["qst"];
    $_SESSION["qst"]+=1;

    header("Location: questions/index.php?id=$id");
    exit;

    // $perg = carregaPergunta($id);

    // $found = false;
    // if ($perg!=-1){
    //     $found = true;
    //     echo "<ol>";
    //     echo "<h2>".$perg["enunciado"]."</h2>";
    //     for ($i=0;$i<count($perg["alternativas"]);$i++){
    //         if ($i==$perg["resposta"]){
    //             echo "<li class='resp'>".$perg["alternativas"][$i]."</li>";
    //         }else{
    //             echo "<li class='wrong'>".$perg["alternativas"][$i]."</li>";
    //         }
    //     }
    //     echo "</ol>";
    // }


    // if (!$found){
    //     echo "<h2>Pergunta não encontrada.</h2>";
    // }


?>