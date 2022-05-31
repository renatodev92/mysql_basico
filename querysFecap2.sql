-- ALGUMAS EXEMPLOS DE QUERYS REALIZADAS NO BANCO DE DADOS DA FECAP --

/* TABELAS UTILIZADAS*/

-- PPESSOA
-- PFUNC
-- PFFINANC
-- PEVENTO
-- PFUNCAO
-- PSINDIC
-- PSECAO
-- AHORARIO
-- PFHSTHOR

-- Query retorna o cargo de todos os colaboradores que não estão desligados e agrupa por sexo e quantidade de cargos.
-- Tabelas: PPESSOA, PFUNC e PFUNC.

SELECT 
    PFUNCAO.NOME,
    PPESSOA.SEXO,
    COUNT(PFUNCAO.NOME) AS TOTAL
FROM
PPESSOA
INNER JOIN PFUNC
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
INNER JOIN PFUNCAO
ON PFUNC.CODFUNCAO = PFUNCAO.CODIGO
WHERE PFUNC.CODSITUACAO != 'D' AND PFUNC.CODRECEBIMENTO != 'H'
GROUP BY PFUNCAO.NOME, PPESSOA.SEXO
ORDER BY PFUNCAO.NOME DESC;

-- Query retorna o tempo de casa de cada colaborador e traz uma coluna com o pagamento do adicional por tempodecasa.

SELECT 
    PFUNC.CHAPA,
    PPESSOA.NOME,
    PFUNCAO.NOME AS CARGO,
    PFUNC.DATAADMISSAO,
    PFUNC.CODSITUACAO,
    PFUNC.CODRECEBIMENTO,
    PFUNC.SALARIO,
    TRUNC((MONTHS_BETWEEN(SYSDATE,PFUNC.DATAADMISSAO))/12) AS TEMPODECASA,
    CASE
        WHEN TRUNC((MONTHS_BETWEEN(SYSDATE,PFUNC.DATAADMISSAO))/12) BETWEEN 1 AND 10 THEN 5
        WHEN TRUNC((MONTHS_BETWEEN(SYSDATE,PFUNC.DATAADMISSAO))/12) BETWEEN 10 AND 20 THEN 10
        WHEN TRUNC((MONTHS_BETWEEN(SYSDATE,PFUNC.DATAADMISSAO))/12) BETWEEN 20 AND 30 THEN 13
        WHEN TRUNC((MONTHS_BETWEEN(SYSDATE,PFUNC.DATAADMISSAO))/12) BETWEEN 30 AND 100 THEN 17
        ELSE 0
    END AS PERCADICONALTEMPODECASA,
     CASE
        WHEN TRUNC((MONTHS_BETWEEN(SYSDATE,PFUNC.DATAADMISSAO))/12) BETWEEN  1 AND 10 THEN  TRUNC ((PFUNC.SALARIO * 0.05),2)
        WHEN TRUNC((MONTHS_BETWEEN(SYSDATE,PFUNC.DATAADMISSAO))/12) BETWEEN 10 AND 20 THEN  TRUNC ((PFUNC.SALARIO * 0.10),2)
        WHEN TRUNC((MONTHS_BETWEEN(SYSDATE,PFUNC.DATAADMISSAO))/12) BETWEEN 20 AND 30 THEN  TRUNC ((PFUNC.SALARIO * 0.13),2)
        WHEN TRUNC((MONTHS_BETWEEN(SYSDATE,PFUNC.DATAADMISSAO))/12) BETWEEN 30 AND 100 THEN TRUNC ((PFUNC.SALARIO * 0.17),2)
        ELSE 0
    END AS VALORADICIONAL,
    4 AS ANTECIPACAOSALARIAL2022
FROM PPESSOA
INNER JOIN PFUNC
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
INNER JOIN PFUNCAO
ON PFUNC.CODFUNCAO = PFUNCAO.CODIGO
WHERE PFUNC.CODSITUACAO IN ('A', 'F', 'P') AND PFUNC.CODRECEBIMENTO = 'M'
ORDER BY SALARIO;


-- Query retorna o total de funcionários não desligados por horário.
-- Tabelas: PFUNC e AHORARIO

SELECT PFUNC.CODHORARIO,
       COUNT(PFUNC.CODHORARIO) AS TOTALPORHORARIO 
FROM PFUNC
INNER JOIN AHORARIO
ON PFUNC.CODHORARIO = AHORARIO.CODIGO
WHERE (
        PFUNC.CODSITUACAO IN ('A', 'F', 'P') AND 
        PFUNC.CODRECEBIMENTO = 'M'
       )
GROUP BY PFUNC.CODHORARIO
ORDER BY TOTALPORHORARIO DESC;

-- Query retorna o histórico de alteração de horário de todos os colaboradores do tipo 'M'(mensalista) e que estão com a situação diferente de 'D' (desligado).

SELECT 
    PFHSTHOR.CHAPA,
    PFUNC.NOME,
    PFUNCAO.NOME AS DESCRICAO,
    PFUNC.CODSITUACAO,
    PFHSTHOR.DTMUDANCA,
    TRUNC((PFUNC.JORNADAMENSAL / 60),2) AS JORNADAMESAL,
    PFHSTHOR.CODHORARIO,
    AHORARIO.DESCRICAO,
    PFHSTHOR.RECMODIFIEDBY AS ALTERACAOUSUARIO
FROM PFHSTHOR
INNER JOIN AHORARIO
ON PFHSTHOR.CODHORARIO = AHORARIO.CODIGO
INNER JOIN PFUNC
ON  PFHSTHOR.CHAPA = PFUNC.CHAPA
INNER JOIN PFUNCAO
ON PFUNC.CODFUNCAO = PFUNCAO.CODIGO
WHERE PFUNC.CODSITUACAO != 'D' AND PFUNC.CODRECEBIMENTO = 'M'
ORDER BY PFUNC.NOME, PFHSTHOR.DTMUDANCA DESC;

-- Query retorna a quantidade de alterações de horário que foi realizada por cada colaborador, e conta quantas alterações de horário cada um deles teve.

SELECT 
    PFHSTHOR.CHAPA,
    COUNT(PFHSTHOR.DTMUDANCA) AS QUATIDADEDEALTERACAO
FROM PFHSTHOR
INNER JOIN AHORARIO
ON PFHSTHOR.CODHORARIO = AHORARIO.CODIGO
INNER JOIN PFUNC
ON  PFHSTHOR.CHAPA = PFUNC.CHAPA
INNER JOIN PFUNCAO
ON PFUNC.CODFUNCAO = PFUNCAO.CODIGO 
WHERE PFUNC.CODSITUACAO != 'D' AND PFUNC.CODRECEBIMENTO = 'M'
GROUP BY PFHSTHOR.CHAPA
ORDER BY QUATIDADEDEALTERACAO DESC;

-- Retornando todos os funcionários que não são desligados, que são mensalistas, trazendo a carga horária e o horário que cada um possui.
-- Agrupando por seção.

SELECT
    PFUNC.CHAPA,
    PPESSOA.NOME,
    PFUNC.CODSITUACAO,
    PFUNC.CODRECEBIMENTO,
    PFUNCAO.NOME AS CARGO,
    PFUNC.CODSECAO,
    PSECAO.DESCRICAO,
    PFUNC.CODHORARIO,
    AHORARIO.DESCRICAO,
    TRUNC((PFUNC.JORNADAMENSAL / 60),2) AS CARGAHORARIAMENSAL
FROM PPESSOA
INNER JOIN PFUNC
ON PPESSOA.CODIGO = PFUNC.CODPESSOA
INNER JOIN PFUNCAO
ON PFUNCAO.CODIGO = PFUNC.CODFUNCAO
INNER JOIN AHORARIO
ON PFUNC.CODHORARIO = AHORARIO.CODIGO
INNER JOIN PSECAO
ON PFUNC.CODSECAO = PSECAO.CODIGO
WHERE PFUNC.CODSITUACAO IN ('A', 'P', 'F', 'E') AND PFUNC.CODRECEBIMENTO = 'M'
ORDER BY PFUNC.CODHORARIO, PSECAO.DESCRICAO;

-- Retornando todos os colaboradores desligados em '01/01/2021 até a data atual. Usando a função SYSDATE (RETORNA A DATA ATUAL DO SISTEMA).
SELECT 
    PFUNC.CHAPA,
    PFUNC.NOME,
    PFUNC.CODSITUACAO, 
    PFUNCAO.DESCRICAO,
    PFUNC.DATAADMISSAO,
    PFUNC.DATADEMISSAO,
    PFUNC.TIPODEMISSAO,
    CASE PFUNC.TIPODEMISSAO
        WHEN '4' THEN 'Pedido de demissão'
        WHEN '2' THEN 'Dispensa s/ justa causa pelo empregador'
        WHEN '1' THEN 'Dispensa c/ justa causa pelo empregador'
        WHEN 'T' THEN 'Término de contrato'
        WHEN '8' THEN 'Óbito'
        WHEN 'V' THEN 'Comum acordo'
    END DESCRICAO
FROM PFUNC
INNER JOIN PFUNCAO
ON PFUNC.CODFUNCAO = PFUNCAO.CODIGO
WHERE DATADEMISSAO BETWEEN '01/01/21' AND SYSDATE
ORDER BY DATADEMISSAO;

--Retorna o total de desligados de 01/01/2021 até a data atual.

SELECT 
    COUNT(PFUNC.TIPODEMISSAO) AS TOTALDESLIGADOS
FROM PFUNC
WHERE (
    PFUNC.TIPODEMISSAO IS NOT NULL AND
    PFUNC.DATADEMISSAO BETWEEN '01/01/21' AND SYSDATE
);

-- Retorna o total de desligados por tipo de demissão de '01/01/2021 até a data atual.

SELECT 
    PFUNC.TIPODEMISSAO,
    COUNT(PFUNC.TIPODEMISSAO) AS TURNOVER
FROM PFUNC
WHERE (
    PFUNC.TIPODEMISSAO IS NOT NULL AND
    PFUNC.DATADEMISSAO BETWEEN '01/01/21' AND SYSDATE
)
GROUP BY PFUNC.TIPODEMISSAO;

-- Retorna o total de admitidos de '01/01/2021 até a data atual.
SELECT
    COUNT(DATAADMISSAO) AS TOTALENTRADA
FROM PFUNC
WHERE PFUNC.DATAADMISSAO BETWEEN '01/01/21' AND SYSDATE;

-- Retonando todos os funcionários do tipo M trazendo os horários de cada um que se encontra nas situações IN ('ATIVO', 'FÉRIAS', 'AFASTADO PELA PREVIDÊNCIA', 'LICENÇA MATERNIDADE').
-- Tabelas
SELECT 
      PFUNC.CHAPA,
      PFUNC.NOME,
      PFUNC.CODRECEBIMENTO,
      PFUNC.DATAADMISSAO,
      PFUNC.CODSITUACAO,
      PFUNCAO.NOME AS CARGO,
      PFUNC.CODSECAO,
      PSECAO.DESCRICAO,
      PFUNC.CODHORARIO,
      AHORARIO.DESCRICAO AS DESCHORARIO
FROM PFUNC
INNER JOIN PSECAO
ON PFUNC.CODSECAO = PSECAO.CODIGO
INNER JOIN PFUNCAO
ON PFUNC.CODFUNCAO = PFUNCAO.CODIGO
INNER JOIN AHORARIO
ON PFUNC.CODHORARIO = AHORARIO.CODIGO
WHERE PFUNC.CODSITUACAO IN('A', 'F', 'P', 'E') AND PFUNC.CODRECEBIMENTO = 'M'
ORDER BY PFUNC.CODHORARIO, PFUNC.CODSECAO;

-- Retornando todos os valores que um funcionário recebeu de um eventop especifíco com base na ficha financeira.
SELECT 
    PFFINANC.CHAPA,
    PFUNC.NOME,
    PFFINANC.DTPAGTO,
    PFUNC.CODSITUACAO,
    PFFINANC.ANOCOMP,
    PFFINANC.MESCOMP,
    PFFINANC.NROPERIODO,
    PFFINANC.CODEVENTO,
    PFFINANC.VALORORIGINAL
FROM PFUNC
INNER JOIN PFFINANC
ON PFUNC.CHAPA = PFFINANC.CHAPA
WHERE PFUNC.CHAPA = 004990 AND PFFINANC.CODEVENTO = 0010 AND PFFINANC.NROPERIODO = 3
ORDER BY PFFINANC.ANOCOMP, PFFINANC.MESCOMP;

-- Retornando os dados bancários dos funcionário do TIPO P e M que são CLT.
SELECT 
     PFUNC.CHAPA,
     PFUNC.NOME,
     PFUNC.DATAADMISSAO,
     PFUNC.CODSITUACAO AS SITUACAO,
     PFUNC.CODRECEBIMENTO,
     PSECAO.DESCRICAO AS DEPARTAMENTO,
     PFUNCAO.NOME AS CARGO,
     PPESSOA.TELEFONE1,
     PPESSOA.TELEFONE2,
     PPESSOA.EMAILPESSOAL,
     PFUNC.CODBANCOPAGTO AS BANCO,
     PFUNC.CODAGENCIAPAGTO AS AGENCIA,
     PFUNC.CONTAPAGAMENTO AS CONTA
FROM PFUNC
LEFT JOIN PPESSOA
ON PFUNC.CODPESSOA = PPESSOA.CODIGO
INNER JOIN PSECAO
ON PFUNC.CODSECAO = PSECAO.CODIGO
INNER JOIN PFUNCAO
ON PFUNC.CODFUNCAO = PFUNCAO.CODIGO
WHERE PFUNC.CODSITUACAO != 'D'
      AND PFUNC.CODRECEBIMENTO != 'H'
ORDER BY PSECAO.DESCRICAO, PFUNC.NOME;

-- Retornando todos os eventos programados que estão no cadastro do colaborador a partir de 1 ano em especifíco.

SELECT PFUNC.CHAPA,
       PFUNC.NOME,
       PFUNC.CODRECEBIMENTO,
       CASE PFUNC.CODSITUACAO
         WHEN 'A' THEN 'Ativo'
         WHEN 'D' THEN 'Demitido'
         WHEN 'E' THEN 'Licenç.Mater.'
         WHEN 'F' THEN 'Férias'
         WHEN 'I' THEN 'Apos. por Incapacidade Permanente'
         WHEN 'L' THEN 'Licença s/ venc'
         WHEN 'M' THEN 'Serv.Militar'
         WHEN 'O' THEN 'Doença Ocupacional'
         WHEN 'P' THEN 'Af.Previdência'
         WHEN 'R' THEN 'Licença Remun.'
         WHEN 'S' THEN 'Mandato Sindical Ônus do Sindicato'
         WHEN 'T' THEN 'Af.Ac.Trabalho'
         WHEN 'U' THEN 'Outros'
         WHEN 'V' THEN 'Aviso Prévio'
         WHEN 'X' THEN 'C/Dem.no mês'
         WHEN 'Z' THEN 'Admissão prox.mês'
         WHEN 'W' THEN 'Licença Mater.Compl. 180 dias'
         WHEN 'C' THEN 'Contrato de Trabalho Suspenso'
         WHEN 'N' THEN 'Mandato Sindical Ônus do Empregador'
         WHEN 'G' THEN 'Recesso Remunerado de Estagio'
         WHEN 'Y' THEN 'Licença Paternidade'
         WHEN 'K' THEN 'Cessão / Requisição'
         WHEN 'Q' THEN 'Prisão / Cárcere'
         ELSE 'VERIFICAR NOVA SISTUAÇÃO.'
       END                    AS SITUACAO,
       PSECAO.DESCRICAO       AS SECAO,
       PFUNCAO.NOME           AS CARGO,
       PFCODFIX.CODEVENTO,
       PEVENTO.DESCRICAO      AS NOMEEVENTO,
       PFCODFIX.VALOR,
       PFCODFIX.NROVEZES,
       PFCODFIX.RECCREATEDBY  AS USUARIOCRIACAO,
       PFCODFIX.RECCREATEDON  AS DATACRIACAO,
       PFCODFIX.RECMODIFIEDBY AS MODIFICADOPOR,
       PFCODFIX.RECMODIFIEDON AS DATAULTIMAMODIFICAO
FROM   PFCODFIX
       LEFT JOIN PFUNC
              ON PFCODFIX.CHAPA = PFUNC.CHAPA
       INNER JOIN PEVENTO
               ON PEVENTO.CODIGO = PFCODFIX.CODEVENTO
       INNER JOIN PFUNCAO
               ON PFUNC.CODFUNCAO = PFUNCAO.CODIGO
       INNER JOIN PSECAO
               ON PFUNC.CODSECAO = PSECAO.CODIGO
WHERE  PFUNC.CODSITUACAO != 'D'
       AND PFUNC.CODRECEBIMENTO != 'H'
ORDER  BY PFUNC.NOME,
          PFCODFIX.CODEVENTO;


-- -- Retornando todos os códigos fixos do cadastro dos colaboradores.

SELECT PFUNC.CHAPA,
       PFUNC.NOME,
       PFUNC.CODRECEBIMENTO,
       CASE PFUNC.CODSITUACAO
         WHEN 'A' THEN 'Ativo'
         WHEN 'D' THEN 'Demitido'
         WHEN 'E' THEN 'Licenç.Mater.'
         WHEN 'F' THEN 'Férias'
         WHEN 'I' THEN 'Apos. por Incapacidade Permanente'
         WHEN 'L' THEN 'Licença s/ venc'
         WHEN 'M' THEN 'Serv.Militar'
         WHEN 'O' THEN 'Doença Ocupacional'
         WHEN 'P' THEN 'Af.Previdência'
         WHEN 'R' THEN 'Licença Remun.'
         WHEN 'S' THEN 'Mandato Sindical Ônus do Sindicato'
         WHEN 'T' THEN 'Af.Ac.Trabalho'
         WHEN 'U' THEN 'Outros'
         WHEN 'V' THEN 'Aviso Prévio'
         WHEN 'X' THEN 'C/Dem.no mês'
         WHEN 'Z' THEN 'Admissão prox.mês'
         WHEN 'W' THEN 'Licença Mater.Compl. 180 dias'
         WHEN 'C' THEN 'Contrato de Trabalho Suspenso'
         WHEN 'N' THEN 'Mandato Sindical Ônus do Empregador'
         WHEN 'G' THEN 'Recesso Remunerado de Estagio'
         WHEN 'Y' THEN 'Licença Paternidade'
         WHEN 'K' THEN 'Cessão / Requisição'
         WHEN 'Q' THEN 'Prisão / Cárcere'
         ELSE 'VERIFICAR NOVA SITUAÇÃO.'
       END                    AS SITUACAO,
       PSECAO.DESCRICAO       AS SECAO,
       PFUNCAO.NOME           AS CARGO,
       PFCODFIX.CODEVENTO,
       PEVENTO.DESCRICAO      AS NOMEEVENTO,
       PFCODFIX.VALOR,
       PFCODFIX.NROVEZES,
       PFCODFIX.RECCREATEDBY  AS USUARIOCRIACAO,
       PFCODFIX.RECCREATEDON  AS DATACRIACAO,
       PFCODFIX.RECMODIFIEDBY AS MODIFICADOPOR,
       PFCODFIX.RECMODIFIEDON AS DATAULTIMAMODIFICAO
FROM   PFCODFIX
       LEFT JOIN PFUNC
              ON PFCODFIX.CHAPA = PFUNC.CHAPA
       INNER JOIN PEVENTO
               ON PEVENTO.CODIGO = PFCODFIX.CODEVENTO
       INNER JOIN PFUNCAO
               ON PFUNC.CODFUNCAO = PFUNCAO.CODIGO
       INNER JOIN PSECAO
               ON PFUNC.CODSECAO = PSECAO.CODIGO
WHERE  PFUNC.CODSITUACAO != 'D'
       AND PFUNC.CODRECEBIMENTO != 'H'
ORDER  BY PFUNC.NOME,
          PFCODFIX.CODEVENTO;


/* -- Query compara individualmente a folha mês anterior X mês atual, com base nos parâmetros.
--Parametros:

-- :ANO_ATUAL
-- :MES_ATUAL
-- :PERIODO_ATUAL

-- :ANO_ANTERIOR
-- :MES_ANTERIOR
-- :PERIODO_ANTERIOR

-- :CHAPA */


SELECT A.CHAPA,
       A.NOME,
       A.DATAADMISSAO,
       CASE A.CODSITUACAO
         WHEN 'A' THEN 'Ativo'
         WHEN 'D' THEN 'Demitido'
         WHEN 'E' THEN 'Licenç.Mater.'
         WHEN 'F' THEN 'Férias'
         WHEN 'I' THEN 'Apos. por Incapacidade Permanente'
         WHEN 'L' THEN 'Licença s/ venc'
         WHEN 'M' THEN 'Serv.Militar'
         WHEN 'O' THEN 'Doença Ocupacional'
         WHEN 'P' THEN 'Af.Previdência'
         WHEN 'R' THEN 'Licença Remun.'
         WHEN 'S' THEN 'Mandato Sindical Ônus do Sindicato'
         WHEN 'T' THEN 'Af.Ac.Trabalho'
         WHEN 'U' THEN 'Outros'
         WHEN 'V' THEN 'Aviso Prévio'
         WHEN 'X' THEN 'C/Dem.no mês'
         WHEN 'Z' THEN 'Admissão prox.mês'
         WHEN 'W' THEN 'Licença Mater.Compl. 180 dias'
         WHEN 'C' THEN 'Contrato de Trabalho Suspenso'
         WHEN 'N' THEN 'Mandato Sindical Ônus do Empregador'
         WHEN 'G' THEN 'Recesso Remunerado de Estagio'
         WHEN 'Y' THEN 'Licença Paternidade'
         WHEN 'K' THEN 'Cessão / Requisição'
         WHEN 'Q' THEN 'Prisão / Cárcere'
         ELSE 'VERIFICAR NOVA SITUAÇÃO.'
       END               AS SITUACAO,
       A.CODRECEBIMENTO,
       B.CODIGO,
       CASE B.PROVDESCBASE
         WHEN 'P' THEN 'Provento'
         WHEN 'D' THEN 'Desconto'
         WHEN 'B' THEN 'Base'
       END               AS TIPOEVENTO,
       B.DESCRICAO       AS NOMEEVENTO,
       C.REF             AS REF_MES_ATUAL,
       C.VALOR           AS VALOR_MES_ATUAL,
       D.REF             AS REF_MES_ANTERIOR,
       D.VALOR           AS VALOR_MES_ANTERIOR,
       C.VALOR - D.VALOR AS DIFERENCA
FROM   PFUNC A
       LEFT JOIN PEVENTO B
              ON A.CODCOLIGADA = B.CODCOLIGADA
       LEFT JOIN PFFINANC C
              ON B.CODCOLIGADA = C.CODCOLIGADA
                 AND B.CODIGO = C.CODEVENTO
                 AND A.CHAPA = C.CHAPA
                 AND C.ANOCOMP = :ANO_ATUAL
                 AND C.MESCOMP = :MES_ATUAL
                 AND C.NROPERIODO = :PERIODO_ATUAL
       LEFT JOIN PFFINANC D
              ON B.CODCOLIGADA = D.CODCOLIGADA
                 AND B.CODIGO = D.CODEVENTO
                 AND A.CHAPA = D.CHAPA
                 AND D.ANOCOMP = :ANO_ANTERIOR
                 AND D.MESCOMP = :MES_ANTERIOR
                 AND D.NROPERIODO = :PERIODO_ANTERIOR
WHERE  A.CODCOLIGADA = 1
       AND A.CODFILIAL = 1
       AND A.CHAPA = :CHAPA
       AND CODSITUACAO <> 'D'
       AND ( C.VALOR > 0
              OR D.VALOR > 0 )
ORDER  BY B.PROVDESCBASE,
          B.CODIGO 
 

/* -- Query compara GERAL a folha mês anterior X mês atual, com base nos parâmetros. Somente CLT.
--Parametros:

-- :ANO_ATUAL
-- :MES_ATUAL
-- :PERIODO_ATUAL

-- :ANO_ANTERIOR
-- :MES_ANTERIOR
-- :PERIODO_ANTERIOR
*/

SELECT A.CHAPA,
       A.NOME,
       E.NOME      AS CARGO,
       A.DATAADMISSAO,
       CASE A.CODSITUACAO
         WHEN 'A' THEN 'Ativo'
         WHEN 'D' THEN 'Demitido'
         WHEN 'E' THEN 'Licenç.Mater.'
         WHEN 'F' THEN 'Férias'
         WHEN 'I' THEN 'Apos. por Incapacidade Permanente'
         WHEN 'L' THEN 'Licença s/ venc'
         WHEN 'M' THEN 'Serv.Militar'
         WHEN 'O' THEN 'Doença Ocupacional'
         WHEN 'P' THEN 'Af.Previdência'
         WHEN 'R' THEN 'Licença Remun.'
         WHEN 'S' THEN 'Mandato Sindical Ônus do Sindicato'
         WHEN 'T' THEN 'Af.Ac.Trabalho'
         WHEN 'U' THEN 'Outros'
         WHEN 'V' THEN 'Aviso Prévio'
         WHEN 'X' THEN 'C/Dem.no mês'
         WHEN 'Z' THEN 'Admissão prox.mês'
         WHEN 'W' THEN 'Licença Mater.Compl. 180 dias'
         WHEN 'C' THEN 'Contrato de Trabalho Suspenso'
         WHEN 'N' THEN 'Mandato Sindical Ônus do Empregador'
         WHEN 'G' THEN 'Recesso Remunerado de Estagio'
         WHEN 'Y' THEN 'Licença Paternidade'
         WHEN 'K' THEN 'Cessão / Requisição'
         WHEN 'Q' THEN 'Prisão / Cárcere'
         ELSE 'VERIFICAR NOVA SITUAÇÃO.'
       END         AS SITUACAO,
       A.CODRECEBIMENTO,
       B.CODIGO    NROEVENTO,
       CASE B.PROVDESCBASE
         WHEN 'P' THEN 'Provento'
         WHEN 'D' THEN 'Desconto'
         WHEN 'B' THEN 'Base'
       END         AS TIPOEVENTO,
       B.DESCRICAO AS NOMEEVENTO,
       C.REF       AS REF_MES_ATUAL,
       C.VALOR     AS VALOR_MES_ATUAL,
       D.REF       AS REF_MES_ANTERIOR,
       D.VALOR     AS VALOR_MES_ANTERIOR
/*C.VALOR - D.VALOR AS DIFERENCA*/
FROM   PFUNC A
       LEFT JOIN PEVENTO B
              ON A.CODCOLIGADA = B.CODCOLIGADA
       LEFT JOIN PFFINANC C
              ON B.CODCOLIGADA = C.CODCOLIGADA
                 AND B.CODIGO = C.CODEVENTO
                 AND A.CHAPA = C.CHAPA
                 AND C.ANOCOMP = :ANO_ATUAL
                 AND C.MESCOMP = :MES_ATUAL
                 AND C.NROPERIODO = :PERIODO_ATUAL
       LEFT JOIN PFFINANC D
              ON B.CODCOLIGADA = D.CODCOLIGADA
                 AND B.CODIGO = D.CODEVENTO
                 AND A.CHAPA = D.CHAPA
                 AND D.ANOCOMP = :ANO_ANTERIOR
                 AND D.MESCOMP = :MES_ANTERIOR
                 AND D.NROPERIODO = :PERIODO_ANTERIOR
       LEFT JOIN PFUNCAO E
              ON A.CODCOLIGADA = E.CODCOLIGADA
                 AND A.CODFUNCAO = E.CODIGO
WHERE  A.CODSITUACAO != 'D'
       AND A.CODRECEBIMENTO != 'H'
       AND ( C.VALOR > 0
              OR D.VALOR > 0 )
ORDER  BY A.NOME, B.PROVDESCBASE DESC,
          B.CODIGO ;

------------------------------------ PROXIMA QUERY ---------------------





    









