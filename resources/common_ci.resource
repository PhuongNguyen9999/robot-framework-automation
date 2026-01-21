*** Settings ***
Library    SeleniumLibrary    timeout=20s

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}
    Maximize Browser Window

Close Browser Session
    Close All Browsers