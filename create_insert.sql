-- Criação do banco de dados
CREATE DATABASE hospital_management;
USE hospital_management;

-- Tabela de Convênios
CREATE TABLE convenios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    tempo_carencia INT 
);

-- Tabela de Especialidades Médicas
CREATE TABLE especialidades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela de Médicos
CREATE TABLE medicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) UNIQUE NOT NULL ,
    email VARCHAR(100),
    especialidade_id INT NOT NULL,
    FOREIGN KEY (especialidade_id) REFERENCES especialidades(id)
);

-- Tabela de Pacientes
CREATE TABLE pacientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    rg VARCHAR(20) NOT NULL,
    convenio_id INT,
    FOREIGN KEY (convenio_id) REFERENCES convenios(id)
);

-- Tabela de Consultas
CREATE TABLE consultas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_consulta DATETIME NOT NULL,
    medico_id INT NOT NULL,
    paciente_id INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    convenio_id INT,
    especialidade_id INT NOT NULL,
    FOREIGN KEY (medico_id) REFERENCES medicos(id),
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    FOREIGN KEY (convenio_id) REFERENCES convenios(id),
    FOREIGN KEY (especialidade_id) REFERENCES especialidades(id)
);

-- Tabela de Internações (relacionada com consultas)
CREATE TABLE internacoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    consulta_id INT UNIQUE NOT NULL,
    data_entrada DATETIME NOT NULL,
    data_saida DATETIME,
    quarto VARCHAR(10) NOT NULL,
    FOREIGN KEY (consulta_id) REFERENCES consultas(id)
);

--             ######     Povoamento  ######

-- Insert Convenios
INSERT INTO convenios (nome, cnpj, tempo_carencia) VALUES
    ('Saúde Total', '12345678000101', 180),
    ('Bem Estar', '98765432000102', 90),
    ('MedMais', '45678912000103', 120),
    ('Vida Plena', '32165498000104', 60);
    
-- Insert especialidades
INSERT INTO especialidades (nome) VALUES
    ('Cardiologia'),
    ('Ortopedia'),
    ('Pediatria'),
    ('Dermatologia'),
    ('Neurologia');
    
 -- Insert médicos
INSERT INTO medicos (nome, crm, email, especialidade_id) VALUES
    ('Dr. Carlos Silva', 'SP-44312', 'carlos.silva@hospital.com', 1),
    ('Dra. Ana Oliveira', 'RJ-23333', 'ana.oliveira@hospital.com', 2),
    ('Dr. Marcos Souza', 'MG-98765', 'marcos.souza@hospital.com', 3),
    ('Dra. Juliana Costa', 'SP-45678', 'juliana.costa@hospital.com', 4),
    ('Dr. Roberto Almeida', 'RJ-13579', 'roberto.almeida@hospital.com', 5);   
    
-- Insert pacientes
INSERT INTO pacientes (nome, data_nascimento, cpf, rg, convenio_id) VALUES
    ('Maria Santos', '1985-03-15', '12345678901', '1234567', 1),
    ('João Pereira', '1990-07-22', '98765432109', '7654321', 2),
    ('Ana Costa', '1978-11-30', '45678912304', '9876543', 1),
    ('Pedro Oliveira', '2005-05-10', '32165498705', '4567890', 3),
    ('Lucia Mendes', '1995-09-18', '78912345606', '2345678', NULL);
    
    -- Insert consultas
INSERT INTO consultas (data_consulta, medico_id, paciente_id, valor, convenio_id, especialidade_id) VALUES
    ('2023-06-10 09:00:00', 1, 1, 250.00, 1, 1),
    ('2023-06-10 10:30:00', 2, 2, 180.00, 2, 2),
    ('2023-06-11 14:00:00', 3, 3, 150.00, 1, 3),
    ('2023-06-12 11:00:00', 4, 4, 200.00, 3, 4),
    ('2023-06-13 16:30:00', 5, 5, 300.00, NULL, 5),
    ('2023-06-14 08:00:00', 1, 2, 250.00, 2, 1),
    ('2023-06-15 10:00:00', 3, 1, 150.00, 1, 3);
    
    -- Insert internações
INSERT INTO internacoes (consulta_id, data_entrada, data_saida, quarto) VALUES
    (1, '2023-06-10 12:00:00', '2023-06-15 10:00:00', '201A'),
    (4, '2023-06-12 15:00:00', '2023-06-14 11:00:00', '305B');
INSERT INTO internacoes (consulta_id, data_entrada, data_saida, quarto) VALUES
    (6, '2023-06-18 08:00:00', NULL, '102C');
    


    
    
      

