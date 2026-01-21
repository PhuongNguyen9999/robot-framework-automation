*** Settings ***
Library    SeleniumLibrary    timeout=20s

*** Variables ***
${BROWSER}      chrome
${REMOTE_URL}   http://localhost:4444/wd/hub

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    ${options}=    Create Dictionary
    ...    args=--headless=new,--no-sandbox,--disable-dev-shm-usage,--window-size=1920,1080

    Open Browser
    ...    ${url}
    ...    ${BROWSER}
    ...    remote_url=${REMOTE_URL}
    ...    options=${options}

    Maximize Browser Window

Close Browser Session
    Close All Browsers