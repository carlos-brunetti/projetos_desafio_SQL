-- 	QUERIES

-- Total de clientes:
SELECT COUNT(*) as total_clientes FROM clients;	

-- Todos os pedidos com dados dos clientes:
SELECT * 
FROM clients c 
JOIN orders o ON c.id_client = o.id_client;

-- Nome e status do pedido:
SELECT first_name, last_name, id_order, order_status 
FROM clients c 
JOIN orders o ON c.id_client = o.id_client;

-- Nome completo, ID do pedido e status:
SELECT CONCAT(first_name, ' ', last_name) AS client, 
       id_order AS request, 
       order_status AS status 
FROM clients c 
JOIN orders o ON c.id_client = o.id_client;

-- Quantidade de pedidos feitos por todos os clientes:
SELECT COUNT(*) 
FROM clients c 
JOIN orders o ON c.id_client = o.id_client;

-- Recuperar pedidos com produto associado:
SELECT c.id_client, 
       CONCAT(first_name, ' ', last_name) AS client_name,
       COUNT(po.id_product) AS total_products_ordered
FROM clients c
JOIN orders o ON c.id_client = o.id_client
JOIN product_order po ON po.id_order = o.id_order
GROUP BY c.id_client, client_name;

-- Clientes com mais de 1 pedido
SELECT 
  c.id_client,
  CONCAT(first_name, ' ', last_name) AS nome_completo,
  COUNT(o.id_order) AS total_pedidos
FROM clients c
JOIN orders o ON c.id_client = o.id_client
GROUP BY c.id_client, nome_completo
HAVING COUNT(o.id_order) > 1
ORDER BY total_pedidos DESC;

-- Cliente, Pedido, Produto, Fornecedor
SELECT 
  c.id_client,
  CONCAT(c.first_name, ' ', c.last_name) AS cliente,
  o.id_order,
  p.name AS produto,
  s.social_name AS fornecedor
FROM clients c
JOIN orders o ON c.id_client = o.id_client
JOIN product_order po ON o.id_order = po.id_order
JOIN product p ON po.id_product = p.id_product
JOIN product_supplier ps ON p.id_product = ps.id_product
JOIN supplier s ON ps.id_supplier = s.id_supplier
ORDER BY cliente, o.id_order;

-- Produtos por Local de Estoque e Quantidade Total
SELECT 
  p.name AS produto,
  sl.location AS local_estoque,
  ps.quantity AS quantidade_armazenada
FROM product p
JOIN storage_location sl ON p.id_product = sl.id_product
JOIN product_storage ps ON sl.id_product_storage = ps.id_product_storage
ORDER BY local_estoque, produto;

-- Total de Pagamentos por Tipo
SELECT 
  type_payment,
  COUNT(*) AS total_pagamentos,
  ROUND(SUM(limit_available), 2) AS total_limite_disponivel
FROM payments
GROUP BY type_payment
ORDER BY total_pagamentos DESC;

-- Pagamentos por Cliente (com nome completo)
SELECT 
  c.id_client,
  CONCAT(c.first_name, ' ', c.last_name) AS nome_cliente,
  p.type_payment,
  p.limit_available
FROM payments p
JOIN clients c ON p.id_client = c.id_client
ORDER BY nome_cliente;

-- Consulta para verificar se algum vendedor também é fornecedor:
SELECT 
  s.id_seller,
  s.social_name AS nome_vendedor,
  su.id_supplier,
  su.social_name AS nome_fornecedor,
  s.cnpj AS cnpj_vendedor,
  su.cnpj AS cnpj_fornecedor
FROM seller s
JOIN supplier su ON s.cnpj = su.cnpj;

