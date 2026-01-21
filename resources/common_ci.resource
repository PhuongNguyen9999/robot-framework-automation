*** Settings ***
Library    SeleniumLibrary    timeout=30s
# Thư viện SeleniumLibrary giúp điều khiển trình duyệt
# timeout=30s: Thời gian tối đa chờ đợi một phần tử xuất hiện là 30 giây

*** Variables ***
${BROWSER}    chrome
# Biến lưu loại trình duyệt sẽ sử dụng, ở đây là Chrome

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}
    # Keyword này dùng đề mở trình duyệt với các cấu hình dành cho CI (Headless)
    
    # Tạo đối tượng ChromeOptions để cấu hình trình duyệt
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    
    # Thêm các tham số (arguments) để chạy ổn định trên môi trường CI (Linux/Docker)
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    
    # Chạy ở chế độ headless (không hiện giao diện) - bắt buộc trên CI server không có màn hình
    # Dùng dấu \ trước dấu = để Robot Framework không hiểu nhầm là named argument
    Call Method    ${options}    add_argument    --headless\=new
    
    # Set kích thước màn hình ảo để tránh lỗi layout khi render
    Call Method    ${options}    add_argument    --window-size\=1920,1080
    
    # Mở trình duyệt với URL và options đã cấu hình
    Open Browser    ${url}    ${BROWSER}    options=${options}

Close Browser Session
    # Đóng tất cả các trình duyệt đang mở
    Close All Browsers