# Dicionário de Dados

Este documento descreve as entidades e os principais atributos do banco de dados da AgroDB Farm.

---

# Entidade: Produtor

| Atributo | Descrição |
|----------|-----------|
| id_produtor | Identificador único do produtor |
| nome | Nome do produtor |
| cpf_cnpj | CPF ou CNPJ |
| telefone | Telefone |
| email | E-mail |
| cidade | Cidade |
| estado | Estado |

---

# Entidade: Fazenda

| Atributo | Descrição |
|----------|-----------|
| id_fazenda | Identificador único da fazenda |
| nome | Nome da fazenda |
| area_total | Área total da fazenda |
| cidade | Cidade |
| estado | Estado |
| id_produtor | Produtor proprietário |

---

# Entidade: Talhão

| Atributo | Descrição |
|----------|-----------|
| id_talhao | Identificador único do talhão |
| nome | Nome do talhão |
| area_hectares | Área em hectares |
| tipo_solo | Tipo de solo |
| status | Situação do talhão |
| id_fazenda | Fazenda responsável |

---

# Entidade: Cultura

| Atributo | Descrição |
|----------|-----------|
| id_cultura | Identificador único |
| nome | Nome da cultura |
| tipo | Tipo da cultura |
| ciclo_dias | Ciclo médio |
| produtividade_media | Produção média esperada |

---

# Entidade: Safra

| Atributo | Descrição |
|----------|-----------|
| id_safra | Identificador único |
| ano | Ano da safra |
| data_inicio | Início |
| data_fim | Fim |
| id_talhao | Talhão |
| id_cultura | Cultura |

---

# Entidade: Produção

| Atributo | Descrição |
|----------|-----------|
| id_producao | Identificador |
| quantidade | Quantidade produzida |
| unidade | Unidade de medida |
| data_colheita | Data da colheita |
| id_safra | Safra |

---

# Entidade: Funcionário

| Atributo | Descrição |
|----------|-----------|
| id_funcionario | Identificador |
| nome | Nome |
| cpf | CPF |
| telefone | Telefone |
| email | E-mail |
| cargo | Cargo |
| salario | Salário |
| data_admissao | Data de admissão |

---

# Entidade: Máquina

| Atributo | Descrição |
|----------|-----------|
| id_maquina | Identificador |
| modelo | Modelo |
| marca | Fabricante |
| potencia | Potência |
| ano_fabricacao | Ano de fabricação |
| consumo_medio | Consumo médio |

---

# Entidade: Utilização de Máquina

| Atributo | Descrição |
|----------|-----------|
| id_utilizacao | Identificador |
| data_utilizacao | Data |
| horas_trabalhadas | Horas trabalhadas |
| id_funcionario | Funcionário |
| id_maquina | Máquina |

---

# Entidade: Fornecedor

| Atributo | Descrição |
|----------|-----------|
| id_fornecedor | Identificador |
| nome | Nome |
| cnpj | CNPJ |
| telefone | Telefone |
| email | E-mail |

---

# Entidade: Compra

| Atributo | Descrição |
|----------|-----------|
| id_compra | Identificador |
| data_compra | Data |
| valor_total | Valor |
| id_fornecedor | Fornecedor |

---

# Entidade: Item Compra

| Atributo | Descrição |
|----------|-----------|
| id_item_compra | Identificador |
| quantidade | Quantidade |
| preco_unitario | Preço unitário |
| id_compra | Compra |
| id_produto | Produto |

---

# Entidade: Produto Insumo

| Atributo | Descrição |
|----------|-----------|
| id_produto | Identificador |
| nome | Nome |
| categoria | Categoria |
| unidade_medida | Unidade |
| preco_medio | Preço médio |

---

# Entidade: Estoque

| Atributo | Descrição |
|----------|-----------|
| id_estoque | Identificador |
| quantidade | Quantidade disponível |
| localizacao | Local |
| id_produto | Produto |

---

# Entidade: Cliente

| Atributo | Descrição |
|----------|-----------|
| id_cliente | Identificador |
| nome | Nome |
| cnpj | CNPJ |
| telefone | Telefone |
| email | E-mail |
| cidade | Cidade |
| estado | Estado |

---

# Entidade: Venda

| Atributo | Descrição |
|----------|-----------|
| id_venda | Identificador |
| data_venda | Data |
| valor_total | Valor |
| id_cliente | Cliente |

---

# Entidade: Item Venda

| Atributo | Descrição |
|----------|-----------|
| id_item_venda | Identificador |
| quantidade | Quantidade |
| preco_unitario | Preço unitário |
| id_venda | Venda |
| id_producao | Produção |

---

# Convenções

- Tabelas em singular.
- Nomes em minúsculas.
- Sem espaços.
- Sem acentos.
- Chaves primárias iniciadas por `id_`.
- Chaves estrangeiras utilizando o mesmo nome da chave primária da tabela relacionada.