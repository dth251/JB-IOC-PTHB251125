set search_path to library;
-- thêm cột genre(varchar) vào bảng Books
alter table books
add column genre varchar(255);

-- Đổi tên cột available thành is_available
alter table books
rename column available to is_available;

-- Xóa cột email khỏi bảng Members
-- ALTER TABLE tên_bảng
-- DROP COLUMN tên_cột [CASCADE | RESTRICT];
alter table members
drop column email restrict ;

-- Xóa bảng OrderDetails khỏi schema sales
set search_path to sales
drop table orderdetails;



