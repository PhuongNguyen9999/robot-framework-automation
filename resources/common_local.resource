*** Settings ***
Library    SeleniumLibrary
# Thư viện chính để auto web

*** Variables ***
${BROWSER}    chrome
# Trình duyệt mặc định là Chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}
    # Keyword mở trình duyệt cho môi trường Local (có giao diện để dễ debug)
    Open Browser    ${url}    ${BROWSER}
    # Phóng to cửa sổ trình duyệt lên tối đa
    Maximize Browser Window

Close Browser Session
    # Đóng trình duyệt hiện tại
    Close Browser



