-- VIEWS - SQL
-- Resumo simples: Views é uma query que você pode utilizar como reuso, quantas vezes quiser.


/* A view pode ser definida como uma tabela virtual composta por linhas e colunas de dados vindos de tabelas relacionadas em uma query 
(um agrupamento de SELECT’s, por exemplo). As linhas e colunas da view são geradas dinamicamente no momento em que é feita uma referência a ela.
Como já dito, a query que determina uma view pode vir de uma ou mais tabelas, ou até mesmo de outras views.
*/

/*Ao criarmos uma view, podemos filtrar o conteúdo de uma tabela a ser exibida, já que a função da view é exatamente essa: 
filtrar tabelas, servindo para agrupá-las, protegendo certas colunas e simplificando o código de programação.
É importante salientar que, mesmo após o servidor do SQL Server ser desligado, a view continua “viva” no sistema, assim como as tabelas que criamos normalmente. 
As views não ocupam espaço no banco de dados.
*/

-- VANTAGNES DA VIEWS
-- Temos muitos motivos e vantagens para usarmos views em nossos projetos. A seguir são citados três que podem fazer a diferença:

-- Reuso: as views são objetos de caráter permanente. Pensando pelo lado produtivo isso é excelente, já que elas podem ser lidas por vários usuários simultaneamente
-- Segurança: as views permitem que ocultemos determinadas colunas de uma tabela. Para isso, basta criarmos uma view com as colunas que acharmos necessário que sejam exibidas e as disponibilizarmos para o usuário.
-- Simplificação do código: as views nos permitem criar um código de programação muito mais limpo, na medida em que podem conter um SELECT complexo. Assim, criar views para os programadores a fim de poupá-los do trabalho de criar SELECT’s é uma forma de aumentar a produtividade da equipe de desenvolvimento.

-- Agora iremos criar uma VIEW

USE cadastro; -- CHAMANDO O BANCO DE DADOS CADASTRO

-- Criando uma view, unindo 3 entidades(tabelas) cliente, produto, matricula.
-- Com essa view, poderemos visualizar a quantidade de matriculados em cada curso.
-- Quando se cria uma view sempre é bom iniciar o nome com o vw_... seguido do nome, para saber que é uma view.

CREATE VIEW vw_numero_de_matriculas
AS SELECT
	cliente.id AS id_cliente,
    cliente.nome, 
    cliente.sexo,
    curso.id AS id_curso,
	curso.curso,
	curso.valor_curso,
    matricula.id AS id_matricula,
    matricula.data_matricula
FROM cliente
INNER JOIN curso
ON cliente.curso_id = curso.id
INNER JOIN matricula
ON cliente.id = matricula.cliente_id; 

-- Também podemos chamar a view quando quisermos, executando o comando SELECT conforme abaixo.alter
SELECT * FROM vw_numero_de_matriculas
ORDER BY curso;

-- Aqui estamos usando a função GROUP BY, para verificar o número de alunos que temos matriculados em cada curso.
SELECT curso, COUNT(curso) 
FROM vw_numero_de_matriculas
GROUP BY curso;

-- Para alterar uma VIEW podemos utilzar o comando ALTER VIEW
-- Nesse caso modifimos os campos.
-- id_cliente   -> cliente_id
-- id_curso     -> curso_id
-- id_matricula -> matricula_id
 
ALTER VIEW vw_numero_de_matriculas
AS SELECT
	cliente.id AS cliente_id,
    cliente.nome, 
    cliente.sexo,
    curso.id AS curso_id,
	curso.curso,
	curso.valor_curso,
    matricula.id AS matricula_id,
    matricula.data_matricula
FROM cliente
INNER JOIN curso
ON cliente.curso_id = curso.id
INNER JOIN matricula
ON cliente.id = matricula.cliente_id;

-- Exibindo a VIEW com as modificações
SELECT * FROM vw_numero_de_matriculas;

-- Para excluir uma VIEW podemos utilizar o comando DROP VIEW
DROP VIEW vw_numero_de_matriculas;




