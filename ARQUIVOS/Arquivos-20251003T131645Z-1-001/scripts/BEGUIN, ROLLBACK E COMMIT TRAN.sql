

--BEGIN TRAN    | inicia Transação
--ROLLBACK TRAN | Cancelar Transação 
--COMMIT TRAN   | Salvar Transação


-------------------------------
------ UPDATES
-------------------------------
USE TESTE 
select * from [dbo].[Produto] where Id = 2

UPDATE [dbo].[Produto]
   SET nome = 'Calça Apertada ', 
       id_categoria = 1
 WHERE Id = 2
GO
select * from [dbo].[Produto] where Id = 2

----------- Com Segurança na transação----------------------
select * from [dbo].[Produto] 

BEGIN TRAN    -- inicia Transação (Executar antes de iniciar transação)
UPDATE [dbo].[Produto]
   SET nome = 'Calça Apertadinha ', 
       id_categoria = 1
 WHERE Id = 2

ROLLBACK TRAN --| Cancelar Transação  
COMMIT TRAN   --| Salvar Transação

select * from [dbo].[Produto]

----- Grande Cagada na base ------
select * from [dbo].[Produto]

BEGIN TRAN    -- inicia Transação (Executar antes de iniciar transação)
UPDATE [dbo].[Produto]
   SET nome = 'Calça Apertadinha ', 
       id_categoria = 1
	   where id =2


ROLLBACK TRAN --| Cancelar Transação 
COMMIT TRAN   --| Salvar Transação

select * from [dbo].[Produto]

-------------------------------
------ DELETES
-------------------------------
USE TESTE 
select * from [dbo].[Produto] where Id = 10

DELETE [dbo].[Produto]
  where Id = 10 

select * from [dbo].[Produto]

----------- Com Segurança na transação----------------------
select * from [dbo].[Produto] where Id IN (1,3,4,5,6,10)

BEGIN TRAN    -- inicia Transação (Executar antes de iniciar transação)

DELETE [dbo].[Produto]
  where Id IN (1,3,4,5,6,10)

select * from [dbo].[Produto]

ROLLBACK TRAN --| Cancelar Transação  
COMMIT TRAN   --| Salvar Transação



----- Grande Cagada na base ------
select * from [dbo].[Produto] 

BEGIN TRAN    -- inicia Transação (Executar antes de iniciar transação)
select * from [dbo].[Produto] where Id IN (1,3,4,5,6,10)

DELETE [dbo].[Produto]
  
select * from [dbo].[Produto]

ROLLBACK TRAN --| Cancelar Transação  
COMMIT TRAN   --| Salvar Transação




-------------------------------
------ INSERTS
-------------------------------

select * from [dbo].[Produto]

INSERT INTO [dbo].[Produto] (id,nome,id_categoria)
                      Values(50,'Camisa Apertadinha',10)

delete [dbo].[Produto] where id = 50

----------- Com Segurança na transação----------------------

select * from [dbo].[Produto]

BEGIN TRAN 
INSERT INTO [dbo].[Produto] (id,nome,id_categoria)
                      Values(50,'Camisa Apertadinha',10)

commit tran 








