*** Variables ***
${ENV}    local

*** Settings ***
Resource    ../resources/common.resource
Resource    ../resources/common_${ENV}.resource
Resource    ../resources/book_store.resource
Resource    ../data/books.resource

Suite Setup     Open Browser To URL    ${BOOK_STORE_URL}
Suite Teardown  Close Browser Session

Test Template    Search Book And Verify

*** Test Cases ***
TC01 - Search books with keyword Design
    Design

TC02 - Search books with keyword design
    design


*** Keywords ***
Search Book And Verify
    [Arguments]    ${keyword}

    Log    Start test with keyword: ${keyword}

    Search Book    ${keyword}

    ${count}=    Get Book Count
    Should Be True    ${count} > 0

    FOR    ${i}    IN RANGE    ${count}
        ${title}=    Get Book Title By Index    ${i}
        Log    Book ${i + 1}: ${title}
        Should Contain    ${title.lower()}    ${SEARCH_EXPECT_TEXT}
    END