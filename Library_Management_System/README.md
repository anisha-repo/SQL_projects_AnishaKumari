# 📚 Library Management System (SQL Project – P2)

## 📘 Overview
An **intermediate-level SQL project** that demonstrates the design and management of a Library Management System.  
The project focuses on creating database tables, performing CRUD operations, and writing advanced SQL queries for data analysis and reporting.  

**Database Used:** `library_db`

---

## 🎯 Objectives
- Design and set up a normalized database.  
- Perform CRUD operations on tables.  
- Use **CTAS** (Create Table As Select) for derived tables.  
- Implement **advanced SQL queries** for analytics and reports.

---

## 🗄️ Database Design
![ERD](https://github.com/anisha-repo/SQL_projects_AnishaKumari/blob/main/Library_Management_System/erd.png)

**Main Tables:**  
`branch`, `employees`, `members`, `books`, `issued_status`, `return_status`

---

## ⚙️ Key Operations

### 🔹 CRUD Examples
```sql
-- Insert a new book
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Update a member’s address
UPDATE members SET member_address = '125 Oak St' WHERE member_id = 'C103';

-- Delete an issued record
DELETE FROM issued_status WHERE issued_id = 'IS121';
-- Books issued by a specific employee
SELECT * FROM issued_status WHERE issued_emp_id = 'E101';

-- Members who issued more than one book
SELECT issued_member_id, COUNT(*) 
FROM issued_status 
GROUP BY 1 
HAVING COUNT(*) > 1;

-- Create a summary table using CTAS
CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count
FROM issued_status ist
JOIN books b ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

-- Members with overdue books (30+ days)
SELECT ist.issued_member_id, m.member_name, bk.book_title, ist.issued_date,
       CURRENT_DATE - ist.issued_date AS over_due_days
FROM issued_status ist
JOIN members m ON m.member_id = ist.issued_member_id
JOIN books bk ON bk.isbn = ist.issued_book_isbn
LEFT JOIN return_status rs ON rs.issued_id = ist.issued_id
WHERE rs.return_date IS NULL AND (CURRENT_DATE - ist.issued_date) > 30;
```
## 🧮 Reports Generated
- Total books issued and returned  
- Overdue books and fine tracking  
- Active members in the last 2 months  
- Top employees by issue count  
- Branch-wise performance and revenue summary  

---

## 🏁 Conclusion
This project highlights **SQL proficiency** through schema design, data manipulation, and analytical reporting — demonstrating a practical understanding of real-world database management.





## ✍️ Author
**Anisha Kumari**
