*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome
${CHROME_OPTIONS}    add_argument(--headless)    add_argument(--no-sandbox)    add_argument(--disable-dev-shm-usage)

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window

Close Browser Session
    Close Browser