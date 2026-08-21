INSERT INTO MCA (Roll, First_Name, Age, Department, Math, Physics, Computer, Birthday)
SELECT Roll, Name, Age, Course, Math, Physics, Computer, Birthday
FROM Student
WHERE Course = 'MCA';
