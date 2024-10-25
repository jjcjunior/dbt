
{{ config(materialized='table',schema="silver") }}

with source_data as (
    SELECT 
	"C7_NUM" numero_oc,
	"C7_EMISSAO" data_emissao, 
	"C7_FILIAL" filial, 
	"C7_ITEM" item, 
	"C7_PRODUTO" cod_produto, 
	"C7_UM" und_medida, 
	"C7_QUANT" qtd,
	"C7_PRECO" preco,
	"C7_TOTAL" valor_total,
	"C7_IPI" ipi,
	"C7_DATPRF" data_prevista,
	"D_E_L_E_T_" 
    FROM {{ source('bronze', 'SC7010')}}

)


select numero_oc, data_emissao, filial, item, cod_produto, und_medida, qtd, preco, valor_total, ipi, data_prevista
from source_data
where filial = '01' AND "D_E_L_E_T_" <> '*' AND SUBSTR(data_emissao,1,4) = '2021'
