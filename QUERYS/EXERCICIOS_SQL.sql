/* ======================================================
   ********************************************************
   *                EXERCÍCIOS - NÍVEL FÁCIL (10)
   ********************************************************
   ====================================================== */

/* 1. Mostrar todas as colunas e 20 primeiras linhas */
SELECT TOP (20) *
FROM account
ORDER BY AccountKey;

/* 2. Contar quantas contas existem no arquivo */
SELECT COUNT(*) AS total_contas
FROM account;

/* 3. Listar todas as AccountType distintos */
SELECT DISTINCT AccountType
FROM account
WHERE AccountType IS NOT NULL
ORDER BY AccountType;

/* 4. Contar quantas contas têm AccountType nulo */
SELECT COUNT(*) AS quantidade_nulos_accounttype
FROM account
WHERE AccountType IS NULL;

/* 5. Retornar AccountKey, AccountDescription e AccountType ordenado por AccountDescription */
SELECT AccountKey, AccountDescription, AccountType
FROM account
ORDER BY AccountDescription;

/* 6. Listar contas cujo AccountDescription contém a palavra 'Cash' (case-insensitive) */
SELECT AccountKey, AccountDescription
FROM account
WHERE AccountDescription LIKE '%Cash%';

/* 7. Mostrar as 10 maiores AccountCodeAlternateKey (maior valor numérico) */
SELECT TOP (10) AccountKey, AccountCodeAlternateKey, AccountDescription
FROM account
ORDER BY AccountCodeAlternateKey DESC;

/* 8. Selecionar as contas cujo Operator = '+' */
SELECT AccountKey, AccountDescription, Operator
FROM account
WHERE Operator = '+';

/* 9. Substituir nulos em AccountType por 'UNKNOWN' (exibir apenas) */
SELECT AccountKey, AccountDescription,
       ISNULL(AccountType, 'UNKNOWN') AS AccountType_clean
FROM account;

/* 10. Verificar quantos ValueType diferentes existem e listar */
SELECT ValueType, COUNT(*) AS qtd
FROM account
GROUP BY ValueType
ORDER BY qtd DESC;


-- ======================================================
-- ********************************************************
-- *               EXERCÍCIOS - NÍVEL MÉDIO (10)
-- ********************************************************
-- ======================================================

/* 11. Contar quantas contas por AccountType (ordenado por quantidade desc) */
SELECT ISNULL(AccountType, 'UNKNOWN') AS AccountType, COUNT(*) AS total
FROM account
GROUP BY ISNULL(AccountType, 'UNKNOWN')
ORDER BY total DESC;

/* 12. Mostrar contas que têm ParentAccountKey (não nulos) com info do pai via self-join */
SELECT c.AccountKey, c.AccountDescription, p.AccountKey AS ParentKey, p.AccountDescription AS ParentDescription
FROM account c
LEFT JOIN account p ON c.ParentAccountKey = p.AccountKey
WHERE c.ParentAccountKey IS NOT NULL
ORDER BY c.AccountKey;

/* 13. Listar contas que são raiz (não possuem ParentAccountKey) */
SELECT AccountKey, AccountDescription
FROM account
WHERE ParentAccountKey IS NULL;

/* 14. Agrupar por Operator e ValueType e mostrar contagens */
SELECT Operator, ValueType, COUNT(*) AS qtd
FROM account
GROUP BY Operator, ValueType
ORDER BY Operator, ValueType;

/* 15. Gerar uma coluna indicando se a conta é de Assets (1) ou não (0) */
SELECT AccountKey, AccountDescription, AccountType,
       CASE WHEN AccountType = 'Assets' THEN 1 ELSE 0 END AS is_assets
FROM account;

/* 16. Encontrar AccountDescription duplicadas (se houver) */
SELECT AccountDescription, COUNT(*) AS ocorrencias
FROM account
GROUP BY AccountDescription
HAVING COUNT(*) > 1;

/* 17. Exibir AccountKey e um campo com AccountCodeAlternateKey formatado com 6 dígitos (leading zeros) */
SELECT AccountKey, AccountDescription,
       FORMAT(AccountCodeAlternateKey, '000000') AS AccountCodeAlt_formatted
FROM account;

/* 18. Mostrar as 5 AccountTypes com mais registros */
SELECT TOP (5) ISNULL(AccountType, 'UNKNOWN') AS AccountType, COUNT(*) AS qtd
FROM account
GROUP BY ISNULL(AccountType, 'UNKNOWN')
ORDER BY qtd DESC;

/* 19. Listar contas cujo AccountCodeAlternateKey está entre 1000 e 2000 */
SELECT AccountKey, AccountCodeAlternateKey, AccountDescription
FROM account
WHERE AccountCodeAlternateKey BETWEEN 1000 AND 2000
ORDER BY AccountCodeAlternateKey;

/* 20. Criar uma visão simplificada (query) com AccountKey, ParentAccountKey e nível estimado (baseado em ParentAccountKey não nulo) */
SELECT AccountKey, ParentAccountKey,
       CASE WHEN ParentAccountKey IS NULL THEN 'root' ELSE 'child' END AS nivel
FROM account;


-- ======================================================
-- ********************************************************
-- *              EXERCÍCIOS - NÍVEL DIFÍCIL (10)
-- ********************************************************
-- ======================================================

/* 21. Usar CTE recursiva para montar a hierarquia (ancestrais) e mostrar caminho completo (path) por AccountKey.
   Observação: ParentAccountKey referencia AccountKey. */
WITH Hierarquia AS (
  SELECT AccountKey,
         AccountDescription,
         ParentAccountKey,
         CAST(AccountDescription AS nvarchar(MAX)) AS path,
         0 AS depth
  FROM account
  WHERE ParentAccountKey IS NULL

  UNION ALL

  SELECT c.AccountKey,
         c.AccountDescription,
         c.ParentAccountKey,
         CAST(h.path + ' > ' + c.AccountDescription AS nvarchar(MAX)) AS path,
         h.depth + 1
  FROM account c
  INNER JOIN Hierarquia h ON c.ParentAccountKey = h.AccountKey
)
SELECT AccountKey, AccountDescription, ParentAccountKey, path, depth
FROM Hierarquia
ORDER BY depth, AccountKey;

/* 22. Calcular a profundidade máxima da hierarquia usando CTE recursiva */
WITH Rec AS (
  SELECT AccountKey, ParentAccountKey, 0 AS depth
  FROM account
  WHERE ParentAccountKey IS NULL
  UNION ALL
  SELECT c.AccountKey, c.ParentAccountKey, r.depth + 1
  FROM account c
  JOIN Rec r ON c.ParentAccountKey = r.AccountKey
)
SELECT MAX(depth) AS profundidade_maxima
FROM Rec;

/* 23. Encontrar contas folhas (que não são pai de ninguém) */
SELECT a.AccountKey, a.AccountDescription
FROM account a
LEFT JOIN account child ON child.ParentAccountKey = a.AccountKey
WHERE child.AccountKey IS NULL;

/* 24. Criar um ranking por AccountType usando ROW_NUMBER() */
SELECT AccountKey, AccountDescription, AccountType,
       ROW_NUMBER() OVER (PARTITION BY AccountType ORDER BY AccountCodeAlternateKey DESC) AS rn
FROM account;

/* 25. Para cada AccountType, trazer a menor e maior AccountCodeAlternateKey (min/max) */
SELECT AccountType,
       MIN(AccountCodeAlternateKey) AS min_code,
       MAX(AccountCodeAlternateKey) AS max_code,
       COUNT(*) AS total
FROM account
GROUP BY AccountType
ORDER BY total DESC;

/* 26. Listar contas cujo AccountDescription inicia com letra 'C' (case-insensitive) */
SELECT AccountKey, AccountDescription
FROM account
WHERE AccountDescription COLLATE Latin1_General_CI_AS LIKE 'C%';

/* 27. Agrupar, filtrar e mostrar AccountTypes com mais de 10 registros */
SELECT AccountType, COUNT(*) AS qtd
FROM account
GROUP BY AccountType
HAVING COUNT(*) > 10
ORDER BY qtd DESC;

/* 28. Usar STRING_AGG para concatenar AccountDescription por AccountType (limitando a 200 caracteres) */
SELECT AccountType,
       LEFT(STRING_AGG(AccountDescription, ', '), 200) AS amostra_descricoes
FROM account
GROUP BY AccountType;

/* 29. Verificar consistência entre ParentAccountCodeAlternateKey e AccountCodeAlternateKey do pai (self-join) */
SELECT c.AccountKey, c.AccountCodeAlternateKey, p.AccountKey AS parent_key, p.AccountCodeAlternateKey AS parent_code
FROM account c
LEFT JOIN account p ON c.ParentAccountKey = p.AccountKey
WHERE c.ParentAccountCodeAlternateKey IS NOT NULL
  AND c.ParentAccountCodeAlternateKey <> p.AccountCodeAlternateKey;

/* 30. Substituir Operator por texto mais legível usando CASE e contar por operador legível */
SELECT
  CASE Operator
    WHEN '+' THEN 'positivo'
    WHEN '-' THEN 'negativo'
    WHEN '~' THEN 'neutro'
    ELSE 'outro'
  END AS operator_label,
  COUNT(*) AS qtd
FROM account
GROUP BY
  CASE Operator
    WHEN '+' THEN 'positivo'
    WHEN '-' THEN 'negativo'
    WHEN '~' THEN 'neutro'
    ELSE 'outro'
  END
ORDER BY qtd DESC;


-- ======================================================
-- ********************************************************
-- *               EXERCÍCIOS - NÍVEL PLENO (10)
-- ********************************************************
-- ======================================================

/* 31. Criar uma tabela temporária agregada por AccountType com total e média do AccountCodeAlternateKey */
SELECT AccountType,
       COUNT(*) AS total,
       AVG(CAST(AccountCodeAlternateKey AS FLOAT)) AS media_code
INTO #agg_accounttype
FROM account
GROUP BY AccountType;

SELECT * FROM #agg_accounttype ORDER BY total DESC;

/* 32. Atualizar (exemplo) — marcar AccountType nulo para 'UNKNOWN' em uma tabela temporária e mostrar resultados.
   (Nota: não altera a tabela original, apenas demonstra UPDATE em temp) */
SELECT * INTO #tmp_account FROM account;
UPDATE #tmp_account
SET AccountType = 'UNKNOWN'
WHERE AccountType IS NULL;

SELECT TOP (20) AccountKey, AccountDescription, AccountType FROM #tmp_account;

/* 33. Usar janela para calcular percentil (cume) do AccountCodeAlternateKey dentro do ValueType */
SELECT AccountKey, AccountDescription, ValueType, AccountCodeAlternateKey,
       CUME_DIST() OVER (PARTITION BY ValueType ORDER BY AccountCodeAlternateKey) AS cume_dist
FROM account
ORDER BY ValueType, cume_dist DESC;

/* 34. Para cada nível de hierarquia (usando CTE recursiva), contar quantas contas existem naquele depth */
WITH RecDepth AS (
  SELECT AccountKey, ParentAccountKey, 0 AS depth
  FROM account
  WHERE ParentAccountKey IS NULL
  UNION ALL
  SELECT c.AccountKey, c.ParentAccountKey, r.depth + 1
  FROM account c
  JOIN RecDepth r ON c.ParentAccountKey = r.AccountKey
)
SELECT depth, COUNT(*) AS qtd
FROM RecDepth
GROUP BY depth
ORDER BY depth;

/* 35. Encontrar possíveis ciclos na hierarquia (defesa contra loops) — limitar profundidade e checar repetição de AccountKey */
WITH RecCheck AS (
  SELECT AccountKey, ParentAccountKey, CAST(AccountKey AS nvarchar(MAX)) AS path, 0 AS depth
  FROM account
  UNION ALL
  SELECT c.AccountKey, c.ParentAccountKey, rc.path + '>' + CAST(c.AccountKey AS nvarchar(20)), rc.depth + 1
  FROM account c
  JOIN RecCheck rc ON c.ParentAccountKey = rc.AccountKey
  WHERE rc.depth < 1000
)
SELECT *
FROM RecCheck
WHERE CHARINDEX('>' + CAST(AccountKey AS nvarchar(20)) + '>', '>' + path + '>') > 0; /* se repetir, pode indicar ciclo */

/* 36. Criar um relatório que mostra: AccountType, total, % do total geral (formato percentual) */
WITH totals AS (
  SELECT COUNT(*) AS total_geral FROM account
),
per_type AS (
  SELECT AccountType, COUNT(*) AS total_type
  FROM account
  GROUP BY AccountType
)
SELECT p.AccountType,
       p.total_type,
       CAST(100.0 * p.total_type / t.total_geral AS DECIMAL(5,2)) AS percentual
FROM per_type p CROSS JOIN totals t
ORDER BY percentual DESC;

/* 37. Usar APPLY para trazer informações do pai em uma linha (CROSS APPLY) */
SELECT c.AccountKey, c.AccountDescription, p.AccountKey AS parentKey, p.AccountDescription AS parentDesc
FROM account c
OUTER APPLY (
  SELECT TOP (1) AccountKey, AccountDescription
  FROM account p
  WHERE p.AccountKey = c.ParentAccountKey
) p;

/* 38. Encontrar os 10 accounts que mais "descem" na hierarquia (maior depth) — combinar CTE recursiva + ROW_NUMBER */
WITH Depths AS (
  SELECT AccountKey, ParentAccountKey, 0 AS depth
  FROM account WHERE ParentAccountKey IS NULL
  UNION ALL
  SELECT c.AccountKey, c.ParentAccountKey, d.depth + 1
  FROM account c
  JOIN Depths d ON c.ParentAccountKey = d.AccountKey
)
SELECT TOP (10) AccountKey, MAX(depth) AS max_depth
FROM Depths
GROUP BY AccountKey
ORDER BY max_depth DESC;

/* 39. Exportar (gerar) lista com AccountKey + AccountDescription onde CustomMembers não é nulo (se houver) — e agrupar por ValueType */
SELECT ValueType, COUNT(*) AS qtd_com_custommembers,
       STRING_AGG(CONCAT(AccountKey, ':', AccountDescription), '; ') WITHIN GROUP (ORDER BY AccountKey) AS lista_contas
FROM account
WHERE CustomMembers IS NOT NULL
GROUP BY ValueType;

/* 40. Construir visão consolidada com colunas calculadas e flags para uso analítico (ex: is_root, is_leaf, has_custommembers) */
WITH children AS (
  SELECT DISTINCT ParentAccountKey FROM account WHERE ParentAccountKey IS NOT NULL
)
SELECT a.AccountKey,
       a.AccountDescription,
       a.AccountType,
       CASE WHEN a.ParentAccountKey IS NULL THEN 1 ELSE 0 END AS is_root,
       CASE WHEN a.AccountKey IN (SELECT ParentAccountKey FROM account WHERE ParentAccountKey IS NOT NULL) THEN 0 ELSE 1 END AS is_leaf,
       CASE WHEN a.CustomMembers IS NOT NULL THEN 1 ELSE 0 END AS has_custommembers,
       a.ValueType
FROM account a
ORDER BY a.AccountKey;
