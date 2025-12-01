create database SchoolDB;

create schema school;
set search_path to school;
create type enum_grade as enum('A','B','C','D','F')
create table students(
  student_id serial primary key,
  name varchar(255) not null,
  dob timestamp
);

create table courses(
    course_id serial primary key,
    course_name varchar(255) not null,
    credits text
);

create table Enrollments(
  enrollment_id serial primary key,
    student_id serial,
    course_id serial,
    grade enum_grade
);
