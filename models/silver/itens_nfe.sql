
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="silver") }}

with source_data as (

    select 
        "D2_DOC" as numero_nf
        ,"D2_TES" as tes
        ,"D2_CF" as cfop
        ,"D2_COD" as produto
        ,"D2_QUANT" as quantidade
        ,"D2_TOTAL"  as total
        ,"D2_VALIPI" as total_ipi
        ,"D2_ICMSRET" as total_icms
        ,"D2_SEGURO" as total_seguro
        ,"D2_VALFRE" as total_frete
        ,"D2_DESPESA" as  total_despesa
        ,"D_E_L_E_T_"
    from {{ source('bronze','SD2010')}}

)


select numero_nf, tes,cfop,produto,quantidade,total,total_despesa,total_frete,total_icms,total_ipi,total_seguro
from source_data
where "D_E_L_E_T_" <> '*'

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
