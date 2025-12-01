create database CompanyDB;

create schema Company;

set search_path to company;
create table emphoyees(
                          emp_id serial primary key,
                          name varchar(255) not null,
                          dob timestamp,
                          department_id serial
);

create table departments(
                            department_id serial primary key,
                            department_name varchar(255) not null
);

create table Projects(
                         project_id serial primary key,
                         project_name varchar(255) not null,
                         start_date date,
                         end_date date
);

create table EmpoyeeProjects(
                                emp_id serial,
                                project_id serial,
                                foreign key (emp_id) references emphoyees(emp_id),
                                foreign key (project_id) references Projects(project_id)
);

alter table emphoyees
    add foreign key (department_id) references departments(department_id);