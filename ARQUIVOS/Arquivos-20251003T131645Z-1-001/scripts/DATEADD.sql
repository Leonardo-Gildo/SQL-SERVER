


select  DATEADD(month,1,getdate())

select cast( DATEADD(year,2,getdate()) as date)

select CONVERT(varchar, DATEADD(year,2,getdate()),103)


select DATEADD(month,-3,getdate())
select  DATEADD(month,-1, cast (GETDATE() as date))


select *
from [dbo].[Ordens]


select 
id
,created_at as Dt_venda
,DATEADD(MONTH,2,created_at) as Dt_pagamento
from [dbo].[Ordens]
---------- conversoes -------------------

select 
id
,CAST( created_at as date) as dt_venda
,CAST( DATEADD(MONTH,2,created_at) as date) as dt_pagamento
from [dbo].[Ordens]

 --- convert 

select 
id
,CONVERT(varchar, created_at , 103) as Dt_venda
,CONVERT(varchar, DATEADD(MONTH,2,created_at),103) as Dt_pagemento
from [dbo].[Ordens]

