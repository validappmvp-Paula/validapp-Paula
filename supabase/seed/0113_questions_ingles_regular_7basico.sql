-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Idioma
-- Extranjero: Inglés, 7° Básico. Cubre los 16 objetivos de aprendizaje de 7°
-- Básico cargados por
-- supabase/seed/0024_curriculum_ingles_regular_7basico_2medio.sql (4 ejes:
-- Comprensión Auditiva, Comprensión Lectora, Expresión Oral, Expresión
-- Escrita), con 4 preguntas por objetivo, total 64 preguntas en este
-- archivo.
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
-- CRITERIO DE IDIOMA USADO EN ESTE ARCHIVO (7° Básico a 2° Medio, nivel A2)
-- ============================================================================
-- A diferencia de 5°-6° Básico (supabase/seed/0111-0112, nivel A1 inicial,
-- instrucciones en español), en esta banda (A2 creciente) se aumenta
-- deliberadamente la proporción de inglés:
--   - Los ESTÍMULOS (textos, diálogos, narraciones) están SIEMPRE en inglés.
--   - Las PREGUNTAS/enunciados se formulan directamente en INGLÉS cuando
--     evalúan comprensión directa de un texto/audio en inglés (p. ej. "What
--     happened first in this story?", "What is the purpose of this text?"),
--     porque en A2 el estudiante ya debe poder decodificar preguntas simples
--     en inglés sin apoyo de traducción.
--   - Las preguntas se formulan en ESPAÑOL cuando son "meta" sobre un
--     concepto lingüístico o estrategia (p. ej. "¿qué conector es
--     adecuado...?", "¿qué estrategia de comprensión lectora...?"), porque
--     evalúan conocimiento metalingüístico/metacognitivo, no comprensión
--     directa de un texto -- mismo criterio de fondo que 0111/0112, pero con
--     el umbral movido: en A1 casi todo el enunciado iba en español, en A2 la
--     mayoría de los enunciados sobre CONTENIDO van en inglés.
--   - Las ALTERNATIVAS están en inglés cuando la pregunta requiere reconocer,
--     completar o producir una forma correcta en inglés (gramática,
--     conectores, ortografía, oraciones completas), y en español solo cuando
--     la pregunta pide identificar una idea/concepto en español (p. ej.
--     resumir la idea principal de un audio).
--
-- ============================================================================
-- FUENTE Y NIVEL DE CONFIANZA
-- ============================================================================
-- Enunciados de redacción ORIGINAL de ValidApp, alineados al objetivo
-- correspondiente (ver supabase/seed/0024). `framework_id`/`source_id`
-- quedan NULL (mismo motivo que el resto del banco). `content_hash` queda
-- NULL, pendiente de calcularse con `computeContentHash`
-- (`lib/data/question-validators.ts`).
--
-- ============================================================================
-- VALIDACIÓN MECÁNICA E IDEMPOTENCIA
-- ============================================================================
-- Mismo patrón que 0111/0112: revisión manual contra
-- `lib/data/question-validators.ts` (sin alternativas duplicadas/vacías,
-- exactamente una respuesta correcta, sin "todas/ninguna de las
-- anteriores"), rotación round-robin 0,1,2,3 de la posición correcta a lo
-- largo de las 64 preguntas, e idempotencia vía `where not exists` sobre
-- `learning_objective_id` + `prompt`, resuelto siempre por (subject.name,
-- strand.name, level.code, learning_objective.short_name).
--
-- Seed SOLO local: no se ha ejecutado contra Supabase.

-- ============================================================================
-- EJE: COMPRENSIÓN AUDITIVA — 7° BÁSICO
-- ============================================================================

-- Objetivo: Comprensión de narraciones orales simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Escuchas: ''Last summer, I went to the beach with my family.'' ¿De qué tiempo verbal habla principalmente esta narración?', '["Presente","Pasado","Futuro","Condicional"]', 0, '''Went'' es la forma pasada del verbo ''go'', indicando que la narración es sobre el pasado.', 'inicial', 25),
  ('Listen: ''She woke up late, missed the bus, and arrived at school at nine.'' What happened first in this story?', '["She arrived at school","She woke up late","She missed the bus","None of the above"]', 1, 'According to the sequence, she first woke up late, then missed the bus, then arrived late.', 'intermedia', 30),
  ('Escuchas: ''We visited my grandparents, ate a big lunch, and played games all afternoon.'' ¿Cuál fue la última actividad mencionada?', '["Visitar a los abuelos","Almorzar","Jugar juegos toda la tarde","Ninguna de las anteriores"]', 2, 'La última actividad mencionada en la narración es jugar juegos toda la tarde.', 'intermedia', 30),
  ('Listen: ''It was raining, but we still went camping. We got wet, but we had a great time around the fire.'' What is the main idea of this short narration?', '["It never rained during the trip","They cancelled the camping trip","They stayed home instead of camping","Despite the rain, they enjoyed their camping trip"]', 3, 'A pesar de la lluvia, disfrutaron su viaje de camping, que es la idea principal.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_7_basico' and lo.short_name = 'Comprensión de narraciones orales simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de información específica en un audio
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''The concert starts at eight and tickets cost ten dollars.'' How much do the tickets cost?', '["Ten dollars","Eight dollars","Eighteen dollars","Eighty dollars"]', 0, 'The audio states the tickets cost ten dollars.', 'inicial', 25),
  ('Escuchas: ''My brother was born in March, and my sister was born in July.'' ¿En qué mes nació la hermana?', '["Marzo","Julio","Enero","Diciembre"]', 1, 'El audio indica que la hermana nació en julio.', 'intermedia', 30),
  ('Listen: ''The trip took three hours by car, but only one hour by plane.'' How long did the trip take by plane?', '["Three hours","Two hours","One hour","Four hours"]', 2, 'The audio states the trip by plane took one hour.', 'intermedia', 30),
  ('Listen: ''The museum is open from Tuesday to Sunday, from ten in the morning until six in the evening, except on public holidays.'' On which day is the museum closed, according to the audio?', '["Tuesday","Sunday","Saturday","Monday, and also on public holidays"]', 3, 'El audio no menciona el lunes entre los días abiertos, y explícitamente indica que también cierra en feriados.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_7_basico' and lo.short_name = 'Identificación de información específica en un audio'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de diálogos sobre experiencias personales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen to this dialogue: ''A: Did you have a good weekend? B: Yes, I went hiking with my friends.'' What did B do over the weekend?', '["Went hiking with friends","Stayed home alone","Went to school","Watched a movie"]', 0, 'B respondió que fue de excursión (''hiking'') con sus amigos.', 'inicial', 25),
  ('Diálogo: ''A: How was your trip to Peru? B: It was amazing, but the flight was very long.'' ¿Qué aspecto del viaje menciona B como negativo?', '["La comida","El vuelo largo","El hotel","El clima"]', 1, 'B menciona que el vuelo fue muy largo como aspecto negativo.', 'intermedia', 30),
  ('Listen: ''A: Did you like the new restaurant? B: The food was great, but the service was too slow.'' What was B''s opinion about the service?', '["It was excellent","It was fast","It was too slow","B didn''t mention it"]', 2, 'B mentions that the service was too slow.', 'intermedia', 30),
  ('Diálogo: ''A: Why were you late today? B: My bus broke down, so I had to walk the last part of the way.'' ¿Qué relación de causa-efecto se describe en la respuesta de B?', '["Caminó porque quería hacer ejercicio","Llegó tarde porque decidió caminar desde su casa","El bus se descompuso, por lo que tuvo que caminar parte del camino","No hay ninguna relación de causa y efecto"]', 3, 'La causa (el bus se descompuso) llevó al efecto (tuvo que caminar parte del camino).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_7_basico' and lo.short_name = 'Comprensión de diálogos sobre experiencias personales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Reconocimiento de la actitud o emoción del hablante
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''I can''t believe we won the game! This is amazing!'' What emotion does the speaker express?', '["Excitement/happiness","Sadness","Anger","Boredom"]', 0, 'The exclamations and words like ''amazing'' show excitement and happiness.', 'inicial', 25),
  ('Escuchas: ''I''m really tired of doing the same thing every day.'' ¿Qué actitud refleja el hablante?', '["Entusiasmo","Aburrimiento o cansancio","Sorpresa","Alegría"]', 1, 'La frase refleja aburrimiento o cansancio ante la rutina.', 'intermedia', 30),
  ('Listen: ''Oh no, I forgot my homework at home again!'' What emotion is the speaker likely feeling?', '["Calm","Excitement","Frustration or worry","Happiness"]', 2, 'Forgetting homework again would likely cause frustration or worry.', 'intermedia', 30),
  ('Listen: ''Well... I guess it''s fine, if that''s what everyone wants.'' What attitude does the speaker''s tone likely suggest, despite the words used?', '["Enthusiastic agreement","Complete happiness","Genuine excitement","Reluctant or unenthusiastic agreement"]', 3, 'Expresiones como ''I guess'' y ''if that''s what everyone wants'' sugieren un acuerdo poco entusiasta, a pesar de aceptar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_7_basico' and lo.short_name = 'Reconocimiento de la actitud o emoción del hablante'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMPRENSIÓN LECTORA — 7° BÁSICO
-- ============================================================================

-- Objetivo: Comprensión de textos narrativos breves
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Last winter, Marco traveled to the south of Chile and saw snow for the first time.'' What is this text mainly about?', '["A past trip where Marco saw snow for the first time","A recipe for winter food","A weather forecast","A future trip Marco is planning"]', 0, 'The text narrates a past event: Marco''s trip and seeing snow for the first time.', 'inicial', 25),
  ('Texto: ''When she was young, Elena wanted to be a doctor. Now, she is studying medicine at university.'' ¿Qué relación temporal se describe en el texto?', '["Solo el presente","Un deseo pasado que se está cumpliendo en el presente","Solo el futuro","Ningún cambio en el tiempo"]', 1, 'El texto describe un deseo del pasado (quería ser doctora) que se está cumpliendo en el presente (está estudiando medicina).', 'intermedia', 30),
  ('Text: ''The old man walked slowly to the river, sat down, and watched the water for hours.'' What can you infer about the old man''s mood from this narration?', '["He seemed angry and impatient","He seemed calm and reflective","He seemed scared","He seemed in a hurry"]', 2, 'Walking slowly and watching the water for hours suggests a calm, reflective mood.', 'intermedia', 30),
  ('Text: ''At first, the team was losing badly. Then, in the last ten minutes, they scored three goals and won the match.'' What is the narrative structure of this text?', '["A story with no conflict or change","A situation that gets worse throughout","A description with no events","A difficult situation followed by an unexpected positive change"]', 3, 'El texto presenta una situación difícil (iban perdiendo) seguida de un cambio positivo inesperado (anotaron y ganaron).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_7_basico' and lo.short_name = 'Comprensión de textos narrativos breves'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación del propósito comunicativo de un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Come to our school fair this Saturday! Games, food, and music for the whole family.'' What is the purpose of this text?', '["To invite people to an event","To tell a sad story","To give scientific information","To complain about something"]', 0, 'El texto invita a las personas a un evento, por lo que su propósito es invitar.', 'inicial', 25),
  ('Texto: ''Please remember to bring your permission slip signed by a parent before Friday.'' ¿Cuál es el propósito de este texto?', '["Narrar una historia","Recordar una tarea o requisito pendiente","Describir un lugar","Expresar una opinión personal"]', 1, 'El texto busca recordar un requisito pendiente (traer el permiso firmado).', 'intermedia', 30),
  ('Text: ''Once upon a time, there was a village near a great forest.'' What is the purpose of this text?', '["To give instructions","To argue a point","To begin telling a story","To advertise a product"]', 2, 'This is the typical opening of a narrative, so its purpose is to begin telling a story.', 'intermedia', 30),
  ('Text: ''Studies show that reading for twenty minutes a day improves vocabulary and comprehension skills in students.'' What is the main communicative purpose of this text?', '["To entertain with a fictional story","To sell a book","To narrate a personal experience","To inform readers about a benefit of reading, supported by evidence"]', 3, 'El texto entrega información respaldada por evidencia sobre un beneficio de la lectura, por lo que su propósito es informar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_7_basico' and lo.short_name = 'Identificación del propósito comunicativo de un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de estrategias de comprensión lectora
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Antes de leer un texto titulado ''The Life Cycle of a Butterfly'', ¿qué estrategia de predicción sería más útil?', '["Predecir que hablará sobre las etapas de vida de una mariposa","Predecir que hablará de un partido de fútbol","Predecir que hablará de una receta de cocina","No es posible predecir nada a partir del título"]', 0, 'El título permite predecir que el texto hablará sobre las etapas de vida de una mariposa.', 'inicial', 25),
  ('Si no entiendes una palabra en un texto en inglés, ¿qué estrategia de comprensión lectora es más recomendable usar primero?', '["Detener la lectura por completo","Intentar inferir el significado por el contexto","Traducir todo el texto al español de inmediato","Ignorar el resto del texto"]', 1, 'Inferir el significado por el contexto es una estrategia clave de comprensión lectora.', 'intermedia', 30),
  ('Después de leer un párrafo complejo y no entenderlo bien, ¿qué estrategia es recomendable aplicar?', '["Avanzar sin volver a leerlo","Releer el párrafo con más atención","Dejar de leer el texto completo","Cambiar el tema del texto"]', 2, 'Releer con atención (relectura) es una estrategia recomendable ante un párrafo complejo.', 'intermedia', 30),
  ('Estás leyendo un texto largo sobre el cambio climático y quieres identificar rápidamente las ideas principales de cada párrafo. ¿Qué estrategia es más eficiente para lograr esto?', '["Leer cada palabra en voz alta lentamente","Memorizar el texto completo palabra por palabra","Traducir todo el texto antes de empezar a leer","Leer la primera oración de cada párrafo para identificar la idea principal"]', 3, 'Leer la primera oración de cada párrafo (a menudo la idea principal) es una estrategia eficiente de lectura rápida.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_7_basico' and lo.short_name = 'Uso de estrategias de comprensión lectora'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comparación de información entre dos textos breves
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text A: ''The museum opens at nine.'' Text B: ''The museum opens at ten.'' What is the difference between the two texts?', '["The opening time is different","Both texts say the same time","Neither text mentions a time","Both texts talk about a different place"]', 0, 'Los dos textos indican horas de apertura distintas: las nueve y las diez.', 'inicial', 25),
  ('Texto A: ''Ana likes to read books in her free time.'' Texto B: ''Ana likes to play sports in her free time.'' ¿Qué diferencia hay entre ambos textos?', '["Ambos dicen exactamente lo mismo","Describen actividades distintas que le gustan a Ana en su tiempo libre","Ninguno menciona a Ana","Ambos hablan de un lugar diferente"]', 1, 'Ambos textos describen actividades distintas (leer y hacer deporte) que le gustan a Ana.', 'intermedia', 30),
  ('Text A: ''It will be sunny tomorrow.'' Text B: ''It will rain tomorrow.'' What can you conclude by comparing both texts?', '["Both texts agree completely","Neither text talks about the weather","They give contradictory information about tomorrow''s weather","Both texts talk about yesterday"]', 2, 'Ambos textos entregan información contradictoria sobre el clima de mañana.', 'intermedia', 30),
  ('Text A: ''The trip costs $50,000 and includes breakfast.'' Text B: ''The trip costs $45,000 but breakfast is not included.'' If you want the cheapest option and don''t mind paying for your own breakfast, which text describes the better option, and why?', '["Text A, because it includes breakfast for a higher price","Neither, because both cost the same","Text B, because it is cheaper and breakfast is not a priority for you","Text B, because it also includes breakfast"]', 2, 'El texto B es más barato y, si no priorizas el desayuno incluido, es la mejor opción.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_7_basico' and lo.short_name = 'Comparación de información entre dos textos breves'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ORAL — 7° BÁSICO
-- ============================================================================

-- Objetivo: Narración oral de experiencias pasadas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración usa correctamente el pasado simple para narrar una experiencia?', '["Last year, I traveled to Brazil.","Last year, I travel to Brazil.","Last year, I traveling to Brazil.","Last year, I to travel Brazil."]', 0, '''I traveled'' es la forma correcta del pasado simple del verbo ''travel''.', 'inicial', 25),
  ('¿Cuál oración usa correctamente el pasado del verbo irregular ''go''?', '["Yesterday, I goed to the park.","Yesterday, I went to the park.","Yesterday, I going to the park.","Yesterday, I go to the park."]', 1, '''Went'' es la forma correcta del pasado irregular de ''go''.', 'intermedia', 30),
  ('¿Cuál oración narra correctamente una experiencia pasada usando un marcador temporal adecuado?', '["Tomorrow, I visited my cousins.","Next week, I visited my cousins.","Two years ago, I visited my cousins.","In the future, I visited my cousins."]', 2, '''Two years ago'' es un marcador temporal adecuado para el pasado, coherente con el verbo ''visited''.', 'intermedia', 30),
  ('Debes narrar oralmente una experiencia pasada de forma coherente, usando pasado simple y un orden lógico. ¿Cuál secuencia de oraciones es la más adecuada?', '["I will go to the beach. I swam in the ocean. I am having lunch.","I go to the beach. I swim in the ocean. I have lunch there.","I went to the beach. I swam in the ocean. Then, I had lunch there.","I going to the beach. I swimming in the ocean. I having lunch."]', 2, 'La secuencia correcta usa pasado simple de forma consistente y un orden lógico de eventos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_7_basico' and lo.short_name = 'Narración oral de experiencias pasadas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Formulación de opiniones simples con justificación
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración expresa correctamente una opinión con una razón?', '["I think soccer is fun because it is a team sport.","Soccer is fun. The weather is nice.","I like soccer, my name is Pedro.","Soccer ball is round."]', 0, 'La oración expresa una opinión (''I think soccer is fun'') justificada con una razón (''because it is a team sport'').', 'inicial', 25),
  ('¿Cuál oración usa un conector adecuado para justificar una opinión?', '["I don''t like homework, and then I do it.","I don''t like homework because it takes too much time.","I don''t like homework, tomorrow is Monday.","Homework is a paper."]', 1, '''Because'' conecta correctamente la opinión con su justificación.', 'intermedia', 30),
  ('Si opinas que ''reading is important'', ¿cuál es una justificación adecuada para esta opinión?', '["Because the sky is blue.","Because I have a dog.","Because it helps you learn new words and ideas.","Because today is sunny."]', 2, 'Esta justificación se relaciona directamente con la opinión sobre la importancia de la lectura.', 'intermedia', 30),
  ('Debes expresar oralmente una opinión completa (postura + justificación + ejemplo) sobre el uso de la tecnología en el aula. ¿Cuál opción cumple con los tres elementos?', '["Technology is good. I like phones.","I think technology helps learning because it gives access to information, for example, online dictionaries.","Technology exists in schools.","I don''t know about technology."]', 1, 'Esta opción incluye una postura clara, una justificación y un ejemplo concreto (diccionarios en línea).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_7_basico' and lo.short_name = 'Formulación de opiniones simples con justificación'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Participación en conversaciones sobre planes futuros
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración expresa correctamente un plan futuro?', '["I am going to visit my aunt next weekend.","I visited my aunt last weekend.","I visit my aunt every weekend.","I have visited my aunt."]', 0, '''I am going to visit'' expresa correctamente un plan futuro.', 'inicial', 25),
  ('¿Cuál pregunta es adecuada para conversar sobre los planes futuros de un compañero?', '["What did you do yesterday?","What are you going to do this weekend?","Where were you born?","How old are you?"]', 1, '''What are you going to do this weekend?'' pregunta específicamente sobre planes futuros.', 'intermedia', 30),
  ('¿Cuál respuesta expresa correctamente una intención futura?', '["I finished my homework yesterday.","I am always busy.","I am planning to study abroad next year.","I studied abroad last year."]', 2, '''I am planning to study abroad next year'' expresa correctamente una intención futura.', 'intermedia', 30),
  ('En una conversación sobre planes de vacaciones, un compañero dice: ''I''m going to visit my grandparents, and then I might travel to the south with my family.'' ¿Qué combinación de certeza expresa esta respuesta?', '["Ambos planes son completamente inciertos","Ambos planes son totalmente seguros","No menciona ningún plan futuro","Un plan seguro (visitar a los abuelos) y un plan posible pero no confirmado (viajar al sur)"]', 3, '''Going to visit'' expresa un plan más definido, mientras que ''might travel'' expresa una posibilidad no confirmada.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_7_basico' and lo.short_name = 'Participación en conversaciones sobre planes futuros'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de conectores simples en el discurso oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál conector es adecuado para agregar una idea, como en ''I like soccer ___ I like basketball''?', '["and","but","because","so"]', 0, '''And'' se usa para agregar una idea similar o relacionada.', 'inicial', 25),
  ('¿Cuál conector es adecuado para mostrar contraste, como en ''I like tea ___ I don''t like coffee''?', '["and","but","so","because"]', 1, '''But'' se usa para mostrar contraste entre dos ideas.', 'intermedia', 30),
  ('¿Cuál conector es adecuado para dar una razón, como en ''I stayed home ___ I was sick''?', '["and","but","because","so"]', 2, '''Because'' introduce una razón o causa.', 'intermedia', 30),
  ('¿Cuál conector es adecuado para indicar una consecuencia, como en ''It was raining, ___ we stayed home''?', '["because","but","and","so"]', 3, '''So'' indica una consecuencia de lo mencionado anteriormente (la lluvia).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_7_basico' and lo.short_name = 'Uso de conectores simples en el discurso oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ESCRITA — 7° BÁSICO
-- ============================================================================

-- Objetivo: Escritura de un texto narrativo breve
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración es un buen inicio para un texto narrativo breve sobre una experiencia pasada?', '["Last summer, my family and I went camping in the mountains.","Camping is a fun outdoor activity.","You should go camping in the mountains.","Mountains are usually cold at night."]', 0, 'Esta oración sitúa la narración en el pasado y presenta el evento central, un buen inicio narrativo.', 'inicial', 25),
  ('¿Cuál oración continúa coherentemente una narración que comienza con ''I woke up early and packed my bags''?', '["I will wake up early tomorrow.","Then, I left the house and took a taxi to the airport.","Waking up early is a good habit.","I usually pack my bags the night before."]', 1, 'Esta oración continúa la secuencia narrativa en pasado de forma coherente.', 'intermedia', 30),
  ('¿Cuál oración funciona bien como cierre de un texto narrativo breve sobre un viaje?', '["I am planning my next trip already.","Traveling is expensive nowadays.","In the end, it was one of the best trips of my life.","Trips usually include flights and hotels."]', 2, 'Esta oración cierra la narración con una reflexión final sobre la experiencia.', 'intermedia', 30),
  ('Debes escribir un texto narrativo breve con inicio, desarrollo y cierre sobre un día en la playa. ¿Cuál secuencia de tres oraciones cumple mejor esta estructura?', '["The beach was crowded. I like the beach. Beaches are sunny.","I go to the beach every year. The beach has sand. I like sand.","Last Saturday, I went to the beach with my friends. We swam and played volleyball all afternoon. In the end, we watched the sunset together.","Beaches are near the ocean. The ocean has waves. Waves are big."]', 2, 'Esta secuencia presenta un inicio (llegada a la playa), desarrollo (actividades) y cierre (ver el atardecer), con coherencia narrativa.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_7_basico' and lo.short_name = 'Escritura de un texto narrativo breve'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de conectores para dar cohesión al texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración usa correctamente un conector de secuencia?', '["First, I got up. Then, I had breakfast.","I got up but I had breakfast.","I got up because breakfast.","I got up, breakfast I had."]', 0, '''First... then'' es una estructura correcta de conectores de secuencia.', 'inicial', 25),
  ('¿Cuál oración usa correctamente un conector de causa?', '["I was tired, then I went to bed early.","I was tired, so I went to bed early.","I was tired, but I went to bed early.","I was tired, first I went to bed early."]', 1, '''So'' conecta correctamente la causa (estar cansado) con la consecuencia (irse a dormir temprano).', 'intermedia', 30),
  ('¿Cuál oración usa correctamente un conector de contraste?', '["It was cold, so I wore a t-shirt.","It was cold, because I wore a t-shirt.","It was cold, but I wore a t-shirt.","It was cold, first I wore a t-shirt."]', 2, '''But'' muestra correctamente el contraste entre el frío y la decisión de usar una polera.', 'intermedia', 30),
  ('Debes unir estas ideas con el conector más adecuado para dar cohesión: ''She studied hard. ___, she passed the exam with a good grade.''', '["But","However","Because","As a result"]', 3, '''As a result'' conecta adecuadamente la causa (estudiar mucho) con su consecuencia (aprobar con buena nota).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_7_basico' and lo.short_name = 'Uso de conectores para dar cohesión al texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Redacción de un correo o mensaje informal
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es un saludo adecuado para iniciar un correo informal en inglés?', '["Hi Sofía, how are you?","To Whom It May Concern,","Dear Sir/Madam,","Yours faithfully,"]', 0, '''Hi Sofía, how are you?'' es un saludo adecuado para un correo informal.', 'inicial', 25),
  ('¿Cuál es una despedida adecuada para un correo informal en inglés?', '["Yours faithfully,","See you soon! Take care.","Sincerely,","Best regards, Human Resources"]', 1, '''See you soon! Take care.'' es una despedida adecuada para un contexto informal.', 'intermedia', 30),
  ('¿Cuál oración es apropiada para el cuerpo de un mensaje informal invitando a un amigo a una fiesta?', '["We regret to inform you that the event has been cancelled.","Please find attached the requested documentation.","Hey, do you want to come to my birthday party on Saturday?","This is to formally request your attendance."]', 2, 'Esta oración usa un tono informal y directo adecuado para invitar a un amigo.', 'intermedia', 30),
  ('Debes escribir un correo informal completo a un amigo contándole que te mudaste de casa e invitándolo a visitarte. ¿Cuál estructura es la más adecuada?', '["Dear Sir, I am writing to inform you of my new address. Sincerely,","To Whom It May Concern: I have moved. Regards,","Hi Tomás! I just moved to a new house. You should come visit me soon! See you, Camila.","This letter serves to notify you of a change of address."]', 2, 'Esta opción usa un saludo informal, cuenta la noticia, invita al amigo y se despide de forma cercana, adecuada para un correo informal.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_7_basico' and lo.short_name = 'Redacción de un correo o mensaje informal'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Aplicación de reglas ortográficas básicas del inglés
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 7° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál palabra está escrita correctamente?', '["beautiful","beatiful","beutiful","beautifull"]', 0, '''Beautiful'' es la forma correctamente escrita de esta palabra frecuente.', 'inicial', 25),
  ('¿Cuál palabra está escrita correctamente?', '["diferent","different","differant","diffrent"]', 1, '''Different'' es la forma correctamente escrita de esta palabra.', 'intermedia', 30),
  ('¿Cuál palabra está escrita correctamente?', '["wich","whitch","which","wichh"]', 2, '''Which'' es la forma correctamente escrita de esta palabra.', 'intermedia', 30),
  ('Un estudiante escribió: ''I recieved a beatiful gift from my freind.'' ¿Cuál es la versión con la ortografía corregida?', '["I recieved a beautiful gift from my freind.","I received a beatiful gift from my friend.","I recieved a beautiful gift from my friend.","I received a beautiful gift from my friend."]', 3, 'La versión correcta corrige las tres palabras mal escritas: ''received'', ''beautiful'' y ''friend''.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_7_basico' and lo.short_name = 'Aplicación de reglas ortográficas básicas del inglés'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
