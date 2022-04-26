-- Criando uma função em SQL

-- Em resumo, Procedures e Functions são rotinas definidas no banco de dados, identificadas por um nome pelo qual podem ser invocadas. 
-- Dessa forma, um procedimento desses pode executar uma série de instruções, receber parâmetros e retornar valores.


-- Por padrão sempre que criar uma função em SQL comece com o fn na frente do nome.
-- Exemplo: Abaixo criaremos uma função chamada 'fn_total' ela multiplicará o um número (a) x (b) por B.
-- Quando criamos funções em SQL temos que declarar o tipo de dados que os parametros vão receber.
-- O parametro a: FLOAT(5,2)
-- O parametro b: INT

USE CADASTRO; 

CREATE FUNCTION fn_total  (a FLOAT(5,2), b INT) 
RETURNS INT 
RETURN a * b;

-- Invocando uma função e passando valores de foma manual como parametro.
SELECT fn_total(5.50,10) AS TOTAL;

-- Chamando a função criada para fazer operações dentro da tabela produto.
SELECT nome, 
	   fabricante,
       quantidade,
       valor_unitario,
       fn_total(valor_unitario, quantidade) AS total_valor_produto
FROM produto;

SELECT * FROM produto;


    