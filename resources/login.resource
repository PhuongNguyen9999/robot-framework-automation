*** Settings ***
# Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}       https://demoqa.com/login
${USERNAME_TXT}    id:userName
${PASSWORD_TXT}    id:password
${LOGIN_BTN}       id:login
${USERNAME_LABEL}  id:userName-value

*** Keywords ***
Open Login Page
    Open Browser    ${LOGIN_URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${USERNAME_TXT}    15s

Login
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_TXT}    ${username}
    Input Text    ${PASSWORD_TXT}    ${password}

    # Scroll login button into view
    Scroll Element Into View    ${LOGIN_BTN}
    Sleep    1s

    # Click bằng JavaScript để tránh bị quảng cáo che
    Execute Javascript    document.getElementById("login").click()

Verify Login Success
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${USERNAME_LABEL}    15s
    Element Text Should Be    ${USERNAME_LABEL}    ${username}