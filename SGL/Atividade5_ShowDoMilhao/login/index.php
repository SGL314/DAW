<?php
    require_once "../htmler.inc";
    echo getMenu();

    ?>
<form method="post" action="">
    <input type="text" name="username" placeholder="Usuário">
    <input type="password" name="password" placeholder="Senha">
</form>
    <?php

    echo getRodape();
?>