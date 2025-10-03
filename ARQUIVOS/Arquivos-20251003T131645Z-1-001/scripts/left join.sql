

select distinct
t1.user_id 
,t2.user_id as 'id2'
,t1.user_name 
,t2.price

From        vendas.dbo.Acessos T1
left join   vendas.dbo.Compras T2 On t1.user_id = t2.user_id
where t2.user_id is null




select *
From vendas.dbo.Acessos T1

select *
From vendas.dbo.Compras T2