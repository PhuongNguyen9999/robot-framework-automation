*** Variables ***
${ENV}    local

*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/api.resource
Resource    ../resources/login.resource
Resource    ../resources/profile.resource
Resource    ../resources/book_store.resource
Resource    ../resources/common_${ENV}.resource
Resource    ../data/users.resource
Resource    ../data/books.resource

Suite Setup       Prepare Test Data
Suite Teardown    Close Browser Session

*** Test Cases ***
TC02 - Delete book successfully
    Open Login Page
    Login    ${USERNAME}    ${PASSWORD}
    Verify Login Success    ${USERNAME}

    Go To Profile Page
    Wait Until Page Contains Element    //body    20s

    book_store.Search Book    ${BOOK_NAME}
    Wait Until Page Contains    ${BOOK_NAME}    20s

    Delete Book

    Run Keyword And Ignore Error    Handle Alert    ACCEPT
    Wait Until Page Does Not Contain    ${BOOK_NAME}    20s


*** Keywords ***
Prepare Test Data
    Add Book Via API
    Run Keyword If    '${ENV}' == 'ci'    Open Browser To URL    ${BOOK_STORE_URL}