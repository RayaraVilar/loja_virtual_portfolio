# Loja Virtual | PostgreSQL

Desenvolvi este projeto pessoal de portfólio para aprimorar minhas habilidades com consultas e manipulação de dados em SQL. Usei o PostgreSQL para modelar uma loja virtual fictícia, cadastrar dados de exemplo e consultar o catálogo, os pedidos e as vendas.

## O que pratiquei

- **Modelagem relacional.** Cinco tabelas conectam categorias, produtos, clientes, pedidos e itens de pedido. Chaves primárias e estrangeiras, restrições `CHECK` e regras de unicidade mantêm a integridade dos dados. Cada item guarda o preço na data da compra.
- **Consultas e relatórios.** Oito consultas usam recursos como `JOIN`, `GROUP BY`, `HAVING` e CTEs para explorar o catálogo, contar pedidos por cliente e calcular o valor dos pedidos confirmados, o ticket médio e o total mensal.
- **Manipulação e administração.** Os scripts demonstram inserção e atualização de dados, reversão de alterações com `ROLLBACK`, criação de índices e análise de planos com `EXPLAIN (ANALYZE, BUFFERS)`.

## Como executar

No pgAdmin 4, crie um banco vazio chamado `loja_virtual_portfolio` em uma instância do PostgreSQL 18. Abra o Query Tool conectado a esse banco e execute os scripts nesta ordem.

| Etapa | Arquivo | Finalidade |
| --- | --- | --- |
| 1 | [01_estrutura.sql](sql/01_estrutura.sql) | Criar as tabelas e seus relacionamentos |
| 2 | [02_dados.sql](sql/02_dados.sql) | Inserir dados fictícios |
| 3 | [05_validacao.sql](sql/05_validacao.sql) | Conferir a carga e os relacionamentos |
| 4 | [03_consultas.sql](sql/03_consultas.sql) | Executar as oito consultas de exemplo |
| 5 | [04_administracao.sql](sql/04_administracao.sql) | Criar índices, analisar planos e testar uma transação reversível |

Execute os scripts de estrutura, carga e administração uma vez por banco. A carga de exemplo gera 4 categorias, 8 clientes, 10 produtos, 8 pedidos e 12 itens de pedido.

O [guia de administração](docs/administracao.md) inclui comandos de backup e restauração.
