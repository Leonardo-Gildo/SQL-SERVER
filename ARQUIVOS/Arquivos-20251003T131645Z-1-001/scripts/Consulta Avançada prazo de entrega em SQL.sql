--1= fazer vinculo e selecionar informa�oes importantes 

select 
o.id
,o.created_at
,o.customer_id
,c.id
,c.first_name
,c.cell_phone
,c.state
,c.street
,c.number

  FROM [dbo].[Ordens] O
  left join [dbo].[Clientes] c  on o.customer_id = c.id


  ----2 = criar prazo 
  select 
o.id
,cast (o.created_at as date) dtvenda
,o.customer_id
,c.id
,c.first_name
,c.cell_phone
,c.state
,c.street
,c.number
,case
	when state in ('Rio Grande do Norte','Distrito Federal','Esp�rito Santo','Mato Grosso','Pernambuco','Bahia','Piau�') then DATEADD(day,5,cast (o.created_at as date))
	when state in ('Amap�','Minas Gerais','Esp�rito Santo','Roraima','Minas Gerais','Rio de Janeiro','S�o Paulo') then DATEADD(day,10,cast (o.created_at as date))
	else DATEADD(day,15,cast (o.created_at as date))
	end as prazo
  FROM [dbo].[Ordens] O
  left join [dbo].[Clientes] c  on o.customer_id = c.id

