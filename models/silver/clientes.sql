
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="silver") }}

with source_data as (

    select 
        "A1_COD" as codigo
        ,"A1_NOME" as nome
        ,"A1_LOJA"  as loja
        ,"A1_EST" as uf
        ,"A1_MUN" as municipio
        ,"D_E_L_E_T_" 
    from {{ source('bronze','SA1010')}}

)


select concat(codigo,loja) as id, codigo,loja,nome,uf,municipio
from source_data
where "D_E_L_E_T_" <> '*'

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
