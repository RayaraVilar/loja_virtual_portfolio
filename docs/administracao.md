# Praticas de administracao PostgreSQL

## Indices e analise

O script `04_administracao.sql` cria indices nas chaves estrangeiras mais consultadas, atualiza estatisticas com `ANALYZE` e mostra um plano com `EXPLAIN (ANALYZE, BUFFERS)`. Em conjuntos pequenos, o PostgreSQL pode preferir uma leitura sequencial; isso nao e erro.

## Backup e restauracao

Estes comandos devem ser executados **no terminal** (PowerShell, CMD ou shell), nao no Query Tool. Ajuste os caminhos e usuario de acordo com sua instalacao. O `pg_dump` e o `pg_restore` geralmente ficam na pasta `bin` do PostgreSQL.

```bash
pg_dump -U postgres -h localhost -Fc -f loja_virtual_portfolio.backup loja_virtual_portfolio
```

Para testar a restauracao, crie **outro banco vazio** chamado `loja_virtual_restaurada` e execute:

```bash
pg_restore -U postgres -h localhost -d loja_virtual_restaurada --no-owner --no-privileges loja_virtual_portfolio.backup
```

No Windows, voce tambem pode usar `Backup...` e `Restore...` pelo menu de contexto do banco no pgAdmin 4. Nunca restaure por cima do seu banco principal sem um plano de recuperacao.

## Permissoes (exemplo para estudo, nao executar sem necessidade)

Para ambientes reais, use usuarios individuais e privilegios minimos. Evite inserir senhas de exemplo ou reais no GitHub. Com o administrador, crie a role de forma interativa e use `GRANT` apenas nas tabelas necessarias. Pratique num ambiente local isolado.

## Limites deste projeto

Os scripts simulam operacoes de e-commerce, mas nao implementam processo completo de checkout, decremento automatico de estoque, concorrencia, autenticacao ou dados pessoais reais. O relatorio de faturamento usa o valor de pedidos com status `PAGO`, `ENVIADO` ou `ENTREGUE` como indicador didatico, nao como contabilidade fiscal.
