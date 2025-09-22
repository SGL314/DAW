<?php


    $user = $_POST["username"];
    $pass = $_POST["password"];

    require_once "../perguntas.inc";
    $resp = verificaLogin($user, $pass);
    echo $resp;
    if (!$resp) {
        echo "Usuário ou senha inválidos!";
    } else {
        session_start();
        $_SESSION["username"] = $user;
        $_SESSION["logged"] = true;
        $usuario = getUser($user);
        $_SESSION["qst"] = (int)$usuario->qst;
        echo $usuario->qst;
        echo "<script>console.log('Login realizado com sucesso!  Question: ".$usuario->qst."');</script>"; 
        header("Location: ../index.php");
        exit();
    }
?>
<br>    
<button onclick="window.location.href='index.php'">Voltar</button>