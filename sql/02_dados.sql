-- Dados exclusivamente ficticios para estudo.
-- Execute apenas UMA vez, depois de 01_estrutura.sql.
BEGIN;

INSERT INTO categorias (nome) VALUES
('Eletrônicos'), ('Informática'), ('Acessórios'), ('Casa e Escritório');

INSERT INTO clientes (nome, email, cidade, uf) VALUES
('Ana Oliveira', 'ana.oliveira@example.com', 'João Pessoa', 'PB'),
('Carlos Mendes', 'carlos.mendes@example.com', 'Recife', 'PE'),
('Mariana Silva', 'mariana.silva@example.com', 'Campina Grande', 'PB'),
('Pedro Almeida', 'pedro.almeida@example.com', 'Natal', 'RN'),
('Juliana Costa', 'juliana.costa@example.com', 'Fortaleza', 'CE'),
('Rafael Sousa', 'rafael.sousa@example.com', 'João Pessoa', 'PB'),
('Beatriz Lima', 'beatriz.lima@example.com', 'Recife', 'PE'),
('Lucas Ribeiro', 'lucas.ribeiro@example.com', 'Patos', 'PB');

-- Busca ID por nome para nao depender dos numeros gerados.
INSERT INTO produtos (nome, preco, estoque, id_categoria) VALUES
('Notebook Dell', 3500.00, 10, (SELECT id_categoria FROM categorias WHERE nome = 'Informática')),
('Mouse Logitech', 120.00, 25, (SELECT id_categoria FROM categorias WHERE nome = 'Acessórios')),
('Smartphone Samsung', 1800.00, 15, (SELECT id_categoria FROM categorias WHERE nome = 'Eletrônicos')),
('Teclado Mecânico', 290.00, 18, (SELECT id_categoria FROM categorias WHERE nome = 'Acessórios')),
('Monitor 24 polegadas', 950.00, 8, (SELECT id_categoria FROM categorias WHERE nome = 'Informática')),
('Webcam Full HD', 260.00, 12, (SELECT id_categoria FROM categorias WHERE nome = 'Acessórios')),
('Fone Bluetooth', 220.00, 20, (SELECT id_categoria FROM categorias WHERE nome = 'Eletrônicos')),
('Cadeira de Escritório', 790.00, 5, (SELECT id_categoria FROM categorias WHERE nome = 'Casa e Escritório')),
('Suporte Notebook', 85.00, 30, (SELECT id_categoria FROM categorias WHERE nome = 'Casa e Escritório')),
('Tablet 10 polegadas', 1400.00, 7, (SELECT id_categoria FROM categorias WHERE nome = 'Eletrônicos'));

INSERT INTO pedidos (id_cliente, data_pedido, status) VALUES
((SELECT id_cliente FROM clientes WHERE email = 'ana.oliveira@example.com'), '2026-10-03 09:00', 'ENTREGUE'),
((SELECT id_cliente FROM clientes WHERE email = 'carlos.mendes@example.com'), '2026-10-04 10:30', 'PAGO'),
((SELECT id_cliente FROM clientes WHERE email = 'mariana.silva@example.com'), '2026-10-06 14:20', 'ENVIADO'),
((SELECT id_cliente FROM clientes WHERE email = 'pedro.almeida@example.com'), '2026-10-08 16:00', 'PENDENTE'),
((SELECT id_cliente FROM clientes WHERE email = 'juliana.costa@example.com'), '2026-10-10 11:15', 'ENTREGUE'),
((SELECT id_cliente FROM clientes WHERE email = 'ana.oliveira@example.com'), '2026-10-11 13:40', 'PAGO'),
((SELECT id_cliente FROM clientes WHERE email = 'rafael.sousa@example.com'), '2026-10-12 08:50', 'CANCELADO'),
((SELECT id_cliente FROM clientes WHERE email = 'beatriz.lima@example.com'), '2026-10-14 17:30', 'ENTREGUE');

-- Preco unitario representa o valor do produto na data do pedido (historico).
-- Os IDs dos pedidos sao conhecidos por sua data_pedido no conjunto de teste.
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario)
SELECT ped.id_pedido, pro.id_produto, v.quantidade, v.preco_unitario
FROM (VALUES
 ('2026-10-03 09:00'::timestamp, 'Notebook Dell', 1, 3500.00::numeric),
 ('2026-10-03 09:00'::timestamp, 'Mouse Logitech', 2, 120.00::numeric),
 ('2026-10-04 10:30'::timestamp, 'Smartphone Samsung', 1, 1800.00::numeric),
 ('2026-10-04 10:30'::timestamp, 'Fone Bluetooth', 1, 220.00::numeric),
 ('2026-10-06 14:20'::timestamp, 'Monitor 24 polegadas', 1, 950.00::numeric),
 ('2026-10-08 16:00'::timestamp, 'Teclado Mecânico', 1, 290.00::numeric),
 ('2026-10-10 11:15'::timestamp, 'Cadeira de Escritório', 1, 790.00::numeric),
 ('2026-10-10 11:15'::timestamp, 'Suporte Notebook', 2, 85.00::numeric),
 ('2026-10-11 13:40'::timestamp, 'Webcam Full HD', 2, 260.00::numeric),
 ('2026-10-12 08:50'::timestamp, 'Tablet 10 polegadas', 1, 1400.00::numeric),
 ('2026-10-14 17:30'::timestamp, 'Mouse Logitech', 1, 120.00::numeric),
 ('2026-10-14 17:30'::timestamp, 'Teclado Mecânico', 1, 290.00::numeric)
) AS v(data_pedido, nome_produto, quantidade, preco_unitario)
JOIN pedidos ped ON ped.data_pedido = v.data_pedido
JOIN produtos pro ON pro.nome = v.nome_produto;

COMMIT;
