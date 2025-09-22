
<?php
require_once "../perguntas.inc";
$id = $_GET["id"];

$perg = carregaPergunta($id);
echo file_get_contents("../menu.inc");
$found = false;
if ($perg!=-1 && $perg!=0){
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
    echo '<form method="post" action="verify.php">
    <input type="hidden" name="question" value=<?php echo $id?>>
    
    <input type="number" placeholder="Número da resposta:" name="answer">

    <input type="submit" value="Enviar">
</form>
<br>';
echo "<button onclick=\"window.location.href='../destroyLogin.php'\">Sair</button>";
}else if ($perg==0){
    $found = true;
    echo "<h2>Parabéns!<br>Você respondeu todas as perguntas corretamente!<br>Ganhou o Show do Milhão!</h2>";
}else{
    echo "<h2>Pergunta não encontrada.<br>".$perg."</h2>";
}
?>

<?php


if (!$found){
    echo "<h2>Pergunta não encontrada.</h2>";
}
echo file_get_contents("../rodape.inc");


?>