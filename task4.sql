-- Task 4: Aggregate Functions and Grouping
USE LibraryDB;

------------------------------------------------------------
-- 1. Apply aggregate functions on numeric columns
------------------------------------------------------------
-- Total number of members
SELECT COUNT(*) AS total_members FROM Members;

-- Average available copies of books
SELECT AVG(available_copies) AS avg_copies FROM Books;

-- Total available copies of all books
SELECT SUM(available_copies) AS total_copies FROM Books;

-- Number of borrowings recorded
SELECT COUNT(*) AS total_borrowings FROM Borrowings;

------------------------------------------------------------
-- 2. Use GROUP BY to categorize
------------------------------------------------------------
-- Count of books published per year
SELECT published_year, COUNT(*) AS books_count
FROM Books
GROUP BY published_year;

-- Number of books authored by each author
SELECT a.name AS author_name, COUNT(ba.book_id) AS books_written
FROM Authors a
JOIN BookAuthors ba ON a.author_id = ba.author_id
GROUP BY a.name;

-- Number of borrowings per member
SELECT m.name AS member_name, COUNT(b.borrow_id) AS total_borrowings
FROM Members m
LEFT JOIN Borrowings b ON m.member_id = b.member_id
GROUP BY m.name;

------------------------------------------------------------
-- 3. Filter groups using HAVING
------------------------------------------------------------
-- Authors who have written more than 1 book
SELECT a.name AS author_name, COUNT(ba.book_id) AS books_written
FROM Authors a
JOIN BookAuthors ba ON a.author_id = ba.author_id
GROUP BY a.name
HAVING COUNT(ba.book_id) > 1;

-- Members who borrowed more than 1 book
SELECT m.name AS member_name, COUNT(b.borrow_id) AS total_borrowings
FROM Members m
JOIN Borrowings b ON m.member_id = b.member_id
GROUP BY m.name
HAVING COUNT(b.borrow_id) > 1;

-- Years in which more than 1 book was published
SELECT published_year, COUNT(*) AS books_count
FROM Books
GROUP BY published_year
HAVING COUNT(*) > 1;
