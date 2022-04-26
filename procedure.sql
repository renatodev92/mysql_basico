-- Stored Procedure

-- Que traduzido significa Procedimento Armazenado, é uma conjunto de comandos em SQL que podem ser executados de uma só vez, como em uma função. 
-- Ele armazena tarefas repetitivas e aceita parâmetros de entrada para que a tarefa seja efetuada de acordo com a necessidade individual.

-- Criando um procedimento (Stored Procedure)
-- Abaixo foi criado um procedimento para que sempre que chamado o mesmo seja executado.
-- Dentro da tabela produto, criamos um procedimento que o exibe o nome, preço e uma mensagem com base no n° de id do produto.

-- Criando o procedimento para mostrar o nome do produto e valor, com base no id_produto.
CREATE PROCEDURE pr_ver_preco (cod_produto INT)
SELECT CONCAT(nome, ",", "valor R$: ", valor_unitario) AS detalhes
FROM produto
WHERE id = cod_produto;

-- Chamando o procedimento e passando o id do produto como parametro.
CALL pr_ver_preco(9);

-- Para excluir um procedimento usamos o comando DROP PROCEDURE em seguida com o nome do procedimento.
DROP PROCEDURE pr_ver_preco;

SELECT * FROM produto;








SELECT * FROM produto;


    