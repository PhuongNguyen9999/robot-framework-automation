# *** Settings ***
# Library    SeleniumLibrary

# *** Variables ***
# ${BROWSER}    chrome

# *** Keywords ***
# Open Browser To URL
#     [Arguments]    ${url}
#     Open Browser    ${url}    ${BROWSER}
#     Maximize Browser Window

# Close Browser Session
#     Close Browser



*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${BROWSER}    chrome
${HEADLESS}   false

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    Run Keyword If    '${HEADLESS}'=='true'    Call Method    ${options}    add_argument    --headless=new
    Run Keyword If    '${HEADLESS}'=='true'    Call Method    ${options}    add_argument    --no-sandbox
    Run Keyword If    '${HEADLESS}'=='true'    Call Method    ${options}    add_argument    --disable-dev-shm-usage

    Open Browser    ${url}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Set Selenium Timeout    20s

Close Browser Session
    Close Browser
