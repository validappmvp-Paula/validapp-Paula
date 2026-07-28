-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Lengua
-- Castellana y Comunicación (denominación oficial de esta banda: "Lenguaje y
-- Comunicación", ver supabase/seed/0014), 4° Básico. Cubre los
-- 13 objetivos de aprendizaje de 4° Básico cargados por
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
-- EJE: LECTURA — 4° BÁSICO
-- ============================================================================

-- Objetivo: Conflicto, personajes y tema central
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''Ana quería ganar la carrera de atletismo, pero se torció el tobillo justo antes de la competencia.'' ¿Cuál es el conflicto principal de esta historia?', '["Ana se lesionó justo antes de una competencia importante para ella","Ana no quiere correr","Ana ganó la carrera fácilmente","Ana no tiene amigos"]', 0, 'El conflicto central es la lesión de Ana justo antes de la competencia que quería ganar.', 'inicial', 25),
  ('Mismo texto sobre Ana y la carrera de atletismo. ¿Quién es el personaje principal?', '["El público","Ana","El tobillo","La carrera"]', 1, 'Ana es quien vive el conflicto central de la historia, por lo que es el personaje principal.', 'intermedia', 35),
  ('Texto: ''Un grupo de amigos organiza una campaña para limpiar la playa de su barrio después de ver mucha basura.'' ¿Cuál es el tema central del texto?', '["Un partido de fútbol","Un viaje al extranjero","El cuidado del medio ambiente","Un cumpleaños"]', 2, 'El texto trata sobre una campaña de limpieza, relacionada con el cuidado del medio ambiente.', 'intermedia', 35),
  ('Texto: ''El rey quería conquistar nuevas tierras, pero su pueblo sufría hambre y pedía que se invirtiera en alimentos en vez de guerras.'' ¿Cuál es el conflicto central del texto?', '["La falta de un rey","Un problema de transporte","La ausencia de personajes","La disputa entre los deseos del rey y las necesidades de su pueblo"]', 3, 'El conflicto surge entre los deseos de conquista del rey y las necesidades de su pueblo hambriento.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_4_basico' and lo.short_name = 'Conflicto, personajes y tema central'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Propósito e ideas relevantes de textos no literarios
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''Se recomienda lavarse las manos antes de comer para evitar enfermedades.'' ¿Cuál es el propósito de este texto?', '["Informar sobre una medida de higiene y salud","Contar una historia de aventuras","Vender un producto de limpieza","Expresar sentimientos con rima"]', 0, 'El texto busca informar sobre una recomendación de higiene y salud.', 'inicial', 25),
  ('Texto: ''El reciclaje ayuda a reducir la basura que llega a los vertederos.'' ¿Cuál es la idea más relevante del texto?', '["La basura siempre debe quemarse","El reciclaje reduce la cantidad de basura en los vertederos","Los vertederos son lugares agradables","El reciclaje no sirve para nada"]', 1, 'La idea principal es que el reciclaje reduce la basura que llega a los vertederos.', 'intermedia', 35),
  ('Un manual de instrucciones para armar un juguete tiene como propósito:', '["Convencer de comprar otro juguete","Describir los sentimientos del niño que lo recibe","Explicar los pasos para armar correctamente el juguete","Contar la historia del juguete"]', 2, 'El propósito de un manual es explicar los pasos para armar correctamente un objeto.', 'intermedia', 35),
  ('Texto: ''Según estudios recientes, dormir al menos ocho horas mejora la concentración y el ánimo durante el día.'' ¿Cuál es la idea principal que el texto busca transmitir?', '["Que dormir es una pérdida de tiempo","Que ocho horas de sueño son insuficientes","Que el ánimo no se relaciona con el sueño","Que dormir suficiente mejora la concentración y el ánimo"]', 3, 'El texto afirma explícitamente que dormir suficiente mejora la concentración y el ánimo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_4_basico' and lo.short_name = 'Propósito e ideas relevantes de textos no literarios'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Interpretación de lenguaje figurado simple
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En la frase ''sus ojos brillaban como estrellas'', ¿qué figura literaria se está usando?', '["Una comparación","Una instrucción","Una noticia","Una receta"]', 0, 'La frase compara los ojos con las estrellas usando la palabra ''como'', propio de una comparación.', 'inicial', 25),
  ('En la frase ''el viento susurraba entre los árboles'', ¿qué recurso se usa al decir que el viento ''susurraba''?', '["Un manual técnico","Una personificación (dar cualidades humanas al viento)","Una receta de cocina","Una lista de datos"]', 1, 'Atribuir la acción humana de ''susurrar'' al viento es una personificación.', 'intermedia', 35),
  ('¿Qué significa la comparación ''es fuerte como un toro''?', '["Que la persona es débil","Que la persona tiene cuernos","Que la persona tiene mucha fuerza","Que la persona es literalmente un toro"]', 2, 'La comparación indica que la persona tiene mucha fuerza, como un toro.', 'intermedia', 35),
  ('En el poema aparece la frase ''las olas bailaban en la orilla''. ¿Qué interpretación es correcta de esta personificación?', '["Que las olas literalmente sabían bailar como personas","Que no había olas ese día","Que la orilla estaba completamente seca","Que las olas se movían de forma similar a un baile"]', 3, 'La personificación sugiere que el movimiento de las olas se asemeja al de un baile, sin ser literal.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_4_basico' and lo.short_name = 'Interpretación de lenguaje figurado simple'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Opinión fundamentada sobre lo leído
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''El protagonista del cuento ayudó a un desconocido a pesar de tener poco tiempo.'' ¿Cuál de estas opiniones está mejor fundamentada con el texto?', '["El protagonista es solidario, porque ayudó a alguien aunque tenía poco tiempo","El protagonista es perezoso, porque no hizo nada","El protagonista es egoísta, porque solo pensó en sí mismo","El texto no permite opinar sobre el protagonista"]', 0, 'La opinión sobre su solidaridad se sustenta directamente en la acción descrita en el texto.', 'inicial', 25),
  ('Para fundamentar una opinión sobre un texto leído, ¿qué debes hacer?', '["No dar ninguna razón","Apoyar tu opinión con información o ejemplos del texto","Opinar sin relación con el texto","Copiar la opinión de otra persona"]', 1, 'Una opinión fundamentada se apoya en información o ejemplos extraídos del texto.', 'intermedia', 35),
  ('Texto: ''El personaje mintió a su familia para evitar un castigo.'' ¿Cuál opinión está mejor fundamentada?', '["El texto no dice si mintió","Actuó con mucha valentía, sin relación con la mentira","Actuó de forma poco honesta, porque mintió para evitar consecuencias","Actuó de forma perfecta, porque nunca mintió"]', 2, 'La opinión sobre su falta de honestidad se sustenta directamente en el hecho de mentir descrito en el texto.', 'intermedia', 35),
  ('Texto: ''La protagonista decidió compartir su almuerzo con un compañero que no tenía comida ese día.'' ¿Cuál de estas opiniones está mejor argumentada con evidencia del texto?', '["Su acción fue negativa, porque se quedó sin almuerzo","El texto no permite formar ninguna opinión","Su acción demuestra que no le gustaba su almuerzo","Su acción demuestra generosidad, ya que compartió lo que tenía con quien lo necesitaba"]', 3, 'Compartir con quien lo necesitaba respalda la opinión de que fue un acto generoso.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_4_basico' and lo.short_name = 'Opinión fundamentada sobre lo leído'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comparación de textos sobre un mismo tema
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un texto dice que el chocolate es saludable en pequeñas cantidades; otro dice que el chocolate siempre es dañino. ¿Qué se puede afirmar al compararlos?', '["Los textos presentan opiniones distintas sobre el mismo tema","Ambos textos dicen exactamente lo mismo","Ninguno de los textos habla sobre el chocolate","Los textos no se pueden comparar"]', 0, 'Ambos textos tratan el mismo tema pero presentan opiniones distintas.', 'inicial', 25),
  ('Dos noticias hablan del mismo partido de fútbol, pero una se enfoca en el equipo ganador y otra en el equipo perdedor. ¿Qué diferencia se puede identificar?', '["La fecha del partido, que es distinta en cada texto","El enfoque o punto de vista de cada noticia","El nombre del estadio, que es distinto en cada texto","El deporte del que hablan, que es distinto en cada texto"]', 1, 'La diferencia principal está en el enfoque que cada noticia le da al mismo hecho.', 'intermedia', 35),
  ('Al comparar dos cuentos sobre animales que ayudan a sus amigos, ¿qué elemento en común se puede identificar?', '["Que ninguno tiene personajes","Que tratan temas completamente distintos","El tema de la amistad y la ayuda entre animales","Que ambos cuentos son manuales técnicos"]', 2, 'Ambos cuentos comparten el tema de la amistad y la ayuda entre animales.', 'intermedia', 35),
  ('Un texto científico explica el ciclo del agua de forma técnica; un poema describe la lluvia con metáforas. Ambos tratan sobre el agua. ¿Qué diferencia principal existe entre ellos?', '["El tema, ya que uno habla del agua y el otro no","Que uno tiene título y el otro no","Que ambos son exactamente del mismo tipo de texto","El propósito y el lenguaje usado (informativo y técnico vs. literario y figurado)"]', 3, 'La diferencia principal está en el propósito y el tipo de lenguaje: informativo-técnico versus literario-figurado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_4_basico' and lo.short_name = 'Comparación de textos sobre un mismo tema'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: ESCRITURA — 4° BÁSICO
-- ============================================================================

-- Objetivo: Planificación, escritura y revisión de textos completos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es el primer paso al producir un texto completo (narración o texto informativo)?', '["Planificar las ideas principales antes de escribir","Revisar el texto antes de haberlo escrito","Publicar el texto sin escribirlo","Memorizar el diccionario completo"]', 0, 'Planificar las ideas principales es el primer paso antes de escribir un texto completo.', 'inicial', 25),
  ('Después de escribir un texto informativo completo, ¿qué corresponde hacer?', '["Copiarlo de otro compañero","Revisarlo para corregir errores y mejorar su claridad","Borrarlo inmediatamente","Entregarlo sin haberlo leído"]', 1, 'La etapa de revisión permite corregir errores y mejorar la claridad del texto.', 'intermedia', 35),
  ('¿Por qué es importante planificar antes de escribir un texto largo?', '["Para evitar escribir el texto","Para copiar de otro autor","Para organizar las ideas y no perder el hilo del tema","Para hacer el texto más corto sin sentido"]', 2, 'Planificar ayuda a organizar las ideas y mantener el hilo del tema durante la escritura.', 'intermedia', 35),
  ('Vas a escribir un texto informativo sobre el reciclaje. Planificas: 1) qué es el reciclaje, 2) por qué es importante, 3) cómo reciclar en casa. ¿Qué etapa del proceso de escritura corresponde a esto?', '["La revisión final","La publicación del texto","La corrección ortográfica exclusivamente","La planificación previa a la escritura"]', 3, 'Organizar las ideas antes de redactar corresponde a la etapa de planificación.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_4_basico' and lo.short_name = 'Planificación, escritura y revisión de textos completos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Conectores temporales y causales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Completa: ''Primero lavé los platos, ___ barrí la cocina.''', '["después","porque","aunque","sin embargo"]', 0, '''Después'' indica el orden temporal entre lavar los platos y barrer la cocina.', 'inicial', 25),
  ('¿Qué conector expresa causa en la oración ''Llegué tarde ___ el bus se atrasó''?', '["aunque","porque","luego","finalmente"]', 1, '''Porque'' introduce la causa de haber llegado tarde.', 'intermedia', 35),
  ('¿Cuál de estos conectores indica orden temporal (secuencia en el tiempo)?', '["Sin embargo","Aunque","Luego","Porque"]', 2, '''Luego'' indica una secuencia temporal entre dos acciones.', 'intermedia', 35),
  ('En el texto ''Estudié toda la semana. ___, aprobé el examen con buena nota'', ¿qué conector causal es más adecuado?', '["Antes","Mientras","Después de que","Por eso"]', 3, '''Por eso'' expresa la consecuencia de haber estudiado toda la semana.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_4_basico' and lo.short_name = 'Conectores temporales y causales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Ortografía literal y acentual
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas palabras respeta la ortografía correcta de la letra ''h'' y su acentuación?', '["exhibición","exivicion","exivición","exhibision"]', 0, 'La forma correcta es ''exhibición'', con ''h'' y tilde en la ''o''.', 'inicial', 25),
  ('¿Cuál de estas palabras necesita tilde?', '["planta","árbol","arbol","arbusto"]', 1, '''Árbol'' requiere tilde según las reglas de acentuación.', 'intermedia', 35),
  ('¿Cuál palabra usa correctamente la ''h''?', '["jospital","osspital","hospital","ospital"]', 2, 'La forma correcta de esta palabra es ''hospital'', con ''h''.', 'intermedia', 35),
  ('En la oración ''el examen fue dificil pero lo aprove'', ¿qué palabras deben corregirse según las normas de ortografía y acentuación?', '["Solo ''dificil'' debe cambiar","Solo ''aprove'' debe cambiar","Ninguna palabra necesita corrección","''dificil'' debe ser ''difícil'' y ''aprove'' debe ser ''aprobé''"]', 3, 'Ambas palabras requieren corrección: ''difícil'' lleva tilde y ''aprobé'' es la forma correcta del verbo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_4_basico' and lo.short_name = 'Ortografía literal y acentual'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Vocabulario preciso en la escritura
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En vez de escribir ''la casa era grande'', ¿cuál palabra da una descripción más precisa del tamaño?', '["Enorme","Pequeña","Normal","Fea"]', 0, '''Enorme'' precisa más el tamaño que la palabra genérica ''grande''.', 'inicial', 25),
  ('Para describir con precisión el sonido de un trueno, ¿cuál palabra es más adecuada que ''ruido''?', '["Aroma","Estruendo","Silencio","Murmullo"]', 1, '''Estruendo'' describe con más precisión un sonido fuerte como el de un trueno.', 'intermedia', 35),
  ('¿Cuál de estas palabras describe con más precisión una sensación de mucho frío?', '["Cálido","Templado","Helado","Tibio"]', 2, '''Helado'' describe con precisión una sensación de mucho frío.', 'intermedia', 35),
  ('Escribiste: ''El animal caminaba y hacía ruido.'' Para hacer el texto más preciso, ¿qué palabras podrías usar en lugar de ''caminaba'' y ''ruido'' si el animal era un elefante pesado?', '["''Volaba'' y ''un aroma dulce''","''Nadaba'' y ''un silencio total''","Dejar las palabras exactamente iguales","''Avanzaba pesadamente'' y ''un fuerte estruendo''"]', 3, 'Las expresiones ''avanzaba pesadamente'' y ''un fuerte estruendo'' describen con más precisión a un elefante pesado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_4_basico' and lo.short_name = 'Vocabulario preciso en la escritura'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMUNICACIÓN ORAL — 4° BÁSICO
-- ============================================================================

-- Objetivo: Exposición oral con recursos visuales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Preparas una exposición sobre el sistema solar con imágenes en diapositivas. ¿Qué función cumplen las imágenes?', '["Apoyar visualmente la explicación oral","Reemplazar completamente lo que vas a decir","Distraer al público del tema","Ninguna, son solo decoración sin relación"]', 0, 'Las imágenes cumplen la función de apoyar visualmente lo que se explica oralmente.', 'inicial', 25),
  ('¿Cuál de estas es una buena práctica al exponer con recursos visuales (láminas, diapositivas)?', '["No mirar nunca al público","Organizar las ideas en introducción, desarrollo y cierre, apoyándote en los recursos","Leer cada palabra de la diapositiva sin explicar nada más","Mostrar las imágenes al revés"]', 1, 'Organizar las ideas y usar los recursos como apoyo, sin leerlos literalmente, es una buena práctica.', 'intermedia', 35),
  ('Si tu exposición tiene 3 diapositivas: introducción, desarrollo y cierre, ¿en qué diapositiva deberías presentar el tema y captar la atención?', '["En el cierre","En ninguna, se hace después de terminar","En la introducción","En el desarrollo"]', 2, 'La introducción es la parte donde se presenta el tema y se busca captar la atención.', 'intermedia', 35),
  ('Expones sobre los volcanes con un mapa de Chile mostrando su ubicación. Un compañero pregunta algo que el mapa no responde. ¿Qué deberías hacer?', '["Decir que el mapa no sirve para nada","Ignorar la pregunta por completo","Terminar la exposición inmediatamente","Responder con la información que investigaste, aunque no esté en el mapa"]', 3, 'Responder con la información investigada, más allá del recurso visual, es lo más adecuado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_4_basico' and lo.short_name = 'Exposición oral con recursos visuales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Discusiones grupales respetando opiniones
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una discusión grupal, un compañero opina algo distinto a ti. ¿Qué actitud demuestra respeto?', '["Escuchar su opinión y responder sin descalificarlo","Burlarte de su opinión","Gritarle para que no siga hablando","Ignorarlo completamente"]', 0, 'Escuchar y responder sin descalificar demuestra respeto por la opinión distinta.', 'inicial', 25),
  ('¿Qué se espera de los participantes en una discusión grupal respetuosa?', '["No participar en absoluto","Escuchar, esperar el turno y argumentar con respeto","Interrumpir constantemente a los demás","Imponer la propia opinión sin escuchar"]', 1, 'Se espera escuchar, esperar el turno y argumentar con respeto en una discusión grupal.', 'intermedia', 35),
  ('Durante una discusión, un compañero cambia de opinión después de escuchar un buen argumento. ¿Qué demuestra esta actitud?', '["Que está siendo irrespetuoso","Que no participó en la discusión","Apertura para considerar otros puntos de vista","Que no tenía ninguna opinión propia"]', 2, 'Cambiar de opinión ante un buen argumento demuestra apertura y disposición a considerar otros puntos de vista.', 'intermedia', 35),
  ('En un grupo se discute sobre qué juego jugar en el recreo. Dos opiniones distintas se presentan con buenos argumentos. ¿Cuál es la forma más respetuosa de llegar a un acuerdo?', '["Que el más fuerte del grupo decida solo","Dejar de hablar del tema para siempre","Que cada uno juegue solo, sin grupo","Conversar y buscar una solución que considere ambas opiniones"]', 3, 'Conversar y buscar una solución que considere ambas opiniones es la forma más respetuosa de acordar.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_4_basico' and lo.short_name = 'Discusiones grupales respetando opiniones'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión crítica de mensajes audiovisuales simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Ves un comercial de televisión que dice que un producto ''es el mejor del mundo''. ¿Qué actitud crítica es adecuada?', '["Cuestionar si esa afirmación tiene pruebas reales","Creer todo lo que dice sin dudar","Comprar el producto de inmediato sin pensar","Ignorar que existe publicidad"]', 0, 'Cuestionar si la afirmación tiene pruebas reales es una actitud crítica adecuada frente a la publicidad.', 'inicial', 25),
  ('Un video en internet muestra información sin citar ninguna fuente. ¿Qué deberías considerar antes de creerlo?', '["Que los videos nunca contienen errores","Que la información podría no ser confiable sin una fuente","Que toda la información en internet es siempre verdadera","Que no es necesario revisar la fuente"]', 1, 'La falta de fuente citada es una señal de que la información podría no ser confiable.', 'intermedia', 35),
  ('¿Por qué es importante analizar críticamente un mensaje audiovisual (como un comercial o un video)?', '["Porque no se debe ver ningún video","Porque la crítica no tiene ninguna utilidad","Para no dejarse convencer sin pensar en la información presentada","Porque todos los mensajes audiovisuales son falsos"]', 2, 'Analizar críticamente ayuda a no dejarse convencer sin evaluar la información presentada.', 'intermedia', 35),
  ('Un video afirma que comer cierto alimento cura todas las enfermedades. ¿Cuál es la reacción más crítica y adecuada?', '["Creer inmediatamente la afirmación","Compartir el video sin verificarlo","Dejar de comer cualquier alimento","Dudar de la afirmación y buscar información en fuentes confiables"]', 3, 'Dudar y verificar en fuentes confiables es la reacción más crítica ante una afirmación exagerada.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_4_basico' and lo.short_name = 'Comprensión crítica de mensajes audiovisuales simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Registro adecuado a la situación comunicativa
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 4° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al hablar con tu director en la oficina, ¿qué registro (forma de hablar) es más adecuado?', '["Un registro formal y respetuoso","Un registro con groserías","Un registro igual al que usas con tus amigos en el recreo","Gritar sin explicar nada"]', 0, 'Con el director corresponde usar un registro formal y respetuoso.', 'inicial', 25),
  ('Cuando conversas con tus amigos en el recreo, ¿qué registro es más habitual usar?', '["No hablar en absoluto","Un registro informal y cercano","Un registro extremadamente formal como en un discurso oficial","Un registro solo con palabras técnicas"]', 1, 'Con amigos en el recreo es habitual usar un registro informal y cercano.', 'intermedia', 35),
  ('¿Por qué es importante adecuar el registro según la situación comunicativa?', '["Porque el registro no tiene ninguna importancia","Porque solo existe una forma correcta de hablar en todo momento","Porque permite comunicarse de forma apropiada según el contexto y la persona","Porque siempre se debe hablar de la misma manera"]', 2, 'Adecuar el registro permite comunicarse de forma apropiada según el contexto y la persona.', 'intermedia', 35),
  ('Estás escribiendo un correo formal a tu profesor para justificar una inasistencia. ¿Cuál inicio es más adecuado según el registro que corresponde?', '["''Hola, ¿qué onda? no fui po''","''Oiga, no fui y ya''","Sin saludo, directo a exigir algo","''Estimado profesor, junto con saludar, quisiera informarle que...''"]', 3, 'Un correo formal a un profesor requiere un registro formal, como ''Estimado profesor, junto con saludar...''.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_4_basico' and lo.short_name = 'Registro adecuado a la situación comunicativa'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
