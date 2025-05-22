CREATE PROCEDURE dbo.salaryHistogram
    @num_intervals INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @min_salary DECIMAL(10,2),
            @max_salary DECIMAL(10,2),
            @interval_size DECIMAL(10,2);

    -- Obter salário mínimo e máximo
    SELECT 
        @min_salary = MIN(salary),
        @max_salary = MAX(salary)
    FROM instructor;

    -- Calcular o tamanho de cada intervalo
    SET @interval_size = (@max_salary - @min_salary) / @num_intervals;

    -- Criar tabela temporária para armazenar os resultados
    IF OBJECT_ID('tempdb..#histogram') IS NOT NULL
        DROP TABLE #histogram;

    CREATE TABLE #histogram (
        IntervaloMin DECIMAL(10,2),
        IntervaloMax DECIMAL(10,2),
        Total INT
    );

    -- Preencher a tabela com os intervalos e contagem de professores
    DECLARE @i INT = 0;
    WHILE @i < @num_intervals
    BEGIN
        DECLARE @start DECIMAL(10,2) = @min_salary + @interval_size * @i;
        DECLARE @end DECIMAL(10,2) = @start + @interval_size;

        -- Último intervalo deve incluir o valor máximo
        IF @i = @num_intervals - 1
            SET @end = @max_salary + 0.01;

        INSERT INTO #histogram (IntervaloMin, IntervaloMax, Total)
        SELECT @start, @end - 0.01, COUNT(*)
        FROM instructor
        WHERE salary >= @start AND salary < @end;

        SET @i = @i + 1;
    END;

    -- Exibir os resultados
    SELECT 
        FORMAT(IntervaloMin, 'N2') AS valorMinimo,
        FORMAT(IntervaloMax, 'N2') AS valorMaximo,
        Total
    FROM #histogram;
END;
