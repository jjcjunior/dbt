
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="silver") }}

with source_data as (

    SELECT 
        "A4_COD" as codigo
        , "A4_NOME" as nome
        ,"D_E_L_E_T_"
    FROM {{ source('bronze','SA4010')}}

)

select codigo,nome
from source_data
where "D_E_L_E_T_" <> '*'

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
