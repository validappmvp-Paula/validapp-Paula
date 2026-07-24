-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Matemática,
-- 1° Básico. Cubre los 24 objetivos de aprendizaje cargados por
-- supabase/seed/0011_curriculum_matematica_regular_basica_1_6.sql (5 ejes:
-- Números, Patrones y Álgebra, Geometría, Medición, Datos y Probabilidades),
-- con 4 preguntas por objetivo (dentro del rango 3-5 pedido, alineado con
-- `learning_objectives.min_recommended_questions`, que quedó en su valor por
-- defecto = 5 para todas las filas de 0011).
--
-- ============================================================================
-- ESTADO EDITORIAL Y DE VALIDACIÓN (léase antes de aprobar cualquier fila)
-- ============================================================================
-- `review_status = 'borrador'`: ninguna de estas preguntas ha sido revisada
-- editorialmente por un humano.
--
-- `validation_status = 'ai_generated_review_required'` (no 'unverified'):
-- este es el estado que 0023_question_generation_pipeline.sql definió
-- explícitamente para "recién generada [por IA/agente], nadie la ha
-- revisado todavía" -- que es exactamente este caso (`source_type =
-- 'validapp_original'`, `generated_by = 'claude-sonnet-5'`). 'unverified' es
-- el valor por defecto histórico para filas sin este campo explícito (ver
-- comentario en 0024_diagnostic_lesson_review_gate.sql), no la etiqueta
-- correcta para contenido nuevo generado por un agente. Cualquiera de los
-- dos valores deja la pregunta igualmente FUERA de ensayos y diagnósticos
-- reales: `get_diagnostic_questions` (0024/0029/0030) y el pool de ensayos
-- (`lib/data/essays.ts`, línea ~416-417) exigen
-- `validation_status = 'approved_for_exam'` + `is_active = true` (y
-- `review_status = 'aprobado'` para ensayos). Ninguna fila de este archivo
-- cumple esa condición todavía.
--
-- `is_active = true`: para que las preguntas sean visibles en el panel
-- administrativo de revisión (no implica uso real, ver punto anterior).
--
-- Ninguna pregunta debe considerarse aprobada, correcta al 100% ni lista
-- para publicar. Requieren revisión pedagógica humana antes de cualquier
-- cambio de `review_status`/`validation_status` (y esa revisión, según el
-- trigger `questions_prevent_ai_self_approval` de 0023, solo la puede hacer
-- un administrador real, nunca un agente).
--
-- ============================================================================
-- FUENTE Y NIVEL DE CONFIANZA
-- ============================================================================
-- Los enunciados son redacción ORIGINAL de ValidApp (no citas de MINEDUC),
-- escritos para evaluar el objetivo de aprendizaje correspondiente (ver
-- `curricular_source`/`pedagogical_notes` del objetivo en 0011). Los
-- distractores buscan representar errores conceptuales típicos del nivel
-- (p. ej. confundir el número anterior con el siguiente, sumar en vez de
-- restar, error de un dígito en el conteo), no opciones absurdas. Ningún
-- distractor es intencionalmente engañoso ni depende de vocabulario fuera
-- del nivel. `framework_id` y `source_id` quedan NULL: el Currículum Regular
-- no usa `curriculum_frameworks` (ver nota en 0011), y no se creó una fila en
-- `content_sources` para esta tarea (fuera de alcance; recomendación: si se
-- decide formalizar la trazabilidad de fuente por pregunta, coordinar con
-- /validapp-content y /validapp-db). `content_hash` queda NULL: se calcula
-- con `computeContentHash` (`lib/data/question-validators.ts`, sha256 sobre
-- texto normalizado en TypeScript), no reproducible de forma confiable en
-- SQL puro; se recomienda correr esa validación en un paso posterior antes
-- de aprobar cualquier fila.
--
-- ============================================================================
-- IDEMPOTENCIA
-- ============================================================================
-- `questions` no tiene una restricción única natural sobre el texto del
-- `prompt`. Se resuelve a mano: cada INSERT ... SELECT filtra con
-- `where not exists (select 1 from questions q2 where q2.learning_objective_id
-- = lo.id and q2.prompt = v.prompt)`, igual patrón que usa
-- supabase/seed/0001_epja_pilot_matematica.sql para otras tablas sin
-- constraint único. Seguro de correr más de una vez: no duplica preguntas ya
-- insertadas. `learning_objective_id` se resuelve siempre por
-- (subject.name, strand.name, level.code, learning_objective.short_name) --
-- nunca por id hardcodeado -- igual que 0011 resuelve `unit_id`.
--
-- Seed SOLO local: NO se ha ejecutado contra ningún proyecto Supabase (ni
-- dev ni producción). No modifica Supabase por sí solo.

-- ============================================================================
-- EJE: NÚMEROS — 1° BÁSICO
-- ============================================================================

-- Objetivo: Conteo hasta 20
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es el número que sigue después del 14 al contar de 1 en 1?', '["13", "15", "16", "20"]', 1, 'Al contar de 1 en 1 en forma ascendente, después del 14 viene el 15.', 'inicial', 25),
  ('Contando de 2 en 2 desde el 0, ¿cuál de estos números NO aparece en la secuencia?', '["6", "9", "12", "18"]', 1, 'Contando de 2 en 2 desde 0 solo aparecen números pares; 9 es impar y no pertenece a esa secuencia.', 'intermedia', 35),
  ('Contando en forma descendente desde el 20 (20, 19, 18, 17...), ¿qué número va justo antes del 17?', '["16", "18", "19", "15"]', 1, 'Contando de forma descendente desde el 20, el número que antecede al 17 es el 18.', 'intermedia', 35),
  ('Contando de 2 en 2 en forma descendente a partir de 20, ¿cuál es el quinto número de la secuencia (contando el 20 como el primero)?', '["14", "12", "10", "16"]', 1, 'Contando de 2 en 2 hacia atrás desde 20: 20, 18, 16, 14, 12; el quinto número es el 12.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_1_basico' and lo.short_name = 'Conteo hasta 20'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Lectura, escritura y representación hasta 20
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se escribe el número 17 en palabras?', '["diecisiete", "dieciocho", "diecinueve", "trece"]', 0, 'El número 17 se escribe "diecisiete".', 'inicial', 25),
  ('Un grupo de fichas está representado por 1 decena y 4 unidades. ¿Qué número representa?', '["10", "14", "4", "41"]', 1, '1 decena equivale a 10 unidades; 10 + 4 = 14.', 'intermedia', 35),
  ('¿Cuál de las siguientes representaciones corresponde al número 19?', '["1 decena y 9 unidades", "9 decenas y 1 unidad", "1 decena y 8 unidades", "2 decenas"]', 0, '19 se representa con 1 decena (10) y 9 unidades sueltas: 10 + 9 = 19.', 'intermedia', 35),
  ('Si tienes 2 decenas y quitas 3 unidades, ¿qué número obtienes?', '["17", "23", "13", "7"]', 0, '2 decenas equivalen a 20; al quitar 3 unidades queda 20 - 3 = 17.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_1_basico' and lo.short_name = 'Lectura, escritura y representación hasta 20'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Adición y sustracción hasta 20
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('12 + 5 = ?', '["16", "17", "18", "15"]', 1, '12 + 5 = 17.', 'inicial', 25),
  ('Ana tenía 18 dulces y regaló 6. ¿Cuántos dulces le quedan?', '["12", "14", "11", "13"]', 0, '18 - 6 = 12.', 'intermedia', 35),
  ('13 + 4 = ?', '["16", "17", "18", "21"]', 1, '13 + 4 = 17.', 'intermedia', 35),
  ('En una caja hay 9 bloques azules y 8 bloques rojos. Si se sacan 5 bloques rojos, ¿cuántos bloques quedan en total?', '["12", "13", "14", "11"]', 0, '9 + 8 = 17 bloques en total; al sacar 5, quedan 17 - 5 = 12.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_1_basico' and lo.short_name = 'Adición y sustracción hasta 20'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Composición y descomposición de números hasta 20
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la descomposición correcta de 16?', '["10 + 6", "10 + 7", "1 + 6", "6 + 6"]', 0, '16 = 10 + 6.', 'inicial', 25),
  ('Si compones 10 + 8, ¿qué número obtienes?', '["18", "19", "17", "8"]', 0, '10 + 8 = 18.', 'intermedia', 35),
  ('¿Cuál de estas descomposiciones NO corresponde al número 15?', '["10 + 5", "9 + 6", "12 + 3", "8 + 8"]', 3, '8 + 8 = 16, no 15; las otras tres opciones sí suman 15.', 'intermedia', 35),
  ('Un número se descompone en 1 decena, 2 unidades y 3 unidades adicionales. ¿Cuál es el número?', '["15", "12", "13", "23"]', 0, '10 + 2 + 3 = 15.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_1_basico' and lo.short_name = 'Composición y descomposición de números hasta 20'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Estimación de cantidades
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Sin contar una por una, ¿cuál es la mejor estimación de un puñado de 18 semillas?', '["Aproximadamente 20", "Aproximadamente 5", "Aproximadamente 100", "Aproximadamente 2"]', 0, '18 está cerca de 20, por lo que "aproximadamente 20" es la mejor estimación.', 'inicial', 25),
  ('Camila estima que hay "alrededor de 15" manzanas en una bandeja. Al contar, hay 16. ¿Fue razonable su estimación?', '["Sí, porque 16 está muy cerca de 15", "No, porque 16 es el doble de 15", "No, porque debía decir exactamente 16", "Sí, porque estimar es adivinar sin relación con la cantidad real"]', 0, 'Una estimación es razonable cuando está cerca del valor real; 16 está muy cerca de 15.', 'intermedia', 35),
  ('¿Cuál de estas cantidades es una estimación razonable para un grupo de lápices descrito como "un poco más de 10"?', '["12", "2", "30", "100"]', 0, '12 es un poco más de 10, coherente con la estimación descrita.', 'intermedia', 35),
  ('Un frasco tiene fichas. Se estimó que había "entre 15 y 20". ¿Cuál de estos resultados confirma que la estimación fue correcta?', '["18 fichas", "25 fichas", "10 fichas", "5 fichas"]', 0, '18 está dentro del rango estimado entre 15 y 20.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_1_basico' and lo.short_name = 'Estimación de cantidades'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de monedas de uso común
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué moneda usarías para pagar exactamente $50?', '["Una moneda de $50", "Una moneda de $10", "Una moneda de $500", "Una moneda de $100"]', 0, 'La moneda de $50 corresponde exactamente al monto pedido.', 'inicial', 25),
  ('Si tienes una moneda de $100 y compras algo de $50, ¿cuánto vuelto recibes?', '["$50", "$150", "$100", "$0"]', 0, '100 - 50 = 50 de vuelto.', 'intermedia', 35),
  ('¿Cuántas monedas de $10 se necesitan para juntar $50?', '["5", "10", "4", "50"]', 0, '10 x 5 = 50; se necesitan 5 monedas de $10.', 'intermedia', 35),
  ('Tienes 2 monedas de $50 y 1 moneda de $100. ¿Cuánto dinero tienes en total?', '["$200", "$150", "$250", "$100"]', 0, '2 monedas de $50 son $100; sumadas a la moneda de $100 dan $200 en total.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_1_basico' and lo.short_name = 'Uso de monedas de uso común'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: PATRONES Y ÁLGEBRA — 1° BÁSICO
-- ============================================================================

-- Objetivo: Patrones repetitivos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué figura sigue en el patrón: círculo, cuadrado, círculo, cuadrado, círculo, ___?', '["cuadrado", "círculo", "triángulo", "rectángulo"]', 0, 'El patrón alterna círculo-cuadrado; después de círculo sigue cuadrado.', 'inicial', 25),
  ('En el patrón rojo, azul, azul, rojo, azul, azul, rojo, ___, ___, ¿qué colores siguen?', '["azul, azul", "rojo, rojo", "azul, rojo", "rojo, azul"]', 0, 'El patrón se repite en bloques de "rojo, azul, azul"; después de rojo siguen azul, azul.', 'intermedia', 35),
  ('¿Cuál de las siguientes secuencias NO es un patrón repetitivo?', '["A, B, A, B, A, B", "1, 2, 1, 2, 1, 2", "2, 4, 6, 8, 10", "triángulo, círculo, triángulo, círculo"]', 2, '2, 4, 6, 8, 10 es un patrón creciente (suma 2 cada vez), no uno repetitivo de elementos en el mismo orden.', 'intermedia', 35),
  ('El patrón es: 3 fichas rojas, 1 ficha azul, 3 fichas rojas, 1 ficha azul... Si continúa, ¿cuántas fichas rojas habrá en 2 repeticiones completas?', '["6", "3", "4", "8"]', 0, 'Cada repetición tiene 3 fichas rojas; en 2 repeticiones hay 3 x 2 = 6 fichas rojas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_1_basico' and lo.short_name = 'Patrones repetitivos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: El signo igual como equivalencia
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa el signo "=" en 5 + 2 = 7?', '["Que ambos lados representan la misma cantidad", "Que el número de la izquierda es mayor", "Que hay que sumar el resultado otra vez", "Que el número de la derecha es el doble"]', 0, 'El signo igual indica que ambos lados de la expresión representan la misma cantidad.', 'inicial', 25),
  ('¿Cuál de las siguientes igualdades es verdadera?', '["4 + 3 = 7", "4 + 3 = 8", "4 + 3 = 6", "4 + 3 = 9"]', 0, '4 + 3 = 7, por lo tanto esa es la igualdad verdadera.', 'intermedia', 35),
  ('En la igualdad 6 + 2 = 5 + ___, ¿qué número falta para que ambos lados sean iguales?', '["3", "4", "2", "8"]', 0, '6 + 2 = 8; para que 5 + ___ también sea 8, el número que falta es 3.', 'intermedia', 35),
  ('¿Cuál de estas igualdades es FALSA?', '["9 = 4 + 5", "10 = 6 + 4", "8 = 3 + 4", "12 = 7 + 5"]', 2, '3 + 4 = 7, no 8; por eso esa igualdad es falsa.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_1_basico' and lo.short_name = 'El signo igual como equivalencia'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Predicción de elementos en una secuencia
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En la secuencia 2, 4, 6, 8, ___, ¿qué número sigue?', '["10", "9", "12", "7"]', 0, 'El patrón suma 2 cada vez; después del 8 sigue el 10.', 'inicial', 25),
  ('En la secuencia de figuras: triángulo, triángulo, cuadrado, triángulo, triángulo, cuadrado, triángulo, triángulo, ___, ¿qué figura falta?', '["cuadrado", "triángulo", "círculo", "rectángulo"]', 0, 'El patrón se repite cada 3 figuras (triángulo, triángulo, cuadrado); la novena figura debe ser cuadrado.', 'intermedia', 35),
  ('En la secuencia 15, 13, 11, 9, ___, ¿qué número sigue?', '["7", "8", "10", "6"]', 0, 'El patrón resta 2 cada vez; después del 9 sigue el 7.', 'intermedia', 35),
  ('En la secuencia 1, 3, 5, 7, 9, ___, ___, ¿cuáles son los dos números que siguen?', '["11 y 13", "10 y 12", "12 y 14", "11 y 12"]', 0, 'La secuencia avanza de 2 en 2 con números impares; después del 9 siguen 11 y 13.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_1_basico' and lo.short_name = 'Predicción de elementos en una secuencia'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Patrones crecientes y decrecientes simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas secuencias es creciente?', '["2, 4, 6, 8", "10, 8, 6, 4", "5, 5, 5, 5", "9, 7, 5, 3"]', 0, 'En 2, 4, 6, 8 cada número es mayor que el anterior, por lo que es creciente.', 'inicial', 25),
  ('En la secuencia decreciente 18, 16, 14, ___, ¿qué número sigue?', '["12", "13", "10", "20"]', 0, 'El patrón resta 2 cada vez; después del 14 sigue el 12.', 'intermedia', 35),
  ('¿Cuál de estas secuencias es decreciente de 3 en 3?', '["20, 17, 14, 11", "20, 23, 26, 29", "20, 18, 16, 14", "20, 17, 15, 13"]', 0, '20, 17, 14, 11 resta 3 cada vez, por lo tanto es decreciente de 3 en 3.', 'intermedia', 35),
  ('Una secuencia creciente comienza en 4 y aumenta de 3 en 3. ¿Cuál es el cuarto número (contando el 4 como el primero)?', '["13", "10", "16", "12"]', 0, '4, 7, 10, 13: el cuarto número de la secuencia es 13.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_1_basico' and lo.short_name = 'Patrones crecientes y decrecientes simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Igualdades numéricas simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('8 + 2 = ___ + 5. ¿Qué número falta?', '["5", "10", "15", "7"]', 0, '8 + 2 = 10; para que ___ + 5 sea también 10, el número que falta es 5.', 'inicial', 25),
  ('Completa: 6 + ___ = 9', '["3", "4", "2", "15"]', 0, '6 + 3 = 9.', 'intermedia', 35),
  ('Completa: ___ - 4 = 10', '["14", "6", "16", "10"]', 0, '14 - 4 = 10.', 'intermedia', 35),
  ('¿Cuál de estas igualdades hace que ambos lados sean iguales a 12?', '["7 + 5 = 8 + 4", "7 + 5 = 6 + 5", "7 + 5 = 9 + 2", "7 + 5 = 10 + 3"]', 0, '7 + 5 = 12 y 8 + 4 = 12, por lo que ambos lados son iguales a 12.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_1_basico' and lo.short_name = 'Igualdades numéricas simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: GEOMETRÍA — 1° BÁSICO
-- ============================================================================

-- Objetivo: Figuras 2D y cuerpos 3D básicos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué figura 2D tiene 3 lados?', '["Triángulo", "Cuadrado", "Círculo", "Rectángulo"]', 0, 'El triángulo es la figura 2D de 3 lados.', 'inicial', 25),
  ('¿Cuál de estos cuerpos 3D no tiene vértices ni aristas, como una pelota?', '["Esfera", "Cubo", "Pirámide", "Prisma"]', 0, 'La esfera es un cuerpo redondo, sin vértices ni aristas, a diferencia del cubo, la pirámide y el prisma.', 'intermedia', 35),
  ('¿Qué cuerpo 3D tiene forma de pelota?', '["Esfera", "Cubo", "Cono", "Cilindro"]', 0, 'La esfera tiene forma de pelota, redonda en todas direcciones.', 'intermedia', 35),
  ('Un dado tiene forma de un cuerpo 3D con 6 caras cuadradas iguales. ¿Cómo se llama ese cuerpo?', '["Cubo", "Esfera", "Cono", "Cilindro"]', 0, 'El cubo tiene 6 caras cuadradas iguales, como un dado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_1_basico' and lo.short_name = 'Figuras 2D y cuerpos 3D básicos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Ubicación relativa de objetos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un lápiz está sobre la mesa y una goma está debajo de la mesa. ¿Dónde está la goma respecto de la mesa?', '["Debajo", "Arriba", "A la izquierda", "Dentro"]', 0, 'La goma está debajo de la mesa, según lo descrito.', 'inicial', 25),
  ('Pedro está a la derecha de Ana. ¿Dónde está Ana respecto de Pedro?', '["A la izquierda de Pedro", "A la derecha de Pedro", "Arriba de Pedro", "Debajo de Pedro"]', 0, 'Si Pedro está a la derecha de Ana, entonces Ana está a la izquierda de Pedro.', 'intermedia', 35),
  ('Un juguete está dentro de la caja. Si lo sacas, ¿dónde queda ahora respecto de la caja?', '["Fuera de la caja", "Dentro de la caja", "Arriba de la caja", "Debajo de la caja"]', 0, 'Al sacar el juguete de la caja, este queda fuera de ella.', 'intermedia', 35),
  ('Un libro está arriba del estante y un cuaderno está abajo. Si el cuaderno pasa a estar arriba y el libro abajo, ¿qué ocurrió?', '["Sus posiciones se intercambiaron", "Nada cambió", "Ambos quedaron arriba", "Ambos quedaron abajo"]', 0, 'El libro y el cuaderno intercambiaron sus posiciones relativas al estante.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_1_basico' and lo.short_name = 'Ubicación relativa de objetos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Representación de objetos con figuras geométricas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué figura 2D se parece más a la forma de una pizza vista desde arriba?', '["Círculo", "Cuadrado", "Triángulo", "Rectángulo"]', 0, 'Una pizza vista desde arriba tiene forma circular.', 'inicial', 25),
  ('¿Qué cuerpo 3D representa mejor la forma de una lata de bebida?', '["Cilindro", "Cubo", "Esfera", "Cono"]', 0, 'Una lata de bebida tiene forma de cilindro.', 'intermedia', 35),
  ('¿Qué figura 2D representa mejor la forma de la pantalla de un televisor?', '["Rectángulo", "Círculo", "Triángulo", "Esfera"]', 0, 'La pantalla de un televisor tiene forma rectangular.', 'intermedia', 35),
  ('Para representar una carpa de camping con base cuadrada y techo en punta, ¿qué cuerpo 3D es el más adecuado?', '["Pirámide", "Cilindro", "Esfera", "Cono"]', 0, 'Una carpa con base cuadrada y techo que termina en punta se representa mejor con una pirámide.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_1_basico' and lo.short_name = 'Representación de objetos con figuras geométricas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comparación de tamaños y formas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál figura tiene más lados: un triángulo o un rectángulo?', '["El rectángulo", "El triángulo", "Tienen los mismos lados", "Ninguno tiene lados"]', 0, 'El rectángulo tiene 4 lados y el triángulo tiene 3; el rectángulo tiene más.', 'inicial', 25),
  ('¿Qué tienen en común un cuadrado y un rectángulo?', '["Ambos tienen 4 lados y 4 ángulos rectos", "Ambos tienen 3 lados", "Ambos son redondos", "Ninguno tiene lados rectos"]', 0, 'Tanto el cuadrado como el rectángulo tienen 4 lados y 4 ángulos rectos.', 'intermedia', 35),
  ('¿Cuál es la diferencia principal entre un cuadrado y un rectángulo no cuadrado?', '["El cuadrado tiene los 4 lados iguales y el rectángulo no", "El rectángulo tiene 3 lados", "El cuadrado es redondo", "No hay diferencia"]', 0, 'En el cuadrado los 4 lados miden lo mismo; en un rectángulo no cuadrado, los lados opuestos son iguales entre sí pero distintos a los otros dos.', 'intermedia', 35),
  ('Se clasifican figuras según su número de lados. ¿En qué grupo debe ir un rombo?', '["Junto con las figuras de 4 lados, como el cuadrado y el rectángulo", "Junto con las figuras de 3 lados", "Junto con los círculos", "Junto con los cuerpos 3D"]', 0, 'El rombo tiene 4 lados, por lo que se clasifica junto con el cuadrado y el rectángulo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_1_basico' and lo.short_name = 'Comparación de tamaños y formas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Referentes de posición en trayectos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si caminas hacia la escuela y luego regresas a tu casa, ¿qué palabra describe mejor tu segundo trayecto?', '["Atrás (de regreso)", "Adelante", "Arriba", "Dentro"]', 0, 'Regresar a casa corresponde al trayecto de vuelta, es decir, "atrás" respecto del punto de llegada anterior.', 'inicial', 25),
  ('El parque está cerca de tu casa y el estadio está lejos. ¿A cuál lugar tardarías menos en llegar caminando?', '["Al parque, porque está cerca", "Al estadio, porque está lejos", "Ambos tardan lo mismo", "No se puede saber"]', 0, 'Un lugar cercano toma menos tiempo en llegar caminando que uno lejano.', 'intermedia', 35),
  ('En un trayecto, primero pasas por la plaza y después por la escuela. ¿Qué lugar visitas primero?', '["La plaza", "La escuela", "Ambos al mismo tiempo", "Ninguno"]', 0, 'Según el orden descrito, la plaza se visita primero y la escuela después.', 'intermedia', 35),
  ('Vas desde tu casa hasta el almacén: primero avanzas adelante, luego giras y avanzas hacia la derecha para llegar. ¿Qué instrucción describe el trayecto en el orden correcto?', '["Adelante y luego a la derecha", "A la derecha y luego atrás", "Arriba y luego abajo", "Adelante y luego atrás"]', 0, 'El trayecto descrito es primero adelante y luego un giro hacia la derecha, en ese orden.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_1_basico' and lo.short_name = 'Referentes de posición en trayectos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: MEDICIÓN — 1° BÁSICO
-- ============================================================================

-- Objetivo: Comparación de longitudes, pesos y capacidades
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Sin usar una regla, ¿cómo puedes saber cuál de dos lápices es más largo?', '["Poniéndolos uno al lado del otro y comparando sus extremos", "Pesándolos en una balanza", "Contando cuántos hay", "Mirando su color"]', 0, 'Para comparar longitudes sin instrumentos, se ponen los objetos uno al lado del otro (alineados) y se observa cuál sobresale más.', 'inicial', 25),
  ('Si una botella de agua pesa más que una pelota de goma, ¿qué se puede afirmar?', '["La botella tiene más peso que la pelota", "La pelota tiene más peso que la botella", "Ambas pesan lo mismo", "No se puede comparar el peso de objetos distintos"]', 0, 'Si la botella pesa más, entonces tiene mayor peso que la pelota, según lo indicado.', 'intermedia', 35),
  ('Un balde grande y un vaso pequeño se llenan con agua. ¿Cuál tiene mayor capacidad?', '["El balde grande", "El vaso pequeño", "Ambos tienen la misma capacidad", "Depende del color del recipiente"]', 0, 'El balde grande tiene mayor capacidad que el vaso pequeño, es decir, puede contener más agua.', 'intermedia', 35),
  ('Tienes tres cintas: la cinta A es más larga que la B, y la B es más larga que la C. ¿Cuál es la cinta más corta?', '["La cinta C", "La cinta A", "La cinta B", "No se puede saber"]', 0, 'Si A es mayor que B y B es mayor que C en longitud, entonces C es la más corta de las tres.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_1_basico' and lo.short_name = 'Comparación de longitudes, pesos y capacidades'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Secuencia temporal
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué día de la semana viene inmediatamente después del lunes?', '["Martes", "Miércoles", "Domingo", "Viernes"]', 0, 'Después del lunes sigue el martes.', 'inicial', 25),
  ('Si hoy es miércoles, ¿qué día fue ayer?', '["Martes", "Jueves", "Lunes", "Viernes"]', 0, 'El día anterior al miércoles es el martes.', 'intermedia', 35),
  ('Ordena estos momentos del día de primero a último: almuerzo, desayuno, cena.', '["Desayuno, almuerzo, cena", "Cena, almuerzo, desayuno", "Almuerzo, desayuno, cena", "Cena, desayuno, almuerzo"]', 0, 'El orden habitual del día es desayuno en la mañana, almuerzo al mediodía y cena en la noche.', 'intermedia', 35),
  ('Si un evento ocurre "dos días después del jueves", ¿qué día es?', '["Sábado", "Viernes", "Domingo", "Lunes"]', 0, 'Un día después del jueves es viernes, y dos días después es sábado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_1_basico' and lo.short_name = 'Secuencia temporal'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Lectura de la hora en punto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En un reloj, la manecilla corta apunta al 3 y la larga al 12. ¿Qué hora es?', '["Las 3 en punto", "Las 12 en punto", "Las 3 y media", "Las 9 en punto"]', 0, 'Cuando la manecilla larga apunta al 12 y la corta a un número, es esa hora "en punto"; en este caso, las 3 en punto.', 'inicial', 25),
  ('¿Cómo se ve un reloj digital que marca las 7 en punto?', '["7:00", "07:30", "17:00 y 30", "0:07"]', 0, 'Las 7 en punto se muestra en un reloj digital como 7:00.', 'intermedia', 35),
  ('Si la manecilla larga está en el 12 y la corta en el 10, ¿qué hora marca el reloj?', '["Las 10 en punto", "Las 12 en punto", "Las 10 y media", "Las 2 en punto"]', 0, 'La manecilla larga en el 12 indica "en punto", y la corta en el 10 indica que son las 10 en punto.', 'intermedia', 35),
  ('Un evento comienza a las 4 en punto y otro comienza 1 hora después. ¿A qué hora comienza el segundo evento?', '["Las 5 en punto", "Las 3 en punto", "Las 4 y media", "Las 6 en punto"]', 0, 'Una hora después de las 4 en punto son las 5 en punto.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_1_basico' and lo.short_name = 'Lectura de la hora en punto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comparación de la duración de eventos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál actividad dura más tiempo generalmente: cepillarse los dientes o dormir toda la noche?', '["Dormir toda la noche", "Cepillarse los dientes", "Ambas duran lo mismo", "No se puede comparar"]', 0, 'Dormir toda la noche toma varias horas, mucho más que cepillarse los dientes, que toma minutos.', 'inicial', 25),
  ('Si una película dura más que un episodio de dibujos animados, ¿qué se puede decir de sus duraciones?', '["La película tiene mayor duración que el episodio", "El episodio tiene mayor duración que la película", "Ambas duran exactamente lo mismo", "No tienen relación de duración"]', 0, 'Si la película dura más, entonces su duración es mayor que la del episodio.', 'intermedia', 35),
  ('¿Qué actividad toma menos tiempo: atarse los cordones de los zapatos o hacer un viaje en avión?', '["Atarse los cordones de los zapatos", "Hacer un viaje en avión", "Ambas toman el mismo tiempo", "No se puede saber"]', 0, 'Atarse los cordones toma segundos o pocos minutos, mucho menos que un viaje en avión.', 'intermedia', 35),
  ('Tres actividades duran: A más que B, y B más que C. ¿Cuál actividad es la de menor duración?', '["La actividad C", "La actividad A", "La actividad B", "No se puede determinar"]', 0, 'Si A es mayor que B y B es mayor que C en duración, entonces C es la actividad más breve.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_1_basico' and lo.short_name = 'Comparación de la duración de eventos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: DATOS Y PROBABILIDADES — 1° BÁSICO
-- ============================================================================

-- Objetivo: Recolección y registro de datos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es una forma adecuada de registrar cuántos compañeros prefieren fruta versus verdura?', '["Hacer una tabla marcando una rayita por cada preferencia", "Adivinar sin preguntar a nadie", "Solo preguntarle a un compañero", "No registrar nada"]', 0, 'Una tabla de conteo con una marca por cada respuesta es una forma adecuada de registrar datos recolectados.', 'inicial', 25),
  ('Si preguntas a 10 compañeros su color favorito y anotas cada respuesta, ¿qué estás haciendo?', '["Recolectando y registrando datos", "Solo estimando sin preguntar", "Prediciendo el futuro", "Multiplicando números"]', 0, 'Preguntar y anotar cada respuesta es el proceso de recolectar y registrar datos.', 'intermedia', 35),
  ('En una tabla de conteo aparecen 4 marcas para "perro" y 2 marcas para "gato". ¿Cuántas respuestas se registraron en total?', '["6", "4", "2", "8"]', 0, '4 marcas de perro más 2 marcas de gato suman 6 respuestas en total.', 'intermedia', 35),
  ('Se registraron los siguientes datos sobre mascotas preferidas: perro (5), gato (3), pez (2). ¿Cuál fue la mascota menos elegida?', '["Pez", "Perro", "Gato", "Todas fueron elegidas por igual"]', 0, 'El pez tuvo solo 2 marcas, la menor cantidad entre las tres opciones registradas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_1_basico' and lo.short_name = 'Recolección y registro de datos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Eventos seguros, posibles e imposibles
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos eventos es imposible?', '["Que un gato hable como una persona", "Que llueva mañana", "Que salga el sol de día", "Que nazca un bebé"]', 0, 'Un gato no puede hablar como una persona; ese evento es imposible en la realidad.', 'inicial', 25),
  ('¿Cuál de estos eventos es seguro que ocurra?', '["Que después del lunes venga el martes", "Que llueva todos los días del año", "Que gane un juego de azar", "Que un dado marque siempre el número 6"]', 0, 'Es seguro que después del lunes siempre viene el martes; los demás eventos no son certeros.', 'intermedia', 35),
  ('¿Cuál de estos eventos es posible pero no seguro?', '["Que mañana llueva", "Que el sol salga de noche", "Que un perro vuele sin ayuda", "Que 2 + 2 sea igual a 5"]', 0, 'Que llueva mañana es posible, pero no es seguro que ocurra; depende del clima.', 'intermedia', 35),
  ('Al lanzar una moneda, sale cara o sello. ¿Es seguro, posible o imposible que ocurra alguno de esos dos resultados?', '["Seguro, porque siempre debe salir uno de los dos", "Imposible, porque una moneda no puede caer", "Posible pero poco probable", "Imposible, porque siempre cae de canto"]', 0, 'Al lanzar una moneda normal, es seguro que el resultado será cara o sello, uno de los dos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_1_basico' and lo.short_name = 'Eventos seguros, posibles e imposibles'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Interpretación de pictogramas simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En un pictograma, cada dibujo de manzana representa 1 fruta vendida. Si hay 4 dibujos de manzana, ¿cuántas frutas se vendieron?', '["4", "1", "2", "8"]', 0, 'Si cada dibujo representa 1 fruta y hay 4 dibujos, se vendieron 4 frutas.', 'inicial', 25),
  ('En un pictograma de mascotas, "perro" tiene 5 dibujos y "gato" tiene 3 dibujos (cada dibujo = 1 mascota). ¿Cuántas mascotas más tiene "perro" que "gato"?', '["2", "5", "3", "8"]', 0, '5 dibujos de perro menos 3 dibujos de gato es una diferencia de 2.', 'intermedia', 35),
  ('Si en un pictograma cada dibujo de estrella representa 1 punto, y un equipo tiene 6 estrellas, ¿cuántos puntos tiene ese equipo?', '["6", "3", "12", "1"]', 0, 'Cada estrella vale 1 punto; con 6 estrellas, el equipo tiene 6 puntos.', 'intermedia', 35),
  ('En un pictograma con dos categorías, "lee" tiene 7 dibujos y "no lee" tiene 5 dibujos (cada dibujo = 1 estudiante). ¿Cuántos estudiantes fueron encuestados en total?', '["12", "7", "5", "2"]', 0, '7 estudiantes que leen más 5 que no leen suman 12 estudiantes encuestados en total.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_1_basico' and lo.short_name = 'Interpretación de pictogramas simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Clasificación de objetos según un atributo
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 1° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si clasificas objetos por su color, ¿en qué grupo pondrías una pelota roja y una manzana roja?', '["En el grupo de objetos rojos", "En el grupo de objetos redondos", "En el grupo de frutas", "En el grupo de juguetes"]', 0, 'Si el criterio de clasificación es el color, ambos objetos van juntos por ser rojos.', 'inicial', 25),
  ('Se clasifican objetos según su forma. ¿En qué grupo va un plato y una moneda?', '["En el grupo de objetos redondos", "En el grupo de objetos cuadrados", "En el grupo de objetos triangulares", "En el grupo de objetos de madera"]', 0, 'Tanto el plato como la moneda tienen forma redonda, por lo que se clasifican juntos según esa forma.', 'intermedia', 35),
  ('Si el criterio de clasificación es "tamaño", ¿cuál de estos grupos es correcto?', '["Elefante y camión en el grupo de objetos grandes", "Elefante y hormiga en el mismo grupo por ser animales", "Camión y hormiga en el grupo de objetos pequeños", "No se pueden clasificar por tamaño"]', 0, 'Según el criterio "tamaño", el elefante y el camión corresponden al grupo de objetos grandes.', 'intermedia', 35),
  ('Tienes estos objetos: pelota roja, cubo rojo, pelota azul, cubo azul. Si clasificas primero por forma y luego por color, ¿cuántos grupos finales obtienes?', '["4 grupos", "2 grupos", "1 grupo", "8 grupos"]', 0, 'Combinando 2 formas (pelota, cubo) con 2 colores (rojo, azul) se obtienen 4 grupos distintos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_1_basico' and lo.short_name = 'Clasificación de objetos según un atributo'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
