
{{ config(materialized='table',schema="silver") }}

with source_data as (
    SELECT 
        "MUNICÍPIO BASE IBGE" as municipio, 
        "MESOREGIÃO IBGE" as mesoregiao,
        "uf" as uf,
        "Nº HABIT. REP." as num_habitante,
        "RENDA PERCAPITA" as renda_percp,
        "potencial" as potencial
    from {{ source('bronze','dna')}} 
)

select municipio,mesoregiao,uf,num_habitante,renda_percp,potencial,CONCAT(uf,REPLACE(municipio,' ','')) as id_municipio
from source_data
