*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}
    ${options}=    Create Dictionary
    ...    args=--headless,--no-sandbox,--disable-dev-shm-usage
    Open Browser    ${url}    ${BROWSER}    options=${options}
    Maximize Browser Window

Close Browser Session
    Close Browser