
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="silver") }}

with source_data as (

    select 
        "F4_CODIGO" as codigo
        ,"F4_DUPLIC" as duplicata
        ,"D_E_L_E_T_" 
    from {{ source('bronze','SF4010')}}

)


select codigo,duplicata
from source_data
where "D_E_L_E_T_" <> '*' AND duplicata = 'S'

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
