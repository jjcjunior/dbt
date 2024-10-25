{{ config(materialized='table',schema="silver") }}

with source_data as (

    SELECT diretorio_arquivo , uf , cod_fornecedor , loja , fornecedor , genero_cert , nome_arquivo , validade_cert
    from {{ source('bronze', 'cert_status')}}
)

select *
from source_data

