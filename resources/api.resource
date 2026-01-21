*** Settings ***
Library    RequestsLibrary
Resource   ../data/users.resource
Resource   ../data/books.resource

*** Variables ***
${BASE_URL}    https://demoqa.com
${ALREADY_PRESENT_MSG}    ISBN already present in the User's Collection!

*** Keywords ***
Add Book Via API
    Evaluate    warnings.filterwarnings('ignore', message='Unverified HTTPS request')    modules=warnings
    Delete All Sessions
    Create Session    demoqa    ${BASE_URL}    verify=False

    ${auth}=    Create Dictionary
    ...    userName=${USERNAME}
    ...    password=${PASSWORD}

    # Retry Generate Token (fix flaky 502)
    Wait Until Keyword Succeeds    5x    10s    Generate Token Once    ${auth}

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${TOKEN}
    ...    Content-Type=application/json

    ${isbn}=    Create Dictionary    isbn=${BOOK_ISBN}
    ${isbn_list}=    Create List    ${isbn}

    ${body}=    Create Dictionary
    ...    userId=${USER_ID}
    ...    collectionOfIsbns=${isbn_list}

    Wait Until Keyword Succeeds    5x    10s    Post Book Request    ${body}    ${headers}

Generate Token Once
    [Arguments]    ${auth}
    ${auth_resp}=    POST On Session    demoqa    /Account/v1/GenerateToken    json=${auth}
    Should Be Equal As Integers    ${auth_resp.status_code}    200
    Set Suite Variable    ${TOKEN}    ${auth_resp.json()['token']}

Post Book Request
    [Arguments]    ${body}    ${headers}
    ${resp}=    Post On Session    demoqa    /BookStore/v1/Books    json=${body}    headers=${headers}    expected_status=any
    Run Keyword If    ${resp.status_code} == 400 and "${ALREADY_PRESENT_MSG}" in """${resp.text}"""    Log    Book already exists, skipping add
    ...    ELSE IF    ${resp.status_code} == 201    Log    Book added successfully
    ...    ELSE    Fail    Add book failed: ${resp.status_code} ${resp.text}