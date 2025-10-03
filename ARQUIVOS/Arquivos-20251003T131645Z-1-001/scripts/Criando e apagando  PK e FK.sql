-- adicionar constraints PK PRimary Key 

use [Teste ]

ALTER TABLE [dbo].[Vendas]
add constraint PK_venda  primary key (id)

alter table [dbo].[Produto]
add constraint PK_Produto primary key (id)

ALTER TABLE [DBO].CATEGORIA
ADD CONSTRAINT PK_CATEGORIA PRIMARY KEY (ID)

--- adicionar FK FOREIGN KEY

alter table [dbo].[Vendas]
add constraint FK_Produto foreign key ([product_id])
references [dbo].[Produto] ([Id])

alter table [dbo].[Produto]
add constraint FK_Categoria foreign key ([id_categoria])
references [dbo].[Categoria] ([Id])


-- apagar PKS e FKS 
ALTER TABLE [dbo].[Categoria]
Drop  constraint [PK_CATEGORIA]
