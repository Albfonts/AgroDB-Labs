-- ==========================================
-- MÓDULO PRODUÇÃO
-- ==========================================

-- Produtores
INSERT INTO produtor (nome, cpf_cnpj, telefone, email, cidade, estado)
VALUES
('João Alberto Souza', '123.456.789-01', '(66) 99811-2233', 'joao.souza@email.com', 'Sorriso', 'MT'),
('Maria Fernanda Costa', '234.567.890-12', '(64) 99722-3344', 'maria.costa@email.com', 'Rio Verde', 'GO'),
('Agropecuária Bandeirantes Ltda', '12.345.678/0001-91', '(45) 99633-4455', 'contato@bandeirantes.agro.br', 'Cascavel', 'PR');

-- Fazendas
INSERT INTO fazenda (nome, area_total, cidade, estado, id_produtor)
VALUES
('Fazenda Boa Vista', 520.00, 'Sorriso', 'MT',
    (SELECT id_produtor FROM produtor WHERE cpf_cnpj = '123.456.789-01')),
('Fazenda Santa Luzia', 680.00, 'Rio Verde', 'GO',
    (SELECT id_produtor FROM produtor WHERE cpf_cnpj = '234.567.890-12')),
('Fazenda Três Marias', 410.00, 'Cascavel', 'PR',
    (SELECT id_produtor FROM produtor WHERE cpf_cnpj = '12.345.678/0001-91'));

-- Talhões
INSERT INTO talhao (nome, area_hectares, tipo_solo, status, id_fazenda)
VALUES
('Talhão A1', 150.00, 'Latossolo', 'Ativo',
    (SELECT id_fazenda FROM fazenda WHERE nome = 'Fazenda Boa Vista')),
('Talhão A2', 120.00, 'Latossolo', 'Ativo',
    (SELECT id_fazenda FROM fazenda WHERE nome = 'Fazenda Boa Vista')),
('Talhão B1', 200.00, 'Argissolo', 'Ativo',
    (SELECT id_fazenda FROM fazenda WHERE nome = 'Fazenda Santa Luzia')),
('Talhão B2', 180.00, 'Argissolo', 'Ativo',
    (SELECT id_fazenda FROM fazenda WHERE nome = 'Fazenda Santa Luzia')),
('Talhão C1', 90.00, 'Nitossolo', 'Ativo',
    (SELECT id_fazenda FROM fazenda WHERE nome = 'Fazenda Três Marias')),
('Talhão C2', 80.00, 'Nitossolo', 'Ativo',
    (SELECT id_fazenda FROM fazenda WHERE nome = 'Fazenda Três Marias'));

-- Culturas
INSERT INTO cultura (nome, tipo, ciclo_dias, produtividade_media)
VALUES
('Soja', 'Grão', 120, 3.30),
('Milho', 'Grão', 150, 9.50),
('Cana-de-açúcar', 'Industrial', 365, 75.00);

-- Safras
INSERT INTO safra (ano, data_inicio, data_fim, id_talhao, id_cultura)
VALUES
(2025, '2025-09-15', '2026-01-20',
    (SELECT id_talhao FROM talhao WHERE nome = 'Talhão A1'),
    (SELECT id_cultura FROM cultura WHERE nome = 'Soja')),
(2025, '2025-10-01', '2026-02-15',
    (SELECT id_talhao FROM talhao WHERE nome = 'Talhão B1'),
    (SELECT id_cultura FROM cultura WHERE nome = 'Milho')),
(2025, '2025-03-01', '2026-03-01',
    (SELECT id_talhao FROM talhao WHERE nome = 'Talhão C1'),
    (SELECT id_cultura FROM cultura WHERE nome = 'Cana-de-açúcar'));

-- Produções
INSERT INTO producao (quantidade, unidade, data_colheita, id_safra)
VALUES
(220.00, 'ton', '2026-01-10',
    (SELECT s.id_safra FROM safra s
        JOIN talhao t ON s.id_talhao = t.id_talhao
        JOIN cultura c ON s.id_cultura = c.id_cultura
        WHERE t.nome = 'Talhão A1' AND c.nome = 'Soja')),
(275.00, 'ton', '2026-01-18',
    (SELECT s.id_safra FROM safra s
        JOIN talhao t ON s.id_talhao = t.id_talhao
        JOIN cultura c ON s.id_cultura = c.id_cultura
        WHERE t.nome = 'Talhão A1' AND c.nome = 'Soja')),
(950.00, 'ton', '2026-02-10',
    (SELECT s.id_safra FROM safra s
        JOIN talhao t ON s.id_talhao = t.id_talhao
        JOIN cultura c ON s.id_cultura = c.id_cultura
        WHERE t.nome = 'Talhão B1' AND c.nome = 'Milho')),
(850.00, 'ton', '2026-02-14',
    (SELECT s.id_safra FROM safra s
        JOIN talhao t ON s.id_talhao = t.id_talhao
        JOIN cultura c ON s.id_cultura = c.id_cultura
        WHERE t.nome = 'Talhão B1' AND c.nome = 'Milho')),
(6200.00, 'ton', '2026-02-25',
    (SELECT s.id_safra FROM safra s
        JOIN talhao t ON s.id_talhao = t.id_talhao
        JOIN cultura c ON s.id_cultura = c.id_cultura
        WHERE t.nome = 'Talhão C1' AND c.nome = 'Cana-de-açúcar'));

-- ==========================================
-- MÓDULO COMERCIAL
-- ==========================================

-- Clientes
INSERT INTO cliente (nome, cnpj, telefone, email, cidade, estado)
VALUES
('Coamo', '76.461.557/0001-75', '(45) 3321-1000', 'comercial@coamo.com.br', 'Cascavel', 'PR'),
('Cargill Agrícola S.A.', '60.498.706/0001-57', '(34) 3230-4000', 'vendas@cargill.com.br', 'Uberlândia', 'MG'),
('Louis Dreyfus Company Brasil', '47.067.525/0001-70', '(66) 3411-5000', 'contato@ldc.com.br', 'Rondonópolis', 'MT');

-- Vendas
INSERT INTO venda (data_venda, valor_total, status, id_cliente)
VALUES
('2026-01-25', 1089000.00, 'Concluída',
    (SELECT id_cliente FROM cliente WHERE cnpj = '76.461.557/0001-75')),
('2026-02-20', 2070000.00, 'Concluída',
    (SELECT id_cliente FROM cliente WHERE cnpj = '60.498.706/0001-57')),
('2026-03-05', 806000.00, 'Concluída',
    (SELECT id_cliente FROM cliente WHERE cnpj = '47.067.525/0001-70'));

-- Itens de Venda
INSERT INTO item_venda (quantidade, valor_unitario, id_venda, id_producao)
VALUES
(220.00, 2200.00,
    (SELECT id_venda FROM venda WHERE data_venda = '2026-01-25'
        AND id_cliente = (SELECT id_cliente FROM cliente WHERE cnpj = '76.461.557/0001-75')),
    (SELECT id_producao FROM producao WHERE data_colheita = '2026-01-10' AND quantidade = 220.00)),
(275.00, 2200.00,
    (SELECT id_venda FROM venda WHERE data_venda = '2026-01-25'
        AND id_cliente = (SELECT id_cliente FROM cliente WHERE cnpj = '76.461.557/0001-75')),
    (SELECT id_producao FROM producao WHERE data_colheita = '2026-01-18' AND quantidade = 275.00)),
(950.00, 1150.00,
    (SELECT id_venda FROM venda WHERE data_venda = '2026-02-20'
        AND id_cliente = (SELECT id_cliente FROM cliente WHERE cnpj = '60.498.706/0001-57')),
    (SELECT id_producao FROM producao WHERE data_colheita = '2026-02-10' AND quantidade = 950.00)),
(850.00, 1150.00,
    (SELECT id_venda FROM venda WHERE data_venda = '2026-02-20'
        AND id_cliente = (SELECT id_cliente FROM cliente WHERE cnpj = '60.498.706/0001-57')),
    (SELECT id_producao FROM producao WHERE data_colheita = '2026-02-14' AND quantidade = 850.00)),
(6200.00, 130.00,
    (SELECT id_venda FROM venda WHERE data_venda = '2026-03-05'
        AND id_cliente = (SELECT id_cliente FROM cliente WHERE cnpj = '47.067.525/0001-70')),
    (SELECT id_producao FROM producao WHERE data_colheita = '2026-02-25' AND quantidade = 6200.00));

-- ==========================================
-- MÓDULO SUPRIMENTOS
-- ==========================================

-- Fornecedores
INSERT INTO fornecedor (nome, cnpj, telefone, email, cidade, estado)
VALUES
('Agroquímica Sul Distribuidora', '11.222.333/0001-44', '(45) 3225-1122', 'vendas@agroquimicasul.com.br', 'Cascavel', 'PR'),
('Fertilizantes Centro-Oeste Ltda', '22.333.444/0001-55', '(66) 3421-2233', 'comercial@fertco.com.br', 'Rondonópolis', 'MT'),
('Sementes Tropical Agro', '33.444.555/0001-66', '(43) 3327-3344', 'contato@tropicalagro.com.br', 'Londrina', 'PR');

-- Produtos
INSERT INTO produto (nome, categoria, unidade_medida, preco_unitario)
VALUES
('Glifosato', 'Defensivo Agrícola', 'L', 28.50),
('Fertilizante NPK', 'Fertilizante', 'kg', 3.20),
('Semente de Soja', 'Semente', 'kg', 6.80);

-- Estoque
INSERT INTO estoque (quantidade, localizacao, ultima_atualizacao, id_produto)
VALUES
(500.00, 'Galpão Central - Sorriso/MT', '2025-02-12',
    (SELECT id_produto FROM produto WHERE nome = 'Glifosato')),
(12000.00, 'Armazém B - Rio Verde/GO', '2025-09-12',
    (SELECT id_produto FROM produto WHERE nome = 'Fertilizante NPK')),
(8000.00, 'Depósito Sementes - Cascavel/PR', '2025-08-22',
    (SELECT id_produto FROM produto WHERE nome = 'Semente de Soja'));

-- Compras
INSERT INTO compra (data_compra, valor_total, status, id_fornecedor)
VALUES
('2025-02-10', 14250.00, 'Concluída',
    (SELECT id_fornecedor FROM fornecedor WHERE cnpj = '11.222.333/0001-44')),
('2025-09-10', 38400.00, 'Concluída',
    (SELECT id_fornecedor FROM fornecedor WHERE cnpj = '22.333.444/0001-55')),
('2025-08-20', 54400.00, 'Concluída',
    (SELECT id_fornecedor FROM fornecedor WHERE cnpj = '33.444.555/0001-66'));

-- Itens de Compra
INSERT INTO item_compra (quantidade, valor_unitario, id_compra, id_produto)
VALUES
(500.00, 28.50,
    (SELECT id_compra FROM compra WHERE data_compra = '2025-02-10'
        AND id_fornecedor = (SELECT id_fornecedor FROM fornecedor WHERE cnpj = '11.222.333/0001-44')),
    (SELECT id_produto FROM produto WHERE nome = 'Glifosato')),
(12000.00, 3.20,
    (SELECT id_compra FROM compra WHERE data_compra = '2025-09-10'
        AND id_fornecedor = (SELECT id_fornecedor FROM fornecedor WHERE cnpj = '22.333.444/0001-55')),
    (SELECT id_produto FROM produto WHERE nome = 'Fertilizante NPK')),
(8000.00, 6.80,
    (SELECT id_compra FROM compra WHERE data_compra = '2025-08-20'
        AND id_fornecedor = (SELECT id_fornecedor FROM fornecedor WHERE cnpj = '33.444.555/0001-66')),
    (SELECT id_produto FROM produto WHERE nome = 'Semente de Soja'));

-- ==========================================
-- MÓDULO OPERAÇÕES
-- ==========================================

-- Funcionários
INSERT INTO funcionario (nome, cpf, telefone, email, cargo, salario, data_admissao)
VALUES
('Fernanda Oliveira Santos', '333.444.555-66', '(45) 99911-1122', 'fernanda.santos@bandeirantes.agro.br', 'Técnica Agrícola', 4500.00, '2023-11-10'),
('Carlos Eduardo Lima', '111.222.333-44', '(66) 99822-2233', 'carlos.lima@boavista.agro.br', 'Operador de Máquinas', 3200.00, '2024-03-01'),
('Roberto Nunes Silva', '222.333.444-55', '(64) 99733-3344', 'roberto.silva@santaluzia.agro.br', 'Operador de Máquinas', 3100.00, '2024-05-15');

-- Máquinas
INSERT INTO maquina (modelo, marca, potencia, ano_fabricacao, consumo_medio)
VALUES
('John Deere 6125J', 'John Deere', 125.00, 2021, 12.50),
('Case IH Axial-Flow 8250', 'Case IH', 421.00, 2020, 35.00),
('New Holland T7.230', 'New Holland', 231.00, 2022, 18.00);

-- Utilização de Máquinas
INSERT INTO utilizacao_maquina (data_utilizacao, horas_trabalhadas, combustivel_consumido, atividade, id_funcionario, id_maquina, id_talhao)
VALUES
('2025-09-15', 8.50, 106.25, 'Preparo do Solo',
    (SELECT id_funcionario FROM funcionario WHERE cpf = '111.222.333-44'),
    (SELECT id_maquina FROM maquina WHERE modelo = 'John Deere 6125J'),
    (SELECT id_talhao FROM talhao WHERE nome = 'Talhão A1')),
('2025-09-20', 6.00, 108.00, 'Plantio',
    (SELECT id_funcionario FROM funcionario WHERE cpf = '222.333.444-55'),
    (SELECT id_maquina FROM maquina WHERE modelo = 'New Holland T7.230'),
    (SELECT id_talhao FROM talhao WHERE nome = 'Talhão A1')),
('2025-10-05', 7.00, 87.50, 'Adubação',
    (SELECT id_funcionario FROM funcionario WHERE cpf = '111.222.333-44'),
    (SELECT id_maquina FROM maquina WHERE modelo = 'John Deere 6125J'),
    (SELECT id_talhao FROM talhao WHERE nome = 'Talhão B1')),
('2025-10-20', 5.00, 90.00, 'Pulverização',
    (SELECT id_funcionario FROM funcionario WHERE cpf = '333.444.555-66'),
    (SELECT id_maquina FROM maquina WHERE modelo = 'New Holland T7.230'),
    (SELECT id_talhao FROM talhao WHERE nome = 'Talhão B1')),
('2026-02-25', 10.00, 350.00, 'Colheita',
    (SELECT id_funcionario FROM funcionario WHERE cpf = '222.333.444-55'),
    (SELECT id_maquina FROM maquina WHERE modelo = 'Case IH Axial-Flow 8250'),
    (SELECT id_talhao FROM talhao WHERE nome = 'Talhão C1'));