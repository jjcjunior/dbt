
{{ config(materialized='table',schema="gold") }}

select 
    ROW_NUMBER () OVER ( ORDER BY  numero_oc ) as pk_ordem_compra,
    numero_oc,
    data_emissao, 
    filial, 
    item, 
    cod_produto, 
    und_medida, 
    qtd,
    preco,
    valor_total,
    ipi,
    data_prevista,
    CONCAT (numero_oc, item) id_oc_item
from {{ref('ordem_compra')}}