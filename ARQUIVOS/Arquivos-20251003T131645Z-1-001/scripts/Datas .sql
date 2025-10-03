


--https://learn.microsoft.com/pt-br/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver16


SELECT SYSDATETIME()
SELECT SYSDATETIMEOFFSET()
SELECT SYSUTCDATETIME()

SELECT CURRENT_TIMESTAMP
SELECT GETDATE()
SELECT GETUTCDATE()
	
--Formato texto 

SELECT DATENAME(YEAR,GETDATE())  
SELECT DATENAME(WEEKDAY, getdate()) 

select *
,DATENAME(year,created_at)  ano_txt
,DATENAME(MONTH,created_at) mes_txt
,DATENAME(DAY,created_at)   dia_txt
from [dbo].[Ordens]

--- relatório pratico formato texto  
select 
DATENAME(year,created_at)  ano_txt
,DATENAME(MONTH,created_at) mes_txt
,count (id) as QNT
from [dbo].[Ordens]

group by DATENAME(year,created_at),DATENAME(MONTH,created_at)
order by 1,3 desc



--Formato Inteiro
select year (nome da coluna)
select year (getdate())
select month (getdate())
select day (getdate())

-- parte da data 
select DATEPART(year, nome da coluna)
select DATEPART(year, getdate())
select DATEPART(MONTH, getdate()) as mes
select DATEPART(DAY, getdate())
select DATEPART(HOUR, getdate())
select DATEPART(MINUTE, getdate())
select DATEPART(SECOND, getdate())
select DATEPART(MILLISECOND, getdate())


--- relatório pratico formato inteiro = venda jan 2019 por dia 
select 
DATEPART(day,created_at) Dia
,count (id) as QNT_Venda
from [dbo].[Ordens]
where YEAR (created_at) = 2019
and   MONTH(created_at) = 1
group by DATEPART(day,created_at)




