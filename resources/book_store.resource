*** Settings ***
# Library    SeleniumLibrary

*** Variables ***
${BOOK_STORE_URL}    https://demoqa.com/books
${SEARCH_BOX}        id:searchBox
${BOOK_TITLES}      css:.rt-tbody .rt-tr-group a

*** Keywords ***
Open Book Store Page
    [Arguments]    ${url}
    Go To    ${url}

Search Book
    [Arguments]    ${keyword}
    Wait Until Element Is Visible    ${SEARCH_BOX}    10s
    Input Text    ${SEARCH_BOX}    ${keyword}
    Sleep    1s

Get Book Count
    ${count}=    Get Element Count    css:.rt-tbody .rt-tr-group a
    RETURN    ${count}

Get Book Title By Index
    [Arguments]    ${index}
    ${title}=    Get Text    xpath=(//div[@class="rt-tbody"]//a)[${index}+1]
    RETURN    ${title}