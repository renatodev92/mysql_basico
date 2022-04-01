/*Use a tabela clientes e resolva os exercicios abaixo.*/


/*1 - Exibir uma lista com as profissões dos clientes e seus respectivos quantitativos. */
SELECT profissao, COUNT(*) FROM clientes
GROUP BY profissao
ORDER BY profissao;
 
/*2 - Quantos clientes homens e quantas mulheres nasceram após 01/01/2005. */
SELECT sexo, COUNT(*) FROM clientes
WHERE nascimento > '2005-01-01'
GROUP BY sexo;

/*3 - Uma lista com os clientes que nasceram fora do Brasil, mostrando o país de origem e o total de pessoas nascidas la. Só interessa os países que tiverem mais que 3 clientes com essa nacionalidade */
SELECT nacionalidade, COUNT(*) FROM clientes
WHERE nacionalidade != 'Brasil'
GROUP BY nacionalidade
HAVING COUNT(nacionalidade) >= 3;

/*4 - Uma lista agrupada pela altura dos clientes, mostrando quantas pessoas pessam mais de 100kg e que estão acima da média de altura de todos os cadastrados*/
SELECT altura, COUNT(*) FROM clientes
WHERE peso > 100.00
GROUP BY altura
HAVING altura > (SELECT AVG(altura) from clientes);