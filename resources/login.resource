*** Settings ***
# File này chứa các keyword xử lý cho trang Login

*** Variables ***
${LOGIN_URL}       https://demoqa.com/login
${USERNAME_TXT}    id:userName
${PASSWORD_TXT}    id:password
${LOGIN_BTN}       id:login
${USERNAME_LABEL}  id:userName-value

*** Keywords ***
Open Login Page
    # Điều hướng đến trang Login trên browser hiện tại
    Go To    ${LOGIN_URL}
    # Chờ ô Username xuất hiện để đảm bảo trang đã load xong
    Wait Until Element Is Visible    ${USERNAME_TXT}    15s

Login
    [Arguments]    ${username}    ${password}
    # Nhập username và password
    Input Text    ${USERNAME_TXT}    ${username}
    Input Text    ${PASSWORD_TXT}    ${password}

    # Cuộn chuột để nút Login hiện rõ trong khung hình (tránh lỗi element not interacting)
    Scroll Element Into View    ${LOGIN_BTN}
    # Sleep nhẹ để ổn định UI
    Sleep    1s

    # Click bằng JavaScript để chắc chắn click được, kể cả khi bị quảng cáo che
    Execute Javascript    document.getElementById("login").click()

Verify Login Success
    [Arguments]    ${username}
    # Chờ label username xuất hiện sau khi login
    Wait Until Element Is Visible    ${USERNAME_LABEL}    15s
    # Kiểm tra text hiển thị có đúng username đã nhập không
    Element Text Should Be    ${USERNAME_LABEL}    ${username}