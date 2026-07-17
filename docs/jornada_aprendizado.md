# 📔 Jornada de Aprendizado — AgroDB Labs

Diário de bordo do projeto:

---

### 2026-07

**Conceito:** Constraints (UNIQUE e CHECK)

**O que aprendi:** Ter Foreign Key certinha não garante integridade
sozinha. FK só garante que o relacionamento existe. Faltava UNIQUE pra
impedir CPF/CNPJ duplicado, e CHECK pra impedir valores absurdos, tipo
área negativa ou salário zerado.

**Exemplo no projeto:**
```sql
ALTER TABLE produtor
ADD CONSTRAINT uq_produtor_cpf_cnpj UNIQUE (cpf_cnpj);

ALTER TABLE talhao
ADD CONSTRAINT chk_talhao_area_hectares CHECK (area_hectares > 0);
```

**Utilidade:** Sem isso, o banco aceitava dois produtores com o mesmo CPF,
ou um talhão com -50 hectares. Agora o próprio banco recusa esse tipo de
erro antes de virar problema.

---

### 2026-07

**Conceito:** JOIN explícito (SQL-92)

**O que aprendi:** Existe um jeito antigo de relacionar tabelas, colocando
as duas no FROM separadas por vírgula e filtrando no WHERE. O padrão
correto desde o SQL-92 é o JOIN explícito com ON, que separa "de onde vêm
os dados" de "como filtrar o resultado".

**Exemplo no projeto:**
```sql
-- Forma correta (SQL-92)
SELECT p.nome, f.nome
FROM produtor p
INNER JOIN fazenda f ON f.id_produtor = p.id_produtor;
```

**Utilidade:** Deixa a consulta mais fácil de ler e de dar manutenção,
principalmente quando preciso encadear vários JOIN seguidos.

---

### 2026-07

**Conceito:** INNER JOIN encadeado

**O que aprendi:** Dá pra encadear vários INNER JOIN pra atravessar uma
cadeia inteira de relacionamento, não só juntar duas tabelas. No meu
modelo, consegui ir de produtor até cultura numa consulta só.

**Exemplo no projeto:**
```sql
SELECT p.nome AS produtor, f.nome AS fazenda, t.nome AS talhao,
       c.nome AS cultura, s.ano AS ano_safra
FROM produtor p
INNER JOIN fazenda f ON f.id_produtor = p.id_produtor
INNER JOIN talhao t  ON t.id_fazenda  = f.id_fazenda
INNER JOIN safra s   ON s.id_talhao   = t.id_talhao
INNER JOIN cultura c ON c.id_cultura  = s.id_cultura
ORDER BY p.nome, f.nome, t.nome;
```

**Utilidade:** Respondo de uma vez "o que está plantado e onde", sem
precisar de várias consultas separadas. Se um talhão ainda não tiver
safra, ele some do resultado — é o gancho pra entender o LEFT JOIN mais
pra frente.

---

### 2026-07

**Conceito:** SELECT, WHERE, ORDER BY, AND / OR / NOT

**O que aprendi:** A base de tudo. SELECT define quais colunas eu quero
ver, WHERE filtra as linhas, ORDER BY define a ordem, e AND/OR/NOT
combinam condições de filtro.

**Exemplo no projeto:**
```sql
SELECT v.data_venda, v.valor_total, v.status, cl.nome AS cliente
FROM venda v
INNER JOIN cliente cl ON cl.id_cliente = v.id_cliente
WHERE v.status = 'Concluída'
  AND v.valor_total > 900000
  AND NOT cl.nome = 'Cargill Agrícola S.A.'
ORDER BY v.valor_total DESC;
```

**Utilidade:** Consigo isolar exatamente as vendas que me interessam sem
precisar olhar a tabela inteira. Percebi que `NOT nome = 'X'` e
`nome <> 'X'` fazem a mesma coisa, mas o segundo é o mais usado na
prática.

---

