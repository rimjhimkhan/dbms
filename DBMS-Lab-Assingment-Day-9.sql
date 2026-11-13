
-- ============================================================
-- GROUP A
-- Q1. Create CUSTOMER, MOVIE and INVOICE tables
-- ============================================================


-- Create CUSTOMER table

CREATE TABLE CUSTOMER (
    CUST_ID VARCHAR2(3),
    FNAME VARCHAR2(20) NOT NULL,
    LNAME VARCHAR2(25),
    AREA VARCHAR2(2) NOT NULL,
    PHONE NUMBER(10),

    CONSTRAINT PK_CUSTOMER PRIMARY KEY (CUST_ID),
    CONSTRAINT CK_CUSTOMER_ID CHECK (CUST_ID LIKE 'A%')
);


-- Create MOVIE table

CREATE TABLE MOVIE (
    MV_NO NUMBER(2),
    TITLE VARCHAR2(30) NOT NULL,
    TYPE VARCHAR2(15) NOT NULL,
    STAR VARCHAR2(20) NOT NULL,
    PRICE NUMBER(6,2) NOT NULL,

    CONSTRAINT PK_MOVIE PRIMARY KEY (MV_NO)
);


-- Create INVOICE table

CREATE TABLE INVOICE (
    INV_NO VARCHAR2(3),
    MV_NO NUMBER(2),
    CUST_ID VARCHAR2(3),
    ISSUE_DATE DATE NOT NULL,
    RETURN_DATE DATE NOT NULL,

    CONSTRAINT PK_INVOICE PRIMARY KEY (INV_NO),
    CONSTRAINT CK_INVOICE_NO CHECK (INV_NO LIKE 'I%'),
    CONSTRAINT FK_INVOICE_MOVIE FOREIGN KEY (MV_NO)
        REFERENCES MOVIE(MV_NO),
    CONSTRAINT FK_INVOICE_CUSTOMER FOREIGN KEY (CUST_ID)
        REFERENCES CUSTOMER(CUST_ID)
);


-- Insert records into CUSTOMER table

INSERT INTO CUSTOMER VALUES
('A01', 'Ivan', 'Bayross', 'SA', 6125467);

INSERT INTO CUSTOMER VALUES
('A02', 'Vandana', 'Saiteal', 'MU', 5560379);

INSERT INTO CUSTOMER VALUES
('A03', 'Pramada', 'Jauguste', 'DA', 4560389);

INSERT INTO CUSTOMER VALUES
('A04', 'Basu', 'Navindi', 'BA', 6125401);

INSERT INTO CUSTOMER VALUES
('A05', 'Ravi', 'Shreedhar', 'NA', NULL);

INSERT INTO CUSTOMER VALUES
('A06', 'Rukmini', NULL, 'GH', 5125274);


-- Insert records into MOVIE table

INSERT INTO MOVIE VALUES
(1, 'Bloody', 'Action', 'JC', 181);

INSERT INTO MOVIE VALUES
(2, 'The Firm', 'Thriller', 'TC', 200);

INSERT INTO MOVIE VALUES
(3, 'Pretty Woman', 'Romance', 'RG', 151);

INSERT INTO MOVIE VALUES
(4, 'Home Alone', 'Comedy', 'MC', 150);

INSERT INTO MOVIE VALUES
(5, 'The Fugitive', 'Thriller', 'MF', 200);

INSERT INTO MOVIE VALUES
(6, 'Coma', 'Suspense', 'MD', 100);

INSERT INTO MOVIE VALUES
(7, 'Dracula', 'Horror', 'GO', 150);

INSERT INTO MOVIE VALUES
(8, 'Quick Change', 'Comedy', 'BM', 100);

INSERT INTO MOVIE VALUES
(9, 'Gone with the Wind', 'Action', 'CB', 200);

INSERT INTO MOVIE VALUES
(10, 'Carry on Doctor', 'Comedy', 'LP', 100);


-- Insert records into INVOICE table

INSERT INTO INVOICE VALUES
('I01', 4, 'A01',
 TO_DATE('23-JUL-1993','DD-MON-YYYY'),
 TO_DATE('25-JUL-1993','DD-MON-YYYY'));

INSERT INTO INVOICE VALUES
('I02', 3, 'A02',
 TO_DATE('12-AUG-1993','DD-MON-YYYY'),
 TO_DATE('15-AUG-1993','DD-MON-YYYY'));

INSERT INTO INVOICE VALUES
('I03', 1, 'A02',
 TO_DATE('15-AUG-1993','DD-MON-YYYY'),
 TO_DATE('18-AUG-1993','DD-MON-YYYY'));

INSERT INTO INVOICE VALUES
('I04', 6, 'A03',
 TO_DATE('10-SEP-1993','DD-MON-YYYY'),
 TO_DATE('13-SEP-1993','DD-MON-YYYY'));

INSERT INTO INVOICE VALUES
('I05', 7, 'A04',
 TO_DATE('05-AUG-1993','DD-MON-YYYY'),
 TO_DATE('08-AUG-1993','DD-MON-YYYY'));

INSERT INTO INVOICE VALUES
('I06', 2, 'A06',
 TO_DATE('18-SEP-1993','DD-MON-YYYY'),
 TO_DATE('21-SEP-1993','DD-MON-YYYY'));

INSERT INTO INVOICE VALUES
('I07', 9, 'A05',
 TO_DATE('07-JUL-1993','DD-MON-YYYY'),
 TO_DATE('10-JUL-1993','DD-MON-YYYY'));

INSERT INTO INVOICE VALUES
('I08', 9, 'A01',
 TO_DATE('11-AUG-1993','DD-MON-YYYY'),
 TO_DATE('14-AUG-1993','DD-MON-YYYY'));

INSERT INTO INVOICE VALUES
('I09', 5, 'A03',
 TO_DATE('06-JUL-1993','DD-MON-YYYY'),
 TO_DATE('09-JUL-1993','DD-MON-YYYY'));

INSERT INTO INVOICE VALUES
('I10', 8, 'A06',
 TO_DATE('03-SEP-1993','DD-MON-YYYY'),
 TO_DATE('06-SEP-1993','DD-MON-YYYY'));

COMMIT;


-- Display all three tables

SELECT * FROM CUSTOMER;

SELECT * FROM MOVIE;

SELECT * FROM INVOICE;


-- ============================================================
-- Q2. Display customer names and movie numbers
--     of all customers who have been issued a movie.
-- ============================================================

SELECT C.FNAME,
       C.LNAME,
       I.MV_NO
FROM CUSTOMER C
INNER JOIN INVOICE I
ON C.CUST_ID = I.CUST_ID;


-- ============================================================
-- Q3. Display movie number and title issued to Ivan.
-- ============================================================

SELECT M.MV_NO,
       M.TITLE
FROM MOVIE M
INNER JOIN INVOICE I
ON M.MV_NO = I.MV_NO
INNER JOIN CUSTOMER C
ON I.CUST_ID = C.CUST_ID
WHERE C.FNAME = 'Ivan';


-- ============================================================
-- Q4. Display TITLE, CUST_ID and MV_NO
--     for all movies that are issued.
-- ============================================================

SELECT M.TITLE,
       I.CUST_ID,
       I.MV_NO
FROM MOVIE M
INNER JOIN INVOICE I
ON M.MV_NO = I.MV_NO;


-- ============================================================
-- Q5. Display title and type of movies issued to Vandana.
-- ============================================================

SELECT M.TITLE,
       M.TYPE
FROM MOVIE M
INNER JOIN INVOICE I
ON M.MV_NO = I.MV_NO
INNER JOIN CUSTOMER C
ON I.CUST_ID = C.CUST_ID
WHERE C.FNAME = 'Vandana';


-- ============================================================
-- Q6. Find names of customers who have been issued
--     movies of type ACTION.
-- ============================================================

SELECT DISTINCT C.FNAME,
       C.LNAME
FROM CUSTOMER C
INNER JOIN INVOICE I
ON C.CUST_ID = I.CUST_ID
INNER JOIN MOVIE M
ON I.MV_NO = M.MV_NO
WHERE UPPER(M.TYPE) = 'ACTION';


-- ============================================================
-- Q7. Display movie details in sentence format
--     for movies having MV_NO >= 3.
-- ============================================================

SELECT 'The movie taken by ' ||
       C.FNAME || ' ' ||
       C.LNAME || ' is ' ||
       M.TITLE || '.' AS MOVIE_DETAILS
FROM CUSTOMER C
INNER JOIN INVOICE I
ON C.CUST_ID = I.CUST_ID
INNER JOIN MOVIE M
ON I.MV_NO = M.MV_NO
WHERE M.MV_NO >= 3;


-- ============================================================
-- Q8. Display customer who has been issued
--     the movie having invoice number I10.
-- ============================================================

SELECT C.*
FROM CUSTOMER C
INNER JOIN INVOICE I
ON C.CUST_ID = I.CUST_ID
WHERE I.INV_NO = 'I10';


-- ============================================================
-- Q9. Display customer name, phone and area
--     who have been issued movies before August 1993.
-- ============================================================

SELECT DISTINCT C.FNAME,
       C.LNAME,
       C.PHONE,
       C.AREA
FROM CUSTOMER C
INNER JOIN INVOICE I
ON C.CUST_ID = I.CUST_ID
WHERE I.ISSUE_DATE < TO_DATE('01-AUG-1993','DD-MON-YYYY');


-- ============================================================
-- Q10. Display movie number and title issued to
--      Ivan, Vandana and Ravi.
-- ============================================================

SELECT DISTINCT M.MV_NO,
       M.TITLE
FROM MOVIE M
INNER JOIN INVOICE I
ON M.MV_NO = I.MV_NO
INNER JOIN CUSTOMER C
ON I.CUST_ID = C.CUST_ID
WHERE C.FNAME IN ('Ivan', 'Vandana', 'Ravi');


-- ============================================================
-- Q11. List movie number and movie name
--      issued to customers.
-- ============================================================

SELECT DISTINCT M.MV_NO,
       M.TITLE
FROM MOVIE M
INNER JOIN INVOICE I
ON M.MV_NO = I.MV_NO;


-- ============================================================
-- Q12. Find type and movie numbers of movies issued
--      to customers A01 and A02.
-- ============================================================

SELECT M.TYPE,
       M.MV_NO
FROM MOVIE M
INNER JOIN INVOICE I
ON M.MV_NO = I.MV_NO
WHERE I.CUST_ID IN ('A01', 'A02');


-- ============================================================
-- Q13. Check whether a movie whose star is TOM CRUISE
--      has been issued to any customer.
-- ============================================================

SELECT DISTINCT I.CUST_ID
FROM INVOICE I
INNER JOIN MOVIE M
ON I.MV_NO = M.MV_NO
WHERE UPPER(M.STAR) = 'TOM CRUISE';


-- ============================================================
-- Q14. Display first name and last name
--      of customers who have been issued a movie.
-- ============================================================

SELECT DISTINCT C.FNAME,
       C.LNAME
FROM CUSTOMER C
INNER JOIN INVOICE I
ON C.CUST_ID = I.CUST_ID;


-- ============================================================
-- Q15. Display movie number which has never
--      been issued to any customer.
-- ============================================================

SELECT M.MV_NO
FROM MOVIE M
WHERE NOT EXISTS (
    SELECT 1
    FROM INVOICE I
    WHERE I.MV_NO = M.MV_NO
);


-- ============================================================
-- GROUP B
-- Using the default Oracle EMP table
-- ============================================================


-- ============================================================
-- Q16. Display employee ID, employee name,
--      manager ID and manager name.
--      SELF JOIN operation.
-- ============================================================

SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_NAME,
       E.MANAGER_ID,
       M.FIRST_NAME || ' ' || M.LAST_NAME AS MANAGER_NAME
FROM EMP E
LEFT JOIN EMP M
ON E.MANAGER_ID = M.EMPLOYEE_ID
ORDER BY E.EMPLOYEE_ID;


-- ============================================================
-- Q17. Display employee name, manager ID,
--      manager name and manager's manager name.
--      SELF JOIN operation using three table aliases.
-- ============================================================

SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_NAME,
       E.MANAGER_ID AS MANAGER_ID,
       M.FIRST_NAME || ' ' || M.LAST_NAME AS MANAGER_NAME,
       MM.FIRST_NAME || ' ' || MM.LAST_NAME
       AS MANAGERS_MANAGER_NAME
FROM EMP E
LEFT JOIN EMP M
ON E.MANAGER_ID = M.EMPLOYEE_ID
LEFT JOIN EMP MM
ON M.MANAGER_ID = MM.EMPLOYEE_ID
ORDER BY E.EMPLOYEE_ID;