
use oficina_db;

INSERT INTO cliente (tipo, nome_razao_social, documento, endereco, contato) VALUES
('PF', 'Carlos Eduardo Almeida', '12345678901', 'Rua das Flores, 123, Curitiba - PR', '(41) 99999-1234'),
('PF', 'Mariana Souza Silva', '98765432100', 'Av. Brasil, 456, Londrina - PR', '(43) 98888-4321'),
('PF', 'João Pedro Costa', '45678912300', 'Rua XV de Novembro, 789, Maringá - PR', '(44) 97777-6789'),
('PJ', 'Oficina Rápida Ltda', '12345678000199', 'Rua do Comércio, 1500, Curitiba - PR', '(41) 3333-1122'),
('PJ', 'Auto Mecânica União', '98765432000188', 'Rua da Liberdade, 200, São José dos Pinhais - PR', '(41) 3222-4455'),
('PJ', 'Revisacar Serviços Automotivos', '19283746000177', 'Av. Sete de Setembro, 999, Ponta Grossa - PR', '(42) 3666-9988');

select * from cliente;

INSERT INTO veiculo (marca, modelo, placa, cliente_id) VALUES
-- PF
('Volkswagen', 'Gol', 'ABC1D23', 1),
('Ford', 'Ka', 'DEF4G56', 2),
('Fiat', 'Uno', 'GHI7J89', 2),
('Chevrolet', 'Onix', 'JKL0M12', 3),

-- PJ
('Renault', 'Master', 'MNO3P45', 4),
('Fiat', 'Fiorino', 'PQR6S78', 4),
('Hyundai', 'HR', 'STU9V01', 5),
('Peugeot', 'Partner', 'VWX2Y34', 5),
('Volkswagen', 'Saveiro', 'YZA5B67', 6);

select * from veiculo;

INSERT INTO ordem_servico (status, data_emissao, valor, descricao, data_conclusao, cliente_id, veiculo_id) VALUES
('Aberta', '2025-04-01', 350.00, 'Troca de óleo e revisão básica', NULL, 1, 1),
('Concluída', '2025-03-10', 1200.00, 'Troca de embreagem', '2025-03-12', 2, 2),
('Cancelada', '2025-03-20', 900.00, 'Reparo no sistema de freio', NULL, 2, 3),
('Concluída', '2025-02-05', 500.00, 'Alinhamento e balanceamento', '2025-02-06', 3, 4),
('Em andamento', '2025-04-05', 1600.00, 'Revisão geral', NULL, 4, 5),
('Aberta', '2025-04-06', 300.00, 'Substituição de lâmpadas', NULL, 4, 6),
('Concluída', '2025-03-01', 800.00, 'Troca de amortecedores', '2025-03-04', 5, 7),
('Em andamento', '2025-04-02', 1100.00, 'Revisão de motor', NULL, 5, 8),
('Concluída', '2025-02-15', 250.00, 'Limpeza do sistema de arrefecimento', '2025-02-16', 6, 9),
('Aberta', '2025-04-07', 700.00, 'Diagnóstico eletrônico', NULL, 6, 9);

select * from ordem_servico;

INSERT INTO mecanico (nome, endereco, contato) VALUES
('José Antônio da Silva', 'Rua dos Mecânicos, 100, Curitiba - PR', '(41) 98888-0001'),
('Marcos Vinícius Pereira', 'Av. dos Trabalhadores, 234, Colombo - PR', '(41) 98888-0002'),
('Carla Fernanda Lopes', 'Rua do Motor, 567, São José dos Pinhais - PR', '(41) 98888-0003'),
('Rafael de Oliveira', 'Av. Industrial, 890, Curitiba - PR', '(41) 98888-0004');

select * from mecanico;

INSERT INTO mecanico_ordem (mecanico_id, ordem_servico_id, especialidade) VALUES
(1, 1, 'Revisão básica'),
(2, 2, 'Transmissão'),
(2, 3, 'Freios'),
(3, 4, 'Suspensão e alinhamento'),
(1, 5, 'Revisão geral'),
(3, 6, 'Elétrica'),
(4, 7, 'Suspensão'),
(1, 8, 'Motor'),
(2, 8, 'Injeção eletrônica'),
(3, 9, 'Arrefecimento'),
(4, 10, 'Diagnóstico eletrônico');

select * from mecanico_ordem;

INSERT INTO servico (tipo, descricao, valor, ordem_servico_id) VALUES
('Revisão', 'Revisão básica com troca de óleo e filtros', 350.00, 1),
('Conserto', 'Troca completa de embreagem', 1200.00, 2),
('Conserto', 'Reparo completo no sistema de freios', 900.00, 3),
('Revisão', 'Alinhamento e balanceamento', 500.00, 4),
('Revisão', 'Checklist completo com troca de óleo', 1600.00, 5),
('Conserto', 'Substituição de lâmpadas do painel e farol', 300.00, 6),
('Conserto', 'Troca de amortecedores dianteiros', 800.00, 7),
('Conserto', 'Análise de motor com revisão do cabeçote', 1100.00, 8),
('Revisão', 'Limpeza do sistema de arrefecimento', 250.00, 9),
('Revisão', 'Diagnóstico eletrônico completo com scanner', 700.00, 10);

INSERT INTO produto_peca (nome, valor) VALUES
('Óleo 10W40 - 1L', 45.00),
('Filtro de óleo', 30.00),
('Kit embreagem', 600.00),
('Pastilha de freio', 150.00),
('Lâmpada H7', 35.00),
('Amortecedor dianteiro', 200.00),
('Jogo de velas', 120.00),
('Aditivo para radiador', 25.00),
('Scanner diagnóstico', 150.00),
('Correia dentada', 180.00);

INSERT INTO servico_produto (servico_id, produto_id, quantidade) VALUES
(1, 1, 3),  -- 3L de óleo
(1, 2, 1),  -- 1 filtro de óleo
(2, 3, 1),  -- kit embreagem
(3, 4, 1),  -- pastilha de freio
(5, 1, 3),
(5, 2, 1),
(6, 5, 2),  -- 2 lâmpadas
(7, 6, 2),  -- amortecedores dianteiros
(8, 7, 1),  -- jogo de velas
(9, 8, 2),  -- aditivo para radiador
(10, 9, 1); -- scanner



