
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="silver") }}

with source_data as (

    select 
            TO_DATE("C5_EMISSAO",'YYYYMMDD') data_emissao
            ,EXTRACT(YEAR FROM TO_DATE("C5_EMISSAO",'YYYYMMDD')) as ano_pedido
            ,"C5_CONDPAG" cond_pag
            ,"C5_VEND1" vendedor
            ,"C5_NOTA" nota_fiscal
            ,"C5_VEND2" apoio
            ,"C5_VEND3" apoio_pecas
            ,"C5_TPFRETE" tipo_frete
            ,"C5_ZFSAIDA" data_saida
            ,"C5_ZMENSPD" observacao
            ,"C5_ZFRETEC" valor_frete
            ,"C5_TRANSP" transportadora
            ,"C5_FILIAL" filial
            ,"C5_NUM" pedido
            ,"C5_TIPO" tipo_pedido
            ,"D_E_L_E_T_"
            ,EXTRACT(YEAR FROM CURRENT_DATE) AS ano_atual
    from {{ source('bronze','SC5010')}}

)


select pedido,nota_fiscal,tipo_pedido,data_emissao, cond_pag,vendedor,apoio,apoio_pecas,tipo_frete,data_saida,observacao,valor_frete, transportadora,filial,ano_pedido,ano_atual
from source_data
where "D_E_L_E_T_" <> '*' AND tipo_pedido = 'N' AND filial = '01' 


/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
