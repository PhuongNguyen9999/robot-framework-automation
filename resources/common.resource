*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}    options=add_argument(--headless) add_argument(--no-sandbox) add_argument(--disable-dev-shm-usage)
    Maximize Browser Window

Close Browser Session
    Close Browser