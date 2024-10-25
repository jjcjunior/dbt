{{ config(materialized='table',schema="gold") }}

select ROW_NUMBER () OVER ( ORDER BY COD  ) as pk_fornecedor, 
    f.ID_FORNECEDOR,
    f.COD,
    f.LOJA,
    f.NOME, 
    f.NOME_REDUZ,
    f.CNPJ_CPF,
    ct.genero_cert,
    ct.validade_cert,
    ct.nome_arquivo, 
    ct.diretorio_arquivo
from {{ref('fornecedor')}} f
LEFT OUTER join {{ref('dim_cert_status')}} ct on ct.cod_fornecedor = f.id_fornecedor
