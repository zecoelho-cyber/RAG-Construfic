# DECISION LOG — CONSTRUFIC
> Registro de todas as decisões técnicas e estratégicas do projeto.

---

## COMO USAR
1. Toda decisão relevante deve ser registrada aqui
2. Use o próximo número sequencial
3. Preencha todos os campos
4. Status: 🟡 Em avaliação | ✅ Aprovado | ❌ Rejeitado | 🔄 Revisado

---

## DECISÃO #001
| Campo | Valor |
|---|---|
| **ID** | DEC-001 |
| **Data** | 2026-03-03 |
| **Tomado por** | Zé Coelho + Antonio Figueiredo |
| **Status** | ✅ Aprovado |

### Decisão
Usar **OpenAI Whisper** para transcrição automática de áudio de reuniões e ligações.

### Contexto
Reuniões e ligações não estavam sendo documentadas, causando perda de informações estratégicas e decisões sem registro.

### Alternativas Consideradas
1. Transcrição manual (descartado — lento e não escalável)
2. Google Speech-to-Text (descartado — custo maior, setup mais complexo)
3. **OpenAI Whisper** ✅ — custo ~$0,006/min, alta precisão, fácil integração

### Impacto Esperado
- Zero perda de informação estratégica
- Atas geradas em minutos, não horas
- Base de conhecimento viva do projeto

---

## DECISÃO #002
| Campo | Valor |
|---|---|
| **ID** | DEC-002 |
| **Data** | 2026-03-04 |
| **Tomado por** | Zé Coelho |
| **Status** | ✅ Aprovado |

### Decisão
Criar um **MVP rápido (3-5 dias)** usando ferramentas no-code (NotebookLM, Claude Cowork ou similar) com um subset pequeno de dados para validação imediata do conceito com o CEO.

### Contexto
Pesquisas junto ao time da I2AI (Instituto de Inteligência Artificial) indicaram que ferramentas no-code já permitem criar protótipos funcionais de assistentes conversacionais com RAG em dias. Isso permite que o CEO tenha uma visão objetiva e tangível da solução antes de qualquer investimento em infraestrutura técnica.

### Alternativas Consideradas
1. Ir direto para a POC técnica (descartado — demora 2-3 meses para o CEO ver resultados)
2. Apresentação apenas com slides (descartado — não permite experimentação real)
3. **MVP no-code com subset de dados** ✅ — custo zero, validação em dias, feedback imediato

### Impacto Esperado
- CEO experimenta a solução pessoalmente na Semana 1
- Decisão de investimento passa de abstrata para concreta
- Calibra prioridades e design da POC completa
- Reduz resistência à adoção pela equipe

---

## DECISÃO #003
| Campo | Valor |
|---|---|
| **ID** | DEC-003 |
| **Data** | — |
| **Tomado por** | — |
| **Status** | 🟡 Em avaliação |

*(Próxima decisão a registrar)*

---
*Última atualização: 2026-03-04 | Responsável: Zé Coelho*
