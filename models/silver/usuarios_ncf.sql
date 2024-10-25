
{{ config(materialized='table',schema="silver") }}

with source_data as (
    SELECT "QAA_MAT" AS codigo
    , "QAA_NOME" AS nome
    , "QAA_APELID" AS apelido
    , "D_E_L_E_T_"
    from {{ source('bronze','QAA010')}}
)

select codigo, nome, apelido
from source_data
where "D_E_L_E_T_" <> '*'
