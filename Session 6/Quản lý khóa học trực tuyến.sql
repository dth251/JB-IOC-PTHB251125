CREATE TABLE Course
(
    id         SERIAL PRIMARY KEY,
    title      VARCHAR(100),
    instructor VARCHAR(50),
    price      NUMERIC(10, 2),
    duration   INT
);

INSERT INTO Course (title, instructor, price, duration)
VALUES ('Lập trình Java Cơ Bản', 'Nguyễn Văn A', 1200000, 40),
       ('SQL cho người mới bắt đầu', 'Trần Thị B', 450000, 20),
       ('Khóa học Demo SQL nâng cao', 'Lê Văn C', 800000, 35),
       ('Phát triển Web với React', 'Phạm Minh D', 2500000, 50),
       ('Data Analysis with SQL', 'Hoàng Anh E', 1500000, 45),
       ('Demo khóa học Marketing', 'Đặng Thu F', 300000, 10);

UPDATE Course
SET price = price * 1.15
WHERE duration > 30;

DELETE
FROM Course
WHERE title LIKE '%Demo%';

SELECT *
FROM Course
WHERE title ILIKE '%SQL%';

SELECT *
FROM Course
WHERE price BETWEEN 500000 AND 2000000
ORDER BY price DESC
LIMIT 3;
