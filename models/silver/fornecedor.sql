{{ config(materialized='table',schema="silver") }}

with source_data as (

    SELECT "A2_COD" COD ,
        "A2_NOME" NOME, 
        CONCAT ("A2_COD" , "A2_LOJA") ID_FORNECEDOR,
        "A2_NREDUZ" NOME_REDUZ, 
        "A2_LOJA" LOJA, 
        "A2_CGC" CNPJ_CPF, 
        "A2_FILIAL" FILIAL, 
        "D_E_L_E_T_"
    from {{ source('bronze','SA2010')}}
)

select *
from source_data
WHERE "D_E_L_E_T_" <> '*' AND FILIAL = '01'
