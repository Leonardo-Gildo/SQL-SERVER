select *
from [Teste ].dbo.produto 

select *
from [Teste ].dbo.Categoria 


ALTER TABLE [Teste ].dbo.produto 
  ADD CONSTRAINT FK_CATEGORIA FOREIGN KEY (ID_CATEGORIA) REFERENCES Teste.dbo.Categoria (ID)

  ALTER TABLE [Teste ].dbo.produto 
  DROP CONSTRAINT  fK_PRODUTO




 

