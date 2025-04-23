--Criou a tabela com uma restrição
CREATE TABLE pessoa (
	ID INT NOT NULL,
	nome VARCHAR(20) NOT NULL,
	sobrenome VARCHAR(40) NOT NULL,
	idade INT,
	PRIMARY KEY (ID),
	CHECK (idade > 0)
);

--Garantiu que não irá ser criado "uma pessoa duas vezes" podendo ter apenas um mesmo conjunto de dados
ALTER TABLE pessoa ADD CONSTRAINT ID_NOME_SOBRENOME UNIQUE(ID, nome, sobrenome);

--alterei a tabela depois dela ser criada alterando e colocando uma condição para que idade não seja nula
ALTER TABLE pessoa ALTER COLUMN idade INT NOT NULL;

--Criei a tabela endereço.
CREATE TABLE endereco (
	ID_ENDERECO INT NOT NULL,
	rua VARCHAR (50),
	PRIMARY KEY (ID_ENDERECO)
);
--Adicionei a coluna ID_endereco a tabela pessoa
ALTER TABLE pessoa ADD COLUMN id_endereco INT;
--aqui adicionei uma nova regra na tabela pessoa, no caso coloquei a coluna id_endereco como uma foreign key e para evitar por exemplo de excluir um endereco que alguem utilize ou atualizar um endereco que alguma pessoa utilize colocamos on delete cascade para que seja excluido tanto o endereco quanto a pessoa ou visse versa e on update cascade para quando atualizar algu endereco atualizar nas duas tabelas
ALTER TABLE pessoa ADD CONSTRAINT FK_endereco FOREIGN KEY (id_endereco) references endereco(ID_ENDERECO) on DELETE CASCADE ON UPDATE CASCADE;
