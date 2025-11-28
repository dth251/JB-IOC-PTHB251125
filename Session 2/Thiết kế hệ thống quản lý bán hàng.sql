create database SalesDB;

create schema sales;
set search_path to sales;

create table Customers(
  customer_id serial primary key,
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  email text unique not null,
    phone varchar(10)
);

create table Products(
    product_id serial primary key,
    product_name varchar(100) not null,
    price float not null,
    stock_quantity int not null
);

create table Orders(
  order_id serial primary key,
  customer_id serial,
    order_date date not null,
  foreign key (customer_id) references Customers(customer_id)
);

create table OrderItems(
  order_item_id serial primary key,
  order_id serial,
  product_id serial,
    quantity int,
    foreign key (order_id) references Orders(order_id),
    foreign key (product_id) references Products(product_id),
    check(quantity >=1)
);

