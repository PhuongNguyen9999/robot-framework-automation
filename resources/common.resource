*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome
${HEADLESS}   ${False}

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}
    Run Keyword If    '${HEADLESS}'=='True'    Open Browser Headless    ${url}
    ...    ELSE    Open Browser Normal    ${url}
    Maximize Browser Window
    Wait Until Page Contains Element    //body    20s

Open Browser Normal
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}

Open Browser Headless
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}    headlesschrome

Close Browser Session
    Close Browser
