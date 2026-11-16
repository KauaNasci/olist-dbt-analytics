{{ config(materialized='external', location='exports/fct_vendas.csv', format='csv') }}

with enriched_orders as (
    select * from {{ ref('int_orders_enriched') }}
)

select
    id_pedido,
    id_cliente,
    status_pedido,
    data_compra,
    valor_produtos,
    valor_frete,
    valor_total_pedido,
    qtd_itens,
    pedido_atrasado
from enriched_orders
where status_pedido = 'delivered'
