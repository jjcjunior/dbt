
{{ config(materialized='table',schema="gold") }}

select
        f.pk_fornecedor, 
        prod.pk_produto, 
        fun.pk_funcionario, 
        oc.pk_ordem_compra, 
        DB3.qtd_aprov, 
        DB3.rir, 
        DB3.validade, 
        DB3.certificado,
        DB3.num_oc, 
        DB3.item_oc, 
        oc.data_prevista,
        DB2.num_fiscal,
        DB2.data_nf, 
        DB1.data_entrada, 
        DB3.qtd_recebida, 
        DB1.data_reg,
        DB1.hora_entrada
from {{ref('itens_avisrec')}} DB3
INNER JOIN {{ref('avisrec_carga')}} DB1 ON DB1.NRAVRC = DB3.NRAVRC
INNER JOIN {{ref('doc_recebimento')}} DB2 ON DB2.NRAVRC = DB3.NRAVRC 
INNER JOIN {{ref('ordem_compra')}} C7 ON DB3.NUM_OC = C7.numero_oc AND DB3.item_oc = C7.ITEM 
INNER JOIN {{ref('dim_fornecedor')}} f on f.id_fornecedor =  DB2.id_fornecedor
LEFT OUTER JOIN {{ref('dim_produto')}} prod on prod.codigo = db3.cod_produto
LEFT OUTER JOIN {{ref('funcionario')}} fun on fun.cod_func = db2.cod_func
INNER JOIN {{ref('fact_ordem_compra')}} oc on oc.id_oc_item = DB3.ID_OC_ITEM