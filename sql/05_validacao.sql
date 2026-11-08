-- Verificacao do ambiente apos executar estrutura e dados.
SELECT current_database() AS banco_atual;
SELECT 'categorias' AS tabela, COUNT(*) AS linhas FROM categorias
UNION ALL SELECT 'clientes', COUNT(*) FROM clientes
UNION ALL SELECT 'produtos', COUNT(*) FROM produtos
UNION ALL SELECT 'pedidos', COUNT(*) FROM pedidos
UNION ALL SELECT 'itens_pedido', COUNT(*) FROM itens_pedido;

-- Pedidos sem itens (deve retornar zero linhas neste conjunto).
SELECT p.id_pedido FROM pedidos p
LEFT JOIN itens_pedido i ON i.id_pedido = p.id_pedido
GROUP BY p.id_pedido
HAVING COUNT(i.id_produto) = 0;

-- Integridade de itens por pedido (restricao FK tambem protege).
SELECT i.id_pedido, i.id_produto
FROM itens_pedido i
LEFT JOIN produtos p ON p.id_produto = i.id_produto
WHERE p.id_produto IS NULL;
