
<?php
require_once "../perguntas.inc";
$id = $_GET["id"];

$perg = carregaPergunta($id);
echo file_get_contents("../menu.inc");
$found = false;
if ($perg!=-1){
    $found = true;
    echo "<ol>";
    echo "<h2>".$perg["enunciado"]."</h2>";
    for ($i=0;$i<count($perg["alternativas"]);$i++){
        if ($i==$perg["resposta"]){
            echo "<li class='resp'>".$perg["alternativas"][$i]."</li>";
        }else{
            echo "<li class='wrong'>".$perg["alternativas"][$i]."</li>";
        }
    }
    echo "</ol>";
}
?>
<form method="post" action="verify.php">
    <input type="hidden" name="question" value=<?php echo $id?>>  

    <!-- <label for="email">E-mail:</label> -->
    <!-- <input type="email" name="email" id="email"> -->
    
    <input type="number" placeholder="Índice da resposta:" name="answer">

    <input type="submit" value="Enviar">
</form>
<?php


if (!$found){
    echo "<h2>Pergunta não encontrada.</h2>";
}
echo file_get_contents("../rodape.inc");


?>