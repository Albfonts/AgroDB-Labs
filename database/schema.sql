-- =========================================================
-- AgroDB-Labs :: database/schema.sql
-- PostgreSQL 17
-- Versão 2.0 — inclui UNIQUE, CHECK e colunas geradas
-- =========================================================

-- =========================================================
-- DROP TABLES (ordem inversa de dependência)
-- =========================================================
DROP TABLE IF EXISTS utilizacao_maquina CASCADE;
DROP TABLE IF EXISTS maquina CASCADE;
DROP TABLE IF EXISTS funcionario CASCADE;
DROP TABLE IF EXISTS item_compra CASCADE;
DROP TABLE IF EXISTS compra CASCADE;
DROP TABLE IF EXISTS estoque CASCADE;
DROP TABLE IF EXISTS produto CASCADE;
DROP TABLE IF EXISTS fornecedor CASCADE;
DROP TABLE IF EXISTS item_venda CASCADE;
DROP TABLE IF EXISTS venda CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS producao CASCADE;
DROP TABLE IF EXISTS safra CASCADE;
DROP TABLE IF EXISTS cultura CASCADE;
DROP TABLE IF EXISTS talhao CASCADE;
DROP TABLE IF EXISTS fazenda CASCADE;
DROP TABLE IF EXISTS produtor CASCADE;

-- =========================================================
-- MÓDULO PRODUÇÃO
-- =========================================================

CREATE TABLE produtor (
    id_produtor     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    cpf_cnpj        VARCHAR(18) NOT NULL,
    telefone        VARCHAR(20),
    email           VARCHAR(150),
    cidade          VARCHAR(100),
    estado          VARCHAR(2),
    CONSTRAINT uq_produtor_cpf_cnpj UNIQUE (cpf_cnpj)
);

CREATE TABLE fazenda (
    id_fazenda      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    area_total      NUMERIC(12,2) NOT NULL,
    cidade          VARCHAR(100),
    estado          VARCHAR(2),
    id_produtor     BIGINT NOT NULL,
    CONSTRAINT fk_fazenda_produtor FOREIGN KEY (id_produtor)
        REFERENCES produtor (id_produtor),
    CONSTRAINT chk_fazenda_area_total CHECK (area_total > 0)
);

CREATE TABLE talhao (
    id_talhao       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    area_hectares   NUMERIC(12,2) NOT NULL,
    tipo_solo       VARCHAR(50),
    status          VARCHAR(30),
    id_fazenda      BIGINT NOT NULL,
    CONSTRAINT fk_talhao_fazenda FOREIGN KEY (id_fazenda)
        REFERENCES fazenda (id_fazenda),
    CONSTRAINT chk_talhao_area_hectares CHECK (area_hectares > 0)
);

CREATE TABLE cultura (
    id_cultura              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome                    VARCHAR(100) NOT NULL,
    tipo                    VARCHAR(50),
    ciclo_dias              INTEGER,
    produtividade_media     NUMERIC(12,2),
    CONSTRAINT uq_cultura_nome UNIQUE (nome),
    CONSTRAINT chk_cultura_ciclo_dias CHECK (ciclo_dias > 0),
    CONSTRAINT chk_cultura_produtividade CHECK (produtividade_media >= 0)
);

CREATE TABLE safra (
    id_safra        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ano             INTEGER NOT NULL,
    data_inicio     DATE NOT NULL,
    data_fim        DATE,
    id_talhao       BIGINT NOT NULL,
    id_cultura      BIGINT NOT NULL,
    CONSTRAINT fk_safra_talhao FOREIGN KEY (id_talhao)
        REFERENCES talhao (id_talhao),
    CONSTRAINT fk_safra_cultura FOREIGN KEY (id_cultura)
        REFERENCES cultura (id_cultura),
    CONSTRAINT chk_safra_datas CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

CREATE TABLE producao (
    id_producao     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantidade      NUMERIC(12,2) NOT NULL,
    unidade         VARCHAR(20) NOT NULL,
    data_colheita   DATE NOT NULL,
    id_safra        BIGINT NOT NULL,
    CONSTRAINT fk_producao_safra FOREIGN KEY (id_safra)
        REFERENCES safra (id_safra),
    CONSTRAINT chk_producao_quantidade CHECK (quantidade > 0)
);

-- =========================================================
-- MÓDULO COMERCIAL
-- =========================================================

CREATE TABLE cliente (
    id_cliente      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    cnpj            VARCHAR(18) NOT NULL,
    telefone        VARCHAR(20),
    email           VARCHAR(150),
    cidade          VARCHAR(100),
    estado          VARCHAR(2),
    CONSTRAINT uq_cliente_cnpj UNIQUE (cnpj)
);

CREATE TABLE venda (
    id_venda        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_venda      DATE NOT NULL,
    valor_total     NUMERIC(14,2) NOT NULL,
    status          VARCHAR(30),
    id_cliente      BIGINT NOT NULL,
    CONSTRAINT fk_venda_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente (id_cliente),
    CONSTRAINT chk_venda_valor_total CHECK (valor_total >= 0)
);

CREATE TABLE item_venda (
    id_item_venda   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantidade      NUMERIC(12,2) NOT NULL,
    valor_unitario  NUMERIC(14,2) NOT NULL,
    subtotal        NUMERIC(14,2) GENERATED ALWAYS AS (quantidade * valor_unitario) STORED,
    id_venda        BIGINT NOT NULL,
    id_producao     BIGINT NOT NULL,
    CONSTRAINT fk_item_venda_venda FOREIGN KEY (id_venda)
        REFERENCES venda (id_venda),
    CONSTRAINT fk_item_venda_producao FOREIGN KEY (id_producao)
        REFERENCES producao (id_producao),
    CONSTRAINT chk_item_venda_quantidade CHECK (quantidade > 0),
    CONSTRAINT chk_item_venda_valor_unitario CHECK (valor_unitario >= 0)
);

-- =========================================================
-- MÓDULO SUPRIMENTOS
-- =========================================================

CREATE TABLE fornecedor (
    id_fornecedor   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    cnpj            VARCHAR(18) NOT NULL,
    telefone        VARCHAR(20),
    email           VARCHAR(150),
    cidade          VARCHAR(100),
    estado          VARCHAR(2),
    CONSTRAINT uq_fornecedor_cnpj UNIQUE (cnpj)
);

CREATE TABLE produto (
    id_produto      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    categoria       VARCHAR(50),
    unidade_medida  VARCHAR(20),
    preco_unitario  NUMERIC(14,2) NOT NULL,
    CONSTRAINT uq_produto_nome UNIQUE (nome),
    CONSTRAINT chk_produto_preco_unitario CHECK (preco_unitario >= 0)
);

CREATE TABLE estoque (
    id_estoque          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantidade          NUMERIC(12,2) NOT NULL,
    localizacao         VARCHAR(150),
    ultima_atualizacao  DATE,
    id_produto          BIGINT NOT NULL,
    CONSTRAINT fk_estoque_produto FOREIGN KEY (id_produto)
        REFERENCES produto (id_produto),
    CONSTRAINT chk_estoque_quantidade CHECK (quantidade >= 0)
);

CREATE TABLE compra (
    id_compra       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_compra     DATE NOT NULL,
    valor_total     NUMERIC(14,2) NOT NULL,
    status          VARCHAR(30),
    id_fornecedor   BIGINT NOT NULL,
    CONSTRAINT fk_compra_fornecedor FOREIGN KEY (id_fornecedor)
        REFERENCES fornecedor (id_fornecedor),
    CONSTRAINT chk_compra_valor_total CHECK (valor_total >= 0)
);

CREATE TABLE item_compra (
    id_item_compra  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantidade      NUMERIC(12,2) NOT NULL,
    valor_unitario  NUMERIC(14,2) NOT NULL,
    subtotal        NUMERIC(14,2) GENERATED ALWAYS AS (quantidade * valor_unitario) STORED,
    id_compra       BIGINT NOT NULL,
    id_produto      BIGINT NOT NULL,
    CONSTRAINT fk_item_compra_compra FOREIGN KEY (id_compra)
        REFERENCES compra (id_compra),
    CONSTRAINT fk_item_compra_produto FOREIGN KEY (id_produto)
        REFERENCES produto (id_produto),
    CONSTRAINT chk_item_compra_quantidade CHECK (quantidade > 0),
    CONSTRAINT chk_item_compra_valor_unitario CHECK (valor_unitario >= 0)
);

-- =========================================================
-- MÓDULO OPERAÇÕES
-- =========================================================

CREATE TABLE funcionario (
    id_funcionario  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    cpf             VARCHAR(14) NOT NULL,
    telefone        VARCHAR(20),
    email           VARCHAR(150),
    cargo           VARCHAR(80),
    salario         NUMERIC(14,2),
    data_admissao   DATE,
    CONSTRAINT uq_funcionario_cpf UNIQUE (cpf),
    CONSTRAINT chk_funcionario_salario CHECK (salario IS NULL OR salario > 0)
);

CREATE TABLE maquina (
    id_maquina      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    modelo          VARCHAR(100) NOT NULL,
    marca           VARCHAR(100),
    potencia        NUMERIC(10,2),
    ano_fabricacao  INTEGER,
    consumo_medio   NUMERIC(10,2),
    CONSTRAINT chk_maquina_potencia CHECK (potencia IS NULL OR potencia > 0),
    CONSTRAINT chk_maquina_consumo_medio CHECK (consumo_medio IS NULL OR consumo_medio >= 0)
);

CREATE TABLE utilizacao_maquina (
    id_utilizacao           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_utilizacao         DATE NOT NULL,
    horas_trabalhadas       NUMERIC(8,2) NOT NULL,
    combustivel_consumido   NUMERIC(10,2),
    atividade               VARCHAR(150),
    id_funcionario          BIGINT NOT NULL,
    id_maquina              BIGINT NOT NULL,
    id_talhao               BIGINT NOT NULL,
    CONSTRAINT fk_utilizacao_maquina_funcionario FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id_funcionario),
    CONSTRAINT fk_utilizacao_maquina_maquina FOREIGN KEY (id_maquina)
        REFERENCES maquina (id_maquina),
    CONSTRAINT fk_utilizacao_maquina_talhao FOREIGN KEY (id_talhao)
        REFERENCES talhao (id_talhao),
    CONSTRAINT chk_utilizacao_horas CHECK (horas_trabalhadas > 0),
    CONSTRAINT chk_utilizacao_combustivel CHECK (combustivel_consumido IS NULL OR combustivel_consumido >= 0)
);