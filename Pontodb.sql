CREATE DATABASE IF NOT EXISTS controle_ponto_esp32;
USE controle_ponto_esp32;

-- =========================
-- TABELA PESSOA
-- =========================
CREATE TABLE Pessoa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    sexo ENUM('M','F','Outro'),
    telefone VARCHAR(20),
    data_nascimento DATE,
    rua VARCHAR(100),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    pais VARCHAR(50)
);

-- =========================
-- TABELA VISITANTE
-- =========================
CREATE TABLE Visitante (
    id_visitante INT AUTO_INCREMENT PRIMARY KEY,
    id_pessoa INT NOT NULL,
    entrada DATETIME,
    saida DATETIME,
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id)
);

-- =========================
-- TABELA FUNCIONARIO
-- =========================
CREATE TABLE Funcionario (
    codigo_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    id_pessoa INT NOT NULL,
    funcao VARCHAR(50),
    data_admissao DATE,
    is_supervisor BOOLEAN DEFAULT 0,
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id)
);


-- =========================
-- TABELA SALARIO
-- =========================
CREATE TABLE Salario (
    codigo_salario INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    data_atualizacao DATE DEFAULT (CURRENT_DATE)
);

-- =========================
-- TABELA POSSUI (FUNCIONARIO x SALARIO)
-- =========================
CREATE TABLE Possui (
    codigo_funcionario INT NOT NULL,
    codigo_salario INT NOT NULL,
    PRIMARY KEY (codigo_funcionario, codigo_salario),
    FOREIGN KEY (codigo_funcionario) REFERENCES Funcionario(codigo_funcionario),
    FOREIGN KEY (codigo_salario) REFERENCES Salario(codigo_salario)
);

-- =========================
-- TABELA HORA EXTRA
-- =========================
CREATE TABLE HoraExtra (
    id_hora_extra INT AUTO_INCREMENT PRIMARY KEY,
    codigo_funcionario INT NOT NULL,
    bonus DECIMAL(10,2),
    data_hora DATETIME,
    FOREIGN KEY (codigo_funcionario) REFERENCES Funcionario(codigo_funcionario)
);

-- =========================
-- TABELA REGISTRO DE PONTO
-- =========================
CREATE TABLE RegistroPonto (
    id_ponto INT AUTO_INCREMENT PRIMARY KEY,
    codigo_funcionario INT NOT NULL,
    horario_chegada DATETIME,
    horario_saida DATETIME,
    data_hora_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (codigo_funcionario) REFERENCES Funcionario(codigo_funcionario)
);
