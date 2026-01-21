*** Settings ***
Library    SeleniumLibrary    timeout=30s

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    ${chrome_args}=    Create List
    ...    --headless
    ...    --no-sandbox
    ...    --disable-dev-shm-usage
    ...    --disable-gpu
    ...    --window-size=1920,1080

    ${options}=    Create Dictionary
    ...    args=${chrome_args}

    Open Browser    ${url}    ${BROWSER}    options=${options}
    Maximize Browser Window

Close Browser Session
    Close All Browsers