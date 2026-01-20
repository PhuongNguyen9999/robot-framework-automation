*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    ${options}=    Evaluate    __import__('selenium.webdriver').ChromeOptions()

    Call Method    ${options}    add_argument    --headless=new
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --remote-debugging-port=9222
    Call Method    ${options}    add_argument    --window-size=1920,1080

    Create Webdriver    Chrome    options=${options}
    Go To    ${url}
    Set Selenium Timeout    20s

Close Browser Session
    Close Browser