

--  https://learn.microsoft.com/pt-br/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver16

select top 10 *
from FactInternetSales

select top 10 
SalesOrderNumber
,CustomerKey
,SalesAmount
,OrderDate
,CAST(OrderDate as date)
,CONVERT(varchar,OrderDate,103 ) as padraobr
,CONVERT(varchar,OrderDate,111 ) as JP
from FactInternetSales


select 
GETDATE() 
,CAST( GETDATE() as date   )
,CONVERT(varchar,GETDATE(),3 )
,CONVERT(varchar,GETDATE(),103 )