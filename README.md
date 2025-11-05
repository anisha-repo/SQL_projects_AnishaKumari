# 🗃️ SQL Project Portfolio – Anisha kumari

Welcome to my SQL project portfolio!  
These projects demonstrate my ability to design normalized databases, write efficient SQL queries, and analyze real-world data using PostgreSQL.

---

## 📚 1. Library Management System

A relational database built to manage books, members, and book issue records.

**Tech Stack:** PostgreSQL 15, pgAdmin 4  
**Skills Practiced:**  
`CREATE TABLE`, `PRIMARY KEY`, `FOREIGN KEY`, `JOIN`, `GROUP BY`, subqueries, and date/time functions.

**Highlights**
- Designed linked tables for `books`, `members`, and `issued_books`.  
- Implemented constraints to maintain referential integrity.  
- Wrote queries to:
  - Find overdue books using `CURRENT_DATE` and `INTERVAL`.  
  - Identify most-borrowed authors and categories.  
  - Count total books issued vs. available.

---

## 🛒 2. Retail Sales Analysis

A beginner-friendly SQL project focusing on **retail sales data exploration, cleaning, and business analysis** using PostgreSQL.

**Tech Stack:** PostgreSQL 15, pgAdmin 4  
**Skills Practiced:**  
`CTE`, `VIEW`, `CASE`, `DATE_TRUNC`, `WINDOW FUNCTIONS`, aggregate queries, and EDA (Exploratory Data Analysis).

**Highlights**
- Built and populated a retail sales database (`retail_sales_schema_query`) to analyze transaction-level data.  
- Cleaned dataset by removing null or missing records using conditional filters.  
- Performed **exploratory and business-driven queries**, including:
  - Total sales and order count by category.  
  - Monthly and yearly average sales trend analysis.  
  - Identification of **top 5 customers** and **high-value transactions (>1000)**.  
  - Created **time-based shift analysis (Morning, Afternoon, Evening)** using CASE and EXTRACT.  
- Delivered key insights on customer behavior, product performance, and seasonal sales trends.  
- Designed a repeatable SQL workflow covering data setup, cleaning, EDA, and reporting.

---

## 🧠 Key Learnings
- Writing optimized PostgreSQL queries using CTEs, subqueries, and window functions.  
- Implementing **data cleaning** and **business analytics** using SQL alone.  
- Structuring projects to reflect real-world data workflows — from database design to insights.

---


## 📂 Repository Structure
