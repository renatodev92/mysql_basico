/* CRIANDO O BANCO DE DADOS*/
/* Abaixo estamos criando um banco de dados chamado cadastro*/

CREATE DATABASE cadastro;

/* CRIANDO UMA TABELA DENTRO DO BANCO DE DADOS*/
/* Abaixo estamos criando uma tabela chamada pessoas*/
/*Nunca cadastre idade em um banco de dados, pois idade é um dado dinâmico*/
/*use cadastro;  Informa que estamos criando a tabela nesse banco de dados.Acessando o banco de dados cadastro*/


CREATE TABLE pessoas (
    nome VARCHAR(30), 
    idade TINYINT (3), 
    sexo CHAR(1),
    peso FLOAT,
    altura FLOAT, 
    nacionalidade VARCHAR(20)
);


/*APAGANDO O BANCO DE DADOS*/

DROP DATABASE cadastro; /*A partir de agora o banco 'cadastro' foi excluido */ 

/*CRIANDO O BANCO DE DADOS DE OUTRA FORMA*/
/* setando as configurações de caracteres especiais no banco*/

CREATE DATABASE cadastro
DEFAULT CHARACTER SET utf8 
DEFAULT COLLATE utf8_general_ci;

/* CRIANDO UMA TABELA DENTRO DO BANCO DE DADOS DE OUTA FORMA*/

/* Abaixo estamos criando uma tabela chamada pessoas*/
/*Nunca cadastre idade em um banco de dados, pois idade é um dado dinâmico*/
/*use cadastro;  Informa que estamos criando a tabela nesse banco de dados.Acessando o banco de dados cadastro*/

CREATE TABLE pessoas (
    id INT NOT NULL AUTO_INCREMENT, /*Será gerado o auto incremento automatico*/
    nome VARCHAR(30) NOT NULL,/*Vachar not null - campo obrigatório*/ 
    nascimento DATE, 
    sexo enum('M', 'F'),/*O campo só pode conter M ou F*/
    peso DECIMAL(5,2), /* 5 casas com 2 casas decimais. ex: 102,35*/
    altura DECIMAL(3,2), /* 3 casas com 2 casas decimais. ex: 1,69*/
    nacionalidade varchar(20) DEFAULT 'Brasil', /*Na nacionalidade se ninguém não utilizar nada será default Brasil*/
    PRIMARY KEY (id)
) DEFAULT charset = utf8; /*setando as configurações de caracteres especiais no banco*/

/* Criando uma nova tabela dentro de cadastro*/
/*Só cria a tabela cursos se não existi no banco de dados 'cadastro'*/

CREATE TABLE IF NOT EXISTS cursos (
    nome VARCHAR(30) NOT NULL UNIQUE, 
    descrisao TEXT,
    carga INT UNSIGNED, /* UNSIGNED - Não permite que um número é negativo*/ 
    totauaulas INT,
    ano year DEFAULT '2022'
) DEFAULT charset = utf8;


/* Criando uma nova tabela dentro de cadastro*/
/*Só cria a tabela cursos se não existi no banco de dados 'cadastro'*/

CREATE TABLE IF NOT EXISTS teste (
    id INT,
    nome VARCHAR(10), 
    idade INT
) DEFAULT charset = utf8;







