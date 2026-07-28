-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Lengua
-- Castellana y Comunicación (denominación oficial de esta banda: "Lenguaje y
-- Comunicación", ver supabase/seed/0014), 3° Básico. Cubre los
-- 13 objetivos de aprendizaje de 3° Básico cargados por
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
-- EJE: LECTURA — 3° BÁSICO
-- ============================================================================

-- Objetivo: Lectura independiente de textos más extensos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''El explorador cruzó el río, subió la montaña y finalmente encontró la cueva escondida entre las rocas.'' ¿Cuál fue el último lugar al que llegó el explorador?', '["La cueva escondida","El río","La montaña","Su casa"]', 0, 'El texto indica que la cueva fue el último lugar al que llegó, después del río y la montaña.', 'inicial', 25),
  ('Texto: ''Durante tres días, Marina leyó un libro largo sobre animales marinos, aprendiendo sobre ballenas, delfines y tiburones.'' ¿Sobre qué tema trata principalmente el libro que leyó Marina?', '["Deportes","Animales marinos","Animales de la selva","Plantas"]', 1, 'El texto indica que el libro trata sobre animales marinos como ballenas, delfines y tiburones.', 'intermedia', 35),
  ('Cuando lees un texto más extenso que los que leías antes, ¿qué habilidad es importante mantener durante toda la lectura?', '["Detenerse después de dos líneas","Ignorar el final del texto","La concentración y comprensión de principio a fin","Leer solo el primer párrafo"]', 2, 'Mantener la concentración durante toda la lectura es clave para comprender textos más extensos.', 'intermedia', 35),
  ('Texto: ''El río Bio Bío nace en la cordillera y recorre gran parte del sur de Chile antes de llegar al mar. En su curso, atraviesa ciudades como Los Ángeles y Concepción.'' Según el texto, ¿qué recorre el río antes de llegar al mar?', '["Solo la cordillera","Solo el mar","Ninguna ciudad","Ciudades como Los Ángeles y Concepción"]', 3, 'El texto indica explícitamente que el río atraviesa ciudades como Los Ángeles y Concepción.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_3_basico' and lo.short_name = 'Lectura independiente de textos más extensos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Inferencias a partir del texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''Pedro llegó empapado a la casa y dejó su paraguas roto en la entrada.'' ¿Qué se puede inferir sobre el clima cuando Pedro salió?', '["Probablemente llovía fuerte","Hacía mucho calor y sol","Estaba nevando","No había clima, estaba en interior"]', 0, 'Llegar empapado con el paraguas roto permite inferir que probablemente llovía fuerte.', 'inicial', 25),
  ('Texto: ''La cocina olía a pan recién horneado y había harina esparcida sobre la mesa.'' ¿Qué se puede inferir que ocurrió en la cocina?', '["Alguien pintó la cocina","Alguien horneó pan","Alguien limpió la cocina","Alguien durmió en la cocina"]', 1, 'El olor a pan recién horneado y la harina esparcida permiten inferir que alguien horneó pan.', 'intermedia', 35),
  ('Texto: ''Camila revisó su mochila tres veces antes de salir y llegó a la escuela con anticipación.'' ¿Qué se puede inferir sobre la personalidad de Camila?', '["Que siempre llega tarde","Que no le importa la escuela","Que es responsable y organizada","Que es descuidada"]', 2, 'Revisar la mochila y llegar con anticipación son señales de una persona responsable y organizada.', 'intermedia', 35),
  ('Texto: ''Al llegar al estadio, todos los asientos estaban ocupados y se escuchaban gritos de alegría cuando el equipo local anotó.'' ¿Qué se puede inferir sobre el ambiente en el estadio?', '["Que el estadio estaba vacío","Que nadie apoyaba al equipo local","Que el partido se había suspendido","Que había mucho público y estaba muy animado"]', 3, 'Los asientos ocupados y los gritos de alegría permiten inferir un ambiente animado y con mucho público.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_3_basico' and lo.short_name = 'Inferencias a partir del texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Propósito y estructura de distintos textos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Una carta generalmente comienza con:', '["Un saludo dirigido a la persona destinataria","Una lista de ingredientes","Un título en mayúsculas","Una fórmula matemática"]', 0, 'Las cartas suelen comenzar con un saludo dirigido a quien las recibe.', 'inicial', 25),
  ('¿Cuál es el propósito principal de una noticia?', '["Dar instrucciones de cocina","Informar sobre un hecho reciente","Contar una historia de fantasía","Expresar sentimientos con rima"]', 1, 'El propósito principal de una noticia es informar sobre un hecho reciente.', 'intermedia', 35),
  ('Un cuento generalmente tiene esta estructura:', '["Un saludo y una despedida","Ingredientes y preparación","Inicio, desarrollo y final","Solo una lista de datos"]', 2, 'Los cuentos suelen estructurarse en inicio, desarrollo y final.', 'intermedia', 35),
  ('¿Cuál de estos textos NO tendría la estructura típica de una carta (saludo, cuerpo, despedida)?', '["Una carta a un amigo","Una carta a un familiar","Una invitación escrita como carta","Una noticia de un diario"]', 3, 'Una noticia sigue una estructura informativa distinta, sin saludo ni despedida como una carta.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_3_basico' and lo.short_name = 'Propósito y estructura de distintos textos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Estrategias de comprensión lectora
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si no entiendes un párrafo la primera vez que lo lees, ¿qué estrategia es útil aplicar?', '["Releerlo con más atención","Pasar al siguiente párrafo sin entenderlo","Cerrar el libro","Copiarlo sin leerlo"]', 0, 'Releer con atención es una estrategia útil cuando no se comprende un párrafo.', 'inicial', 25),
  ('¿Para qué sirve subrayar las ideas importantes de un texto?', '["Para que el texto se vea más bonito","Para identificar y recordar la información relevante","Para hacer el texto más largo","Para dañar el libro"]', 1, 'Subrayar ayuda a identificar y recordar la información más relevante del texto.', 'intermedia', 35),
  ('Formular preguntas mientras lees un texto ayuda principalmente a:', '["Evitar pensar en el texto","Memorizar el texto sin comprenderlo","Verificar tu propia comprensión del contenido","Terminar de leer más rápido"]', 2, 'Formular preguntas mientras se lee permite verificar la propia comprensión del texto.', 'intermedia', 35),
  ('Después de leer un texto sobre el ciclo del agua, un estudiante no recuerda las etapas. ¿Qué estrategia le ayudaría más a recordarlas?', '["Leer un texto completamente distinto","Dejar de estudiar el tema","Copiar el texto sin leerlo","Releer el texto y subrayar cada etapa mencionada"]', 3, 'Releer y subrayar cada etapa mencionada ayuda a recordar mejor la información del texto.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_3_basico' and lo.short_name = 'Estrategias de comprensión lectora'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Relación del texto con conocimientos previos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''El pingüino es un ave que no puede volar, pero nada muy bien.'' Si ya sabías que los pingüinos viven en lugares fríos, ¿qué conocimiento previo se relaciona con este texto?', '["Que los pingüinos habitan zonas frías, como se explicó antes","Que los pingüinos vuelan muy alto","Que los pingüinos viven en el desierto","Que los pingüinos son insectos"]', 0, 'El conocimiento previo sobre el hábitat frío de los pingüinos se relaciona con la información del texto.', 'inicial', 25),
  ('Antes de leer un texto sobre el fútbol, ¿qué conocimiento previo podría ayudarte a comprenderlo mejor?', '["Saber sobre la historia de la música clásica","Saber las reglas básicas del fútbol","Saber cocinar un pastel","Saber sobre el espacio exterior"]', 1, 'Conocer las reglas básicas del fútbol facilita comprender un texto sobre ese deporte.', 'intermedia', 35),
  ('Relacionar un texto nuevo con lo que ya sabes sirve principalmente para:', '["Hacer el texto más difícil","Evitar leer el texto completo","Comprender mejor la nueva información","Olvidar lo que ya sabías"]', 2, 'Relacionar la información nueva con conocimientos previos ayuda a comprenderla mejor.', 'intermedia', 35),
  ('Texto: ''El delfín, aunque vive en el agua, respira aire igual que las personas.'' ¿Qué conocimiento previo sobre los mamíferos ayuda a entender por qué el delfín respira aire?', '["Que todos los animales del mar tienen branquias","Que el delfín es un pez","Que los peces no necesitan respirar","Que los mamíferos respiran aire, y el delfín es un mamífero"]', 3, 'Saber que los mamíferos respiran aire ayuda a entender por qué el delfín, siendo mamífero, respira aire.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_3_basico' and lo.short_name = 'Relación del texto con conocimientos previos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: ESCRITURA — 3° BÁSICO
-- ============================================================================

-- Objetivo: Textos narrativos y descriptivos con estructura
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué parte de un texto narrativo presenta a los personajes y el lugar donde ocurre la historia?', '["El inicio","El desarrollo","El cierre","El título únicamente"]', 0, 'El inicio de un texto narrativo suele presentar a los personajes y el ambiente.', 'inicial', 25),
  ('En un texto descriptivo sobre un animal, ¿qué tipo de información se espera encontrar?', '["Una receta relacionada","Sus características físicas y su comportamiento","Solo su precio en una tienda","Instrucciones para armarlo"]', 1, 'Un texto descriptivo sobre un animal detalla sus características físicas y su comportamiento.', 'intermedia', 35),
  ('¿Qué parte de un cuento resuelve el conflicto y termina la historia?', '["La presentación de personajes","El título","El cierre o desenlace","El inicio"]', 2, 'El cierre o desenlace es la parte que resuelve el conflicto y termina la historia.', 'intermedia', 35),
  ('Escribes un cuento con esta estructura: 1) Un dragón vive en una cueva. 2) El dragón pierde su tesoro y lo busca por el bosque. 3) El dragón encuentra el tesoro y vuelve a su cueva. ¿Qué parte corresponde al desarrollo?', '["La presentación del dragón en la cueva","El regreso final a la cueva","El título del cuento","La búsqueda del tesoro por el bosque"]', 3, 'La búsqueda del tesoro corresponde al desarrollo, donde se presenta y avanza el conflicto.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_3_basico' and lo.short_name = 'Textos narrativos y descriptivos con estructura'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de conectores simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué conector es adecuado para unir estas ideas: ''Quería salir a jugar ___ estaba lloviendo''?', '["pero","y","porque","entonces"]', 0, 'El conector ''pero'' expresa la oposición entre querer salir y que estuviera lloviendo.', 'inicial', 25),
  ('Completa: ''Estudié mucho ___ obtuve una buena nota.''', '["ni","por eso","pero","aunque"]', 1, '''Por eso'' expresa la consecuencia de haber estudiado mucho.', 'intermedia', 35),
  ('¿Cuál conector indica una relación de causa, como en ''No fui al parque ___ estaba enfermo''?', '["pero","o","porque","y"]', 2, '''Porque'' introduce la causa de no haber ido al parque.', 'intermedia', 35),
  ('En el texto ''Terminé la tarea. ___, guardé mis cuadernos'', ¿qué conector indica que una acción ocurre después de otra?', '["Porque","Aunque","Sin embargo","Después"]', 3, '''Después'' indica que guardar los cuadernos ocurrió luego de terminar la tarea.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_3_basico' and lo.short_name = 'Uso de conectores simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Normas ortográficas y acentuación básica
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas palabras lleva tilde?', '["camión","camion","auto","mesa"]', 0, '''Camión'' lleva tilde en la ''o'' por ser una palabra aguda terminada en ''n''.', 'inicial', 25),
  ('¿Cuál de estas palabras está escrita correctamente?', '["árvol","árbol","arbol","arból"]', 1, 'La forma correcta es ''árbol'', con tilde en la primera ''a''.', 'intermedia', 35),
  ('¿Qué palabra usa correctamente la letra ''b'' según su ortografía habitual?', '["bonitto","vonitto","bonito","vonito"]', 2, 'La forma correcta de esta palabra es ''bonito'', con ''b''.', 'intermedia', 35),
  ('En la oración ''el camion llego rapido'', ¿qué palabras necesitan tilde según las normas de acentuación?', '["rapido y el","camion solamente","Ninguna palabra necesita tilde","camión y llegó"]', 3, '''Camión'' y ''llegó'' requieren tilde según las reglas de acentuación; ''rápido'' también, pero no está entre las opciones incorrectas presentadas como correctas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_3_basico' and lo.short_name = 'Normas ortográficas y acentuación básica'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Reescritura con sugerencias de mejora
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un compañero te sugiere agregar más detalles a la descripción de tu personaje. ¿Qué deberías hacer al reescribir?', '["Incorporar más detalles sobre el personaje","Eliminar toda la descripción","Ignorar la sugerencia","Copiar la descripción de otro texto"]', 0, 'Incorporar más detalles responde directamente a la sugerencia de mejora recibida.', 'inicial', 25),
  ('Tu docente te dice que una oración de tu cuento es confusa. ¿Qué acción corresponde al reescribir?', '["Cambiar el título únicamente","Reformular esa oración para que sea más clara","Dejarla exactamente igual","Borrar todo el cuento"]', 1, 'Reformular la oración confusa responde a la retroalimentación de mejorar la claridad.', 'intermedia', 35),
  ('Al recibir sugerencias de mejora sobre un texto propio, ¿qué actitud es más adecuada?', '["Enojarse y no volver a escribir","Copiar el texto de otra persona","Considerarlas y aplicar las que ayuden a mejorar el texto","Ignorarlas siempre"]', 2, 'Una actitud adecuada es considerar las sugerencias y aplicar las que mejoren el texto.', 'intermedia', 35),
  ('Recibiste esta sugerencia: ''El final de tu cuento es muy repentino, agrega más explicación.'' ¿Qué cambio harías al reescribir el cierre?', '["Eliminar el final por completo","Agregar un personaje nuevo al inicio","Cambiar todo el cuento por uno distinto","Desarrollar con más detalle cómo se resuelve el conflicto"]', 3, 'Desarrollar con más detalle la resolución del conflicto responde a la sugerencia recibida.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_3_basico' and lo.short_name = 'Reescritura con sugerencias de mejora'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMUNICACIÓN ORAL — 3° BÁSICO
-- ============================================================================

-- Objetivo: Exposición oral de un tema investigado
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Investigaste sobre los volcanes de Chile para exponer. ¿Qué deberías hacer antes de la exposición?', '["Organizar la información investigada en un orden claro","Improvisar todo sin haber investigado","Copiar la exposición de otro compañero","Hablar de un tema distinto al investigado"]', 0, 'Organizar la información investigada en un orden claro es un paso previo importante.', 'inicial', 25),
  ('Durante una exposición sobre un tema investigado, ¿qué es importante transmitir al público?', '["Nada, solo mostrar imágenes en silencio","La información investigada de forma clara y ordenada","Solo tu opinión personal sin datos","Un chiste sin relación al tema"]', 1, 'El objetivo es transmitir la información investigada de forma clara y ordenada.', 'intermedia', 35),
  ('Si investigaste sobre las plantas y sus partes, ¿cuál de estas ideas es relevante incluir en tu exposición?', '["El clima de mañana","Un juego de mesa","Las funciones de la raíz, el tallo y las hojas","Tu comida favorita"]', 2, 'Las funciones de las partes de la planta son relevantes para una exposición sobre ese tema.', 'intermedia', 35),
  ('Preparaste una exposición sobre los animales en peligro de extinción en Chile. ¿Cuál sería un buen cierre para tu exposición?', '["Cambiar de tema abruptamente","No decir nada y sentarte","Repetir el título muchas veces","Un resumen de las ideas principales y su importancia"]', 3, 'Un buen cierre resume las ideas principales expuestas y su importancia.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_3_basico' and lo.short_name = 'Exposición oral de un tema investigado'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Escucha activa en una conversación
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Mientras un compañero habla, ¿qué demuestra que estás escuchando activamente?', '["Mirarlo y responder de forma coherente a lo que dice","Mirar tu celular sin prestar atención","Interrumpir constantemente","Hablar de un tema totalmente distinto"]', 0, 'Mirar a quien habla y responder coherentemente demuestra escucha activa.', 'inicial', 25),
  ('¿Qué significa ''escuchar activamente'' a alguien?', '["Ignorar a la persona que habla","Prestar atención y comprender lo que dice, no solo oír sonidos","Escuchar música mientras alguien habla","Repetir exactamente lo que dice sin pensar"]', 1, 'Escuchar activamente implica prestar atención y comprender, no solo oír.', 'intermedia', 35),
  ('Un compañero te cuenta un problema. ¿Qué respuesta demuestra escucha activa?', '["Quedarte en silencio sin mirarlo","Hablar de otra persona","Hacerle una pregunta relacionada con lo que contó","Cambiar de tema inmediatamente"]', 2, 'Hacer una pregunta relacionada demuestra que se comprendió y prestó atención a lo contado.', 'intermedia', 35),
  ('En una conversación grupal, alguien resume lo que dijo un compañero antes de dar su propia opinión. ¿Qué habilidad está demostrando?', '["Falta de atención","Interrupción","Desinterés por el tema","Escucha activa"]', 3, 'Resumir lo dicho por otro antes de opinar demuestra escucha activa.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_3_basico' and lo.short_name = 'Escucha activa en una conversación'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Participación en debates simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En un debate simple sobre si se debe usar uniforme escolar, ¿qué es importante hacer al opinar?', '["Fundamentar tu opinión con una razón","Gritar más fuerte que los demás","Opinar sin dar ninguna razón","Interrumpir a todos los que hablan"]', 0, 'Fundamentar la opinión con una razón es clave en la participación de un debate.', 'inicial', 25),
  ('Durante un debate, un compañero opina distinto a ti. ¿Qué actitud es adecuada?', '["Ignorarlo completamente","Escuchar su opinión con respeto aunque no estés de acuerdo","Burlarte de su opinión","No dejarlo hablar"]', 1, 'Escuchar con respeto una opinión distinta es una actitud adecuada en un debate.', 'intermedia', 35),
  ('¿Qué se necesita para participar bien en un debate simple?', '["Copiar la opinión de otro sin pensar","No decir nada","Una opinión y una razón que la explique","Solo gritar tu opinión"]', 2, 'Se necesita una opinión respaldada por una razón que la explique.', 'intermedia', 35),
  ('En un debate sobre si las mascotas deben entrar a la sala de clases, un estudiante dice: ''No deberían entrar porque algunos compañeros son alérgicos.'' ¿Qué elemento del debate está usando?', '["Solo una opinión sin razón","Una pregunta sin relación al tema","Un insulto","Una opinión fundamentada con una razón"]', 3, 'El estudiante presenta una opinión respaldada por una razón concreta (la alergia).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_3_basico' and lo.short_name = 'Participación en debates simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Vocabulario preciso y adecuado al contexto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 3° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una exposición formal frente al curso, ¿qué tipo de vocabulario es más adecuado usar?', '["Un vocabulario claro y respetuoso","Groserías","Palabras inventadas sin sentido","Solo gestos, sin hablar"]', 0, 'En una exposición formal corresponde usar un vocabulario claro y respetuoso.', 'inicial', 25),
  ('Si hablas con tu profesor sobre una duda de la tarea, ¿qué vocabulario es más apropiado?', '["Quedarte en silencio","Un vocabulario respetuoso y claro","Un vocabulario muy informal con groserías","Gritar sin explicar la duda"]', 1, 'Con el profesor corresponde un vocabulario respetuoso y claro.', 'intermedia', 35),
  ('¿Por qué es importante usar un vocabulario preciso al explicar algo?', '["Porque impide que te escuchen","Porque no tiene ninguna utilidad","Porque ayuda a que te entiendan mejor","Porque hace que hables más lento"]', 2, 'Un vocabulario preciso ayuda a que el mensaje se entienda mejor.', 'intermedia', 35),
  ('Estás explicando el ciclo del agua y usas la palabra ''evaporación'' en vez de decir ''cuando el agua se transforma en vapor''. ¿Qué logras al usar ese vocabulario preciso?', '["Confundir más a quien te escucha","Hacer la explicación menos clara","Cambiar el significado de lo que quieres decir","Comunicar la idea de forma más exacta y con un término específico"]', 3, 'Usar el término técnico preciso comunica la idea de forma más exacta.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_3_basico' and lo.short_name = 'Vocabulario preciso y adecuado al contexto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
