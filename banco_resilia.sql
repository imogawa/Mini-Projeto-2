CREATE DATABASE banco_resilia;
USE banco_resilia;

CREATE TABLE cursos (
id INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR (100)
);

CREATE TABLE facilitadores (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100),
skills VARCHAR (30)
);

CREATE TABLE turmas (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100),
cursos_id INT,
facilitadores_id INT,
FOREIGN KEY (cursos_id) REFERENCES cursos (id),
FOREIGN KEY (facilitadores_id) REFERENCES facilitadores (id)
);

SELECT * FROM turmas;

CREATE TABLE alunos (
cpf VARCHAR (11) PRIMARY KEY,
nome VARCHAR (100), 
data_de_nascimento DATE,
turmas_id INT,
FOREIGN KEY (turmas_id) REFERENCES turmas (id)
);

SELECT * FROM alunos;

CREATE TABLE entregas (
link VARCHAR (150),
modulo INT, 
conceito VARCHAR (50),
alunos_cpf VARCHAR (11),
FOREIGN KEY (alunos_cpf) REFERENCES alunos (cpf)
);

#Alterando a tabela alunos para inserir o atributo "email"
ALTER TABLE alunos ADD email TEXT AFTER nome;

#Alterando a tabela turmas para inserir o atributo "número"
ALTER TABLE turmas ADD numero INT AFTER id;

#Populando tabelas

INSERT INTO cursos (tipo) 
VALUES ('Web Dev Full Stack'),
('Data Analytics');

INSERT INTO facilitadores (nome, skills) 
VALUES ('Joana', 'Hard Skills'),
('Naiara', 'Soft Skills');

INSERT INTO turmas (nome, numero, cursos_id, facilitadores_id)
VALUES ('Geração Futuro', 19, 1, 2), 
	('Geração Analise', 20, 2, 1);
    
    SELECT * FROM turmas;

INSERT INTO entregas (link, modulo, conceito, alunos_cpf)
VALUES ('https://github.com/priminhavera/repoProjetoFinal1', 1, 'mais que pronto', '1212223352' ),
('https://github.com/tatis/repoProjetoFinal1', 1, 'pronto', '1214227352'),
('https://github.com/uliss_es/repoProjetoFinal1', 1, 'pronto', '3212223459'),
('https://github.com/germanias/repoProjetoFinal1', 1, 'ainda não está pronto', '1212453352'),
('https://github.com/nora_git/repoProjetoFinal1', 1, 'chegando lá', '1212212852'),
('https://github.com/jokeline-line/repoProjetoFinal1', 1, 'mais que pronto', '1212223378'),
('https://github.com/whre_is_wally/repoProjetoFinal1', 1, 'pronto', '8912225352');

INSERT INTO alunos (nome, email, cpf, data_de_nascimento, turmas_id)
VALUES ('Primavera', 'prima_vera@outlook.com', '1212223352', '2000-10-08', 1),
('Tatiana', 'tatianalindinha@gmail.com', '1214227352', '2002-11-07', 1),
('Ulisses', 'uliss_es@gmail.com', '3212223459', '1999-01-18', 2),
('Germania', 'germanianota@gmail.com', '1212453352', '2001-12-12', 1),
('Nora', 'nora_nora@hotmail.com', '1212212852', '2000-05-02', 2),
('Jokeline', 'jokelin_ee@gmail.com', '1212223378', '1998-12-25', 1),
('Wally', 'w_a_lly@gmail.com', '8912225352', '2003-06-13', 1);


# Quem são os alunos que entregaram o projeto de Módulo 1 e estão com o conceito em "pronto" ou "mais que pronto"?
SELECT * FROM entregas
	WHERE modulo = 1 AND conceito = 'pronto' OR 'mais que pronto';
    
# Quantos alunos temos em cada turma?
SELECT turmas_id AS turmas, COUNT(turmas_id) AS quantidade_de_alunos FROM alunos
	GROUP BY turmas_id;
    
# Quantos projetos no total (entre todas as turmas) foram entregues com conceito "ainda não está pronto" e "chegando lá"?
SELECT COUNT(conceito) AS projetos_em_andamento FROM entregas
	WHERE conceito = 'Ainda não está pronto' OR conceito = 'chegando lá';

# Qual a turma com maior quantidade de projetos no "mais que pronto"?
SELECT turmas_id AS turma, count(conceito) AS projetos_concluidos FROM alunos
	INNER JOIN entregas ON alunos.CPF = entregas.alunos_cpf
    WHERE conceito = 'Mais que pronto'
    GROUP BY turmas_id
    ORDER BY projetos_concluidos DESC;
