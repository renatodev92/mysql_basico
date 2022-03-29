/*Use a tabela gafanhotos e resolva os exercicios abaixo.*/

/*1 - Fazer uma lista com todas as mulheres.*/
SELECT * FROM gafanhotos
WHERE sexo = 'F';

/*2 - Fazer uma lista com todos que nasceram entre 01/01/2000 e 31/03/2022.*/
SELECT * FROM gafanhotos 
WHERE nascimento BETWEEN '2000-01-01' AND '2022-03-31';

/*3 - Fazer uma lista com todos os homens que são programadores.*/
SELECT * FROM gafanhotos 
WHERE sexo = 'M' AND profissao = 'Programador';

/*4 - Fazer uma lista que contem todas as mulheres que nasceram no Brasil e que têm seu nome iniciando com a letra J. */
SELECT * FROM gafanhotos 
WHERE sexo = 'F' AND nacionalidade = 'Brasil' AND nome LIKE 'J%';

/*5 - Fazer uma lista o nome, nacionalidade, sexo de todos os homens que tem Silva no nome, não nasceram no brasil e pesam menos de 100kg.*/
SELECT nome, nacionalidade, sexo, peso FROM gafanhotos
WHERE sexo = 'M' AND nacionalidade !='BRASIL' AND peso < 100.00 AND nome LIKE '%Silva%';


/*6 - Qual a maior altura do gafanhotos homens que moram no Brasil. Exiba na tela: nome, nacionalidade, altura*/
SELECT nome, nacionalidade, MAX(altura) FROM gafanhotos
WHERE sexo = 'M' AND nacionalidade = 'Brasil';

/*7 - Qual a media de peso dos gafanhotos cadastrados.*/
SELECT AVG(peso) FROM gafanhotos;

/*8 - Qual é o menor peso entre as gafanhotos mulheres que nasceram fora do Brasil e entre 01/01/1990 a 31/12/2000?.*/
SELECT nome, nacionalidade, MIN(peso) FROM gafanhotos
WHERE nacionalidade != 'Brasil' AND nascimento BETWEEN '1990-01-01' AND '2000-12-31';

/*9 - Quantas gafanhotos mulheres tem mais de 1.90 de altura. */
SELECT * FROM gafanhotos
WHERE sexo = 'F' AND altura > 1.90;

