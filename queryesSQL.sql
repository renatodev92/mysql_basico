USE cadatro;

SELECT * FROM PFUNC;
SELECT * FROM PDEP;

SELECT pfunc.id, 
CONCAT(pfunc.nome, ' ',pfunc.sobrenome) AS 'nome_completo', 
pfunc.cargo, 
pfunc.salario, 
IF(
    pfunc.salario >= 5000.00,
	(pfunc.salario * 0.05) + COUNT(pdep.id) * 100,
    (pfunc.salario * 0.1) + COUNT(pdep.id) * 200
) as 'bonus_salario',
IF(
    pfunc.salario >= 5000.00,
	pfunc.salario + (pfunc.salario * 0.05) + COUNT(pdep.id) * 100,
    pfunc.salario + (pfunc.salario * 0.1) + COUNT(pdep.id) * 200
) as 'total_rendimentos',
DATE_FORMAT(pfunc.data_de_admissao, '%d/%m/%Y') AS 'data_admissao',
TIMESTAMPDIFF(year, pfunc.data_nascimento, now()) AS 'idade',
TIMESTAMPDIFF(year, pfunc.data_de_admissao, now()) AS 'tempo_casa',
COUNT(pdep.id) AS 'numero_dependentes',
IFNULL(
	GROUP_CONCAT(
		CONCAT(pdep.nome, ' ' , pdep.sobrenome) SEPARATOR ' , '
	),
    'Não possui dependenetes'
)AS 'dependentes'
FROM pfunc
LEFT JOIN pdep
ON pfunc.id = pdep.pfunc_id
GROUP BY pfunc.id;