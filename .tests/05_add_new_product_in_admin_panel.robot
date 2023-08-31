*** Settings ***
Library    SeleniumLibrary
Library    String
Library    FakerLibrary

*** Variables ***
${LOGIN URL}      https://bueno.inf.br/teste
${BROWSER}        Firefox
${UUID}           19321f80-081a-4597-baac-4052c1ce9ed6

*** Test Cases ***
Create New Product in Admin Panel
    Open Browser And Acess Admin Panel
    Open Product Pages
    Fill General Product Information  ${UUID} 
    Fill Data Product Information  ${UUID} 
    Fill SEO Product Information  ${UUID} 
    Wait Until Page Contains  Success: You have modified products!
    Close Browser

*** Keywords ***
Fill General Product Information
    [Arguments]    ${expected}
    ${UUID}
    Click Link  jquery:#content > div.page-header > div > div > a
    Input Text  id:input-name-1  NP ${UUID}
    Input Text  id:input-meta-title-1  Meta Title
    Input Text  id:input-meta-description-1  Meta description
    
Fill Data Product Information
    [Arguments]    ${expected}
    ${UUID}
    Execute Javascript  $('#tab-general').hide(); $('#tab-data').show()
    Input Text  id:input-model  PM${UUID}
    Input Text  id:input-price  100

Fill SEO Product Information
    [Arguments]    ${expected}
    ${UUID}
    Execute Javascript  $('#tab-data').hide(); $('#tab-seo').show()
    Input Text  id:input-keyword-0-1  prod-seo-${UUID}
    Click Element  jquery:#content > div.page-header > div > div > button

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
