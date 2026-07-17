-- =========================================================
-- AgroDB-Labs :: database/queries.sql
-- PostgreSQL 17
-- Consultas analíticas construídas de forma incremental,
-- documentando cada conceito de SQL aplicado ao modelo real.
-- =========================================================


-- =========================================================
-- BLOCO 0 — SELECT, WHERE, ORDER BY, AND / OR / NOT
-- =========================================================
-- Conceito: a base de tudo. SELECT define quais colunas eu quero
-- ver, WHERE filtra as linhas, ORDER BY define a ordem, e
-- AND/OR/NOT combinam condições de filtro.
-- =========================================================

-- 0.1 SELECT + WHERE simples
-- Lista apenas os talhões que estão com status 'Ativo'
SELECT
    nome,
    area_hectares,
    tipo_solo,
    status
FROM talhao
WHERE status = 'Ativo';


-- 0.2 WHERE com operador de comparação + ORDER BY
-- Fazendas com área total maior que 450 hectares, da maior pra menor
SELECT
    nome,
    area_total,
    cidade,
    estado
FROM fazenda
WHERE area_total > 450
ORDER BY area_total DESC;


-- 0.3 AND — as duas condições precisam ser verdadeiras
-- Talhões com solo Latossolo E área maior que 100 hectares
SELECT
    nome,
    area_hectares,
    tipo_solo
FROM talhao
WHERE tipo_solo = 'Latossolo'
  AND area_hectares > 100;


-- 0.4 OR — pelo menos uma das condições precisa ser verdadeira
-- Produtos das categorias 'Semente' OU 'Defensivo Agrícola'
SELECT
    nome,
    categoria,
    preco_unitario
FROM produto
WHERE categoria = 'Semente'
   OR categoria = 'Defensivo Agrícola';


-- 0.5 NOT — inverte a condição
-- Todas as culturas, exceto a Soja
-- Equivalente mais comum na prática: WHERE nome <> 'Soja'
SELECT
    nome,
    tipo,
    ciclo_dias
FROM cultura
WHERE NOT nome = 'Soja';


-- 0.6 Combinando AND + OR + NOT numa consulta só
-- Vendas concluídas, com valor acima de 900000, que NÃO sejam
-- da Cargill Agrícola S.A.
SELECT
    v.data_venda,
    v.valor_total,
    v.status,
    cl.nome     AS cliente
FROM venda v
INNER JOIN cliente cl ON cl.id_cliente = v.id_cliente
WHERE v.status = 'Concluída'
  AND v.valor_total > 900000
  AND NOT cl.nome = 'Cargill Agrícola S.A.'
ORDER BY v.valor_total DESC;


-- =========================================================
-- BLOCO 1 — INNER JOIN
-- =========================================================
-- Conceito: retorna apenas as linhas onde existe correspondência
-- em AMBAS as tabelas. Se um produtor não tiver fazenda, ou uma
-- fazenda não tiver talhão, essas linhas não aparecem no resultado.
-- =========================================================

-- 1.1 Produtores e suas fazendas
-- Relaciona produtor -> fazenda (1:N)
SELECT
    p.nome          AS produtor,
    p.cidade        AS cidade_produtor,
    p.estado        AS estado_produtor,
    f.nome          AS fazenda,
    f.area_total    AS area_total_ha
FROM produtor p
INNER JOIN fazenda f ON f.id_produtor = p.id_produtor
ORDER BY p.nome;


-- 1.2 Fazendas, talhões e o tipo de solo de cada um
-- Relaciona fazenda -> talhao (1:N)
SELECT
    f.nome          AS fazenda,
    t.nome          AS talhao,
    t.area_hectares AS area_ha,
    t.tipo_solo,
    t.status
FROM fazenda f
INNER JOIN talhao t ON t.id_fazenda = f.id_fazenda
ORDER BY f.nome, t.nome;


-- 1.3 Cadeia completa: produtor -> fazenda -> talhão -> safra -> cultura
-- Encadeamento de vários INNER JOIN, um para cada relacionamento 1:N
-- do módulo Produção. Mostra qual cultura está plantada em cada talhão.
SELECT
    p.nome      AS produtor,
    f.nome      AS fazenda,
    t.nome      AS talhao,
    c.nome      AS cultura,
    s.ano       AS ano_safra,
    s.data_inicio,
    s.data_fim
FROM produtor p
INNER JOIN fazenda f ON f.id_produtor = p.id_produtor
INNER JOIN talhao t  ON t.id_fazenda  = f.id_fazenda
INNER JOIN safra s   ON s.id_talhao   = t.id_talhao
INNER JOIN cultura c ON c.id_cultura  = s.id_cultura
ORDER BY p.nome, f.nome, t.nome;


-- 1.4 Vendas com o nome do cliente
-- Relaciona venda -> cliente (N:1)
SELECT
    v.id_venda,
    v.data_venda,
    v.valor_total,
    v.status,
    cl.nome     AS cliente,
    cl.cidade   AS cidade_cliente
FROM venda v
INNER JOIN cliente cl ON cl.id_cliente = v.id_cliente
ORDER BY v.data_venda;