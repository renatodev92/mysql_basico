-- 1. Criar Banco de Dados: CREATE DATABASE
CREATE DATABASE supermercado;
USE supermercado;

-- 2. Criar tabelas de no Banco de dados: CREATE TABLE
-- O tipo de dados SMALLINT do Firebird é usado quando precisamos armazenar valores inteiros (sem a parte fracionária) na faixa de -32.768 até 32.767.

CREATE TABLE fornecedores (
    cod_fornecedor SMALLINT PRIMARY KEY,
    nome_fornecedor VARCHAR(100)
);

CREATE TABLE 

CREATE TABLE produtos (
    id_produto SMALLINT PRIMARY KEY, 
    nome_produto VARCHAR(100) NOT NULL,
    quantidade_produto SMALLINT NOT NULL, 
    preco_produto DECIMAL(10,2),
    cod_fornecedor SMALLINT,
    CONSTRAINT fk_cod_fornecedor FOREIGN KEY -- CHAVE ESTRANGEIRA
    REFERENCES fornecedores(cod_fornecedor)

);

-- 3. Inserir dados em uma tabela: INSERT INTO
INSERT INTO fornecedores (cod_fornecedor, nome_fornecedor) VALUES (1, 'IBM');

INSERT INTO produtos 
VALUES (102, 'Monitor LCD', 12, 1250.00, 1), 
       (103, 'Mouse', 20, 150.00, 1),
       (104, 'Teclado', 30, 300.00, 1),
       (105, 'Desktop i5', 12, 2000.00, 1);

-- 4. Fazendo consultas no banco de dados. SELECT.

SELECT * FROM fornecedores;

SELECT nome_fornecedor FROM fornecedores;
SELECT nome_produto, preco_produto FROM produtos;

-- 5. Consultando uma tabela com filtros de dados. SELECT/WHERE.

SELECT nome_produto FROM produtos
WHERE id_produto = 101;

-- 6. Alterar um registro em uma tabela. UPDATE.

UPDATE produtos
SET preco_produto = 1400.00
WHERE id_produto = 102;

-- 7. Excluir registro em uma tabela: DELETE
DELETE FROM produtos
WHERE id_produto = 105;

-- 8. Trazer dados de duas ou mais tabelas relacionadas entre si. INNER JOIN
SELECT id_produto, nome_produto, nome_fornecedor
FROM fornecedores
INNER JOIN produtos
ON fornecedores.cod_fornecedor = produtos.cod_fornecedor;

-- 9. Retornar os resultados em ordem especificada. ORDEM BY
SELECT nome_produto, preco_produto
FROM produtos
ORDER BY preco_produto;

-- 10. Apaga todos os dados de uma tabela.
TRUNCATE TABLE produtos;

-- 11. Relizando consultas com SUBQUERY(SUBSELECT) (AVANÇADO)
SELECT * FROM clientes
WHERE clientes.altura >
	(SELECT AVG(clientes.altura) FROM clientes)
ORDER BY clientes.altura;



