<?php

function getMenu(){
    $res = (file_get_contents("menu.inc")==false) ? file_get_contents("../menu.inc") : file_get_contents("menu.inc");
    return $res;
}
function getRodape(){
    $res = (file_get_contents("rodape.inc")==false) ? file_get_contents("../rodape.inc") : file_get_contents("rodape.inc");
    return $res;
}


?>