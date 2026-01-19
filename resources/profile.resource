*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${PROFILE_URL}    https://demoqa.com/profile
${SEARCH_BOX}     id:searchBox
${DELETE_BTN}     xpath=//span[@title='Delete']
${OK_BTN}         xpath=//button[text()='OK']

*** Keywords ***
Go To Profile Page
    Go To    ${PROFILE_URL}
    Wait Until Page Contains Element    ${SEARCH_BOX}    10s

Search Book
    [Arguments]    ${book_name}
    Input Text    ${SEARCH_BOX}    ${book_name}
    Sleep    2s

Delete Book
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Wait Until Page Contains Element    ${DELETE_BTN}    10s
    Click Element    ${DELETE_BTN}
    Wait Until Page Contains Element    ${OK_BTN}    10s
    Click Button    ${OK_BTN}