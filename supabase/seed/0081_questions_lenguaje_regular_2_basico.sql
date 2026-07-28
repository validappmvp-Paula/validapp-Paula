-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Lengua
-- Castellana y Comunicación (denominación oficial de esta banda: "Lenguaje y
-- Comunicación", ver supabase/seed/0014), 2° Básico. Cubre los
-- 13 objetivos de aprendizaje de 2° Básico cargados por
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
-- EJE: LECTURA — 2° BÁSICO
-- ============================================================================

-- Objetivo: Lectura fluida de textos breves
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al leer un texto breve en voz alta, ¿qué es importante para una lectura fluida?', '["Leer con una velocidad adecuada y buena pronunciación","Leer lo más rápido posible sin importar los errores","Leer en silencio siempre","Saltarse palabras difíciles sin intentarlo"]', 0, 'La fluidez lectora combina velocidad adecuada y buena pronunciación, no solo rapidez.', 'inicial', 25),
  ('Texto: ''El perro corrió por el parque y saltó sobre un charco de agua.'' Si lees este texto en voz alta con fluidez, ¿qué acción realizó el perro primero?', '["Ladró fuerte","Corrió por el parque","Saltó sobre un charco","Durmió en su casa"]', 1, 'El texto indica que primero el perro corrió por el parque y luego saltó sobre el charco.', 'intermedia', 35),
  ('¿Qué significa leer un texto ''con precisión''?', '["Leer sin mirar el texto","Leer solo la primera línea","Leer las palabras correctamente, sin cambiarlas ni omitirlas","Leer inventando palabras nuevas"]', 2, 'Leer con precisión implica no cambiar ni omitir palabras del texto original.', 'intermedia', 35),
  ('Un estudiante lee un texto muy rápido pero se equivoca en muchas palabras. ¿Qué debería mejorar primero?', '["Su velocidad, aunque siga equivocándose","Nada, está leyendo bien","Dejar de leer en voz alta para siempre","Su precisión al leer cada palabra"]', 3, 'La precisión debe mejorarse antes que la velocidad para lograr una lectura fluida real.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_2_basico' and lo.short_name = 'Lectura fluida de textos breves'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de textos literarios y no literarios
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''Había una vez un zorro astuto que vivía en el bosque.'' ¿Qué tipo de texto es este fragmento?', '["Un texto literario (cuento)","Una noticia","Una receta","Un manual de instrucciones"]', 0, 'El inicio ''había una vez'' y la presencia de un personaje animal fantástico son propios de un cuento.', 'inicial', 25),
  ('Texto: ''El agua hierve a 100 grados Celsius a nivel del mar.'' ¿Qué tipo de texto es este?', '["Una fábula","Un texto no literario (informativo)","Un cuento","Un poema"]', 1, 'El texto entrega un dato científico comprobable, propio de un texto informativo.', 'intermedia', 35),
  ('Texto: ''Lucía guardó el paraguas porque el cielo estaba nublado.'' ¿Qué se puede inferir, aunque el texto no lo diga directamente?', '["Que Lucía iba a nadar","Que era de noche","Que probablemente iba a llover","Que hacía mucho calor"]', 2, 'Un cielo nublado y guardar el paraguas permiten inferir que probablemente llovería.', 'intermedia', 35),
  ('Texto: ''El técnico revisó el motor del auto y encontró una pieza rota.'' ¿Qué información NO está explícita en el texto?', '["Que el técnico revisó el motor","Que encontró una pieza rota","Que se trata de un auto","El nombre exacto de la pieza rota"]', 3, 'El texto no menciona el nombre exacto de la pieza, solo que estaba rota.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_2_basico' and lo.short_name = 'Comprensión de textos literarios y no literarios'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Elementos del texto narrativo
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''En un pueblo pequeño, Juanita cuidaba ovejas junto a su abuelo.'' ¿Quiénes son los personajes de este texto?', '["Juanita y su abuelo","Solo Juanita","Solo el abuelo","Las ovejas y el pueblo"]', 0, 'El texto menciona a Juanita y a su abuelo como los personajes que cuidan las ovejas.', 'inicial', 25),
  ('Mismo texto: ''En un pueblo pequeño, Juanita cuidaba ovejas junto a su abuelo.'' ¿Dónde ocurre la historia (el ambiente)?', '["En el espacio","En un pueblo pequeño","En una ciudad grande","En el mar"]', 1, 'El texto indica que la historia ocurre en un pueblo pequeño.', 'intermedia', 35),
  ('Texto: ''El león rugió fuerte y todos los animales del bosque corrieron a esconderse.'' ¿Cuál es la acción principal que realiza el león?', '["Correr","Dormir","Rugir fuerte","Esconderse"]', 2, 'La acción principal del león en el texto es rugir fuerte.', 'intermedia', 35),
  ('Texto: ''Carla encontró un mapa viejo en el ático de su casa y decidió seguir sus pistas.'' ¿Cuál de estos elementos corresponde al personaje principal?', '["El ático","El mapa","La casa","Carla"]', 3, 'Carla es quien realiza la acción principal de encontrar el mapa y seguir sus pistas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_2_basico' and lo.short_name = 'Elementos del texto narrativo'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Incorporación de vocabulario nuevo
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('La palabra ''veloz'' significa lo mismo que:', '["Rápido","Lento","Pequeño","Triste"]', 0, '''Veloz'' es un sinónimo de ''rápido''.', 'inicial', 25),
  ('Si un texto dice que un lugar es ''diminuto'', esa palabra significa que el lugar es:', '["Muy ruidoso","Muy pequeño","Muy grande","Muy antiguo"]', 1, '''Diminuto'' significa de tamaño muy pequeño.', 'intermedia', 35),
  ('La palabra ''feliz'' es un sinónimo de:', '["Cansado","Asustado","Contento","Enojado"]', 2, '''Feliz'' y ''contento'' tienen un significado similar.', 'intermedia', 35),
  ('Texto: ''El explorador se sintió exhausto después de la larga caminata.'' Según el contexto, ¿qué significa ''exhausto''?', '["Muy alegre","Muy hambriento","Muy asustado","Muy cansado"]', 3, 'El contexto de una larga caminata sugiere que ''exhausto'' significa muy cansado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_2_basico' and lo.short_name = 'Incorporación de vocabulario nuevo'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Distinción de textos según su propósito
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un texto que cuenta una historia inventada con personajes, ¿qué propósito tiene?', '["Entretener con una historia (propósito literario)","Dar instrucciones para cocinar","Informar sobre el clima","Vender un producto"]', 0, 'Un texto con historia inventada y personajes tiene un propósito principalmente literario, de entretención.', 'inicial', 25),
  ('Una receta de cocina tiene como propósito principal:', '["Anunciar una noticia deportiva","Explicar los pasos para preparar un alimento","Contar una historia de aventuras","Expresar sentimientos con rima"]', 1, 'El propósito de una receta es explicar los pasos para preparar un alimento.', 'intermedia', 35),
  ('Un afiche que dice ''Cuida el agua, no la desperdicies'' tiene como propósito:', '["Vender agua embotellada","Explicar cómo nadar","Convencer a las personas de cuidar el agua","Contar un cuento sobre el agua"]', 2, 'El afiche busca convencer a las personas de cuidar el agua, un propósito persuasivo.', 'intermedia', 35),
  ('¿Cuál de estos textos tiene un propósito principalmente informativo, y no de entretención?', '["Un cuento de hadas","Un poema sobre el amor","Una canción de cuna","Una noticia sobre el clima de la semana"]', 3, 'Una noticia informa sobre hechos reales, a diferencia de los otros textos que buscan entretener o expresar sentimientos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_2_basico' and lo.short_name = 'Distinción de textos según su propósito'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: ESCRITURA — 2° BÁSICO
-- ============================================================================

-- Objetivo: Textos breves con secuencia lógica
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas oraciones debería ir primero en un texto que cuenta cómo se hace un sándwich?', '["Primero, toma dos rebanadas de pan.","Al final, sirve el sándwich en un plato.","Después, agrega el jamón y el queso.","Luego, junta las dos rebanadas."]', 0, 'El primer paso lógico para hacer un sándwich es tomar las rebanadas de pan.', 'inicial', 25),
  ('En un texto narrativo, ¿qué parte va normalmente al final?', '["El título","El cierre o desenlace de la historia","El inicio de la historia","La presentación de los personajes"]', 1, 'El cierre o desenlace es la parte que normalmente concluye una narración.', 'intermedia', 35),
  ('Ordena estas ideas de forma lógica: (1) Se secó con una toalla (2) El perro se mojó en la lluvia (3) Se durmió en su cama. ¿Cuál es el orden correcto?', '["3, 2, 1","2, 3, 1","2, 1, 3","1, 2, 3"]', 2, 'Primero el perro se moja, luego se seca y finalmente se duerme: el orden lógico es 2, 1, 3.', 'intermedia', 35),
  ('Un texto dice: ''Después, comimos el pastel. Primero, cantamos cumpleaños feliz. Al final, abrimos los regalos.'' ¿Cuál es el orden lógico correcto de los hechos?', '["Comer el pastel, cantar, abrir los regalos","Abrir los regalos, cantar, comer el pastel","Cantar, abrir los regalos, comer el pastel","Cantar, comer el pastel, abrir los regalos"]', 3, 'Según los conectores ''primero'', ''después'' y ''al final'', el orden es: cantar, comer el pastel y abrir los regalos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_2_basico' and lo.short_name = 'Textos breves con secuencia lógica'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Reglas ortográficas básicas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas oraciones usa correctamente el punto final?', '["El sol brilla en el cielo.","El viento sopla fuerte","La lluvia moja el pasto","El pájaro vuela alto"]', 0, '''El sol brilla en el cielo.'' es la única oración que termina correctamente con punto final.', 'inicial', 25),
  ('¿Cuándo se debe usar mayúscula inicial en una palabra?', '["Solo en los números","Al comenzar una oración o en nombres propios","Al final de cada oración","En todas las palabras de un texto"]', 1, 'La mayúscula se usa al iniciar una oración y en los nombres propios.', 'intermedia', 35),
  ('En el texto ''Fui al parque Me encontré con Pedro'', ¿qué signo de puntuación falta entre las dos ideas?', '["Un signo de interrogación","Nada, está completo","Un punto seguido","Una coma al final"]', 2, 'Entre ambas ideas completas falta un punto seguido que las separe.', 'intermedia', 35),
  ('Corrige: ''ana fue al colegio ella estudio mucho''. ¿Cuál es la versión correcta?', '["ana fue al colegio ella estudio mucho","Ana Fue Al Colegio. Ella Estudio Mucho.","Ana fue al colegio ella estudió mucho","Ana fue al colegio. Ella estudió mucho."]', 3, 'La versión correcta usa mayúsculas iniciales, tilde en ''estudió'' y punto seguido entre ambas oraciones.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_2_basico' and lo.short_name = 'Reglas ortográficas básicas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Planificación previa a la escritura
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Antes de escribir un cuento, ¿qué es útil planificar primero?', '["La idea central y los personajes principales","La ortografía de cada palabra","El color del cuaderno","El título en otro idioma"]', 0, 'Planificar la idea central y los personajes ayuda a organizar el cuento antes de escribirlo.', 'inicial', 25),
  ('Si vas a escribir sobre ''mi mascota'', ¿qué deberías planificar antes de escribir?', '["Un problema de matemáticas","Qué características de tu mascota vas a describir","El clima de mañana","Una receta de cocina"]', 1, 'Planificar qué características describir ayuda a organizar el texto sobre la mascota.', 'intermedia', 35),
  ('Planificar un texto antes de escribirlo ayuda principalmente a:', '["Escribir sin pensar en el tema","Hacer el texto más largo sin sentido","Organizar las ideas antes de redactarlas","Evitar tener que revisar el texto después"]', 2, 'La planificación previa ayuda a organizar las ideas antes de escribir el texto.', 'intermedia', 35),
  ('Vas a escribir un texto informativo sobre los animales del zoológico. ¿Cuál de estos pasos de planificación es más adecuado hacer primero?', '["Escribir la última oración del texto","Buscar un dibujo para colorear","Memorizar el abecedario","Elegir qué animales vas a describir y en qué orden"]', 3, 'Elegir los animales y su orden es un paso de planificación previo a la redacción del texto.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_2_basico' and lo.short_name = 'Planificación previa a la escritura'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Revisión de textos propios
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al revisar un texto propio, ¿qué debes buscar?', '["Errores de ortografía y partes poco claras","Nada, un primer borrador siempre está perfecto","Solo la cantidad de palabras","El color de la tinta usada"]', 0, 'Al revisar un texto se buscan errores de ortografía y partes que no se entiendan bien.', 'inicial', 25),
  ('Si una oración de tu texto no se entiende bien, ¿qué deberías hacer al revisarlo?', '["Copiar la oración de un libro","Reescribirla para que sea más clara","Dejarla igual aunque no se entienda","Borrar todo el texto"]', 1, 'Reescribir la oración poco clara mejora la comprensión del texto.', 'intermedia', 35),
  ('¿Por qué es útil leer en voz alta tu propio texto al revisarlo?', '["Porque cambia el significado del texto","Porque no es necesario revisar nada más","Porque ayuda a notar errores que no se ven al leer en silencio","Porque hace el texto más largo"]', 2, 'Leer en voz alta ayuda a detectar errores que pasan desapercibidos al leer en silencio.', 'intermedia', 35),
  ('Revisas tu texto y notas que repites la palabra ''bonito'' cuatro veces en un párrafo corto. ¿Qué deberías hacer?', '["Dejarlo igual porque repetir palabras no es un problema","Eliminar todo el párrafo","Agregar la palabra ''bonito'' una vez más","Reemplazar algunas repeticiones por sinónimos como ''lindo'' o ''hermoso''"]', 3, 'Reemplazar repeticiones por sinónimos mejora la variedad del vocabulario en el texto.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_2_basico' and lo.short_name = 'Revisión de textos propios'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMUNICACIÓN ORAL — 2° BÁSICO
-- ============================================================================

-- Objetivo: Comprensión de textos orales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Escuchas a tu profesora contar: ''Mañana no habrá clases porque es feriado.'' ¿Qué información es la más relevante?', '["Que mañana no hay clases por ser feriado","Que la profesora está cansada","Que hoy es lunes","Que el feriado es en otro país"]', 0, 'La información más relevante del mensaje oral es que mañana no habrá clases por el feriado.', 'inicial', 25),
  ('Un compañero relata oralmente que fue al dentista y le dolió un poco. ¿Cuál es la idea principal de su relato?', '["Que no le gusta el dentista","Que fue al dentista y sintió un poco de dolor","Que fue a la playa","Que comió muchos dulces"]', 1, 'La idea principal del relato es la visita al dentista y el dolor sentido.', 'intermedia', 35),
  ('Al escuchar instrucciones orales complejas, ¿qué estrategia ayuda a comprenderlas mejor?', '["Interrumpir constantemente","Ignorar la instrucción","Prestar atención y pedir que se repita si algo no se entiende","Distraerse mientras se habla"]', 2, 'Prestar atención y pedir repetición cuando algo no se entiende ayuda a comprender mejor.', 'intermedia', 35),
  ('Escuchas: ''Primero busquen su cuaderno, luego escriban la fecha y después copien el título de la pizarra.'' Si ya escribiste la fecha, ¿qué falta por hacer?', '["Buscar el cuaderno","Nada, ya terminaste","Borrar la fecha","Copiar el título de la pizarra"]', 3, 'Según el orden de la instrucción, después de escribir la fecha falta copiar el título.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_2_basico' and lo.short_name = 'Comprensión de textos orales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Exposición oral breve con apoyo visual
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Vas a exponer sobre tu animal favorito usando una lámina con dibujos. ¿Para qué sirve la lámina?', '["Para apoyar visualmente lo que estás explicando","Para leerla en vez de hablar","Para que el público la lea en silencio","Para tapar tu cara mientras hablas"]', 0, 'La lámina cumple la función de apoyar visualmente la explicación oral.', 'inicial', 25),
  ('Durante una exposición oral, ¿qué es importante hacer con el apoyo visual (lámina o dibujo)?', '["No mencionarlo nunca","Mostrarlo mientras se explica su contenido","Esconderlo detrás de la espalda","Mirarlo todo el tiempo sin hablar"]', 1, 'El apoyo visual debe mostrarse mientras se explica su contenido oralmente.', 'intermedia', 35),
  ('Si tu lámina tiene un dibujo de un león, ¿qué deberías decir mientras la muestras?', '["Nada, solo mostrar el dibujo en silencio","Una canción sin relación al tema","Información relacionada con el león que estás explicando","Un tema completamente distinto"]', 2, 'Al mostrar la lámina se debe explicar información relacionada con lo que representa.', 'intermedia', 35),
  ('Preparas una exposición sobre las plantas con 3 láminas: raíz, tallo y hoja. ¿En qué orden es más lógico mostrarlas si vas a explicar de abajo hacia arriba de la planta?', '["Hoja, tallo, raíz","Tallo, raíz, hoja","Hoja, raíz, tallo","Raíz, tallo, hoja"]', 3, 'De abajo hacia arriba, el orden de la planta es raíz, tallo y luego hoja.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_2_basico' and lo.short_name = 'Exposición oral breve con apoyo visual'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Preguntas y respuestas pertinentes
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un compañero expone sobre los dinosaurios. ¿Cuál de estas preguntas es pertinente hacerle al final?', '["¿Cuál era el dinosaurio más grande?","¿Qué comiste en el almuerzo?","¿Te gusta el fútbol?","¿Qué día es hoy?"]', 0, 'La pregunta sobre el dinosaurio más grande es pertinente al tema expuesto.', 'inicial', 25),
  ('Si alguien te pregunta ''¿cómo te llamas?'', ¿cuál es una respuesta pertinente?', '["Quedarte en silencio","Decir tu nombre","Hablar del clima","Cambiar de tema"]', 1, 'La respuesta pertinente a esa pregunta es decir tu propio nombre.', 'intermedia', 35),
  ('Durante una conversación sobre mascotas, ¿cuál de estas preguntas NO es pertinente al tema?', '["¿Cómo se llama tu mascota?","¿Qué le gusta comer a tu mascota?","¿Cuánto cuesta un pasaje de avión?","¿Qué mascota tienes en casa?"]', 2, 'La pregunta sobre el pasaje de avión no tiene relación con el tema de las mascotas.', 'intermedia', 35),
  ('En una entrevista sobre el trabajo de un bombero, ¿cuál pregunta obtendría información más relevante sobre su labor?', '["¿Cuál es su comida favorita?","¿Qué colores le gustan?","¿Cuántos hermanos tiene?","¿Qué hace usted cuando hay un incendio?"]', 3, 'La pregunta sobre el incendio se relaciona directamente con la labor de un bombero.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_2_basico' and lo.short_name = 'Preguntas y respuestas pertinentes'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de vocabulario variado
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 2° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En vez de decir siempre ''bueno'', ¿qué otra palabra podrías usar con un significado parecido?', '["Excelente","Malo","Triste","Feo"]', 0, '''Excelente'' es una palabra con un significado similar a ''bueno'', útil para variar el vocabulario.', 'inicial', 25),
  ('Para no repetir la palabra ''grande'' varias veces, ¿qué palabra podrías usar en su lugar?', '["Rápido","Enorme","Pequeño","Feo"]', 1, '''Enorme'' es un sinónimo de ''grande'' que ayuda a variar el vocabulario.', 'intermedia', 35),
  ('¿Cuál de estas palabras es un sinónimo de ''contento''?', '["Enojado","Cansado","Alegre","Triste"]', 2, '''Alegre'' es un sinónimo de ''contento''.', 'intermedia', 35),
  ('En una exposición oral usaste la palabra ''lindo'' seis veces. ¿Qué podrías hacer para variar tu vocabulario?', '["Seguir usando ''lindo'' todas las veces","Dejar de hablar","Usar solo palabras en otro idioma","Reemplazar algunas repeticiones por palabras como ''hermoso'' o ''bonito''"]', 3, 'Reemplazar repeticiones por sinónimos como ''hermoso'' o ''bonito'' varía el vocabulario usado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_2_basico' and lo.short_name = 'Uso de vocabulario variado'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
