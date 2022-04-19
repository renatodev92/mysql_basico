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


