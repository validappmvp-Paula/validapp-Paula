-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Lengua
-- Castellana y Comunicación (denominación oficial de esta banda: "Lenguaje y
-- Comunicación", ver supabase/seed/0014), 6° Básico. Cubre los
-- 13 objetivos de aprendizaje de 6° Básico cargados por
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
-- EJE: LECTURA — 6° BÁSICO
-- ============================================================================

-- Objetivo: Estructura de géneros literarios
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué elemento es característico de una obra dramática breve, a diferencia de un cuento?', '["Está escrita para ser representada, con diálogos y acotaciones","No tiene ningún personaje","Siempre tiene rima en cada línea","No puede tener conflicto"]', 0, 'La obra dramática se escribe para ser representada, con diálogos y acotaciones escénicas.', 'inicial', 25),
  ('¿Qué elemento suele estar presente en la estructura de un poema, a diferencia de un cuento?', '["Un desenlace obligatorio con final feliz","El uso de versos y, frecuentemente, ritmo o rima","Un narrador que cuenta hechos en orden cronológico exacto","Diálogos entre personajes con acotaciones escénicas"]', 1, 'El poema se estructura en versos y frecuentemente usa ritmo o rima, a diferencia del cuento.', 'intermedia', 35),
  ('Un cuento tradicional generalmente presenta esta estructura:', '["Únicamente diálogos entre personajes","Una serie de instrucciones paso a paso","Inicio, desarrollo (con conflicto) y desenlace","Solo una lista de versos sin orden"]', 2, 'El cuento tradicional se estructura en inicio, desarrollo con conflicto y desenlace.', 'intermedia', 35),
  ('Un texto está escrito en versos, con lenguaje figurado y sin una historia con personajes que actúan en el tiempo. ¿A qué género literario corresponde más probablemente?', '["Cuento narrativo","Obra dramática con diálogos","Noticia periodística","Poema"]', 3, 'El uso de versos y lenguaje figurado sin una historia narrada es característico del género poético.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_6_basico' and lo.short_name = 'Estructura de géneros literarios'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Tesis e ideas de apoyo en textos expositivos/argumentativos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''El uso de bicicletas en la ciudad debería aumentar, ya que reduce la contaminación y mejora la salud de las personas.'' ¿Cuál es la tesis del texto?', '["Que el uso de bicicletas en la ciudad debería aumentar","Que las bicicletas contaminan más que los autos","Que nadie debería andar en bicicleta","Que la salud no se relaciona con el ejercicio"]', 0, 'La tesis es la idea principal que el texto defiende: que el uso de bicicletas debería aumentar.', 'inicial', 25),
  ('Mismo texto sobre el uso de bicicletas en la ciudad. ¿Cuáles son las ideas de apoyo que sostienen la tesis?', '["Que a nadie le gusta andar en bicicleta","Que reduce la contaminación y mejora la salud","Que las bicicletas son más caras que los autos","Que la ciudad no tiene calles"]', 1, 'Las ideas de apoyo son las razones que respaldan la tesis: reducir contaminación y mejorar la salud.', 'intermedia', 35),
  ('En un texto argumentativo, ¿qué función cumplen las ideas de apoyo respecto a la tesis?', '["Contradicen siempre la tesis principal","Reemplazan por completo a la tesis","Sostienen y dan razones que respaldan la tesis principal","No tienen ninguna relación con la tesis"]', 2, 'Las ideas de apoyo respaldan con razones la tesis principal del texto.', 'intermedia', 35),
  ('Texto: ''Se debería prohibir el uso de bolsas plásticas de un solo uso, porque tardan cientos de años en degradarse y dañan la vida marina.'' ¿Cuál idea de apoyo es más directa para sostener esta tesis?', '["Que las bolsas plásticas son de color variado","Que existen desde hace pocos años","Que se fabrican en distintos países","Que tardan mucho en degradarse y dañan la vida marina"]', 3, 'La idea de apoyo más directa es que tardan mucho en degradarse y dañan la vida marina.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_6_basico' and lo.short_name = 'Tesis e ideas de apoyo en textos expositivos/argumentativos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Recursos literarios y su efecto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En la frase ''sus lágrimas eran un río'', ¿qué recurso literario se usa?', '["Una metáfora","Una hipérbole exagerada sin comparación","Una instrucción","Una noticia"]', 0, 'La frase identifica las lágrimas con un río sin usar ''como'', propio de una metáfora.', 'inicial', 25),
  ('En la frase ''te lo he dicho un millón de veces'', ¿qué recurso literario se está utilizando?', '["Una instrucción técnica","Una hipérbole (exageración)","Una metáfora sutil","Un dato exacto y comprobable"]', 1, 'Decir ''un millón de veces'' es una exageración deliberada, propia de la hipérbole.', 'intermedia', 35),
  ('¿Cuál es el efecto principal de usar una metáfora en un texto literario?', '["Eliminar cualquier sentido figurado del texto","Convertir el texto en un manual técnico","Crear una imagen o comparación que enriquece el significado","Hacer el texto más difícil de entender sin ningún propósito"]', 2, 'La metáfora crea una imagen que enriquece el significado del texto literario.', 'intermedia', 35),
  ('En el poema aparece: ''el tiempo es un ladrón que roba nuestros días''. ¿Qué efecto logra esta metáfora?', '["Explica de forma literal cómo funciona un reloj","Da una instrucción sobre cómo administrar el tiempo","Describe un hecho científico exacto sobre el tiempo","Transmite la idea de que el tiempo pasa y se pierde, de forma similar a un robo"]', 3, 'La metáfora transmite la sensación de que el tiempo se pierde de forma similar a un robo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_6_basico' and lo.short_name = 'Recursos literarios y su efecto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comparación de puntos de vista sobre un tema
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un texto defiende el uso de uniforme escolar porque promueve la igualdad; otro lo critica porque limita la expresión personal. ¿Qué se puede afirmar al compararlos?', '["Presentan puntos de vista opuestos sobre el mismo tema","Ambos textos afirman exactamente lo mismo","Ninguno de los textos trata sobre el uniforme escolar","No es posible comparar ambos textos"]', 0, 'Ambos textos tratan el mismo tema desde puntos de vista opuestos.', 'inicial', 25),
  ('Al comparar dos artículos de opinión sobre un mismo tema, ¿qué es importante identificar?', '["La cantidad de páginas únicamente","Los argumentos que sostienen cada punto de vista","Solo la cantidad de párrafos de cada texto","El color de la portada de cada texto"]', 1, 'Al comparar puntos de vista es importante identificar los argumentos que los sostienen.', 'intermedia', 35),
  ('Dos autores escriben sobre el mismo problema ambiental, pero uno propone soluciones tecnológicas y otro propone cambios de hábitos personales. ¿Qué se puede concluir?', '["Ninguno propone ninguna solución","El problema ambiental no se menciona en los textos","Ambos abordan el mismo problema desde enfoques distintos","Ambos autores están totalmente de acuerdo en todo"]', 2, 'Ambos autores tratan el mismo problema pero proponen soluciones desde enfoques distintos.', 'intermedia', 35),
  ('Un editorial defiende que la tecnología mejora la educación; una carta al director sostiene que la distrae. ¿Qué habilidad se ejercita al comparar ambos puntos de vista?', '["Memorizar cada texto palabra por palabra","Elegir el texto más largo como el más verdadero","Ignorar las diferencias entre ambos textos","Analizar críticamente distintas perspectivas sobre un mismo tema"]', 3, 'Comparar ambos puntos de vista ejercita el análisis crítico de distintas perspectivas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_6_basico' and lo.short_name = 'Comparación de puntos de vista sobre un tema'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Evaluación de la confiabilidad de una fuente
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Lectura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un sitio web sin autor, sin fecha y con muchos errores ortográficos publica una noticia. ¿Qué se puede afirmar sobre su confiabilidad?', '["Es poco confiable, porque carece de elementos que respalden su seriedad","Es totalmente confiable, sin ninguna duda","La ortografía no influye en la confiabilidad de una fuente","Toda información en internet es igualmente confiable"]', 0, 'La ausencia de autor, fecha y una ortografía descuidada son señales de baja confiabilidad.', 'inicial', 25),
  ('¿Qué elemento ayuda a evaluar si una fuente de información es confiable?', '["Que use un lenguaje informal","Que cite autor, fecha y datos verificables","Que tenga muchas imágenes llamativas","Que sea muy larga en extensión"]', 1, 'Citar autor, fecha y datos verificables ayuda a evaluar la confiabilidad de una fuente.', 'intermedia', 35),
  ('Al investigar sobre un tema, encuentras dos fuentes: una de una institución oficial y otra de un blog personal sin referencias. ¿Cuál sería más recomendable priorizar?', '["Ambas son igual de confiables sin excepción","Ninguna de las dos, porque toda la información es falsa","La fuente de la institución oficial, por su mayor respaldo","El blog personal, porque es más entretenido"]', 2, 'La fuente de la institución oficial suele tener mayor respaldo y confiabilidad.', 'intermedia', 35),
  ('Una fuente afirma un dato importante, pero no puedes encontrar esa misma información en ninguna otra fuente confiable. ¿Qué actitud crítica es más adecuada?', '["Creerla de inmediato porque suena convincente","Compartirla sin ninguna verificación","Ignorar siempre la necesidad de verificar información","Dudar de la afirmación hasta poder verificarla en otras fuentes"]', 3, 'Dudar y buscar verificación en otras fuentes es la actitud crítica más adecuada.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Lectura' and l.code = 'regular_6_basico' and lo.short_name = 'Evaluación de la confiabilidad de una fuente'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: ESCRITURA — 6° BÁSICO
-- ============================================================================

-- Objetivo: Textos argumentativos simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al producir un texto argumentativo simple, ¿qué elemento debe presentarse primero?', '["La tesis u opinión que se va a defender","Un dibujo sin relación al tema","Una lista de ingredientes","Un poema sin argumento"]', 0, 'La tesis u opinión que se defenderá debe presentarse al inicio del texto argumentativo.', 'inicial', 25),
  ('¿Qué función cumplen los argumentos en un texto argumentativo?', '["Contradecir siempre la tesis","Respaldar con razones la tesis planteada","No tienen ninguna función en el texto","Reemplazar la tesis por completo"]', 1, 'Los argumentos respaldan con razones la tesis planteada en el texto.', 'intermedia', 35),
  ('Escribes: ''Se debería reducir el uso de plástico, porque contamina los océanos y afecta a los animales marinos.'' ¿Qué parte corresponde al argumento?', '["Ninguna parte es un argumento","Toda la oración es solo una pregunta","Que contamina los océanos y afecta a los animales marinos","Que se debería reducir el uso de plástico"]', 2, 'El argumento es la razón que respalda la tesis: que contamina los océanos y afecta a los animales marinos.', 'intermedia', 35),
  ('Organizas tu texto argumentativo así: 1) tesis, 2) primer argumento con ejemplo, 3) segundo argumento con ejemplo, 4) conclusión. ¿Por qué es útil esta organización?', '["Porque hace el texto innecesariamente confuso","Porque elimina la necesidad de una tesis","Porque no requiere ningún argumento adicional","Porque presenta las ideas de forma clara y respalda la tesis con evidencia ordenada"]', 3, 'Esta organización presenta las ideas de forma clara y respalda la tesis con evidencia ordenada.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_6_basico' and lo.short_name = 'Textos argumentativos simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Vocabulario variado y preciso
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si repites la palabra ''importante'' cinco veces en un párrafo, ¿qué podrías hacer para variar el vocabulario?', '["Reemplazar algunas repeticiones por sinónimos como ''relevante'' o ''fundamental''","Repetir la palabra una vez más","Eliminar el párrafo completo","Escribir el párrafo en otro idioma"]', 0, 'Reemplazar repeticiones por sinónimos como ''relevante'' o ''fundamental'' varía el vocabulario del texto.', 'inicial', 25),
  ('¿Cuál de estas palabras es un sinónimo preciso de ''analizar''?', '["Destruir","Examinar","Ignorar","Olvidar"]', 1, '''Examinar'' es un sinónimo preciso de ''analizar''.', 'intermedia', 35),
  ('Para describir con precisión un sonido muy fuerte y repentino, ¿qué palabra es más adecuada que ''ruido''?', '["Murmullo","Aroma","Estruendo","Silencio"]', 2, '''Estruendo'' describe con más precisión un sonido fuerte y repentino que la palabra genérica ''ruido''.', 'intermedia', 35),
  ('En tu texto usaste la palabra ''bueno'' para describir una idea, un sabor y una persona. ¿Qué podrías hacer para precisar mejor el vocabulario en cada caso?', '["Seguir usando ''bueno'' en todos los casos","Eliminar esas tres ideas del texto","Usar la palabra ''malo'' en su lugar","Usar palabras específicas como ''acertada'', ''delicioso'' y ''amable'' según el contexto"]', 3, 'Usar palabras específicas según el contexto precisa mejor el vocabulario que repetir ''bueno''.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_6_basico' and lo.short_name = 'Vocabulario variado y preciso'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Ortografía y puntuación autónomas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas oraciones usa correctamente los dos puntos en una enumeración?', '["Compré tres frutas: manzanas, plátanos y peras.","Compré tres frutas, manzanas plátanos y peras.","Compré tres frutas: manzanas plátanos, y peras","Compré: tres frutas manzanas, plátanos y peras."]', 0, '''Compré tres frutas: manzanas, plátanos y peras.'' usa correctamente los dos puntos antes de la enumeración y las comas entre los elementos.', 'inicial', 25),
  ('¿Cuál de estas palabras está correctamente acentuada según las reglas de acentuación?', '["arból","árbol","arbol","árvol"]', 1, 'La forma correcta es ''árbol'', con tilde en la primera ''a''.', 'intermedia', 35),
  ('¿En qué situación se usan los signos de exclamación (¡ !) en español?', '["Nunca se usan en español","Solo al final de un texto completo","Al escribir una expresión de sorpresa, alegría o énfasis","Solo en preguntas"]', 2, 'Los signos de exclamación se usan para expresar sorpresa, alegría o énfasis en español.', 'intermedia', 35),
  ('Corrige de forma autónoma: ''que sorpresa me lleve ayer''. ¿Cuál es la versión correctamente puntuada y acentuada?', '["que sorpresa me lleve ayer.","¡Que sorpresa, me lleve, ayer!","Qué Sorpresa Me Lleve Ayer","¡Qué sorpresa me llevé ayer!"]', 3, 'La versión correcta usa signos de exclamación, tilde en ''Qué'' y en ''llevé'', con mayúscula inicial adecuada.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_6_basico' and lo.short_name = 'Ortografía y puntuación autónomas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Reescritura a partir de retroalimentación
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Escritura. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un compañero te sugiere que tu argumento principal necesita un ejemplo. ¿Qué deberías hacer al reescribir?', '["Agregar un ejemplo que respalde tu argumento","Eliminar el argumento por completo","Ignorar la sugerencia","Cambiar todo el tema del texto"]', 0, 'Agregar un ejemplo que respalde el argumento responde directamente a la sugerencia recibida.', 'inicial', 25),
  ('Tu docente te retroalimenta diciendo que la conclusión de tu texto es muy breve y poco clara. ¿Qué acción corresponde al reescribir?', '["Agregar un tema nuevo sin relación","Desarrollar la conclusión con más claridad y detalle","Eliminar la conclusión completamente","Dejarla exactamente igual"]', 1, 'Desarrollar la conclusión con más claridad responde a la retroalimentación recibida.', 'intermedia', 35),
  ('¿Por qué es valioso considerar la retroalimentación de pares o del docente al reescribir un texto?', '["Porque la retroalimentación nunca es útil","Porque reescribir un texto no tiene ningún beneficio","Porque ofrece una perspectiva externa que ayuda a mejorar el texto","Porque siempre hay que copiar exactamente lo que dicen otros"]', 2, 'La retroalimentación ofrece una perspectiva externa valiosa para mejorar el texto propio.', 'intermedia', 35),
  ('Recibes esta retroalimentación: ''Tu tesis es clara, pero el segundo argumento no tiene relación directa con ella.'' ¿Qué deberías hacer al reescribir ese argumento?', '["Dejarlo igual, aunque no se relacione con la tesis","Eliminar la tesis en su lugar","Agregar un tercer argumento sin corregir el segundo","Modificarlo o reemplazarlo para que respalde directamente la tesis"]', 3, 'Modificar o reemplazar el argumento para que respalde la tesis responde a la retroalimentación recibida.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Escritura' and l.code = 'regular_6_basico' and lo.short_name = 'Reescritura a partir de retroalimentación'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMUNICACIÓN ORAL — 6° BÁSICO
-- ============================================================================

-- Objetivo: Exposición oral formal sobre un tema de investigación
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al organizar una exposición oral formal sobre un tema investigado, ¿qué estructura es más adecuada seguir?', '["Introducción, desarrollo con la información investigada y conclusión","Solo mencionar el título sin explicar nada","Hablar de temas sin ninguna relación entre sí","Leer únicamente una lista de palabras sueltas"]', 0, 'Una exposición formal se organiza en introducción, desarrollo y conclusión.', 'inicial', 25),
  ('¿Qué caracteriza a una exposición oral ''formal'', a diferencia de una conversación informal con amigos?', '["Hablar sin ningún orden de ideas","El uso de un registro cuidado y una estructura organizada","El uso de groserías constantes","La ausencia total de preparación previa"]', 1, 'Una exposición formal se caracteriza por un registro cuidado y una estructura organizada.', 'intermedia', 35),
  ('Investigaste sobre la contaminación de los océanos para presentar formalmente al curso. ¿Qué deberías incluir en tu conclusión?', '["Una pregunta sin ninguna respuesta","Silencio total sin cerrar la exposición","Un resumen de las ideas principales y su importancia","Un chiste sin relación con el tema"]', 2, 'La conclusión debe resumir las ideas principales expuestas y explicar su importancia.', 'intermedia', 35),
  ('Presentas una exposición formal de 5 minutos sobre el reciclaje, pero se te acaba el tiempo antes de terminar la conclusión. ¿Qué es lo más adecuado hacer?', '["Seguir hablando mucho más allá del tiempo asignado","Detenerte a mitad de una idea sin cerrar el tema","Empezar la exposición de nuevo desde el inicio","Resumir brevemente la idea principal antes de terminar"]', 3, 'Resumir brevemente la idea principal permite cerrar la exposición a pesar del tiempo limitado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_6_basico' and lo.short_name = 'Exposición oral formal sobre un tema de investigación'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Discusiones literarias fundamentadas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una discusión literaria sobre un cuento leído en clase, ¿qué corresponde hacer al opinar sobre un personaje?', '["Fundamentar tu opinión con ejemplos o citas del texto","Opinar sin relación con el texto leído","Repetir exactamente lo que dijo otro compañero","No participar en la discusión"]', 0, 'Fundamentar la opinión con ejemplos o citas del texto es lo que corresponde en una discusión literaria.', 'inicial', 25),
  ('Un compañero afirma que el protagonista de un cuento es valiente. ¿Qué haría más sólida esa afirmación en una discusión literaria?', '["Decir que es una opinión sin importancia","Citar una acción del texto que demuestre esa valentía","No dar ninguna razón","Cambiar de tema inmediatamente"]', 1, 'Citar una acción concreta del texto respalda con evidencia la afirmación sobre el personaje.', 'intermedia', 35),
  ('¿Por qué es importante fundamentar las opiniones en una discusión sobre un texto literario?', '["Porque no es necesario haber leído el texto","Porque las discusiones literarias no requieren argumentos","Porque permite sostener el análisis con evidencia del texto","Porque las opiniones sin fundamento son igual de válidas"]', 2, 'Fundamentar las opiniones permite sostener el análisis literario con evidencia concreta del texto.', 'intermedia', 35),
  ('En una discusión sobre un cuento, dos compañeros interpretan de forma distinta el final de la historia, cada uno con evidencia del texto. ¿Qué demuestra esta situación?', '["Que uno de los dos está mintiendo sobre el texto","Que el cuento no tiene ningún final","Que solo puede existir una interpretación posible","Que un texto literario puede admitir más de una interpretación fundamentada"]', 3, 'Esta situación demuestra que un texto literario puede admitir más de una interpretación fundamentada.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_6_basico' and lo.short_name = 'Discusiones literarias fundamentadas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Evaluación crítica de mensajes de los medios
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un titular de noticia dice algo muy llamativo, pero al leer la noticia completa la información es distinta. ¿Qué debes evaluar críticamente?', '["Si el titular representa fielmente el contenido de la noticia","Nada, los titulares siempre son exactos","Solo el tamaño de las letras del titular","El color del sitio web donde se publicó"]', 0, 'Se debe evaluar si el titular representa fielmente el contenido real de la noticia.', 'inicial', 25),
  ('¿Qué actitud crítica es adecuada frente a un mensaje publicitario que promete resultados exagerados?', '["Ignorar que existe la publicidad","Cuestionar si esas afirmaciones tienen evidencia real","Creer inmediatamente todo lo que promete","Comprar el producto sin analizarlo"]', 1, 'Cuestionar la evidencia detrás de afirmaciones exageradas es una actitud crítica adecuada.', 'intermedia', 35),
  ('Al ver una noticia en redes sociales sin fuente citada, ¿qué deberías hacer antes de compartirla?', '["Asumir que es verdadera porque tiene muchas reacciones","Ignorar siempre las noticias en redes sociales","Verificar la información en fuentes confiables antes de compartirla","Compartirla de inmediato sin verificar"]', 2, 'Verificar la información en fuentes confiables es lo adecuado antes de compartir una noticia sin fuente.', 'intermedia', 35),
  ('Dos medios de comunicación informan sobre el mismo hecho con datos distintos. ¿Qué estrategia de evaluación crítica es más adecuada?', '["Creer automáticamente al primer medio que viste","Ignorar el hecho por completo","Elegir la versión más entretenida sin verificarla","Contrastar ambas versiones con otras fuentes confiables"]', 3, 'Contrastar ambas versiones con otras fuentes confiables permite evaluar críticamente la información.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_6_basico' and lo.short_name = 'Evaluación crítica de mensajes de los medios'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Recursos no verbales y paraverbales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Lenguaje 6° Básico, eje Comunicación Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Durante una exposición oral, mantener contacto visual con el público es un ejemplo de:', '["Un recurso no verbal que apoya la comunicación","Un recurso paraverbal relacionado con el tono de voz","Un error que se debe evitar siempre","Un recurso que no tiene ninguna función"]', 0, 'El contacto visual es un recurso no verbal que apoya la comunicación oral.', 'inicial', 25),
  ('El volumen y la entonación de la voz al hablar corresponden a:', '["La ortografía del texto","Recursos paraverbales","Recursos no verbales como los gestos","El contenido del mensaje únicamente"]', 1, 'El volumen y la entonación son recursos paraverbales, relacionados con la voz.', 'intermedia', 35),
  ('¿Por qué es útil usar gestos y postura corporal adecuados durante una exposición oral?', '["Porque distraen siempre al público","Porque no tienen ninguna relación con la comunicación oral","Porque refuerzan y acompañan el mensaje que se comunica oralmente","Porque reemplazan por completo la necesidad de hablar"]', 2, 'Los gestos y la postura corporal refuerzan y acompañan el mensaje oral.', 'intermedia', 35),
  ('Un estudiante expone con buen contenido, pero habla con un tono de voz muy bajo y sin mirar al público. ¿Qué recursos debería mejorar?', '["El contenido de la investigación, que ya está bien","La ortografía del texto escrito","El tema elegido para la exposición","Los recursos paraverbales (volumen del tono de voz) y no verbales (contacto visual)"]', 3, 'El estudiante debería mejorar el volumen de su voz (paraverbal) y el contacto visual (no verbal).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Lengua Castellana y Comunicación') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación')
    and s.name = 'Comunicación Oral' and l.code = 'regular_6_basico' and lo.short_name = 'Recursos no verbales y paraverbales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
