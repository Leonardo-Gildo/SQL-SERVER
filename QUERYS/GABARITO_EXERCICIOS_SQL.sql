/* ======================================================
   ********************************************************
   *      GABARITO - EXERCÍCIOS - NÍVEL FÁCIL (10)
					-- TABELA ACCOUNT --
   ********************************************************
   ====================================================== */

-- 1. Mostrar todas as colunas e 20 primeiras linhas
SELECT TOP 20 *
FROM dbo.DimAccount;

-- 2. Contar quantas contas existem no arquivo
SELECT COUNT (*) as TOTAL_Contas
FROM dbo.DimAccount;

-- 3. Listar todas as AccountType distintos e não nulos
SELECT DISTINCT AccountType
FROM dbo.DimAccount
WHERE AccountType IS NOT NULL;

-- 4. Contar quantas contas têm AccountType nulo
SELECT COUNT(*) TOTAL_Contas
FROM dbo.DimAccount
WHERE AccountType IS NULL;

-- 5. Retornar AccountKey, AccountDescription e AccountType ordenado por AccountDescription
SELECT AccountKey, AccountDescription, AccountType
FROM dbo.DimAccount
ORDER BY AccountDescription;

-- 6. Listar contas cujo AccountDescription contém a palavra 'Cash' (case-insensitive)
SELECT AccountKey, AccountDescription
FROM dbo.DimAccount
WHERE AccountDescription LIKE '%Cash%'

-- 7. Mostrar as 10 maiores AccountCodeAlternateKey (maior valor numérico)
SELECT top 10 AccountKey, AccountDescription, AccountCodeAlternateKey as COD_ALTERNATIVO
FROM dbo.DimAccount
ORDER BY AccountCodeAlternateKey DESC;

-- 8. Selecionar as contas cujo Operator = '+'
SELECT 
AccountKey as ID_Conta, 
AccountDescription as Descricao, 
Operator as Operador 
FROM dbo.DimAccount
WHERE Operator = '+'