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
