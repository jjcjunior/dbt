
{{ config(materialized='table',schema="silver") }}

with source_data as (
    SELECT 
        "ZQ1_FNC" AS codigo_ncf
        , "ZQ1_ITEM" AS cod_produto
        , "ZQ1_QTDE" AS quantidade
        , "D_E_L_E_T_"
        , "ZQ1_TPITEM" tipo_item
    from {{ source('bronze','ZQ1010')}} 
)

select codigo_ncf,cod_produto,quantidade,tipo_item
from source_data
where "D_E_L_E_T_" <> '*'
