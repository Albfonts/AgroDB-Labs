# 🌾 AgroDB Labs

Projeto desenvolvido para estudo de Banco de Dados, PostgreSQL e Administração de Banco de Dados (DBA).

O objetivo é simular um ambiente real de uma empresa do agronegócio, modelando um banco de dados desde o levantamento de requisitos até consultas SQL, otimização e documentação.

---

## Objetivos

Este projeto tem como finalidade:

- Praticar modelagem de banco de dados.
- Aprender PostgreSQL na prática.
- Aplicar conceitos de normalização.
- Desenvolver consultas SQL.
- Simular atividades de um DBA.
- Construir um portfólio profissional.

---

## Empresa Fictícia

A **AgroDB Farm** é uma empresa fictícia do setor agrícola responsável pela produção e comercialização de:

- 🌱 Soja
- 🌽 Milho
- 🎋 Cana-de-açúcar

O sistema controla produtores, fazendas, talhões, safras, culturas, produção, clientes, vendas, fornecedores, produtos, estoque, compras, funcionários, máquinas e utilização de máquinas.

---

## Tecnologias

- PostgreSQL 17
- Docker
- Docker Compose
- pgAdmin 4
- VS Code
- Git
- GitHub

---

## Estrutura do Projeto

```
AgroDB-Labs
│
├── database/
│   ├── schema.sql
│   └── seed.sql
│
├── diagrams/
│   ├── modelo_conceitual.drawio
│   └── modelo_conceitual.png
│
├── docker/
│   ├── docker-compose.yml
│   └── .env.example
│
├── docs/
│   ├── arquitetura.md
│   ├── dicionario_dados.md
│   ├── modelo_logico.md
│   ├── modelo_negocio.md
│   └── padroes_projeto.md
│
├── .gitignore
└── README.md
```

---

## Modelo de Dados

O banco de dados está organizado em **4 módulos**, totalizando **17 tabelas**:

### Produção
`produtor` → `fazenda` → `talhao` → `safra` → `producao`, relacionadas com `cultura`.

### Comercial
`cliente` → `venda` → `item_venda`, relacionado com `producao`.

### Suprimentos
`fornecedor` → `compra` → `item_compra`, relacionado com `produto` e `estoque`.

### Operações
`funcionario`, `maquina` e `utilizacao_maquina`, relacionado com `talhao`.

**Convenções utilizadas:**
- `snake_case` em todas as tabelas e colunas.
- Tabelas no singular.
- Chaves primárias com `GENERATED ALWAYS AS IDENTITY` (sem `SERIAL` ou `UUID`).
- Chaves estrangeiras nomeadas como `CONSTRAINT fk_origem_destino`.
- `NUMERIC` para valores monetários, áreas, pesos e consumo.
- `DATE` para todas as datas.

---

## Como executar o projeto

1. Clone o repositório:
```bash
git clone https://github.com/Albfonts/AgroDB-Labs.git
cd AgroDB-Labs
```

2. Configure as variáveis de ambiente:
```bash
cd docker
cp .env.example .env
```
Edite o arquivo `.env` com suas próprias credenciais.

3. Suba os containers:
```bash
docker-compose up -d
```

4. Acesse o pgAdmin em `http://localhost:5050` e conecte ao servidor PostgreSQL.

5. Execute os scripts na seguinte ordem, usando o Query Tool do pgAdmin:
   - `database/schema.sql` (cria as 17 tabelas)
   - `database/seed.sql` (popula com dados de exemplo)

---

## Roadmap

- [x] Levantamento de requisitos
- [x] Modelagem conceitual
- [x] Modelagem lógica
- [x] Modelagem física
- [x] Criação do schema
- [x] Inserção de dados (seed)
- [x] Ambiente Docker configurado
- [ ] Consultas SQL (SELECT, JOIN, GROUP BY, CTE, subconsultas)
- [ ] Views
- [ ] Índices
- [ ] Procedures e Triggers
- [ ] Backup e Restore
- [ ] Otimização de consultas (EXPLAIN/ANALYZE)

---

## Status

🚧 Sprint 2 em desenvolvimento — modelagem e ambiente concluídos, iniciando consultas analíticas.

---

## Autor

**Daniel Albor**

Estudante de Análise e Desenvolvimento de Sistemas.

Projeto desenvolvido para construção de portfólio na área de Banco de Dados / DBA.