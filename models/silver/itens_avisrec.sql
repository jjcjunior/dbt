{{ config(materialized='table',schema="silver") }}

with source_data as (
    SELECT 
        "DB3_CODPRO" COD_PRODUTO, 
        "DB3_QTDAPR" QTD_APROV, 
        CONCAT("DB3_NRAVRC","DB3_ITEM") as RIR, 
        "DB3_DTVALD" VALIDADE, 
        "DB3_CERTIF" CERTIFICADO, 
        "DB3_NUMPC" NUM_OC, 
        "DB3_ITEMPC" ITEM_OC ,
        "DB3_QUANT" QTD_RECEBIDA,
        CONCAT("DB3_NUMPC", "DB3_ITEMPC") ID_OC_ITEM,
        "DB3_NRAVRC" NRAVRC,
        "D_E_L_E_T_"
    from {{ source('bronze','DB3010')}}

)
select cod_produto,qtd_aprov,rir,validade,certificado,num_oc,item_oc,qtd_recebida,nravrc , id_oc_item
from source_data 
where "D_E_L_E_T_" <> '*'
