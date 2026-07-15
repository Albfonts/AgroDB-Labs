# Padrões do Projeto

## Convenções de Nomenclatura

### Tabelas

- Letras minúsculas
- Nome no singular
- Sem acentos
- Utilizar snake_case

Exemplos:

- produtor
- fazenda
- item_venda
- utilizacao_maquina

---

### Colunas

- Letras minúsculas
- Snake_case
- Chaves primárias iniciadas por `id_`

Exemplos:

- id_produtor
- nome
- data_inicio
- preco_unitario

---

### Chaves Primárias

Todas as tabelas possuirão uma chave primária inteira chamada `id_<tabela>`.

Exemplos:

- id_produtor
- id_fazenda
- id_cliente

---

### Chaves Estrangeiras

As chaves estrangeiras utilizarão exatamente o mesmo nome da chave primária referenciada.

Exemplo:

Tabela `fazenda`

- id_produtor

---

### Objetivo

Manter um padrão único em todo o banco de dados para facilitar manutenção, leitura e escalabilidade.