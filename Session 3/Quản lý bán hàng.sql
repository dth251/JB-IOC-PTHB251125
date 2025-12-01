set search_path to librarydb;

create schema sales;

create table Products(
                         product_id serial primary key,
                         product_name varchar(255),
                         price numeric(10,2),
                         stock_quantity int
);

create table Orders(
                       order_id serial primary key,
                       order_date date default current_date
);

create table OrderDetails(
                             order_detail_id serial primary key,
                             order_id int,
                             product_id int,
                             quantity int,
                             foreign key (order_id) references Orders(order_id),
                             foreign key (product_id) references Products(product_id)
);