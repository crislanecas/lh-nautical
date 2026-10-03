# LH Nautical — Análise de Dados e Sistema de Recomendação

![Dashboard LH Nautical](./05.%20Power%20BI/dashboard.png)

Projeto de análise de dados ponta a ponta desenvolvido a partir do desafio técnico da Indicium Academy, utilizando dados da LH Nautical, empresa fictícia de varejo náutico.

A solução envolveu análise exploratória, estruturação e preparação dos dados, criação de schema e carregamento em PostgreSQL, desenvolvimento de consultas SQL para análise de vendas e clientes, construção de uma dimensão de calendário, previsão de demanda utilizando Python e sistema de recomendação baseado em similaridade de cosseno.

O projeto também incluiu a construção de um dashboard no Power BI para acompanhamento de indicadores como faturamento, ticket médio, pedidos, vendas por período, desempenho por categoria e produtos.

---

## 📌 Sobre o projeto

A LH Nautical possui dados operacionais de 2020 a 2026 distribuídos em 24 arquivos CSV, representando diferentes áreas do negócio, como catálogo de produtos, vendas, pagamentos, estoque e devoluções.

O desafio propôs transformar esses dados brutos em informações úteis para apoiar decisões de negócio.

A solução foi desenvolvida utilizando:
- SQL
- PostgreSQL
- Python
- Pandas
- NumPy
- Scikit-learn
- Power BI
- DAX

O trabalho foi estruturado em etapas, acompanhando o fluxo de um projeto de dados:

**Dados brutos → PostgreSQL → SQL → Python → Power BI → Insights**

---

## 🎯 Objetivos

O projeto teve como principais objetivos:

- Compreender a estrutura e a qualidade dos dados;
- Criar um schema PostgreSQL a partir dos arquivos CSV;
- Realizar o carregamento dos dados no banco;
- Analisar o comportamento de clientes e vendas;
- Construir uma dimensão de calendário;
- Desenvolver um baseline para previsão de demanda;
- Criar um sistema de recomendação baseado em similaridade de compra;
- Comunicar os principais resultados por meio de um dashboard.

---

# 🗂️ Estrutura do projeto

```text
## 📁 Estrutura do projeto

```text
lh-nautical/
│
├── 03_sql/
│   ├── 2_schema.sql
│   ├── 3_validacao.sql
│   ├── 4_analise_clientes.sql
│   ├── 5_calendario.sql
│   ├── 6_previsao.sql
│   ├── 6_validacao.sql
│   ├── 7_recomendacao.sql
│   ├── 8_validacao_powerbi.sql
│   └── 8_validacao_powerbi_asdf.sql
│
├── 04_python/
│   ├── 2_schema.ipynb
│   ├── 3_carregamento.ipynb
│   ├── 6_modelo_previsao.ipynb
│   ├── 7_recomendacao.ipynb
│   ├── dataset_teste.csv
│   └── dataset_treino.csv
│
├── 05_power_bi/
│   ├── dashboard.png
│   └── dashboard.pbix
│
├── 06_relatorio/
│   └── Relatorio.pdf
│
├── .gitignore
└── README.md
```

⚠️ Observações sobre os dados

Durante as etapas do desafio, foram mantidas as premissas estabelecidas no enunciado. Portanto, nem todos os dados foram tratados ou corrigidos, especialmente nas etapas em que o desafio solicitava explicitamente a preservação dos dados brutos.

Alguns arquivos de apoio, versões intermediárias e materiais de referência são mantidos fora do versionamento conforme definido no .gitignore.
