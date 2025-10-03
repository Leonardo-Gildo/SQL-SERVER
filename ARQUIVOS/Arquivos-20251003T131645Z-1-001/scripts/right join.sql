

select distinct
t2.user_name
,t2.user_id
,t1.user_id as 'idtabela 1'
,t1.type

From        vendas.dbo.Acessos T1
right join  vendas.dbo.Compras T2 On t1.user_id = t2.user_id
where t1.user_id is null


select *
From vendas.dbo.Acessos T1

select *
From vendas.dbo.Compras T2