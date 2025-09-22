<?php
    require_once "../htmler.inc";
    echo getMenu();

    ?>
<form method="post" action="login.php">
    <input type="text" name="username" placeholder="Usuário"><br>
    <input type="password" name="password" placeholder="Senha"><br>
    <input type="submit" value="Login">     
</form>
    <?php

    echo getRodape();
?>