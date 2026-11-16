with source as (
    select * from {{ ref('olist_customers_dataset') }}
),

renamed as (
    select
        customer_id as id_cliente,
        customer_unique_id as id_unico_cliente,
        customer_city as cidade_cliente,
        customer_state as estado_cliente
    from source
    where customer_id is not null
)

select * from renamed
