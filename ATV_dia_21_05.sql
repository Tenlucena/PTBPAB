CREATE PROCEDURE dbo.salaryHistogram
    @numIntervalos INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @minSalario DECIMAL(18,2),
            @maxSalario DECIMAL(18,2),
            @intervalo DECIMAL(18,2),
            @i INT = 0;

    -- Obter salário mínimo e máximo
    SELECT 
        @minSalario = MIN(Salario),
        @maxSalario = MAX(Salario)
    FROM Professores;

    -- Calcular o tamanho de cada intervalo
    SET @intervalo = (@maxSalario - @minSalario) / @numIntervalos;

    -- Criar tabela temporária para armazenar os resultados
    CREATE TABLE #Histograma (
        Intervalo VARCHAR(50),
        Frequencia INT
    );

    WHILE @i < @numIntervalos
    BEGIN
        DECLARE @inicio DECIMAL(18,2) = @minSalario + (@intervalo * @i);
        DECLARE @fim DECIMAL(18,2) = @minSalario + (@intervalo * (@i + 1));
        
        INSERT INTO #Histograma (Intervalo, Frequencia)
        SELECT 
            CONCAT(FORMAT(@inicio, 'N2'), ' - ', FORMAT(@fim, 'N2')),
            COUNT(*)
        FROM Professores
        WHERE Salario >= @inicio AND 
              (Salario < @fim OR (@i = @numIntervalos - 1 AND Salario <= @fim)); -- Incluir limite superior no último intervalo

        SET @i = @i + 1;
    END

    -- Exibir o histograma
    SELECT * FROM #Histograma;

    -- Limpar tabela temporária
    DROP TABLE #Histograma;
END;