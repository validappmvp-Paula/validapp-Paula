-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Inglés
-- (Formación General), 4° Medio. Cubre los 16 objetivos de aprendizaje de 4°
-- Medio cargados por supabase/seed/0025_curriculum_ingles_regular_3_4medio.sql
-- (4 ejes: Comprensión Auditiva, Comprensión Lectora, Expresión Oral,
-- Expresión Escrita), con 4 preguntas por objetivo, total 64 preguntas en
-- este archivo. Cierra el banco de Inglés Currículum Regular (5° Básico a 4°
-- Medio; no cubre 1°-4° Básico, ver decisión documentada en 0023).
--
-- Mismo estado editorial, decisión sobre `subject.name` (reutiliza ''Idioma
-- Extranjero: Inglés'', ver encabezado completo de 0117), criterio de
-- idioma (nivel B2, cierre de la Enseñanza Media: estímulos y preguntas de
-- contenido mayoritariamente en inglés, incluyendo juicio crítico en
-- inglés; español reservado para preguntas ''meta''/metalingüísticas),
-- fuente, validación mecánica e idempotencia que 0111-0117. `source` cita
-- Decreto Supremo N.° 193/2019. Seed SOLO local: no se ha ejecutado contra
-- Supabase.

-- ============================================================================
-- EJE: COMPRENSIÓN AUDITIVA — 4° MEDIO
-- ============================================================================

-- Objetivo: Comprensión de discursos orales complejos sobre temas diversos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''The intersection of artificial intelligence and ethics raises complex questions about accountability when autonomous systems make consequential decisions.'' What complex topic is being discussed?', '["The ethical and accountability questions raised by AI decision-making","A simple recipe for cooking","A description of a sports match","A weather forecast for the weekend"]', 0, 'El discurso aborda las complejas preguntas éticas y de responsabilidad relacionadas con la IA.', 'inicial', 25),
  ('Escuchas un discurso sobre la interseccionalidad de género, raza y clase social en el acceso a la educación superior. ¿Qué tipo de tema complejo se aborda?', '["Un tema puramente recreativo","Un tema social complejo relacionado con desigualdades interseccionales","Un tema exclusivamente deportivo","Un tema de entretenimiento sin relevancia social"]', 1, 'El discurso aborda un tema social complejo sobre desigualdades interseccionales en el acceso educativo.', 'intermedia', 30),
  ('Listen: ''Balancing economic growth with environmental sustainability requires navigating trade-offs that don''t have simple, universally agreed-upon solutions.'' What complexity does this discourse acknowledge?', '["That there is one simple solution accepted by everyone","That balancing growth and sustainability involves difficult trade-offs without easy consensus","That economic growth has no relationship with the environment","That environmental sustainability is not a real concern"]', 1, 'El discurso reconoce la complejidad de equilibrar crecimiento y sostenibilidad, sin soluciones simples ni consenso universal.', 'intermedia', 30),
  ('Listen to this complex discourse: ''While globalization has lifted millions out of poverty, it has simultaneously deepened inequality within many nations, creating a paradox that defies simple ideological narratives from either free-market advocates or their critics.'' What paradox does this discourse present, and why is it considered complex?', '["Que la globalización solo ha traído beneficios, sin ninguna consecuencia negativa","Que la globalización ha reducido la pobreza global mientras profundiza la desigualdad interna, un fenómeno que no encaja en narrativas ideológicas simples","Que la globalización no tiene ninguna relación con la pobreza o la desigualdad","Que la globalización ha sido completamente negativa según todos los expertos"]', 1, 'El discurso presenta un fenómeno paradójico (reducción de pobreza global vs. profundización de desigualdad interna) que no encaja en narrativas ideológicas simplistas, reflejando alta complejidad.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_4_medio' and lo.short_name = 'Comprensión de discursos orales complejos sobre temas diversos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Análisis crítico de la intención comunicativa de un discurso oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''Vote for change, vote for a better future for your children.'' What is the primary communicative intention of this discourse?', '["To persuade the audience to vote for a specific option","To give a neutral, purely informative report","To tell an unrelated personal anecdote","To provide a scientific explanation"]', 0, 'El discurso busca persuadir a la audiencia para que vote por una opción específica, apelando a las emociones sobre el futuro de los hijos.', 'inicial', 25),
  ('Escuchas un discurso publicitario: ''Este producto cambiará tu vida para siempre, no esperes más.'' ¿Cuál es la intención comunicativa principal?', '["Informar de manera neutral sobre un producto","Persuadir al oyente para que compre el producto rápidamente","Contar una historia sin ninguna intención comercial","Explicar un concepto científico"]', 1, 'La intención principal es persuadir al oyente para que compre el producto, usando urgencia y exageración.', 'intermedia', 30),
  ('Listen: ''Some studies suggest a possible link, though the evidence remains preliminary and further research is needed.'' What is the primary communicative intention of this discourse, compared to a persuasive advertisement?', '["To persuade the audience emotionally without any evidence","To inform cautiously, acknowledging the limits of current evidence","To sell a specific product aggressively","To entertain with a fictional story"]', 1, 'A diferencia de un discurso persuasivo, este busca informar de manera cautelosa, reconociendo los límites de la evidencia actual.', 'intermedia', 30),
  ('Listen critically: ''Some might call this a tax increase, but we prefer to call it an investment in our shared future.'' What critical observation can be made about the speaker''s communicative intention in choosing the word ''investment'' instead of ''tax increase''?', '["No hay ninguna intención especial detrás de esa elección de palabras","El hablante busca reformular una idea potencialmente negativa (aumento de impuestos) con un término más positivo (inversión), una estrategia persuasiva deliberada","El hablante busca confundir a la audiencia sin ninguna intención clara","El hablante está siendo completamente neutral y objetivo"]', 1, 'El hablante reformula deliberadamente una idea potencialmente negativa con un término más positivo, una estrategia retórica persuasiva que merece análisis crítico.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_4_medio' and lo.short_name = 'Análisis crítico de la intención comunicativa de un discurso oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de debates o paneles de discusión
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen to this panel discussion: ''Panelist A: Universal basic income could reduce poverty effectively. Panelist B: I disagree; it could discourage work instead.'' What are the two opposing positions presented?', '["Both panelists completely agree with each other","Panelist A supports universal basic income; Panelist B is concerned it could discourage work","Neither panelist discusses universal basic income","Panelist B strongly supports universal basic income"]', 1, 'El panel presenta dos posturas opuestas: A apoya el ingreso básico universal, B expresa preocupación de que desincentive el trabajo.', 'inicial', 25),
  ('Escuchas un panel donde tres expertos discuten sobre la regulación de la inteligencia artificial, cada uno con una postura distinta. ¿Qué característica define a este tipo de discurso oral?', '["Presentar una sola postura sin ningún debate","No presentar ninguna postura clara","Presentar múltiples posturas y puntos de vista sobre un mismo tema","Ser un monólogo de una sola persona"]', 2, 'Un panel de discusión se caracteriza por presentar múltiples posturas sobre un mismo tema, a diferencia de un monólogo.', 'intermedia', 30),
  ('Listen: ''Moderator: Let''s move to our next panelist. Panelist C: Building on what was said, I''d like to add a different perspective based on recent data.'' What communicative function does the moderator perform in this panel discussion?', '["Presenting their own personal opinion on the topic","Organizing turns and facilitating the flow of the discussion","Ignoring all panelists completely","Ending the discussion abruptly without reason"]', 1, 'El moderador cumple la función de organizar los turnos y facilitar el flujo de la discusión entre los panelistas.', 'intermedia', 30),
  ('Listen to this debate excerpt: ''Panelist A: The data clearly shows this policy reduced emissions. Panelist B: While emissions data is accurate, correlation with the policy specifically hasn''t been firmly established; other factors may be at play. Moderator: An important distinction—let''s explore that further.'' What does this excerpt reveal about the sophistication of this panel discussion?', '["Los panelistas simplemente repiten lo mismo sin ningún desarrollo","El panel distingue cuidadosamente entre datos aceptados y la interpretación causal de esos datos, mostrando un debate riguroso y matizado","El moderador ignora completamente la discusión","Ningún panelista presenta evidencia en este fragmento"]', 1, 'El fragmento muestra un debate riguroso que distingue entre datos aceptados (las emisiones bajaron) y la interpretación causal (si la política fue la causa), una sofisticación característica de paneles académicos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_4_medio' and lo.short_name = 'Comprensión de debates o paneles de discusión'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Evaluación de la confiabilidad de un discurso oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''I heard from a friend of a friend that this happened, so it must be true.'' What makes this discourse unreliable?', '["It relies on secondhand, unverifiable information rather than credible sources","It cites a specific, verifiable scientific study","It comes from a recognized expert in the field","It provides clear, documented evidence"]', 0, 'El discurso se basa en información de segunda mano no verificable (''amigo de un amigo''), lo que lo hace poco confiable.', 'inicial', 25),
  ('Escuchas un discurso que cita datos específicos, menciona la fuente institucional y reconoce las limitaciones del estudio. ¿Qué característica aumenta la confiabilidad de este discurso?', '["El uso de un tono exagerado y emocional","La transparencia sobre la fuente y las limitaciones del estudio","La ausencia total de datos específicos","El uso de generalizaciones sin evidencia"]', 1, 'La transparencia sobre la fuente institucional y las limitaciones del estudio aumenta la confiabilidad del discurso.', 'intermedia', 30),
  ('Listen: ''This is definitely true, no question about it, and anyone who disagrees simply doesn''t understand the facts.'' How should you critically evaluate the reliability of this discourse?', '["It is highly reliable because it sounds very confident","It should be viewed with skepticism, since dismissing disagreement without evidence is a warning sign of unreliable argumentation","It is reliable because it uses the word ''facts''","There is no way to evaluate the reliability of spoken discourse"]', 1, 'Descartar el desacuerdo sin evidencia y usar un tono absoluto es una señal de alerta sobre la confiabilidad de un discurso.', 'intermedia', 30),
  ('Listen critically: ''According to the official report, results improved by 12%, though the report itself was commissioned and funded by the company whose product was being evaluated.'' How does this detail affect your evaluation of the discourse''s reliability?', '["No afecta en nada la confiabilidad del discurso","Aumenta la confiabilidad, ya que la empresa conoce bien su propio producto","Genera un conflicto de interés potencial que debe considerarse al evaluar la confiabilidad, aunque los datos puedan ser precisos","Hace que el discurso sea completamente falso sin ninguna duda"]', 2, 'Que el informe haya sido financiado por la empresa evaluada genera un conflicto de interés potencial que debe considerarse críticamente, sin necesariamente invalidar los datos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_4_medio' and lo.short_name = 'Evaluación de la confiabilidad de un discurso oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMPRENSIÓN LECTORA — 4° MEDIO
-- ============================================================================

-- Objetivo: Comprensión crítica de textos complejos y de diversa índole
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Comprensión Lectora. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''This philosophical essay explores whether free will is compatible with a deterministic universe, presenting arguments from both compatibilist and incompatibilist perspectives.'' What makes this text complex?', '["It presents multiple philosophical perspectives on a nuanced, abstract question","It is a simple recipe with clear steps","It only presents one single obvious answer","It has no argumentative content at all"]', 0, 'El texto presenta múltiples perspectivas filosóficas sobre una pregunta abstracta y matizada, lo que lo hace complejo.', 'inicial', 25),
  ('Texto: ''El poema utiliza metáforas oscuras y una estructura fragmentada para explorar temas de identidad y pérdida.'' ¿Qué tipo de texto complejo se describe?', '["Un manual técnico simple","Un texto literario complejo con recursos poéticos y temáticos profundos","Una receta de cocina","Un informe meteorológico"]', 1, 'El texto describe un poema con recursos literarios complejos, un texto de diversa índole distinto a un texto informativo simple.', 'intermedia', 30),
  ('Text: ''This legal document uses precise, technical language to define liability in cases involving autonomous vehicles, a domain where existing laws often fail to provide clear guidance.'' What critical challenge does this text highlight?', '["That existing laws provide perfectly clear guidance for autonomous vehicles","That legal language regarding autonomous vehicle liability can be ambiguous due to gaps in existing law","That autonomous vehicles have no legal implications","That this is a purely fictional, unimportant topic"]', 1, 'El texto destaca el desafío crítico de que la ley existente a menudo no ofrece una guía clara para la responsabilidad legal de vehículos autónomos.', 'intermedia', 30),
  ('Text: ''While the scientific paper presents robust statistical evidence, its conclusions are framed within a specific theoretical model that some researchers in the field consider outdated, raising questions about how the findings should be interpreted.'' What complex critical tension does this text present?', '["Que la evidencia estadística es sólida, pero su interpretación depende de un marco teórico cuestionado por parte de la comunidad científica","Que no existe ninguna evidencia estadística en el estudio","Que todos los investigadores están completamente de acuerdo con el marco teórico usado","Que el estudio no tiene ninguna relación con la comunidad científica"]', 0, 'El texto presenta la tensión entre evidencia estadística sólida y un marco teórico interpretativo cuestionado, una complejidad típica del análisis crítico de textos académicos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_4_medio' and lo.short_name = 'Comprensión crítica de textos complejos y de diversa índole'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Evaluación de la validez de los argumentos de un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Comprensión Lectora. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''This celebrity uses this brand of shoes, so the shoes must be the best on the market.'' What logical flaw does this argument show?', '["It relies on celebrity endorsement rather than evidence about quality","It provides rigorous product testing data","It compares multiple brands using objective criteria","It cites a peer-reviewed consumer study"]', 0, 'El argumento se basa en el respaldo de una celebridad en vez de evidencia real sobre la calidad del producto, una falacia de apelación a la autoridad irrelevante.', 'inicial', 25),
  ('Texto: ''Si no apoyas esta política completamente, entonces claramente no te importa el bienestar de la comunidad.'' ¿Qué falacia argumentativa se presenta en este texto?', '["Un argumento perfectamente válido y equilibrado","Una falsa dicotomía, que presenta solo dos opciones extremas sin considerar posturas intermedias","Una cita de una fuente confiable","Un argumento basado en evidencia estadística sólida"]', 1, 'El texto presenta una falsa dicotomía, sugiriendo que solo existen dos opciones extremas sin considerar posturas intermedias.', 'intermedia', 30),
  ('Text: ''The proposal must be flawed because the person who suggested it has been wrong about other things in the past.'' What logical weakness does this argument show?', '["It is a strong, evidence-based argument about the proposal itself","It commits an ad hominem fallacy by attacking the person rather than evaluating the proposal on its merits","It thoroughly analyzes the proposal''s content","It cites relevant data about the proposal"]', 1, 'El argumento comete una falacia ad hominem, atacando a la persona en vez de evaluar la propuesta según sus propios méritos.', 'intermedia', 30),
  ('Text: ''Because renewable energy investments have increased over the past decade, and carbon emissions have also risen globally during the same period, renewable energy must be ineffective at reducing emissions.'' Evaluate the validity of this argument''s reasoning.', '["Es un argumento completamente válido, ya que ambos datos ocurren en el mismo período","El argumento es inválido porque asume causalidad a partir de una correlación simultánea, ignorando otros factores que también podrían explicar el aumento de emisiones","El argumento es válido porque cita datos numéricos específicos","No es posible evaluar la validez de este argumento sin más información"]', 1, 'El argumento es inválido porque asume causalidad a partir de una simple correlación temporal, ignorando otros factores (como el crecimiento poblacional o industrial) que podrían explicar el aumento de emisiones a pesar de la inversión en energías renovables.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_4_medio' and lo.short_name = 'Evaluación de la validez de los argumentos de un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Análisis comparativo de textos con posturas distintas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Comprensión Lectora. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text A: ''Standardized testing ensures fair, objective comparison between students.'' Text B: ''Standardized testing often reflects socioeconomic advantages rather than true ability.'' What is the key difference between these two texts?', '["Text A emphasizes fairness/objectivity; Text B emphasizes hidden socioeconomic bias","Both texts present identical arguments","Neither text discusses standardized testing","Text B fully supports standardized testing"]', 0, 'El texto A enfatiza la equidad y objetividad, mientras que el texto B enfatiza el sesgo socioeconómico oculto.', 'inicial', 25),
  ('Texto A: ''La inteligencia artificial generará más empleos de los que eliminará.'' Texto B: ''La inteligencia artificial eliminará más empleos de los que generará, al menos a corto plazo.'' Al comparar analíticamente ambos textos, ¿qué elemento sería útil buscar para evaluar cuál postura tiene mayor respaldo?', '["El tono emocional usado en cada texto","La cantidad de adjetivos usados en cada texto","La evidencia empírica y las fuentes citadas por cada postura","La extensión en número de palabras de cada texto"]', 2, 'Para evaluar analíticamente cuál postura tiene mayor respaldo, es útil examinar la evidencia empírica y las fuentes citadas, no elementos superficiales como el tono o la extensión.', 'intermedia', 30),
  ('Text A: ''Nuclear energy is essential for a low-carbon future, given its high efficiency and low emissions.'' Text B: ''Nuclear energy poses unacceptable long-term risks related to waste storage and accident potential.'' When analyzing these texts comparatively, what critical question would help evaluate both positions?', '["Which text uses more emotional language","Which text is longer","What specific evidence and risk assessments each position relies on","Which text was published first"]', 2, 'Comparar la evidencia específica y las evaluaciones de riesgo citadas por cada postura es más relevante analíticamente que aspectos superficiales como la extensión o el orden de publicación.', 'intermedia', 30),
  ('Text A, from an industry-funded report: ''This chemical is safe at current usage levels, based on internal testing.'' Text B, from an independent university study: ''This chemical shows potential long-term risks at current usage levels, based on controlled experiments.'' When comparing these texts with differing postures, what critical factor should most influence your evaluation of which position deserves more weight?', '["El texto que use un lenguaje más simple debería tener más peso","El texto A debería tener más peso porque proviene de la industria que conoce mejor el producto","Se debe considerar el posible conflicto de interés del texto A (financiado por la industria) frente a la independencia del texto B, además de comparar el rigor metodológico de ambos estudios","El texto que se publicó más recientemente siempre tiene más peso automáticamente"]', 2, 'Un análisis crítico riguroso debe considerar el posible conflicto de interés en el texto financiado por la industria y comparar el rigor metodológico de ambos estudios, no solo aceptar automáticamente uno sobre otro.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_4_medio' and lo.short_name = 'Análisis comparativo de textos con posturas distintas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Construcción de una postura crítica frente a lo leído
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Comprensión Lectora. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('After reading a text presenting only one side of a controversial issue, what is an appropriate critical response?', '["Seeking additional sources to understand other perspectives before forming a final opinion","Immediately accepting the text''s position as the complete truth","Ignoring the topic completely without further thought","Assuming the opposite of what the text says must be true"]', 0, 'Buscar fuentes adicionales para comprender otras perspectivas antes de formar una opinión final es una respuesta crítica apropiada.', 'inicial', 25),
  ('Al leer un texto que presenta una postura fuerte sin citar ninguna evidencia específica, ¿qué actitud crítica es más apropiada adoptar?', '["Aceptar la postura sin cuestionarla, ya que suena convincente","Cuestionar la falta de evidencia y buscar más información antes de formar una postura propia","Rechazar automáticamente cualquier postura sin evidencia, sin analizarla más","Ignorar por completo el texto sin ningún análisis"]', 1, 'Cuestionar la falta de evidencia y buscar más información es la actitud crítica más apropiada, evitando tanto la aceptación acrítica como el rechazo automático.', 'intermedia', 30),
  ('Text: ''This report argues that a controversial urban development project will bring economic benefits, citing job creation, while critics argue it will displace long-term residents.'' After reading both perspectives, what would constructing a critical stance require?', '["Adoptar automáticamente la postura que se presenta primero en el texto","Considerar la evidencia de ambas posturas, sus posibles sesgos, y formar una opinión propia fundamentada","Rechazar ambas posturas sin ningún análisis","Copiar textualmente la conclusión de una de las dos posturas sin reflexión propia"]', 1, 'Construir una postura crítica requiere considerar la evidencia de ambas posturas, sus posibles sesgos, y formar una opinión propia fundamentada.', 'intermedia', 30),
  ('Text: ''A widely cited report claims a new educational method significantly improves student outcomes; however, the report was funded by the company selling the method, used a small sample size, and lacked a control group for comparison.'' After critically analyzing these methodological details, what would be the most appropriate critical stance to construct?', '["Aceptar completamente las conclusiones del informe sin ninguna reserva","Rechazar por completo el método educativo sin considerar ningún otro dato","Adoptar una postura crítica y cautelosa, reconociendo las limitaciones metodológicas (financiamiento, muestra pequeña, falta de grupo de control) antes de aceptar las conclusiones","Ignorar por completo el informe sin ningún análisis"]', 2, 'Dadas las limitaciones metodológicas identificadas (financiamiento, muestra pequeña, falta de grupo de control), la postura crítica apropiada es cautelosa, sin aceptar ni rechazar completamente las conclusiones sin más evidencia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_4_medio' and lo.short_name = 'Construcción de una postura crítica frente a lo leído'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ORAL — 4° MEDIO
-- ============================================================================

-- Objetivo: Discurso oral formal con postura personal fundamentada
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Expresión Oral. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración presenta correctamente una postura personal fundamentada en un discurso formal?', '["I firmly believe that stricter data privacy laws are necessary, given the increasing risks of digital surveillance.","Data privacy, laws, whatever, maybe.","I don''t know about data privacy laws.","Privacy is a topic. Laws exist too."]', 0, 'Esta oración presenta una postura personal clara, fundamentada en una razón (los riesgos crecientes de vigilancia digital).', 'inicial', 25),
  ('¿Cuál oración es adecuada para desarrollar con evidencia una postura personal en un discurso formal?', '["This is true because I feel like it is.","According to recent reports, data breaches have increased by 40% in the last three years, supporting the need for stronger regulation.","Data, privacy, breaches, whatever.","Everyone agrees with me, so it must be true."]', 1, 'Esta oración desarrolla la postura personal con evidencia concreta (un dato estadístico específico).', 'intermedia', 30),
  ('¿Cuál oración es adecuada para cerrar un discurso formal con una postura personal fundamentada?', '["That''s it, whatever, I''m done talking.","In conclusion, given the evidence presented, stronger data privacy protections are both necessary and urgent.","Privacy, the end, goodbye.","I forgot what my point was."]', 1, 'Esta oración cierra el discurso resumiendo la postura fundamentada en la evidencia presentada.', 'intermedia', 30),
  ('Debes preparar un discurso oral formal completo sobre la obligatoriedad del voto, presentando tu postura personal, una razón, evidencia y una conclusión coherente. ¿Cuál secuencia cumple mejor esta estructura?', '["Voting is good. I like voting. The end.","I believe mandatory voting strengthens democratic participation, because it ensures broader representation; for example, countries with mandatory voting show turnout rates above 90%. In conclusion, this policy deserves serious consideration.","Voting, democracy, good, whatever, conclusion.","I don''t have any opinion about voting."]', 1, 'Esta secuencia presenta postura, razón, evidencia concreta y una conclusión coherente, cumpliendo con un discurso formal fundamentado.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_4_medio' and lo.short_name = 'Discurso oral formal con postura personal fundamentada'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Participación en debates formales sobre temas de actualidad
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Expresión Oral. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En un debate formal sobre un tema de actualidad, ¿cuál expresión es adecuada para presentar tu postura con evidencia reciente?', '["Recent data from this year shows a clear trend supporting my position.","Whatever, I don''t have any data.","I just think this is true, no evidence needed.","This topic doesn''t interest me at all."]', 0, 'Esta expresión presenta la postura respaldada por datos recientes, adecuada para un debate formal sobre un tema de actualidad.', 'inicial', 25),
  ('¿Cuál expresión es adecuada para refutar respetuosamente un argumento de actualidad en un debate formal?', '["You clearly don''t understand current events at all.","While that concern is valid, more recent data suggests a different trend.","That''s a ridiculous point to make.","I don''t want to discuss this topic."]', 1, 'Esta expresión reconoce la preocupación del oponente antes de refutarla con datos más recientes, de forma respetuosa.', 'intermedia', 30),
  ('En un debate formal sobre un tema de actualidad muy polarizado, ¿qué actitud es más apropiada mantener?', '["Insultar a quienes piensan diferente","Mantener un tono respetuoso y basado en evidencia, incluso en desacuerdo","Evitar completamente participar en el debate","Repetir la misma frase sin ningún argumento"]', 1, 'Mantener un tono respetuoso y basado en evidencia es lo más apropiado, incluso en temas polarizados.', 'intermedia', 30),
  ('Debes participar en un debate formal sobre la regulación de las redes sociales, presentando postura, evidencia actual, y respondiendo a un contraargumento de forma respetuosa. ¿Cuál intervención cumple mejor con estos tres elementos?', '["Social media, yes, no, whatever, bye.","I believe stricter regulation is necessary, since recent studies show a clear link between unregulated platforms and the spread of misinformation; while some argue this could limit free expression, targeted regulation can address harm without broad censorship.","Social media is bad. The end.","I don''t have any opinion about social media regulation."]', 1, 'Esta intervención presenta postura, evidencia actual y una respuesta respetuosa a un contraargumento, cumpliendo con una participación completa en un debate formal.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_4_medio' and lo.short_name = 'Participación en debates formales sobre temas de actualidad'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Análisis crítico oral de discursos públicos en inglés
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Expresión Oral. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al analizar críticamente oralmente un discurso público, ¿qué elemento es relevante evaluar?', '["Los recursos retóricos y la evidencia utilizados por el hablante","Solo la duración exacta del discurso","El color de fondo del escenario","La cantidad exacta de aplausos recibidos"]', 0, 'Evaluar los recursos retóricos y la evidencia utilizada es relevante en un análisis crítico oral de un discurso público.', 'inicial', 25),
  ('Al analizar oralmente un discurso público que usa una apelación al miedo sin evidencia sólida, ¿qué observación crítica sería pertinente?', '["Elogiar el discurso sin ninguna observación","Señalar que el discurso apela a la emoción del miedo sin presentar evidencia suficiente que la respalde","Decir que el discurso es perfecto y objetivo","No hacer ningún comentario al respecto"]', 1, 'Es pertinente señalar que el discurso apela al miedo sin evidencia suficiente, una observación crítica relevante.', 'intermedia', 30),
  ('Al analizar un discurso público en inglés que combina estadísticas reales con una conclusión que va más allá de lo que esas estadísticas realmente muestran, ¿qué análisis crítico es más adecuado?', '["Aceptar la conclusión sin cuestionarla, ya que se citan estadísticas","Señalar que, aunque las estadísticas son reales, la conclusión extrapola más de lo que estas realmente demuestran","Rechazar por completo las estadísticas presentadas","Decir que el discurso no tiene ninguna estadística"]', 1, 'Un análisis crítico adecuado reconoce las estadísticas reales pero cuestiona si la conclusión extrapola más de lo que estas realmente demuestran.', 'intermedia', 30),
  ('Debes analizar oralmente un discurso público en inglés de un líder político que combina un dato económico real, una apelación emocional al orgullo nacional, y una conclusión que atribuye todos los beneficios económicos exclusivamente a su gestión. ¿Cuál análisis crítico oral es más completo y adecuado?', '["El discurso es completamente objetivo y no requiere ningún análisis crítico","El discurso combina un dato real con apelación emocional, pero la atribución exclusiva de todos los beneficios a una sola gestión ignora otros factores posibles, lo que merece un análisis cuidadoso","El discurso es completamente falso en su totalidad, sin ningún elemento válido","No es posible analizar este tipo de discurso de forma crítica"]', 1, 'Un análisis crítico completo reconoce el dato real y la apelación emocional, pero cuestiona la atribución exclusiva de los beneficios, que ignora otros factores posibles, mostrando un análisis matizado.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_4_medio' and lo.short_name = 'Análisis crítico oral de discursos públicos en inglés'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Evaluación de la comunicación oral propia y ajena
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Expresión Oral. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al evaluar tu propia comunicación oral y la de un compañero, ¿qué criterio es relevante considerar en ambos casos?', '["La claridad, organización y uso de evidencia en el discurso","Solo el volumen de la voz utilizado","La cantidad de veces que se sonrió durante la presentación","El color de la vestimenta usada"]', 0, 'La claridad, organización y uso de evidencia son criterios relevantes al evaluar cualquier comunicación oral, propia o ajena.', 'inicial', 25),
  ('Al evaluar la comunicación oral de un compañero, notas que presentó buena evidencia pero no consideró ningún contraargumento. ¿Qué retroalimentación constructiva sería más adecuada darle?', '["Decirle que su presentación fue perfecta sin ninguna observación","Sugerirle que incluya y responda a posibles contraargumentos en futuras presentaciones","Criticar duramente sin ninguna sugerencia de mejora","No darle ninguna retroalimentación"]', 1, 'Sugerir constructivamente incluir y responder contraargumentos es una retroalimentación útil y específica.', 'intermedia', 30),
  ('Al autoevaluar tu propia comunicación oral usando una grabación, identificas que hablaste con claridad pero mantuviste poco contacto visual con la audiencia. ¿Qué acción de mejora es más pertinente?', '["No cambiar nada, ya que la claridad fue suficiente","Practicar mantener mayor contacto visual con la audiencia en futuras presentaciones","Dejar de grabar tus presentaciones para evitar verlas","Evitar hablar con claridad en el futuro"]', 1, 'Dado que el aspecto identificado a mejorar es el contacto visual, la acción pertinente es practicar mantenerlo en futuras presentaciones.', 'intermedia', 30),
  ('Debes evaluar tanto tu propia comunicación oral como la de un compañero usando los mismos tres criterios: claridad, evidencia y manejo de contraargumentos. Notas que tu compañero domina la claridad y evidencia, pero tú manejas mejor los contraargumentos. ¿Qué acción sería más constructiva para ambos?', '["Ignorar las diferencias y no compartir ninguna observación","Compartir retroalimentación específica y constructiva sobre las fortalezas y áreas de mejora de cada uno, aprendiendo mutuamente","Decir que ambos son perfectos sin ninguna sugerencia","Criticar solo los errores sin mencionar ninguna fortaleza"]', 1, 'Compartir retroalimentación específica y constructiva sobre fortalezas y áreas de mejora permite un aprendizaje mutuo, la acción más constructiva en este contexto.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_4_medio' and lo.short_name = 'Evaluación de la comunicación oral propia y ajena'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ESCRITA — 4° MEDIO
-- ============================================================================

-- Objetivo: Redacción de un ensayo argumentativo complejo
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Expresión Escrita. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración presenta correctamente una tesis compleja y matizada para un ensayo argumentativo?', '["While automation presents undeniable economic benefits, policymakers must address its disruptive effects on the labor market through targeted retraining programs.","Automation is a topic. Economy exists. Jobs exist too.","I don''t know about automation and jobs.","Automation, economy, jobs, maybe."]', 0, 'Esta oración presenta una tesis compleja y matizada, reconociendo beneficios y proponiendo una solución específica.', 'inicial', 25),
  ('¿Cuál oración funciona como un argumento de apoyo con evidencia, adecuado para un ensayo argumentativo complejo sobre la brecha digital?', '["The digital divide is a phrase with four words.","According to a 2022 report, rural areas have 30% less access to high-speed internet than urban areas, limiting educational opportunities.","Some people don''t have internet, I guess.","Digital, divide, internet, word."]', 1, 'Esta oración presenta evidencia específica (un informe con datos concretos) que respalda el argumento sobre la brecha digital.', 'intermedia', 30),
  ('¿Cuál oración es adecuada para la conclusión de un ensayo argumentativo complejo sobre la regulación de la inteligencia artificial?', '["In conclusion, effective AI regulation must balance innovation with accountability, requiring ongoing collaboration between governments, industry, and civil society.","AI, the end, goodbye forever.","I don''t want to talk about AI anymore.","AI is a word with two letters."]', 0, 'Esta oración cierra el ensayo con una conclusión matizada que reconoce la complejidad del tema y propone un enfoque colaborativo.', 'intermedia', 30),
  ('Debes redactar un ensayo argumentativo complejo (tesis matizada, al menos dos argumentos con evidencia, reconocimiento de un contraargumento, y conclusión) sobre la migración internacional. ¿Cuál secuencia cumple mejor esta estructura?', '["Migration is complicated. I have an opinion. The end.","While migration policy remains politically contentious, evidence suggests that well-managed migration can benefit both host and origin countries economically and culturally. Critics raise valid concerns about integration challenges; however, targeted support programs have shown success in addressing these. In conclusion, evidence-based migration policy, rather than purely restrictive approaches, offers the most sustainable path forward.","Migration, policy, good, bad, whatever.","I don''t know if migration matters."]', 1, 'Esta secuencia presenta una tesis matizada, argumentos con evidencia, reconocimiento de un contraargumento y una conclusión coherente, cumpliendo la estructura de un ensayo argumentativo complejo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_4_medio' and lo.short_name = 'Redacción de un ensayo argumentativo complejo'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Integración crítica de múltiples fuentes en un texto propio
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Expresión Escrita. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al integrar críticamente múltiples fuentes en un ensayo, ¿qué acción va más allá de simplemente citarlas por separado?', '["Analizar cómo las fuentes se relacionan, coinciden o difieren entre sí","Citar cada fuente en un párrafo separado sin ninguna conexión","Copiar textualmente cada fuente sin ningún análisis","Ignorar las diferencias entre las fuentes citadas"]', 0, 'La integración crítica implica analizar cómo las fuentes se relacionan, coinciden o difieren entre sí, no solo citarlas de forma aislada.', 'inicial', 25),
  ('¿Cuál oración integra críticamente dos fuentes distintas, mostrando su relación?', '["Smith (2020) said something, and Lee (2021) said something else.","While Smith (2020) emphasizes economic benefits, Lee (2021) highlights social costs, suggesting the issue involves genuine trade-offs.","Smith and Lee wrote about this topic.","Sources exist about this topic somewhere."]', 1, 'Esta oración integra críticamente dos fuentes, mostrando explícitamente su relación (énfasis distintos que sugieren trade-offs).', 'intermedia', 30),
  ('Al integrar tres fuentes que presentan conclusiones distintas sobre el mismo tema en un ensayo, ¿qué enfoque demuestra mayor pensamiento crítico?', '["Elegir arbitrariamente una fuente e ignorar las otras dos","Analizar por qué las fuentes difieren (metodología, muestra, sesgo potencial) y formar una síntesis propia fundamentada","Copiar las tres conclusiones sin ningún análisis adicional","Rechazar las tres fuentes sin ninguna razón"]', 1, 'Analizar por qué las fuentes difieren y formar una síntesis propia fundamentada demuestra un pensamiento crítico más profundo.', 'intermedia', 30),
  ('Debes integrar tres fuentes en un párrafo de tu ensayo sobre los efectos de las redes sociales en la salud mental: un estudio que encuentra efectos negativos, otro que encuentra efectos neutros, y un tercero que encuentra efectos positivos en ciertos contextos. ¿Cuál integración demuestra el análisis crítico más completo?', '["Social media affects mental health, according to three studies.","While one study found negative effects, another found no significant impact, and a third identified positive effects in specific contexts, suggesting that the relationship between social media and mental health may depend heavily on how and why it is used.","Social media is bad for mental health, based on one study.","Three studies exist about social media and mental health."]', 1, 'Esta opción integra críticamente las tres fuentes, reconociendo sus diferencias y proponiendo una explicación matizada (que el efecto depende del uso), el análisis más completo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_4_medio' and lo.short_name = 'Integración crítica de múltiples fuentes en un texto propio'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Adecuación del texto escrito a un propósito y audiencia específicos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Expresión Escrita. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Debes escribir sobre el mismo tema (beneficios del ejercicio) para una revista científica y para un folleto dirigido a adolescentes. ¿Qué debería cambiar principalmente entre ambos textos?', '["El vocabulario, el nivel de tecnicidad y el tono, adaptados a cada audiencia","El tema completo del texto","Nada, ambos textos deben ser idénticos","Solo el idioma utilizado"]', 0, 'El vocabulario, la tecnicidad y el tono deben adaptarse según la audiencia y el propósito, aunque el tema central sea el mismo.', 'inicial', 25),
  ('¿Cuál texto está mejor adecuado a un propósito persuasivo dirigido a inversionistas, en comparación con uno meramente informativo?', '["This company sells shoes. Shoes are objects people wear.","Investing in this company offers strong growth potential, backed by a 25% year-over-year revenue increase.","Shoes exist in many colors and sizes.","This is a company. It has employees."]', 1, 'Esta oración está adecuada a un propósito persuasivo dirigido a inversionistas, destacando datos de crecimiento relevantes para ellos.', 'intermedia', 30),
  ('Al adecuar un texto escrito a una audiencia académica especializada, en comparación con el público general, ¿qué característica debería aumentar?', '["El uso de terminología técnica específica del área, asumiendo conocimiento previo","La cantidad de explicaciones básicas de conceptos elementales","El uso de un tono extremadamente informal","La cantidad de emojis y abreviaciones"]', 0, 'Para una audiencia académica especializada, es adecuado aumentar el uso de terminología técnica específica, asumiendo conocimiento previo del tema.', 'intermedia', 30),
  ('Debes escribir dos textos sobre el mismo estudio científico: un resumen para una revista académica especializada y un artículo de divulgación para un periódico general. ¿Cuál par de enfoques refleja mejor esta adecuación de propósito y audiencia?', '["Usar exactamente el mismo texto técnico para ambas audiencias","Usar terminología técnica y datos estadísticos detallados para la revista académica, y un lenguaje más simple con analogías para el periódico general","Usar un lenguaje extremadamente simple para ambas audiencias, ignorando a los académicos","No adaptar nada, ya que el estudio es el mismo para ambos textos"]', 1, 'Adaptar el nivel de tecnicidad (detallado para la revista académica, simplificado con analogías para el periódico general) refleja una adecuación correcta a cada propósito y audiencia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_4_medio' and lo.short_name = 'Adecuación del texto escrito a un propósito y audiencia específicos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Reflexión sobre el propio proceso de escritura en inglés
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 4° Medio, eje Expresión Escrita. Basada en Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al reflexionar sobre tu propio proceso de escritura en inglés, ¿qué pregunta sería más útil hacerte?', '["¿Qué decisiones tomé al estructurar mis argumentos y por qué?","¿Qué color de lápiz usé para escribir el borrador?","¿Cuántas páginas tiene mi cuaderno?","¿A qué hora del día escribí el texto?"]', 0, 'Reflexionar sobre las decisiones de estructura y argumentación es más relevante para el proceso de escritura que aspectos superficiales.', 'inicial', 25),
  ('Un estudiante reflexiona y nota que, al escribir en inglés, tiende a traducir directamente estructuras del español, lo que a veces genera oraciones poco naturales. ¿Qué acción de mejora es más pertinente?', '["Ignorar esta observación y seguir escribiendo igual","Practicar estructuras y expresiones propias del inglés en vez de traducir directamente del español","Dejar de escribir en inglés por completo","Escribir exclusivamente en español de ahora en adelante"]', 1, 'Practicar estructuras propias del inglés, en vez de traducir directamente, es la acción de mejora pertinente identificada mediante la reflexión.', 'intermedia', 30),
  ('Al reflexionar sobre tu proceso de escritura de un ensayo en inglés, identificas que dedicaste mucho tiempo a la planificación pero muy poco a la revisión final. ¿Qué ajuste sería más pertinente para tu próximo ensayo?', '["Eliminar completamente la etapa de planificación","Distribuir el tiempo de forma más equilibrada, dedicando más tiempo a la revisión final","Escribir el ensayo sin ninguna planificación en el futuro","No hacer ningún cambio, ya que planificar es suficiente"]', 1, 'Dado que el desequilibrio identificado es la falta de tiempo dedicado a la revisión, el ajuste pertinente es distribuir el tiempo de forma más equilibrada.', 'intermedia', 30),
  ('Al finalizar el proceso de escritura de tu ensayo final de la asignatura, reflexionas sobre tu progreso a lo largo del año: reconoces que mejoraste en el uso de conectores y vocabulario académico, pero identificas que aún cometes errores frecuentes con los tiempos verbales en pasado. ¿Qué conclusión y acción futura sería más pertinente a partir de esta reflexión?', '["Concluir que no se puede mejorar más y dejar de practicar la escritura","Reconocer el progreso logrado y enfocar la práctica futura específicamente en los tiempos verbales en pasado","Ignorar los errores identificados, ya que el vocabulario mejoró","Concluir que el progreso en conectores y vocabulario no tiene ningún valor"]', 1, 'Una reflexión pertinente reconoce el progreso logrado (conectores, vocabulario) y dirige la práctica futura específicamente al área que aún requiere mejora (tiempos verbales en pasado).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_4_medio' and lo.short_name = 'Reflexión sobre el propio proceso de escritura en inglés'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
