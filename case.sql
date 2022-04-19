-- Trabalhando com o CASE SQL

-- O que é o comando SQL CASE?

--A expressão SQL CASE é um comando usado para definir condições que vão ser testadas durante a execução do código e, caso sejam atendidas, entregarão um determinado resultado.
--Além disso, o CASE pode ser usado junto com qualquer instrução ou cláusula que permita avaliar expressões, como os comandos UPDATE, SELECT e DELETE e as cláusulas WHERE, ORDER BY, GROUP BY, entre outros.

-- Qual a sintaxe do comando SQL CASE?
-- A sintaxe básica do comando SQL CASE é muito simples, como mostramos a seguir:

/*CASE
     WHEN condição1 THEN resultado1
     WHEN condição2 THEN resultado2
     WHEN condiçãoN THEN resultadoN
     ELSE resultado
 END;
 */

-- 2: Para demonstrar isso, pense em um cenário em que serão definidos descontos para determinados produtos. Assim, para itens com um determinado nome, será dado um desconto tal. Se o item não tiver nenhum dos nomes indicados, ele não terá desconto. Nesse caso, o código que poderíamos usar seria:

  SELECT nome, valor_unitario,
 CASE nome
 WHEN 'Playstation 3' THEN (valor_unitario) * 0.9
 WHEN 'Xbox 360' THEN (valor_unitario) * 0.8
 WHEN 'Iphone 4' THEN (valor_unitario) * 0.7
 ELSE 'Sem desconto disponível'
 END AS produto_com_desconto
 From produto;

 -- 2: Usando uma expressão CASE sem o ELSE
 -- O uso da cláusula ELSE não é obrigatório no comando CASE. Então, qual seria o resultado se retirássemos essa linha do comando usado no exemplo anterior? 
 --Observe que, sem a cláusula ELSE definida, o SQL atribuiu o valor NULL para os linhas que não atendiam a nenhuma condição especificada pela cláusula WHEN.

   SELECT nome, valor_unitario,
 CASE nome
 WHEN 'Playstation 3' THEN (valor_unitario) * 0.9
 WHEN 'Xbox 360' THEN (valor_unitario) * 0.8
 WHEN 'Iphone 4' THEN (valor_unitario) * 0.7
 END AS produto_com_desconto
 From produto

 -- 3: Usando uma expressão CASE de pesquisa
 -- Agora vamos ver como funciona a forma de expressão CASE de pesquisa. Essa segunda forma é usada para avaliar um conjunto de expressões e retornar um resultado assim que uma delas for avaliada como verdadeira. Ao contrário da forma simples, a CASE de pesquisa permite que múltiplas comparações sejam definidas em uma cláusula WHEN.
 -- Então, imagine que temos uma situação na qual precisamos definir uma taxa de desconto de acordo com o preço do produto. Para itens com preço maior que 800.00, o desconto será de 40%. Se o preço for maior que 300.00 ou menor ou igual a 799.00, o desconto será de 30%. Já para outros valores, o desconto será de 20%.

 SELECT nome, valor_unitario,
 CASE
    WHEN valor_unitario > 800.00 THEN (valor_unitario) * 0.6
    WHEN valor_unitario > 300.00 AND valor_unitario <= 799.00 THEN (valor_unitario) * 0.7
    ELSE (valor_unitario) * 0.8
END AS produto_com_desconto
FROM produto;

-- 4: Usando uma expressão CASE com múltiplas expressões
--  O comando SQL CASE permite definir várias expressões para serem testadas durante a execução. No exemplo que mostraremos agora, queremos identificar os itens da tabela “produto” que precisam de reposição. Para isso, precisamos seguir a regra:

/* produtos com quantidade menor ou igual a 100 precisam de reposição;
produtos com quantidade menor ou igual a 150 estão com estoque baixo;
produtos com quantidade menor ou igual a 200 recebem classificação de estoque médio;
se nenhuma condição for atendida, então o item está com estoque alto.*/

SELECT nome, fabricante, quantidade,
CASE
    WHEN quantidade <= 100 THEN 'Precisam de reposição'
    WHEN quantidade <= 150 THEN 'Estoque baixo'
    WHEN quantidade <= 200 THEN 'Estoque médio'
    ELSE'O item está com o estoque alto'
END AS status_estoque
FROM produto
ORDER BY quantidade;

-- 5: Usando uma expressão CASE dentro de outra CASE: Cases aninhadas
-- Com o comando SQL CASE também podemos testar condições dentro de outras condições. Para essa demonstração, imagine um cenário em que queremos estabelecer um novo preço para os itens da nossa tabela “produto” de acordo com o valor_unitario e quantidade no estoque.
-- Então, se o valor_unitario do produto estiver entre 100.00 e 500.00 reais, deve-se avaliar se a quantidade está acima de 100. 
--Caso as duas condições sejam verdadeiras, então o produto recebe um desconto de 20%. Se a primeira condição for verdadeira, mas a segunda não, o preço terá um desconto de 10%. Já se a primeira condição não for verdadeira, o preço permanece o mesmo.

SELECT nome, valor_unitario, quantidade,
CASE 
	WHEN valor_unitario > 100.00 <= 500.00 THEN 
		CASE 
			WHEN quantidade > 100 THEN (valor_unitario) * 0.8
            ELSE (valor_unitario) * 0.9 
		END
    ELSE valor_unitario
END AS 'novo_valor'
FROM produto
ORDER BY valor_unitario;

SELECT * FROM produto;








