*** Settings ***
Documentation     Gestão de produtos no Painel Administrativo
Resource          resources/main.robot

Test Setup        Open Browser And Acess Admin Panel
Test Teardown     End Suite Test

*** Test Cases ***
Create New Product in Admin Panel with success
    Open Product Pages
    ${some_uuid}    Uuid 4
    Fill Product Page Form  prod-seo-${some_uuid}
    Wait Until Page Contains  Success: You have modified products!    10
    
Create New Product in Admin Panel should show error if SEO input is already in use
    Open Product Pages
    Fill Product Page Form  prod-seo
    Wait Until Page Contains  Warning: Please check the form carefully for errors!    10

*** Keywords ***
Fill Product Page Form 
    [Arguments]    ${prod-seo}
    Click Link  jquery:#content > div.page-header > div > div > a
    Sleep  2
    Input Text  id:input-name-1  New Product
    Input Text  id:input-meta-title-1  Meta Title
    Input Text  id:input-meta-description-1  Meta description
    Execute Javascript  $('#tab-general').hide(); $('#tab-data').show()
    Input Text  id:input-model  ProductModel123
    Input Text  id:input-price  100
    Execute Javascript  $('#tab-data').hide(); $('#tab-seo').show()
    Input Text  id:input-keyword-0-1  ${prod-seo} 
    Click Element  jquery:#content > div.page-header > div > div > button

Open Browser And Acess Admin Panel
    Open Browser To Login Page
    OpenCart Login  admin  nCvj#D8V$b5X$7Dq%wGu
    Wait Until Location Contains  dashboard    10

Open Product Pages
    ${ORIGINAL URL}  Get Location 
    ${URL}  Replace String  ${ORIGINAL URL}	common/dashboard	catalog/product
    Go To  ${URL}
    Wait Until Location Contains  catalog/product

Open Browser To Login Page
    Open OpenCart Page  ${HOST}/painel
    Title Should Be    Administration


