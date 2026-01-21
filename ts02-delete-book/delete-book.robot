*** Variables ***
${ENV}    local
# Mặc định chạy local

*** Settings ***
Resource    ../resources/api.resource
Resource    ../resources/login.resource
Resource    ../resources/profile.resource
Resource    ../resources/book_store.resource
Resource    ../resources/common_${ENV}.resource
Resource    ../data/users.resource
Resource    ../data/books.resource

# Suite Setup: Chuẩn bị dữ liệu (thêm sách bằng API) trước khi chạy UI test
Suite Setup       Prepare Test Data
# Suite Teardown: Đóng trình duyệt sau khi xong
Suite Teardown    Close Browser Session

*** Test Cases ***
TC02 - Delete book successfully
    # Bước 1: Login vào hệ thống
    Open Login Page
    Login    ${USERNAME}    ${PASSWORD}
    Verify Login Success    ${USERNAME}

    # Bước 2: Vào trang Profile
    Go To Profile Page
    # Đợi body load xong (để chắc chắn trang đã render)
    Wait Until Page Contains Element    //body    20s

    # Bước 3: Search sách cần xóa
    book_store.Search Book    ${BOOK_NAME}
    Wait Until Page Contains    ${BOOK_NAME}    20s

    # Bước 4: Thực hiện xóa sách
    Delete Book

    # Bước 5: Verify xóa thành công
    # Xử lý alert confirm nếu có (keyword Handle Alert)
    Run Keyword And Ignore Error    Handle Alert    ACCEPT
    # Kiểm tra sách không còn xuất hiện trên trang nữa
    Wait Until Page Does Not Contain    ${BOOK_NAME}    20s


*** Keywords ***
Prepare Test Data
    # Gọi API để thêm sách vào tài khoản (Pre-condition)
    # Điều này đảm bảo luôn có sách để xóa mỗi khi chạy test
    Add Book Via API
    # Mở trình duyệt sẵn để các test case UI dùng
    Open Browser To URL    ${BOOK_STORE_URL}