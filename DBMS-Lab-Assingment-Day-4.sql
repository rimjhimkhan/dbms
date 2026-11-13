
-- Q1. Create CUSTOMER and MOVIE tables with constraints

CREATE TABLE CUSTOMER (
    CUST_ID VARCHAR2(3),
    FNAME VARCHAR2(20) NOT NULL,
    LNAME VARCHAR2(20),
    AREA VARCHAR2(2) NOT NULL,
    PHONE NUMBER(10),
    CONSTRAINT PK_CUSTOMER PRIMARY KEY (CUST_ID)
);


CREATE TABLE MOVIE (
    MV_NO NUMBER(2),
    CUST_ID VARCHAR2(3),
    TITLE VARCHAR2(30) NOT NULL,
    STAR VARCHAR2(10) NOT NULL,
    PRICE NUMBER(6,2),
    CONSTRAINT PK_MOVIE PRIMARY KEY (MV_NO),
    CONSTRAINT FK_MOVIE_CUSTOMER FOREIGN KEY (CUST_ID)
        REFERENCES CUSTOMER(CUST_ID),
    CONSTRAINT CHK_MOVIE_PRICE CHECK (PRICE BETWEEN 100 AND 250)
);


-- Insert records into CUSTOMER table

INSERT INTO CUSTOMER VALUES ('A01', 'Ivan', 'Ross', 'SA', 6125467);
INSERT INTO CUSTOMER VALUES ('A02', 'Vandana', 'Ray', 'MU', 5560379);
INSERT INTO CUSTOMER VALUES ('A03', 'Pramada', 'Jauguste', 'DA', 4560389);
INSERT INTO CUSTOMER VALUES ('A04', 'Basu', 'Navindi', 'BA', 6125401);
INSERT INTO CUSTOMER VALUES ('A05', 'Ravi', 'Shridhar', 'NA', NULL);
INSERT INTO CUSTOMER VALUES ('A06', 'Rukmini', 'Aiyer', 'GH', 5125274);


-- Insert records into MOVIE table

INSERT INTO MOVIE VALUES (1, 'A02', 'Bloody', 'JC', 181);
INSERT INTO MOVIE VALUES (2, 'A04', 'The Firm', 'TC', 200);
INSERT INTO MOVIE VALUES (3, 'A01', 'Pretty Woman', 'RG', 151);
INSERT INTO MOVIE VALUES (4, 'A06', 'Home Alone', 'MC', 150);
INSERT INTO MOVIE VALUES (5, 'A05', 'The Fugitive', 'MF', 200);
INSERT INTO MOVIE VALUES (6, 'A03', 'Coma', 'MD', 100);
INSERT INTO MOVIE VALUES (7, 'A02', 'Dracula', 'GO', 150);
INSERT INTO MOVIE VALUES (8, 'A06', 'Quick Change', 'BM', 100);
INSERT INTO MOVIE VALUES (9, 'A03', 'Gone with the Wind', 'CB', 200);
INSERT INTO MOVIE VALUES (10, 'A05', 'Carry on Doctor', 'LP', 100);

COMMIT;


-- Display both tables

SELECT * FROM CUSTOMER;

SELECT * FROM MOVIE;


-- Q2. Prove that ENTITY INTEGRITY constraint is ensured
--     by both tables.
--     Condition 1: Primary key cannot contain NULL.
--     Condition 2: Primary key values must be unique.


-- Check for NULL primary keys

SELECT *
FROM CUSTOMER
WHERE CUST_ID IS NULL;

SELECT *
FROM MOVIE
WHERE MV_NO IS NULL;


-- Check for duplicate primary key values

SELECT CUST_ID, COUNT(*)
FROM CUSTOMER
GROUP BY CUST_ID
HAVING COUNT(*) > 1;

SELECT MV_NO, COUNT(*)
FROM MOVIE
GROUP BY MV_NO
HAVING COUNT(*) > 1;

-- Both tables have primary key constraints.
-- The above queries should return no rows.


-- Q3. Prove that REFERENTIAL INTEGRITY constraint
--     is ensured by both tables.

-- Display customer IDs present in MOVIE table
-- but missing from CUSTOMER table.

SELECT DISTINCT M.CUST_ID
FROM MOVIE M
WHERE NOT EXISTS (
    SELECT 1
    FROM CUSTOMER C
    WHERE C.CUST_ID = M.CUST_ID
);

-- This query should return no rows because
-- MOVIE.CUST_ID references CUSTOMER.CUST_ID.


-- Q4. Prove that DOMAIN INTEGRITY constraint
--     is ensured by MOVIE table.

-- Display movies having valid prices.

SELECT *
FROM MOVIE
WHERE PRICE BETWEEN 100 AND 250;

-- The CHECK constraint prevents prices
-- below 100 or above 250.


-- Q5. Display movie titles whose price is
--     greater than 100 but less than 200.

SELECT TITLE
FROM MOVIE
WHERE PRICE > 100 AND PRICE < 200;


-- Q6. Display CUST_ID who have seen movies
--     having stars JC, TC or MC.

SELECT DISTINCT CUST_ID
FROM MOVIE
WHERE STAR IN ('JC', 'TC', 'MC');


-- Q7. Display customer details whose AREA
--     contains the letter A.

SELECT *
FROM CUSTOMER
WHERE AREA LIKE '%A%';


-- Q8. Display movie titles whose price is within 180
--     and title contains exactly 6 characters.

SELECT TITLE
FROM MOVIE
WHERE PRICE <= 180
AND LENGTH(TITLE) = 6;


-- Q9. Display movie name, original price and price
--     after 10% increment.

SELECT TITLE,
       PRICE AS "Original Price",
       PRICE * 1.10 AS "Increased Price"
FROM MOVIE;


-- Q10. Display customer details in sentence format.

SELECT FNAME || ' ' || LNAME ||
       ' stays in ' || AREA ||
       ' and his phone number is ' ||
       PHONE || '.' AS CUSTOMER_DETAILS
FROM CUSTOMER;


-- Q11. Add NOT NULL constraint to LNAME field
--      in CUSTOMER table.

ALTER TABLE CUSTOMER
MODIFY (LNAME NOT NULL);


-- Q12. Display customer name whose phone number
--      is not recorded.

SELECT FNAME, LNAME
FROM CUSTOMER
WHERE PHONE IS NULL;


-- Q13. Add a phone number of your choice
--      for a customer whose AREA contains A.
--      Here we update customer A05.

UPDATE CUSTOMER
SET PHONE = 9876543210
WHERE CUST_ID = 'A05';

COMMIT;

-- Display updated customer details

SELECT *
FROM CUSTOMER
WHERE CUST_ID = 'A05';


-- Q14. Display unique customer IDs from MOVIE table.

SELECT DISTINCT CUST_ID
FROM MOVIE;


-- Q15. Remove NOT NULL constraint from STAR column
--      in MOVIE table.

ALTER TABLE MOVIE
MODIFY (STAR NULL);


-- Q16. Delete any row from CUSTOMER table.
--      A01 is referenced in MOVIE, so deletion
--      should fail due to referential integrity.

DELETE FROM CUSTOMER
WHERE CUST_ID = 'A01';

-- Expected error:
-- ORA-02292: integrity constraint violated -
-- child record found.


-- Q17. Delete any row from MOVIE table.
--      Movie number 10 is selected.

DELETE FROM MOVIE
WHERE MV_NO = 10;

COMMIT;


-- Q20. Drop the foreign key from MOVIE table.
--      This is placed before dropping MOVIE because
--      the foreign key belongs to that table.

ALTER TABLE MOVIE
DROP CONSTRAINT FK_MOVIE_CUSTOMER;


-- Q18. Drop CUSTOMER table.
--      This should now succeed because its foreign
--      key reference has been removed in Q20.

DROP TABLE CUSTOMER;


-- Q19. Drop MOVIE table.

DROP TABLE MOVIE;