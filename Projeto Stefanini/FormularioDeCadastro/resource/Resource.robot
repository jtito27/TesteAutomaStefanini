*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}        http://prova.stefanini-jgr.com.br/teste/qa/
${BROWSER}    chrome

${HEADER_HOME}  Cadastro de usuários
${HEADER_TABLE}  Usuários cadastrados
${ID_USER1}  id=tdUserId1
${ID_USER2}  id=tdUserId2
${ID_USER3}  id=tdUserId3
${REMOVE_USER2}  removeUser2
${ID_NOME}   id=name
${ID_EMAIL}  id=email
${ID_SENHA}  id=password
${BT_CADASTRAR}  id=register
${CLASS_ERROR}   class=error
${TXT_NOMEOBG}   O campo Nome é obrigatório.
${TXT_NOMECOMPLETO}   Por favor, insira um nome completo.
${TXT_EMAILOBG}  O campo E-mail é obrigatório.
${TXT_EMAILINVALIDO}  Por favor, insira um e-mail válido.
${TXT_SENHAOBG}  O campo Senha é obrigatório.
${TXT_SENHAINVALIDA}  A senha deve conter ao menos 8 caracteres.


*** Keywords ***
Abrir navegador
    Open Browser   ${URL}   ${BROWSER}

Fechar navegador
     Close Browser


Dado que estou na página inicial do site
   Title Should Be     ${HEADER_HOME}

E preenchi somente o primeiro nome
    Input Text    ${ID_NOME}    João

E não preenchi nenhum campo solicitado
    Click Element    ${ID_NOME}
    Click Element    ${ID_EMAIL}
    Click Element    ${ID_SENHA}

E preencho o campo e-mail com um e-mail inválido
    Input Text    ${ID_EMAIL}    abc123

E preencho o campo senha com uma senha inválida
    Input Text    ${ID_SENHA}    abc1234

Quando eu clicar no botão cadastrar
    Click Element    ${BT_CADASTRAR}

Então a página deve exibir a mensagem "Por favor, insira um nome completo."
    Element Should Contain    ${CLASS_ERROR}    ${TXT_NOMECOMPLETO}
Então a página deve exibir a mensagem "O campo Nome é obrigatório."
    Element Should Contain    ${CLASS_ERROR}    ${TXT_NOMEOBG}

Então a página deve exibir a mensagem "Por favor, insira um e-mail válido."
    Wait Until Page Contains    ${TXT_EMAILINVALIDO}
    Page Should Contain   ${TXT_EMAILINVALIDO}

E a página deve exibir a mensagem "O campo E-mail é obrigatório."
    Wait Until Page Contains    ${TXT_EMAILOBG}
    Page Should Contain   ${TXT_EMAILOBG}

Então a página deve exibir a mensagem ""A senha deve conter ao menos 8 caracteres."
    Wait Until Page Contains    ${TXT_SENHAINVALIDA}
    Page Should Contain         ${TXT_SENHAINVALIDA}

E a página deve exibir a mensagem "O campo Senha é obrigatório."
    Wait Until Page Contains    ${TXT_SENHAOBG}
    Page Should Contain         ${TXT_SENHAOBG}

E a página não deve exibir a tabela de usuários
    Page Should Not Contain    ${HEADER_TABLE}

###Cenário 05: Realizar cadastro completo
E preencho o campo nome, e-mail e senha com dados válidos
    Input Text    ${ID_NOME}     João Victor
    Input Text    ${ID_EMAIL}    j.tito27@gmail.com
    Input Text    ${ID_SENHA}    abc@1234

Então a página deve exibir o formulário do usuário cadastrados
    Page Should Contain    ${HEADER_TABLE}
    Table Row Should Contain    ${ID_USER1}      1    João Victor

E a opção de excluir para cada um dos usuários cadastrados
    Page Should Contain  Excluir

###Cenário 06: Acionar botão excluir
E tenho várioas usuários cadastrados e exibidos na tabela Usuários cadastrados
    Input Text    ${ID_NOME}     João Victor
    Input Text    ${ID_EMAIL}    j.tito27@gmail.com
    Input Text    ${ID_SENHA}    abc@1234
    Click Element    ${BT_CADASTRAR}
    Input Text    ${ID_NOME}     Luiz Felipe
    Input Text    ${ID_EMAIL}    j.tito28@gmail.com
    Input Text    ${ID_SENHA}    abc@1234
    Click Element    ${BT_CADASTRAR}
    Input Text    ${ID_NOME}     Stefanini QA
    Input Text    ${ID_EMAIL}    j.tito29@gmail.com
    Input Text    ${ID_SENHA}    abc@1234
    Click Element    ${BT_CADASTRAR}
    Page Should Contain    ${HEADER_TABLE}
    Table Row Should Contain    ${ID_USER1}     1    João Victor
    Table Row Should Contain    ${ID_USER2}     2    Luiz Felipe
    Table Row Should Contain    ${ID_USER3}     3    Stefanini QA

Quando eu clicar no botão excluir de um determinado usuário
    Click Element    ${REMOVE_USER2}
Então a página deve excluir a linha em questão
    Page Should Not Contain    Luiz Felipe
E exibir a tabela sem interferir nos ids dos demais itens e em sua ordenação.
    Page Should Contain    ${HEADER_TABLE}
    Table Row Should Contain    ${ID_USER1}      1    João Victor
    Table Row Should Contain    ${ID_USER3}      2    Stefanini QA
