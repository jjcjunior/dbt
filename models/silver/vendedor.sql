
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="silver") }}

with source_data as (

    SELECT "A3_COD" codigo
            , "A3_NOME" nome
            ,"A3_EST" uf
            , "A3_MUN" municipio
            , "A3_TIPO" tipo
            , "A3_GEREN" gerente
            , "A3_ADMISS" admissao
            , "A3_MSBLQL" bloqueado
            , "A3_NOMSUP" supervisor 
            ,"D_E_L_E_T_"
    FROM {{ source('bronze','SA3010')}}
)

select 
    codigo
    ,nome
    ,uf
    ,municipio
    ,tipo
    ,gerente
    ,admissao
    ,bloqueado
    ,supervisor
from source_data
where "D_E_L_E_T_" <> '*'

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
