{{ config(materialized='table',schema="silver") }}

with source_data as (

    SELECT ROW_NUMBER () OVER ( ORDER BY cartao ) as pk_funcionario, cartao as cod_func, funcionario, funcao
    from {{ source('bronze','funcionario')}}

)

select *
from source_data
