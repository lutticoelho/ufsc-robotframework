*** Settings ***
Documentation     Pesquisa de produtos
Resource          resources/main.robot

Suite Setup       Open OpenCart Page  ${HOST}
Suite Teardown    End Suite Test

*** Variables ***
# Termo de pesquisa
${SEARCH_TERM}    macbook 

*** Test Cases ***
Pesquisar Produto Existente
    Pesquisar    ${SEARCH_TERM}
    Wait Until Page Contains Element    css:#product-list    10

Pesquisar Produto Inexistente
    Pesquisar    Surface Pro 2   
    Wait Until Page Contains    There is no product that matches the search criteria.    

*** Keywords ***
Pesquisar    
    [Arguments]    ${SEARCH_TERM}
    Input Text    name=search    ${SEARCH_TERM}
    Click Button    css:#search>button