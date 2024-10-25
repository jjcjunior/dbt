
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="gold") }}

select  ROW_NUMBER () OVER ( ORDER BY municipio ) as pk_dna, municipio,mesoregiao,uf,num_habitante,renda_percp,potencial,id_municipio
from {{ref('dna')}} 
order by municipio

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null

