*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser    https://bueno.inf.br/teste/painel/index.php    browser=chrome
Suite Teardown    Close All Browsers

*** Test Cases ***
Teste de Login e senha em branco
     [Tags]    Situacao1
    Login com Credenciais Inválidas    ${EMPTY}    ${EMPTY}

Teste de Login em branco com senha
     [Tags]    Situacao2
    Login com Credenciais Inválidas    ${EMPTY}    nCvj#D8V$b5X$7Dq%wGu

Teste de Login e senha errados preenchidos
    [Tags]    Situacao3
    Login com Credenciais Inválidas    usuario_inexistente    senha_errada

Teste de Login correto e senha errada
     [Tags]    Situacao4
    Login com Credenciais Inválidas    admin    senha_errada

Teste de Login errado e senha correta
     [Tags]    Situacao5
    Login com Credenciais Inválidas    usuario_inexistente    nCvj#D8V$b5X$7Dq%wGu

Teste de Login e senha corretos
     [Tags]    Situacao6
    Login com Credenciais Válidas    admin    nCvj#D8V$b5X$7Dq%wGu




*** Keywords ***
Login com Credenciais Válidas
    [Arguments]    ${username}    ${password}
    Input Text    id=input-username    ${username}
    Input Text    id=input-password    ${password}
    Click Element    xpath=//button[@type='submit']
    Wait Until Page Contains Element    xpath=//div[@id='navigation']

Login com Credenciais Inválidas
    [Arguments]    ${username}    ${password}
    Input Text    id=input-username    ${username}
    Input Text    id=input-password    ${password}
    Click Element    xpath=//button[@type='submit']
    Wait Until Element Is Visible    class=alert-dismissible
    # Wait Until Element Is Visible    xpath=//div[@class='alert-dismissible']    timeout=5s

