select * from books;
select * from issued_status;
select * from employees;
select * from members;
select * from issued_status;
select * from return_status;

--project task
-- create a new book record --"(978-1-60129-456-2",' To Kill a Mockingbird', 'Classic',6.00, 'yes',' Harper Lee'
--'  J.B. Lippincott & Co.')"
insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values
(978-1-60129-456-2,' To Kill a Mockingbird', 'Classic',6.00, 'yes',' Harper Lee',' J.B. Lippincott & Co.')

--update an existing member address
Update members
set member_address='125 church Street'
where member_id='C102';
select * from members

--delete a record from the issued status table 
-- objective: delete the record with issued_id="IS121" from the issued_status table
delete from issued_status
where issued_id='IS121'

-- Retrieve all books Issued  by a specific employee 
-- objective: select all books issued by the employee with emp_id='E101'
select * from issued_status
where issued_emp_id='E101'

-- list members who have issued more than one book 
-- Objective: use group by to find members who have issued more than one book

select 
	issued_emp_id,
	count(*) no_of_books_issued
from issued_status
group by issued_emp_id
having count(*)>1

--CTAS - create table as select
-- create a summary  tables: used CTAS to generate new tables based on query result - each book and total book_issued_cnt
create table book_issued_cnt as
select b.isbn,
	   b.book_title,
	   count(ist.issued_id) as no_of_times_issued
from books as b
join issued_status as ist
on ist.issued_book_isbn=b.isbn
group by 1,2

-- retrieve all book in a specific category
select 
	*
from books
where category ='Classic'

-- find total rental income by cateogy
select b.category,
	  sum(b.rental_price)
from books as b
join issued_status as ist
on ist.issued_book_isbn=b.isbn
group by 1

--list members who registered in the last 180 days
select * from members
where reg_date>=current_date - interval '180 days'

--list employees with their branch manager's name and their branch details
select 
	e1.*,
	b.manager_id,
	e2.emp_name as manager
from employees as e1
Join branch as b
on b.branch_id=e1.branch_id
join
employees as e2
on b.manager_id=e2.emp_id

--create a table of books with rental price above a certaine threshold 7USD

create table book_price_above_7
as
select * from books
where rental_price>7

-- Retrieve the list of books not yet returned

select * from issued_status
left join return_status
on issued_status.issued_id=return_status.issued_id
where return_id is null


--identify members with overdue books
--Write a query to identify members who have overdue books(assume a 30-day return period).
--display the member's name, book title, issue date and days overdue

SELECT 
    m.member_id,
    m.member_name,
    b.book_title,
    i.issued_date,
	(CURRENT_DATE - i.issued_date) AS days_overdue
FROM 
    issued_status i
JOIN 
    members m ON i.issued_member_id = m.member_id
JOIN 
    books b ON i.issued_book_isbn = b.isbn
left join 
	return_status r on r.issued_id=i.issued_id
WHERE 
    r.return_date IS NULL 
    AND i.issued_date <= (CURRENT_DATE - INTERVAL '30 DAY');

-- update book status on return
-- Write a query to update the status of books in the books table to 'yes' when they are returned
--(based on entries in the return status table).

create or replace procedure add_return_records
						(
						p_return_id varchar(10),
						p_issued_id varchar(10)
						)
language plpgsql
as $$

declare v_isbn varchar(50);
		v_book_name varchar(80);
begin
	--all your logic and code
	-- inserting into return_status based on user input
	insert into return_status(return_id,issued_id,return_date)
	values
	(p_return_id ,p_issued_id,current_date);

	select
		issued_book_isbn,
		issued_book_name
		into
		v_isbn,
		v_book_name
	from issued_status
	where issued_id=p_issued_id;

	update books
	set status='yes'
	where isbn=v_isbn;

	raise notice 'thank you for returning the book:%',v_book_name;
end;
$$

--testing function add_return_records

issued_id=IS135
isbn ='978-0-307-58837-1'

select * from books
where isbn ='978-0-307-58837-1'

select * from issued_status
where issued_book_isbn='978-0-307-58837-1'

select * from return_status
where issued_id='IS135'

call add_return_records('R138','IS135');


/*
  Branch performance report
  Create a query that generates a performance report for each branch, showing the 
  number of books issued, the number of books 
  returned, and the total revenue generated from book rentals
*/
CREATE TABLE branch_reports
AS
SELECT 
    b.branch_id,
    b.manager_id,
    COUNT(ist.issued_id) as number_book_issued,
    COUNT(rs.return_id) as number_of_book_return,
    SUM(bk.rental_price) as total_revenue
FROM issued_status as ist
JOIN 
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
JOIN 
books as bk
ON ist.issued_book_isbn = bk.isbn
GROUP BY 1, 2;

select * from branch_reports

--CTAS: create a table of active members
-- use the create table as (CTAS) statement to create a new table active_member who have issued 
-- at least one book in the last 2 months
create table active_members
as
select * from members
where member_id in
		(
		select distinct issued_member_id
		from issued_status
		where issued_date>=current_date-interval '2 month'
		)
select * from 	active_members	

-- find employees with the most book issues processed
-- Write a query to find the top 3 employees who have processed the most book issues.
-- display the employee name, number of books processed and their branch
select 
e.emp_name,
b.*,
count(ist.issued_id) as no_book_issued
from issued_status as ist
join employees as e
on e.emp_id=ist.issued_emp_id
join branch as b
on e.branch_id=b.branch_id
group by 1,2


/*
 Stored Procedure Objective: 

Create a stored procedure to manage the status of books in a library system. 

Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 

The procedure should function as follows: 

The stored procedure should take the book_id as an input parameter. 

The procedure should first check if the book is available (status = 'yes'). 

If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 

If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
*/

SELECT * FROM books;

SELECT * FROM issued_status;


CREATE OR REPLACE PROCEDURE issue_book(p_issued_id VARCHAR(10), p_issued_member_id VARCHAR(30), p_issued_book_isbn VARCHAR(30), p_issued_emp_id VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
-- all the variabable
    v_status VARCHAR(10);

BEGIN
-- all the code
    -- checking if book is available 'yes'
    SELECT 
        status 
        INTO
        v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    IF v_status = 'yes' THEN

        INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES
        (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

        UPDATE books
            SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

        RAISE NOTICE 'Book records added successfully for book isbn : %', p_issued_book_isbn;


    ELSE
        RAISE NOTICE 'Sorry to inform you the book you have requested is unavailable book_isbn: %', p_issued_book_isbn;
    END IF;

    
END;
$$


SELECT * FROM books;
-- "978-0-553-29698-2" -- yes
-- "978-0-375-41398-8" -- no
SELECT * FROM issued_status;


CALL issue_book('IS155', 'C108', '978-0-553-29698-2', 'E104');



CALL issue_book('IS156', 'C108', '978-0-375-41398-8', 'E104');


SELECT * FROM books
WHERE isbn = '978-0-375-41398-8'

--
