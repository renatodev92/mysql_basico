
-- AGRUPANDO INFORMAÇÕES COM O GROUP BY EM SQL.
-- FONTE: https://www.devmedia.com.br/exemplos-com-group-by-e-com-a-clausula-having-totalizando-dados-sql-server-2008-parte-2/19839

USE cadastro;

CREATE TABLE produto (
		id INT NOT NULL AUTO_INCREMENT,
        nome VARCHAR(100) NOT NULL,
        fabricante VARCHAR(100) NOT NULL,
        quantidade INT NOT NULL, 
        valor_unitario FLOAT (5,2) NOT NULL,
        tipo VARCHAR(100) NOT NULL, 
        PRIMARY KEY(id)
) DEFAULT CHARSET = UTF8;

INSERT INTO produto VALUES(DEFAULT, 'Core 2 Duo', 'Dell', 200, 489, 'Notebook'),
						  (DEFAULT, 'Xbox 360', 'Microsolft', 350, 888, 'Console'), 	
						  (DEFAULT, 'GT 16220-QuadBand', 'Sansung', 300, 526, 'Celular'),
                          (DEFAULT, 'Iphone 4', 'Apple', 50, 999, 'Celular'),
                          (DEFAULT, 'Playstation 2', 'Sony', 500, 275, 'Console'),
                          (DEFAULT, 'Sofa Estofado', 'KingsStart', 99, 330, 'Sofa'),
                          (DEFAULT, 'Armario de Serviço', 'Aracaju', 50, 129, 'Armario'), 
                          (DEFAULT, 'Refrigerador 420LT', 'CCE', 200, 499, 'Refrigerador'),
                          (DEFAULT, 'Wii 120 GB', 'Nintendo', 250, 423, 'Console');
SELECT * FROM produto;

SELECT tipo, SUM(quantidade) AS 'total_estoque'
FROM produto
GROUP BY tipo;

SELECT fabricante, SUM(quantidade) 'total_estoque_fabricante'
FROM produto
GROUP BY fabricante;


SELECT fabricante, tipo, SUM(quantidade) AS 'total_estoque_tipo'
FROM produto
GROUP BY fabricante, tipo
HAVING SUM(quantidade) <= 50;
 
SELECT tipo, fabricante, nome, valor_unitario, quantidade, SUM(quantidade * valor_unitario) AS 'valor_estoque'
FROM produto
GROUP by tipo, fabricante, nome, valor_unitario, quantidade;

SELECT nome, SUM(quantidade) AS 'total_estoque', SUM(quantidade * valor_unitario) 'valor_estoque'
FROM produto
GROUP BY nome
HAVING SUM(quantidade) > 200 AND SUM(quantidade * valor_unitario) >= 100000.00;