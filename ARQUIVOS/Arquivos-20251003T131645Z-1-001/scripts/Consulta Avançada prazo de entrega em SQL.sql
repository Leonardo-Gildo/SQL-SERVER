--1= fazer vinculo e selecionar informaçoes importantes 

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
	when state in ('Rio Grande do Norte','Distrito Federal','Espírito Santo','Mato Grosso','Pernambuco','Bahia','Piauí') then DATEADD(day,5,cast (o.created_at as date))
	when state in ('Amapá','Minas Gerais','Espírito Santo','Roraima','Minas Gerais','Rio de Janeiro','São Paulo') then DATEADD(day,10,cast (o.created_at as date))
	else DATEADD(day,15,cast (o.created_at as date))
	end as prazo
  FROM [dbo].[Ordens] O
  left join [dbo].[Clientes] c  on o.customer_id = c.id

