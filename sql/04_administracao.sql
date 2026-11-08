-- Conceitos iniciais de administracao. Executar APOS os dados.
-- Indices auxiliares: chaves estrangeiras nao recebem indices automaticamente no PostgreSQL.
CREATE INDEX idx_produtos_categoria ON produtos(id_categoria);
CREATE INDEX idx_pedidos_cliente ON pedidos(id_cliente);
CREATE INDEX idx_pedidos_data ON pedidos(data_pedido);
CREATE INDEX idx_itens_produto ON itens_pedido(id_produto);

-- Estatisticas para o otimizador.
ANALYZE clientes;
ANALYZE categorias;
ANALYZE produtos;
ANALYZE pedidos;
ANALYZE itens_pedido;

-- Plano de execucao: com poucas linhas, e normal que o PostgreSQL prefira Seq Scan.
EXPLAIN (ANALYZE, BUFFERS)
SELECT p.nome, c.nome AS categoria
FROM produtos p
JOIN categorias c ON c.id_categoria = p.id_categoria
WHERE c.nome = 'Informática';

-- Demonstra transacao reversivel: execute TODO o bloco na mesma sessao.
BEGIN;
UPDATE produtos
SET preco = preco + 10
WHERE nome = 'Mouse Logitech'
RETURNING id_produto, nome, preco;
ROLLBACK;

-- Confirma que o preco permaneceu inalterado.
SELECT nome, preco FROM produtos WHERE nome = 'Mouse Logitech';

-- Backup e restauracao: ver docs/administracao.md (comandos externos ao SQL).
