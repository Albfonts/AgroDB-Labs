-- =========================================================
-- AgroDB-Labs :: database/indexes.sql
-- PostgreSQL 17
-- Índices sobre colunas de Foreign Key
--
-- Motivo: o PostgreSQL cria índice automático apenas na
-- Primary Key. Colunas de FK usadas em JOIN, WHERE ou
-- ORDER BY precisam de índice próprio para evitar
-- Sequential Scan em tabelas grandes.
--
-- Executar após schema.sql e seed.sql.
-- =========================================================

-- MÓDULO PRODUÇÃO
CREATE INDEX idx_fazenda_id_produtor ON fazenda (id_produtor);
CREATE INDEX idx_talhao_id_fazenda ON talhao (id_fazenda);
CREATE INDEX idx_safra_id_talhao ON safra (id_talhao);
CREATE INDEX idx_safra_id_cultura ON safra (id_cultura);
CREATE INDEX idx_producao_id_safra ON producao (id_safra);

-- MÓDULO COMERCIAL
CREATE INDEX idx_venda_id_cliente ON venda (id_cliente);
CREATE INDEX idx_item_venda_id_venda ON item_venda (id_venda);
CREATE INDEX idx_item_venda_id_producao ON item_venda (id_producao);

-- MÓDULO SUPRIMENTOS
CREATE INDEX idx_estoque_id_produto ON estoque (id_produto);
CREATE INDEX idx_compra_id_fornecedor ON compra (id_fornecedor);
CREATE INDEX idx_item_compra_id_compra ON item_compra (id_compra);
CREATE INDEX idx_item_compra_id_produto ON item_compra (id_produto);

-- MÓDULO OPERAÇÕES
CREATE INDEX idx_utilizacao_maquina_id_funcionario ON utilizacao_maquina (id_funcionario);
CREATE INDEX idx_utilizacao_maquina_id_maquina ON utilizacao_maquina (id_maquina);
CREATE INDEX idx_utilizacao_maquina_id_talhao ON utilizacao_maquina (id_talhao);

-- =========================================================
-- Índices auxiliares para consultas frequentes
-- (datas usadas em relatórios e filtros por período)
-- =========================================================
CREATE INDEX idx_safra_data_inicio ON safra (data_inicio);
CREATE INDEX idx_producao_data_colheita ON producao (data_colheita);
CREATE INDEX idx_venda_data_venda ON venda (data_venda);
CREATE INDEX idx_compra_data_compra ON compra (data_compra);
CREATE INDEX idx_utilizacao_maquina_data ON utilizacao_maquina (data_utilizacao);