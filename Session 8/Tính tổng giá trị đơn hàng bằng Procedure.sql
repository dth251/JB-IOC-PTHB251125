CREATE TABLE order_detail (
                              id SERIAL PRIMARY KEY,
                              order_id INT,
                              product_name VARCHAR(100),
                              quantity INT,
                              unit_price NUMERIC
);




INSERT INTO order_detail (order_id, product_name, quantity, unit_price) VALUES
                                                                            (101, 'Laptop Dell XPS 13', 2, 1500.00),
                                                                            (102, 'Chuột Logitech MX Master 3', 5, 99.99),
                                                                            (103, 'Bàn phím cơ Keychron K2', 3, 89.00),
                                                                            (104, 'Màn hình LG UltraFine 4K', 1, 399.99),
                                                                            (105, 'Ổ cứng SSD Samsung 1TB', 4, 129.50),
                                                                            (106, 'Tai nghe Sony WH-1000XM5', 2, 299.99),
                                                                            (107, 'Webcam Logitech C920', 6, 79.99),
                                                                            (108, 'Ghế công thái học Sihoo M57', 1, 249.00),
                                                                            (109, 'Bộ chia USB-C Anker', 3, 39.99),
                                                                            (110, 'Đèn bàn LED Xiaomi', 2, 45.00);


create or replace procedure calculate_order_total(order_id_input INT, OUT total NUMERIC)
    language plpgsql
as $$
begin
    select sum(unit_price * quantity) into total
    from order_detail
    where order_id_input = order_id;
    raise notice 'gia tri tong don hang : %',total;
end;
$$;

call calculate_order_total(101,null)