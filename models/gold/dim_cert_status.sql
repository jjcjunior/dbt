
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="gold") }}

select ROW_NUMBER () OVER ( ORDER BY diretorio_arquivo ) as pk_certificado, 
    diretorio_arquivo , 
    uf , 
    cod_fornecedor , 
    CONCAT(loja , fornecedor), 
    genero_cert , 
    nome_arquivo ,
    validade_cert
from {{ref('cert_status')}} 
where fornecedor is not null
