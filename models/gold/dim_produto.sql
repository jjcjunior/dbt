
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="gold") }}

select ROW_NUMBER () OVER ( ORDER BY p.codigo ) as pk_produto,p.codigo as codigo ,p.descricao as descricao, s.descricao as subgrupo
from {{ref('produtos')}} as p
left join {{ref('subgrupo')}} as s ON p.subgrupo = s.codigo
order by p.codigo asc

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
