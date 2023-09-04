*** Settings ***
Documentation     Registro de Usuário
Resource          resources/main.robot

Suite Setup       Open OpenCart Page  ${HOST}/index.php?route=account/register&language=en-gb
Suite Teardown    End Suite Test

*** Test Cases ***
Cenário inicial - Privace Policy não selecionado
    Registro    nome    sobrenome   email@email15.com  12345    0
    Wait Until Page Contains    Warning: You must agree to the Privacy Policy!    10

Cenário nome menor que 1 caracter
    Registro    ${empty}    sobrenome   email@email.com  12345  0
    Wait Until Page Contains    First Name must be between 1 and 32 characters!    10

Cenário nome maior que 32 caracter
    Registro    qwertyuiop asdfghjkl zxcvbnm qwerty    sobrenome   email@email.com  12345   0
    Wait Until Page Contains    First Name must be between 1 and 32 characters!    10

Cenário sobrenome menor que 32 caracter
    Registro    nome    ${empty}    email@email.com  12345  0
    Wait Until Page Contains    Last Name must be between 1 and 32 characters!    10

Cenário sobrenome maior que 32 caracter
    Registro    nome    qwertyuiop asdfghjkl zxcvbnm qwerty    email@email.com  12345   0
    Wait Until Page Contains    Last Name must be between 1 and 32 characters!    10

Cenário email vazio
    Registro    nome    sobrenome    ${empty}  12345    0
    Wait Until Page Contains    E-Mail Address does not appear to be valid!    10

Cenário email invalido
    Registro    nome    sobrenome    email  12345   0
    Wait Until Page Contains    E-Mail Address does not appear to be valid!    10

Cenário password menor que 4 caracteres
    Registro    nome    sobrenome    email@email.com  123   0
    Wait Until Page Contains    Password must be between 4 and 20 characters!    10

Cenário password maior que 20 caracteres
    Registro    nome    sobrenome    email@email.com  123456789012345678901     0
    Wait Until Page Contains    Password must be between 4 and 20 characters!    10

Cenário todos vazios
    Registro    ${empty}   ${empty}    ${empty}     ${empty}    0
    Wait Until Page Contains    First Name must be between 1 and 32 characters!    10
    Wait Until Page Contains    Last Name must be between 1 and 32 characters!    10
    Wait Until Page Contains    E-Mail Address does not appear to be valid!    10
    Wait Until Page Contains    Password must be between 4 and 20 characters!    10

Cenário inicial - Registro com sucesso
    ${email}=   FakerLibrary.Email
    Registro    nome    sobrenome   ${email}  12345    1
    Wait Until Page Contains    Your Account Has Been Created!    15

*** Keywords ***
Registro
    [Arguments]     ${nome}     ${sobrenome}        ${email}        ${password}     ${policy}
    
    Input Text                  id=input-firstname  ${nome}
    Input Text                  id=input-lastname   ${sobrenome}
    Input Text                  id=input-email      ${email}
    Input Text                  id=input-password   ${password}
    Click Element               id=input-newsletter

    Click Element               name=agree
    ${checked} =    Get Element Attribute  name=agree  checked
    Run Keyword If  '${checked}' and '${policy}' == '0'    Click Element   name=agree
    
    Click Element               xpath=//button[@type='submit']
