<?php
if (isset($_GET['caminho'])) {
    $caminho = $_GET['caminho'];

    // Segurança: sanitize o caminho para evitar acesso a arquivos sensíveis
    $caminho = realpath($caminho);

    // Verifica se o arquivo existe e está dentro do diretório permitido
    $dirPermitido = realpath(__DIR__.'/../data/files/');
    if (strpos($caminho, $dirPermitido) === 0 && file_exists($caminho)) {
        header('Content-Type: text/plain');
        readfile($caminho);
    } else {
        echo "Acesso negado ou arquivo não encontrado.";
        http_response_code(403);
    }
} else {
    http_response_code(400);
    echo "Parâmetro 'caminho' não informado.";
}
?>
