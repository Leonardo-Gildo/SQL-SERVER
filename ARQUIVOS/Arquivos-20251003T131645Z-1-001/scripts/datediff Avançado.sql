
use DWAdventure
select *
from [dbo].[DimEmployee]

--- funcionarios demitidos quantos anos ficaram na empresa

select 
EmployeeKey
,FirstName
,HireDate
,EndDate
from [dbo].[DimEmployee]

-- funcionarios demitidos
select 
EmployeeKey
,FirstName
,HireDate
,EndDate
from [dbo].[DimEmployee]
where EndDate is not null

select 
EmployeeKey
,FirstName
,HireDate
,EndDate
,DATEDIFF(year,HireDate,EndDate) Tempo_empresa
from [dbo].[DimEmployee]
where EndDate is not null
order by 5

----- funcionarios ativos empres (tempo de casa)
select 
EmployeeKey
,FirstName
,HireDate
,DATEDIFF(hour,HireDate,getdate()) as 'Tempo Empresa (mes)'
from [dbo].[DimEmployee]
where EndDate is null
order by 4 desc


--- quantos anos tem os  funcionarios 
select 
EmployeeKey
,FirstName
,BirthDate
from [dbo].[DimEmployee]

select 
EmployeeKey
,FirstName
,BirthDate
,DATEDIFF(year , BirthDate,getdate()   ) as idade
from [dbo].[DimEmployee]
order by 4 desc

select DATEDIFF(SECOND,'1973-05-12', GETDATE()  )



---Faixa idades
select top 10 *
from [dbo].[DimEmployee]

select 
EmployeeKey
,FirstName
,BirthDate
,DATEDIFF (YEAR,BirthDate,GETDATE()  )
from [dbo].[DimEmployee]
--------------------------------------------------------

select 
EmployeeKey
,FirstName
,BirthDate
,DATEDIFF (YEAR,BirthDate,GETDATE()  )
,CASE
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 0 and  20 then '0 a 20 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 21 and 40 then '21 a 40 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 41 and 60 then '41 a 60 Anos'
	else '+ de 60 Anos'
	end as 'Faixa etaria'
	from [dbo].[DimEmployee]
	order by 4
	   




--- relatório com as quantidades de pessoas por faixa

select 
EmployeeKey
,FirstName
,BirthDate
,DATEDIFF (YEAR,BirthDate,GETDATE()  )
,CASE
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 0 and  20 then '0 a 20 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 21 and 40 then '21 a 40 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 41 and 60 then '41 a 60 Anos'
	else '+ de 60 Anos'
	end as 'Faixa etaria'
	from [dbo].[DimEmployee]
	order by 4
	   
select 
EmployeeKey
,CASE
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 0 and  20 then '0 a 20 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 21 and 40 then '21 a 40 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 41 and 60 then '41 a 60 Anos'
	else '+ de 60 Anos'
	end as 'Faixa etaria'
	from [dbo].[DimEmployee]


		   
select 
count (EmployeeKey) as qnt
,CASE
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 0 and  20 then '0 a 20 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 21 and 40 then '21 a 40 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 41 and 60 then '41 a 60 Anos'
	else '+ de 60 Anos'
	end as 'Faixa etaria'
	from [dbo].[DimEmployee]
	group by 	CASE
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 0 and  20 then '0 a 20 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 21 and 40 then '21 a 40 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 41 and 60 then '41 a 60 Anos'
	else '+ de 60 Anos'
	end
	
	


select
[Faixa etaria]
,count (EmployeeKey) as Quantidade

from (
select 
EmployeeKey
,CASE
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 0 and  20 then '0 a 20 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 21 and 40 then '21 a 40 Anos'
	when DATEDIFF (YEAR,BirthDate,GETDATE()  ) between 41 and 60 then '41 a 60 Anos'
	else '+ de 60 Anos'
	end as 'Faixa etaria'
	from [dbo].[DimEmployee] ) as tabela 
	group by [Faixa etaria]
	order by 2 desc