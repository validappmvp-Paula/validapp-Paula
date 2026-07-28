-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Lengua
-- Castellana y Comunicación (denominación oficial de esta banda: "Lenguaje y
-- Comunicación", ver supabase/seed/0014), 5° Básico. Cubre los
-- 13 objetivos de aprendizaje de 5° Básico cargados por
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
-- EJE: LECTURA — 5° BÁSICO
-- ============================================================================

-- Objetivo: Narrador, personajes, ambiente y conflicto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''Yo caminaba por el bosque cuando escuché un ruido extraño detrás de los árboles.'' ¿Qué tipo de narrador presenta este fragmento?', '["Narrador en primera persona (protagonista)","Narrador en tercera persona omnisciente","Un narrador que no participa en la historia y no usa ''yo''","No hay narrador en el texto"]', 0, 'El uso de ''yo'' indica que el narrador participa en la historia como protagonista, en primera persona.', 'inicial', 25),
  ('Texto: ''Marta y su hermano exploraban una cueva oscura en busca de un tesoro perdido hace siglos.'' ¿Cuál es el ambiente de esta historia?', '["Un salón de clases","Una cueva oscura","Una playa soleada","Una ciudad moderna"]', 1, 'El texto indica que la historia ocurre en una cueva oscura.', 'intermedia', 35),
  ('Texto: ''El capitán quería llegar a puerto antes de la tormenta, pero el motor del barco falló a mitad de camino.'' ¿Cuál es el conflicto principal?', '["No hay ningún problema en la historia","El barco ya llegó sin problemas","El motor falló y la tormenta se acerca antes de llegar a puerto","El capitán no quiere llegar a puerto"]', 2, 'El conflicto es la falla del motor combinada con la tormenta que se acerca, antes de llegar a puerto.', 'intermedia', 35),
  ('Texto: ''Él observaba la escena desde lejos, sin participar, y conocía los pensamientos secretos de todos los personajes.'' ¿Qué tipo de narrador es este?', '["Narrador protagonista en primera persona","Un personaje que solo habla de sí mismo","No existe narrador en este fragmento","Narrador omnisciente en tercera persona"]', 3, 'Conocer los pensamientos de todos los personajes sin participar es propio de un narrador omnisciente en tercera persona.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_5_basico' and lo.short_name = 'Narrador, personajes, ambiente y conflicto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Hecho y opinión en textos informativos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('''El agua cubre aproximadamente el 70% de la superficie terrestre.'' ¿Esta afirmación es un hecho o una opinión?', '["Un hecho, porque se puede comprobar","Una opinión, porque depende del punto de vista","Ni hecho ni opinión","Una instrucción"]', 0, 'Se trata de un hecho porque es un dato comprobable científicamente.', 'inicial', 25),
  ('''El fútbol es el deporte más entretenido del mundo.'' ¿Esta afirmación es un hecho o una opinión?', '["Una receta de cocina","Una opinión, porque depende de los gustos de cada persona","Un hecho, porque se puede medir con exactitud","Una instrucción para jugar fútbol"]', 1, 'Es una opinión porque depende de los gustos y preferencias personales.', 'intermedia', 35),
  ('¿Cuál es la diferencia principal entre un hecho y una opinión en un texto informativo?', '["El hecho siempre es falso y la opinión siempre es verdadera","La opinión se puede medir con exactitud, el hecho no","El hecho se puede comprobar; la opinión expresa un punto de vista","No existe ninguna diferencia entre ambos"]', 2, 'El hecho es comprobable objetivamente, mientras que la opinión expresa un punto de vista personal.', 'intermedia', 35),
  ('Texto: ''El Everest mide 8.849 metros de altura y es, sin duda, la montaña más hermosa del planeta.'' ¿Qué parte de esta oración corresponde a un hecho y cuál a una opinión?', '["Ambas partes son hechos comprobables","Ambas partes son opiniones","La altura es opinión y ''la más hermosa'' es un hecho","La altura es un hecho; que sea ''la más hermosa'' es una opinión"]', 3, 'La altura es un dato medible (hecho); calificarla como ''la más hermosa'' es un juicio personal (opinión).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_5_basico' and lo.short_name = 'Hecho y opinión en textos informativos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Significado de palabras por contexto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''El anciano caminaba con parsimonia, disfrutando cada paso sin ninguna prisa.'' Según el contexto, ¿qué significa ''parsimonia''?', '["Lentitud y calma","Mucha rapidez","Enojo","Tristeza profunda"]', 0, 'El contexto de ''sin ninguna prisa'' indica que ''parsimonia'' significa lentitud y calma.', 'inicial', 25),
  ('Texto: ''La noticia generó gran controversia, con opiniones muy divididas entre las personas.'' Según el contexto, ¿qué significa ''controversia''?', '["Una celebración alegre","Una discusión con opiniones opuestas","Un acuerdo total entre todos","Silencio absoluto"]', 1, 'El contexto de ''opiniones muy divididas'' indica que ''controversia'' es una discusión con posturas opuestas.', 'intermedia', 35),
  ('Texto: ''El científico formuló una hipótesis para explicar el fenómeno antes de comprobarlo con experimentos.'' Según el contexto, ¿qué es una ''hipótesis''?', '["Una opinión sin ninguna relación con la ciencia","Un error del científico","Una posible explicación que aún debe comprobarse","Un hecho ya comprobado y seguro"]', 2, 'El contexto indica que la hipótesis se plantea antes de comprobarse con experimentos, por lo que es una explicación posible aún no verificada.', 'intermedia', 35),
  ('Texto: ''A pesar de la escasez de recursos, la comunidad logró salir adelante gracias a su resiliencia.'' Según el contexto, ¿qué significa ''resiliencia''?', '["Falta total de recursos","Debilidad frente a los problemas","Indiferencia ante las dificultades","Capacidad de superar dificultades y adaptarse"]', 3, 'El contexto de ''salir adelante a pesar de la escasez'' indica que ''resiliencia'' es la capacidad de superar dificultades.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_5_basico' and lo.short_name = 'Significado de palabras por contexto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Postura personal fundamentada frente a lo leído
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''El personaje decidió devolver la billetera con dinero que encontró en la calle, aunque nadie lo estaba viendo.'' ¿Cuál postura está mejor fundamentada con evidencia del texto?', '["Actuó de forma honesta, ya que devolvió el dinero sin que nadie lo obligara","Actuó de forma deshonesta, porque se quedó con el dinero","El texto no permite formar una postura sobre su actuar","Actuó por obligación de otra persona"]', 0, 'Devolver el dinero sin ser obligado ni vigilado respalda la postura de que actuó con honestidad.', 'inicial', 25),
  ('Para formar una postura personal fundamentada sobre un texto, ¿qué debes hacer?', '["No formar ninguna postura","Basarte en evidencia y ejemplos del texto para argumentar tu postura","Opinar sin relación con lo leído","Copiar la postura de otra persona sin pensar"]', 1, 'Una postura fundamentada se apoya en evidencia y ejemplos concretos del texto.', 'intermedia', 35),
  ('Texto: ''La protagonista sacrificó su tiempo libre para ayudar a organizar una colecta solidaria en su barrio.'' ¿Cuál postura está mejor argumentada con el texto?', '["El texto no entrega información sobre su actuar","Demuestra que no tiene tiempo libre nunca","Demuestra un compromiso solidario con su comunidad","Demuestra desinterés por ayudar a otros"]', 2, 'Sacrificar tiempo libre para ayudar en una colecta respalda la postura de un compromiso solidario.', 'intermedia', 35),
  ('Texto: ''El personaje mintió sobre sus razones para no participar en el proyecto grupal, evitando el trabajo en equipo.'' ¿Cuál de estas posturas está mejor fundamentada con evidencia del texto?', '["Su actitud fue ejemplar y muy colaborativa","El texto no permite opinar sobre su actitud","Mintió porque estaba obligado a hacerlo, según el texto","Su actitud fue poco colaborativa, ya que evitó el trabajo en equipo mediante una mentira"]', 3, 'Mentir para evitar el trabajo en equipo respalda la postura de una actitud poco colaborativa.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_5_basico' and lo.short_name = 'Postura personal fundamentada frente a lo leído'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Contexto sociocultural del texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''En la ceremonia mapuche, se agradecía a la tierra por las cosechas del año.'' ¿Qué elemento del contexto sociocultural se menciona en el texto?', '["Una tradición o ceremonia de un pueblo originario","Un evento deportivo internacional","Una receta de cocina moderna","Una noticia sobre tecnología"]', 0, 'El texto describe una ceremonia y tradición de un pueblo originario, el mapuche.', 'inicial', 25),
  ('¿Qué se entiende por ''contexto sociocultural'' de un texto?', '["El nombre del autor únicamente","La época, el lugar y la cultura en que fue escrito o se desarrolla","Solo el color de la portada del libro","La cantidad de páginas del texto"]', 1, 'El contexto sociocultural incluye la época, el lugar y la cultura relacionadas con el texto.', 'intermedia', 35),
  ('Texto: ''Durante la colonia, muchas cartas se escribían con un lenguaje muy formal y respetuoso hacia las autoridades.'' ¿Qué aspecto del contexto sociocultural se refleja en este fragmento?', '["Un deporte popular de la actualidad","Una receta tradicional","Las normas de respeto y formalidad de esa época","Las tecnologías actuales de comunicación"]', 2, 'El fragmento refleja las normas sociales de formalidad y respeto propias de esa época histórica.', 'intermedia', 35),
  ('Texto: ''El cuento fue escrito en una época sin electricidad, por lo que los personajes usan velas para alumbrarse de noche.'' ¿Qué permite inferir este detalle sobre el contexto histórico del texto?', '["Que la historia ocurre en el futuro","Que los personajes tienen tecnología moderna","Que el texto no tiene ningún contexto temporal","Que la historia ocurre en una época anterior a la electricidad"]', 3, 'El uso de velas para alumbrarse permite inferir que la historia ocurre antes de la existencia de la electricidad.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_5_basico' and lo.short_name = 'Contexto sociocultural del texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: ESCRITURA — 5° BÁSICO
-- ============================================================================

-- Objetivo: Textos de diversos géneros con propósito definido
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si quieres producir un texto para convencer a tus compañeros de reciclar, ¿qué género es más adecuado?', '["Un texto argumentativo","Una receta de cocina","Un poema sin relación al tema","Un cuento de hadas sin relación al tema"]', 0, 'Un texto argumentativo es el género adecuado para convencer sobre una idea, como el reciclaje.', 'inicial', 25),
  ('¿Cuál es el propósito principal de un texto poético?', '["Vender un producto específico","Expresar sentimientos o ideas mediante recursos como el ritmo y las imágenes","Dar instrucciones técnicas exactas","Informar datos científicos de forma exacta"]', 1, 'El texto poético busca expresar sentimientos o ideas mediante recursos como el ritmo y las imágenes.', 'intermedia', 35),
  ('Si tu propósito es informar sobre un hecho reciente en tu comunidad, ¿qué género es más apropiado producir?', '["Una receta de cocina","Un cuento de fantasía","Una noticia","Un poema de amor"]', 2, 'Una noticia es el género apropiado para informar sobre un hecho reciente.', 'intermedia', 35),
  ('Quieres escribir un texto con el propósito de entretener contando una aventura inventada con personajes fantásticos. ¿Qué género deberías elegir?', '["Un informe científico","Una noticia periodística","Un manual de instrucciones","Un cuento narrativo"]', 3, 'Un cuento narrativo es el género adecuado para entretener contando una aventura inventada.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_5_basico' and lo.short_name = 'Textos de diversos géneros con propósito definido'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Conectores variados para cohesión y coherencia
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Completa con un conector adversativo: ''Estudió mucho, ___ no aprobó el examen.''', '["sin embargo","porque","además","entonces"]', 0, '''Sin embargo'' expresa la oposición entre estudiar mucho y no aprobar el examen.', 'inicial', 25),
  ('¿Qué conector es adecuado para agregar una idea nueva, como en ''Me gusta leer. ___, me gusta escribir cuentos''?', '["A pesar de","Además","Sin embargo","Porque"]', 1, '''Además'' agrega una idea nueva relacionada con la anterior.', 'intermedia', 35),
  ('¿Cuál conector expresa una condición, como en ''___ llueve, no saldremos al patio''?', '["Pero","Luego","Si","Y"]', 2, '''Si'' introduce una condición para la acción de no salir al patio.', 'intermedia', 35),
  ('En el texto ''Quería ir a la fiesta. ___, tenía mucha tarea pendiente'', ¿qué conector adversativo es más adecuado para mostrar contraste?', '["Además","Por lo tanto","Debido a que","Sin embargo"]', 3, '''Sin embargo'' muestra el contraste entre querer ir a la fiesta y tener mucha tarea pendiente.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_5_basico' and lo.short_name = 'Conectores variados para cohesión y coherencia'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Convenciones de escritura crecientes
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas oraciones usa correctamente la coma en una enumeración?', '["Compré manzanas, peras, plátanos y uvas.","Compré manzanas peras plátanos y uvas.","Compré, manzanas peras, plátanos y uvas.","Compré manzanas, peras plátanos, y, uvas."]', 0, '''Compré manzanas, peras, plátanos y uvas.'' separa correctamente cada elemento de la enumeración con comas.', 'inicial', 25),
  ('¿Cuál de estas palabras está correctamente escrita con ''j'' o ''g'' según su ortografía habitual?', '["hirafa","jirafa","girafa","yirafa"]', 1, 'La forma correcta de esta palabra es ''jirafa'', con ''j''.', 'intermedia', 35),
  ('¿En qué caso se debe usar el signo de interrogación de apertura (¿) en español?', '["Solo en textos científicos","Nunca se usa en español","Al inicio de una pregunta escrita","Al final de cualquier oración"]', 2, 'El signo de interrogación de apertura se usa al inicio de una pregunta escrita en español.', 'intermedia', 35),
  ('Corrige la puntuación de: ''Fuimos al cine comimos palomitas y luego volvimos a casa''. ¿Cuál es la versión correctamente puntuada?', '["Fuimos, al cine comimos, palomitas y luego, volvimos a casa.","Fuimos al cine comimos, palomitas, y luego volvimos, a casa.","Fuimos al cine comimos palomitas y luego volvimos a casa","Fuimos al cine, comimos palomitas y luego volvimos a casa."]', 3, 'La versión correcta separa con una coma la primera acción del resto de la enumeración y termina con punto final.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_5_basico' and lo.short_name = 'Convenciones de escritura crecientes'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Revisión con pautas o rúbricas simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al usar una pauta para revisar tu texto, ¿qué debes hacer?', '["Comparar tu texto con cada criterio de la pauta","Ignorar la pauta y entregar el texto tal cual","Copiar la pauta en vez de tu texto","Botar la pauta sin leerla"]', 0, 'Comparar el texto con cada criterio de la pauta permite identificar qué mejorar.', 'inicial', 25),
  ('Una rúbrica de escritura indica que el texto debe tener ''ideas claras y ordenadas''. ¿Qué deberías revisar en tu texto según ese criterio?', '["El tamaño de la letra únicamente","Que las ideas estén expresadas con claridad y en un orden lógico","El color del cuaderno usado","La cantidad de dibujos incluidos"]', 1, 'Ese criterio de la rúbrica exige revisar la claridad y el orden de las ideas del texto.', 'intermedia', 35),
  ('¿Para qué sirve usar una pauta o rúbrica al revisar un texto propio?', '["Para evitar revisar el texto por completo","Para copiar el texto de otra persona","Para identificar de forma objetiva qué aspectos del texto se pueden mejorar","Para hacer el texto más largo sin revisar nada"]', 2, 'Una pauta o rúbrica ayuda a identificar de forma objetiva qué aspectos del texto mejorar.', 'intermedia', 35),
  ('Una rúbrica evalúa ''coherencia'', ''ortografía'' y ''uso de conectores''. Al revisar tu texto notas que tiene buena ortografía pero las ideas están desordenadas. ¿Qué criterio deberías mejorar primero?', '["La ortografía, aunque ya esté bien","El tamaño del texto","El título únicamente","La coherencia y el orden de las ideas"]', 3, 'Si las ideas están desordenadas, el criterio de coherencia es el que requiere mejorar primero.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_5_basico' and lo.short_name = 'Revisión con pautas o rúbricas simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMUNICACIÓN ORAL — 5° BÁSICO
-- ============================================================================

-- Objetivo: Exposición oral con apoyo de TIC
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Vas a exponer usando una presentación digital con imágenes y texto breve. ¿Qué recomienda una buena práctica de exposición con TIC?', '["Usar las diapositivas como apoyo, sin leerlas palabra por palabra","Leer cada palabra de la diapositiva sin explicar nada más","No preparar ningún contenido antes de exponer","Poner mucho texto y ninguna imagen en cada diapositiva"]', 0, 'Usar las diapositivas como apoyo, sin leerlas literalmente, es una buena práctica al exponer con TIC.', 'inicial', 25),
  ('¿Qué ventaja ofrece usar tecnología (como diapositivas o videos) durante una exposición oral?', '["Impide que el público comprenda el tema","Ayuda a ilustrar y reforzar visualmente la información expuesta","Reemplaza completamente la necesidad de hablar","Hace que no sea necesario investigar el tema"]', 1, 'La tecnología ayuda a ilustrar y reforzar visualmente lo que se expone oralmente.', 'intermedia', 35),
  ('Preparas un video breve como apoyo de tu exposición sobre el reciclaje. ¿Cuál es el uso más adecuado de ese recurso?', '["Reemplazar toda tu exposición oral por el video sin explicar nada","No mencionarlo durante la exposición","Mostrarlo en el momento adecuado para reforzar una idea clave","Mostrarlo sin relación con el tema de tu exposición"]', 2, 'El video debe mostrarse en el momento adecuado para reforzar una idea clave de la exposición.', 'intermedia', 35),
  ('Tu presentación digital tiene un error y no puedes mostrar una diapositiva importante durante la exposición. ¿Qué es lo más adecuado hacer?', '["Detener la exposición por completo","Decir que no sabes de qué hablar","Culpar al público por el error técnico","Explicar la idea oralmente sin depender del recurso técnico"]', 3, 'Explicar la idea oralmente permite continuar la exposición a pesar de la falla técnica.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_5_basico' and lo.short_name = 'Exposición oral con apoyo de TIC'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Debates con argumentación y contraargumentación
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En un debate, alguien presenta un argumento y tú no estás de acuerdo. ¿Qué corresponde hacer para responder adecuadamente?', '["Presentar un contraargumento con una razón que lo respalde","Gritar que está equivocado sin dar razones","Ignorar completamente lo que dijo","Repetir exactamente lo mismo que él dijo"]', 0, 'Presentar un contraargumento respaldado por una razón es la forma adecuada de responder en un debate.', 'inicial', 25),
  ('¿Qué es un contraargumento en un debate?', '["Una pregunta que no tiene respuesta","Una respuesta que rebate o cuestiona un argumento previo con razones","Una opinión sin ninguna relación con el tema","Un insulto hacia quien opina distinto"]', 1, 'Un contraargumento es una respuesta con razones que rebate un argumento previo.', 'intermedia', 35),
  ('En un debate sobre el uso de celulares en el colegio, un estudiante argumenta que ayudan a investigar en clase. ¿Cuál sería un buen contraargumento?', '["Cambiar de tema sin responder","Insultar al estudiante que opinó","Que también pueden distraer a los estudiantes durante la clase","Decir que los celulares no existen"]', 2, 'Señalar que también pueden distraer es un contraargumento pertinente y razonado.', 'intermedia', 35),
  ('Durante un debate, presentas un argumento y un compañero te da un contraargumento válido con evidencia. ¿Cuál es la reacción más adecuada?', '["Ignorarlo y repetir tu argumento sin cambios","Insultar a tu compañero","Abandonar el debate sin decir nada","Considerar el contraargumento y responder con nueva evidencia o reconocerlo"]', 3, 'Considerar el contraargumento y responder con evidencia demuestra una participación adecuada en el debate.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_5_basico' and lo.short_name = 'Debates con argumentación y contraargumentación'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Intención del hablante en un discurso
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Discurso: ''Los invito a todos a cuidar nuestro planeta, cada pequeña acción cuenta.'' ¿Cuál es la intención principal del hablante?', '["Convencer a la audiencia de cuidar el medio ambiente","Informar sobre el clima de mañana","Contar un cuento de fantasía","Vender un producto"]', 0, 'El hablante busca convencer a la audiencia de cuidar el medio ambiente.', 'inicial', 25),
  ('Un discurso que dice ''no debemos rendirnos, sigamos adelante juntos'' busca principalmente:', '["Criticar sin ninguna intención de motivar","Motivar o animar a la audiencia","Informar datos científicos exactos","Dar una receta de cocina"]', 1, 'El discurso busca motivar y animar a la audiencia a seguir adelante.', 'intermedia', 35),
  ('¿Qué significa identificar la ''intención comunicativa'' de un discurso?', '["Memorizar el discurso completo","Identificar el color de la ropa del hablante","Reconocer qué busca lograr el hablante con sus palabras (informar, convencer, motivar, etc.)","Contar cuántas palabras tiene el discurso"]', 2, 'Identificar la intención comunicativa implica reconocer qué busca lograr el hablante.', 'intermedia', 35),
  ('Discurso: ''Compañeros, sé que el proyecto ha sido difícil, pero cada uno de ustedes ha dado lo mejor de sí. Sigamos así.'' ¿Cuál es la intención principal de quien pronuncia este discurso?', '["Criticar duramente al equipo por su desempeño","Informar sobre un dato científico","Vender un producto al equipo","Reconocer el esfuerzo del equipo y motivarlo a continuar"]', 3, 'El discurso reconoce el esfuerzo del equipo y busca motivarlo a continuar.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_5_basico' and lo.short_name = 'Intención del hablante en un discurso'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Registro y vocabulario según la audiencia
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 5° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si expones frente a estudiantes de primero básico sobre un tema, ¿qué tipo de vocabulario deberías usar?', '["Un vocabulario simple y adecuado a su edad","Un vocabulario técnico y complejo","Palabras en otro idioma sin traducir","Ningún vocabulario, solo gestos"]', 0, 'Frente a estudiantes pequeños corresponde usar un vocabulario simple y adecuado a su edad.', 'inicial', 25),
  ('Si tu audiencia son especialistas en un tema científico, ¿qué tipo de vocabulario sería más adecuado usar?', '["Solo palabras informales de uso cotidiano","Un vocabulario más técnico y específico del tema","Un vocabulario extremadamente infantil","Ningún vocabulario relacionado con el tema"]', 1, 'Frente a especialistas es adecuado usar un vocabulario más técnico y específico.', 'intermedia', 35),
  ('¿Por qué es importante adaptar el vocabulario según la audiencia?', '["Porque la audiencia no influye en cómo se habla","Porque usar el mismo vocabulario siempre es mejor","Para que el mensaje sea comprendido por quienes escuchan","Porque el vocabulario nunca debe cambiar"]', 2, 'Adaptar el vocabulario asegura que el mensaje sea comprendido por la audiencia.', 'intermedia', 35),
  ('Preparas la misma exposición sobre el sistema solar para un curso de 1° básico y para un grupo de científicos. ¿Qué debería cambiar entre ambas exposiciones?', '["Nada, la exposición debe ser exactamente igual","Solo el color de las diapositivas","El tema completo de la exposición","El nivel de vocabulario y complejidad, adaptándolo a cada audiencia"]', 3, 'El nivel de vocabulario y complejidad debe adaptarse según cada audiencia, aunque el tema sea el mismo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_5_basico' and lo.short_name = 'Registro y vocabulario según la audiencia'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
