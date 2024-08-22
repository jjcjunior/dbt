
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="silver") }}

with source_data as (

    SELECT "B1_COD" as codigo
            , "B1_ZBM" subgrupo
            , "B1_DESC" descricao
            , "B1_FILIAL" filial
            , "D_E_L_E_T_"
    from {{ source('bronze','SB1010')}}

)

select codigo,descricao, subgrupo
from source_data
where "D_E_L_E_T_" <> '*' AND filial = '01'

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
