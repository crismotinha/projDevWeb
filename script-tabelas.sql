CREATE TABLE Usuario (
id					INTEGER				PRIMARY KEY AUTO_INCREMENT,        
email				VARCHAR(60)       	NOT NULL,
senha				VARCHAR(40)        	NOT NULL,
saldo				DECIMAL(12,2)		NOT NULL);

CREATE TABLE Conta (
id					INTEGER				PRIMARY KEY AUTO_INCREMENT, 
agencia				CHAR(4)				NOT NULL,
numero_conta		CHAR(6)				NOT NULL,
id_usuario			INTEGER				NOT NULL,
FOREIGN KEY(id_usuario) REFERENCES Usuario(id));

CREATE TABLE Transacao (
id					INTEGER				PRIMARY KEY AUTO_INCREMENT, 
valor				DECIMAL(12,2)		NOT NULL,
descricao			VARCHAR(500)		NOT NULL,
id_conta			INTEGER				NOT NULL,
FOREIGN KEY(id_conta) REFERENCES Conta(id));