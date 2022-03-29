/*ALTERANDO DADOS DE UMA TABELA*/

/*ADD - Incluindo no banco de dados cadastro, na tabela pessoas, a coluna profissao tipo varchar(10) */

ALTER TABLE pessoas
ADD column profissao VARCHAR(10);

/*DROP - Removendo no banco de dados cadastro, na tabela pessoas, a coluna profissao. */

ALTER TABLE pessoas
DROP column profissao;

/*AFTER - Incluindo no banco de dados cadastro, na tabela pessoas, a coluna profissao depois do campo nome*/

ALTER TABLE pessoas
ADD column profissao VARCHAR(10) AFTER nome;

/*FIRST -Incluindo no banco de dados cadastro, na tabela pessoas, a coluna numero como o primeiro campo da tabela*/

ALTER TABLE pessoas
ADD numero INT FIRST;


/*MODIFY - Alterando no banco de dados cadastro, na tabela pessoas, a coluna profissao, varchar de (10) para (20)*/
ALTER TABLE pessoas
MODIFY column profissao VARCHAR(20);

/*CHANGE - Alterando no banco de dados cadastro, na tabela pessoas, o nome da coluna profissao para cargo.*/
ALTER TABLE pessoas
CHANGE COLUMN profissao cargo VARCHAR(20);

/*RENAME TO - Alterando no banco de dados cadastro, a tabela pessoas para persons*/
ALTER TABLE pessoas
RENAME TO persons;

/*FIRST -Incluindo no banco de dados cadastro, na tabela cursos, a coluna idcurso como o primeiro campo da tabela*/

ALTER TABLE cursos
ADD column  idcurso INT FIRST;

/*PRIMARY KEY  -Incluindo no banco de dados cadastro, na tabela cursos, a coluna idcurso com a constraints(primary key).*/

ALTER TABLE cursos
ADD PRIMARY KEY (idcurso);



/*DROP*/
/*Para apagar uma tabela inteira ou o bando de dados, podemos utilizar o comando DROP*/
/*Apagando a tabela inteira*/

/*Lembre-se, antes de apagar faça um backup do banco de dados.*/

DROP TABLE cursos; /*Apaga a tabela cursos*/
DROP TABLE pessoas; /*Apaga a tabela pessoas*/

/*Apagando o banco inteiro*/
DROP database cadastro;



