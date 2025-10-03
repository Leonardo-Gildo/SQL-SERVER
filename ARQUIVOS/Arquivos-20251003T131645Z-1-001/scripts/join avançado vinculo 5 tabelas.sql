use Ecommece

select 
T1.id as Id_venda
,T1.total_price
,T1.quantity
,T2.created_at
,T2.status
,T3.name
,D.name
,CLI.first_name
,CLI.cell_phone
,CLI.state

from Ecommece.dbo.Vendas as    T1
left join Ecommece.dbo.Ordens  T2        ON  T1.order_id = T2.id
left join Ecommece.DBO.Produto T3        ON  T1.product_id = t3.id
left join Ecommece.DBO.Categoria as D    ON t3.category_id = D.id
left join Ecommece.dbo.Clientes as CLI    ON T2.customer_id = CLI.id

where T2.status = 'entrega_pendente'
order by 2 desc


















