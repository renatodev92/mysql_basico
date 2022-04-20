/* O COMANDO MAIS IMPORTANTE DO SQL - SELECT*/

-- SELECT DISTINCT - A instrução SELECT DISTINCT é usada para retornar apenas valores distintos (diferentes). Dentro de uma tabela, uma coluna geralmente contém muitos valores duplicados; E às vezes você só deseja listar os diferentes valores (distintos).

-- Selecione da tabela cursos, o campo ano_criacao_curso, e retorne os anos em que houveram cursos. Caso haja uma ano repitido o comando SELECT DISTINCT não retornará.

SELECT DISTINCT ano_criacao_curso FROM cursos
ORDER BY ano_criacao_curso;

/*Contando o totaulas_curso da tabela cursos.*/
/*GRUPO BY - Exibindo quantos cursos tem por totaulas_curso*/
SELECT totaulas_curso, COUNT(*) AS 'NUMERO DE CURSOS' FROM cursos
GROUP BY totaulas_curso
ORDER BY totaulas_curso;

/*Contando o carga_curso da tabela cursos.*/
/*GRUPO BY - Exibindo quantos cursos tem por carga_curso*/

SELECT carga_curso, COUNT(*) AS 'Quantidade de Cursos por carga horária'FROM cursos
GROUP BY carga_curso

/* Conte quantos cursos eu fiz por ano. */
/* E ordene pelo COUNT(*)/CONTADOR*/

SELECT ano, COUNT(*) FROM cursos
GROUP BY ano
ORDER BY COUNT(*);

/* Conte quantos cursos eu fiz por ano. */
/* E retorne pelo COUNT(*), somente os anos que eu dei >= 5 cursos.CONTADOR*/

SELECT ano_criacao_curso, COUNT(*) FROM cursos
GROUP BY ano_criacao_curso
HAVING COUNT(ano_criacao_curso) >= 5
ORDER BY COUNT(*);

/* SELECT - Selecione a coluna ano_criacao_curso da tabela cursos e conte as linhas*/
/* WHERE - Onde o totaulas_curso seja maior que 30*/
/* GROUP BY -  Agrupar a seleção por ano_criacao_curso*/
/* HAVING - Só vou mostrar quem tem o ano_criacao_curso acima de 2013. */
/* ORDER BY - Ordene por ordem decrescente*/

SELECT ano_criacao_curso, COUNT(*) FROM cursos  
WHERE totaulas_curso > 30
GROUP BY ano_criacao_curso 
HAVING ano_criacao_curso > 2013  
ORDER BY COUNT(*) DESC; 

/* SELECT   - Selecione a coluna carga_curso da tabela cursos*/
/* WHERE    - ano_criacao_curso > 2016*/
/* GROUP BY - E monte o agrupamento por  carga_curso*/
/* HAVING   - E mostre somente a coluna carga_curso onde a carga_curso for > que a médias da carga horária total de cursos. */

SELECT carga_curso, COUNT(*) FROM cursos
WHERE ano_criacao_curso > 2016
GROUP BY carga_curso
HAVING carga_curso > (SELECT AVG(carga_curso) FROM cursos);


/* Selecionando a tabela clientes e extraindo do campo nascimento 
    DIA - DAY()
    MÊS - MONTH()
    YEAR - YEAR()
*/
USE cadastro;
SELECT * FROM cliente;

SELECT
	nome,
	DAY(nascimento) AS dia_nascimento,
    MONTH(nascimento) AS mes_nascimento,
    YEAR(nascimento) AS ano_nascimento
FROM cliente
HAVING ano_nascimento BETWEEN 1970 AND 1980;