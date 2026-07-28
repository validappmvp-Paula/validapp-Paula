-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Lengua
-- Castellana y Comunicación (denominación oficial de esta banda: "Lenguaje y
-- Comunicación", ver supabase/seed/0014), 1° Básico. Cubre los
-- 13 objetivos de aprendizaje de 1° Básico cargados por
-- supabase/seed/0014_curriculum_lenguaje_regular_basica_1_6.sql (3 ejes:
-- Lectura, Escritura, Comunicación Oral), con 4 preguntas por objetivo
-- (dentro del rango 3-5 pedido), total 52 preguntas en este archivo.
--
-- ============================================================================
-- ESTADO EDITORIAL Y DE VALIDACIÓN (léase antes de aprobar cualquier fila)
-- ============================================================================
-- Mismo patrón que el banco de Matemática (supabase/seed/0026-0031/0050-0051/
-- 0060-0063): `review_status = 'borrador'`, `validation_status =
-- 'ai_generated_review_required'` (no 'unverified' -- ver justificación
-- completa en el encabezado de 0026_questions_matematica_regular_1basico.sql,
-- misma razón aplica aquí sin repetirla íntegra), `is_active = true`,
-- `source_type = 'validapp_original'`, `generated_by = 'claude-sonnet-5'`.
-- Ninguna fila cumple `validation_status = 'approved_for_exam'` +
-- `review_status = 'aprobado'`, por lo que ninguna pregunta de este archivo
-- es usable todavía en un ensayo o diagnóstico real
-- (`get_diagnostic_questions`, `lib/data/essays.ts`). Requieren revisión
-- pedagógica humana antes de cualquier cambio de estado (y ese cambio, por
-- el trigger `questions_prevent_ai_self_approval` de 0023, solo lo puede
-- hacer un administrador real, nunca un agente).
--
-- ============================================================================
-- FORMATO DE PREGUNTA SEGÚN TIPO DE CONTENIDO (decisión de diseño)
-- ============================================================================
-- A diferencia de Matemática, las preguntas de Lenguaje NO se fuerzan a un
-- único formato de "cálculo". Se usan 3 estilos, según lo que evalúa cada
-- objetivo:
--   - Comprensión lectora (eje Lectura, especialmente "extraer información
--     explícita/implícita", inferencias, hecho/opinión, etc.): el estímulo
--     es un fragmento breve (1-3 oraciones) de redacción ORIGINAL ValidApp,
--     embebido directamente al inicio del `prompt` (p. ej. "Texto: '...'
--     Pregunta: ..."). Se decidió NO usar `question_stimuli`/`stimulus_id`
--     (tabla creada por 0023_question_generation_pipeline.sql para
--     estímulos compartidos por varias preguntas): en este banco cada
--     objetivo tiene su propio fragmento corto y no hay reutilización real
--     entre preguntas distintas, por lo que separar el estímulo en una tabla
--     aparte habría agregado complejidad sin beneficio en esta primera
--     versión. `resource_url` (pensada para adjuntar un recurso externo,
--     p. ej. una imagen) y `explanation` (retroalimentación que se muestra
--     DESPUÉS de responder, no el estímulo de lectura) no son apropiadas
--     para este propósito -- se revisó el esquema real
--     (`supabase/migrations/0011_question_bank_expansion.sql`,
--     `0023_question_generation_pipeline.sql`) antes de decidir esto.
--     Si más adelante se generan muchas preguntas sobre el MISMO texto largo
--     compartido, se recomienda migrar a `question_stimuli` -- eso
--     requeriría coordinar con /validapp-db si implica cambios de esquema
--     adicionales.
--   - Gramática, ortografía y acentuación (eje Escritura): preguntas de
--     corrección o identificación directa (p. ej. "¿cuál palabra está bien
--     escrita?", "¿qué falta en esta oración?").
--   - Figuras literarias y recursos del lenguaje (eje Lectura en cursos
--     superiores): identificación e interpretación de metáforas,
--     personificaciones, hipérboles, en frases u oraciones breves.
--   - Comunicación oral (eje Comunicación Oral): preguntas situacionales
--     sobre normas de comunicación (turnos de habla, registro, escucha
--     activa, debate, exposición), no cálculo ni gramática.
--
-- ============================================================================
-- FUENTE Y NIVEL DE CONFIANZA
-- ============================================================================
-- Los enunciados son redacción ORIGINAL de ValidApp (no citas de MINEDUC),
-- escritos para evaluar el objetivo de aprendizaje correspondiente (ver
-- `curricular_source`/`pedagogical_notes` del objetivo en 0014). Los
-- distractores buscan representar errores conceptuales o de comprensión
-- típicos del nivel (p. ej. confundir hecho con opinión, no identificar el
-- personaje principal, aplicar mal una regla ortográfica común), no
-- opciones absurdas. Ningún distractor depende de estereotipos ni de
-- vocabulario fuera del nivel. `framework_id` y `source_id` quedan NULL
-- (mismo motivo que Matemática: el Currículum Regular no usa
-- `curriculum_frameworks`, y no se creó una fila en `content_sources` para
-- esta tarea). `content_hash` queda NULL: se recomienda calcularlo con
-- `computeContentHash` (`lib/data/question-validators.ts`) en un paso
-- posterior antes de aprobar cualquier fila.
--
-- ============================================================================
-- VALIDACIÓN MECÁNICA REALIZADA (por este agente, antes de este commit)
-- ============================================================================
-- Se escribió un script Node que replica exactamente
-- `normalizeForComparison`, `computeContentHash`, `textSimilarity` y
-- `validateQuestion` de `lib/data/question-validators.ts`, y se corrió
-- contra las 312 preguntas de los 78 objetivos de este banco (6 archivos:
-- 0080-0085). Resultado: 0 errores bloqueantes (alternativas duplicadas,
-- índice de respuesta inválido, alternativas vacías, "todas/ninguna de las
-- anteriores", enunciado demasiado corto, vínculo curricular roto) y 0
-- preguntas duplicadas/casi-duplicadas (exactas o por similitud de Jaccard
-- >= 0.7) dentro de un mismo objetivo o entre objetivos distintos. Se
-- detectaron y corrigieron 3 errores de alternativas duplicadas antes de
-- generar este SQL (ver historial de la sesión). Se detectaron 78 warnings
-- no bloqueantes (heurísticas blandas de `question-validators.ts`:
-- `length_hint` y `answer_leaked_in_prompt`) -- la mayoría son falsos
-- positivos legítimos documentados en el propio validador: en preguntas de
-- "extraer información explícita" de un texto, es esperable y correcto que
-- la respuesta correcta aparezca literalmente en el fragmento leído; en
-- preguntas de definición/concepto, es esperable que la alternativa
-- correcta (una definición completa) sea más larga que distractores de una
-- sola palabra. Se revisaron manualmente y no se identificó ningún caso que
-- filtrara la respuesta de forma no pedagógica. Además, se corrigió
-- explícitamente el patrón "la respuesta correcta siempre es la alternativa
-- A": la posición de la respuesta correcta se rotó de forma determinística
-- (round-robin) para las 312 preguntas, quedando 78 preguntas con respuesta
-- correcta en cada una de las 4 posiciones.
--
-- ============================================================================
-- IDEMPOTENCIA
-- ============================================================================
-- Mismo patrón que Matemática: cada INSERT ... SELECT filtra con
-- `where not exists (select 1 from questions q2 where q2.learning_objective_id
-- = lo.id and q2.prompt = v.prompt)`. `learning_objective_id` se resuelve
-- siempre por (subject.name, strand.name, level.code,
-- learning_objective.short_name) -- nunca por id hardcodeado.
--
-- Seed SOLO local: NO se ha ejecutado contra ningún proyecto Supabase (ni
-- dev ni producción). No modifica Supabase por sí solo.

-- ============================================================================
-- EJE: LECTURA — 1° BÁSICO
-- ============================================================================

-- Objetivo: Conciencia fonológica
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Con qué sonido inicial comienza la palabra ''mesa''?', '["m","s","e","t"]', 0, 'La palabra ''mesa'' comienza con el sonido /m/.', 'inicial', 25),
  ('¿Cuántas sílabas tiene la palabra ''zapato''?', '["1","3","2","4"]', 1, '''Za-pa-to'' tiene 3 sílabas.', 'intermedia', 35),
  ('¿Cuál de estas palabras termina con el mismo sonido final que ''pan''?', '["silla","mesa","tren","casa"]', 2, '''Pan'' y ''tren'' terminan ambas con el sonido /n/; las otras opciones terminan en /a/.', 'intermedia', 35),
  ('¿Cuál de estas palabras NO comparte el sonido inicial con ''sol'', ''sapo'' y ''silla''?', '["sopa","seis","sala","luna"]', 3, '''Sol'', ''sapo'', ''silla'', ''sopa'', ''seis'' y ''sala'' comienzan con el sonido /s/; ''luna'' comienza con /l/.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_1_basico' and lo.short_name = 'Conciencia fonológica'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Principio alfabético
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué letra representa el sonido inicial /m/ en la palabra ''mano''?', '["m","n","p","b"]', 0, 'El sonido /m/ al inicio de ''mano'' se representa con la letra ''m''.', 'inicial', 25),
  ('Al leer la palabra ''sapo'', ¿qué letra corresponde al último sonido?', '["s","o","a","p"]', 1, 'La palabra ''sapo'' termina con la letra y el sonido ''o''.', 'intermedia', 35),
  ('¿Cuál palabra se forma al unir los sonidos /s/-/o/-/l/?', '["sal","sil","sol","los"]', 2, 'Unir los sonidos /s/, /o/ y /l/ en ese orden forma la palabra ''sol''.', 'intermedia', 35),
  ('Si cambias la primera letra de ''pato'' por ''g'', ¿qué palabra nueva se forma?', '["pato","goto","pito","gato"]', 3, 'Reemplazando la ''p'' inicial de ''pato'' por ''g'' se obtiene la palabra ''gato''.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_1_basico' and lo.short_name = 'Principio alfabético'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Lectura de palabras y oraciones simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas secuencias de palabras forma una oración con sentido completo?', '["El perro corre en el patio.","corre el patio en","perro el corre","en patio corre el"]', 0, '''El perro corre en el patio.'' es la única secuencia con un orden de palabras que forma una oración con sentido.', 'inicial', 25),
  ('Lee la oración: ''La niña lee un cuento.'' ¿Quién realiza la acción de leer?', '["Lee","La niña","El cuento","Un cuento"]', 1, 'El sujeto que realiza la acción de leer es ''la niña''.', 'intermedia', 35),
  ('¿Cuál de estas palabras se lee con dos sílabas?', '["pan","luz","gato","sol"]', 2, '''Ga-to'' tiene dos sílabas; ''sol'', ''pan'' y ''luz'' tienen una sola sílaba.', 'intermedia', 35),
  ('Lee la oración: ''El gato duerme sobre la silla azul.'' ¿Dónde duerme el gato?', '["En el suelo","Bajo la mesa","En la cama","Sobre la silla azul"]', 3, 'El texto indica explícitamente que el gato duerme sobre la silla azul.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_1_basico' and lo.short_name = 'Lectura de palabras y oraciones simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de textos escuchados y leídos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''Tomás tiene un perro llamado Toby. Toby es café y le gusta jugar con la pelota.'' ¿De qué color es Toby?', '["Café","Negro","Blanco","Gris"]', 0, 'El texto dice explícitamente que Toby es café.', 'inicial', 25),
  ('Texto: ''Marta fue al parque con su mamá. Vieron patos nadando en la laguna.'' ¿A dónde fue Marta?', '["A la playa","Al parque","A la escuela","Al supermercado"]', 1, 'El texto indica que Marta fue al parque con su mamá.', 'intermedia', 35),
  ('Texto: ''Las nubes están muy oscuras y el viento sopla fuerte.'' Según el texto, ¿qué es lo más probable que pase pronto?', '["Que haga mucho calor","Que nieve en la playa","Que llueva","Que salga el sol"]', 2, 'Nubes oscuras y viento fuerte permiten predecir que probablemente lloverá.', 'intermedia', 35),
  ('Texto: ''Sofía riega las plantas todas las mañanas antes de ir al colegio.'' ¿Cuándo riega Sofía las plantas?', '["Todas las noches","Solo los fines de semana","Después del colegio","Todas las mañanas, antes del colegio"]', 3, 'El texto dice explícitamente que Sofía riega las plantas todas las mañanas, antes de ir al colegio.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_1_basico' and lo.short_name = 'Comprensión de textos escuchados y leídos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Estrategias de comprensión con apoyo
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Antes de leer un cuento llamado ''El pajarito perdido'', ¿qué estrategia es útil aplicar?', '["Predecir de qué tratará el cuento a partir del título","Memorizar el cuento completo antes de leerlo","Cerrar el libro sin leerlo","Copiar el título muchas veces"]', 0, 'Predecir a partir del título es una estrategia de comprensión previa a la lectura.', 'inicial', 25),
  ('Después de leer un cuento, ¿qué actividad ayuda a recapitular lo leído?', '["Leer otro cuento distinto sin relacionarlo","Contar con tus palabras lo que pasó en el cuento","Dibujar algo que no aparece en el cuento","Olvidar el cuento"]', 1, 'Recapitular con tus propias palabras ayuda a consolidar la comprensión del cuento leído.', 'intermedia', 35),
  ('Mientras lees un texto, ¿qué estrategia sirve para verificar si estás comprendiendo?', '["Saltarte párrafos difíciles sin volver a ellos","Dejar de leer inmediatamente","Detenerte y preguntarte si lo que leíste tiene sentido","Leer cada vez más rápido sin detenerte"]', 2, 'Detenerse a verificar la comprensión durante la lectura es una estrategia recomendada.', 'intermedia', 35),
  ('Un estudiante predijo que un cuento trataría sobre un perro, pero al leerlo descubre que trata sobre un gato. ¿Qué debería hacer?', '["Seguir pensando que el cuento es sobre un perro","Dejar de leer el cuento","Decir que el cuento está mal escrito","Ajustar su predicción según la nueva información del texto"]', 3, 'Una buena estrategia de comprensión es ajustar las predicciones cuando el texto entrega nueva información.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_1_basico' and lo.short_name = 'Estrategias de comprensión con apoyo'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: ESCRITURA — 1° BÁSICO
-- ============================================================================

-- Objetivo: Escritura de letras, sílabas y palabras
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es la forma correcta de escribir la sílaba que suena /ma/?', '["ma","am","na","ay"]', 0, 'La sílaba que suena /ma/ se escribe ''ma''.', 'inicial', 25),
  ('Al escribir la palabra ''sol'', ¿cuántas letras se deben usar?', '["5","3","2","4"]', 1, 'La palabra ''sol'' tiene 3 letras: s, o, l.', 'intermedia', 35),
  ('¿Cuál es la sílaba inicial de la palabra ''casa''?', '["ac","as","ca","sa"]', 2, 'La palabra ''casa'' se divide en las sílabas ''ca-sa''; la primera es ''ca''.', 'intermedia', 35),
  ('Ordena las sílabas ''pa'' y ''to'' en el orden correcto para formar la palabra ''pato''.', '["to - pa","pa - pa","to - to","pa - to"]', 3, 'El orden ''pa-to'' forma la palabra ''pato''; los demás órdenes no forman esa palabra.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_1_basico' and lo.short_name = 'Escritura de letras, sílabas y palabras'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Oraciones simples con convenciones básicas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas oraciones cumple con las convenciones de mayúscula inicial y punto final?', '["El sol brilla.","las nubes se mueven","El viento sopla","la lluvia moja el suelo."]', 0, '''El sol brilla.'' es la única que comienza con mayúscula y termina con punto; las demás omiten la mayúscula inicial, el punto final, o ambos.', 'inicial', 25),
  ('¿Qué falta en esta oración: ''la niña juega en el parque''?', '["Nada, está completa","Mayúscula inicial y punto final","Solo un punto final","Solo una mayúscula al final"]', 1, 'A la oración le falta la mayúscula al inicio y el punto al final.', 'intermedia', 35),
  ('¿Cuál de estas palabras debe escribirse con mayúscula por ser un nombre propio?', '["mesa","auto","Camila","perro"]', 2, '''Camila'' es un nombre propio y debe escribirse con mayúscula inicial.', 'intermedia', 35),
  ('Corrige esta oración: ''mi gato duerme mucho''. ¿Cuál de estas opciones aplica correctamente mayúscula inicial y punto final?', '["mi perro corre rápido","El pájaro vuela alto","la luna brilla mucho.","Mi gato duerme mucho."]', 3, '''Mi gato duerme mucho.'' es la única opción que cumple ambas convenciones: mayúscula inicial y punto final.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_1_basico' and lo.short_name = 'Oraciones simples con convenciones básicas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Producción de textos breves guiados
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Vas a escribir una tarjeta de cumpleaños para un amigo. ¿Cuál es un buen inicio para el mensaje?', '["¡Feliz cumpleaños, Diego!","La tarea de matemáticas","El clima de hoy","Instrucciones para armar un juguete"]', 0, 'Un mensaje de cumpleaños debe felicitar a la persona, coherente con el propósito de la tarjeta.', 'inicial', 25),
  ('¿Cuál de estos textos breves es un mensaje adecuado para invitar a alguien a tu casa?', '["Dos más dos es cuatro.","Te invito a mi casa el sábado a las 4.","El gato es un animal.","Las plantas necesitan agua."]', 1, '''Te invito a mi casa el sábado a las 4.'' es el único mensaje que cumple el propósito de invitar a alguien a un lugar.', 'intermedia', 35),
  ('Al escribir una tarjeta para tu mamá, ¿qué idea es más apropiada incluir?', '["Un reporte del clima","Una receta de cocina","Un mensaje cariñoso para ella","Una lista de tareas escolares"]', 2, 'Una tarjeta para la mamá busca expresar cariño, no informar datos ajenos al propósito.', 'intermedia', 35),
  ('Escribes un mensaje breve para avisar que llegarás tarde a una junta de amigos. ¿Cuál mensaje comunica esa idea de forma clara?', '["Me gusta mucho jugar fútbol.","El cielo está nublado hoy.","Mi comida favorita es la pizza.","Llegaré un poco más tarde a la junta."]', 3, '''Llegaré un poco más tarde a la junta.'' es el único mensaje que comunica con claridad la idea de llegar tarde.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_1_basico' and lo.short_name = 'Producción de textos breves guiados'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Revisión de textos propios con ayuda
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Después de escribir un texto, ¿qué debes hacer para revisarlo?', '["Releerlo para buscar errores","Botarlo a la basura","Copiarlo tal cual sin mirarlo","Pedirle a otro que lo escriba de nuevo"]', 0, 'Releer el texto propio permite identificar errores para corregirlos.', 'inicial', 25),
  ('En el texto ''el perro ladra fuerte'', ¿qué error se debe corregir?', '["Está mal escrita la palabra ''ladra''","Falta la mayúscula inicial y el punto final","Sobra una palabra","Falta la palabra ''perro''"]', 1, 'Al texto le falta la mayúscula al inicio y el punto final.', 'intermedia', 35),
  ('Si escribiste ''yo bamos al parque'', ¿cuál es la corrección adecuada con ayuda del docente?', '["Yo van al parque.","Yo vamos al parque","Yo voy al parque.","Yo bamos al parque."]', 2, 'La forma correcta del verbo con el pronombre ''yo'' es ''voy'', además de la mayúscula inicial y el punto final.', 'intermedia', 35),
  ('Revisa este texto: ''mi perro se yama rex''. ¿Cuáles son los errores que se deben corregir?', '["Solo falta el punto final","Solo falta la mayúscula inicial","No tiene ningún error","Falta mayúscula inicial, ''yama'' debe ser ''llama'' y falta punto final"]', 3, 'El texto tiene tres errores: falta la mayúscula inicial, ''yama'' debe escribirse ''llama'' y falta el punto final.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_1_basico' and lo.short_name = 'Revisión de textos propios con ayuda'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMUNICACIÓN ORAL — 1° BÁSICO
-- ============================================================================

-- Objetivo: Comprensión de instrucciones y textos orales sencillos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('La profesora dice: ''Guarden sus lápices y saquen el cuaderno de matemáticas.'' ¿Qué deben hacer los estudiantes primero?', '["Guardar los lápices","Sacar el cuaderno de lenguaje","Salir al patio","Dibujar en la pizarra"]', 0, 'La instrucción indica que primero se deben guardar los lápices.', 'inicial', 25),
  ('Si alguien te dice ''camina hasta la puerta y espera ahí'', ¿qué acción debes realizar primero?', '["Correr por el pasillo","Caminar hasta la puerta","Esperar sentado","Abrir la ventana"]', 1, 'Según la instrucción, la primera acción es caminar hasta la puerta.', 'intermedia', 35),
  ('Escuchas esta instrucción: ''Pinta el círculo de azul y el cuadrado de rojo.'' ¿De qué color debe quedar el cuadrado?', '["Verde","Amarillo","Rojo","Azul"]', 2, 'La instrucción indica que el cuadrado debe pintarse de rojo.', 'intermedia', 35),
  ('Instrucción oral: ''Primero levanten la mano, después digan su nombre y al final siéntense.'' ¿Cuál es el segundo paso?', '["Levantar la mano","Sentarse","Salir de la sala","Decir su nombre"]', 3, 'El segundo paso indicado en la instrucción es decir su nombre.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_1_basico' and lo.short_name = 'Comprensión de instrucciones y textos orales sencillos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Participación respetando turnos de habla
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Durante una conversación en clase, ¿qué se debe hacer mientras otro compañero está hablando?', '["Escuchar en silencio y esperar el turno","Hablar al mismo tiempo","Interrumpir para dar tu opinión","Salir de la sala"]', 0, 'Respetar los turnos de habla implica escuchar en silencio mientras otro habla.', 'inicial', 25),
  ('Si quieres hablar en una conversación grupal, ¿qué es lo más adecuado hacer?', '["Quedarte callado toda la clase","Levantar la mano y esperar que te den la palabra","Gritar más fuerte que los demás","Hablar sin esperar turno"]', 1, 'Levantar la mano y esperar el turno es la forma respetuosa de pedir la palabra.', 'intermedia', 35),
  ('Dos compañeros hablan al mismo tiempo y no se entienden. ¿Qué deberían hacer?', '["Dejar de participar en la conversación","Hablar más fuerte para ganarle al otro","Turnarse para hablar uno a la vez","Seguir hablando ambos a la vez"]', 2, 'Turnarse para hablar permite que ambos se comuniquen y se entiendan.', 'intermedia', 35),
  ('En un grupo de 4 estudiantes conversando, uno interrumpe constantemente a los demás. ¿Qué norma de comunicación no está respetando?', '["El uso de mayúsculas","La ortografía","La lectura en voz alta","El respeto por los turnos de habla"]', 3, 'Interrumpir constantemente no respeta los turnos de habla en una conversación grupal.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_1_basico' and lo.short_name = 'Participación respetando turnos de habla'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Expresión de ideas y experiencias personales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Quieres contarle a tu curso sobre tu mascota. ¿Qué debes hacer?', '["Expresar tus ideas con claridad frente al curso","Quedarte en silencio","Escribir un cuento inventado","Copiar lo que dijo otro compañero"]', 0, 'Contar sobre tu mascota implica expresar tus propias ideas con claridad.', 'inicial', 25),
  ('Al contar una experiencia personal, ¿qué es importante hacer para que te entiendan?', '["No mirar a quien te escucha","Hablar con claridad y en orden los hechos","Hablar muy rápido y bajito","Mezclar los hechos sin orden"]', 1, 'Hablar con claridad y ordenar los hechos ayuda a que la experiencia se comprenda bien.', 'intermedia', 35),
  ('Un compañero cuenta que fue a la playa con su familia. ¿Qué tipo de texto es este relato?', '["Un poema","Una receta","Una experiencia personal contada oralmente","Una instrucción"]', 2, 'Contar un hecho vivido corresponde a una experiencia personal narrada oralmente.', 'intermedia', 35),
  ('Vas a exponer sobre tu experiencia en un cumpleaños. ¿Cuál de estas ideas es más relevante incluir?', '["El clima de otro país","Una receta de cocina que no conoces","Un cuento inventado sin relación al tema","Qué hiciste, con quién estuviste y qué sentiste"]', 3, 'Para contar una experiencia personal es relevante incluir qué hiciste, con quién y cómo te sentiste.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_1_basico' and lo.short_name = 'Expresión de ideas y experiencias personales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Recitación de poemas y canciones breves
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 1° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al recitar un poema frente al curso, ¿qué es importante cuidar?', '["Hablar con un volumen adecuado para que todos escuchen","Hablar en voz muy baja","Leer sin decir ninguna palabra","Recitarlo mirando solo el suelo"]', 0, 'Un volumen adecuado permite que todo el curso escuche la recitación.', 'inicial', 25),
  ('¿Qué significa ''recitar'' un poema?', '["Borrarlo","Decirlo en voz alta, generalmente de memoria","Escribirlo en el cuaderno","Dibujarlo"]', 1, 'Recitar es decir un texto en voz alta, habitualmente de memoria.', 'intermedia', 35),
  ('Si olvidas una parte de una canción mientras la cantas frente al curso, ¿qué es razonable hacer?', '["Dejar de participar para siempre","Empezar a llorar sin decir nada","Intentar seguir con calma o pedir ayuda al docente","Salir corriendo de la sala"]', 2, 'Mantener la calma y pedir ayuda es una reacción razonable ante un olvido momentáneo.', 'intermedia', 35),
  ('Estás preparando la recitación de un poema corto. ¿Cuál de estas acciones ayuda a memorizarlo mejor?', '["Leerlo una sola vez y no practicar más","Memorizar solo la última palabra","Evitar leerlo antes de recitarlo","Practicarlo varias veces en voz alta"]', 3, 'Practicar varias veces en voz alta ayuda a memorizar mejor un poema o canción.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_1_basico' and lo.short_name = 'Recitación de poemas y canciones breves'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
