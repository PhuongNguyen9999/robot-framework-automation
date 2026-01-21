*** Settings ***
Library    SeleniumLibrary    timeout=30s

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    Open Browser    ${url}    ${BROWSER}
    ...    options=add_argument(--headless=new)
    ...    ;add_argument(--no-sandbox)
    ...    ;add_argument(--disable-dev-shm-usage)
    ...    ;add_argument(--disable-gpu)
    ...    ;add_argument(--window-size=1920,1080)

Close Browser Session
    Close All Browsers