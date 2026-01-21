*** Settings ***
Library    SeleniumLibrary    timeout=20s

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    ${options}=    Create List
    ...    --headless=new
    ...    --no-sandbox
    ...    --disable-dev-shm-usage
    ...    --window-size=1920,1080

    Open Browser    ${url}    ${BROWSER}    options=${options}
    Maximize Browser Window

Close Browser Session
    Close All Browsers