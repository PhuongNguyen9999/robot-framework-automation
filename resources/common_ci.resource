*** Settings ***
Library    SeleniumLibrary    timeout=20s

*** Variables ***
${BROWSER}      chrome
${REMOTE_URL}   http://localhost:4444/wd/hub

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}    remote_url=${REMOTE_URL}
    Maximize Browser Window

Close Browser Session
    Close All Browsers
