# Desafio Técnico: Analista de Dados Pleno (BI) - Atendas CPaaS

## 1. Contexto do Negócio
A **Atendas CPaaS** é uma plataforma que permite a empresas enviarem e receberem mensagens por múltiplos canais (WhatsApp, SMS, E-mail e Webchat). Nosso modelo de receita baseia-se no faturamento por mensagem trafegada (volume x preço por mensagem). Cada canal possui um custo unitário (cobrado pelas operadoras/provedores) e um preço de venda praticado para o cliente.

Como **Analista de Dados Pleno (BI)**, sua missão é transformar os dados brutos de tráfego de mensagens e atendimentos de suporte em relatórios inteligentes e painéis interativos. Esses painéis guiarão os diretores da empresa nas decisões de precificação, expansão de canais e melhoria no suporte ao cliente.

---

## 2. Estrutura do Banco de Dados
O ambiente local contém um banco de dados PostgreSQL com quatro tabelas principais:
1. **`companies`**: Cadastro de empresas clientes (ID, nome, segmento de atuação, plano contratado, status atual, data de cadastro e data de churn, se houver).
2. **`channels`**: Cadastro de canais de comunicação com o custo unitário e preço unitário padrão de venda de cada canal.
3. **`messages_sent`**: Histórico detalhado de todas as mensagens trafegadas (ID único, ID da empresa, canal utilizado, direção [Inbound/Outbound], status da entrega [Delivered/Sent/Failed], data/hora do envio, custo real faturado e preço real cobrado do cliente).
4. **`support_tickets`**: Registro de tickets de suporte abertos pelos clientes (ID, ID da empresa, categoria do problema, status [Open/Resolved], data de criação, data de resolução e nota de avaliação do atendimento [CSAT, de 1 a 5]).

---

## 3. Tarefas a serem Realizadas

### Parte 1: Extração de Dados e Análises com SQL
Escreva consultas SQL otimizadas (e as salve em um arquivo `.sql` organizado) para responder às seguintes perguntas de negócio:

1. **Volume e Faturamento Mensal**: Retorne o volume total de mensagens enviadas (apenas `Outbound`), o faturamento bruto (soma de `billing_price`), o custo total (soma de `billing_cost`) e a margem de lucro bruta (em valor e em %) por mês e por canal de comunicação.
2. **Taxa de Sucesso de Entrega**: Calcule a taxa de entrega (`Delivered` em relação ao total de mensagens) mensal de cada canal. Identifique se algum canal está sofrendo com quedas acentuadas na qualidade de entrega.
3. **Análise de Churn e Perda de Receita (Revenue Leakage)**: Liste as empresas que deram churn (`status = 'Churned'`), indicando a data de saída, o segmento de atuação e a receita média mensal que essa empresa gerava nos 3 meses anteriores ao seu cancelamento.
4. **Acordo de Nível de Serviço (SLA) do Suporte**: Calcule o tempo médio de resolução de tickets (em horas) agrupado por categoria de ticket e por mês. Dica: use a diferença entre `resolved_at` e `created_at`.
5. **Satisfação do Cliente (CSAT)**: Calcule a nota média de CSAT (coluna `rating`) para cada segmento de empresa. Adicionalmente, traga o percentual de avaliações avaliadas como detratoras (notas 1 e 2) por categoria de suporte.

### Parte 2: Modelagem e Visualização no Apache Superset
Utilizando o Apache Superset (disponível em `http://localhost:8088`), conecte-se ao banco de dados e construa um dashboard contendo as seguintes três visões:

#### Visão Financeira:
- Indicadores globais (Cards): Receita Acumulada, Custo Acumulado, Margem Geral (%) e Quantidade de Clientes Ativos.
- Gráfico de Linhas/Área: Evolução mensal da Receita vs Custo.
- Tabela/Gráfico de Barras: Ranking dos 10 clientes que mais geram receita (Faturamento Bruto) e sua respectiva margem.

#### Visão Operacional:
- Gráfico de Barras Empilhadas: Volume de mensagens trafegadas mensalmente por canal.
- Gráfico de Linha: Evolução da taxa de sucesso de entrega por canal.
- Tabela de Eficiência: Detalhamento do volume de mensagens com status `Failed` por empresa e por canal (ajudando a identificar onde estão ocorrendo as falhas).

#### Visão de Atendimento (Suporte):
- Gráfico de Rosca/Pizza: Distribuição dos tickets abertos por categoria.
- Indicador (Card): SLA médio global (em horas) e CSAT médio global.
- Gráfico de Linha: Tendência mensal do CSAT.
- Tabela de Alerta: Clientes ativos com CSAT médio abaixo de 3.0 nos últimos 30 dias (indicação de risco de churn).

### Parte 3: Apresentação Executiva
Prepare uma breve apresentação (pode ser em PDF, Slides ou documento de texto estruturado) direcionada aos tomadores de decisão (C-Level). Ela deve conter:
1. **Destaques Financeiros**: Quais canais são os mais lucrativos e quais demandam atenção por conta de margens baixas.
2. **Pontos de Atenção Operacionais**: Gargalos de entrega ou falhas que estão afetando a experiência dos clientes.
3. **Plano de Ação para Retenção**: Com base nos dados de suporte e CSAT, quais clientes deveriam receber contato imediato da equipe de Customer Success (CS) para evitar novos churns?

---

## 4. O que será Avaliado?
- **Qualidade do SQL**: Uso de boas práticas, organização de código (CTE's, identação, aliases claros), uso correto de agregadores e tratamento de valores nulos.
- **Visualização de Dados**: Escolha correta dos gráficos, legibilidade das informações, uso de filtros interativos, design harmonioso e intuitivo do dashboard.
- **Raciocínio Analítico**: Capacidade de conectar os números (como falhas técnicas no SMS ou demora no suporte) com impactos de negócio (como o churn do cliente).
- **Comunicação Executiva**: Clareza, objetividade e relevância das recomendações propostas na apresentação.

---

## 5. Instruções de Entrega
O candidato deve exportar e entregar:
1. O arquivo contendo as queries SQL resolvidas (`respostas.sql`).
2. O dashboard exportado do Apache Superset (arquivo `.zip` contendo os datasets e o dashboard estruturado).
3. A apresentação de slides ou documento com a análise de negócios em formato PDF.
