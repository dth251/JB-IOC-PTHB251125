create database UniversityDB;
create schema university;
set search_path to university;

create table Students(
                                    student_id serial primary key,
                                    first_name varchar(50) not null,
                                    last_name VARCHAR(50) not null,
                                    birth_day date,
                                    email text not null unique
);

create table Courses(
                                   course_id serial primary key,
                                   course_name varchar(100) not null,
                                   credits int
);

create table Enrollments(
                                       enrollment_id serial primary key,
                                       enroll_date date,
                                       student_id serial,
                                       course_id serial,
                                       foreign key (student_id) references Students(student_id),
                                       foreign key (course_id) references Courses(course_id)
);