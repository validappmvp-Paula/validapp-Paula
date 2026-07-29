-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Idioma
-- Extranjero: Inglés, 8° Básico. Cubre los 16 objetivos de aprendizaje de 8°
-- Básico cargados por
-- supabase/seed/0024_curriculum_ingles_regular_7basico_2medio.sql (4 ejes:
-- Comprensión Auditiva, Comprensión Lectora, Expresión Oral, Expresión
-- Escrita), con 4 preguntas por objetivo, total 64 preguntas en este
-- archivo.
--
-- Mismo estado editorial, criterio de idioma (ver encabezado completo de
-- supabase/seed/0113_questions_ingles_regular_7basico.sql: mayor proporción
-- de inglés en estímulos y preguntas de contenido, español reservado para
-- preguntas ''meta''/metalingüísticas; nivel A2-B1), fuente, validación
-- mecánica e idempotencia que 0111-0113. `source` cita Decreto Supremo N.°
-- 614/2013. Seed SOLO local: no se ha ejecutado contra Supabase.

-- ============================================================================
-- EJE: COMPRENSIÓN AUDITIVA — 8° BÁSICO
-- ============================================================================

-- Objetivo: Comprensión de instrucciones y explicaciones más extensas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''First, read the instructions carefully. Then, answer each question in complete sentences, and finally, check your spelling before submitting.'' What is the first step mentioned?', '["Read the instructions carefully","Answer in complete sentences","Check your spelling","Submit the work"]', 0, 'The instructions state reading carefully is the first step.', 'inicial', 25),
  ('Escuchas una explicación extensa: ''To complete this project, you need to choose a topic, research at least three sources, and then organize your information before writing.'' ¿Cuál es el segundo paso mencionado?', '["Elegir un tema","Investigar al menos tres fuentes","Organizar la información","Escribir el proyecto"]', 1, 'El segundo paso mencionado es investigar al menos tres fuentes.', 'intermedia', 30),
  ('Listen: ''You should submit your assignment by Friday. If you need an extension, you must ask the teacher at least two days before the deadline.'' What must you do if you need more time?', '["Submit late without telling anyone","Ask the teacher at least two days before the deadline","Wait until Friday to ask","Submit nothing at all"]', 2, 'The explanation states you must ask the teacher at least two days before the deadline.', 'intermedia', 30),
  ('Listen to this extended explanation: ''To use the library, first get a student card. Then, search the catalog online. If the book is available, reserve it, and finally, pick it up within three days or the reservation expires.'' What happens if you don''t pick up the book within three days?', '["Nothing happens","You get a new library card automatically","The reservation expires","You must search the catalog again immediately"]', 2, 'The explanation clearly states the reservation expires if the book isn''t picked up within three days.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_8_basico' and lo.short_name = 'Comprensión de instrucciones y explicaciones más extensas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de la idea principal y detalles de apoyo
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''Recycling helps protect the environment. For example, it reduces waste in landfills and saves natural resources.'' ¿Cuál es la idea principal?', '["El reciclaje ayuda a proteger el medio ambiente","Los rellenos sanitarios son muy grandes","Los recursos naturales son ilimitados","No hay ninguna idea principal"]', 0, 'La idea principal es que el reciclaje ayuda a proteger el medio ambiente; el resto son detalles de apoyo.', 'inicial', 25),
  ('Listen: ''Exercise is important for health. It improves your mood, strengthens your muscles, and helps you sleep better.'' Which of these is a supporting detail, not the main idea?', '["Exercise is important for health","It strengthens your muscles","Exercise improves overall wellbeing","None of the above"]', 1, '''It strengthens your muscles'' is a supporting detail of the main idea about exercise being important for health.', 'intermedia', 30),
  ('Listen: ''Learning a new language takes time and practice. You need to study vocabulary, practice speaking, and be patient with mistakes.'' ¿Cuál detalle apoya la idea principal sobre aprender un idioma?', '["Aprender un idioma es fácil e inmediato","Se necesita practicar hablar","Los errores nunca ocurren al aprender","No se necesita estudiar vocabulario"]', 1, '''Practicar hablar'' es un detalle de apoyo de la idea principal sobre el tiempo y la práctica necesarios.', 'intermedia', 30),
  ('Listen: ''Social media can be useful, but it also has risks. It helps people stay connected, allows quick access to information, but can also cause stress and spread false information.'' What is the main idea, considering all the details mentioned?', '["Social media only has risks and no benefits","Social media only has benefits and no risks","Social media has both benefits and risks that should be considered","Social media is not related to stress at all"]', 2, 'El audio presenta tanto beneficios (conexión, información) como riesgos (estrés, desinformación), por lo que la idea principal es que tiene ambos aspectos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_8_basico' and lo.short_name = 'Identificación de la idea principal y detalles de apoyo'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de diálogos con distintos puntos de vista
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''A: I think we should recycle more at school. B: I agree, but it would need more trash cans around campus.'' What is B''s overall position?', '["B agrees with A but adds a condition","B completely disagrees with A","B doesn''t understand the topic","B changes the subject completely"]', 0, 'B agrees with A but adds a practical condition (more trash cans).', 'inicial', 25),
  ('Diálogo: ''A: Homework should be eliminated completely. B: I don''t think so; homework helps students practice what they learn.'' ¿Cuál es la postura de B?', '["Está de acuerdo con eliminar la tarea","Está en desacuerdo, porque la tarea ayuda a practicar","No tiene ninguna opinión","Cambia de tema"]', 1, 'B está en desacuerdo con A, argumentando que la tarea ayuda a practicar lo aprendido.', 'intermedia', 30),
  ('Listen: ''A: Uniforms make school more equal for everyone. B: Maybe, but they also limit self-expression.'' What kind of response does B give?', '["B completely agrees without conditions","B completely rejects A''s idea with no argument","B partially agrees but raises a counterpoint","B ignores A''s opinion entirely"]', 2, 'B partially acknowledges A''s point (''Maybe'') but raises a counterpoint about self-expression.', 'intermedia', 30),
  ('Listen: ''A: Video games are a waste of time. B: I disagree. Some games actually improve problem-solving skills, even if they shouldn''t replace other activities.'' How would you describe B''s argument?', '["B fully agrees with A without any nuance","B disagrees with A, but acknowledges a limit or balance","B has no opinion on the topic","B agrees that video games are always a waste of time"]', 1, 'B disagrees with A''s claim, but adds a nuance (''even if they shouldn''t replace other activities''), showing a balanced argument.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_8_basico' and lo.short_name = 'Comprensión de diálogos con distintos puntos de vista'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Reconocimiento de vocabulario de interés juvenil
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''I spend a lot of time on social media, especially watching short videos.'' ¿A qué tema de interés juvenil se refiere principalmente el audio?', '["Redes sociales y videos cortos","Historia antigua","Cocina tradicional","Meteorología"]', 0, 'El audio se refiere a redes sociales y videos cortos, un tema de interés juvenil.', 'inicial', 25),
  ('Listen: ''My favorite hobby is playing video games with my friends online.'' What topic of youth interest does this refer to?', '["Cooking","Video games","Gardening","Accounting"]', 1, 'The audio refers to video games, a common topic of youth interest.', 'intermedia', 30),
  ('Escuchas: ''I follow several influencers who talk about sustainable fashion and recycling clothes.'' ¿Qué combinación de temas de interés juvenil se mencionan?', '["Moda sostenible y reciclaje","Política internacional","Finanzas personales","Medicina"]', 2, 'El audio combina moda sostenible y reciclaje, temas de interés juvenil actuales.', 'intermedia', 30),
  ('Listen: ''Streaming platforms let you watch series, but some people prefer podcasts because you can listen while doing other things.'' What two forms of youth-relevant entertainment are compared in this audio?', '["Newspapers and magazines","Streaming series and podcasts","Live theater and radio","Board games and card games"]', 1, 'El audio compara plataformas de streaming (series) con podcasts, dos formas de entretenimiento de interés juvenil.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_8_basico' and lo.short_name = 'Reconocimiento de vocabulario de interés juvenil'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMPRENSIÓN LECTORA — 8° BÁSICO
-- ============================================================================

-- Objetivo: Comprensión de textos informativos breves
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Sharks have existed for more than 400 million years, even before dinosaurs.'' What is this text mainly about?', '["A fact about how long sharks have existed","A recipe using shark meat","A story about a shark attack","An opinion about sharks being dangerous"]', 0, 'El texto entrega un dato informativo sobre la antigüedad de los tiburones.', 'inicial', 25),
  ('Texto: ''El agua potable es un recurso limitado; solo un pequeño porcentaje del agua del planeta es apta para el consumo humano.'' ¿Cuál es la idea central de este texto informativo?', '["El agua potable es un recurso ilimitado","El agua potable es un recurso limitado","El planeta no tiene agua","Toda el agua del planeta es apta para consumo"]', 1, 'El texto informa que el agua potable es un recurso limitado.', 'intermedia', 30),
  ('Text: ''Recent research shows that teenagers need between eight and ten hours of sleep per night for healthy development.'' What type of text is this?', '["A fictional story","An informative text based on research","A poem","An advertisement"]', 1, 'El texto entrega información basada en investigación, característica de un texto informativo.', 'intermedia', 30),
  ('Text: ''According to a recent study, students who read for pleasure for at least twenty minutes daily show significant improvement in vocabulary and comprehension after six months.'' What specific evidence supports the claim in this text?', '["No evidence is given, it is just an opinion","A study showing improvement after six months of daily reading","A story about one student''s experience","A recommendation with no supporting data"]', 1, 'El texto cita un estudio específico con un resultado medido (mejora después de seis meses), lo que constituye evidencia concreta.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_8_basico' and lo.short_name = 'Comprensión de textos informativos breves'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Distinción entre hechos y opiniones en un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''The Earth revolves around the Sun.'' Is this a fact or an opinion?', '["A fact, because it can be scientifically verified","An opinion, because it depends on perspective","Neither a fact nor an opinion","A prediction about the future"]', 0, 'Es un hecho porque puede verificarse científicamente.', 'inicial', 25),
  ('Texto: ''El chocolate es el mejor postre del mundo.'' ¿Es un hecho o una opinión?', '["Un hecho medible","Una opinión, porque depende del gusto personal","Una instrucción","Una pregunta"]', 1, 'Es una opinión porque depende del gusto personal de cada persona.', 'intermedia', 30),
  ('Text: ''Chile is located in South America.'' Is this a fact or an opinion?', '["An opinion depending on perspective","A recipe","A fact, because it is a verifiable geographic location","A prediction"]', 2, 'Es un hecho geográfico verificable.', 'intermedia', 30),
  ('Text: ''Studies show that Chile has more than six million inhabitants in its capital region, which is, without a doubt, the most exciting place to live in the country.'' Which part of this sentence is a fact, and which part is an opinion?', '["Both parts are facts","Both parts are opinions","The population figure is an opinion; being the most exciting place is a fact","The population figure is a fact; being ''the most exciting place to live'' is an opinion"]', 3, 'La cifra de población es un dato verificable (hecho), mientras que calificarlo como ''el lugar más emocionante'' es un juicio personal (opinión).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_8_basico' and lo.short_name = 'Distinción entre hechos y opiniones en un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de la estructura de un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Introduction: Climate change is a global issue. Development: It causes rising temperatures and extreme weather. Conclusion: We must act now.'' What structure does this text follow?', '["Introduction, development, and conclusion","Only a conclusion","A list with no structure","A dialogue between two people"]', 0, 'El texto sigue claramente la estructura de introducción, desarrollo y conclusión.', 'inicial', 25),
  ('¿Cuál de estos elementos corresponde típicamente a la introducción de un texto informativo?', '["Una conclusión final con recomendaciones","La presentación general del tema","El detalle más técnico y específico","Una opinión personal del lector"]', 1, 'La introducción presenta el tema de forma general antes de profundizar en el desarrollo.', 'intermedia', 30),
  ('Text: ''Many people think technology only distracts students. However, technology can also support learning when used correctly. In fact, tools like educational apps have shown positive results.'' What structural element does the word ''however'' signal in this text?', '["The beginning of the introduction","A change or contrast in the argument","The end of the conclusion","A completely unrelated new topic"]', 1, '''However'' señala un cambio o contraste dentro del desarrollo del argumento.', 'intermedia', 30),
  ('Text: ''Introduction: Many students struggle with time management. Development: This section explains three common causes: procrastination, lack of planning, and distractions. Conclusion: By addressing these causes, students can improve their study habits.'' Given this structure, what would you expect to find in the development section specifically?', '["Solo una opinión personal sin ejemplos","Una lista y explicación de las tres causas mencionadas","Un resumen de la introducción repetido","Ninguna información adicional"]', 1, 'El desarrollo típicamente profundiza y explica los elementos anunciados, en este caso las tres causas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_8_basico' and lo.short_name = 'Identificación de la estructura de un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso del diccionario y contexto para ampliar vocabulario
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si no conoces la palabra ''enormous'' en un texto, ¿qué estrategia es más útil para ampliar tu vocabulario?', '["Buscarla en el diccionario y anotar su significado","Ignorarla completamente para siempre","Inventar un significado sin verificar","Dejar de leer el texto"]', 0, 'Buscar la palabra en el diccionario y anotarla es una estrategia efectiva para ampliar el vocabulario.', 'inicial', 25),
  ('Text: ''The ancient castle was in ruins, with crumbling walls and a collapsed roof.'' Using context, what does ''crumbling'' most likely mean?', '["Recently painted","Breaking apart or falling into pieces","Extremely modern","Perfectly maintained"]', 1, 'El contexto de ''ruinas'' y ''techo colapsado'' indica que ''crumbling'' significa desmoronarse o caerse a pedazos.', 'intermedia', 30),
  ('Al buscar una palabra nueva en el diccionario, ¿qué información adicional es útil registrar para ampliar el vocabulario de forma efectiva?', '["Solo el número de letras que tiene","Un ejemplo de uso en una oración","El color con el que se asocia","La cantidad de vocales que tiene"]', 2, 'Registrar un ejemplo de uso ayuda a comprender mejor el significado y a recordarlo en contexto.', 'intermedia', 30),
  ('Text: ''The company''s profits plummeted after the scandal, leaving investors worried about the future.'' Sin usar el diccionario, ¿qué te permite inferir el contexto sobre el significado de ''plummeted''?', '["Que las ganancias aumentaron mucho","Que las ganancias cayeron drásticamente","Que las ganancias se mantuvieron iguales","Que no hay ninguna relación con las ganancias"]', 1, 'El contexto (escándalo, inversionistas preocupados) permite inferir que ''plummeted'' significa que las ganancias cayeron drásticamente.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_8_basico' and lo.short_name = 'Uso del diccionario y contexto para ampliar vocabulario'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ORAL — 8° BÁSICO
-- ============================================================================

-- Objetivo: Exposición oral breve sobre un tema conocido
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración es adecuada para iniciar una exposición oral sobre un tema conocido?', '["Today, I am going to talk about recycling and why it matters.","Recycling is boring, let''s talk about something else.","I don''t know what to say about this topic.","Recycling, yes, no, maybe."]', 0, 'Esta oración presenta claramente el tema de la exposición, un inicio adecuado.', 'inicial', 25),
  ('¿Qué recurso es recomendable usar durante una exposición oral breve sobre un tema conocido?', '["Leer directamente de un texto sin mirar al público","Usar apoyo visual simple, como imágenes o palabras clave","No preparar nada con anticipación","Hablar lo más rápido posible sin pausas"]', 1, 'Usar apoyo visual simple ayuda a organizar y comunicar mejor la exposición.', 'intermedia', 30),
  ('¿Cuál oración es adecuada para cerrar una exposición oral breve?', '["That''s all, I don''t have anything else to add, bye.","In summary, recycling helps protect our environment for future generations.","I forgot what I wanted to say.","Recycling, recycling, recycling."]', 1, 'Esta oración cierra la exposición con un resumen claro de la idea principal.', 'intermedia', 30),
  ('Debes preparar una exposición oral breve y organizada sobre el reciclaje, con introducción, desarrollo y cierre. ¿Cuál secuencia de tres oraciones cumple mejor esta estructura?', '["Recycling is good. I like recycling. The end.","Today I will talk about recycling. It helps reduce waste and save resources. In conclusion, we should all recycle more.","Recycling, waste, resources, conclusion, recycling again.","I don''t want to talk about recycling today."]', 1, 'Esta secuencia presenta claramente introducción, desarrollo (beneficios) y cierre (conclusión), cumpliendo la estructura esperada.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_8_basico' and lo.short_name = 'Exposición oral breve sobre un tema conocido'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comparación oral de ideas o situaciones
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración usa correctamente un comparativo?', '["This book is more interesting than that one.","This book is interesting than that one.","This book interesting more that one.","This book most interesting that one."]', 0, '''More interesting than'' es la forma correcta del comparativo con adjetivos largos.', 'inicial', 25),
  ('¿Cuál oración usa correctamente un superlativo?', '["This is the more difficult exam of the year.","This is the most difficult exam of the year.","This is difficult exam most of the year.","This is the difficultest exam of the year."]', 1, '''The most difficult'' es la forma correcta del superlativo con adjetivos largos.', 'intermedia', 30),
  ('¿Cuál oración compara correctamente dos situaciones usando ''as...as''?', '["This test is as difficult that the last one.","This test is difficult as the last one.","This test is as difficult as the last one.","This test is more as difficult the last one."]', 2, '''As difficult as'' es la estructura correcta para comparar igualdad.', 'intermedia', 30),
  ('Debes comparar oralmente dos situaciones: estudiar en la mañana versus estudiar en la noche, indicando cuál prefieres y por qué. ¿Cuál oración cumple mejor con una comparación clara y una justificación?', '["Morning, night, studying, good.","I study. Morning is a word. Night is a word too.","Studying in the morning is more effective for me than studying at night, because I concentrate better after resting.","I don''t know which is better, both are the same probably maybe."]', 2, 'Esta oración compara claramente ambas opciones usando un comparativo y justifica la preferencia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_8_basico' and lo.short_name = 'Comparación oral de ideas o situaciones'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Expresión de acuerdo y desacuerdo
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál expresión se usa para mostrar acuerdo con una idea?', '["I completely agree with that.","I don''t think so at all.","That''s not true.","I disagree completely."]', 0, '''I completely agree with that'' expresa acuerdo con una idea.', 'inicial', 25),
  ('¿Cuál expresión se usa para mostrar desacuerdo de forma respetuosa?', '["That''s a great idea!","I see your point, but I don''t fully agree.","You are completely wrong.","I don''t care what you think."]', 1, '''I see your point, but I don''t fully agree'' muestra desacuerdo de forma respetuosa.', 'intermedia', 30),
  ('Si alguien dice ''Homework should be banned'' y tú piensas lo contrario, ¿cuál es una respuesta adecuada?', '["Yes, totally, homework is useless.","I understand your view, but I think homework helps students practice.","I don''t want to talk about this.","Homework, homework, homework."]', 1, 'Esta respuesta reconoce el punto de vista del otro y expresa un desacuerdo argumentado.', 'intermedia', 30),
  ('En un debate, un compañero dice: ''I think uniforms are unnecessary.'' Tú estás parcialmente de acuerdo, pero también ves un beneficio en los uniformes. ¿Cuál respuesta expresa mejor este acuerdo parcial?', '["I completely agree, uniforms are useless.","I completely disagree, uniforms are perfect.","I partially agree, but I think uniforms also help create a sense of equality among students.","I don''t have any opinion about this topic."]', 2, 'Esta respuesta muestra un acuerdo parcial y agrega un matiz o contraargumento, reflejando una postura equilibrada.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_8_basico' and lo.short_name = 'Expresión de acuerdo y desacuerdo'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de un registro adecuado a la situación
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si le hablas a tu profesor, ¿cuál saludo es más adecuado en cuanto a registro?', '["Good morning, Mr. Pérez.","Hey dude, what''s up?","Yo, what''s going on?","Sup, teacher?"]', 0, '''Good morning, Mr. Pérez'' usa un registro formal adecuado para hablarle a un profesor.', 'inicial', 25),
  ('Si le hablas a un amigo cercano, ¿cuál saludo es más adecuado en cuanto a registro?', '["Good afternoon, sir.","Hey, what''s up?","Dear Sir or Madam,","To whom it may concern,"]', 1, '''Hey, what''s up?'' es adecuado para un registro informal entre amigos.', 'intermedia', 30),
  ('¿Cuál oración usa un registro formal adecuado para una presentación ante autoridades del colegio?', '["Hey guys, listen up!","What''s up, everyone?","Good morning, and thank you for the opportunity to present today.","Yo, check this out."]', 2, 'Esta oración usa un registro formal adecuado para dirigirse a autoridades.', 'intermedia', 30),
  ('Debes adaptar tu registro según la audiencia: hablas primero con tu mejor amigo y luego con el director del colegio sobre el mismo tema (un proyecto escolar). ¿Cuál par de expresiones refleja mejor esta adaptación de registro?', '["Hey, check out my project! / Hey, check out my project!","Good morning, Director. / Good morning, Director.","Yo, my project is cool! / Good morning, Director, I would like to present my project.","Good morning, Director. / Yo, check this out."]', 2, 'La primera expresión usa un registro informal apropiado para un amigo, y la segunda un registro formal apropiado para el director.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_8_basico' and lo.short_name = 'Uso de un registro adecuado a la situación'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ESCRITA — 8° BÁSICO
-- ============================================================================

-- Objetivo: Redacción de un texto informativo breve
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración es adecuada para iniciar un texto informativo breve?', '["Bees play an important role in pollinating plants around the world.","I don''t like bees at all.","Bees, bees, bees, they are insects.","Once upon a time, there was a bee."]', 0, 'Esta oración presenta un dato objetivo, adecuado para iniciar un texto informativo.', 'inicial', 25),
  ('¿Cuál oración da un ejemplo adecuado para apoyar la idea de que ''el ejercicio es importante para la salud''?', '["El ejercicio es aburrido para todos.","Por ejemplo, caminar 30 minutos al día reduce el riesgo de enfermedades cardíacas.","No me gusta hacer ejercicio.","El ejercicio no tiene ninguna relación con la salud."]', 1, 'Esta oración entrega un ejemplo concreto y basado en evidencia que apoya la idea principal.', 'intermedia', 30),
  ('¿Cuál oración es adecuada para el cierre de un texto informativo sobre el reciclaje?', '["In conclusion, recycling is an important habit that benefits the environment.","Recycling, the end, goodbye.","I don''t want to recycle anymore.","Recycling is a word with nine letters."]', 0, 'Esta oración cierra el texto con una conclusión clara relacionada con el tema.', 'intermedia', 30),
  ('Debes redactar un texto informativo breve con introducción, un dato de apoyo y una conclusión, sobre el reciclaje. ¿Cuál secuencia de tres oraciones cumple mejor esta estructura?', '["Recycling is good. I like recycling. Recycling is good again.","Recycling helps reduce waste. For example, recycling one ton of paper saves about 17 trees. In conclusion, recycling benefits the environment significantly.","I don''t know about recycling. Maybe it''s good. The end.","Recycling, trees, environment, conclusion, recycling."]', 1, 'Esta secuencia presenta una introducción, un dato de apoyo concreto (17 árboles) y una conclusión clara.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_8_basico' and lo.short_name = 'Redacción de un texto informativo breve'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de comparativos y superlativos en la escritura
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración usa correctamente el comparativo de un adjetivo corto?', '["This city is bigger than the last one.","This city is more big than the last one.","This city is biggest than the last one.","This city is big than the last one."]', 0, '''Bigger'' es la forma correcta del comparativo de adjetivos cortos como ''big''.', 'inicial', 25),
  ('¿Cuál oración usa correctamente el superlativo de un adjetivo corto?', '["This is the more tall building in the city.","This is the tallest building in the city.","This is the most tall building in the city.","This is tallest the building in the city."]', 1, '''The tallest'' es la forma correcta del superlativo de adjetivos cortos como ''tall''.', 'intermedia', 30),
  ('¿Cuál oración usa correctamente el comparativo irregular de ''good''?', '["This restaurant is gooder than the other one.","This restaurant is more good than the other one.","This restaurant is better than the other one.","This restaurant is bestest than the other one."]', 2, '''Better'' es la forma comparativa irregular correcta de ''good''.', 'intermedia', 30),
  ('Debes escribir una oración comparando tres ciudades según su tamaño (grande, más grande, la más grande). ¿Cuál oración usa correctamente los tres grados de comparación?', '["Santiago is big, Valparaíso is bigger, but Concepción is the more big of all.","Santiago is big, Valparaíso is more bigger, but Concepción is the biggest of all.","Santiago is big, Valparaíso is bigger, but Concepción is the biggest of all.","Santiago is bigger, Valparaíso is big, but Concepción is more biggest of all."]', 2, 'Esta oración usa correctamente el positivo (big), comparativo (bigger) y superlativo (the biggest).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_8_basico' and lo.short_name = 'Uso de comparativos y superlativos en la escritura'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Planificación previa a la escritura de un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Antes de escribir un texto, ¿qué acción corresponde a la etapa de planificación?', '["Organizar las ideas principales antes de comenzar a escribir","Revisar la ortografía del texto ya terminado","Publicar el texto sin revisarlo","Borrar el texto completo sin planificar"]', 0, 'Organizar las ideas principales antes de escribir corresponde a la etapa de planificación.', 'inicial', 25),
  ('¿Cuál herramienta es útil durante la planificación de un texto?', '["Un diccionario de sinónimos avanzados","Un esquema o lista con las ideas principales que se van a desarrollar","Un corrector ortográfico automático","Una impresora"]', 1, 'Un esquema o lista de ideas principales es una herramienta típica de planificación.', 'intermedia', 30),
  ('Si vas a escribir un texto sobre ''los beneficios del deporte'', ¿qué deberías hacer primero durante la planificación?', '["Escribir la conclusión antes que todo lo demás","Corregir la ortografía de una versión que aún no existe","Listar los beneficios principales que vas a mencionar","Publicar el texto sin escribirlo"]', 2, 'Listar los beneficios principales antes de escribir es parte esencial de la planificación.', 'intermedia', 30),
  ('Debes planificar un texto informativo sobre el cuidado del medio ambiente antes de escribirlo. ¿Cuál de estas acciones corresponde correctamente a la etapa de planificación, y no a la escritura o revisión final?', '["Corregir errores ortográficos del texto ya escrito","Hacer una lista de las ideas principales y el orden en que se presentarán","Publicar el texto en la plataforma del colegio","Leer el texto en voz alta para revisar la fluidez"]', 1, 'Hacer una lista de ideas principales y su orden corresponde a la planificación, antes de escribir o revisar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_8_basico' and lo.short_name = 'Planificación previa a la escritura de un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Revisión y corrección de un texto propio
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 8° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al revisar tu propio texto, ¿qué acción corresponde hacer?', '["Buscar y corregir errores de ortografía y gramática","Escribir el texto por primera vez","Planificar las ideas antes de escribir","Borrar el texto sin revisarlo"]', 0, 'Buscar y corregir errores es la acción propia de la etapa de revisión.', 'inicial', 25),
  ('Un estudiante escribió: ''She go to school every day.'' ¿Cuál es la corrección adecuada tras revisar esta oración?', '["She go to school every days.","She goes to school every day.","She going to school every day.","She gos to school every day."]', 1, '''She goes'' corrige el error de concordancia verbal en tercera persona del presente simple.', 'intermedia', 30),
  ('Al revisar un texto propio, ¿qué criterio es importante verificar además de la ortografía?', '["El color del cuaderno usado","Que las ideas estén conectadas de forma coherente","La cantidad de páginas escritas","El tipo de lápiz utilizado"]', 2, 'Verificar la coherencia de las ideas es un criterio importante en la revisión, además de la ortografía.', 'intermedia', 30),
  ('Un estudiante escribió: ''Yesterday I go to the park and I plays with my friends, it were very funny.'' Al revisar y corregir este texto, ¿cuál versión corrige correctamente todos los errores?', '["Yesterday I go to the park and I played with my friends, it were very funny.","Yesterday I went to the park and I played with my friends, it was very fun.","Yesterday I went to the park and I plays with my friends, it were very funny.","Yesterday I go to the park and I play with my friends, it was very funny."]', 1, 'La versión correcta corrige el tiempo verbal (went, played), la concordancia (it was) y el uso de ''fun'' en vez de ''funny'' para describir la experiencia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_8_basico' and lo.short_name = 'Revisión y corrección de un texto propio'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
