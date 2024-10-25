
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="silver") }}

with source_data as (

    select 
        "F2_DOC" numero_nf
        ,"F2_EMISSAO" data_emissao
        ,"F2_CLIENTE" cod_cliente
        ,"F2_LOJA"  loja_cliente
        ,"F2_DUPL" duplicata
        ,"F2_TIPO" tipo
        ,"D_E_L_E_T_"
    from {{ source('bronze','SF2010')}}

)


select numero_nf, data_emissao::DATE ,concat(cod_cliente,loja_cliente) as id_cliente,duplicata,tipo
from source_data
where "D_E_L_E_T_" <> '*' AND duplicata <> ' ' AND tipo <> 'D'

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
