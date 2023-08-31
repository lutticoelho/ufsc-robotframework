*** Settings ***
Library    SeleniumLibrary
Library    String
Library    FakerLibrary

*** Variables ***
${LOGIN URL}      https://bueno.inf.br/teste
${BROWSER}        Chrome

*** Test Cases ***
Create New Product in Admin Panel
    Open Browser And Acess Admin Panel
    Open Product Pages
    Click Link  jquery:#content > div.page-header > div > div > a
    Input Text  id:input-name-1  New Product
    Input Text  id:input-meta-title-1  Meta Title
    Input Text  id:input-meta-description-1  Meta description
    Execute Javascript  $('#tab-general').hide(); $('#tab-data').show()
    Input Text  id:input-model  ProductModel123
    Input Text  id:input-price  100
    Execute Javascript  $('#tab-data').hide(); $('#tab-seo').show()
    ${some_uuid}    Uuid 4
    Input Text  id:input-keyword-0-1  prod-seo-${some_uuid} 
    Click Element  jquery:#content > div.page-header > div > div > button
    Wait Until Page Contains  Success: You have modified products!    10
    Close Browser

*** Keywords ***
Open Browser And Acess Admin Panel
    Open Browser To Login Page
    Input Text  id=input-username  admin
    Input Text  id=input-password  nCvj#D8V$b5X$7Dq%wGu
    Click Button  css=button[type='submit']
    Wait Until Location Contains  dashboard

Open Product Pages
    ${ORIGINAL URL}  Get Location 
    ${URL}  Replace String  ${ORIGINAL URL}	common/dashboard	catalog/product
    Go To  ${URL}
    Wait Until Location Contains  catalog/product

Open Browser To Login Page
    Open Browser    ${LOGIN URL}/painel    ${BROWSER}
    Maximize Browser Window
    Title Should Be    Administration

