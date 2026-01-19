*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/api.resource
Resource    ../resources/login.resource
Resource    ../resources/profile.resource
Resource    ../data/users.resource
Resource    ../data/books.resource

Suite Setup       Add Book Via API
Suite Teardown    Close Browser

*** Test Cases ***
TC02 - Delete book successfully
    Open Login Page
    Login    ${USERNAME}    ${PASSWORD}
    Verify Login Success    ${USERNAME}

    Go To Profile Page
    Search Book    ${BOOK_NAME}
    Delete Book