/*Criand uma PROCEDURE*/

DELIMITER $$
CREATE PROCEDURE pr_baixaestoque(
	IN n_id INT(11),
    IN n_quantidade INT(11)
)
BEGIN
	UPDATE produto
	SET produto.quantidade = (produto.quantidade - n_quantidade)
	WHERE produto.id = n_id;
END
$$

/* CHAMANDO UMA PROCEDURE*/

CALL pr_baixaestoque(1,10);