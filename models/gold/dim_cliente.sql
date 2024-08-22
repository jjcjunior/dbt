
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="gold") }}

select  ROW_NUMBER () OVER ( ORDER BY id ) as pk_cliente, id, codigo,loja,nome,uf,municipio, CONCAT(uf,REPLACE(municipio,' ','')) as localizacao
from {{ref('clientes')}} 
order by id

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
