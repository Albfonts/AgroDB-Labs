# Modelo Lógico - AgroDB Farm

Este documento descreve todas as tabelas do banco de dados do MVP 1.0.

---

# Módulo Produção

- produtor
- fazenda
- talhao
- cultura
- safra
- producao

---

# Módulo Comercial

- cliente
- venda
- item_venda

---

# Módulo Suprimentos

- fornecedor
- produto
- estoque
- compra
- item_compra

---

# Módulo Operações

- funcionario
- maquina
- utilizacao_maquina

---

# Tabela: produtor

## Descrição

Armazena os dados dos produtores rurais cadastrados no sistema.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_produtor | BIGINT (IDENTITY) | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome do produtor |
| cpf_cnpj | VARCHAR(18) | Sim | Documento do produtor (UNIQUE) |
| telefone | VARCHAR(20) | Não | Telefone para contato |
| email | VARCHAR(150) | Não | E-mail |
| cidade | VARCHAR(100) | Não | Cidade |
| estado | VARCHAR(2) | Não | Sigla da Unidade Federativa |

---

# Tabela: fazenda

## Descrição

Armazena as fazendas pertencentes aos produtores cadastrados.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_fazenda | BIGINT (IDENTITY) | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome da fazenda |
| area_total | NUMERIC(12,2) | Sim | Área total em hectares (CHECK > 0) |
| cidade | VARCHAR(100) | Não | Cidade |
| estado | VARCHAR(2) | Não | UF |
| id_produtor | BIGINT | Sim | Chave Estrangeira para produtor |

---

# Tabela: talhao

## Descrição

Representa uma divisão produtiva dentro de uma fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_talhao | BIGINT (IDENTITY) | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome do talhão |
| area_hectares | NUMERIC(12,2) | Sim | Área em hectares (CHECK > 0) |
| tipo_solo | VARCHAR(50) | Não | Tipo predominante do solo |
| status | VARCHAR(30) | Não | Situação atual do talhão |
| id_fazenda | BIGINT | Sim | Chave Estrangeira para fazenda |

---

# Tabela: cultura

## Descrição

Armazena as culturas agrícolas cultivadas na fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_cultura | BIGINT (IDENTITY) | Sim | Chave Primária |
| nome | VARCHAR(100) | Sim | Nome da cultura (UNIQUE) |
| tipo | VARCHAR(50) | Não | Categoria da cultura |
| ciclo_dias | INTEGER | Não | Duração média do ciclo em dias (CHECK > 0) |
| produtividade_media | NUMERIC(12,2) | Não | Produção média esperada por hectare |

---

# Tabela: safra

## Descrição

Representa uma safra agrícola de determinada cultura, plantada em um talhão específico.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_safra | BIGINT (IDENTITY) | Sim | Chave Primária |
| ano | INTEGER | Sim | Ano da safra |
| data_inicio | DATE | Sim | Início da safra |
| data_fim | DATE | Não | Encerramento da safra (CHECK >= data_inicio) |
| id_talhao | BIGINT | Sim | Chave Estrangeira para talhão |
| id_cultura | BIGINT | Sim | Chave Estrangeira para cultura |

---

# Tabela: producao

## Descrição

Registra a produção obtida ao final de uma safra. O talhão é obtido indiretamente
via `safra.id_talhao`, evitando redundância de dados.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_producao | BIGINT (IDENTITY) | Sim | Chave Primária |
| quantidade | NUMERIC(12,2) | Sim | Quantidade produzida (CHECK > 0) |
| unidade | VARCHAR(20) | Sim | Unidade de medida (kg, ton etc.) |
| data_colheita | DATE | Sim | Data da colheita |
| id_safra | BIGINT | Sim | Chave Estrangeira para safra |

---

# Tabela: cliente

## Descrição

Armazena os clientes que compram a produção agrícola.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_cliente | BIGINT (IDENTITY) | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome do cliente |
| cnpj | VARCHAR(18) | Sim | Documento da empresa (UNIQUE) |
| telefone | VARCHAR(20) | Não | Telefone para contato |
| email | VARCHAR(150) | Não | E-mail |
| cidade | VARCHAR(100) | Não | Cidade |
| estado | VARCHAR(2) | Não | Sigla da Unidade Federativa |

---

# Tabela: venda

## Descrição

Registra as vendas realizadas para os clientes.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_venda | BIGINT (IDENTITY) | Sim | Chave Primária |
| data_venda | DATE | Sim | Data da venda |
| valor_total | NUMERIC(14,2) | Sim | Valor total da venda (CHECK >= 0) |
| status | VARCHAR(30) | Não | Situação da venda |
| id_cliente | BIGINT | Sim | Chave Estrangeira para cliente |

---

# Tabela: item_venda

## Descrição

Relaciona os produtos vendidos em cada venda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_item_venda | BIGINT (IDENTITY) | Sim | Chave Primária |
| quantidade | NUMERIC(12,2) | Sim | Quantidade vendida (CHECK > 0) |
| valor_unitario | NUMERIC(14,2) | Sim | Preço por unidade (CHECK >= 0) |
| subtotal | NUMERIC(14,2) | Calculado | Coluna GENERATED: quantidade × valor_unitario |
| id_venda | BIGINT | Sim | Chave Estrangeira para venda |
| id_producao | BIGINT | Sim | Chave Estrangeira para produção |

---

# Tabela: fornecedor

## Descrição

Armazena os fornecedores de insumos agrícolas.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_fornecedor | BIGINT (IDENTITY) | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome do fornecedor |
| cnpj | VARCHAR(18) | Sim | Documento da empresa (UNIQUE) |
| telefone | VARCHAR(20) | Não | Telefone para contato |
| email | VARCHAR(150) | Não | E-mail |
| cidade | VARCHAR(100) | Não | Cidade |
| estado | VARCHAR(2) | Não | Sigla da Unidade Federativa |

---

# Tabela: produto

## Descrição

Armazena os produtos (insumos) utilizados na fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_produto | BIGINT (IDENTITY) | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome do produto (UNIQUE) |
| categoria | VARCHAR(50) | Não | Fertilizante, Herbicida, Semente etc. |
| unidade_medida | VARCHAR(20) | Não | kg, litro, saco, unidade |
| preco_unitario | NUMERIC(14,2) | Sim | Preço unitário do produto (CHECK >= 0) |

---

# Tabela: estoque

## Descrição

Controla a quantidade disponível de cada produto.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_estoque | BIGINT (IDENTITY) | Sim | Chave Primária |
| quantidade | NUMERIC(12,2) | Sim | Quantidade disponível (CHECK >= 0) |
| localizacao | VARCHAR(150) | Não | Local de armazenamento |
| ultima_atualizacao | DATE | Não | Última atualização |
| id_produto | BIGINT | Sim | Chave Estrangeira para produto |

---

# Tabela: compra

## Descrição

Registra as compras realizadas junto aos fornecedores.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_compra | BIGINT (IDENTITY) | Sim | Chave Primária |
| data_compra | DATE | Sim | Data da compra |
| valor_total | NUMERIC(14,2) | Sim | Valor total da compra (CHECK >= 0) |
| status | VARCHAR(30) | Não | Situação da compra |
| id_fornecedor | BIGINT | Sim | Chave Estrangeira para fornecedor |

---

# Tabela: item_compra

## Descrição

Relaciona os produtos adquiridos em cada compra.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_item_compra | BIGINT (IDENTITY) | Sim | Chave Primária |
| quantidade | NUMERIC(12,2) | Sim | Quantidade comprada (CHECK > 0) |
| valor_unitario | NUMERIC(14,2) | Sim | Preço unitário (CHECK >= 0) |
| subtotal | NUMERIC(14,2) | Calculado | Coluna GENERATED: quantidade × valor_unitario |
| id_compra | BIGINT | Sim | Chave Estrangeira para compra |
| id_produto | BIGINT | Sim | Chave Estrangeira para produto |

---

# Tabela: funcionario

## Descrição

Armazena os colaboradores que trabalham na fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_funcionario | BIGINT (IDENTITY) | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome completo |
| cpf | VARCHAR(14) | Sim | Documento do funcionário (UNIQUE) |
| telefone | VARCHAR(20) | Não | Telefone para contato |
| email | VARCHAR(150) | Não | E-mail |
| cargo | VARCHAR(80) | Não | Cargo exercido |
| salario | NUMERIC(14,2) | Não | Salário mensal (CHECK > 0) |
| data_admissao | DATE | Não | Data de admissão |

---

# Tabela: maquina

## Descrição

Armazena as máquinas agrícolas utilizadas nas operações da fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_maquina | BIGINT (IDENTITY) | Sim | Chave Primária |
| modelo | VARCHAR(100) | Sim | Modelo da máquina |
| marca | VARCHAR(100) | Não | Fabricante |
| potencia | NUMERIC(10,2) | Não | Potência em CV (CHECK > 0) |
| ano_fabricacao | INTEGER | Não | Ano de fabricação |
| consumo_medio | NUMERIC(10,2) | Não | Litros por hora (CHECK >= 0) |

---

# Tabela: utilizacao_maquina

## Descrição

Registra a utilização das máquinas agrícolas durante as operações nos talhões.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_utilizacao | BIGINT (IDENTITY) | Sim | Chave Primária |
| data_utilizacao | DATE | Sim | Data da operação |
| horas_trabalhadas | NUMERIC(8,2) | Sim | Horas trabalhadas (CHECK > 0) |
| combustivel_consumido | NUMERIC(10,2) | Não | Litros consumidos (CHECK >= 0) |
| atividade | VARCHAR(150) | Não | Ex: Preparo do Solo, Plantio, Colheita |
| id_funcionario | BIGINT | Sim | Chave Estrangeira para funcionário |
| id_maquina | BIGINT | Sim | Chave Estrangeira para máquina |
| id_talhao | BIGINT | Sim | Chave Estrangeira para talhão |