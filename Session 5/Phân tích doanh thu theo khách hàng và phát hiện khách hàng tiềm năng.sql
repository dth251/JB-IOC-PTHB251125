CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           customer_name VARCHAR(100),
                           city VARCHAR(100)
);

INSERT INTO customers (customer_id, customer_name, city) VALUES
                                                             (1, 'Nguyễn Văn A', 'Hà Nội'),
                                                             (2, 'Trần Thị B', 'Đà Nẵng'),
                                                             (3, 'Lê Văn C', 'Hồ Chí Minh'),
                                                             (4, 'Phạm Thị D', 'Hà Nội');
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customers(customer_id),
                        order_date DATE,
                        total_price INT
);

INSERT INTO orders (order_id, customer_id, order_date, total_price) VALUES
                                                                        (101, 1, '2024-12-20', 3000),
                                                                        (102, 2, '2025-01-05', 1500),
                                                                        (103, 1, '2025-02-10', 2500),
                                                                        (104, 3, '2025-02-15', 4000),
                                                                        (105, 4, '2025-03-01', 800);
CREATE TABLE order_items (
                             item_id SERIAL PRIMARY KEY,
                             order_id INT REFERENCES orders(order_id),
                             product_id INT,
                             quantity INT,
                             price INT
);

INSERT INTO order_items (item_id, order_id, product_id, quantity, price) VALUES
                                                                             (1, 101, 2, 2, 1500),
                                                                             (2, 102, 2, 1, 1500),
                                                                             (3, 103, 3, 5, 500),
                                                                             (4, 104, 2, 4, 1000);

-- Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng:
-- Chỉ hiển thị khách hàng có tổng doanh thu > 2000
-- Dùng ALIAS: total_revenue và order_count
select c.customer_id, c.customer_name, sum(total_price) as total_revenue, count(order_id) order_count
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id
having sum(total_price) > 2000
order by sum(total_price) desc;

-- Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng
-- Sau đó hiển thị những khách hàng có doanh thu lớn hơn mức trung bình đó
-- B1: tính tổng doanh thu của từng khách hàng
-- B2: tính trung bình doanh thu của tất cả khách hàng
-- B3: so sánh các khách hàng có tổng doanh thu > mức trung bình
select c.customer_id, c.customer_name, sum(total_price) as total_revenue
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(total_price) >
       (select avg(trungbinh)
        from (select sum(total_price) as trungbinh
              from orders
              group by customer_id)
            as t
        );

-- Dùng HAVING + GROUP BY để lọc ra thành phố có tổng doanh thu cao nhất
select c.city,sum(total_price) as total_revenue
from customers c
         join orders o on c.customer_id = o.customer_id
group by c.city
having sum(total_price) = (
             SELECT
                 SUM(o.total_price)
             FROM customers c
                      JOIN orders o ON c.customer_id = o.customer_id
             GROUP BY c.city
             ORDER BY SUM(o.total_price) DESC
             LIMIT 1
    )

-- (Mở rộng) Hãy dùng INNER JOIN giữa customers, orders, order_items để hiển thị chi tiết:
-- Tên khách hàng, tên thành phố, tổng sản phẩm đã mua, tổng chi tiêu
select c.customer_name, c.city, sum(oi.quantity) as total_products, sum(o.total_price) as total_revenue
from customers c
         join orders o on c.customer_id = o.customer_id
         join order_items oi on o.order_id = oi.order_id
group by c.customer_id
order by total_revenue desc;