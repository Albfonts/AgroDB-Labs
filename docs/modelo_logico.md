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
| id_produtor | INTEGER | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome do produtor |
| cpf_cnpj | VARCHAR(18) | Sim | Documento do produtor (UNIQUE)|
| telefone | VARCHAR(20) | Não | Telefone para contato |
| email | VARCHAR(150) | Não | E-mail |
| cidade | VARCHAR(100) | Sim | Cidade |
| estado | VARCHAR(2) | Sim | Sigla da Unidade Federativa |

---

# Tabela: fazenda

## Descrição

Armazena as fazendas pertencentes aos produtores cadastrados.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_fazenda | INTEGER | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome da fazenda |
| area_total | NUMERIC(10,2) | Sim | Área total em hectares |
| cidade | VARCHAR(100) | Sim | Cidade |
| estado | VARCHAR(2) | Sim | UF |
| id_produtor | INTEGER | Sim | Chave Estrangeira para produtor |

---

# Tabela: talhao

## Descrição

Representa uma divisão produtiva dentro de uma fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_talhao | INTEGER | Sim | Chave Primária |
| nome | VARCHAR(100) | Sim | Nome do talhão |
| area_hectares | NUMERIC(8,2) | Sim | Área em hectares |
| tipo_solo | VARCHAR(50) | Sim | Tipo predominante do solo |
| status | VARCHAR(20) | Sim | Situação atual do talhão|
| id_fazenda | INTEGER | Sim | Chave Estrangeira para fazenda |

---

# Tabela: cultura

## Descrição

Armazena as culturas agrícolas cultivadas na fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_cultura | INTEGER | Sim | Chave Primária |
| nome | VARCHAR(100) | Sim | Nome da cultura |
| tipo | VARCHAR(50) | Sim | Categoria da cultura |
| ciclo_dias | INTEGER | Sim | Duração média do ciclo em dias |
| produtividade_media | NUMERIC(10,2) | Não | Produção média esperada por hectare |

---

# Tabela: safra

## Descrição

Representa uma safra agrícola de determinada cultura.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_safra | INTEGER | Sim | Chave Primária |
| ano | INTEGER | Sim | Ano da safra |
| data_inicio | DATE | Sim | Início da safra |
| data_fim | DATE | Sim | Encerramento da safra |
| id_cultura | INTEGER | Sim | Chave Estrangeira para cultura |

---

# Tabela: producao

## Descrição

Registra a produção obtida em cada talhão durante uma safra.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_producao | INTEGER | Sim | Chave Primária |
| quantidade | NUMERIC(12,2) | Sim | Quantidade produzida |
| unidade | VARCHAR(20) | Sim | Unidade de medida (kg, ton etc.) |
| data_colheita | DATE | Sim | Data da colheita |
| id_talhao | INTEGER | Sim | Chave Estrangeira para talhão |
| id_safra | INTEGER | Sim | Chave Estrangeira para safra |

---

# Tabela: cliente

## Descrição

Armazena os clientes que compram a produção agrícola.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_cliente | INTEGER | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome do cliente |
| cnpj | VARCHAR(18) | Sim | Documento da empresa (UNIQUE) |
| telefone | VARCHAR(20) | Não | Telefone para contato |
| email | VARCHAR(150) | Não | E-mail |
| cidade | VARCHAR(100) | Sim | Cidade |
| estado | VARCHAR(2) | Sim | Sigla da Unidade Federativa |

---

# Tabela: venda

## Descrição

Registra as vendas realizadas para os clientes.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_venda | INTEGER | Sim | Chave Primária |
| data_venda | DATE | Sim | Data da venda |
| valor_total | NUMERIC(12,2) | Sim | Valor total da venda |
| status | VARCHAR(20) | Sim | Situação da venda |
| id_cliente | INTEGER | Sim | Chave Estrangeira para cliente |

---

# Tabela: item_venda

## Descrição

Relaciona os produtos vendidos em cada venda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_item_venda | INTEGER | Sim | Chave Primária |
| quantidade | NUMERIC(12,2) | Sim | Quantidade vendida |
| preco_unitario | NUMERIC(12,2) | Sim | Preço por unidade |
| subtotal | NUMERIC(12,2) | Sim | Valor parcial do item |
| id_venda | INTEGER | Sim | Chave Estrangeira para venda |
| id_producao | INTEGER | Sim | Chave Estrangeira para produção |

---

# Tabela: fornecedor

## Descrição

Armazena os fornecedores de insumos agrícolas.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_fornecedor | INTEGER | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome do fornecedor |
| cnpj | VARCHAR(18) | Sim | Documento da empresa (UNIQUE) |
| telefone | VARCHAR(20) | Não | Telefone para contato |
| email | VARCHAR(150) | Não | E-mail |
| cidade | VARCHAR(100) | Sim | Cidade |
| estado | VARCHAR(2) | Sim | Sigla da Unidade Federativa |

---

# Tabela: produto

## Descrição

Armazena os produtos utilizados na fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_produto | INTEGER | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome do produto |
| categoria | VARCHAR(50) | Sim | Fertilizante, Herbicida, Semente etc. |
| unidade_medida | VARCHAR(20) | Sim | kg, litro, saco, unidade |
| preco_medio | NUMERIC(12,2) | Não | Preço médio do produto |

---

# Tabela: estoque

## Descrição

Controla a quantidade disponível de cada produto.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_estoque | INTEGER | Sim | Chave Primária |
| quantidade | NUMERIC(12,2) | Sim | Quantidade disponível |
| localizacao | VARCHAR(100) | Sim | Local de armazenamento |
| data_atualizacao | DATE | Sim | Última atualização |
| id_produto | INTEGER | Sim | Chave Estrangeira para produto |

---

# Tabela: compra

## Descrição

Registra as compras realizadas junto aos fornecedores.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_compra | INTEGER | Sim | Chave Primária |
| data_compra | DATE | Sim | Data da compra |
| valor_total | NUMERIC(12,2) | Sim | Valor total da compra |
| status | VARCHAR(20) | Sim | Situação da compra |
| id_fornecedor | INTEGER | Sim | Chave Estrangeira para fornecedor |

---

# Tabela: item_compra

## Descrição

Relaciona os produtos adquiridos em cada compra.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_item_compra | INTEGER | Sim | Chave Primária |
| quantidade | NUMERIC(12,2) | Sim | Quantidade comprada |
| preco_unitario | NUMERIC(12,2) | Sim | Preço unitário |
| subtotal | NUMERIC(12,2) | Sim | Valor parcial do item |
| id_compra | INTEGER | Sim | Chave Estrangeira para compra |
| id_produto | INTEGER | Sim | Chave Estrangeira para produto | 

---

# Tabela: funcionario

## Descrição

Armazena os colaboradores que trabalham na fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_funcionario | INTEGER | Sim | Chave Primária |
| nome | VARCHAR(150) | Sim | Nome completo |
| cpf | VARCHAR(14) | Sim | Documento do funcionário (UNIQUE) |
| telefone | VARCHAR(20) | Não | Telefone para contato |
| email | VARCHAR(150) | Não | E-mail |
| cargo | VARCHAR(100) | Sim | Cargo exercido |
| salario | NUMERIC(10,2) | Sim | Salário mensal |
| data_admissao | DATE | Sim | Data de admissão |

---

# Tabela: maquina

## Descrição

Armazena as máquinas agrícolas utilizadas nas operações da fazenda.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_maquina | INTEGER | Sim | Chave Primária |
| modelo | VARCHAR(100) | Sim | Modelo da máquina |
| marca | VARCHAR(100) | Sim | Fabricante |
| potencia | INTEGER | Sim | Potência em CV |
| ano_fabricacao | INTEGER | Sim | Ano de fabricação |
| consumo_medio | NUMERIC(6,2) | Não | Litros por hora |

---

# Tabela: utilizacao_maquina

## Descrição

Registra a utilização das máquinas agrícolas durante as operações nos talhões.

## Atributos

| Coluna | Tipo | Obrigatório | Observação |
|---------|------|-------------|------------|
| id_utilizacao | INTEGER | Sim | Chave Primária |
| data_inicio | TIMESTAMP | Sim | Início da operação |
| data_fim | TIMESTAMP | Sim | Fim da operação |
| horas_trabalhadas | NUMERIC(5,2) | Sim | Horas trabalhadas |
| combustivel_consumido | NUMERIC(8,2) | Não | Litros consumidos |
| id_funcionario | INTEGER | Sim | Chave Estrangeira para funcionário |
| id_maquina | INTEGER | Sim | Chave Estrangeira para máquina |
| id_talhao | INTEGER | Sim | Chave Estrangeira para talhão |