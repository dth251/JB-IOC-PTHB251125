set search_path to product;
CREATE TABLE products (
                          product_id   SERIAL PRIMARY KEY,
                          product_name VARCHAR(100),
                          category     VARCHAR(50)
);
CREATE TABLE orders (
                        order_id    SERIAL PRIMARY KEY,
                        product_id  INTEGER REFERENCES products(product_id),
                        quantity    INTEGER,
                        total_price INTEGER
);
INSERT INTO products (product_id, product_name, category) VALUES
                                                              (1, 'Laptop Dell', 'Electronics'),
                                                              (2, 'IPhone 15', 'Electronics'),
                                                              (3, 'Bàn học gỗ', 'Furniture'),
                                                              (4, 'Ghế xoay', 'Furniture');
INSERT INTO orders (order_id, product_id, quantity, total_price) VALUES
                                                                     (101, 1, 2, 2200),
                                                                     (102, 2, 3, 3300),
                                                                     (103, 3, 5, 2500),
                                                                     (104, 4, 4, 1600),
                                                                     (105, 1, 1, 1100);
-- Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)
-- Đặt bí danh cột như sau:
-- total_sales cho tổng doanh thu
-- total_quantity cho tổng số lượng
    select (sum(total_price)) as tolal_sales
    from orders

    select (sum(quantity)) as total_quantity
    from orders

-- Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
    select product_id, sum(total_price) as total_sales
    from orders
    group by product_id
    having sum(total_price)> 2000
-- Sắp xếp kết quả theo tổng doanh thu giảm dần
select product_id, sum(total_price) as total_sales
from orders
group by product_id
order by sum(total_price) desc