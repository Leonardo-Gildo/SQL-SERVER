select * 
,REPLACE(Concat(cast((cast(Promotor as float)-cast(Detratores as float))/cast(total as float)* 100 as decimal(10,2)),'%'),'.',',') as '%NPS'
,concat (cast(cast(Promotor as float)/cast(Total as float) * 100 as decimal(10,2)),'%')		as'% Promotor'
,concat (cast(cast(Neutro as float)/cast(Total as float) * 100 as decimal(10,2)),'%')		as'% Neutro'
,concat (cast(cast(Detratores as float)/cast(Total as float) * 100 as decimal(10,2)),'%')   as'% Detratores'
from(
select * 
,Nota0+Nota1+Nota2+Nota3+Nota4+Nota5+Nota6 as Detratores 
,Nota7+Nota8							   as Neutro
,Nota9+Nota10							   as Promotor 
from (
select 
Pergunta
,count(CASe when NOta = 0	then 1 end)      as Nota0	-- Detrator
,count(CASe when NOta = 1	then 1 end)      as Nota1   -- Detrator
,count(CASe when NOta = 2	then 1 end)      as Nota2   -- Detrator
,count(CASe when NOta = 3	then 1 end)      as Nota3   -- Detrator
,count(CASe when NOta = 4	then 1 end)      as Nota4   -- Detrator
,count(CASe when NOta = 5	then 1 end)      as Nota5   -- Detrator
,count(CASe when NOta = 6	then 1 end)      as Nota6   -- Detrator
,count(CASe when NOta = 7	then 1 end)      as Nota7	-- Neutro
,count(CASe when NOta = 8	then 1 end)      as Nota8	-- Neutro
,count(CASe when NOta = 9	then 1 end)      as Nota9	-- Promotor
,count(CASe when NOta = 10	then 1 end)		 as Nota10	-- Promotor
,count(CASe when NOta in(0,1,2,3,4,5,6,7,8,9,10)	then 1 end)		 as Total	-- Promotor
from [dbo].[NPS]
Group By Pergunta ) TAB
) TAB2




