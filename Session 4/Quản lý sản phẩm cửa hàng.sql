-- -- create database banhang;

-- create schema product;

create table products
(
    id       serial primary key,
    name     varchar(50),
    category varchar(50),
    price    decimal(10, 2),
    stock    int
);

insert into products (name, category, price, stock)
values ('Laptop dell', 'Electronics', 1500.00, 5),
       ('Chuột logitech', 'Electronics', 25.50, 50),
       ('Bàn phím razer', 'Electronics', 120.00, 20),
       ('Tủ lạnh LG', 'Home Appliances', 800.00, 3),
       ('Máy giặt Samsung', 'Home Appliances', 600.00, 2);

--Thêm sản phẩm mới: 'Điều hòa Panasonic', category 'Home Appliances', giá 400.00, stock 10
insert into products(name, category, price, stock)
values ('Điều hòa Panasonic', 'Home Appliances', 400.00, 10);

-- Cập nhật stock của 'Laptop Dell' thành 7
update products
set stock = 7
where name = 'Laptop Dell';

-- Xóa các sản phẩm có stock bằng 0 (nếu có)
delete
from products
where stock = 0;

-- Liệt kê tất cả sản phẩm theo giá tăng dần
select name
from products
order by price asc;

-- Liệt kê danh mục duy nhất của các sản phẩm (DISTINCT)
select distinct name
from products;

-- Liệt kê sản phẩm có giá từ 100 đến 1000
select name
from products
where price between 100 and 1000;

-- Liệt kê các sản phẩm có tên chứa từ 'LG' hoặc 'Samsung' (sử dụng LIKE/ILIKE)
select name
from products
where name ilike '%LG%' or '%Samsung%';

--Hiển thị 2 sản phẩm đầu tiên theo giá giảm dần, hoặc lấy sản phẩm thứ 2 đến thứ 3 bằng LIMIT và OFFSET
select name
from products
order by name desc
limit 2 offset 1;





