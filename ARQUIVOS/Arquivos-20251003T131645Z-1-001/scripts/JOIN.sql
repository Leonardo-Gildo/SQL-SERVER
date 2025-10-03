

--Join ou inner join = relaciona dados que tenha informaçoes iguais se nao tiver ele nao traz o resultado 
--Left join = prioriza a primeira tabela T1
--Right join = prioriza a segunda tabela T2
--Full join = traz Tudo T1 e T2

select 
t1.id
,t1.quantity
,t2.customer_id
,t2.status

From Ecommece.dbo.Vendas as T1
left join Ecommece.dbo.Ordens as T2 ON t1.order_id = t2.id




