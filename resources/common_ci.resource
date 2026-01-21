*** Settings ***
Library    SeleniumLibrary    timeout=20s

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    ${options}=    Evaluate    sys.modules["selenium.webdriver"].ChromeOptions()    sys
    Evaluate    ${options}.add_argument("--headless=new")
    Evaluate    ${options}.add_argument("--no-sandbox")
    Evaluate    ${options}.add_argument("--disable-dev-shm-usage")
    Evaluate    ${options}.add_argument("--window-size=1920,1080")

    Open Browser    ${url}    ${BROWSER}    options=${options}
    Maximize Browser Window

Close Browser Session
    Close All Browsers