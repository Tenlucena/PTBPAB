CREATE TRIGGER dbo.trigger_prevent_assignment_teaches
ON teaches
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verifica para cada inserção na tabela teaches
    IF EXISTS (
        SELECT i.ID, i.year
        FROM inserted i
        JOIN teaches t ON t.ID = i.ID AND t.year = i.year
        GROUP BY i.ID, i.year
        HAVING COUNT(*) + 
               (SELECT COUNT(*) FROM inserted i2 WHERE i2.ID = i.ID AND i2.year = i.year) > 2
    )
    BEGIN
        RAISERROR('Este instrutor já possui 2 ou mais atribuições neste ano.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Se passou, insere normalmente
    INSERT INTO teaches (ID, course_id, sec_id, semester, year)
    SELECT ID, course_id, sec_id, semester, year
    FROM inserted;
END;
