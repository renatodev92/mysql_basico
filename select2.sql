/* O COMANDO MAIS IMPORTANTE DO SQL - SELECT*/
/*COM O SELECT VOCÊ PODE SELECIONAR VARIOS DADOS*/

/*Exibindo os valores da carga horária que eu tenho dentro da tabela cursos.Ele não repete a carga caso tenha um valor repetido*/
/* EX:
PHP: 30H
JAVA: 30H
RUBY: 30H
CSS: 20H 

O resultado final com o DISTINCT será:
20
30
Note que não foi repetida a carga 30.

*/
SELECT DISTINCT carga FROM cursos
ORDER BY carga;

/*Contando o total de aulas da tabela cursos.*/
/*GRUPO BY - Exibindo quantos cursos tem por totaulas*/
SELECT totaulas, COUNT(*) FROM cursos
GROUP BY totaulas;
ORDER BY totaulas;

/*Execute esse comando após o comando acima. */
SELECT * FROM cursos
WHERE totaulas = 30;

/* Conte quantos cursos eu tenho com a carga horária igual. */

/* EX:

PHP: 30H
JAVA: 30H
RUBY: 30H
CSS: 20H 
CSS2.5: 20H

O resultado final com o GROUP BY será:


CARGA - COUNT()
30     - 3 = TENHO 3 CURSOS COM A CARGA HORÁRIO DE 30H.
20     - 2 = TENHO 2 CURSOS COM A CARGA HORÁRIO DE 20H.
Note que não foi repetida a carga 30.
*/

SELECT carga, COUNT(*) FROM cursos
GROUP BY carga;

/* Conte quantos cursos eu fiz por ano. */
/* E ordene pelo COUNT(*)/CONTADOR*/

SELECT ano, COUNT(*) FROM cursos
GROUP BY ano
ORDER BY COUNT(*);

/* Conte quantos cursos eu fiz por ano. */
/* E retorne pelo COUNT(*), somente os anos que eu dei >= 5 cursos.CONTADOR*/

SELECT ano, COUNT(*) FROM cursos
GROUP BY ano
HAVING COUNT(ano) >= 5;
ORDER BY COUNT(*);

SELECT ano, COUNT(*) FROM cursos /*Selecione os anos da tabela cursos*/
WHERE totaulas > 30/* Onde o total de aulas seja acima de 30*/
GROUP BY ano /* Agrupar a seleção por ano*/
HAVING ano > 2013 /*Só vou mostrar quem tem o ano acima de 2013. */
ORDER BY COUNT(*) DESC; /* Ordenando*/

SELECT carga, COUNT(*) from cursos /* Selecione a coluna carga da tabela curos*/
WHERE ano > 2016 /*Onde o ano é maior que 2016*/
GROUP BY carga/* E monte o agrupamento por carga horária*/
HAVING carga > (SELECT AVG(carga) from cursos); /*Mostre somente quem está acima do resultado de outro select*/