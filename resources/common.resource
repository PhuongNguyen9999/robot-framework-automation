*** Settings ***
Library    SeleniumLibrary
Library    Process
Library    BuiltIn

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}
    ${options}=    Evaluate    __import__('selenium.webdriver').webdriver.ChromeOptions()
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Open Browser    ${url}    ${BROWSER}    options=${options}
    Maximize Browser Window

Close Browser Session
    Close Browser