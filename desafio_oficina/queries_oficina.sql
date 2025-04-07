-- ======================
-- QUERIES OFICINA
-- ======================

USE oficina_db;

-- =============================
-- 1. Listar todos os clientes com nome e tipo (PF ou PJ)
-- =============================
SELECT nome_razao_social, tipo
FROM cliente;

-- =============================
-- 2. Buscar veículos da marca “Chevrolet” cadastrados
-- =============================
SELECT id_veiculo, marca, modelo, placa
FROM veiculo
WHERE marca = 'Chevrolet';

-- =============================
-- 3. Exibir ordens de serviço com o valor total e valor com 10% de desconto
-- =============================
SELECT 
    id_ordem_servico,
    valor AS valor_original,
    ROUND(valor * 0.9, 2) AS valor_com_10_desconto
FROM ordem_servico;

-- =============================
-- 4. Listar todos os serviços com o nome do cliente e descrição da ordem
-- =============================
SELECT 
    s.id_servico,
    c.nome_razao_social AS cliente,
    o.descricao AS descricao_ordem,
    s.tipo AS tipo_servico,
    s.valor
FROM servico s
JOIN ordem_servico o ON s.ordem_servico_id = o.id_ordem_servico
JOIN cliente c ON o.cliente_id = c.id_cliente;

-- =============================
-- 5. Exibir o total de peças utilizadas por serviço (com nomes)
-- =============================
SELECT 
    s.id_servico,
    s.tipo,
    p.nome AS nome_peca,
    sp.quantidade
FROM servico AS s
JOIN servico_produto AS sp ON s.id_servico = sp.servico_id
JOIN produto_peca AS p ON sp.produto_id = p.id_produto
ORDER BY s.id_servico;

desc servico_produto;

-- =============================
-- 6. Serviços que utilizaram mais de 2 unidades de peças (usando HAVING)
-- =============================
SELECT 
    s.id_servico,
    s.tipo,
    SUM(sp.quantidade) AS total_pecas
FROM servico AS s
JOIN servico_produto AS sp ON s.id_servico = sp.servico_id
GROUP BY s.id_servico, s.tipo
HAVING total_pecas > 2
ORDER BY total_pecas DESC;

-- =============================
-- 7. Faturamento total da oficina por mês
-- =============================
SELECT 
    DATE_FORMAT(data_emissao, '%Y-%m') AS mes,
    SUM(valor) AS faturamento_total
FROM ordem_servico
GROUP BY mes
ORDER BY mes;