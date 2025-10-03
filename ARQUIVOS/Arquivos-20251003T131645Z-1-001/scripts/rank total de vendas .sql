

select
EmployeeKey
,sum( SalesAmount) venda
from dbo.FactResellerSales
group by EmployeeKey
order by sum( SalesAmount) desc


select
EmployeeKey
,ProductKey
,sum( SalesAmount) venda
,DENSE_RANK()over (partition by EmployeeKey order by sum( SalesAmount)desc) as posição 
from dbo.FactResellerSales
group by EmployeeKey,ProductKey










