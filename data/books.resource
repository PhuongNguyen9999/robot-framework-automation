*** Variables ***
# Danh sách từ khóa test cho search
@{SEARCH_KEYWORDS}    Design    design
# Text mong đợi xuất hiện trong kết quả search
${SEARCH_EXPECT_TEXT}    design

# Thông tin sách cụ thể (cho test case Delete/Add)
${BOOK_NAME}    Learning JavaScript Design Patterns
${BOOK_ISBN}    9781449331818