
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table',schema="silver") }}

with source_data as (

    select 
            "C6_PRODUTO" produto
            ,"C6_NOTA" nota_fiscal
            ,"C6_DATFAT" data_fat
            ,"C6_NUM" pedido
            ,"C6_LOCAL" armazem
            ,"C6_QTDVEN" qtd_vendida
            ,"C6_ITEM" item
            ,"C6_QTDENT" qtd_entregue
            ,"C6_PRCVEN" valor_unit
            ,"C6_VALOR" valor_total
            ,"C6_CLI" cliente
            ,"C6_LOJA" loja_cliente
            ,"C6_BLQ" status_blq
            ,"C6_FILIAL" filial
            ,"C6_TES" tes
            ,"D_E_L_E_T_"
    from {{ source('bronze','SC6010')}}

)

select produto,nota_fiscal,data_fat,pedido,armazem,qtd_vendida,item,qtd_entregue,valor_unit,valor_total,concat(cliente,loja_cliente) as id_cliente,filial,status_blq,tes
from source_data
where "D_E_L_E_T_" = ' ' AND status_blq <> 'R'


/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
