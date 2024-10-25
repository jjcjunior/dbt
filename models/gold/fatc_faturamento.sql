
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="gold") }}


SELECT 
n.numero_nf, n.data_emissao,c.pk_cliente,pe.pedido,p.pk_produto,i.cfop,i.quantidade,i.total,i.total_ipi,i.total_icms,i.total_seguro,i.total_frete,i.total_despesa,
(i.total+i.total_ipi+i.total_icms+i.total_seguro+i.total_frete+i.total_despesa) as total_faturado
FROM {{ref('nfe')}} as n
INNER JOIN {{ref('itens_nfe')}} as i ON n.numero_nf = i.numero_nf
INNER JOIN {{ref('tipo_doc')}} as td ON td.codigo = i.tes
INNER JOIN {{ref('dim_produto')}} as p ON p.codigo = i.produto
INNER JOIN {{ref('dim_cliente')}} as c ON c.id = n.id_cliente
INNER JOIN {{ref('pedidos')}} as pe ON pe.nota_fiscal = n.numero_nf
WHERE n.data_emissao >= (CURRENT_DATE - INTERVAL '6 months')

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null



