--1 Criando o procedimento
CREATE PROCEDURE dbo.student_grade_points 
    @grade VARCHAR(4)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.name AS student_name,
        s.dept_name AS student_dept,
        c.title AS course_title,
        c.dept_name AS course_dept,
        t.semester,
        t.year,
        t.grade AS grade_letter,
        CASE t.grade
            WHEN 'A+' THEN 4.0
            WHEN 'A'  THEN 3.7
            WHEN 'A-' THEN 3.4
            WHEN 'B+' THEN 3.1
            WHEN 'B'  THEN 2.7
            WHEN 'B-' THEN 2.3
            WHEN 'C+' THEN 2.0
            WHEN 'C'  THEN 1.7
            WHEN 'C-' THEN 1.3
            WHEN 'D'  THEN 1.0
            WHEN 'F'  THEN 0.0
            ELSE 0.0
        END AS grade_points
    FROM student s
    JOIN takes t ON s.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
    WHERE t.grade = @grade;
END;

EXEC dbo.student_grade_points 'A';

--2 Criando uma função
CREATE FUNCTION dbo.return_instructor_location
(
    @name_instructor VARCHAR(30)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        i.name AS instructor_name,
        c.title AS course_title,
        t.semester,
        t.year,
        s.building,
        s.room_number
    FROM instructor i
    JOIN teaches t ON i.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
    JOIN section s ON c.course_id = s.course_id 
                  AND t.semester = s.semester 
                  AND t.year = s.year 
                  AND t.sec_id = s.sec_id
    WHERE i.name = @name_instructor
);

SELECT * FROM dbo.return_instructor_location('Gustafsson');
