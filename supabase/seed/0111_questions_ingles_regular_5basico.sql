-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Idioma
-- Extranjero: Inglés, 5° Básico. Cubre los 16 objetivos de aprendizaje de
-- 5° Básico cargados por supabase/seed/0023_curriculum_ingles_regular_basica_5_6.sql
-- (4 ejes: Comprensión Auditiva, Comprensión Lectora, Expresión Oral,
-- Expresión Escrita), con 4 preguntas por objetivo (dentro del rango 3-5
-- pedido), total 64 preguntas en este archivo.
--
-- ============================================================================
-- ESTADO EDITORIAL Y DE VALIDACIÓN (léase antes de aprobar cualquier fila)
-- ============================================================================
-- Mismo patrón que el resto del banco (Matemática 0026-0031/0050-0053,
-- Lenguaje 0080-0085, Ciencias/Historia 0086-0097): `review_status =
-- 'borrador'`, `validation_status = 'ai_generated_review_required'`,
-- `is_active = true`, `source_type = 'validapp_original'`, `generated_by =
-- 'claude-sonnet-5'`. Ninguna fila cumple `validation_status =
-- 'approved_for_exam'` + `review_status = 'aprobado'`, por lo que ninguna
-- pregunta de este archivo es usable todavía en un ensayo o diagnóstico real.
-- Requieren revisión pedagógica humana antes de cualquier cambio de estado
-- (trigger `questions_prevent_ai_self_approval` de la migración 0023 lo
-- impide para cualquier agente).
--
-- ============================================================================
-- CRITERIO DE IDIOMA USADO EN ESTE ARCHIVO (5° Básico, nivel A1 inicial)
-- ============================================================================
-- 5° Básico es el primer curso con enseñanza obligatoria de Inglés en Chile
-- (ver decisión documentada en el encabezado de supabase/seed/0023). Se aplicó
-- el siguiente criterio pedagógico:
--   - Las INSTRUCCIONES y preguntas "meta" (p. ej. "¿qué significa...?", "¿qué
--     instrucción da...?") se formulan en ESPAÑOL, porque en este nivel A1
--     inicial el estudiante recién está aprendiendo a decodificar inglés y no
--     se le puede exigir comprender un enunciado completo en un segundo
--     idioma que todavía no domina -- mismo criterio aplicado por el resto
--     del banco (p. ej. Lenguaje, supabase/seed/0080-0085) al no forzar un
--     único formato rígido.
--   - El CONTENIDO evaluado (palabras, frases, diálogos breves, textos de
--     apoyo) se presenta SIEMPRE en inglés, entre comillas, replicando el
--     patrón de "Texto: '...' Pregunta: ..." usado en Lenguaje para
--     comprensión lectora (ver supabase/seed/0084).
--   - Las ALTERNATIVAS están en español cuando la pregunta pide traducir o
--     identificar un significado/función (p. ej. "¿qué significa esta
--     palabra?"), y en inglés cuando la pregunta pide reconocer, completar o
--     producir una palabra/frase en inglés (p. ej. completar oraciones,
--     elegir la forma correcta de una frase).
--   - No se evalúa ortografía en inglés mediante escritura libre (no aplica a
--     selección múltiple); se evalúa mediante reconocimiento de la opción
--     correctamente formada/puntuada, siguiendo el mismo criterio usado en
--     Lenguaje para "convenciones de escritura" (ver supabase/seed/0084).
--
-- ============================================================================
-- FUENTE Y NIVEL DE CONFIANZA
-- ============================================================================
-- Los enunciados son redacción ORIGINAL de ValidApp (no citas de MINEDUC),
-- escritos para evaluar el objetivo de aprendizaje correspondiente (ver
-- `curricular_source`/`pedagogical_notes` del objetivo en
-- supabase/seed/0023). `framework_id` y `source_id` quedan NULL (el
-- Currículum Regular no usa `curriculum_frameworks`, mismo motivo documentado
-- en el resto del banco). `content_hash` queda NULL: se recomienda calcularlo
-- con `computeContentHash` (`lib/data/question-validators.ts`) en un paso
-- posterior antes de aprobar cualquier fila.
--
-- ============================================================================
-- VALIDACIÓN MECÁNICA
-- ============================================================================
-- Se revisó manualmente cada pregunta contra las reglas de
-- `lib/data/question-validators.ts` antes de escribir este SQL: sin
-- alternativas duplicadas, sin alternativas vacías, exactamente una respuesta
-- correcta, sin "todas/ninguna de las anteriores", sin duplicados ni
-- casi-duplicados dentro del archivo. La posición de la respuesta correcta se
-- rotó de forma determinística (round-robin 0,1,2,3) a lo largo de las 64
-- preguntas, quedando 16 preguntas con respuesta correcta en cada una de las
-- 4 posiciones.
--
-- ============================================================================
-- IDEMPOTENCIA
-- ============================================================================
-- Cada INSERT ... SELECT filtra con `where not exists (select 1 from
-- questions q2 where q2.learning_objective_id = lo.id and q2.prompt =
-- v.prompt)`. `learning_objective_id` se resuelve siempre por (subject.name,
-- strand.name, level.code, learning_objective.short_name) -- nunca por id
-- hardcodeado.
--
-- Seed SOLO local: NO se ha ejecutado contra ningún proyecto Supabase (ni dev
-- ni producción). No modifica Supabase por sí solo.

-- ============================================================================
-- EJE: COMPRENSIÓN AUDITIVA — 5° BÁSICO
-- ============================================================================

-- Objetivo: Reconocimiento de sonidos y palabras del inglés
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Escuchas: ''Hello! My name is Diego.'' ¿Qué palabra corresponde a un saludo en inglés?', '["Hello","Name","Diego","My"]', 0, '''Hello'' es la palabra usada para saludar en inglés.', 'inicial', 25),
  ('En el audio se escucha: ''Good morning, class!'' ¿En qué momento del día se usa este saludo?', '["En la noche","En la mañana","En la tarde","A la medianoche"]', 1, '''Good morning'' se usa para saludar en la mañana.', 'intermedia', 30),
  ('Escuchas: ''Thank you very much!'' ¿Qué expresa esta frase?', '["Una despedida","Una pregunta","Agradecimiento","Una orden"]', 2, '''Thank you'' expresa agradecimiento.', 'intermedia', 30),
  ('En un audio se escuchan las palabras ''cat'', ''hat'' y ''bat''. ¿Qué tienen en común los sonidos finales de estas palabras en inglés?', '["Todas terminan en un sonido distinto","Todas comienzan igual","Ninguna comparte sonido","Todas riman porque terminan en el mismo sonido ''-at''"]', 3, 'Las tres palabras comparten el sonido final ''-at'', por eso riman.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_5_basico' and lo.short_name = 'Reconocimiento de sonidos y palabras del inglés'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de instrucciones simples en inglés
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('La profesora dice: ''Stand up, please.'' ¿Qué instrucción da la profesora?', '["Ponerse de pie","Sentarse","Abrir el libro","Guardar silencio"]', 0, '''Stand up'' significa ''ponerse de pie''.', 'inicial', 25),
  ('Escuchas la instrucción: ''Open your books on page ten.'' ¿Qué se pide hacer?', '["Cerrar los libros","Abrir los libros en la página diez","Guardar los libros","Dibujar en el libro"]', 1, '''Open your books on page ten'' pide abrir los libros en la página diez.', 'intermedia', 30),
  ('La instrucción dice: ''Listen carefully and repeat.'' ¿Qué dos acciones se piden?', '["Escribir y borrar","Cantar y bailar","Escuchar con atención y repetir","Correr y saltar"]', 2, 'La instrucción pide escuchar con atención y luego repetir.', 'intermedia', 30),
  ('Escuchas: ''Please, close the door and sit down quietly.'' ¿Cuál es la secuencia correcta de acciones pedidas?', '["Sentarse y luego cerrar la puerta","Solo sentarse en silencio","Solo cerrar la puerta","Cerrar la puerta y luego sentarse en silencio"]', 3, 'La instrucción pide primero cerrar la puerta y luego sentarse en silencio.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_5_basico' and lo.short_name = 'Comprensión de instrucciones simples en inglés'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de información puntual en textos orales breves
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Escuchas: ''My name is Laura and I am ten years old.'' ¿Cómo se llama la persona que habla?', '["Laura","Diez","Ana","Profesora"]', 0, 'El audio indica que su nombre es Laura.', 'inicial', 25),
  ('En el audio: ''I live in Valparaíso with my family.'' ¿Dónde vive la persona?', '["En Santiago","En Valparaíso","En Concepción","En el colegio"]', 1, 'El audio menciona que vive en Valparaíso.', 'intermedia', 30),
  ('Escuchas: ''The party starts at four o''clock.'' ¿A qué hora comienza la fiesta?', '["A las dos","A las tres","A las cuatro","A las cinco"]', 2, 'El audio indica que la fiesta comienza a las cuatro.', 'intermedia', 30),
  ('En el audio: ''There are three books, two pencils, and one notebook on the table.'' ¿Cuántos objetos en total se mencionan?', '["Dos","Cuatro","Cinco","Seis"]', 3, 'Se mencionan tres libros, dos lápices y un cuaderno: seis objetos en total.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_5_basico' and lo.short_name = 'Identificación de información puntual en textos orales breves'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Discriminación de sonidos propios del inglés
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos sonidos NO existe en español y es propio del inglés?', '["El sonido ''th'' de ''think''","El sonido de la letra ''a''","El sonido de la letra ''m''","El sonido de la letra ''s''"]', 0, 'El sonido ''th'' (como en ''think'') no existe en español y es propio del inglés.', 'inicial', 25),
  ('Escuchas las palabras ''ship'' y ''sheep''. ¿Qué distingue su pronunciación?', '["No hay ninguna diferencia","La duración y el sonido de la vocal","El número de letras es igual","Ambas se pronuncian exactamente igual"]', 1, '''Ship'' y ''sheep'' se distinguen por la duración y el sonido de su vocal.', 'intermedia', 30),
  ('¿Por qué palabras como ''cat'' y ''hat'' pueden ser difíciles de distinguir para alguien que recién comienza a aprender inglés?', '["Porque tienen sonidos idénticos al español","Porque no tienen ningún sonido en común","Porque comparten sonidos que no siempre existen igual en español","Porque son palabras muy largas"]', 2, 'Comparten sonidos vocálicos y consonánticos que no siempre se pronuncian igual en español.', 'intermedia', 30),
  ('Un estudiante confunde las palabras ''think'' y ''sink'' al escucharlas. ¿Qué está causando esta confusión?', '["El sonido de la letra ''k'' final","El sonido de la vocal ''i''","El acento de la palabra","La diferencia entre el sonido ''th'' y el sonido ''s''"]', 3, 'La confusión ocurre por la diferencia entre el sonido ''th'' (como en ''think'') y el sonido ''s'' (como en ''sink'').', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_5_basico' and lo.short_name = 'Discriminación de sonidos propios del inglés'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMPRENSIÓN LECTORA — 5° BÁSICO
-- ============================================================================

-- Objetivo: Reconocimiento del alfabeto y palabras conocidas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la letra que sigue después de ''B'' en el alfabeto en inglés?', '["C","D","A","E"]', 0, 'Después de ''B'' viene la letra ''C'' en el alfabeto inglés (igual que en español).', 'inicial', 25),
  ('Lees el cartel ''EXIT'' en la puerta de una sala. ¿Qué significa esta palabra?', '["Entrada","Salida","Baño","Escalera"]', 1, '''Exit'' significa ''salida'' en español.', 'intermedia', 30),
  ('Lees la palabra ''SCHOOL'' en un cartel. ¿A qué lugar se refiere?', '["Hospital","Supermercado","Colegio","Parque"]', 2, '''School'' significa ''colegio'' o ''escuela''.', 'intermedia', 30),
  ('Ves un mapa del colegio con los rótulos ''LIBRARY'' y ''CAFETERIA''. ¿Qué representa cada palabra?', '["Ambas representan un baño","LIBRARY es el patio y CAFETERIA es la sala de clases","Ambas representan la misma sala","LIBRARY es la biblioteca y CAFETERIA es el comedor"]', 3, '''Library'' significa biblioteca y ''cafeteria'' significa comedor.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_5_basico' and lo.short_name = 'Reconocimiento del alfabeto y palabras conocidas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de textos breves con apoyo visual
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto con una imagen de un perro: ''This is a dog. It is brown.'' ¿De qué color es el perro?', '["Café","Negro","Blanco","Gris"]', 0, 'El texto indica que el perro es ''brown'' (café).', 'inicial', 25),
  ('Texto con una imagen de una familia: ''This is my family. We are five.'' ¿Cuántas personas hay en la familia?', '["Cuatro","Cinco","Seis","Tres"]', 1, 'El texto dice ''we are five'', es decir, cinco personas.', 'intermedia', 30),
  ('Texto con una imagen de una sala de clases: ''The classroom has ten desks and one board.'' ¿Qué elementos tiene la sala según el texto y la imagen?', '["Solo un pizarrón","Diez sillas y un libro","Diez escritorios y un pizarrón","Un escritorio y diez pizarrones"]', 2, 'El texto indica diez escritorios (''desks'') y un pizarrón (''board'').', 'intermedia', 30),
  ('Texto con una imagen de una mochila: ''My backpack is blue and has three books, one notebook, and two pencils inside.'' ¿Cuántos objetos escolares hay dentro de la mochila?', '["Tres","Cuatro","Cinco","Seis"]', 3, 'Hay tres libros, un cuaderno y dos lápices: seis objetos en total.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_5_basico' and lo.short_name = 'Comprensión de textos breves con apoyo visual'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de información explícita
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''Ana has a red bike.'' ¿De qué color es la bicicleta de Ana?', '["Roja","Azul","Verde","Amarilla"]', 0, 'El texto indica explícitamente que la bicicleta es roja.', 'inicial', 25),
  ('Texto: ''Pedro goes to school by bus every day.'' ¿Cómo llega Pedro al colegio?', '["Caminando","En bus","En bicicleta","En auto"]', 1, 'El texto dice explícitamente que Pedro va en bus.', 'intermedia', 30),
  ('Texto: ''The library opens at nine and closes at five.'' ¿A qué hora cierra la biblioteca?', '["A las nueve","A las diez","A las cinco","A las ocho"]', 2, 'El texto indica explícitamente que la biblioteca cierra a las cinco.', 'intermedia', 30),
  ('Texto: ''Sofía has two brothers, one sister, and a dog named Rex.'' ¿Cuántos hermanos y hermanas tiene Sofía en total, según el texto?', '["Uno","Dos","Cuatro","Tres"]', 3, 'Tiene dos hermanos y una hermana: tres hermanos en total (explícito en el texto).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_5_basico' and lo.short_name = 'Identificación de información explícita'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Vocabulario temático básico
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas palabras corresponde a un color en inglés?', '["Red","Table","Run","Happy"]', 0, '''Red'' significa ''rojo'', un color.', 'inicial', 25),
  ('¿Cuál de estas palabras corresponde a un miembro de la familia en inglés?', '["Window","Mother","Chair","Number"]', 1, '''Mother'' significa ''madre'', un miembro de la familia.', 'intermedia', 30),
  ('¿Cuál de estas palabras corresponde a un objeto de la sala de clases en inglés?', '["Sunny","Weekend","Pencil","Happy"]', 2, '''Pencil'' significa ''lápiz'', un objeto de la sala de clases.', 'intermedia', 30),
  ('De estas palabras: ''three'', ''green'', ''sister'', ''seven'', ¿cuáles corresponden a la categoría ''números''?', '["''green'' y ''sister''","''sister'' y ''seven''","''green'' y ''seven''","''three'' y ''seven''"]', 3, '''Three'' (tres) y ''seven'' (siete) son números; ''green'' es un color y ''sister'' es un familiar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_5_basico' and lo.short_name = 'Vocabulario temático básico'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ORAL — 5° BÁSICO
-- ============================================================================

-- Objetivo: Saludos y presentaciones personales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es una forma correcta de presentarte en inglés?', '["Hello, my name is Sofía.","Green is my favorite color.","I have two brothers.","The weather is nice today."]', 0, '''Hello, my name is...'' es la forma correcta de presentarse en inglés.', 'inicial', 25),
  ('¿Cuál de estas expresiones se usa para despedirse en inglés?', '["Nice to meet you","Goodbye, see you tomorrow","How old are you?","What is your name?"]', 1, '''Goodbye, see you tomorrow'' es una expresión de despedida.', 'intermedia', 30),
  ('Si alguien te dice ''How are you?'', ¿cuál es una respuesta adecuada?', '["My name is Carlos","I am ten years old","I am fine, thank you","I live in Chile"]', 2, '''I am fine, thank you'' es una respuesta adecuada a ''How are you?''.', 'intermedia', 30),
  ('Estás conociendo a un compañero nuevo. ¿Cuál es la secuencia más adecuada para saludar y presentarte?', '["Goodbye. My name is Tomás. See you.","What is your name? Goodbye.","I am ten years old. Hello.","Hello! My name is Tomás. Nice to meet you."]', 3, 'Lo adecuado es saludar, decir el nombre y expresar el gusto de conocer a alguien, en ese orden.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_5_basico' and lo.short_name = 'Saludos y presentaciones personales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Preguntas y respuestas sobre información personal
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la pregunta correcta para saber el nombre de alguien en inglés?', '["What is your name?","How old are you?","Where do you live?","What do you like?"]', 0, '''What is your name?'' se usa para preguntar el nombre.', 'inicial', 25),
  ('¿Cuál es una respuesta correcta a la pregunta ''How old are you?''?', '["My name is Elena","I am eleven years old","I live in Temuco","I like pizza"]', 1, '''I am eleven years old'' responde correctamente a la edad.', 'intermedia', 30),
  ('¿Qué pregunta corresponde a la respuesta ''I live in Concepción''?', '["What is your name?","How old are you?","Where do you live?","What is your favorite color?"]', 2, '''Where do you live?'' corresponde a la respuesta sobre el lugar donde vive.', 'intermedia', 30),
  ('Un compañero responde: ''My name is Javiera, I am ten years old, and I like reading books.'' ¿Qué tres preguntas fueron probablemente formuladas, en el mismo orden?', '["What do you like? Where do you live? How old are you?","What is your name? Where do you live? What do you like?","How old are you? Where do you live? What is your name?","What is your name? How old are you? What do you like?"]', 3, 'Las respuestas corresponden en orden a nombre, edad y gustos: ''What is your name? How old are you? What do you like?''', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_5_basico' and lo.short_name = 'Preguntas y respuestas sobre información personal'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Repetición e imitación de patrones de pronunciación
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al repetir la palabra ''book'' después de escucharla, ¿qué debes imitar principalmente?', '["El sonido y la pronunciación de la palabra","El significado de otra palabra","El color del objeto","La forma de escribirla en español"]', 0, 'Al repetir se debe imitar el sonido y la pronunciación escuchada.', 'inicial', 25),
  ('¿Por qué es importante practicar la entonación al repetir preguntas en inglés, como ''Are you happy?''?', '["Para memorizar el vocabulario en español","Para que la pregunta se entienda correctamente como pregunta","Porque no influye en el significado","Porque cambia el significado a una orden"]', 1, 'La entonación ascendente ayuda a que la frase se reconozca como una pregunta.', 'intermedia', 30),
  ('Al practicar el ritmo de la frase ''I like to play soccer'', ¿qué se busca lograr?', '["Cambiar las palabras de la frase","Traducir la frase al español","Sonar más natural, similar a un hablante nativo","Hablar más lento de lo normal"]', 2, 'Practicar el ritmo busca sonar más natural, como lo haría un hablante nativo.', 'intermedia', 30),
  ('Un estudiante repite la palabra ''three'' pronunciándola como ''tree''. ¿Qué error de pronunciación específico está cometiendo?', '["Está usando mal el vocabulario","Está cambiando el significado por el orden de las palabras","Está pronunciando bien la palabra","No está imitando el sonido ''th'' correctamente"]', 3, 'El error está en no producir correctamente el sonido ''th'', confundiéndolo con ''tr''.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_5_basico' and lo.short_name = 'Repetición e imitación de patrones de pronunciación'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Participación en canciones y juegos en inglés
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Para qué sirve principalmente cantar canciones en inglés en clases?', '["Para practicar pronunciación y vocabulario de forma entretenida","Para aprender matemáticas","Para evitar hablar en inglés","Para copiar texto en el cuaderno"]', 0, 'Cantar canciones ayuda a practicar pronunciación y vocabulario de forma entretenida.', 'inicial', 25),
  ('Durante un juego oral en inglés donde debes nombrar colores, ¿qué habilidad estás practicando principalmente?', '["Escritura formal","Vocabulario y pronunciación oral","Comprensión de lectura silenciosa","Gramática avanzada"]', 1, 'El juego practica vocabulario y pronunciación oral.', 'intermedia', 30),
  ('En una rima infantil en inglés que se repite varias veces, ¿qué beneficio tiene la repetición?', '["Hace la actividad más aburrida","No tiene ningún beneficio","Ayuda a memorizar y afianzar la pronunciación","Dificulta el aprendizaje"]', 2, 'La repetición ayuda a memorizar y afianzar la pronunciación de las palabras.', 'intermedia', 30),
  ('Durante un juego en inglés, un estudiante se equivoca al pronunciar una palabra y sus compañeros lo corrigen con respeto. ¿Qué actitud demuestra el grupo?', '["Una actitud de burla hacia el error","Indiferencia frente al error","Rechazo a seguir jugando","Un ambiente de apoyo que favorece el aprendizaje"]', 3, 'Corregir con respeto favorece un ambiente de apoyo que facilita el aprendizaje del idioma.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_5_basico' and lo.short_name = 'Participación en canciones y juegos en inglés'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ESCRITA — 5° BÁSICO
-- ============================================================================

-- Objetivo: Copia y trazado de palabras y frases simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al copiar la palabra ''dog'' desde la pizarra, ¿qué debes cuidar principalmente?', '["Escribir las letras correctamente y en el orden correcto","Cambiar el orden de las letras","Traducir la palabra al español","Dibujar un perro en vez de escribir"]', 0, 'Al copiar se debe cuidar escribir las letras en el orden correcto.', 'inicial', 25),
  ('Al copiar la frase ''I like cats'' en tu cuaderno, ¿qué error debes evitar?', '["Usar lápiz en vez de lápiz pasta","Omitir o cambiar letras de las palabras","Escribir en letra script","Usar cuaderno de cuadros"]', 1, 'Se debe evitar omitir o cambiar letras al copiar la frase.', 'intermedia', 30),
  ('Si copias ''My name is Juan'' pero escribes ''My name Juan is'', ¿qué tipo de error cometiste?', '["Un error de ortografía","Un error de orden de las palabras","Un error de mayúsculas","No cometiste ningún error"]', 2, 'Cambiar el orden de las palabras es un error de orden, aunque las palabras estén bien escritas.', 'intermedia', 30),
  ('Debes copiar la frase ''The sun is yellow and hot'' cuidando mayúsculas y ortografía. ¿Cuál transcripción es correcta?', '["the sun is yellow and hot","The Sun Is Yellow And Hot","the Sun is yellow And hot","The sun is yellow and hot"]', 3, 'La transcripción correcta respeta la mayúscula inicial de la oración y la ortografía original, sin mayúsculas innecesarias.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_5_basico' and lo.short_name = 'Copia y trazado de palabras y frases simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Completar oraciones con vocabulario conocido
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Completa con un color adecuado: ''I have a ___ dog.''', '["brown","run","happy","three"]', 0, '''Brown'' es un color, adecuado para describir al perro.', 'inicial', 25),
  ('Completa con un miembro de la familia: ''She is my ___.''', '["book","sister","red","Monday"]', 1, '''Sister'' (hermana) es un miembro de la familia, adecuado para completar la oración.', 'intermedia', 30),
  ('Completa con un día de la semana: ''We go to school on ___.''', '["happy","green","Monday","dog"]', 2, '''Monday'' es un día de la semana, adecuado para completar la oración.', 'intermedia', 30),
  ('Completa correctamente ambos espacios: ''My favorite ___ is soccer, and I play it on ___.''', '["color / red","animal / cat","food / apple","sport / Saturdays"]', 3, '''Sport'' (deporte) y ''Saturdays'' (los sábados) completan correctamente ambas partes de la oración sobre el fútbol.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_5_basico' and lo.short_name = 'Completar oraciones con vocabulario conocido'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Escritura de información personal básica
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración escribe correctamente el nombre de una persona, siguiendo el modelo ''My name is ___''?', '["My name is Camila.","Camila name my is.","Is my name Camila.","Name Camila my is."]', 0, '''My name is Camila.'' sigue el orden correcto en inglés.', 'inicial', 25),
  ('¿Cuál oración expresa correctamente la edad, según el modelo ''I am ___ years old''?', '["I ten years am old.","I am ten years old.","Ten I am years old.","Years old I am ten."]', 1, '''I am ten years old.'' sigue el orden correcto del modelo.', 'intermedia', 30),
  ('¿Cuál oración indica correctamente el curso, siguiendo el modelo ''I am in ___ grade''?', '["Grade I fifth am in.","I fifth grade am in.","I am in fifth grade.","In fifth I am grade."]', 2, '''I am in fifth grade.'' sigue el orden correcto del modelo.', 'intermedia', 30),
  ('Debes escribir tu información personal básica (nombre, edad, curso) siguiendo un modelo dado. ¿Cuál opción organiza las tres oraciones en un orden lógico y correcto?', '["I am ten years old. I am in fifth grade. My name is Martín.","My name is fifth grade. I am Martín. Ten years old I am.","I am in fifth grade. My name is Martín. I am ten years old.","My name is Martín. I am ten years old. I am in fifth grade."]', 3, 'El orden lógico y gramaticalmente correcto es presentar primero el nombre, luego la edad y luego el curso.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_5_basico' and lo.short_name = 'Escritura de información personal básica'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de mayúsculas y puntuación elemental
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 5° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración usa correctamente la mayúscula inicial?', '["My dog is brown.","my dog is brown.","MY dog is brown.","my Dog is Brown."]', 0, '''My dog is brown.'' comienza correctamente con mayúscula.', 'inicial', 25),
  ('¿Cuál oración usa correctamente el punto final?', '["I like apples","I like apples,","I like apples.","I like apples;"]', 1, '''I like apples.'' termina correctamente con un punto.', 'intermedia', 30),
  ('¿Cuál de estas oraciones escribe correctamente el nombre propio ''Chile'' con mayúscula?', '["I live in chile.","I live in Chile.","i live in Chile","I Live In Chile"]', 2, '''I live in Chile.'' usa correctamente la mayúscula en el nombre propio ''Chile''.', 'intermedia', 30),
  ('Corrige aplicando mayúsculas y puntuación: ''my name is ana and i live in santiago''', '["My Name Is Ana And I Live In Santiago","my name is Ana and i live in Santiago.","My name Is ana and I live in Santiago","My name is Ana and I live in Santiago."]', 3, 'La versión correcta usa mayúscula inicial de oración, mayúsculas en los nombres propios ''Ana'' y ''Santiago'', y termina con punto final.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_5_basico' and lo.short_name = 'Uso de mayúsculas y puntuación elemental'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
