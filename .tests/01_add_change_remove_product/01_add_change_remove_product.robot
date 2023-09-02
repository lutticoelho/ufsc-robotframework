*** Settings ***
Documentation   Exemplo de teste usando Robot Framework
Library         SeleniumLibrary

*** Variables ***
${URL}           https://bueno.inf.br/teste/
${BROWSER}       Chrome

*** Keywords ***
Abrir o navegador
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
Clicar produto tela principal
    Click Element   xpath=//*[@id="content"]/div[2]/div[1]/form/div[1]/div[1]/a/img
Clicar botao adicionar ao carrinho
    Click Button  id=button-cart
Clicar botao carrinho
    Click Element    xpath=//*[@id="top"]/div/div[2]/ul/li[4]/a
Aguardar ao adicionar
    Wait Until Page Contains  class="alert alert-success alert-dismissible"
Trocar a quantidade
    Input Text    xpath=//*[@id="shopping-cart"]/div/table/tbody/tr/td[4]/form/div/input[1]    15
Clicar atualizar valor
    Click Button    xpath=//*[@id="shopping-cart"]/div/table/tbody/tr/td[4]/form/div/button[1]
Clicar remover produto
    Click Button    xpath=//*[@id="shopping-cart"]/div/table/tbody/tr/td[4]/form/div/button[2]

*** Test Cases ***
Cenário 1: Adicionar produtos no carrinho 
    Abrir o navegador
    Clicar produto tela principal
    Clicar botao adicionar ao carrinho
    Aguardar ao adicionar
    Close Browser

Cenário 2: Alterar a quantidade de produtos no carrinho
    Abrir o navegador
    Clicar produto tela principal
    Clicar botao adicionar ao carrinho
    Aguardar ao adicionar
    Clicar botao carrinho
    Trocar a quantidade
    Clicar atualizar valor
    Close Browser

Cenário 3: Remover produto do carrinho
    Abrir o navegador
    Clicar produto tela principal
    Clicar botao adicionar ao carrinho
    Aguardar ao adicionar
    Clicar botao carrinho
    Clicar remover produto