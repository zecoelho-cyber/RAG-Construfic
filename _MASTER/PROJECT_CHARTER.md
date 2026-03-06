# PROJECT CHARTER — CONSTRUFIC
**Versão:** 1.0 | **Data:** 2026-03-04

---

## 1. IDENTIFICAÇÃO DO PROJETO
| Campo | Valor |
|---|---|
| **Projeto** | Transformação Digital & IA — Construfic |
| **Sponsor / CEO** | Antonio Figueiredo |
| **Mentor TI/IA** | Zé Coelho (ze@zecoelho.com.br) |
| **Gerente de Loja** | Diogo |
| **Início** | Março/2026 |
| **Modelo** | 36h/mês (24h base + 12h bônus) |

---

## 2. CONTEXTO
A Construfic é uma PME de materiais de construção localizada em Avaré/SP. Enfrenta desafios típicos do varejo de materiais: gestão de estoque complexa (10k+ SKUs), atendimento ao cliente lento, relatórios manuais e conhecimento técnico disperso.

---

## 3. OBJETIVO
Implementar uma arquitetura de IA em duas fases (POC + Produção) para resolver as principais dores operacionais, aumentar eficiência e preparar a empresa para crescimento digital.

---

## 4. ESCOPO — TRÊS PILARES

### Pilar 1: ChatBot IA (RAG)
- Atendimento 24/7 via WhatsApp
- Base de conhecimento com catálogo completo (10k+ SKUs)
- Respostas em < 3 segundos
- Integração com histórico de pedidos

### Pilar 2: Dashboard BI
- Visão de estoque em tempo real
- KPIs de vendas automatizados
- Alertas proativos de ruptura
- Eliminação de relatórios manuais em Excel

### Pilar 3: Data Lake
- Integração com ERP Santri
- Fonte única de verdade para dados
- Base para evolução futura da IA
- Histórico completo de pedidos e clientes

---

## 5. ROADMAP

| Fase | Período | Entregável |
|---|---|---|
| **MVP Rápido** | Semana 1 Mar/26 | Validação no-code com subset de dados (3-5 dias) |
| **Fase 0 — Discovery** | Mar/26 | Entrevistas, benchmarks, mapeamento de dados |
| **Fase 1 — POC** | Abr–Mai/26 | ChatBot piloto + Dashboard MVP |
| **GO/NO-GO #1** | Mai/26 | Avaliação de resultados e decisão de escalar |
| **Fase 2 — Produção** | Jun–Ago/26 | Deploy completo + Data Lake + treinamento |

---

## 6. KPIs DE SUCESSO
- Tempo de atendimento: **-60%**
- Ruptura de estoque: **-40%**
- Relatórios manuais eliminados: **-80%**
- Satisfação do cliente (NPS): **+30%**
- Consultas resolvidas pelo ChatBot: **+70%**
- Horas economizadas por mês: **+40h**

---

## 7. DECISÕES REGISTRADAS
| # | Decisão | Data | Status |
|---|---|---|---|
| 001 | Transcrição de áudio com OpenAI Whisper | 2026-03-03 | ✅ Aprovado |
| 002 | MVP rápido no-code antes da POC (NotebookLM/Cowork) | 2026-03-04 | ✅ Aprovado |

---

## 8. ASSINATURAS
| Papel | Nome | Data |
|---|---|---|
| Sponsor / CEO | Antonio Figueiredo | 2026-03-__ |
| Mentor TI/IA | Zé Coelho | 2026-03-04 |
