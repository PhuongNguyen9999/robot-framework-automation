*** Settings ***
# File chứa các keyword thao tác với trang Profile (cá nhân)

*** Variables ***
${PROFILE_URL}    https://demoqa.com/profile
${SEARCH_BOX}     id:searchBox
${DELETE_BTN}     xpath=//span[@title='Delete']
${OK_BTN}         xpath=//button[text()='OK']

*** Keywords ***
Go To Profile Page
    # Điều hướng đến trang Profile
    Go To    ${PROFILE_URL}
    # Chờ ô search xuất hiện để xác nhận trang đã load
    Wait Until Page Contains Element    ${SEARCH_BOX}    10s

Search Book
    [Arguments]    ${book_name}
    # Tìm kiếm sách trong list cá nhân
    Input Text    ${SEARCH_BOX}    ${book_name}
    Sleep    2s

Delete Book
    # Cuộn xuống cuối trang để chắc chắn nút Delete nhìn thấy được
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    
    # Chờ nút delete (thùng rác) xuất hiện và click
    Wait Until Page Contains Element    ${DELETE_BTN}    10s
    Click Element    ${DELETE_BTN}
    
    # Chờ popup confirm hiện ra và click OK
    Wait Until Page Contains Element    ${OK_BTN}    10s
    Click Button    ${OK_BTN}