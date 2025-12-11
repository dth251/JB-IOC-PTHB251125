CREATE TABLE employees (
                           emp_id SERIAL PRIMARY KEY,
                           emp_name VARCHAR(100),
                           job_level INT,
                           salary NUMERIC
);

INSERT INTO employees (emp_name, job_level, salary) VALUES
                                                        ('Nguyễn Văn A', 1, 800.00),
                                                        ('Trần Thị B', 2, 1200.00),
                                                        ('Lê Văn C', 3, 1800.00),
                                                        ('Phạm Thị D', 2, 1300.00),
                                                        ('Hoàng Văn E', 2, 2500.00),
                                                        ('Đặng Thị F', 1, 850.00),
                                                        ('Vũ Văn G', 3, 1900.00),
                                                        ('Bùi Thị H', 2, 1100.00),
                                                        ('Đỗ Văn I', 3, 3200.00),
                                                        ('Ngô Thị K', 2, 2700.00);


create or replace procedure  adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC)
    language plpgsql

as $$
declare
    levelktv int;
begin
    select job_level  into levelktv
    from employees
    where p_emp_id = emp_id;
    select salary  into p_new_salary
    from employees
    where p_emp_id = emp_id;
    if levelktv = 1 then p_new_salary := p_new_salary * 1.05;
    elseif levelktv = 2 then p_new_salary := p_new_salary * 1.1;
    elseif  levelktv = 3 then p_new_salary := p_new_salary * 1.15;
    end if;
end;
$$;

call  adjust_salary(3,p_new_salary := null);


CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          price NUMERIC,
                          discount_percent INT
);

INSERT INTO products (name, price, discount_percent) VALUES
                                                         ('Điện thoại iPhone 15 Pro', 29999.00, 5),
                                                         ('Laptop ASUS ROG Strix', 42999.00, 10),
                                                         ('Tai nghe Sony WH-1000XM5', 6999.00, 15),
                                                         ('Máy ảnh Canon EOS R10', 18999.00, 8),
                                                         ('Màn hình LG UltraGear 27"', 7999.00, 12),
                                                         ('Chuột Logitech G502 X', 1499.00, 60),
                                                         ('Bàn phím cơ Keychron K8', 2199.00, 50),
                                                         ('Ổ cứng SSD Samsung 1TB', 2499.00, 70),
                                                         ('Đèn thông minh Xiaomi Yeelight', 899.00, 25),
                                                         ('Loa Bluetooth JBL Flip 6', 2799.00, 18);

create or replace Procedure calculate_discount(p_id INT, OUT p_final_price NUMERIC)
    language plpgsql
as $$
declare
    giamgia int;
begin
    select price into p_final_price
    from products
    where id = p_id;
    select discount_percent into giamgia
    from products
    where id = p_id;
    if giamgia > 50 then p_final_price := p_final_price * 0.5;
    else  p_final_price :=  p_final_price *  (100 - giamgia) /100;
    end if;

    update products
    set price = p_final_price
    where id = p_id;
end;
$$

    call calculate_discount(6, p_final_price := null);