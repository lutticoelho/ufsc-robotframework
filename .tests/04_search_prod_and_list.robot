*** Settings ***
Library           SeleniumLibrary

*** Variables ***
# URL do site
${URL}            https://bueno.inf.br/teste/
# Navegador
${BROWSER}        Chrome
# Termo de pesquisa
${SEARCH_TERM}    macbook 

*** Test Cases ***
Pesquisar Produto
    Open Browser    ${URL}    ${BROWSER}
    Input Text    name=search    ${SEARCH_TERM}
    Click Button    css:#search>button
    

    #Wait Until Page Contains Element    css=div.product-layout.product-grid
    Wait Until Page Contains Element    css:#product-list
    [Teardown]    Close Browser