
{{ config(materialized='table',schema="silver") }}

with source_data as (
    SELECT 
        "QI2_FNC" AS numero_ficha, 
		"QI2_ZRFNC" AS numero_reduz, 
		"QI2_REV" AS revisao, 
		"QI2_TPFIC" AS classificacao,
		"QI2_PRIORI" AS prioridade, 
        "QI2_LOJCLI" AS loja_cliente,
        "QI2_CODCLI" AS cod_cliente,
        "QI2_CODPRO" as produto,
		"QI2_STATUS" AS situacao, 
		"QI2_ZZSERI" AS numero_serie, 
		trim("QI2_ZZGAR") AS garantia, 
		"QI2_ZZTPAT" AS tipo_atendimento, 
		"QI2_ZZ0S" AS rat, 
		"QI2_CODORI" AS cod_origem,
		"QI2_DDETA" AS cod_comentario, 
		"QI2_CODEFE" AS cod_efeito, 
		"QI2_CODCAT" AS cod_categoria, 
		"QI2_CODACA" AS cod_corretiva, 
		"QI2_MAT" AS usuario, 
		"QI2_REGIST" AS data_registro, 
		"QI2_CONREA" AS data_conclusao, 
		TRIM("QI2_CONREA") AS status, 
		"QI2_CONTAT" AS contato_cf, 
		"QI2_FONE" AS fone_cf,
		"QI2_ZZKM" AS km, 
		"QI2_ZZVMO" AS vl_mao_obra, 
		"QI2_ZZVOD" AS vl_despesas, 
		"QI2_ZZDPMO" AS data_pagamento_mo,
		EXTRACT(YEAR FROM TO_DATE("QI2_REGIST",'YYYYMMDD')) AS ano,
		EXTRACT(YEAR FROM CURRENT_DATE ) AS ano_atual,
        "D_E_L_E_T_"
    from {{ source('bronze','QI2010')}} 
)
SELECT numero_ficha
        ,numero_reduz
        ,revisao
        ,(CASE 
            WHEN classificacao = '1' THEN 'POTENCIAL' 
            WHEN classificacao = '2' THEN 'EXISTENTE' 
            WHEN classificacao = '3' THEN 'MELHORIA' END) as classificacao
        ,(CASE 
            WHEN prioridade = '1' THEN 'BAIXA' 
            WHEN prioridade = '2' THEN 'MEDIA' 
            WHEN prioridade = '3' THEN 'ALTA' END) as prioridade
        ,(CASE 
            WHEN situacao = '1' THEN 'REGISTRADA' 
            WHEN situacao = '2' THEN 'EM ANALISE' 
            WHEN situacao = '3' THEN 'PROCEDE'
            WHEN situacao = '4' THEN 'NAO PROCEDE'
            WHEN situacao = '5' THEN 'CANCELADA' END) as situacao
        ,loja_cliente
        ,cod_cliente
        ,produto
        ,numero_serie
        ,(CASE 
            WHEN garantia = 'S' THEN 'SIM' 
            WHEN garantia = 'N' THEN 'NAO' 
            WHEN garantia = 'B' THEN 'BONIFICACAO' END) as garantia
        ,(CASE 
            WHEN tipo_atendimento = 'D' THEN 'DEVOLUCAO'
            WHEN tipo_atendimento = 'R' THEN 'RECLAMACAO'
            WHEN tipo_atendimento = 'S' THEN 'SUGESTAO'
            WHEN tipo_atendimento = 'O' THEN 'OUTROS' END) AS tipo_atendimento
        ,CASE 
            WHEN split_part(TRIM(rat),' ',1) = 'REF' THEN TRIM(rat)
            WHEN (TRANSLATE(TRIM(rat),'SR/ATNFE,. ',' ') = ' ' or TRANSLATE(TRIM(rat),'SR/ATNFE,. ','') = '') THEN 'NAO INFORMADO' 
            ELSE TRANSLATE(TRIM(rat),'SR/ATNFE,. ',' ')  END as rat
        ,cod_origem
        ,cod_comentario
        ,cod_efeito
        ,cod_categoria
        ,cod_corretiva
        ,usuario
        ,data_registro
        ,data_conclusao
        ,(CASE WHEN status IS NULL THEN 'Pendente' ELSE 'Concluido' END) AS status
        ,contato_cf
        ,fone_cf
        ,km
        ,vl_mao_obra
        ,vl_despesas
        ,data_pagamento_mo
FROM source_data
where ("D_E_L_E_T_" <> '*' OR "D_E_L_E_T_" = ' ')  AND revisao = '00' and (ano BETWEEN ano_atual-2 AND ano_atual)
