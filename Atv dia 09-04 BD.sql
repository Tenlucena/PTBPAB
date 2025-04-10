-- Questão 1: sem subconsulta escalar
SELECT I.ID, I.NAME, COALESCE(COUNT(t.sec_id), 0) AS Number_of_sections
FROM instructor I
LEFT JOIN teaches t ON I.ID = t.ID
GROUP BY I.ID, I.name;

-- Questão 2: Mesmo resultado da questão anterior, mas utilizando subconsulta escalar
SELECT I.ID, I.NAME,
    (SELECT COALESCE(COUNT(t.sec_id), 0) FROM teaches t WHERE I.ID = t.ID ) AS Number_of_sections
FROM instructor I
GROUP BY I.ID, I.name;

-- Questão 3:seções ministradas pelos instrutores na primavera de 2010
SELECT t.course_id, COALESCE(COUNT(t.sec_id), 0) AS sec_id, I.ID, t.semester, t.[year], COALESCE(I.NAME, '-')
FROM instructor I
LEFT JOIN teaches t ON I.ID = t.ID
WHERE t.[year] = 2010 AND (t.semester = 'Spring')
GROUP BY I.ID, I.name, t.course_id, t.semester, t.[year]
ORDER BY t.course_id;

-- Questão 4: Pontos totais recebidos por aluno.
SELECT 
    s.ID,
    s.name,
    c.title,
    s.dept_name,
    t.grade,
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
    END AS points,
    c.credits,
    SUM(
        c.credits * 
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
        END
    ) AS total_pontos
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
GROUP BY 
    s.ID,
    s.name,
    c.title,
    s.dept_name,
    t.grade,
    c.credits
ORDER BY total_pontos DESC;

-- Questão 5:Criação da VIEW 
CREATE VIEW coeficiente_rendimento AS
SELECT 
    s.ID,
    s.name,
    c.title,
    s.dept_name,
    t.grade,
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
    END AS points,
    c.credits,
    SUM(
        c.credits * 
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
        END
    ) AS total_pontos
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
GROUP BY 
    s.ID,
    s.name,
    c.title,
    s.dept_name,
    t.grade,
    c.credits;

SELECT * FROM coeficiente_rendimento;