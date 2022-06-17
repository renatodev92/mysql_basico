-- Algumas funções em SQL

-- NULLIF
-- A função NULLIF compara dois valores. Se os valores forem iguais, a função retornará valor nulo. Se os valores dos campos valor e valororiginal forem iguais, a função retornará valor nulo. Se os valores desses campos forem diferentes, a função retornará o primeiro valor.

SELECT * FROM pffinanc;

SELECT valor, valororiginal, nullif(valor, valororiginal) AS RESULTADO from pffinanc;

-- DECODE
-- A função Decode tem como objetivo ‘decodificar’ o valor do campo selecionado, atribuindo um valor de resposta para cada valor de condição estipulado.
-- Se o campo anocomp da tabela pffinanc, for 2022 escreva: 'Dois mil e vinte dois anos', se for 2019 escreva: Dois mil e dezenove anos, se for 2018 escreva: Dois mil e dezoito anos, se não for nenhum escreva:  Outro ano.

SELECT anocomp, decode(anocomp, 2022, 'Dois mil e vinte dois anos', 2019, 'Dois mil e dezenove anos', 2018, 'Dois mil e dezoito anos', 'Outro ano') 
AS RESULT from pffinanc
ORDER BY anocomp DESC;

--CASE
--A função CASE é utilizada para determinar a exibição do resultado a partir de condições especificadas dentro da função.
-- Selecione o estado civil, conte todas as linhas onde o estadocivil is not null(Não é nullo) e retorne a descricao.
--Caso o estadocivil for (
    -- S = Solteiro
    -- C = Casado
    -- E dai em diante

--)

--Obs.: Para melhor entendimento da função: para todo ‘case’ deve existir um ‘end’, e para todo ‘when’ deve existir um ‘then’. O ‘else’ existe sozinho, como última alternativa da função.

SELECT estadocivil, COUNT(*) AS TOTAL,
    CASE estadocivil
        WHEN 'S' THEN 'Solteiro'
        WHEN 'C' THEN 'clientes'
        WHEN 'I' THEN 'Divorciado'
        WHEN 'O' THEN 'Outros'
        WHEN 'V' THEN 'Viúvo'
        WHEN 'P' THEN 'Separado'
        WHEN 'D' THEN 'Desquitado'
        WHEN 'E' THEN 'União Estável'
        WHEN 'P' THEN 'Separado'
        ELSE '???'
    END AS DESCRICAO
FROM PPESSOA
WHERE estadocivil IS NOT NULL
GROUP BY estadocivil
ORDER BY TOTAL DESC;


-- O SQL a seguir ordenará os clientes por Cidade. No entanto, se Cidade for NULL, então ordene por País:
SELECT CustomerName, City, Country
FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END);


-- LOWER
-- Transforma um texto em letras minúsculas.
SELECT LOWER(nome) FROM PPESSOA;

-- UPPER
-- Transforma um texto em letras maiúsculas.
SELECT UPPER(nome) FROM PPESSOA;

-- SUBSTR
-- A função SUBSTR tem como objetivo extrair parte do conteúdo do campo selecionado, de acordo com os parâmetros informados na função, independente do tipo do campo (numérico, texto ou data).
--Retorna 5 caracteres a partir da primeira letra.
SELECT SUBSTR(nome,1,5) FROM PPESSOA;

-- LENGTH
-- A função LENGTH tem como objetivo exibir o tamanho do valor que está gravado no campo selecionado.
SELECT nome, LENGTH(nome)AS TOTALLETRAS 
FROM PPESSOA;

--REPLACE
-- A função REPLACE tem como objetivo possibilitar a substituição de caracteres específicos por outros.
--O código abaixo seleciona dos registros da tabela pcempr os campos matricula e nome, e exibe, logo em seguida, o campo nome, substituindo o caractere ‘A’ por ‘*’

SELECT nome, replace(nome,'A','*') from CLIENTE;

-- ROUND
-- A função ROUND tem como objetivo efetuar o arredondamento de números para a quantidade de casas decimais determinada na função.
-- Arredonda o valor depois da virgula para 3 casas decimais.

SELECT id, nome, altura, ROUND(altura,3) AS 'ARREDONDAMENTO' FROM cliente;


--TRUNC ou TRUNCATE
-- A função TRUNC ou TRUNCATE tem como objetivo efetuar o truncamento(corte) de números para a quantidade de casas determinada na função.
-- o select abaixo retorna remove o valor de uma casa decimal do campo altura.

SELECT id, nome, altura, TRUNCATE(altura,1) AS 'ARREDONDAMENTO' FROM cliente;


-- SYSDATE
-- Selecionando data do sistema com a função Sysdate.

SELECT sysdate() FROM cliente;

















