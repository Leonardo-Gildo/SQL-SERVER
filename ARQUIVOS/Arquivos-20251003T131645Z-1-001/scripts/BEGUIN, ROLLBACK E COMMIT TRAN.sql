

--BEGIN TRAN    | inicia Transa��o
--ROLLBACK TRAN | Cancelar Transa��o 
--COMMIT TRAN   | Salvar Transa��o


-------------------------------
------ UPDATES
-------------------------------
USE TESTE 
select * from [dbo].[Produto] where Id = 2

UPDATE [dbo].[Produto]
   SET nome = 'Cal�a Apertada ', 
       id_categoria = 1
 WHERE Id = 2
GO
select * from [dbo].[Produto] where Id = 2

----------- Com Seguran�a na transa��o----------------------
select * from [dbo].[Produto] 

BEGIN TRAN    -- inicia Transa��o (Executar antes de iniciar transa��o)
UPDATE [dbo].[Produto]
   SET nome = 'Cal�a Apertadinha ', 
       id_categoria = 1
 WHERE Id = 2

ROLLBACK TRAN --| Cancelar Transa��o  
COMMIT TRAN   --| Salvar Transa��o

select * from [dbo].[Produto]

----- Grande Cagada na base ------
select * from [dbo].[Produto]

BEGIN TRAN    -- inicia Transa��o (Executar antes de iniciar transa��o)
UPDATE [dbo].[Produto]
   SET nome = 'Cal�a Apertadinha ', 
       id_categoria = 1
	   where id =2


ROLLBACK TRAN --| Cancelar Transa��o 
COMMIT TRAN   --| Salvar Transa��o

select * from [dbo].[Produto]

-------------------------------
------ DELETES
-------------------------------
USE TESTE 
select * from [dbo].[Produto] where Id = 10

DELETE [dbo].[Produto]
  where Id = 10 

select * from [dbo].[Produto]

----------- Com Seguran�a na transa��o----------------------
select * from [dbo].[Produto] where Id IN (1,3,4,5,6,10)

BEGIN TRAN    -- inicia Transa��o (Executar antes de iniciar transa��o)

DELETE [dbo].[Produto]
  where Id IN (1,3,4,5,6,10)

select * from [dbo].[Produto]

ROLLBACK TRAN --| Cancelar Transa��o  
COMMIT TRAN   --| Salvar Transa��o



----- Grande Cagada na base ------
select * from [dbo].[Produto] 

BEGIN TRAN    -- inicia Transa��o (Executar antes de iniciar transa��o)
select * from [dbo].[Produto] where Id IN (1,3,4,5,6,10)

DELETE [dbo].[Produto]
  
select * from [dbo].[Produto]

ROLLBACK TRAN --| Cancelar Transa��o  
COMMIT TRAN   --| Salvar Transa��o




-------------------------------
------ INSERTS
-------------------------------

select * from [dbo].[Produto]

INSERT INTO [dbo].[Produto] (id,nome,id_categoria)
                      Values(50,'Camisa Apertadinha',10)

delete [dbo].[Produto] where id = 50

----------- Com Seguran�a na transa��o----------------------

select * from [dbo].[Produto]

BEGIN TRAN 
INSERT INTO [dbo].[Produto] (id,nome,id_categoria)
                      Values(50,'Camisa Apertadinha',10)

commit tran 








