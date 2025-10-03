

select distinct  
u.user_name as 'nome cadastro'
,u.id as 'Id de cadastro'
,c.user_id as 'id de compra'
,a.user_id as 'id de acesso'


from       vendas.dbo.Usuarios U
Full join  vendas.dbo.Compras  C ON u.id = c.user_id
Full join  Vendas.dbo.Acessos  A ON u.id = a.user_id

