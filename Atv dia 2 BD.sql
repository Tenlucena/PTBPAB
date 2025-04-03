--Questão 1
SELECT * FROM student FULL OUTER JOIN takes ON student.ID = takes.ID;
--Aqui ele junta as duas tabelas e utiliza o id para relacionar as duas tabelas.

--Questão 2
SELECT s.ID, s.name, count(t.course_id) as Quantidade_de_cursos From student s join takes t on s.ID = t.ID WHERE s.dept_name = 'Civil Eng.'group by s.ID, s.name order by Quantidade_de_cursos DESC;
-- utilizei o s e t para me referir as duas tabelaso count vai contar quantos cursos cada aluno fez, o join relaciona as duas tabelas e o group by agrupa os resultados por id e nome o order by ordena os resultados de forma descendente se tirar o desc ele fazer d forma crescente 

--Questão 3
CREATE VIEW civil_eng_students AS 
	SELECT s.ID, s.name, count(t.course_id) as Quantidade_de_cursos From student s join takes t on s.ID = t.ID WHERE s.dept_name = 'Civil Eng.'group by s.ID, s.name;

SELECT * FROM civil_eng_students ORDER BY Quantidade_de_cursos DESC;
--o order by não pode ser utilizado dentro o create view apenas quando for consultar algum dado
