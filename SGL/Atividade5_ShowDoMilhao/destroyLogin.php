<?php
    session_start();
    require_once "perguntas.inc";
    saveQuestion($_SESSION["username"], $_SESSION["qst"]);
    session_unset();
    session_destroy();
    header("Location: index.php");
    exit();
?>