{{ config(materialized='external', location='exports/dim_clientes.csv', format='csv') }}

with customers as (
    select * from {{ ref('stg_customers') }}
)

select
    id_cliente,
    id_unico_cliente,
    cidade_cliente,
    estado_cliente
from customers
