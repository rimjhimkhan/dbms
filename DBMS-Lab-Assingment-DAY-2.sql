CREATE TABLE EMP1 (
    ID            NUMBER(2),
    Name          VARCHAR2(10),
    Basic         NUMBER(6,2),
    Designation   VARCHAR2(10),
    Age           NUMBER(2)
);

DESC EMP1;

ALTER TABLE EMP1
MODIFY Basic NUMBER(6);

DESC EMP1;

ALTER TABLE EMP1
MODIFY Name VARCHAR2(15);

DESC EMP1;

CREATE TABLE EMP_trainee AS
SELECT
    ID AS Emp_id,
    Name,
    Basic,
    Designation,
    Age
FROM EMP1
WHERE 1 = 0;

DESC EMP_trainee;

INSERT INTO EMP1 VALUES (1, 'Rohit', 6700, 'Manager', 24);

INSERT INTO EMP1 VALUES (2, 'Sunil', 6200, 'Engineer', 27);

INSERT INTO EMP1 VALUES (3, 'Payal', 6300, 'Engineer', 25);

INSERT INTO EMP1 VALUES (4, 'Kunal', 6700, 'Trainee', 28);

INSERT INTO EMP1 VALUES (5, 'Sunita', 6230, 'Trainee', 26);

INSERT INTO EMP1 VALUES (6, 'Bimal', 7000, 'Trainee', 25);

COMMIT;

SELECT * FROM EMP1;


INSERT INTO EMP_trainee
(Emp_id, Name, Basic, Designation, Age)
SELECT ID, Name, Basic, Designation, Age
FROM EMP1
WHERE Designation = 'Trainee';

COMMIT;

SELECT * FROM EMP_trainee;

ALTER TABLE EMP1
ADD (
    Skills VARCHAR2(10),
    DOJ DATE
);

UPDATE EMP1
SET Skills = 'Java',
    DOJ = TO_DATE('10-JAN-24', 'DD-MON-RR')
WHERE ID = 1;

UPDATE EMP1
SET Skills = 'Python',
    DOJ = TO_DATE('15-FEB-24', 'DD-MON-RR')
WHERE ID = 2;

UPDATE EMP1
SET Skills = 'SQL',
    DOJ = TO_DATE('20-MAR-24', 'DD-MON-RR')
WHERE ID = 3;

UPDATE EMP1
SET Skills = 'Java',
    DOJ = TO_DATE('05-APR-24', 'DD-MON-RR')
WHERE ID = 4;

UPDATE EMP1
SET Skills = 'HTML',
    DOJ = TO_DATE('12-MAY-24', 'DD-MON-RR')
WHERE ID = 5;

UPDATE EMP1
SET Skills = 'Python',
    DOJ = TO_DATE('18-JUN-24', 'DD-MON-RR')
WHERE ID = 6;

COMMIT;

SELECT * FROM EMP1;


UPDATE EMP1
SET Skills = 'SQL'
WHERE Designation = 'Trainee';

COMMIT;


SELECT ID, Name, Designation, Skills
FROM EMP1
WHERE Designation = 'Trainee';


ALTER TABLE EMP1
RENAME COLUMN Age TO Age_in_Years;

DESC EMP1;

ALTER TABLE EMP_trainee
DROP COLUMN Age;

DESC EMP_trainee;


SELECT TABLE_NAME
FROM USER_TABLES
WHERE TABLE_NAME = 'EMP';


CREATE TABLE EMP_Mgr_Engr AS
SELECT *
FROM EMP1;

DESC EMP_Mgr_Engr;


TRUNCATE TABLE EMP_Mgr_Engr;

SELECT * FROM EMP_Mgr_Engr;