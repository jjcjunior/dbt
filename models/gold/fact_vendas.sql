
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="gold") }}


SELECT t.pk_transportadora,c.pk_cliente, pr.pk_produto,v.pk_vendedor, v2.pk_vendedor as pk_apoio, v3.pk_vendedor as pk_apoio_pecas, i.nota_fiscal , data_emissao ,i.data_fat, i.pedido , TRIM(i.armazem) as armazem, i.qtd_vendida, 
i.item,i.qtd_entregue, ROUND(i.valor_unit,2) valor_unit, i.valor_total , p.cond_pag,p.tipo_frete, p.data_saida ,
TRIM(p.observacao) observacao,ROUND(p.valor_frete,2)
FROM {{ref('itens_pedido')}} as i
INNER JOIN {{ref('pedidos')}} as p ON i.filial = p.filial AND i.pedido = p.pedido
INNER JOIN {{ref('tipo_doc')}} as td ON td.codigo = i.tes
INNER JOIN {{ref('dim_cliente')}} as c ON i.id_cliente = c.id
INNER JOIN {{ref('dim_transportadora')}} as t ON p.transportadora = t.codigo
INNER JOIN {{ref('dim_produto')}} as pr ON i.produto = pr.codigo
INNER JOIN {{ref('dim_vendedor')}} as v ON p.vendedor = v.codigo
LEFT JOIN {{ref('dim_vendedor')}} as v2 ON p.apoio = v2.codigo
LEFT JOIN {{ref('dim_vendedor')}} as v3 ON p.apoio_pecas = v3.codigo
WHERE p.filial = '01' AND p.tipo_pedido = 'N' AND i.status_blq <> 'R' AND (p.ano_pedido BETWEEN (p.ano_atual -2)  AND p.ano_atual)

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null



