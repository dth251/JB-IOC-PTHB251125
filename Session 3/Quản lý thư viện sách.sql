Create database libraryDB;
create schema library;
set search_path to library;

create table Books(
  book_id int primary key,
  title varchar(255),
  author varchar(255),
  published_year int,
  available boolean default true
);

create table Members(
  member_id int primary key,
  name varchar(255),
  email varchar(255) unique,
  join_data date default current_time
);