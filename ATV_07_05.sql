-- Questão 1: Criar usuários independentes com autenticação por senha diretamente no banco de dados
CREATE USER User_A WITH PASSWORD = 'SenhaForte@123';
CREATE USER User_B WITH PASSWORD = 'SenhaForte@123';
CREATE USER User_C WITH PASSWORD = 'SenhaForte@123';
CREATE USER User_D WITH PASSWORD = 'SenhaForte@123';
CREATE USER User_E WITH PASSWORD = 'SenhaForte@123';

-- consulta de tabelas
SELECT name FROM sys.tables;

-- Questão 2: permitir ao usuário A selecionar ou modificar qualquer relação, exceto CLASSROOM
GRANT SELECT, INSERT, UPDATE, DELETE ON prereq TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON grade_points TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON pessoa TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON endereco TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON company TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON employee TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON manages TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON works TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON department TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON course TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON instructor TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON section TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON teaches TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON student TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON takes TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON advisor TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON time_slot TO User_A WITH GRANT OPTION;

-- Questão 3: listagem das permissões do usuário A
SELECT 
    princ.name AS usuario, 
    perm.permission_name AS permissao, 
    perm.state_desc AS estado, 
    perm.class_desc AS tipo_objeto, 
    obj.name AS objeto 
FROM 
    sys.database_permissions AS perm
JOIN 
    sys.database_principals AS princ ON perm.grantee_principal_id = princ.principal_id
LEFT JOIN 
    sys.objects AS obj ON perm.major_id = obj.object_id
WHERE 
    princ.name = 'User_A';
