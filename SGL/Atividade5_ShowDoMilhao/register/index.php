<?php
    require_once "../htmler.inc";
    echo getMenu();

    ?>
<button onclick="window.location.href='../login/index.php';">Fazer login</button>
<form method="post" action="register.php">
    <input type="text" name="name" placeholder="Nome"><br>
    <input type="email" name="email" placeholder="Email"><br>

    <input type="text" name="username" placeholder="Usuário"><br>
    <input type="password" name="password" placeholder="Senha"><br>
    <input type="submit" value="Registrar">
</form>
    <?php

    echo getRodape();
?>