
{{ config(materialized='table',schema="silver") }}

with source_data as (
    SELECT 
        "DB1_MANIFE" DATA_ENTRADA, 
        "DB1_ENTREG" DATA_REG,
        "DB1_HORA1" HORA_ENTRADA,
        "DB1_NRAVRC" NRAVRC,
        "D_E_L_E_T_"
    from {{ source('bronze','DB1010')}} 
)

select data_entrada,data_reg,hora_entrada,nravrc
from source_data
where "D_E_L_E_T_" <> '*'
