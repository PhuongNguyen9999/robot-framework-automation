*** Settings ***
Library    SeleniumLibrary    timeout=30s

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    Open Browser    ${url}    ${BROWSER}
    ...    options=add_argument:--headless
    ...    options=add_argument:--no-sandbox
    ...    options=add_argument:--disable-dev-shm-usage
    ...    options=add_argument:--disable-gpu
    ...    options=add_argument:--window-size=1920,1080

    Maximize Browser Window

Close Browser Session
    Close All Browsers