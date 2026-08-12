-- =========================================================
-- BLOCO 0 — SELECT, WHERE, ORDER BY, AND / OR / NOT
-- =========================================================

SELECT
    nome,
    area_hectares,
    tipo_solo,
    status
FROM talhao
WHERE status = 'Ativo';


SELECT
    nome,
    area_total,
    cidade,
    estado
FROM fazenda
WHERE area_total > 450
ORDER BY area_total DESC;


SELECT
    nome,
    area_hectares,
    tipo_solo
FROM talhao
WHERE tipo_solo = 'Latossolo'
  AND area_hectares > 100;


SELECT
    nome,
    categoria,
    preco_unitario
FROM produto
WHERE categoria = 'Semente'
   OR categoria = 'Defensivo Agrícola';


SELECT
    nome,
    tipo,
    ciclo_dias
FROM cultura
WHERE NOT nome = 'Soja';


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

SELECT
    p.nome          AS produtor,
    p.cidade        AS cidade_produtor,
    p.estado        AS estado_produtor,
    f.nome          AS fazenda,
    f.area_total    AS area_total_ha
FROM produtor p
INNER JOIN fazenda f ON f.id_produtor = p.id_produtor
ORDER BY p.nome;


SELECT
    f.nome          AS fazenda,
    t.nome          AS talhao,
    t.area_hectares AS area_ha,
    t.tipo_solo,
    t.status
FROM fazenda f
INNER JOIN talhao t ON t.id_fazenda = f.id_fazenda
ORDER BY f.nome, t.nome;


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


-- =========================================================
-- BLOCO 2 — LEFT JOIN
-- =========================================================

SELECT
    t.nome          AS talhao,
    t.area_hectares,
    t.tipo_solo,
    s.ano           AS ano_safra,
    s.data_inicio,
    s.data_fim
FROM talhao t
LEFT JOIN safra s ON s.id_talhao = t.id_talhao
ORDER BY t.nome;


SELECT
    p.nome          AS produto,
    p.categoria,
    p.preco_unitario,
    e.quantidade,
    e.localizacao
FROM produto p
LEFT JOIN estoque e ON e.id_produto = p.id_produto
ORDER BY p.nome;


SELECT
    f.nome          AS funcionario,
    f.cargo,
    um.data_utilizacao,
    um.atividade
FROM funcionario f
LEFT JOIN utilizacao_maquina um ON um.id_funcionario = f.id_funcionario
ORDER BY f.nome, um.data_utilizacao;


SELECT
    t.nome          AS talhao,
    t.area_hectares,
    t.tipo_solo,
    t.status
FROM talhao t
LEFT JOIN safra s ON s.id_talhao = t.id_talhao
WHERE s.id_safra IS NULL
ORDER BY t.nome;


-- =========================================================
-- BLOCO 3 — GROUP BY / FUNÇÕES DE AGREGAÇÃO
-- =========================================================

SELECT
    cl.nome         AS cliente,
    SUM(v.valor_total) AS total_vendido
FROM venda v
INNER JOIN cliente cl ON cl.id_cliente = v.id_cliente
GROUP BY cl.nome
ORDER BY total_vendido DESC;


SELECT
    f.nome              AS fazenda,
    COUNT(t.id_talhao)  AS total_talhoes
FROM fazenda f
INNER JOIN talhao t ON t.id_fazenda = f.id_fazenda
GROUP BY f.nome
ORDER BY total_talhoes DESC;


SELECT
    tipo_solo,
    AVG(area_hectares) AS area_media_ha
FROM talhao
GROUP BY tipo_solo
ORDER BY area_media_ha DESC;


SELECT
    fo.nome             AS fornecedor,
    SUM(c.valor_total)  AS total_comprado
FROM compra c
INNER JOIN fornecedor fo ON fo.id_fornecedor = c.id_fornecedor
GROUP BY fo.nome
HAVING SUM(c.valor_total) > 20000
ORDER BY total_comprado DESC;


SELECT
    s.id_safra,
    s.ano,
    SUM(p.quantidade) AS producao_total
FROM safra s
INNER JOIN producao p ON p.id_safra = s.id_safra
GROUP BY s.id_safra, s.ano
ORDER BY producao_total DESC
LIMIT 1;