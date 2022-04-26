USE CADASTRO;

-- GRANT/REVOKE 
-- FONTE: http://www.bosontreinamentos.com.br/mysql/curso-de-mysql-grant-e-revoke-definindo-privilegios-de-acesso-aos-bancos-de-dados/

-- Verificando os usúarios do BANCO DE DADOS
SELECT user FROM mysql.user; 

-- Verificando em quais HOTS os usúarios podem se logar
SELECT user, host FROM mysql.user;

-- Exindo os privilégios que o usúario do banco de dados possui.
SHOW GRANTS FOR root@localhost;
-- PRIVELEGIOS

-- PARA TRABALHAR COM DADOS
-- INSERT, UPDATE, DELETE, SELECT, EXECUTE

-- PARA MODIFICAR A ESTRUTURA DO BANCO DE DADOS
-- CREATE , ALTER, DROP, CREATE VIEWS, TRIGGER, INDEX, CREATE ROUTINE, ALTER ROUTINE

-- ADMINISTRATIVOS
-- CREATE USER, SHOW DATABASES, SHUTDOWN, RELOAD, ALL, GRANT OPTION, USAGE

-- NIVEIS DE PRIVILÉGIOS

-- 1 - GLOBAL    - O usúario tem acesso a todas as tabelas de todos os bancos de dados.
-- 2 - DATABASE  - Esse privilégio dá ao usúario acesso a todas as tabelas de um banco de dados especifíco.
-- 3 - TABLES    - O usúario tem acesso a todas as colunas de uma tabela especifica em uma base de dados.
-- 4 - COLUMN    - O usúario possui acesso apenas a colunas especificadas em uma determinada tabela.

-- ARMAZENANDO INFORMÇÕES SOBRE PRIVILÉGIOS
-- O mysql ultiliza tabelas especiais denominadas grat tables para armazenar informações sobre privilégios dos usúarios, em um banco de dados
-- interno de nome MYSQL. Os dados a seguir demonstram esses privilégios.

-- USER: Armazena nomes e senhas de todos os usúarios do servidor. Também aramazena privilégios globais que são aplicados a todos os bancos de dados do servidor.
-- DB: Armazena privilégios do banco de dados.
-- TABLES_PRIV: Armazena privilégios da tabela.
-- COLUMNS_PRIV: Armazena privilégios de colunas.
-- PROCS_PRIV: 	 Armazena privilégios de acesso a funções e stored procedures (procedimentos armazenados).

-- CRIANDO UM USÚARIO NO BANCO DE DADOS
-- *.* Esse simbolo significa * todos os bancos * todas as tabelas. Sendo a junção *.*
-- INDENTIFIED BY (SENHA)

GRANT USAGE
ON *.* 
TO larissa@localhost IDENTIFIED BY '1234';

-- Verificando se o usúario foi criado.
SELECT user, host FROM mysql.user;

-- Exibindo os privilégios do usúario criado
SHOW GRANTS FOR larissa@localhost;

-- Criando um usúario com todos os privilégios GLOBAIS
GRANT ALL 
ON *.* 
TO oliveira IDENTIFIED BY '1234'
WITH GRANT OPTION;

-- Exibindo os privilégios globais do usúario criado.
SHOW GRANTS FOR oliveira;

-- Visualizando o BANCO DE DADOS
SHOW DATABASES;

-- CRIANDO UM NOVO USÚARIO
CREATE USER tatiane@localhost;

-- Exibindo os privilégios globais do usúario criado.
SHOW GRANTS FOR tatiane@localhost;

-- Verificando se o usúario foi criado.
SELECT user, host FROM mysql.user;

-- Dando provilégios especifios ao usúario.
-- O usúario terá permissão para trabalhar com os dados: Poderá usar SELECT, INSERT, UPDATE e DELETE.
-- Selecionando todas as tabelas do banco de dados cadastro.*.

GRANT 
	SELECT, 
    INSERT, 
    UPDATE, 
    DELETE
ON cadastro.*  
TO tatiane@localhost;

-- Exibindo os privilégios globais do usúario criado.
SHOW GRANTS FOR tatiane@localhost;

-- Dando provilégios especifios ao usúario.
-- O usúario terá permissão para trabalhar com os dados: Poderá usar SELECT e UPDATE, somente em alguns campos especificos.
-- Selecionando o banco de dado cadastro com acesso somente a tabela.cliente.
GRANT
	SELECT(id, nome), 
    UPDATE (nome)
ON cadastro.cliente
TO larissa@localhost;  

-- Exibindo os privilégios globais do usúario criado.
SHOW GRANTS FOR larissa@localhost;


-- REVOKE
-- O usúario não terá mais permissão de trabalhar com os dados: SELECT, INSERT, UPDATE e DELETE. Somente SELECT e INSERT.
-- Selecionando todas as tabelas do banco de dados cadastro.*.
-- REVOKE - Remova do usúario tatiane@localhost, a permissão de UPDATE e DELETE.

REVOKE 
	UPDATE,
    DELETE
ON cadastro.*  
FROM tatiane@localhost;

-- Exibindo os privilégios globais do usúario criado, após o REVOKE.
SHOW GRANTS FOR tatiane@localhost;

-- Removendo os privilégios de alguns usúarios no banco de dados.

REVOKE ALL, GRANT OPTION
FROM  tatiane@localhost, larissa@localhost, renato@localhost;








