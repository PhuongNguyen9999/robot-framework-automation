*** Settings ***
Library    RequestsLibrary
# Thư viện để gửi HTTP Requests (GET, POST, etc.)
Resource   ../data/users.resource
Resource   ../data/books.resource

*** Variables ***
${BASE_URL}    https://demoqa.com
${ALREADY_PRESENT_MSG}    ISBN already present in the User's Collection!

*** Keywords ***
Add Book Via API
    # Keyword cấu hình để bỏ qua cảnh báo HTTPS không bảo mật
    Evaluate    warnings.filterwarnings('ignore', message='Unverified HTTPS request')    modules=warnings
    
    # Xóa các session cũ để tránh conflict
    Delete All Sessions
    # Tạo session mới tên 'demoqa' trỏ đến BASE_URL, tắt verify SSL để tránh lỗi chứng chỉ
    Create Session    demoqa    ${BASE_URL}    verify=False

    # Tạo dictionary chứa thông tin đăng nhập
    ${auth}=    Create Dictionary
    ...    userName=${USERNAME}
    ...    password=${PASSWORD}

    # Gọi keyword lấy Token, có cơ chế retry (thử lại) nếu server lỗi 502
    # Retry 5 lần, mỗi lần cách nhau 10s
    Wait Until Keyword Succeeds    5x    10s    Generate Token Once    ${auth}

    # Tạo headers cho request add book, bắt buộc có Token
    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${TOKEN}
    ...    Content-Type=application/json

    # Chuẩn bị data body chứa ISBN sách cần thêm
    ${isbn}=    Create Dictionary    isbn=${BOOK_ISBN}
    ${isbn_list}=    Create List    ${isbn}

    ${body}=    Create Dictionary
    ...    userId=${USER_ID}
    ...    collectionOfIsbns=${isbn_list}

    # Gọi keyword gửi request Add book, cũng có retry để xử lý 502
    Wait Until Keyword Succeeds    5x    10s    Post Book Request    ${body}    ${headers}

Generate Token Once
    [Arguments]    ${auth}
    # Gửi POST request để lấy token xác thực
    ${auth_resp}=    POST On Session    demoqa    /Account/v1/GenerateToken    json=${auth}
    # Kiểm tra status code phải là 200 (OK)
    Should Be Equal As Integers    ${auth_resp.status_code}    200
    # Lưu token vào biến Suite để các test case khác dùng lại
    Set Suite Variable    ${TOKEN}    ${auth_resp.json()['token']}

Post Book Request
    [Arguments]    ${body}    ${headers}
    # Gửi request thêm sách vào collection của user
    ${resp}=    Post On Session    demoqa    /BookStore/v1/Books    json=${body}    headers=${headers}    expected_status=any
    
    # Xử lý logic kết quả trả về:
    # Nếu sách đã có (400) -> Log báo đã có, không tính là lỗi
    Run Keyword If    ${resp.status_code} == 400 and "${ALREADY_PRESENT_MSG}" in """${resp.text}"""    Log    Book already exists, skipping add
    # Nếu thêm thành công (201) -> Log thành công
    ...    ELSE IF    ${resp.status_code} == 201    Log    Book added successfully
    # Các trường hợp khác -> Fail test
    ...    ELSE    Fail    Add book failed: ${resp.status_code} ${resp.text}