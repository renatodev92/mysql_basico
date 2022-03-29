/*Use a tabela gafanhotos e resolva os exercicios abaixo.*/


/*1 - Exibir uma lista com as profissões dos gafanhotos e seus respectivos quantitativos. */
SELECT profissao, COUNT(*) FROM gafanhotos
GROUP BY profissao
ORDER BY profissao;
 
/*2 - Quantos gafanhotos homens e quantas mulheres nasceram após 01/01/2005. */
SELECT sexo, COUNT(*) FROM gafanhotos
WHERE nascimento > '2005-01-01'
GROUP BY sexo;

/*3 - Uma lista com os gafanhotos que nasceram fora do Brasil, mostrando o país de origem e o total de pessoas nascidas la. Só interessa os países que tiverem mais que 3 gafanhotos com essa nacionalidade */
SELECT nacionalidade, COUNT(*) FROM gafanhotos
WHERE nacionalidade != 'Brasil'
GROUP BY nacionalidade
HAVING COUNT(nacionalidade) >= 3;

/*4 - Uma lista agrupada pela altura dos gafanhotos, mostrando quantas pessoas pessam mais de 100kg e que estão acima da média de altura de todos os cadastrados*/
SELECT altura, COUNT(*) FROM gafanhotos
WHERE peso > 100.00
GROUP BY altura
HAVING altura > (SELECT AVG(altura) from gafanhotos);