*** Settings ***
Resource          ../resource/Resource.robot
Test Setup        Abrir navegador
Test Teardown     Fechar navegador

*** Test Case ***
Cenário 01: Validar cadastro com os campos vazios e não exibição da tabela de usuários
    Dado que estou na página inicial do site
    E não preenchi nenhum campo solicitado
    Quando eu clicar no botão cadastrar
    Então a página deve exibir a mensagem "O campo Nome é obrigatório."
    E a página deve exibir a mensagem "O campo E-mail é obrigatório."
    E a página deve exibir a mensagem "O campo Senha é obrigatório."
    E a página não deve exibir a tabela de usuários

Cenário 02: Validar cadastro com o preenchimento apenas do primeiro nome
     Dado que estou na página inicial do site
     E preenchi somente o primeiro nome
     Quando eu clicar no botão cadastrar
     Então a página deve exibir a mensagem "Por favor, insira um nome completo."
     E a página deve exibir a mensagem "O campo E-mail é obrigatório."
     E a página deve exibir a mensagem "O campo Senha é obrigatório."
     E a página não deve exibir a tabela de usuários

Cenário 03: Validar cadastro com o preenchimento de um e-mail inválido
    Dado que estou na página inicial do site
    E preencho o campo e-mail com um e-mail inválido
    Quando eu clicar no botão cadastrar
    Então a página deve exibir a mensagem "Por favor, insira um e-mail válido."
    E a página não deve exibir a tabela de usuários

Cenário 04: Validar cadastro com o preenchimento de uma senha inválida
    Dado que estou na página inicial do site
    E preencho o campo senha com uma senha inválida
    Quando eu clicar no botão cadastrar
    Então a página deve exibir a mensagem ""A senha deve conter ao menos 8 caracteres."
    E a página não deve exibir a tabela de usuários

Cenário 05: Realizar cadastro completo
    Dado que estou na página inicial do site
    E preencho o campo nome, e-mail e senha com dados válidos
    Quando eu clicar no botão cadastrar
    Então a página deve exibir o formulário do usuário cadastrados
    E a opção de excluir para cada um dos usuários cadastrados

Cenário 06: Acionar botão excluir
    Dado que estou na página inicial do site
    E tenho várioas usuários cadastrados e exibidos na tabela Usuários cadastrados
    Quando eu clicar no botão excluir de um determinado usuário
    Então a página deve excluir a linha em questão
    E exibir a tabela sem interferir nos ids dos demais itens e em sua ordenação.
*** Keywords ***
