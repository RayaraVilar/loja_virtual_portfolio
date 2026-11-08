-- Consultas para demonstrar SQL relacional e relatórios.

-- 1. Produtos e suas categorias.
SELECT p.nome AS produto, c.nome AS categoria, p.preco, p.estoque
FROM produtos p
JOIN categorias c ON c.id_categoria = p.id_categoria
ORDER BY p.preco DESC;

-- 2. Clientes e numero de pedidos (inclui clientes sem pedidos).
SELECT c.id_cliente, c.nome, COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY total_pedidos DESC, c.nome;

-- 3. Total de cada pedido (mantem pedidos sem itens, se existirem).
SELECT p.id_pedido, c.nome AS cliente, p.status,
       COALESCE(SUM(i.quantidade * i.preco_unitario), 0) AS total_pedido
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
LEFT JOIN itens_pedido i ON i.id_pedido = p.id_pedido
GROUP BY p.id_pedido, c.nome, p.status
ORDER BY p.id_pedido;

-- 4. Faturamento de pedidos pagos, enviados ou entregues (exclui pendentes/cancelados).
SELECT COALESCE(SUM(i.quantidade * i.preco_unitario), 0) AS valor_pedidos_confirmados
FROM pedidos p
JOIN itens_pedido i ON i.id_pedido = p.id_pedido
WHERE p.status IN ('PAGO', 'ENVIADO', 'ENTREGUE');

-- 5. Produtos nunca vendidos (considera todas as situacoes de pedido).
SELECT p.nome
FROM produtos p
LEFT JOIN itens_pedido i ON i.id_produto = p.id_produto
WHERE i.id_produto IS NULL
ORDER BY p.nome;

-- 6. Ticket medio por pedido confirmado.
WITH totais AS (
  SELECT p.id_pedido, SUM(i.quantidade * i.preco_unitario) AS total
  FROM pedidos p
  JOIN itens_pedido i ON i.id_pedido = p.id_pedido
  WHERE p.status IN ('PAGO', 'ENVIADO', 'ENTREGUE')
  GROUP BY p.id_pedido
)
SELECT ROUND(AVG(total), 2) AS ticket_medio FROM totais;

-- 7. Categorias com mais de um produto.
SELECT c.nome AS categoria, COUNT(p.id_produto) AS quantidade_produtos
FROM categorias c
JOIN produtos p ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nome
HAVING COUNT(p.id_produto) > 1
ORDER BY quantidade_produtos DESC, categoria;

-- 8. Relatorio mensal de pedidos confirmados.
SELECT DATE_TRUNC('month', p.data_pedido)::date AS mes,
       COUNT(DISTINCT p.id_pedido) AS pedidos,
       SUM(i.quantidade * i.preco_unitario) AS valor
FROM pedidos p
JOIN itens_pedido i ON i.id_pedido = p.id_pedido
WHERE p.status IN ('PAGO', 'ENVIADO', 'ENTREGUE')
GROUP BY DATE_TRUNC('month', p.data_pedido)
ORDER BY mes;
