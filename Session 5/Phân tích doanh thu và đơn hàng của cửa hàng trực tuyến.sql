set search_path to vd;
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           customer_name VARCHAR(100),
                           city VARCHAR(50)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customers(customer_id),
                        order_date DATE,
                        total_amount NUMERIC(10, 2)
);

CREATE TABLE order_items (
                             item_id SERIAL PRIMARY KEY,
                             order_id INT REFERENCES orders(order_id),
                             product_name VARCHAR(100),
                             quantity INT,
                             price NUMERIC(10, 2)
);


INSERT INTO customers (customer_name, city) VALUES
                                                ('Nguyễn Văn A', 'Hà Nội'),
                                                ('Trần Thị B', 'Hồ Chí Minh'),
                                                ('Lê Văn C', 'Đà Nẵng'),
                                                ('Phạm Thị D', 'Cần Thơ'),
                                                ('Hoàng Văn E', 'Hà Nội');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
                                                               (1, '2023-10-01', 15500000), -- Đơn của Nguyễn Văn A (ID 1)
                                                               (1, '2023-11-15', 1200000),  -- Đơn thứ 2 của Nguyễn Văn A (ID 1)
                                                               (2, '2023-10-05', 25000000), -- Đơn của Trần Thị B (ID 2)
                                                               (3, '2023-12-01', 5000000),  -- Đơn của Lê Văn C (ID 3)
                                                               (4, '2024-01-10', 800000);   -- Đơn của Phạm Thị D (ID 4)

INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
-- Chi tiết cho Order ID 1 (Tổng 15.5tr)
(1, 'Laptop Dell Inspiron', 1, 15000000),
(1, 'Chuột không dây', 1, 500000),

-- Chi tiết cho Order ID 2 (Tổng 1.2tr)
(2, 'Bàn phím cơ', 1, 1200000),

-- Chi tiết cho Order ID 3 (Tổng 25tr)
(3, 'iPhone 14', 1, 20000000),
(3, 'AirPods Pro', 1, 5000000),

-- Chi tiết cho Order ID 4 (Tổng 5tr)
(4, 'Màn hình LG 24 inch', 2, 2500000), -- 2 cái x 2.5tr = 5tr

-- Chi tiết cho Order ID 5 (Tổng 800k)
(5, 'Tai nghe Sony', 1, 800000);

-- ALIAS:
-- Hiển thị danh sách tất cả các đơn hàng với các cột:
-- Tên khách (customer_name)
-- Ngày đặt hàng (order_date)
-- Tổng tiền (total_amount)

select c.customer_name "Tên Khách", o.order_date "Ngày đặt hàng", o.total_amount "Tổng tiền"
from customers c
join orders o on c.customer_id = o.customer_id

-- Aggregate Functions:
-- Tính các thông tin tổng hợp:
-- Tổng doanh thu (SUM(total_amount))
-- Trung bình giá trị đơn hàng (AVG(total_amount))
-- Đơn hàng lớn nhất (MAX(total_amount))
-- Đơn hàng nhỏ nhất (MIN(total_amount))
-- Số lượng đơn hàng (COUNT(order_id))
select SUM(total_amount),AVG(total_amount),MAX(total_amount),MIN(total_amount),COUNT(order_id)
from orders

-- GROUP BY / HAVING:
--     Tính tổng doanh thu theo từng thành phố
--     chỉ hiển thị những thành phố có tổng doanh thu lớn hơn 10.000
select c.city,sum(total_amount) as total_revenue
from customers c
join orders o on c.customer_id = o.customer_id
group by c.city
having sum(total_amount) > 10.000;


-- JOIN:
-- Liệt kê tất cả các sản phẩm đã bán, kèm:
-- Tên khách hàng
-- Ngày đặt hàng
-- Số lượng và giá
-- (JOIN 3 bảng customers, orders, order_items)

select oi.product_name,c.customer_name,o.order_date, oi.quantity,oi.price
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id

-- Subquery:
-- Tìm tên khách hàng có tổng doanh thu cao nhất.
-- Gợi ý: Dùng SUM(total_amount) trong subquery để tìm MAX


select c.customer_id, c.customer_name, sum(total_amount) as total_revenue
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(total_amount) = (
    select max(total)
    from (
             select sum(total_amount) as total
             from customers c
                join orders o on c.customer_id = o.customer_id
             group by c.customer_id
         ) as t
    );


-- Dùng UNION để hiển thị danh sách tất cả thành phố có khách hàng hoặc có đơn hàng
SELECT city FROM customers
UNION
SELECT c.city
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id;

-- Dùng INTERSECT để hiển thị các thành phố vừa có khách hàng vừa có đơn hàng
SELECT city FROM customers
INTERSECT
SELECT c.city
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id;


