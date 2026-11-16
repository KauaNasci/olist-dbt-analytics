with orders as (
    select * from {{ ref('stg_orders') }}
),

items as (
    select
        id_pedido,
        sum(preco_produto) as valor_produtos,
        sum(valor_frete) as valor_frete,
        count(id_item_pedido) as qtd_itens
    from {{ ref('stg_items') }}
    group by 1
),

joined as (
    select
        o.id_pedido,
        o.id_cliente,
        o.status_pedido,
        o.data_compra,
        coalesce(i.valor_produtos, 0) as valor_produtos,
        coalesce(i.valor_frete, 0) as valor_frete,
        coalesce(i.valor_produtos, 0) + coalesce(i.valor_frete, 0) as valor_total_pedido,
        coalesce(i.qtd_itens, 0) as qtd_itens,
        case 
            when o.data_entrega_cliente > o.data_estimada_entrega then true 
            else false 
        end as pedido_atrasado
    from orders o
    left join items i on o.id_pedido = i.id_pedido
)

select * from joined
