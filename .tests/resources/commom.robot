*** Settings ***
Resource          main.robot

*** Variables ***
${HOST}    https://bueno.inf.br/teste


*** Keywords ***
Open OpenCart Page
    [Arguments]  ${URL}
    Open Browser    url=${URL}    browser=%{BROWSER}
    Maximize Browser Window

End Suite Test
    Close All Browsers

OpenCart Login
    [Arguments]    ${username}    ${password}
    Input Text    id=input-username    ${username}
    Input Text    id=input-password    ${password}
    Click Element    xpath=//button[@type='submit']