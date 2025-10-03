

--- Rank + Sub query + tabela temporária 
--- por colaborador o ranking de vendas por produto 


select 
EmployeeKey
,ProductKey
,sum ( SalesAmount) as venda
,DENSE_RANK() over (partition by EmployeeKey order by sum ( SalesAmount) desc ) as posicao
from dbo.FactResellerSales
group by EmployeeKey,ProductKey


