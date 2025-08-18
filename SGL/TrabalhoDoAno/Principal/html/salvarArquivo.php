<?php
if (isset($_POST['caminho']) && isset($_POST['conteudo'])) {
    $caminho = $_POST['caminho'];
    $conteudo = $_POST['conteudo'];

    // Segurança: sanitize o caminho para evitar acesso indevido
    $caminho = realpath($caminho);
    $dirPermitido = realpath(__DIR__ . '/data/files/');
    
    if (strpos($caminho, $dirPermitido) === 0) {
        if (file_put_contents($caminho, $conteudo) !== false) {
            echo "Arquivo salvo com sucesso!";
        } else {
            http_response_code(500);
            echo "Erro ao salvar o arquivo.";
        }
    } else {
        http_response_code(403);
        echo "Acesso negado.";
    }
} else {
    http_response_code(400);
    echo "Parâmetros insuficientes.";
}
?>
