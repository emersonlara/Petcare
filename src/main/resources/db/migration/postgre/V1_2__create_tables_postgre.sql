CREATE TABLE status_fornecedor(
	IDSTATUS INT NOT NULL,
	STATUS VARCHAR(20),
    
    PRIMARY KEY(IDSTATUS)
);

CREATE TABLE fornecedor(
	IDFORNECEDOR SERIAL PRIMARY KEY,
	NOME VARCHAR(100) NOT NULL,
	CNPJ VARCHAR(14) NOT NULL,
	COD_STATUS INT,

    FOREIGN KEY (COD_STATUS)
		REFERENCES status_fornecedor(IDSTATUS)
);


CREATE TABLE status_setor(
	IDSTATUS INT NOT NULL,
	STATUS VARCHAR(20),
    
    PRIMARY KEY(IDSTATUS)
);

CREATE TABLE setor(
    IDSETOR SERIAL PRIMARY KEY,
    SETOR VARCHAR(100) NOT NULL,
    STATUS INT,
    
    FOREIGN KEY(STATUS)
		REFERENCES status_setor(IDSTATUS)
);

CREATE TABLE tipo_produto(
	ID_TIPO SERIAL PRIMARY KEY,
	TIPO VARCHAR(50) NOT NULL,
	DESCRICAO VARCHAR(255),
	COD_STATUS INT NOT NULL
   
);

CREATE TABLE status_produto(
	IDSTATUS INT NOT NULL,
	STATUS VARCHAR(20),
    
    PRIMARY KEY(IDSTATUS)
);

CREATE TABLE produto(
	IDPRODUTO SERIAL PRIMARY KEY,
	COD_TIPO INT, 
	COD_FORNECEDOR INT NOT NULL,
	DESCRICAO VARCHAR(100) NOT NULL,
	MEDIDA VARCHAR(20) NOT NULL,
	VL_COMPRA REAL NOT NULL,
	VL_VENDA REAL,
	STATUS_PRODUTO INT NOT NULL,
    
    CONSTRAINT CK_VLVENDA CHECK(VL_VENDA > VL_COMPRA),
   
    FOREIGN KEY(COD_FORNECEDOR)
    	REFERENCES fornecedor(IDFORNECEDOR),
    FOREIGN KEY(STATUS_PRODUTO)
    	REFERENCES status_produto(IDSTATUS)
    
);

CREATE TABLE TIPO_MOVIMENTO(
	IDTIPOMOVIMENTO INT NOT NULL,
	TIPO_MOVIMENTO VARCHAR(50) NOT NULL,

	PRIMARY KEY(IDTIPOMOVIMENTO)
);

CREATE TABLE movimentacoes(
	IDMOVIMENTACAO SERIAL PRIMARY KEY,
	COD_TIPOMOVIMENTO INT NOT NULL,
	COD_PRODUTO INT,
	COD_SETOR INT ,
	DT_MOVIMENTO TIMESTAMP DEFAULT NOW(),
	QTD_ITENS INT NOT NULL,
	USUARIO VARCHAR(255) NOT NULL,
    VL_UNITARIO REAL NOT NULL,
	

	FOREIGN KEY(COD_PRODUTO)
		REFERENCES produto(IDPRODUTO)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY(COD_SETOR)
		REFERENCES setor(IDSETOR)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY(COD_TIPOMOVIMENTO)
		REFERENCES tipo_movimento(IDTIPOMOVIMENTO)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE TIPO_MEDIDA(
	IDMEDIDA SERIAL PRIMARY KEY,
	DESCRICAO VARCHAR(50) NOT NULL

);



CREATE TABLE roles_status(
	IDSTATUS INT NOT NULL,
	STATUS VARCHAR(20),
    PRIMARY KEY(IDSTATUS)
);

CREATE TABLE roles(
	IDROLE SERIAL PRIMARY KEY,
    DESCRICAO VARCHAR(50) NOT NULL,
    COD_STATUS INT NOT NULL,
   
    FOREIGN KEY(COD_STATUS) 
		REFERENCES roles_status(IDSTATUS)
);

CREATE TABLE users_status(
	IDSTATUS INT NOT NULL,
	STATUS VARCHAR(20),
    PRIMARY KEY(IDSTATUS)
);


CREATE TABLE users(

	IDUSUARIO SERIAL PRIMARY KEY,
	USUARIO VARCHAR(255) NOT NULL,
	DT_NASCIMENTO TIMESTAMP NOT NULL,
    EMAIL VARCHAR(300) NOT NULL,
    SENHA VARCHAR(300) NOT NULL,
    COD_STATUS INT NOT NULL,
    
    FOREIGN KEY(COD_STATUS) 
		REFERENCES users_status(IDSTATUS)
        
);

CREATE TABLE users_roles(
	IDREGISTRO SERIAL PRIMARY KEY,
	COD_USER INT NOT NULL,
    COD_ROLE INT NOT NULL,
	
    
	FOREIGN KEY(COD_USER)
		REFERENCES users(IDUSUARIO)
		ON DELETE CASCADE
  		ON UPDATE CASCADE,
	FOREIGN KEY(COD_ROLE)
		REFERENCES roles(IDROLE)
		ON DELETE CASCADE
  		ON UPDATE CASCADE

);
