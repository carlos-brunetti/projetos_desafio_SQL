CREATE DATABASE IF NOT EXISTS oficina_db;
USE oficina_db;

show databases;
-- Tabela cliente (PF ou PJ, mas nunca ambos)
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('PF', 'PJ') NOT NULL,
    nome_razao_social VARCHAR(100) NOT NULL,
    documento VARCHAR(20) UNIQUE NOT NULL, -- CPF ou CNPJ
    endereco VARCHAR(255),
    contato VARCHAR(45),
    CONSTRAINT chk_tipo_documento CHECK (
        (tipo = 'PF' AND CHAR_LENGTH(documento) = 11)
        OR (tipo = 'PJ' AND CHAR_LENGTH(documento) = 14)
    )
);

-- Tabela veículo
CREATE TABLE veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(45) NOT NULL,
    modelo VARCHAR(45) NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

-- Tabela ordem de serviço
CREATE TABLE ordem_servico (
    id_ordem_servico INT AUTO_INCREMENT PRIMARY KEY,
    status ENUM('Aberta', 'Em andamento', 'Concluída', 'Cancelada') NOT NULL,
    data_emissao DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    descricao TEXT,
    data_conclusao DATE,
    cliente_id INT NOT NULL,
    veiculo_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (veiculo_id) REFERENCES veiculo(id_veiculo) ON DELETE CASCADE
);

-- Tabela mecânico
CREATE TABLE mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255),
    contato VARCHAR(45)
);

-- Relação mecânico x ordem de serviço (N:M)
CREATE TABLE mecanico_ordem (
    mecanico_id INT,
    ordem_servico_id INT,
    especialidade VARCHAR(100),
    PRIMARY KEY (mecanico_id, ordem_servico_id),
    FOREIGN KEY (mecanico_id) REFERENCES mecanico(id_mecanico) ON DELETE CASCADE,
    FOREIGN KEY (ordem_servico_id) REFERENCES ordem_servico(id_ordem_servico) ON DELETE CASCADE
);

-- Tabela serviço
CREATE TABLE servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('Conserto', 'Revisão') NOT NULL,
    descricao TEXT,
    valor DECIMAL(10,2) NOT NULL,
    ordem_servico_id INT NOT NULL,
    FOREIGN KEY (ordem_servico_id) REFERENCES ordem_servico(id_ordem_servico) ON DELETE CASCADE
);

-- Tabela produto/peça
CREATE TABLE produto_peca (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor DECIMAL(10,2) NOT NULL
);

-- Relação serviço x produto/peça (N:M)
CREATE TABLE servico_produto (
    servico_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (servico_id, produto_id),
    FOREIGN KEY (servico_id) REFERENCES servico(id_servico) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto_peca(id_produto) ON DELETE CASCADE
);
