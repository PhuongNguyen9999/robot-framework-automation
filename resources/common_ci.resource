*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    # Headless for CI
    Call Method    ${options}    add_argument    --headless=new
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size=1920,1080

    # Chrome for Testing binary path (pipeline)
    Call Method    ${options}    binary_location    /opt/chrome/chrome

    Open Browser    ${url}    ${BROWSER}    options=${options}    executable_path=/usr/local/bin/chromedriver
    Set Selenium Timeout    20s

Close Browser Session
    Close Browser