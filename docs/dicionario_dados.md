# Dicionário de Dados

Este documento descreve as entidades e os principais atributos do banco de dados da AgroDB Farm.

---

# Entidade: Produtor

| Atributo | Descrição |
|----------|-----------|
| id_produtor | Identificador único do produtor |
| nome | Nome do produtor |
| cpf_cnpj | CPF ou CNPJ |
| telefone | Telefone para contato |
| email | E-mail do produtor |
| cidade | Cidade onde está localizado |
| estado | Estado onde está localizado |

---

# Entidade: Talhão

| Atributo | Descrição |
|----------|-----------|
| id_talhao | Identificador único do talhão |
| nome | Nome do talhão |
| area_hectares | Área do talhão em hectares |
| localizacao | Localização do talhão |
| tipo_solo | Tipo de solo predominante |
| status | Situação do talhão (ativo ou inativo) |
| id_produtor | Produtor responsável pelo talhão |

---

# Entidade: Cultura

| Atributo | Descrição |
|----------|-----------|
| id_cultura | Identificador único da cultura |
| nome | Nome da cultura |
| tipo | Tipo da cultura (grão, cereal etc.) |
| ciclo_dias | Tempo médio de cultivo em dias |
| produtividade_media | Produção média esperada por hectare |

---

# Entidade: Safra

| Atributo | Descrição |
|----------|-----------|
| id_safra | Identificador único da safra |
| ano | Ano da safra |
| data_inicio | Data de início da safra |
| data_fim | Data de encerramento da safra |
| id_cultura | Cultura plantada na safra |

---

# Entidade: Máquina

| Atributo | Descrição |
|----------|-----------|
| id_maquina | Identificador único da máquina |
| modelo | Modelo da máquina |
| marca | Fabricante da máquina |
| potencia | Potência do equipamento |
| ano_fabricacao | Ano de fabricação |
| consumo_medio | Consumo médio de combustível |

> **Observação:** A relação entre funcionários e máquinas será modelada posteriormente por meio de uma tabela intermediária.

---

# Entidade: Funcionário

| Atributo | Descrição |
|----------|-----------|
| id_funcionario | Identificador único do funcionário |
| nome | Nome completo |
| cpf | CPF do funcionário |
| telefone | Telefone para contato |
| email | E-mail |
| cargo | Cargo exercido |
| salario | Salário |
| data_admissao | Data de admissão |

---

# Entidade: Cliente

| Atributo | Descrição |
|----------|-----------|
| id_cliente | Identificador único do cliente |
| nome | Nome do cliente |
| cnpj | CNPJ da empresa cliente |
| telefone | Telefone para contato |
| email | E-mail |
| cidade | Cidade |
| estado | Estado |


---

# Próximas Entidades

As seguintes entidades serão detalhadas nas próximas etapas do projeto:

- Fornecedor
- Produto
- Estoque
- Compra
- Venda
- Item Compra
- Item Venda
- Utilização de Máquina
- Aplicação de Insumos

---

## Convenções

Durante todo o projeto serão adotadas as seguintes convenções:

- Nomes de tabelas em singular.
- Nomes em letras minúsculas.
- Sem acentos.
- Sem espaços.
- Chaves primárias iniciadas por `id_`.
- Relacionamentos representados por chaves estrangeiras (`Foreign Keys`).