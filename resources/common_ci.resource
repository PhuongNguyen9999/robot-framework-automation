*** Settings ***
Library    SeleniumLibrary    timeout=30s

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    ${options}=    Set Variable
    ...    --no-sandbox
    ...    --disable-dev-shm-usage
    ...    --disable-gpu
    ...    --window-size=1920,1080

    Open Browser    ${url}    ${BROWSER}    options=${options}
    Maximize Browser Window

Close Browser Session
    Close All Browsers