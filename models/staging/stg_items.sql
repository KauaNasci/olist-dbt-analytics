with source as (
    select * from {{ ref('olist_order_items_dataset') }}
),

renamed as (
    select
        order_id as id_pedido,
        order_item_id as id_item_pedido,
        product_id as id_produto,
        cast(price as double) as preco_produto,
        cast(freight_value as double) as valor_frete
    from source
    where order_id is not null
)

select * from renamed
