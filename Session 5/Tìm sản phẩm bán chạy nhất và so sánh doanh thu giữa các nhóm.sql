set search_path to product;
-- Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
-- Hiển thị: product_name, total_revenue
SELECT p.product_name, SUM(o.total_price) AS total_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id
HAVING SUM(o.total_price) = (
    SELECT MAX(total_revenue)
    FROM (
             SELECT SUM(total_price) AS total_revenue
             FROM orders
             GROUP BY product_id
         )  as t
);

-- Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
select p.category, sum(total_price) total_revenue
from products p
join orders o on p.product_id = o.product_id
group by p.category

--     Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000
SELECT p.category
FROM products p
WHERE p.product_id = (
    SELECT product_id
    FROM orders
    GROUP BY product_id
    ORDER BY SUM(total_price) DESC
    LIMIT 1
)
INTERSECT
SELECT p.category
FROM products p
         JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 3000;