------- inserindo nova tabela espelho (Cópia de tabela)
select *
into [dbo].[Categoriaduplicada] 
from[dbo].[Categoria] 

select *
from [dbo].[Categoriaduplicada] 

drop table [dbo].[Categoriaduplicada] 


---------------- inserindo nova coluna 
select *
from [dbo].[Categoria]

alter table [dbo].[Categoria]
add Subcategoria int  

----Alterar tipo da coluna
ALTER TABLE nome_tabela 
ALTER COLUMN nome_coluna tipo_dados;


insert into [dbo].[Categoria] 
        (id,nome,Subcategoria)
Values (15,'Julia','outono')

Alter table [dbo].[Categoria]
drop column  Subcategoria


exec sp_columns [Categoria] 














