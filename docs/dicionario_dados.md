# Dicionário de Dados

Este documento descreve as entidades e os atributos do banco de dados da AgroDB Farm.

---

# Entidade: Produtor

| Atributo | Descrição |
|----------|-----------|
| id_produtor | Identificador único do produtor |
| nome | Nome do produtor |
| cpf_cnpj | CPF ou CNPJ (único) |
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
| area_total | Área total da fazenda, em hectares |
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
| nome | Nome da cultura (único) |
| tipo | Tipo da cultura |
| ciclo_dias | Ciclo médio, em dias |
| produtividade_media | Produção média esperada |

---

# Entidade: Safra

| Atributo | Descrição |
|----------|-----------|
| id_safra | Identificador único |
| ano | Ano da safra |
| data_inicio | Início |
| data_fim | Fim |
| id_talhao | Talhão onde a safra foi plantada |
| id_cultura | Cultura plantada |

---

# Entidade: Produção

| Atributo | Descrição |
|----------|-----------|
| id_producao | Identificador |
| quantidade | Quantidade produzida |
| unidade | Unidade de medida |
| data_colheita | Data da colheita |
| id_safra | Safra que originou a produção |

---

# Entidade: Cliente

| Atributo | Descrição |
|----------|-----------|
| id_cliente | Identificador |
| nome | Nome |
| cnpj | CNPJ (único) |
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
| valor_total | Valor total da venda |
| status | Situação da venda |
| id_cliente | Cliente comprador |

---

# Entidade: Item Venda

| Atributo | Descrição |
|----------|-----------|
| id_item_venda | Identificador |
| quantidade | Quantidade vendida |
| valor_unitario | Preço por unidade |
| subtotal | Coluna calculada (quantidade × valor_unitario) |
| id_venda | Venda relacionada |
| id_producao | Produção vendida |

---

# Entidade: Fornecedor

| Atributo | Descrição |
|----------|-----------|
| id_fornecedor | Identificador |
| nome | Nome |
| cnpj | CNPJ (único) |
| telefone | Telefone |
| email | E-mail |
| cidade | Cidade |
| estado | Estado |

---

# Entidade: Produto

| Atributo | Descrição |
|----------|-----------|
| id_produto | Identificador |
| nome | Nome do produto (único) |
| categoria | Categoria (Fertilizante, Semente, Defensivo etc.) |
| unidade_medida | Unidade (kg, L, saco...) |
| preco_unitario | Preço unitário do produto |

---

# Entidade: Estoque

| Atributo | Descrição |
|----------|-----------|
| id_estoque | Identificador |
| quantidade | Quantidade disponível |
| localizacao | Local de armazenamento |
| ultima_atualizacao | Data da última atualização |
| id_produto | Produto em estoque |

---

# Entidade: Compra

| Atributo | Descrição |
|----------|-----------|
| id_compra | Identificador |
| data_compra | Data |
| valor_total | Valor total da compra |
| status | Situação da compra |
| id_fornecedor | Fornecedor |

---

# Entidade: Item Compra

| Atributo | Descrição |
|----------|-----------|
| id_item_compra | Identificador |
| quantidade | Quantidade comprada |
| valor_unitario | Preço unitário |
| subtotal | Coluna calculada (quantidade × valor_unitario) |
| id_compra | Compra relacionada |
| id_produto | Produto comprado |

---

# Entidade: Funcionário

| Atributo | Descrição |
|----------|-----------|
| id_funcionario | Identificador |
| nome | Nome |
| cpf | CPF (único) |
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
| potencia | Potência, em CV |
| ano_fabricacao | Ano de fabricação |
| consumo_medio | Consumo médio, em L/h |

---

# Entidade: Utilização de Máquina

| Atributo | Descrição |
|----------|-----------|
| id_utilizacao | Identificador |
| data_utilizacao | Data da operação |
| horas_trabalhadas | Horas trabalhadas |
| combustivel_consumido | Litros consumidos |
| atividade | Atividade realizada (Plantio, Colheita etc.) |
| id_funcionario | Funcionário responsável |
| id_maquina | Máquina utilizada |
| id_talhao | Talhão onde ocorreu a operação |

---

# Convenções

- Tabelas em singular.
- Nomes em minúsculas, sem espaços e sem acentos (snake_case).
- Chaves primárias iniciadas por `id_`, do tipo `BIGINT GENERATED ALWAYS AS IDENTITY`.
- Chaves estrangeiras utilizam o mesmo nome da chave primária referenciada.
- Constraints nomeadas seguindo o padrão `fk_<origem>_<destino>`, `uq_<tabela>_<coluna>` e `chk_<tabela>_<coluna>`.
- Colunas monetárias, de área e de quantidade utilizam `NUMERIC`.
- Datas utilizam o tipo `DATE`.
