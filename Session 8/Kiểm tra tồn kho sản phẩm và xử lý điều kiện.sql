CREATE TABLE inventory (
                           product_id SERIAL PRIMARY KEY,
                           product_name VARCHAR(100),
                           quantity INT
);
INSERT INTO inventory (product_name, quantity) VALUES
                                                   ('Laptop Lenovo ThinkPad X1', 15),
                                                   ('Chuột không dây Logitech M185', 50),
                                                   ('Bàn phím cơ Akko 3068', 30),
                                                   ('Màn hình Samsung 24 inch', 20),
                                                   ('Ổ cứng HDD Seagate 2TB', 25),
                                                   ('Tai nghe Bluetooth JBL Tune 510BT', 40),
                                                   ('Webcam Razer Kiyo', 10),
                                                   ('Ghế văn phòng ergonomic', 12),
                                                   ('Bộ phát Wi-Fi TP-Link Archer C6', 18),
                                                   ('Đèn LED để bàn thông minh', 22);

-- Viết một Procedure có tên check_stock(p_id INT, p_qty INT) để:
-- Kiểm tra xem sản phẩm có đủ hàng không
-- Nếu quantity < p_qty, in ra thông báo lỗi bằng RAISE EXCEPTION ‘Không đủ hàng trong kho’
-- Gọi Procedure với các trường hợp:
-- Một sản phẩm có đủ hàng
-- Một sản phẩm không đủ hàng


create or replace procedure check_stock(p_id INT, p_qty INT)
    language plpgsql
as $$
declare
    stock int;
begin
    select quantity into stock
    from inventory
    where product_id = p_id;
    if stock >= p_qty then raise notice 'Đủ hàng trong kho';
    else
        raise exception 'Không đủ hàng trong kho';
    end if;
end;
$$


    call check_stock(1,12);
call check_stock(1,20);
