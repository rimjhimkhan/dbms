/* Task 1 */

CREATE TABLE Student (
    Roll      NUMBER(5),
    Name      VARCHAR2(30),
    Age       NUMBER(5),
    Course    VARCHAR2(5),
    Math      NUMBER(6,2),
    Physics   NUMBER(6,2),
    Computer  NUMBER(6,2),
    Birthday  DATE
);

DESC Student;

SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH, DATA_PRECISION, DATA_SCALE
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'STUDENT'
ORDER BY COLUMN_ID;


CREATE TABLE MSc AS
SELECT *
FROM Student
WHERE 1 = 0;

SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH, DATA_PRECISION, DATA_SCALE
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MSC'
ORDER BY COLUMN_ID;


CREATE TABLE MCA AS
SELECT
    Roll,
    Name AS First_Name,
    Age,
    Course AS Department,
    Math,
    Physics,
    Computer,
    Birthday
FROM Student
WHERE 1 = 0;

DESC MCA;

SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH, DATA_PRECISION, DATA_SCALE
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MCA'
ORDER BY COLUMN_ID;


INSERT INTO Student VALUES
(1, 'Rahul', 19, 'BCA', 79.5, 67, 89,
 TO_DATE('15-JUN-93', 'DD-MON-RR'));

INSERT INTO Student VALUES
(2, 'Kunal', 21, 'BCA', 68, 76, 59.5,
 TO_DATE('16-AUG-91', 'DD-MON-RR'));

INSERT INTO Student VALUES
(3, 'Aditi', 20, 'MSc', 90, 73, 56,
 TO_DATE('20-SEP-92', 'DD-MON-RR'));

INSERT INTO Student VALUES
(4, 'Sumit', 20, 'MCA', 57.5, 78, 81,
 TO_DATE('07-DEC-91', 'DD-MON-RR'));

INSERT INTO Student VALUES
(5, 'Anirban', 22, 'MCA', 80, 68, 63,
 TO_DATE('15-SEP-94', 'DD-MON-RR'));

INSERT INTO Student VALUES
(6, 'Kumkum', 21, 'BCA', 72, 54.5, 60,
 TO_DATE('08-FEB-95', 'DD-MON-RR'));

INSERT INTO Student VALUES
(7, 'Suman', 21, 'BCA', 91.5, 32, 61,
 TO_DATE('10-MAR-94', 'DD-MON-RR'));

INSERT INTO Student VALUES
(8, 'Rohit', 22, 'MSc', 85, 76, 92,
 TO_DATE('19-APR-92', 'DD-MON-RR'));

COMMIT;


SELECT * FROM Student;

SELECT * FROM Student
WHERE Roll = 5;

SELECT Roll, Name, Math, Physics, Computer
FROM Student;

SELECT * FROM Student
WHERE Course = 'BCA';


INSERT INTO MCA
(Roll, First_Name, Age, Department, Math, Physics, Computer, Birthday)
SELECT Roll, Name, Age, Course, Math, Physics, Computer, Birthday
FROM Student
WHERE Course = 'MCA';

COMMIT;

SELECT * FROM MCA;


INSERT INTO MSc
SELECT *
FROM Student
WHERE Course = 'MSc';

COMMIT;

SELECT * FROM MSc;


DESC Student;

DESC MCA;

SELECT Course, Roll, Name, Age, Math, Physics, Computer, Birthday
FROM Student;


UPDATE Student
SET Math = 95
WHERE Roll = 7;

COMMIT;

SELECT Roll, Name, Math
FROM Student
WHERE Roll = 7;


UPDATE MCA
SET First_Name = 'Sumitava'
WHERE Roll = 4;

COMMIT;

SELECT *
FROM MCA
WHERE Roll = 4;


DELETE FROM Student
WHERE Roll = 2;

COMMIT;

SELECT * FROM Student;


DELETE FROM Student;

COMMIT;

SELECT * FROM Student;