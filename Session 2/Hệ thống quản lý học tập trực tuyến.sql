create database ElearningDB;

create SCHEMA elearning;
set search_path to elearning;

create table Students(
                         student_id serial primary key,
                         first_name varchar(50) not null,
                         last_name varchar(50) not null,
                         email text unique not null
);

create table Instructors(
                            instructor_id serial primary key,
                            first_name varchar(50) not null,
                            last_name varchar(50) not null,
                            email text unique not null
);

create table Courses(
                        course_id serial primary key,
                        course_name varchar(100) not null,
                        instructor_id serial,
                        foreign key (instructor_id) references Instructors(instructor_id)
);

create table Enrollments(
                            enrollment_id serial primary key,
                            student_id serial,
                            course_id serial,
                            enroll_date date not null,
                            foreign key (student_id) references Students(student_id),
                            foreign key (course_id) references Courses(course_id)
);

Create table Assignments(
                            assignment_id serial primary key,
                            course_id serial,
                            title varchar(100) not null,
                            due_date date not null,
                            foreign key (course_id) references Courses(course_id)

);

create table Submissions(
                            submission_id serial primary key,
                            assignment_id serial,
                            student_id serial,
                            submission_date date not null,
                            grade int,
                            foreign key (assignment_id) references Assignments(assignment_id),
                            foreign key (student_id) references Students(student_id),
                            CHECK (grade > 1 AND grade < 100)
);