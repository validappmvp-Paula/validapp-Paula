-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Inglés
-- (Formación General), 3° Medio. Cubre los 16 objetivos de aprendizaje de 3°
-- Medio cargados por supabase/seed/0025_curriculum_ingles_regular_3_4medio.sql
-- (4 ejes: Comprensión Auditiva, Comprensión Lectora, Expresión Oral,
-- Expresión Escrita), con 4 preguntas por objetivo, total 64 preguntas en
-- este archivo.
--
-- ============================================================================
-- ESTADO EDITORIAL Y DE VALIDACIÓN
-- ============================================================================
-- Mismo patrón que el resto del banco: `review_status = 'borrador'`,
-- `validation_status = 'ai_generated_review_required'`, `is_active = true`,
-- `source_type = 'validapp_original'`, `generated_by = 'claude-sonnet-5'`.
-- Ninguna fila es usable todavía en un ensayo o diagnóstico real; requieren
-- revisión pedagógica humana (trigger `questions_prevent_ai_self_approval`
-- de la migración 0023 lo impide para cualquier agente).
--
-- ============================================================================
-- DECISIÓN SOBRE `subject.name` (ver incertidumbre documentada en 0025)
-- ============================================================================
-- supabase/seed/0025 documenta una incertidumbre residual explícita sobre si
-- la denominación oficial exacta del Decreto Supremo N.° 193/2019 para esta
-- banda es ''Inglés'' o ''Idioma Extranjero: Inglés''. La fila real de
-- `subjects` creada y usada por 0025 (y por 0023/0024 antes) es
-- ''Idioma Extranjero: Inglés'' -- este archivo reutiliza exactamente ese
-- mismo `subject.name` (verificado leyendo el SQL real de 0025, no asumido),
-- para no crear una segunda fila de `subjects` ni romper el vínculo con
-- `learning_objectives`. La incertidumbre sobre el nombre exacto en el
-- decreto se mantiene documentada en 0025 y no afecta la resolución de
-- objetivos aquí, que siempre se hace por (subject.name = ''Idioma
-- Extranjero: Inglés'', strand.name, level.code, learning_objective.short_name).
--
-- ============================================================================
-- CRITERIO DE IDIOMA (3°-4° Medio, nivel B1-B2, Formación General)
-- ============================================================================
-- Mismo criterio de fondo que 0113-0116 (proporción alta de inglés en
-- estímulos y preguntas de contenido, español para preguntas
-- ''meta''/metalingüísticas), llevado más lejos por el nivel B1-B2 de esta
-- banda: la mayoría de los estímulos son textos/diálogos auténticos más
-- largos y académicos (ensayos, entrevistas, artículos de divulgación), y
-- varias preguntas de contenido se formulan directamente en inglés incluso
-- cuando piden un juicio crítico, porque en B1-B2 se espera que el
-- estudiante pueda razonar en inglés sobre lo leído/escuchado, no solo
-- decodificarlo.
--
-- ============================================================================
-- FUENTE Y NIVEL DE CONFIANZA, VALIDACIÓN MECÁNICA E IDEMPOTENCIA
-- ============================================================================
-- Enunciados de redacción ORIGINAL de ValidApp, alineados al objetivo
-- correspondiente (ver supabase/seed/0025). `framework_id`/`source_id`
-- quedan NULL. `content_hash` queda NULL, pendiente de calcularse con
-- `computeContentHash` (`lib/data/question-validators.ts`). Revisión manual
-- contra las reglas de ese validador (sin alternativas duplicadas/vacías,
-- exactamente una respuesta correcta, sin ''todas/ninguna de las
-- anteriores''), rotación round-robin 0,1,2,3 de la posición correcta a lo
-- largo de las 64 preguntas, e idempotencia vía `where not exists` sobre
-- `learning_objective_id` + `prompt`, resuelto siempre por (subject.name,
-- strand.name, level.code, learning_objective.short_name).
--
-- Seed SOLO local: no se ha ejecutado contra Supabase.

-- ============================================================================
-- EJE: COMPRENSIÓN AUDITIVA — 3° MEDIO
-- ============================================================================

-- Objetivo: Comprensión de discursos orales auténticos de mayor complejidad
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen to this podcast excerpt: ''In this episode, we explore how urban planning decisions from decades ago still shape traffic patterns today.'' What is the main topic of this podcast excerpt?', '["How past urban planning still affects traffic today","A recipe for a traditional dish","A weather forecast for the week","A review of a new video game"]', 0, 'El podcast se enfoca en cómo las decisiones de planificación urbana pasadas siguen afectando el tráfico actual.', 'inicial', 25),
  ('Escuchas una entrevista auténtica: ''Bueno, honestamente, no esperaba que el proyecto tuviera tanto éxito, pero, eh, los resultados hablan por sí solos.'' ¿Qué característica de un discurso oral auténtico se observa en este fragmento?', '["Un discurso perfectamente escrito sin pausas","El uso de muletillas y pausas naturales del habla espontánea","La ausencia total de emociones","Un discurso completamente memorizado"]', 1, 'El fragmento muestra muletillas (''eh'', ''honestamente'') típicas del habla espontánea y auténtica.', 'intermedia', 30),
  ('Listen to this news report: ''Officials confirmed today that the new policy will take effect next month, following months of public consultation and several revisions to the original proposal.'' What complex information is being communicated?', '["A simple weather update","A policy taking effect after consultation and revisions","A sports score from last night","A recipe recommendation"]', 1, 'El reporte comunica información compleja sobre una política que entrará en vigencia tras consulta pública y revisiones.', 'intermedia', 30),
  ('Listen to this authentic radio interview: ''Interviewer: So, would you say the project failed? Guest: Well, not exactly— I mean, some parts didn''t go as planned, but overall, I''d call it a partial success, if that makes sense.'' What makes this excerpt an example of authentic, more complex oral discourse?', '["Es un discurso perfectamente estructurado sin ninguna vacilación","Incluye vacilaciones, autocorrecciones y matices típicos del habla espontánea real","No tiene ninguna relación con una entrevista real","Es un texto completamente escrito y leído en voz alta"]', 1, 'El fragmento incluye vacilaciones (''well, not exactly'', ''I mean'') y matices típicos del habla espontánea auténtica, más compleja que un discurso guionado.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_3_medio' and lo.short_name = 'Comprensión de discursos orales auténticos de mayor complejidad'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de matices de significado en un discurso oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''Sure, that''s a great idea.'' (said with a flat, unenthusiastic tone) What nuance might this tone suggest, despite the words used?', '["Genuine enthusiasm about the idea","Possible sarcasm or lack of real enthusiasm","Complete indifference with no emotion","Total agreement without any doubt"]', 1, 'Un tono plano y poco entusiasta al decir ''great idea'' puede sugerir sarcasmo o falta de entusiasmo real.', 'inicial', 25),
  ('Escuchas: ''No es que esté en desacuerdo del todo, pero tengo mis dudas.'' ¿Qué matiz de significado transmite esta frase?', '["Un acuerdo total y sin dudas","Un desacuerdo parcial o dudas, sin rechazo completo","Un rechazo absoluto de la idea","Indiferencia completa"]', 1, 'La frase transmite un matiz de desacuerdo parcial o dudas, sin llegar a un rechazo completo.', 'intermedia', 30),
  ('Listen: ''I suppose it could work, in theory.'' What nuance does the phrase ''in theory'' add to this statement?', '["Complete certainty that it will work","A suggestion of doubt about whether it will work in practice","Total rejection of the idea","Enthusiastic support without reservations"]', 1, '''In theory'' añade un matiz de duda sobre si funcionará realmente en la práctica.', 'intermedia', 30),
  ('Listen: ''It''s not that the plan is bad, exactly, but I do wonder if we''ve fully considered the long-term risks.'' What nuanced meaning does this statement convey, beyond its literal words?', '["Una crítica abierta y directa de que el plan es completamente malo","Una aceptación total del plan sin ninguna duda","Una preocupación matizada sobre los riesgos a largo plazo, sin rechazar completamente el plan","Una indiferencia total hacia el plan"]', 2, 'La frase transmite una preocupación matizada sobre los riesgos a largo plazo, sin rechazar completamente el plan, un matiz más sutil que una crítica abierta.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_3_medio' and lo.short_name = 'Identificación de matices de significado en un discurso oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Síntesis de la información relevante de un texto oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''The talk covered the history of the internet, its technical infrastructure, and its social effects, but the speaker mainly emphasized how it has changed communication between people.'' If you had to summarize this talk in one sentence, what would be the most relevant focus?', '["The internet has mainly changed communication between people","The talk was only about technical infrastructure","The talk had no clear focus at all","The talk was about the history of computers only"]', 0, 'Aunque se mencionan varios temas, el enfoque principal enfatizado por el hablante es el cambio en la comunicación.', 'inicial', 25),
  ('Al sintetizar un audio largo con mucha información, ¿qué estrategia es más recomendable?', '["Anotar cada palabra exacta del audio","Identificar y resumir solo las ideas más relevantes","Ignorar completamente el audio","Memorizar el audio palabra por palabra"]', 1, 'Identificar y resumir las ideas más relevantes es la estrategia recomendable para sintetizar un audio largo.', 'intermedia', 30),
  ('Listen: ''The documentary discussed climate change causes, effects on agriculture, effects on sea levels, potential solutions, and international cooperation efforts, spending most of its time on possible solutions.'' What would be the most accurate one-sentence synthesis of this documentary?', '["El documental se enfoca principalmente en las causas del cambio climático","El documental trata varios aspectos del cambio climático, con énfasis en posibles soluciones","El documental solo habla sobre agricultura","El documental no menciona ninguna solución"]', 1, 'Aunque toca varios aspectos, el documental dedica más tiempo a las posibles soluciones, lo que debe reflejarse en la síntesis.', 'intermedia', 30),
  ('Listen to this lecture summary: ''While the lecture touched on economic history, political changes, and cultural shifts of the 20th century, the professor''s central argument was that technological innovation was the primary driver behind all these changes.'' When synthesizing this lecture, what is the most accurate way to represent its core argument?', '["Resumir por igual los tres temas mencionados sin ninguna jerarquía","Sintetizar que la innovación tecnológica fue el motor principal detrás de los otros cambios mencionados","Ignorar el argumento central y centrarse solo en los cambios culturales","Decir que el profesor no tuvo ningún argumento central"]', 1, 'Una síntesis precisa debe reflejar el argumento central señalado explícitamente por el profesor: que la innovación tecnológica fue el motor principal.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_3_medio' and lo.short_name = 'Síntesis de la información relevante de un texto oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Evaluación crítica de un mensaje oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''This product will completely change your life and solve all your problems instantly!'' What critical observation would be appropriate about this message?', '["It uses exaggerated claims that may not be realistic","It provides solid scientific evidence","It is a balanced and objective message","It comes from a peer-reviewed source"]', 0, 'El mensaje usa afirmaciones exageradas (''solve all your problems instantly'') que probablemente no sean realistas, lo que merece una observación crítica.', 'inicial', 25),
  ('Escuchas un mensaje que afirma ''todos los expertos están de acuerdo'' sin mencionar ninguna fuente específica. ¿Qué evaluación crítica es pertinente?', '["Aceptar la afirmación sin cuestionarla, ya que menciona expertos","Cuestionar la falta de fuentes específicas que respalden la afirmación","Asumir que la afirmación es completamente falsa sin evidencia","Ignorar el mensaje sin ningún análisis"]', 1, 'Es pertinente cuestionar la falta de fuentes específicas que respalden una afirmación tan amplia.', 'intermedia', 30),
  ('Listen: ''Recent data suggests a possible link, though more research is needed before drawing firm conclusions.'' How would you critically evaluate this message compared to one that makes absolute claims without evidence?', '["Es menos confiable porque admite incertidumbre","Es más confiable porque reconoce los límites de la evidencia disponible, en vez de exagerar certeza","Ambos mensajes son igual de confiables","No es posible evaluar la confiabilidad de ningún mensaje oral"]', 1, 'Reconocer los límites de la evidencia disponible es un indicador de mayor confiabilidad, a diferencia de afirmaciones absolutas sin respaldo.', 'intermedia', 30),
  ('Listen critically: ''Studies prove beyond any doubt that this method works for everyone, in every situation, without exception.'' Considering how scientific claims are typically presented, what critical concern should this message raise?', '["Ninguna preocupación, ya que menciona estudios científicos","La certeza absoluta y la ausencia de excepciones son inusuales en afirmaciones científicas legítimas, lo que sugiere posible exageración","El mensaje es completamente confiable sin ninguna duda","Los estudios científicos siempre afirman certeza absoluta"]', 1, 'Las afirmaciones científicas legítimas rara vez son absolutas (''en todos los casos, sin excepción''), por lo que este lenguaje sugiere posible exageración o falta de rigor.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_3_medio' and lo.short_name = 'Evaluación crítica de un mensaje oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMPRENSIÓN LECTORA — 3° MEDIO
-- ============================================================================

-- Objetivo: Comprensión de textos académicos o de divulgación
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Comprensión Lectora. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''This article explains how neural networks, inspired by the structure of the human brain, are used to process large amounts of data and identify patterns.'' What is the main purpose of this text?', '["To explain how neural networks work and their purpose","To narrate a personal experience with technology","To advertise a specific software product","To criticize the use of technology"]', 0, 'El texto explica cómo funcionan las redes neuronales y su propósito, un texto de divulgación científica.', 'inicial', 25),
  ('Texto: ''La investigación reciente sobre el microbioma intestinal sugiere que las bacterias presentes en el intestino podrían influir en el estado de ánimo.'' ¿Qué tipo de texto es este?', '["Una receta de cocina","Un texto de divulgación científica","Un poema","Una carta personal"]', 1, 'El texto presenta hallazgos de investigación de forma accesible, característico de un texto de divulgación científica.', 'intermedia', 30),
  ('Text: ''While quantum computing remains largely experimental, researchers argue it could eventually solve problems that are currently impossible for classical computers to handle efficiently.'' What is the communicative purpose of this academic text?', '["To inform about the potential and current status of quantum computing","To sell a quantum computer","To tell a fictional story about computers","To give personal cooking advice"]', 0, 'El texto informa sobre el potencial y estado actual de la computación cuántica, un propósito informativo/académico.', 'intermedia', 30),
  ('Text: ''Although the initial hypothesis proposed a direct causal relationship, subsequent controlled studies revealed a more complex interplay of variables, suggesting that correlation alone cannot fully explain the observed phenomenon.'' What academic distinction does this text make, and why is it significant?', '["Que la hipótesis inicial fue completamente correcta sin matices","Que la correlación y la causalidad son exactamente lo mismo","Distingue entre una relación causal simple (hipótesis inicial) y una interacción más compleja de variables revelada por estudios posteriores, mostrando los límites de la correlación","Que no existe ninguna relación entre las variables mencionadas"]', 2, 'El texto distingue entre una relación causal simple inicial y una interacción más compleja revelada posteriormente, un matiz académico importante sobre los límites de la correlación.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_3_medio' and lo.short_name = 'Comprensión de textos académicos o de divulgación'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Análisis crítico de la argumentación de un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Comprensión Lectora. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Everyone knows that traditional methods are always better than new approaches.'' What is a critical weakness of this argument?', '["It relies on a vague generalization (''everyone knows'') without evidence","It provides strong statistical evidence","It considers multiple perspectives fairly","It cites a specific, reliable study"]', 0, 'El argumento se apoya en una generalización vaga (''everyone knows'') sin evidencia que la respalde, una debilidad crítica.', 'inicial', 25),
  ('Texto: ''Dado que solo tres personas se quejaron del producto, se puede concluir que a nadie le gusta.'' ¿Qué debilidad argumentativa presenta este texto?', '["Presenta evidencia sólida y representativa","Generaliza una conclusión amplia a partir de una muestra muy pequeña y no representativa","No presenta ninguna conclusión","Es un argumento completamente válido y bien fundamentado"]', 1, 'El texto generaliza una conclusión amplia a partir de una muestra muy pequeña, una falacia de generalización apresurada.', 'intermedia', 30),
  ('Text: ''Because this policy was implemented and crime rates dropped the same year, the policy must be the cause of the drop.'' What logical weakness does this argument show?', '["It correctly proves causation with strong evidence","It assumes causation from correlation without ruling out other factors","It uses no evidence at all","It considers all possible causes carefully"]', 1, 'El argumento asume causalidad a partir de una correlación temporal, sin descartar otros factores posibles, una falacia común.', 'intermedia', 30),
  ('Text: ''Critics claim this economic policy failed because unemployment rose slightly after its implementation. However, they ignore that a global recession occurred at the same time, which likely explains most of the increase, independent of the policy itself.'' What critical analysis does this text offer regarding the original argument?', '["Acepta sin cuestionar que la política fue la única causa del aumento del desempleo","Señala que el argumento original ignora un factor externo relevante (la recesión global) que podría explicar el aumento, cuestionando la atribución causal simple","Rechaza completamente cualquier posible causa del aumento del desempleo","No ofrece ningún análisis crítico, solo repite la crítica original"]', 1, 'El texto ofrece un análisis crítico al señalar que el argumento original ignora un factor externo relevante, cuestionando una atribución causal simplista.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_3_medio' and lo.short_name = 'Análisis crítico de la argumentación de un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Interpretación de recursos retóricos en un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Comprensión Lectora. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Time is money.'' What rhetorical device is used in this expression?', '["A metaphor comparing time to money","A simile using ''like'' or ''as''","A direct factual statement with no figurative meaning","An exaggeration with no comparison"]', 0, '''Time is money'' es una metáfora que compara el tiempo con el dinero, sin usar ''like'' o ''as''.', 'inicial', 25),
  ('Texto: ''Sus palabras cayeron como gotas de lluvia sobre tierra seca.'' ¿Qué recurso retórico se utiliza en esta frase?', '["Una metáfora sin comparación explícita","Un símil, al usar ''como'' para comparar dos elementos","Una pregunta retórica","Una hipérbole exagerada sin comparación"]', 1, 'La frase usa ''como'' para comparar dos elementos, lo que corresponde a un símil.', 'intermedia', 30),
  ('Text: ''I''ve told you a million times to be careful!'' What rhetorical device is used in this sentence?', '["A literal, factual statement","Hyperbole, an exaggeration for emphasis","A metaphor comparing two unrelated things","A rhetorical question"]', 1, '''A million times'' es una hipérbole, una exageración usada para dar énfasis, no un dato literal.', 'intermedia', 30),
  ('Text: ''Is it really too much to ask for a little honesty in our leaders?'' What rhetorical device is used here, and what effect does it likely have on the reader?', '["Una metáfora que compara la honestidad con un objeto físico","Una pregunta retórica que invita al lector a reflexionar y probablemente a estar de acuerdo con el punto implícito","Una hipérbole que exagera la cantidad de honestidad pedida","Un símil que compara la honestidad con otro concepto usando ''como''"]', 1, 'Esta es una pregunta retórica que invita al lector a reflexionar, generalmente llevándolo a estar de acuerdo con el punto implícito del autor.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_3_medio' and lo.short_name = 'Interpretación de recursos retóricos en un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Investigación y contraste de fuentes en inglés
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Comprensión Lectora. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('When researching a topic in English, why is it important to use more than one source?', '["To compare information and identify possible biases or gaps","Because one source is always completely wrong","Because using multiple sources is required by law","Because it makes the research process longer for no reason"]', 0, 'Usar más de una fuente permite comparar información e identificar posibles sesgos o vacíos.', 'inicial', 25),
  ('Al contrastar dos fuentes en inglés sobre el mismo tema y encontrar información contradictoria, ¿qué acción es más adecuada?', '["Elegir una fuente al azar sin analizar más","Investigar la credibilidad de cada fuente antes de decidir cuál es más confiable","Ignorar ambas fuentes completamente","Combinar ambas sin ningún análisis crítico"]', 1, 'Investigar la credibilidad de cada fuente antes de decidir es la acción más adecuada ante información contradictoria.', 'intermedia', 30),
  ('Text A (academic journal): ''Data indicates a 10% increase.'' Text B (unverified blog): ''Some people say it increased a lot.'' When contrasting these two English sources, which is more reliable, and why?', '["Text B, because it is more emotional","Text A, because it comes from an academic journal with specific data, unlike Text B''s vague, unverified claim","Both are equally reliable","Neither source can be evaluated for reliability"]', 1, 'El texto A proviene de una fuente académica con datos específicos, mientras que el texto B es vago y no verificado, por lo que el texto A es más confiable.', 'intermedia', 30),
  ('While researching a topic in English, you find three sources: a peer-reviewed study, a government report, and an anonymous forum post, all discussing the same claim but with different conclusions. How should you approach contrasting these sources in your research?', '["Usar únicamente la publicación anónima porque es la más reciente","Ignorar las tres fuentes porque no coinciden","Dar el mismo peso y credibilidad a las tres fuentes por igual","Priorizar la evidencia del estudio revisado por pares y el informe oficial, evaluando críticamente por qué la fuente anónima difiere"]', 3, 'Es adecuado priorizar fuentes con mayor rigor (estudio revisado por pares, informe oficial) y evaluar críticamente por qué la fuente anónima podría diferir.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_3_medio' and lo.short_name = 'Investigación y contraste de fuentes en inglés'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ORAL — 3° MEDIO
-- ============================================================================

-- Objetivo: Presentación oral formal con apoyo de recursos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Expresión Oral. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración es adecuada para introducir una presentación oral formal con apoyo visual?', '["Today, supported by the data on this slide, I will explain the impact of urban migration.","Migration, yes, slides, whatever.","I don''t know what this slide shows.","Slides are nice, I guess."]', 0, 'Esta oración presenta el tema formalmente y hace referencia explícita al recurso visual de apoyo.', 'inicial', 25),
  ('Al usar una diapositiva con un gráfico durante una presentación formal, ¿qué es recomendable hacer?', '["Ignorar completamente el gráfico durante la presentación","Explicar oralmente lo que muestra el gráfico y su relevancia para el tema","Leer únicamente los números sin ninguna explicación","Ocultar el gráfico de la audiencia"]', 1, 'Es recomendable explicar oralmente lo que muestra el gráfico y su relevancia, integrando el recurso visual con el discurso oral.', 'intermedia', 30),
  ('¿Cuál oración es adecuada para cerrar una presentación oral formal que usó recursos visuales?', '["That''s it, whatever, thanks I guess.","In conclusion, as shown in the data presented, urban migration requires coordinated policy responses.","Slides, migration, the end, bye.","I forgot to explain the slides, sorry."]', 1, 'Esta oración cierra la presentación formal resumiendo la conclusión con referencia a los datos presentados.', 'intermedia', 30),
  ('Debes preparar una presentación oral formal sobre el cambio climático, usando un gráfico como apoyo, con introducción, desarrollo (explicando el gráfico) y cierre. ¿Cuál secuencia cumple mejor esta estructura?', '["Climate change is bad. Look at this graph. The end.","Today, I will present data on rising global temperatures, shown in this graph. As you can see, temperatures have risen steadily since 1950. In conclusion, this trend demands urgent global action.","Graph, temperatures, bad, whatever, conclusion.","I don''t want to explain the graph today."]', 1, 'Esta secuencia presenta una introducción, un desarrollo que integra y explica el gráfico, y una conclusión coherente, cumpliendo la estructura formal esperada.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_3_medio' and lo.short_name = 'Presentación oral formal con apoyo de recursos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Argumentación oral con evidencia y contraargumentos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Expresión Oral. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración presenta correctamente un argumento con evidencia?', '["According to a recent study, remote work increases productivity by 13% on average.","Remote work is nice, I guess, whatever.","I don''t know if remote work is good.","Remote work, work, home, maybe."]', 0, 'Esta oración presenta un argumento respaldado con evidencia concreta (un estudio con un porcentaje).', 'inicial', 25),
  ('¿Cuál oración reconoce adecuadamente un contraargumento antes de responderlo?', '["I completely ignore any opposing view.","Some may argue that remote work reduces team cohesion; however, virtual team-building strategies can effectively address this concern.","Nobody could possibly disagree with this.","This is obviously true, no counterargument exists."]', 1, 'Esta oración reconoce un contraargumento válido y luego lo responde, una estrategia argumentativa sólida.', 'intermedia', 30),
  ('Al argumentar oralmente con evidencia, ¿por qué es importante también considerar contraargumentos?', '["Porque hace la argumentación más débil","Porque demuestra un análisis más equilibrado y fortalece la credibilidad del argumento","Porque es obligatorio por reglas gramaticales","Porque elimina la necesidad de usar evidencia"]', 1, 'Considerar contraargumentos demuestra un análisis equilibrado y fortalece la credibilidad de la argumentación.', 'intermedia', 30),
  ('Debes argumentar oralmente sobre la obligatoriedad de la educación cívica en el colegio, incluyendo evidencia, un contraargumento reconocido y una respuesta a este. ¿Cuál opción cumple mejor con estos tres elementos?', '["Civic education is good. The end.","Studies show that civic education increases youth participation in elections by 18%. Critics argue it takes time from other subjects; however, this investment appears to yield long-term benefits for democratic participation.","Civic education, school, good, whatever.","I don''t have any opinion about civic education."]', 1, 'Esta opción incluye evidencia, un contraargumento reconocido y una respuesta argumentada, cumpliendo con una argumentación oral completa.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_3_medio' and lo.short_name = 'Argumentación oral con evidencia y contraargumentos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Participación en discusiones académicas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Expresión Oral. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una discusión académica, ¿cuál expresión es adecuada para presentar una idea de forma rigurosa?', '["Based on the evidence presented in the study, I would argue that...","I just feel like this is true, whatever.","This is obviously correct, no need to explain.","I don''t really care about this discussion."]', 0, 'Esta expresión presenta una idea de forma rigurosa, basada en evidencia, adecuada para una discusión académica.', 'inicial', 25),
  ('¿Cuál expresión es adecuada para cuestionar respetuosamente un argumento en una discusión académica?', '["That''s a ridiculous point, you''re wrong.","Could you clarify how this evidence supports that specific conclusion?","I don''t want to hear your argument.","Whatever you say, I don''t care."]', 1, 'Esta expresión cuestiona respetuosamente un argumento, pidiendo clarificación sobre la evidencia presentada.', 'intermedia', 30),
  ('En una discusión académica sobre un tema controvertido, ¿qué actitud es más apropiada al participar?', '["Imponer tu opinión sin considerar evidencia","Mantener una actitud abierta, basada en evidencia y respetuosa con otras posturas","Ignorar completamente a los demás participantes","Rechazar cualquier evidencia que contradiga tu postura inicial"]', 1, 'Mantener una actitud abierta, basada en evidencia y respetuosa es lo apropiado en una discusión académica.', 'intermedia', 30),
  ('En una discusión académica, un compañero presenta una conclusión que no está completamente respaldada por los datos que citó. ¿Cuál intervención es la más apropiada?', '["Ignorar por completo el problema en su argumento","Decir que su argumento es completamente inválido sin explicar por qué","Señalar respetuosamente que los datos citados no parecen respaldar completamente esa conclusión específica, y preguntar si hay evidencia adicional","Aceptar la conclusión sin ningún cuestionamiento"]', 2, 'Señalar respetuosamente la brecha entre los datos y la conclusión, e invitar a aportar más evidencia, es la intervención más apropiada en una discusión académica rigurosa.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_3_medio' and lo.short_name = 'Participación en discusiones académicas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Evaluación de la propia producción oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Expresión Oral. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al evaluar tu propia producción oral después de una presentación, ¿qué criterio es relevante considerar?', '["La claridad y organización de las ideas presentadas","El color de la ropa que usaste","La cantidad de personas presentes en la sala","La hora exacta en que comenzó la presentación"]', 0, 'La claridad y organización de las ideas es un criterio relevante para evaluar la propia producción oral.', 'inicial', 25),
  ('Después de escuchar la grabación de tu propia presentación, notas que usaste muchas muletillas (''um'', ''like''). ¿Qué acción de mejora corresponde aplicar?', '["Ignorar completamente esta observación","Practicar reduciendo el uso de muletillas en futuras presentaciones","Aumentar el uso de muletillas para sonar más natural","Dejar de dar presentaciones orales por completo"]', 1, 'Practicar la reducción de muletillas es una acción de mejora adecuada tras identificar este patrón.', 'intermedia', 30),
  ('Al autoevaluar tu argumentación oral, notas que presentaste evidencia sólida pero no consideraste ningún contraargumento. ¿Qué mejora deberías aplicar la próxima vez?', '["Eliminar toda la evidencia presentada","Incluir y responder al menos un contraargumento relevante en la próxima presentación","No cambiar nada, ya que la evidencia fue suficiente","Evitar completamente presentar argumentos en el futuro"]', 1, 'Incluir y responder contraargumentos es la mejora pertinente identificada mediante la autoevaluación.', 'intermedia', 30),
  ('Debes autoevaluar tu presentación oral usando tres criterios: claridad, uso de evidencia y manejo del tiempo. Identificas que fuiste claro y usaste evidencia sólida, pero excediste el tiempo asignado en un 50%. ¿Qué acción de mejora es más pertinente para tu próxima presentación?', '["No cambiar nada, ya que dos de tres criterios se cumplieron bien","Practicar y ensayar la presentación con anticipación para ajustarla al tiempo asignado","Eliminar toda la evidencia presentada para simplificar","Dejar de usar evidencia en presentaciones futuras"]', 1, 'Dado que el problema identificado es el manejo del tiempo, la mejora pertinente es practicar y ensayar para ajustar la duración.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_3_medio' and lo.short_name = 'Evaluación de la propia producción oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ESCRITA — 3° MEDIO
-- ============================================================================

-- Objetivo: Redacción de un ensayo con tesis y argumentos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Expresión Escrita. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración presenta correctamente una tesis clara para un ensayo?', '["Governments should prioritize investment in renewable energy to reduce long-term environmental and economic risks.","Energy is a topic. Governments exist. Risks exist too.","I don''t know about renewable energy policy.","Renewable, energy, government, maybe."]', 0, 'Esta oración presenta una tesis clara con una justificación, adecuada para un ensayo.', 'inicial', 25),
  ('¿Cuál oración funciona como un argumento de apoyo adecuado, con evidencia, para la tesis ''Bilingual education benefits cognitive development''?', '["Bilingual education is a phrase with two words.","Research shows that bilingual individuals often perform better on tasks requiring cognitive flexibility.","Some people don''t like learning two languages.","Bilingual, cognitive, development, word."]', 1, 'Esta oración presenta evidencia (investigación) que respalda la tesis sobre la educación bilingüe.', 'intermedia', 30),
  ('¿Cuál oración es adecuada para el párrafo de conclusión de un ensayo sobre la importancia de la privacidad digital?', '["In conclusion, protecting digital privacy should be a fundamental priority in an increasingly connected world.","Privacy, the end, goodbye forever.","I don''t want to talk about privacy anymore.","Privacy is a word with seven letters."]', 0, 'Esta oración resume la postura y cierra el ensayo con una conclusión coherente con la tesis planteada.', 'intermedia', 30),
  ('Debes redactar un ensayo completo (tesis, al menos dos argumentos con evidencia, y conclusión) sobre la importancia de la educación financiera. ¿Cuál secuencia cumple mejor esta estructura?', '["Financial education is good. I like it. The end.","Financial education should be mandatory in schools. First, studies show that financially literate adults save more effectively. Second, it reduces the likelihood of problematic debt. In conclusion, schools must prioritize this subject.","Financial education, schools, good, whatever.","I don''t know if financial education matters."]', 1, 'Esta secuencia presenta una tesis clara, dos argumentos con evidencia y una conclusión coherente, cumpliendo la estructura esperada de un ensayo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_3_medio' and lo.short_name = 'Redacción de un ensayo con tesis y argumentos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de un registro académico en la escritura
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Expresión Escrita. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración usa un registro académico adecuado?', '["The data suggests a significant correlation between the two variables under study.","The data is like, super connected, you know?","Data, stuff, connection, whatever.","I dunno, the numbers seem kinda related."]', 0, 'Esta oración usa vocabulario preciso y estructura formal, propia de un registro académico.', 'inicial', 25),
  ('¿Cuál oración debería reemplazarse por un registro más académico en un ensayo formal?', '["The researchers concluded that further studies are necessary.","This study is, like, super important, you know?","The findings indicate a need for additional research.","The data supports this conclusion consistently."]', 1, 'Esta oración usa un registro coloquial (''like'', ''you know'') que debería reemplazarse por un registro más académico.', 'intermedia', 30),
  ('¿Cuál es una característica típica del registro académico en la escritura?', '["Uso frecuente de abreviaciones informales y emojis","Uso de vocabulario preciso, oraciones completas y tono objetivo","Uso exclusivo de oraciones muy cortas sin conectores","Ausencia total de evidencia o datos"]', 1, 'El registro académico se caracteriza por vocabulario preciso, oraciones completas y un tono objetivo.', 'intermedia', 30),
  ('Debes reescribir la siguiente oración informal en un registro académico adecuado: ''This study is super cool because it shows that people who exercise feel way happier.'' ¿Cuál versión logra esto mejor?', '["This study is super cool because people who exercise feel way happier.","This study demonstrates that individuals who engage in regular physical exercise report significantly higher levels of wellbeing.","This study, exercise, happy, whatever, cool.","I dunno, but exercise makes people happy I guess."]', 1, 'Esta versión reemplaza el vocabulario coloquial (''super cool'', ''way happier'') por vocabulario académico preciso, manteniendo el significado original.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_3_medio' and lo.short_name = 'Uso de un registro académico en la escritura'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Investigación y citación de fuentes en un texto propio
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Expresión Escrita. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al incorporar información de una fuente externa en tu propio texto, ¿qué acción es necesaria?', '["Citar adecuadamente la fuente de la que proviene la información","Presentar la información como si fuera propia, sin citarla","Ignorar de dónde proviene la información","Inventar una fuente si no recuerdas la original"]', 0, 'Citar adecuadamente la fuente es una acción necesaria al incorporar información externa en un texto propio.', 'inicial', 25),
  ('¿Cuál oración cita correctamente una fuente dentro de un texto académico?', '["Studies show many things about this topic.","According to Smith (2020), regular exercise improves cognitive function in adults.","Someone said something about exercise once.","Exercise is good, everyone agrees, probably."]', 1, 'Esta oración cita adecuadamente una fuente específica (Smith, 2020) para respaldar la afirmación.', 'intermedia', 30),
  ('Si usas las palabras exactas de un autor en tu ensayo sin citarlo ni encerrarlas entre comillas, ¿qué problema académico se comete?', '["Ningún problema, es una práctica normal","Plagio, ya que se presenta el texto de otro autor como propio","Un uso correcto y adecuado de fuentes","Una forma válida de parafrasear"]', 1, 'Usar las palabras exactas de otro autor sin citarlas ni encerrarlas entre comillas constituye plagio.', 'intermedia', 30),
  ('Debes investigar un tema usando dos fuentes académicas distintas e incorporarlas correctamente citadas en un mismo párrafo de tu ensayo. ¿Cuál opción logra esto de forma más adecuada?', '["Exercise is good for you, and so is sleep, everyone knows that.","According to Johnson (2019), regular exercise improves mental health, while Lee (2021) found similar benefits associated with adequate sleep.","Some people said exercise and sleep are both good, I think.","Exercise and sleep, good, whatever, sources exist somewhere."]', 1, 'Esta opción incorpora correctamente dos fuentes distintas, citadas específicamente, dentro del mismo párrafo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_3_medio' and lo.short_name = 'Investigación y citación de fuentes en un texto propio'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Revisión recursiva de un texto con foco en la voz propia
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 3° Medio, eje Expresión Escrita. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa ''revisión recursiva'' de un texto propio?', '["Revisar el texto una sola vez y no volver a él","Revisar el texto varias veces, en distintas etapas, mejorándolo progresivamente","Eliminar el texto completo sin revisión","Pedir que otra persona escriba el texto en tu lugar"]', 1, 'La revisión recursiva implica revisar el texto varias veces en distintas etapas, mejorándolo progresivamente.', 'inicial', 25),
  ('Al revisar recursivamente un ensayo con foco en la voz propia, ¿qué deberías verificar?', '["Que el texto suene como una copia exacta de otro autor","Que el texto refleje tu perspectiva y estilo personal de forma auténtica","Que el texto no tenga ninguna opinión personal","Que el texto elimine completamente cualquier argumento propio"]', 1, 'La revisión con foco en la voz propia busca verificar que el texto refleje la perspectiva y estilo personal del autor de forma auténtica.', 'intermedia', 30),
  ('Un estudiante revisa su ensayo por segunda vez y nota que varias oraciones suenan genéricas y podrían haber sido escritas por cualquier persona, sin reflejar su perspectiva personal. ¿Qué acción de revisión recursiva corresponde aplicar?', '["Dejar el texto exactamente igual, ya que está gramaticalmente correcto","Reescribir esas oraciones para incorporar una perspectiva y voz más personal y específica","Eliminar todo el ensayo y no continuar","Copiar oraciones de otro texto para reemplazarlas"]', 1, 'Corresponde reescribir esas oraciones genéricas para incorporar una perspectiva y voz más personal, un objetivo central de la revisión recursiva con foco en la voz propia.', 'intermedia', 30),
  ('Debes aplicar un proceso de revisión recursiva a tu ensayo en al menos dos etapas: una enfocada en la estructura y argumentos, y otra enfocada en la voz propia y el estilo personal. Si en la primera revisión ya corregiste la estructura, pero notas que el texto aún suena impersonal, ¿qué corresponde hacer en la segunda etapa?', '["No hacer nada más, ya que la estructura está corregida","Revisar nuevamente el texto enfocándote específicamente en incorporar tu voz y estilo personal","Eliminar completamente los argumentos ya corregidos","Pedir a otra persona que reescriba todo el ensayo"]', 1, 'La segunda etapa de la revisión recursiva debe enfocarse específicamente en incorporar la voz y el estilo personal, complementando la revisión estructural ya realizada.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_3_medio' and lo.short_name = 'Revisión recursiva de un texto con foco en la voz propia'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
