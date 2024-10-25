
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="gold") }}

SELECT dia,TO_CHAR(dia,'TMMON') as NomeMes, TO_CHAR(dia,'MM')::INT as Mes,EXTRACT(QUARTER FROM dia) as Trimestre ,TO_CHAR(dia,'YYYY') Ano
FROM
(
SELECT CONCAT(EXTRACT (YEAR FROM CURRENT_DATE)-2,'-01-01')::DATE + SEQUENCE.DAY AS dia
FROM GENERATE_SERIES(0, 1095) AS SEQUENCE (DAY)
)
