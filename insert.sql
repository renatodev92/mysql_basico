/* INSERINDO DADOS EM UMA TABELA COM O INSERT*/

/*Através do INSERT INTO podemos inserir dados em uma tabela, criada no banco de dados*/

/*Modelo 01*/
/* Insira na tabela pessoas os valores ...*/

INSERT INTO pessoas (nome, nascimento, sexo, peso, altura, nacionalidade) VALUES ('Godofredo', '1992-11-24', 'M', '78.5', '1.83', 'Brasil' );

/* Insira na tabela pessoas os valores ...*/
/*DEFAUT significa que os dados serão defaut, conforme definidos*/

/*Modelo 02*/
INSERT INTO pessoas (id, nome, nascimento, sexo, peso, altura, nacionalidade) VALUES (DEFAULT', Godofredo', '1992-11-24', 'M', '78.5', '1.83', DEFAULT );


/*Modelo 03*/
INSERT INTO pessoas VALUES (DEFAULT, 'Godofredo', '1992-11-24', 'M', '78.5', '1.83', DEFAULT);

/*Modelo 04 - Inserindo mais de um unico dado*/
INSERT INTO pessoas (id, nome, nascimento, sexo, peso, altura, nacionalidade) VALUES 
(DEFAULT, 'Rafael', '1991-10-28', 'M', '85.2', '1.82', DEFAULT), 
(DEFAULT, 'Samuel', '1993-06-30', 'M', '80.2', '1.85', DEFAULT), 
(DEFAULT, 'Renan', '1994-10-06', 'M', '90.0', '2.84', DEFAULT), 
(DEFAULT, 'Bruna', '1988-03-13', 'F', '92.5', '1.71', DEFAULT);

/*Modelo 05 - Insira na tabela cursos os valores */
INSERT INTO cursos VALUES 
( '1', 'HTML5', 'Curso de HTML 5', '40', '5', '2022'), 
( '2', 'CSS3', 'Curso de CSS 3', '50', '15', '2022'), 
( '3', 'JAVASCRIPT', 'Curso de JAVASCRIPT', '50', '20', '2022'), 
( '4', 'PHP', 'Curso de PHP', '20', '4', '2022'),
( '5', 'PDO', 'Curso de PDO', '30', '3', '2022'),
( '6', 'GIT', 'Curso de GIT', '50', '1', '2022'),
( '7', 'GITHUB', 'Curso de GITHUB', '2', '1', '2022'),
( '8', 'SQL', 'Curso de SQL', '3', '20', '2022'),
( '9', 'JIRA', 'Curso de JIRA', '15', '3', '2022'),
('10', 'NODE', 'Curso de NODE', '10', '10', '2022');




