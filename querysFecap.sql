-- ALGUMAS EXEMPLOS DE QUERYS REALIZADAS NO BANCO DE DADOS DA FECAP --

/* TABELAS UTILIZADAS*/

-- PPESSOA
-- PFUNC
-- PFFINANC
-- PEVENTO
-- PFUNCAO
-- PSINDIC
-- PSECAO



-- Retornando todos funcionarios que são ativos e que tem o salário entre 1.000,00 a 1.300,00. Unindo 3 tabelas: PPESSOA, PFUNC e PFUNCAO.

SELECT PFUNC.CHAPA,
       PPESSOA.NOME,
       PFUNC.CODSITUACAO,
       PFUNC.SALARIO,
       PFUNC.CODFUNCAO,
       PFUNCAO.NOME,
       PPESSOA.DTNASCIMENTO, 
       PPESSOA.SEXO, 
       PPESSOA.CIDADE, 
       PPESSOA.CPF, 
       PPESSOA.TELEFONE1, 
       PPESSOA.TELEFONE2,
       PPESSOA.EMAIL
FROM PFUNC
LEFT JOIN PPESSOA
ON PFUNC.CODPESSOA = PPESSOA.CODIGO
LEFT JOIN PFUNCAO
ON PFUNCAO.CODIGO = PFUNC.CODFUNCAO
WHERE (PFUNC.SALARIO BETWEEN 1000.00  AND 1300.00) AND PFUNC.CODSITUACAO = 'A' AND PFUNC.CODRECEBIMENTO = 'M'
ORDER BY PFUNC.SALARIO ASC;

-- Abaixo um comando SQL que lista todos os funcionários do RM separados por departamento ( seção ), que estão ativos.

SELECT 
     PFUNC.CODPESSOA,
     PFUNC.NOME,
     PPESSOA.DTNASCIMENTO,
     PPESSOA.CPF,
     PFUNC.CODSITUACAO,
     PSECAO.CODIGO,
     PSECAO.CATEGORIA,
     PSECAO.DESCRICAO
 FROM PFUNC
 INNER JOIN PPESSOA 
 ON PPESSOA.CODIGO = PFUNC.CODPESSOA
 INNER JOIN PSECAO 
 ON PSECAO.CODCOLIGADA = PFUNC.CODCOLIGADA AND PSECAO.CODIGO = PFUNC.CODSECAO
 WHERE PFUNC.CODSITUACAO = 'A';

 -- Selecionando os dados da ficha financeira do ano de 2021 de 1 funcionário em especifíco.
  -- Ligando 3 tabelas: PFFINANC, PEVENTO e PFUNC.

SELECT PFFINANC.CHAPA, 
       PFUNC.NOME,
       PFFINANC.ANOCOMP, 
       PFFINANC.MESCOMP,
       PFFINANC.NROPERIODO,
       PFFINANC.CODEVENTO,
       PEVENTO.DESCRICAO,
       PEVENTO.provdescbase,
       PFFINANC.VALORORIGINAL
FROM PFFINANC
INNER JOIN PEVENTO
ON (PEVENTO.CODIGO = PFFINANC.CODEVENTO)
INNER JOIN PFUNC
ON PFUNC.CHAPA = PFFINANC.CHAPA
WHERE  (PFFINANC.ANOCOMP = 2021 AND  
        PFFINANC.VALORORIGINAL != 0  AND 
        PFFINANC.VALORORIGINAL IS NOT NULL AND
        PFFINANC.NROPERIODO = 3 AND
        PFUNC.CHAPA = 004990)
ORDER BY PFFINANC.MESCOMP, pevento.provdescbase;

-- Realizar uma consulta para retornar os colaboradores que são ativos  e o sindicato ao qual pertecem.
--Não trazer os colaboradores cujo codigo de recebimento é igual 'H'. 

SELECT 
    pfunc.chapa,
    ppessoa.nome, 
    ppessoa.estadocivil,
    ppessoa.sexo,
    pfunc.codsituacao,
    pfunc.codrecebimento, 
    pfunc.codsecao,
    pfunc.codsindicato,
    psindic.nome as NOMESINDICATO,
    pfunc.salario,
    pfunc.codbancopagto
FROM ppessoa
INNER JOIN pfunc
ON (ppessoa.codigo = pfunc.codpessoa)
INNER JOIN psindic
ON pfunc.codsindicato = psindic.codigo
WHERE (pfunc.codsituacao = 'A' AND 
       pfunc.codrecebimento != 'H'
    )
ORDER BY pfunc.codsindicato;

--  Busque na tabela PPESSOA todas as pessoas que tem seu endereço localizados no ITAIM PAULISTA.

SELECT ppessoa.nome,
       ppessoa.sexo,
       ppessoa.estadocivil,
       ppessoa.rua, 
       ppessoa.numero, 
       ppessoa.complemento,
       ppessoa.bairro, 
       ppessoa.estado,
       ppessoa.cep
FROM ppessoa
WHERE ppessoa.cep BETWEEN '08100-000' AND '08199-999'
ORDER BY ppessoa.rua;
 
-- Retorne da tabela PPESSOA a quantidade de pessoas por grau de instrução e agrupe pelo grau de instrução.

SELECT 
    ppessoa.grauinstrucao, COUNT(*)AS TOTAL
FROM ppessoa
GROUP BY ppessoa.grauinstrucao
HAVING ppessoa.grauinstrucao IS NOT NULL
ORDER BY TOTAL DESC;

-- Retorne o total de funcionários por seção, que não estão desligados.

SELECT 
  pfunc.codsecao,
  COUNT (*) AS TOTAL
FROM pfunc
INNER JOIN ppessoa
ON (pfunc.codpessoa = ppessoa.codigo)
WHERE (pfunc.codsituacao != 'D' AND
       pfunc.codrecebimento != 'H' 
        )
GROUP BY pfunc.codsecao
ORDER BY TOTAL DESC;


-- Abaixo um comando SQL que lista todos os funcionários do RM separados por departamento ( seção ).

SELECT 
     PFUNC.CODPESSOA,
     PFUNC.NOME,
     PPESSOA.DTNASCIMENTO,
     PPESSOA.CPF,
     PFUNC.CODSECAO,
     PSECAO.DESCRICAO AS SECAO
     
 FROM PFUNC
 INNER JOIN PPESSOA 
 ON (PPESSOA.CODIGO = PFUNC.CODPESSOA)
 INNER JOIN PSECAO 
 ON (PSECAO.CODCOLIGADA = PFUNC.CODCOLIGADA AND PSECAO.CODIGO = PFUNC.CODSECAO);

 -- Retornando todos os descontos que houveram na folha de pagamento de 01/2021.

 SELECT PFFINANC.CHAPA, 
       PFUNC.NOME,
       PFFINANC.ANOCOMP, 
       PFFINANC.MESCOMP,
       PFFINANC.NROPERIODO,
       PFFINANC.CODEVENTO,
       PEVENTO.DESCRICAO,
       PEVENTO.provdescbase,
       PFFINANC.VALORORIGINAL
FROM PFFINANC
INNER JOIN PEVENTO
ON (PEVENTO.CODIGO = PFFINANC.CODEVENTO)
INNER JOIN PFUNC
ON PFUNC.CHAPA = PFFINANC.CHAPA
WHERE  (PFFINANC.ANOCOMP = 2021 AND 
        PFFINANC.MESCOMP = 1 AND
        PFFINANC.VALORORIGINAL != 0  AND 
        PFFINANC.VALORORIGINAL IS NOT NULL AND
        PFFINANC.NROPERIODO = 3 AND 
        PEVENTO.PROVDESCBASE = 'D')
ORDER BY PFFINANC.MESCOMP, pevento.provdescbase;

-- Retornando todos os colaboradores que não estão demitidos, e que codrecebimento é diferente de AUTONOMOS. 

SELECT 
       PFUNC.CHAPA, 
       PPESSOA.NOME,
       PFUNC.CODSITUACAO,
       CASE PFUNC.CODSITUACAO
            WHEN 'A' THEN 'ATIVO'
            WHEN 'P' THEN 'AFASTADO PELA PREVIDÊNCIA SOCIAL'
            WHEN 'L' THEN 'LICENÇA SEM REMUNERAÇÃO'
            WHEN 'F' THEN 'FERIAS'
            WHEN 'C' THEN 'CONTRATO SUSPENSO'
            WHEN 'E' THEN 'LICENÇA MATERNIDADE'
            WHEN 'T' THEN 'APOSENTADORIA POR INVALIDEZ'
            ELSE 'OUTROS'
        END AS DESCRICAO,
       PFUNC.CODRECEBIMENTO,
       PFUNC.SALARIO,
       PFUNC.CODBANCOPAGTO,
       PFUNC.CODAGENCIAPAGTO,
       PFUNC.CONTAPAGAMENTO,
       PPESSOA.DTNASCIMENTO,
       PPESSOA.ESTADOCIVIL,
       PPESSOA.SEXO,
       PPESSOA.NACIONALIDADE,
       PPESSOA.ESTADO
FROM PPESSOA
INNER JOIN PFUNC
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
WHERE (PFUNC.CODSITUACAO != 'D' AND 
       PFUNC.CODRECEBIMENTO != 'H')
ORDER BY PFUNC.CODSITUACAO DESC;

-- Retornando alguns dados de todos os colaboradores que foram admitidos no ano de 2022.
-- Tabelas usadas: PPESSOA, PSECAO e PFUNC. 

SELECT PFUNC.CHAPA,
       PFUNC.NOME,
       PFUNC.CODSITUACAO,
       PFUNC.SALARIO,
       PFUNCAO.NOME,
       PSECAO.DESCRICAO,
       PFUNC.CODSECAO,
       PFUNC.DATAADMISSAO,
       SUBSTR(PFUNC.DATAADMISSAO, 7,8) AS ANOADMISSAO,
      
FROM PPESSOA
INNER JOIN PFUNC
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
INNER JOIN PSECAO 
ON PSECAO.CODCOLIGADA = PFUNC.CODCOLIGADA AND PSECAO.CODIGO = PFUNC.CODSECAO
INNER JOIN PFUNCAO
ON (PFUNC.CODFUNCAO = PFUNCAO.CODIGO)
WHERE (PFUNC.CODSITUACAO != 'D' AND 
       PFUNC.DATAADMISSAO BETWEEN '01/01/22' AND '31/12/22')
ORDER BY PSECAO.DESCRICAO, PFUNC.DATAADMISSAO;


-- Retornando todos os colaboradores que foram admitidos no ano de 2022.
-- Tabelas usadas: PPESSOA, PFUNC, PFUNCAO e PSECAO.


SELECT PFUNC.CHAPA,
       PFUNC.NOME,
       PPESSOA.DTNASCIMENTO,
       TRUNC((months_between(sysdate,PPESSOA.DTNASCIMENTO))/12) AS IDADE,
       PFUNC.CODSITUACAO,
       PFUNC.SALARIO,
       PFUNCAO.NOME,
       PSECAO.DESCRICAO,
       PFUNC.CODSECAO,
       PFUNC.DATAADMISSAO,
       SUBSTR(PFUNC.DATAADMISSAO, 7,8) AS ANOADMISSAO
FROM PPESSOA
INNER JOIN PFUNC
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
INNER JOIN PSECAO 
ON PSECAO.CODCOLIGADA = PFUNC.CODCOLIGADA AND PSECAO.CODIGO = PFUNC.CODSECAO
INNER JOIN PFUNCAO
ON (PFUNC.CODFUNCAO = PFUNCAO.CODIGO)
WHERE (PFUNC.CODSITUACAO != 'D' AND 
       PFUNC.DATAADMISSAO BETWEEN '01/01/22' AND '31/12/22')
ORDER BY IDADE;

-- Retornando todos os colaboradores que constam no RM e não demitidos.
-- Calculando idade.
-- Ordenando os dados por idade
-- Tabelas usadas: PPESSOA, PFUNC e PFUNCAO.

SELECT 
    PFUNC.CHAPA,
    PPESSOA.NOME,
    PPESSOA.SEXO,
    PFUNCAO.NOME AS CARGO,
    PPESSOA.DTNASCIMENTO,
    TRUNC((months_between(sysdate,PPESSOA.DTNASCIMENTO))/12) AS IDADE,
    PFUNC.CODRECEBIMENTO,
    PFUNC.CODSITUACAO
FROM PPESSOA
INNER JOIN PFUNC
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
INNER JOIN PFUNCAO
ON (PFUNC.CODFUNCAO = PFUNCAO.CODIGO)
WHERE PPESSOA.DTNASCIMENTO IS NOT NULL AND PFUNC.CODSITUACAO != 'D'
ORDER BY IDADE DESC;


-- Classificando os funcionários por idade que não são demitisos por idade.
-- Tabelas usadas: PPESSOA, PFUNC e PFUNCAO.
-- Usando o GROUP BY com ALIAS.    

SELECT 
    TRUNC((months_between(sysdate,PPESSOA.DTNASCIMENTO))/12) AS IDADE,
    COUNT(*) AS TOTAL_POR_IDADE
FROM PPESSOA
INNER JOIN PFUNC
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
INNER JOIN PFUNCAO
ON (PFUNC.CODFUNCAO = PFUNCAO.CODIGO)
WHERE PPESSOA.DTNASCIMENTO IS NOT NULL AND PFUNC.CODSITUACAO != 'D'
GROUP BY TRUNC((months_between(sysdate,PPESSOA.DTNASCIMENTO))/12)
ORDER BY TOTAL_POR_IDADE DESC;


-- Criando uma VIEW da consulta realizada acima. 
CREATE VIEW  VW_RENATOTESTE AS
SELECT 
    PFUNC.CHAPA,
    PPESSOA.NOME,
    PPESSOA.SEXO,
    PFUNCAO.NOME AS FUNCAO,
    PPESSOA.DTNASCIMENTO,
    TRUNC((months_between(sysdate,PPESSOA.DTNASCIMENTO))/12) AS IDADE,
    PFUNC.CODRECEBIMENTO,
    PFUNC.CODSITUACAO
FROM PPESSOA
INNER JOIN PFUNC
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
INNER JOIN PFUNCAO
ON (PFUNC.CODFUNCAO = PFUNCAO.CODIGO)
WHERE PPESSOA.DTNASCIMENTO IS NOT NULL AND PFUNC.CODSITUACAO != 'D';

-- Super Query SQL. Ela calcula o tempo de casa do funcionário e tem outras funbcionalidades.
-- Tabelas usadas: PPESSOA, PFUNC, PSINDIC e PSECAO.
SELECT 
    PFUNC.CHAPA,
    PPESSOA.NOME,
    PFUNC.CODRECEBIMENTO,
    PFUNC.DATAADMISSAO,
    TRUNC((months_between(sysdate,PFUNC.DATAADMISSAO))/12) AS TEMPOCASA,
    CASE
        WHEN TRUNC((months_between(sysdate,PFUNC.DATAADMISSAO))/12) BETWEEN '10' AND '15' THEN 'Adicional PRATA de 10 a 15 anos'
        WHEN TRUNC((months_between(sysdate,PFUNC.DATAADMISSAO))/12) BETWEEN '16' AND '20' THEN 'Adicional BRONZE 16 a 20 anos'
        WHEN TRUNC((months_between(sysdate,PFUNC.DATAADMISSAO))/12) BETWEEN '21' AND '30' THEN 'Adicional OURO 21 A 30 anos de casa'
        WHEN TRUNC((months_between(sysdate,PFUNC.DATAADMISSAO))/12) BETWEEN '31' AND '60' THEN 'Adicional DIAMANTE 31 A 50 anos de casa'
        ELSE 'Menor que 10 anos de casa'
    END AS TIPOFUNCIONARIO,
    PFUNC.CODSITUACAO,
    PFUNC.CODSECAO,
    PSECAO.DESCRICAO,
    PFUNC.CODSINDICATO,
    PSINDIC.NOME AS NOMESINDICATO,
    CASE 
        PSINDIC.MESDATABASE
        WHEN 3 THEN 'Março'
        ELSE 'NÃO É MARÇO'
    END MESDATABASE
FROM PFUNC
INNER JOIN PPESSOA
ON PFUNC.CODPESSOA = PPESSOA.CODIGO
INNER JOIN PSINDIC
ON PFUNC.CODSINDICATO = PSINDIC.CODIGO
INNER JOIN PSECAO
ON PSECAO.CODCOLIGADA = PFUNC.CODCOLIGADA AND PSECAO.CODIGO = PFUNC.CODSECAO
WHERE PFUNC.CODSITUACAO != 'D' AND 
      PFUNC.CODRECEBIMENTO != 'H'
ORDER BY TEMPOCASA DESC;


-- Criando uma VIEW para verificar o tempo de casa, dias do aviso e valor total de aviso que cada colaborador que está ativo tem direito a receber.


CREATE VIEW VW_RENATOTESTE AS
SELECT 
    PFUNC.CHAPA,
    PPESSOA.NOME,
    PFUNC.CODSITUACAO,
    PFUNC.DATAADMISSAO,
    PFUNC.SALARIO,
    (PFUNC.SALARIO / 30) AS VALORDIA, 
    TRUNC((months_between(sysdate, PFUNC.DATAADMISSAO))/12) AS TEMPODECASA,
    TRUNC((months_between(sysdate, PFUNC.DATAADMISSAO))/12) * 3 + 30 AS QUANTIDADEDIASAVISO
FROM PFUNC
INNER JOIN PPESSOA
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
WHERE PFUNC.CODSITUACAO = 'A' AND PFUNC.CODRECEBIMENTO = 'M';



SELECT CHAPA,
       NOME,
       CODSITUACAO,
       DATAADMISSAO,
       SALARIO,
       VALORDIA,
       TEMPODECASA,
       QUANTIDADEDIASAVISO,
       (SALARIO / 30) * QUANTIDADEDIASAVISO AS TOTALPASSIVOTRABALHISTA
FROM VW_RENATOTESTE;


SELECT * FROM VW_RENATOTESTE;









