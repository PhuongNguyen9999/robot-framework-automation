*** Settings ***
# File chứa các keyword thao tác với trang Book Store

*** Variables ***
${BOOK_STORE_URL}    https://demoqa.com/books
${SEARCH_BOX}        id:searchBox
${BOOK_TITLES}      css:.rt-tbody .rt-tr-group a

*** Keywords ***
Open Book Store Page
    [Arguments]    ${url}
    # Mở trang Book Store
    Go To    ${url}

Search Book
    [Arguments]    ${keyword}
    # Chờ ô search xuất hiện
    Wait Until Element Is Visible    ${SEARCH_BOX}    10s
    # Nhập từ khóa tìm kiếm
    Input Text    ${SEARCH_BOX}    ${keyword}
    # Sleep nhẹ để chờ table filter kết quả
    Sleep    1s

Get Book Count
    # Đếm số lượng sách hiển thị trong bảng kết quả
    ${count}=    Get Element Count    css:.rt-tbody .rt-tr-group a
    RETURN    ${count}

Get Book Title By Index
    [Arguments]    ${index}
    # Lấy tiêu đề sách theo chỉ số index (dòng thứ mấy trong bảng)
    # XPath này tìm đến thẻ <a> trong dòng thứ index+1 (do xpath bắt đầu từ 1)
    ${title}=    Get Text    xpath=(//div[@class="rt-tbody"]//a)[${index}+1]
    RETURN    ${title}