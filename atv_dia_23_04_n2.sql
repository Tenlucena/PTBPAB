--1
CREATE SCHEMA avaliacaocontinua;

--2 Tabela company
CREATE TABLE avaliacaocontinua.company (
	company_name VARCHAR(50) NOT NULL,
	city VARCHAR(50),
	PRIMARY KEY (company_name)
);

--3 Tabela employee
CREATE TABLE avaliacaocontinua.employee (
	person_name VARCHAR(50) NOT NULL,
	street VARCHAR(50),
	city VARCHAR(50),
	PRIMARY KEY (person_name)
);

--4 Tabela manages
CREATE TABLE avaliacaocontinua.manages (
	person_name VARCHAR(50) NOT NULL,
	manager_name VARCHAR(50),
	PRIMARY KEY (person_name)
);

--5 Tabela works
CREATE TABLE avaliacaocontinua.works (
	person_name VARCHAR(50) NOT NULL,
	company_name VARCHAR(50) NOT NULL,
	salary INT,
	PRIMARY KEY (person_name)
);

--6 Chave estrangeira works → employee
ALTER TABLE avaliacaocontinua.works 
ADD CONSTRAINT FK_person_name 
FOREIGN KEY (person_name) 
REFERENCES avaliacaocontinua.employee(person_name) 
ON DELETE CASCADE ON UPDATE CASCADE;

--7 Chave estrangeira works → company
ALTER TABLE avaliacaocontinua.works 
ADD CONSTRAINT FK_company_name 
FOREIGN KEY (company_name) 
REFERENCES avaliacaocontinua.company(company_name) 
ON DELETE CASCADE ON UPDATE CASCADE;

--8 Chave estrangeira manages → employee
ALTER TABLE avaliacaocontinua.manages 
ADD CONSTRAINT FK_person_name_manages 
FOREIGN KEY (person_name) 
REFERENCES avaliacaocontinua.employee(person_name) 
ON DELETE CASCADE ON UPDATE CASCADE;
