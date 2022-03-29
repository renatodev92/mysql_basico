/* O COMANDO MAIS IMPORTANTE DO SQL - SELECT*/
/*COM O SELECT VOCÊ PODE SELECIONAR VARIOS DADOS*/


/* Selecione todas * as colunas da tabela cursos */
SELECT * FROM cursos;

/* Selecione todas * as colunas da tabela cursos, por ordem do campo nome */

SELECT * FROM cursos
ORDER BY nome;

/* Selecione todas * as colunas da tabela cursos, por ordem do campo nome */
/* DESC - Ordena de baixo pra cima*/

SELECT * FROM cursos
ORDER BY nome DESC;

/* Selecione as colunas: nome, carga e ano da tabela cursos, por ordem do campo nome */
SELECT nome, carga, ano FROM cursos
ORDER BY nome;

/* Selecione as colunas: nome, carga e ano da tabela cursos, por ordem do campo ano */
SELECT nome, carga, ano FROM cursos
ORDER BY ano;


/* Selecione as colunas: nome, carga e ano da tabela cursos, por ordem do campo ano, nome */
SELECT nome, carga, ano FROM cursos
ORDER BY ano, nome, carga;

/* Selecione todas * colunas da tabela cursos, onde o ano é igual a '2016' por ordem do campo nome */
SELECT * FROM cursos
WHERE ano = '2016'
ORDER BY nome;

/* Selecione as colunas: nome, descricao e carga da tabela cursos, where o ano é igual = '2016' .por ordem do campo nome */
SELECT nome, descricao, carga FROM cursos
WHERE ano = '2016'
ORDER BY nome;


/* Selecione as colunas: nome, descricao da tabela cursos, where o ano é menor ou igual <= 2015 .por ordem do campo ano, nome */
SELECT nome, descricao, ano FROM cursos
WHERE ano <= 2015
ORDER BY ano, nome;


/* Selecione as colunas: nome, descricao da tabela cursos, where o ano não é igual != 2015 .por ordem do campo ano, nome */
SELECT nome, descricao, ano FROM cursos
WHERE ano != 2015
ORDER BY ano, nome;

/* Selecione as colunas: nome, descricao, ano da tabela cursos, where o ano está entre 2014 and 2016 .por ordem do campo ano, nome */
/* desc - descrescente por ano*/
SELECT nome, descricao, ano FROM cursos
WHERE ano   
ORDER BY ano DESC, nome;

/* Selecione as colunas: nome, descricao, ano da tabela cursos, where o ano é in (2014,2016,2020).por ordem do campo ano*/
SELECT nome, descricao, ano FROM cursos
WHERE ano IN (2014, 2016,2020)
ORDER BY ano;

/* Selecione as colunas: nome, descricao, ano da tabela cursos, where o ano é in (2014,2016,2020).por ordem do campo ano*/
SELECT nome, descricao, ano FROM cursos
WHERE ano IN (2014, 2016,2020)
ORDER BY ano;

/* Selecione todas * colunas da tabela cursos, onde a carga é maior que '35' e menor que '30'.*/
SELECT * FROM cursos
WHERE carga > 35 AND totaulas < 30
ORDER BY nome;

/* Selecione todas * colunas da tabela cursos, onde a carga é maior que '35' ou menor que '30'.*/
SELECT * FROM cursos
WHERE carga > 35 AND totaulas < 30
ORDER BY nome;

/* Selecione todas * colunas da tabela cursos, onde o nome= 'PHP'*/
SELECT * FROM cursos
WHERE nome = 'PHP';

/*LIKE*/


/* Selecione todas * colunas da tabela cursos, onde o nome começa com a letra P. LIKE(PARECIDO/SEMELHANTE)*/
SELECT * FROM cursos
WHERE nome LIKE 'P%';

/* Selecione todas * colunas da tabela cursos, onde o nome termina com letra a. LIKE(PARECIDO/SEMELHANTE)*/
SELECT * FROM cursos
WHERE nome LIKE '%a';

/* Selecione todas * colunas da tabela cursos, onde o nome contenha a letra a. LIKE(PARECIDO/SEMELHANTE)*/
SELECT * FROM cursos
WHERE nome LIKE '%a%';

/* Selecione todas * colunas da tabela cursos, onde o nome começe com PH e termine com P. LIKE(PARECIDO/SEMELHANTE)*/
SELECT * FROM cursos
WHERE nome LIKE 'PH%P';

/* Selecione todas * colunas da tabela cursos, onde o nome começe com PH e termine com seguido _ de alguma coisa. LIKE(PARECIDO/SEMELHANTE)*/
SELECT * FROM cursos
WHERE nome LIKE 'PH%P_';


/*DISTINCT*/
/*A instrução SELECT DISTINCT é usada para retornar apenas valores distintos (diferentes). Dentro de uma tabela, uma coluna geralmente contém muitos valores duplicados; E às vezes você só deseja listar os diferentes valores (distintos)*/

/*Verifica quais naciolidades existem na tabela gafanhotos*/
SELECT DISTINCT nacionalidade FROM gafanhotos
ORDER BY nacionalidade;


/*COUNT - conta quantos nomes aparecem na tabela cursos*/
SELECT COUNT(*) nome FROM cursos;


/*MAX - Seleciona a maior carga horária da tabela cursos */
SELECT MAX(carga) FROM cursos;


/*MAX - Dentro dos cursos de 2016 qual foi o max totaulas */
SELECT MAX(totaulas) from cursos where ano = '2016';

/*MIN - Seleciona a menor carga horária da tabela cursos */
SELECT MIN(carga) FROM cursos;

/*MIN - Seleciona a menor carga horária da tabela cursos where ano = 2016 */
SELECT MIN(carga) FROM cursos
WHERE ano = '2016';

/*SUM -  Somando o totaulas da tabela cursos*/
SELECT SUM(totauaulas) FROM cursos;

/*AVG - Media do totaulas dentro do curso. */
SELECT AVG(totaulas) FROM cursos;












