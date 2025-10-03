
select
LastName
,EnglishProductName
,venda

from (
select 
t1.EmployeeKey
,t2.LastName
,t3.EnglishProductName
,sum( t1.SalesAmount) venda 
,DENSE_RANK() over (partition by t1.EmployeeKey order by  sum( t1.SalesAmount) desc   ) posicao 
from       dbo.FactResellerSales as T1
left join  dbo.DimEmployee       as T2 ON t1.EmployeeKey = t2.EmployeeKey
left join  dbo.DimProduct        as T3 ON t1.ProductKey  = t3.ProductKey

group by t1.EmployeeKey,t2.LastName,t3.EnglishProductName ) TB
where posicao = 1