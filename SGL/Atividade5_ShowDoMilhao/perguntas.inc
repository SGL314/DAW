<?php
class Usuario {
    public $login;
    public $senha;
    public $email;
    public $nome;
    public $qst;

    public function __construct($login, $senha, $email, $nome, $qst) {
        $this->login = $login;
        $this->senha = $senha;
        $this->email = $email;
        $this->nome  = $nome;
        $this->qst = $qst;
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

function carregaPergunta($id){
    $json_str = file_get_contents("../data/questions.json");
    $dados = json_decode($json_str, true);
    $qt = count($dados);
    if ($id+1>$qt){
        return -1;
    }else if ($id+1==$qt){
        return 0;
    }else{
        return $dados[$id];
    }
}

function getDados(){
    $json_str = file_get_contents("questions.json");
    $dados = json_decode($json_str, true);
    return $dados;
}

function getUsers(){
    $json_str = (!file_get_contents("data/users.json")) ? file_get_contents("../data/users.json") : file_get_contents("data/users.json");
    $dados = json_decode($json_str, true);
    return $dados;
}

function getUser($login){
    $users = getUsers();
    foreach ($users as $user){
        if ($user["login"] == $login){
            //echo ">".$user["qst"];
            $new = new Usuario($user["login"],$user["senha"],$user["email"],$user["nome"],$user["qst"]);
            return $new;
        }
    }
    return false;
}

function head($i,$string){
    echo "<h$i>$string</h$i>";
}

function dorme($tempo){
    usleep($tempo*1000000);
}

function verificaLogin($u,$p){
    $users = getUsers();
    foreach ($users as $user){
        if ($user["login"] == $u){
            if ($user["senha"] == $p){
                return $user;
            }
        }
    }
    return false;
}

function saveQuestion($u,$qst){
    $users = getUsers();
    $index = 0;

    foreach ($users as $user){
        echo $user;
        if ($user["login"] == $u){
            $users[$index]["qst"] = $qst;
            echo "colocado";

            $json = json_encode($users, JSON_PRETTY_PRINT);
            file_put_contents("data/users.json", $json);
            break;
        }
        $index+=1;
    }
    echo "return";
}


?>