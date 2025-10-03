/*
create table     = criar tabela
insert into      = inserir dados na tabela 
truncate table   = apagar dados na tabela 
drop table       = deletar tabela 

*/

use [Teste ]
create table Vendas
(
id           int primary key not null
,product_id  int not null
,cliente     varchar (50) null
,data_compra date not null
,valor_total money
)

select *
from [Teste ].dbo.Vendas

insert into [Teste ].dbo.Vendas (id,product_id,cliente,data_compra,valor_total)values(0,28,'Luana','11/07/2022',186)

truncate table [Teste ].dbo.Vendas

--------------------------------------------------------------------------------

use teste
create table Produto
(
Id              int primary key not null
,nome           varchar (50)not null
,id_categoria   int not null
)

select *
from[dbo].[Produto]


insert into [dbo].[Produto] (Id,nome,id_categoria) values (0,'Sapato',0)

truncate table  teste.dbo.produto

-----------
use [Teste ]
create table Categoria
(
id    int primary key not null
,nome varchar (50)

)
select *
from [Teste ].dbo.Categoria


truncate table [Teste ].dbo.Categoria

