<?php

class Usuario {
    public $login;
    public $senha;
    public $email;
    public $nome, $qst;

    public function __construct($login, $senha, $email, $nome, $qst) {
        $this->login = $login;
        $this->senha = $senha;
        $this->email = $email;
        $this->nome  = $nome;
        $this->$qst = $qst;
    }

    // Converte o objeto em array para salvar em JSON
    public function toArray() {
        return [
            "login" => $this->login,
            "senha" => $this->senha,
            "email" => $this->email,
            "nome"  => $this->nome,
            "qst" => $this->qst
        ];
    }
}

    require_once "../perguntas.inc";
    require_once "../htmler.inc";
    $name = $_POST["name"];
    $email = $_POST["email"];
    $senha = $_POST["password"];
    $login = $_POST["username"];
    $found = false;

    $users = json_decode(file_get_contents("../data/users.json"),true);
    for ($i=0;$i<count($users);$i++){
        $user = $users[$i];
        // print_r($user["login"]);
        if ($user["login"] == $login){
            echo '<script>alert("Usuário '.$login.' já existe");</script>';
            $found = true;
            break;
        }
    }
    if (!$found){
        $user = new Usuario($login,$senha,$email,$name,0);
        $users[] = $user;
        
        $json = json_encode($users, JSON_PRETTY_PRINT);
        file_put_contents("../data/users.json", $json);
        echo '<script>alert("Usuário criado");</script>';
    }
?>
<button onclick="history.back();">Voltar</button>