-- PROJETO 01 | Loja Virtual | PostgreSQL 18
-- Execute em um banco NOVO e vazio (ex.: loja_virtual_portfolio).
-- Este script nao apaga tabelas existentes.

BEGIN;

CREATE TABLE categorias (
    id_categoria INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE clientes (
    id_cliente INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    cidade VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL,
    data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_clientes_uf CHECK (uf ~ '^[A-Z]{2}$')
);

CREATE TABLE produtos (
    id_produto INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    preco NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
    estoque INTEGER NOT NULL DEFAULT 0 CHECK (estoque >= 0),
    id_categoria INTEGER NOT NULL REFERENCES categorias(id_categoria),
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE pedidos (
    id_pedido INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES clientes(id_cliente),
    data_pedido TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',
    CONSTRAINT chk_pedido_status CHECK
      (status IN ('PENDENTE', 'PAGO', 'ENVIADO', 'ENTREGUE', 'CANCELADO'))
);

CREATE TABLE itens_pedido (
    id_pedido INTEGER NOT NULL REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    id_produto INTEGER NOT NULL REFERENCES produtos(id_produto),
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario NUMERIC(10,2) NOT NULL CHECK (preco_unitario >= 0),
    PRIMARY KEY (id_pedido, id_produto)
);

COMMIT;
