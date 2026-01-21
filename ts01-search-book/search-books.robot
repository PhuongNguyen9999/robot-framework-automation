*** Variables ***
${ENV}    local
# Biến ENV quyết định chạy trên môi trường nào (local/ci), mặc định là local

*** Settings ***
# Load common resource tương ứng với biến ENV
Resource    ../resources/common_${ENV}.resource
Resource    ../resources/book_store.resource
Resource    ../data/books.resource

# Suite Setup: Chạy 1 lần duy nhất khi bắt đầu file test này -> Mở browser
Suite Setup     Open Browser To URL    ${BOOK_STORE_URL}
# Suite Teardown: Chạy 1 lần duy nhất khi kết thúc file test -> Đóng browser
Suite Teardown  Close Browser Session

# Test Template: Định nghĩa keyword mẫu sẽ được dùng cho tất cả Test Cases bên dưới
Test Template    Search Book And Verify

*** Test Cases ***
# Test case 1: Search với từ khóa 'Design'
TC01 - Search books with keyword Design
    Design

# Test case 2: Search với từ khóa 'design' (kiểm tra case-insensitive)
TC02 - Search books with keyword design
    design


*** Keywords ***
Search Book And Verify
    [Arguments]    ${keyword}
    
    Log    Start test with keyword: ${keyword}

    # Thực hiện search sách
    Search Book    ${keyword}

    # Kiểm tra số lượng sách trả về
    ${count}=    Get Book Count
    # Phải có ít nhất 1 cuốn sách
    Should Be True    ${count} > 0

    # Duyệt qua từng cuốn sách trong kết quả để verify content
    FOR    ${i}    IN RANGE    ${count}
        ${title}=    Get Book Title By Index    ${i}
        Log    Book ${i + 1}: ${title}
        # Tiêu đề sách phải chứa từ mong đợi (design)
        Should Contain    ${title.lower()}    ${SEARCH_EXPECT_TEXT}
    END