
{{ config(materialized='table',schema="gold") }}

SELECT 
c.pk_cliente
,nf.numero_ficha
,nf.numero_reduz
,nf.revisao
,nf.classificacao
,nf.prioridade
,nf.situacao
,p.pk_produto
,nf.numero_serie
,nf.garantia
,nf.tipo_atendimento
,nf.rat
,nf.cod_origem
,nf.cod_comentario
,nf.cod_efeito
,nf.cod_categoria
,nf.cod_corretiva
,nf.usuario
,nf.data_registro
,nf.data_conclusao
,nf.status
,g.cod_produto
,g.quantidade
,g.tipo_item
,nf.contato_cf
,nf.fone_cf
,nf.km
,nf.vl_mao_obra
,nf.vl_despesas
,nf.data_pagamento_mo
FROM {{ref('nao_conformidade')}} as nf
INNER JOIN {{ref('dim_produto')}} as p ON p.codigo = nf.produto 
INNER JOIN {{ref('dim_cliente')}} as c ON c.codigo = nf.cod_cliente AND c.loja = nf.loja_cliente
INNER JOIN {{ref('dim_usuario_ncf')}} as u ON u.codigo = nf.usuario
INNER JOIN {{ref('classificacao_ncf')}} as efeitos ON efeitos.codigo = nf.cod_efeito
INNER JOIN {{ref('classificacao_ncf')}} as categoria ON categoria.codigo = nf.cod_categoria
INNER JOIN {{ref('classificacao_ncf')}} as origem ON origem.codigo = nf.cod_origem
LEFT JOIN {{ref('garantias_ncf')}} as g ON g.codigo_ncf = nf.numero_ficha