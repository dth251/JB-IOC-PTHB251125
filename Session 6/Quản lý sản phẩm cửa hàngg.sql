CREATE TABLE Product
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(100),
    category VARCHAR(50),
    price    NUMERIC(10, 2),
    stock    INT
);

INSERT INTO Product (name, category, price, stock)
VALUES ('iPhone 15', 'Điện tử', 22000000, 10),
       ('Laptop Dell XPS', 'Điện tử', 35000000, 5),
       ('Chuột không dây', 'Điện tử', 500000, 20),
       ('Bàn làm việc', 'Nội thất', 1500000, 2),
       ('Tai nghe Sony', 'Điện tử', 8500000, 15);

SELECT *
FROM Product;

SELECT *
FROM Product
ORDER BY price DESC
LIMIT 3;

SELECT *
FROM Product
WHERE category = 'Điện tử'
  AND price < 10000000;

SELECT *
FROM Product
ORDER BY stock ASC;