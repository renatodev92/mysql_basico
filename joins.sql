/*Criando uma nova coluna na tabela clientes*/
ALTER TABLE clientes
ADD COLUMN cursoescolhido int;

/*Adicionando uma chave estrangeira na coluna curso preferido, e referenciando a tabela cursos id cursos.*/
ALTER TABLE clientes
ADD FOREIGN KEY (cursoescolhido)
REFERENCES cursos(idcurso);

/* Veja que apareceu uma chave chamada (MUL ESTRANGEIRA) ao executar o comando abaixo. */
desc clientes

/*Incluindo no aluno 1 tabela clientes o curso 6 MYSQL where o id="1"*/
UPDATE clientes SET cursoescolhido = '6' where = '1';


----------------------------------------------------------------------------------------------------------------------------------------------------
/*  JOIN  unindo entidades(TABELAS) e exibindo dados*/
/* Sempre que utilizar o JOIN deve ser utilizado o ON junto */

----------------------------------------------------------------------------------------------------------------------------------------------------

/*INNER JOIN - Só traz o que tem relacionado nas duas tabelas*/
SELECT clientes.id,clientes.nome, clientes.cursoescolhido, cursos.nome, cursos.ano
FROM clientes INNER JOIN cursos
ON cursos.idcurso = clientes.cursoescolhido /*Fazendo a ligação da chave primary com a chave estrangeira*/
ORDER BY clientes.nome;

/*Outra forma de exibir o mesmo resultado*/
/*Com o comando AS definimos clientes = g, cursos = c*/
SELECT g.id, g.nome, g.cursoescolhido, c.nome, c.ano
FROM clientes AS g INNER JOIN cursos AS c
ON c.idcurso = g.cursoescolhido /*Fazendo a ligação da chave primary com a chave estrangeira*/
ORDER BY g.nome;

----------------------------------------------------------------------------------------------------------------------------------------------------

/*OUTER JOIN*/
/*Diferente do INNER JOIN que só traz o resultado que tem relacionado entre as duas tabelas, nunca trara um dado vazio. o OUTER JOIN traz os dados que também estão vazios entre as duas tabelas.*/


/* LEFT - Retorna os dados da tabela que está a esquerda. Nesse caso (clientes) mesmo aqueles que não tenham um cursoescolhido.*/

SELECT clientes.id, clientes.nome, clientes.cursoescolhido, cursos.nome, cursos.ano
FROM clientes LEFT OUTER JOIN cursos
ON cursos.idcurso = clientes.cursoescolhido /*Fazendo a ligação da chave primary com a chave estrangeira*/
ORDER BY clientes.nome;

/* RIGHT - Retorna os dados da tabela que está a direita. Nesse caso (cursos) mesmo aqueles que não tenham um aluno cadastrado.*/
SELECT clientes.id, clientes.nome, clientes.cursoescolhido, cursos.nome, cursos.ano
FROM clientes RIGHT OUTER JOIN cursos
ON cursos.idcurso = clientes.cursoescolhido /*Fazendo a ligação da chave primary com a chave estrangeira*/
ORDER BY cursos.nome;

----------------------------------------------------------------------------------------------------------------------------------------------------
/*Criando uma tabela MATRICULA que vai trabalhar com a tabela clientes e cursos. n x n muitos para muitos*/

CREATE TABLE matricula (
    id INT NOT NULL AUTO_INCREMENT, 
    datamatricula DATE,
    idgafanhoto INT
    idcurso INT, 
    PRIMARY KEY (id),
    FOREIGN KEY (idgafanhoto) REFERENCES clientes(id), /* Adicionando a chave estrangeira da entidade 'clientes' em 'matricula'*/
    FOREIGN KEY (idcurso) REFERENCES cursos(idcurso)/* Adicionando a chave estrangeira da entidade 'cursos' em 'matricula'*/
) DEFAULT CHARSET = utf8;

/*Agora digite o comando abaixo para visualizar as chaves primarias*/
desc matricula;

/*Inserindo os dados na tabela matricula*/
INSERT INTO matricula 
VALUES (DEFAULT , '2022-04-01', '1', '2'), 
	   (DEFAULT , '2022-04-01', '2', '20'), 			
	   (DEFAULT , '2022-04-01', '15', '23');

/*

1 - Selecione na tabela clientes o id, nome. 
2 - Selecione na tabela matricula o id_matricula,id_curso.
3 - Una as tabelas 'clientes' e 'matricula' com o INNER JOIN
4 - Ligue as tabelas com as chaves estrangeiras através do ON.

*/
SELECT clientes.id_cliente, clientes.nome, matricula.id_matricula, matricula.id_curso FROM
clientes INNER JOIN matricula
ON clientes.id_cliente = matricula.id_cliente;


/*

UNINCO AS 3 TABELAS 'clientes', 'matricula' e 'cursos'

1 - Selecione na tabela clientes o id, nome. 
2 - Selecione na tabela matricula o id_matricula.
3 - Selecione na tabela cursos o id_curso, nome_curso, descricao_curso.
4 - Una as tabelas 'clientes' e 'matricula' com o INNER JOIN
5 - Ligue as tabelas com as chaves estrangeiras através do ON.
6 - Una as tabelas 'cursos' com as demais
7 - Ligue as tabelas com as chaves estrangeiras através do ON.

*/

SELECT clientes.id_cliente,  clientes.nome, 
matricula.id_matricula, 
cursos.id_curso, cursos.nome_curso, cursos.descricao_curso 
FROM clientes INNER JOIN matricula
ON clientes.id_cliente = matricula.id_cliente
INNER JOIN cursos
ON cursos.id_curso = matricula.id_curso;


--Outro modelo de CONSULTA JOIN

SELECT cli.id_cliente, cli.nome, cli.profissao, cli.cursoescolhido, 
cur.id_curso, cur.nome_curso, cur.descricao_curso, cur.totaulas_curso, cur.ano_criacao_curso
FROM clientes AS cli RIGHT JOIN cursos AS cur
ON cli.cursoescolhido = cur.id_curso 
WHERE cli.cursoescolhido IS NULL;

--Outro modelo de CONSULTA JOIN
SELECT cli.id_cliente, cli.nome, cli.profissao, 
	   mat.id_curso, cur.nome_curso,  cur.descricao_curso, mat.datamatricula, mat.id_matricula
FROM clientes AS cli INNER JOIN matricula AS mat
ON cli.id_cliente = mat.id_cliente
INNER JOIN cursos AS cur
ON cli.cursoescolhido = cur.id_curso;

--Outro modelo de CONSULTA JOIN
--Exibindo os resultados dos clientes que até o momento estão matriculados no cursos.
SELECT  clientes.id_cliente, clientes.nome, clientes.profissao,clientes.cursoescolhido,
		cursos.id_curso, matricula.id_matricula, cursos.nome_curso, cursos.descricao_curso, cursos.valor_curso
FROM cursos INNER JOIN clientes
ON  clientes.cursoescolhido = cursos.id_curso
INNER JOIN matricula 
ON clientes.id_cliente = matricula.id_cliente
ORDER BY clientes.nome;



