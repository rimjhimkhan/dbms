
-- Q1. Create EMP table with the given structure
--     EMP_ID is Primary Key.
--     Required fields are NOT NULL.
--     DEPT_ID should be greater than or equal to 10.

CREATE TABLE EMP (
    EMP_ID NUMBER(6),
    FIRST_NAME VARCHAR2(25)
        CONSTRAINT NN_EMP_FNAME NOT NULL,
    LAST_NAME VARCHAR2(25)
        CONSTRAINT NN_EMP_LNAME NOT NULL,
    HIRE_DATE DATE
        CONSTRAINT NN_EMP_HIREDATE NOT NULL,
    JOB_ID VARCHAR2(10)
        CONSTRAINT NN_EMP_JOB NOT NULL,
    SAL NUMBER(8,2)
        CONSTRAINT NN_EMP_SAL NOT NULL,
    DEPT_ID NUMBER(4),

    CONSTRAINT PK_EMP PRIMARY KEY (EMP_ID),
    CONSTRAINT CK_EMP_DEPT CHECK (DEPT_ID >= 10)
);


-- Insert records into EMP table

INSERT INTO EMP VALUES
(198, 'Donald', 'Connell', TO_DATE('21-JUN-1999','DD-MON-YYYY'), 'SH_CLERK', 2600, 50);

INSERT INTO EMP VALUES
(199, 'Douglas', 'Grant', TO_DATE('13-JAN-1998','DD-MON-YYYY'), 'SH_CLERK', 3000, 50);

INSERT INTO EMP VALUES
(200, 'Jennifer', 'Whalen', TO_DATE('17-SEP-1987','DD-MON-YYYY'), 'AD_ASST', 4400, 10);

INSERT INTO EMP VALUES
(201, 'Michael', 'Hartstein', TO_DATE('19-JAN-1999','DD-MON-YYYY'), 'IT_PROG', 6000, 20);

INSERT INTO EMP VALUES
(202, 'Pat', 'Fay', TO_DATE('25-OCT-1989','DD-MON-YYYY'), 'AC_MGR', 6500, 20);

INSERT INTO EMP VALUES
(203, 'Susan', 'Mavris', TO_DATE('26-NOV-1976','DD-MON-YYYY'), 'AD_VP', 7500, 40);

INSERT INTO EMP VALUES
(204, 'Hermann', 'Baer', TO_DATE('23-AUG-1995','DD-MON-YYYY'), 'AD_PRES', 9500, 90);

INSERT INTO EMP VALUES
(205, 'Shelley', 'Higgins', TO_DATE('24-FEB-1998','DD-MON-YYYY'), 'AC_MGR', 2300, 60);

INSERT INTO EMP VALUES
(206, 'William', 'Gitz', TO_DATE('12-MAR-2001','DD-MON-YYYY'), 'IT_PROG', 5000, 60);

INSERT INTO EMP VALUES
(100, 'Steven', 'King', TO_DATE('15-JUN-2002','DD-MON-YYYY'), 'AD_ASST', 8956, 100);

INSERT INTO EMP VALUES
(101, 'Neena', 'Kochar', TO_DATE('10-JUL-2003','DD-MON-YYYY'), 'SH_CLERK', 3400, 30);

COMMIT;


-- Display EMP table

SELECT * FROM EMP;


-- Q2. Display FIRST_NAME in ascending order
--     with alias name EMPLOYEE_NAME.

SELECT FIRST_NAME AS EMPLOYEE_NAME
FROM EMP
ORDER BY FIRST_NAME ASC;


-- Q3. Display FIRST_NAME in descending order
--     with alias name EMPLOYEE_NAME.

SELECT FIRST_NAME AS EMPLOYEE_NAME
FROM EMP
ORDER BY FIRST_NAME DESC;


-- Q4. Display HIRE_DATE in ascending order.

SELECT HIRE_DATE
FROM EMP
ORDER BY HIRE_DATE ASC;


-- Q5. Display employee details whose FIRST_NAME
--     starts with J or M.
--     Sort the result by LAST_NAME.

SELECT *
FROM EMP
WHERE FIRST_NAME LIKE 'J%'
   OR FIRST_NAME LIKE 'M%'
ORDER BY LAST_NAME ASC;


-- Q6. Find maximum, minimum, average and sum of salary.

SELECT MAX(SAL) AS "Max",
       MIN(SAL) AS "Min",
       ROUND(AVG(SAL), 2) AS "Avg",
       SUM(SAL) AS "Sum"
FROM EMP;


-- Q7. Find maximum, minimum, average and sum of salary
--     for each individual JOB_ID.

SELECT JOB_ID,
       MAX(SAL) AS "Max",
       MIN(SAL) AS "Min",
       ROUND(AVG(SAL), 2) AS "Avg",
       SUM(SAL) AS "Sum"
FROM EMP
GROUP BY JOB_ID;


-- Q8. Display the number of employees under each JOB_ID.

SELECT JOB_ID,
       COUNT(*) AS NUMBER_OF_EMPLOYEES
FROM EMP
GROUP BY JOB_ID;


-- Q9. Display the number of managers in the company.
--     Here, employees having MGR in their JOB_ID
--     are counted as managers.

SELECT COUNT(*) AS NUMBER_OF_MANAGERS
FROM EMP
WHERE JOB_ID LIKE '%MGR%';


-- Q10. Find the difference between highest
--      and lowest salaries.

SELECT MAX(SAL) - MIN(SAL) AS SALARY_DIFFERENCE
FROM EMP;


-- Q11. Display maximum and average salary of engineers.
--      IT_PROG represents programmers/technical employees.

SELECT MAX(SAL) AS MAX_SALARY,
       ROUND(AVG(SAL), 2) AS AVG_SALARY
FROM EMP
WHERE JOB_ID LIKE '%PROG%';


-- Q12. Display the FIRST_NAME that comes first
--      and last in alphabetical order.

SELECT MIN(FIRST_NAME) AS FIRST_EMPLOYEE_NAME,
       MAX(FIRST_NAME) AS LAST_EMPLOYEE_NAME
FROM EMP;


-- Q13. Display first and last HIRE_DATE.

SELECT MIN(HIRE_DATE) AS "First Hire_Date",
       MAX(HIRE_DATE) AS "Last Hire_Date"
FROM EMP;


-- Q14. Display maximum and average salary of clerks.

SELECT MAX(SAL) AS MAX_SALARY,
       ROUND(AVG(SAL), 2) AS AVG_SALARY
FROM EMP
WHERE JOB_ID LIKE '%CLERK%';


-- Q15. Display department number and lowest salary
--      of each department.

SELECT DEPT_ID,
       MIN(SAL) AS MINIMUM_SALARY
FROM EMP
GROUP BY DEPT_ID;


-- Q16. Display department number and lowest salary
--      excluding departments where minimum salary
--      is 3000 or less.
--      Sort in descending order of salary.

SELECT DEPT_ID,
       MIN(SAL) AS MINIMUM_SALARY
FROM EMP
GROUP BY DEPT_ID
HAVING MIN(SAL) > 3000
ORDER BY MIN(SAL) DESC;


-- Q17. Display employee details in sentence format.

SELECT FIRST_NAME || ' whose designation is ' ||
       JOB_ID || ' gets ' || SAL ||
       ' but wants to earn ' || (3 * SAL) AS EMPLOYEE_DETAILS
FROM EMP;


-- Q18. Display employee details in comma-separated format.

SELECT EMP_ID || ', ' ||
       FIRST_NAME || ', ' ||
       LAST_NAME || ', ' ||
       TO_CHAR(HIRE_DATE, 'DD-MON-YY') || ', ' ||
       JOB_ID || ', ' ||
       SAL || ', ' ||
       DEPT_ID AS EMPLOYEE_DETAILS
FROM EMP;


-- Q19. Display today's date with alias TODAY.

SELECT SYSDATE AS TODAY
FROM DUAL;


-- Q20. Display EMP_ID, day and year of hiring.

SELECT EMP_ID,
       TO_CHAR(HIRE_DATE, 'DD') AS HIRE_DAY,
       TO_CHAR(HIRE_DATE, 'YYYY') AS HIRE_YEAR
FROM EMP;


-- Q21. Display employee name and HIRE_DATE
--      in DD-MONTH-YY format.

SELECT FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME,
       TO_CHAR(HIRE_DATE, 'DD-MONTH-YY') AS HIRE_DATE
FROM EMP;


-- Q22. Display EMPLOYEE_ID and month of hiring.

SELECT EMP_ID,
       TO_CHAR(HIRE_DATE, 'MONTH') AS HIRE_MONTH
FROM EMP;


-- Q23. Display employee name, EMP_ID and HIRE_DATE
--      in DD-MON-YYYY format.

SELECT FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME,
       EMP_ID,
       TO_CHAR(HIRE_DATE, 'DD-MON-YYYY') AS HIRE_DATE
FROM EMP;


-- Q24. Display employee name, EMP_ID and HIRE_DATE
--      in MONTH-DD-YYYY format.

SELECT FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME,
       EMP_ID,
       TO_CHAR(HIRE_DATE, 'MONTH-DD-YYYY') AS HIRE_DATE
FROM EMP;


-- Q25. Display the current system year in full spelling.

SELECT TO_CHAR(SYSDATE, 'YEAR') AS SYSTEM_YEAR
FROM DUAL;


-- Q26. Display today's date, 15 days after
--      and 15 days before today's date.

SELECT SYSDATE AS TODAY,
       SYSDATE + 15 AS AFTER_15_DAYS,
       SYSDATE - 15 AS BEFORE_15_DAYS
FROM DUAL;


-- Q27. Ensure DOMAIN INTEGRITY and ENTITY INTEGRITY.

-- DOMAIN INTEGRITY:
-- DEPT_ID must be greater than or equal to 10.

SELECT *
FROM EMP
WHERE DEPT_ID < 10;

-- The query should return no rows.

-- ENTITY INTEGRITY:
-- EMP_ID must be unique and cannot be NULL.

SELECT EMP_ID, COUNT(*)
FROM EMP
GROUP BY EMP_ID
HAVING COUNT(*) > 1;

SELECT *
FROM EMP
WHERE EMP_ID IS NULL;

-- Both queries should return no rows.
-- Primary key constraint ensures entity integrity.
-- CHECK constraint ensures domain integrity.


-- Q28. Drop DOMAIN constraint from EMP table.

ALTER TABLE EMP
DROP CONSTRAINT CK_EMP_DEPT;


-- Q29. Drop PRIMARY KEY constraint from EMP table.

ALTER TABLE EMP
DROP CONSTRAINT PK_EMP;


-- Q30. Drop EMP table.

DROP TABLE EMP;