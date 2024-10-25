
{{ config(materialized='table',schema="silver") }}

with source_data as (
    SELECT 
        CONCAT("DB2_CLIFOR","DB2_LOJA") as ID_FORNECEDOR, 
        "DB2_DOC" NUM_FISCAL, 
        "DB2_EMISSA" DATA_NF, 
        "DB2_FILIAL" filial,
        "DB2_NRAVRC" NRAVRC,
        "D_E_L_E_T_",
        TRIM(TO_CHAR("DB2_CRACHA",'000000')) COD_FUNC 
    from {{ source('bronze', 'DB2010')}} 
)


select id_fornecedor,num_fiscal,data_nf,filial,nravrc,cod_func
from source_data
where filial = '01' AND "D_E_L_E_T_" <> '*' 
