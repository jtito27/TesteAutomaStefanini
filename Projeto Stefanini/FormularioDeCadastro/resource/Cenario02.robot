*** Settings ***
Resource          ../resource/Resource.robot


*** Keywords ***
Abrir navegador
    Open Browser   http://prova.stefanini-jgr.com.br/teste/qa/   ${BROWSER}

Fechar navegador
     Close Browser


Dado que estou na página inicial do site
   Title Should Be     Cadastro de usuários

E não preenchi nenhum campo solicitado
    Click Element    ${ID_NOME}
    Click Element    ${ID_EMAIL}
    Click Element    ${ID_SENHA}

Quando eu clicar no botão cadastrar
    Click Element    ${BT_CADASTRAR}

Então a página deve exibir a mensagem "O campo Nome é obrigatório."
    Element Should Contain    ${CLASS_ERROR}    ${TXT_NOMEOBG}

E a página deve exibir a mensagem "O campo E-mail é obrigatório."
    Wait Until Page Contains    ${TXT_EMAILOBG}
    Page Should Contain   ${TXT_EMAILOBG}

E a página deve exibir a mensagem "O campo Senha é obrigatório."
    Wait Until Page Contains    ${TXT_SENHAOBG}
    Page Should Contain         ${TXT_SENHAOBG}

E a página não deve exibir a tabela de usuários
    Page Should Not Contain    ${HEADER_TABLE}
