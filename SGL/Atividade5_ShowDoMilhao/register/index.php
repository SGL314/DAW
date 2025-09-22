<?php
    require_once "../htmler.inc";
    echo getMenu();

    ?>
<button onclick="window.location.href='../login/index.php';">Fazer login</button>
<form method="post" action="register.php">
    Identificação:
     <input type="text" name="username" placeholder="Usuário" required><br>
    <input type="password" name="password" placeholder="Senha" required><br>
    Opcionais:
    <input type="text" name="name" placeholder="Nome"><br>
    <input type="email" name="email" placeholder="Email"><br>
   
    <input type="submit" value="Registrar">
</form>
    <?php

    echo getRodape();
?>