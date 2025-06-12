# 🏥 Hospital Management Database - SQL Project

## 📝 Descrição do Projeto
Este repositório contém um sistema completo de banco de dados para gestão hospitalar, implementado em MySQL. O projeto demonstra habilidades em modelagem de dados, consultas SQL complexas e programação em banco de dados.

## 🗃️ Estrutura do Banco de Dados
O sistema inclui as seguintes tabelas principais:
- **Convenios**: Cadastro de planos de saúde
- **Especialidades**: Áreas médicas disponíveis
- **Medicos**: Corpo clínico com CRM e especialidades
- **Pacientes**: Cadastro completo de pacientes
- **Consultas**: Registro de atendimentos médicos
- **Internacoes**: Controle de internações hospitalares

## 💻 Conteúdo Técnico
### ✅ Principais Recursos Implementados
**Modelagem Relacional Completa**
- Chaves primárias e estrangeiras
- Constraints de integridade
- Relacionamentos 1:N e N:M

**Consultas SQL Avançadas**
- JOINs entre múltiplas tabelas
- Funções agregadas (SUM, COUNT)
- Filtros com WHERE e HAVING
- Cálculos de datas (TIMESTAMPDIFF)

**Programação SQL**
- Stored Procedures para relatórios
- Views para simplificar consultas
- Índices para otimização

## 📂 Estrutura de Arquivos
O projeto está organizado e todo comentado, dividido em 3 arquivos SQL principais:

1. **`create_insert.sql`**  
   - Criação do banco de dados e tabelas
   - Povoamento inicial com dados de exemplo

2. **`consultas_joins.sql`**  
   - Consultas básicas e avançadas
   - JOINs entre tabelas
   - Funções agregadas e filtros

3. **`procedures_index_views.sql`**  
   - Stored Procedures
   - Criação de Views
   - Índices de otimização

## 🚀 Como Executar
1. Execute o script completo em um servidor MySQL
2. Utilize os exemplos fornecidos para testar:

```sql
-- Exemplo de procedure
CALL sp_relatorio_consultas_periodo('2023-06-10', '2023-06-15');

-- Exemplo de view
SELECT * FROM vw_agenda_medica WHERE medico = 'Dr. Carlos Silva';



📩 Contato: https://biolink.website/socialKauanSilva
