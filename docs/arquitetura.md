# Arquitetura do Sistema

## Visão Geral

A AgroDB Farm foi organizada utilizando uma arquitetura baseada em domínios de negócio.

Essa divisão facilita a manutenção, evolução do sistema e organização da base de dados.

---

# Domínios do Sistema

## Produção

Responsável pelo gerenciamento da produção agrícola.

Entidades:

- Produtor
- Fazenda
- Talhão
- Cultura
- Safra
- Produção

---

## Suprimentos

Responsável pelo controle dos insumos agrícolas.

Entidades:

- Fornecedor
- Compra
- Item Compra
- Produto Insumo
- Estoque

---

## Comercial

Responsável pelo processo de comercialização da produção.

Entidades:

- Cliente
- Venda
- Item Venda

---

## Operação

Responsável pelo controle operacional da fazenda.

Entidades:

- Funcionário
- Máquina
- Utilização de Máquina

---

# Objetivos da Arquitetura

A arquitetura foi projetada para:

- Facilitar a manutenção.
- Evitar redundância de dados.
- Garantir integridade referencial.
- Facilitar futuras integrações.
- Permitir crescimento do sistema.

---

# Evolução Futura

O projeto deverá evoluir para uma plataforma completa composta por:

- Banco de Dados PostgreSQL
- API REST
- Dashboard Web
- Business Intelligence
- Inteligência de Dados
- Relatórios Gerenciais
- Dashboards Analíticos

---

# Tecnologias

O projeto utilizará:

- PostgreSQL
- Docker
- Docker Compose
- Git
- GitHub
- VS Code
- Draw.io
- SQL

No futuro serão adicionadas novas tecnologias para desenvolvimento da aplicação e análise de dados.