/* UPDATE*/

/*Para modificar uma linha de uma tabela em SQL usamos o UPDATE*/

/*UPDATE 1*/
UPDATE cursos
SET descrisao = 'Curso de HTML5'
WHERE idcurso = '1';

/*UPDATE 2*/
UPDATE cursos
SET descrisao = 'Curso de CSS3'
WHERE idcurso = '2';


/*UPDATE 3*/
UPDATE cursos
SET nome = 'PHP7', ano ='2015';
WHERE idcurso='4';

/*UPDATE 4*/
UPDATE cursos
SET nome = 'PDO7', ano ='2018', carga='50'
WHERE idcurso='5'
LIMIT 1; /* LIMIT - Limita a quantidade de linhas a serem afetadas*/

/*UPDATE 5*/
UPDATE cursos
SET ano = '2050'
WHERE ano='2022';

/*UPDATE 6*/
UPDATE cursos
SET ano = '2022'
WHERE ano='2050'
LIMIT 1;/* LIMIT - Limita a quantidade de linhas a serem afetadas*/

/*DELETE 1*/
/*Para apagar os dados de uma tabela usamos o DELETE*/


/*DELETE 2*/
/* Delete da tabela cursos todos os dados onde o idcurso é igual a 11.*/
DELETE from cursos
WHERE idcurso='11';


/*DELETE 3*/
/* Delete da tabela cursos todos os dados onde o ano do curso é igual 2050*/
DELETE from cursos
WHERE ano = "2022"
LIMIT 2;/* LIMIT - Limita a quantidade de linhas a serem afetadas*/

/*TRUNCATE*/
/*Apaga todos os registro de uma tabela*/


/*TRUNCATE 1*/
TRUNCATE table cursos;



/*TRUNCATE 2*/
TRUNCATE cursos;









