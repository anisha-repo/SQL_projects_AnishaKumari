--library management system project 2
-- creating branch table
drop table if exists branch;
create table branch
(
	branch_id varchar(10) primary key,
	manager_id varchar(10),
	branch_address varchar(55),
	contact_no varchar(10)
)
drop table if exists employees;
create table employees(
	emp_id varchar(10) primary key,
	emp_name varchar(25),
	position varchar(25),
	salary int,
	branch_id varchar(25)	--fk
);
drop table if exists books;
create table books(
	isbn varchar(20) primary key,
	book_title varchar(75),
	category varchar(10),
	rental_price float,
	status varchar(15),
	author	varchar(35),
	publisher varchar(55)

)

drop table if exists members;
create table members(
	member_id varchar(20) primary key,
	member_name varchar(25),	
	member_address varchar(75),
	reg_date date
);

drop table if exists issued_status;
create table issued_status(
	issued_id varchar(10) primary key,
	issued_member_id varchar(10),   --fk
	issued_book_name varchar(75),
	issued_date	date,
	issued_book_isbn varchar(25),   --fk
	issued_emp_id varchar(10) 		--fk
);
drop table if exists return_status;
create table return_status(
	return_id varchar(10) primary key,
	issued_id varchar(10),
	return_book_name varchar(75),
	return_date date,
	return_book_isbn varchar(20)
);

--foreign key
alter table issued_status
ADD constraint fk_members
FOREIGN KEY (issued_member_id)
references members(member_id)

alter table issued_status
ADD constraint fk_books
FOREIGN KEY (issued_book_isbn )
references books(isbn)

alter table issued_status
ADD constraint fk_employees
FOREIGN KEY (issued_emp_id )
references employees(emp_id)

alter table employees
ADD constraint fk_branch
FOREIGN KEY (branch_id )
references branch(branch_id)

alter table return_status
ADD constraint fk_issued_status
FOREIGN KEY (issued_id )
references issued_status(issued_id)
