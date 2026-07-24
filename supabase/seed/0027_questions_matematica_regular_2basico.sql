-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Matemática,
-- 2° Básico. Mismo patrón, alcance, estado editorial e idempotencia que
-- supabase/seed/0026_questions_matematica_regular_1basico.sql (ver ese
-- archivo para el detalle completo de las decisiones de diseño). Resumen:
--   - review_status = 'borrador'; validation_status =
--     'ai_generated_review_required' (no 'unverified': ver justificación en
--     0026); is_active = true. Ninguna fila es usable en ensayos/diagnósticos
--     reales (get_diagnostic_questions y el pool de essays.ts exigen
--     validation_status = 'approved_for_exam').
--   - Enunciados originales de ValidApp, no citas de MINEDUC.
--   - Idempotente vía `where not exists` sobre (learning_objective_id, prompt).
--   - Seed SOLO local: no ejecutado contra ningún Supabase.

-- ============================================================================
-- EJE: NÚMEROS — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué número sigue después del 59 al contar de 1 en 1?', '["58", "60", "61", "50"]', 1, 'Después del 59 sigue el 60.', 'inicial', 25),
  ('Contando de 10 en 10 desde el 0, ¿cuál de estos números SÍ aparece en la secuencia?', '["70", "75", "83", "91"]', 0, 'Contando de 10 en 10 desde 0 (0, 10, 20... 70...) el número 70 sí aparece; los demás no son múltiplos de 10.', 'intermedia', 35),
  ('Contando de 5 en 5 desde el 0, ¿qué número va justo después del 45?', '["50", "46", "55", "40"]', 0, 'Contando de 5 en 5, después del 45 sigue el 50.', 'intermedia', 35),
  ('Contando de 2 en 2 en forma descendente desde 100, ¿cuál es el cuarto número de la secuencia (contando el 100 como el primero)?', '["94", "96", "92", "98"]', 0, '100, 98, 96, 94: el cuarto número es 94.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_2_basico' and lo.short_name = 'Conteo hasta 100'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos números es mayor: 47 o 74?', '["74", "47", "Son iguales", "No se puede comparar"]', 0, '74 es mayor que 47 porque tiene más decenas (7 frente a 4).', 'inicial', 25),
  ('Ordena de menor a mayor: 38, 83, 58.', '["38, 58, 83", "83, 58, 38", "58, 38, 83", "38, 83, 58"]', 0, '38 < 58 < 83, por lo tanto ese es el orden de menor a mayor.', 'intermedia', 35),
  ('¿Qué número está entre 62 y 65?', '["63", "61", "66", "70"]', 0, '63 está entre 62 y 65 porque 62 < 63 < 65.', 'intermedia', 35),
  ('Un número tiene 6 decenas y es menor que 65 pero mayor que 61. ¿Cuál puede ser ese número?', '["63", "70", "59", "66"]', 0, '63 tiene 6 decenas y está entre 61 y 65.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_2_basico' and lo.short_name = 'Comparación de números hasta 100'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('34 + 25 = ?', '["59", "49", "69", "54"]', 0, '34 + 25 = 59.', 'inicial', 25),
  ('Un puesto tenía 82 panes y vendió 47. ¿Cuántos panes le quedan?', '["35", "45", "39", "25"]', 0, '82 - 47 = 35.', 'intermedia', 35),
  ('27 + 38 = ?', '["65", "55", "75", "54"]', 0, '27 + 38 = 65 (7+8=15, se reagrupa 1 decena).', 'intermedia', 35),
  ('En una caja hay 56 fichas rojas y 29 fichas azules. Si se retiran 15 fichas rojas, ¿cuántas fichas quedan en total?', '["70", "71", "56", "41"]', 0, '56 + 29 = 85 fichas en total; al retirar 15, quedan 85 - 15 = 70.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_2_basico' and lo.short_name = 'Adición y sustracción hasta 100'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la descomposición correcta de 46?', '["40 + 6", "4 + 6", "40 + 60", "4 + 60"]', 0, '46 = 40 + 6 (4 decenas y 6 unidades).', 'inicial', 25),
  ('Si compones 50 + 9, ¿qué número obtienes?', '["59", "95", "14", "509"]', 0, '50 + 9 = 59.', 'intermedia', 35),
  ('¿Cuál de estas descomposiciones NO corresponde al número 73?', '["70 + 3", "60 + 13", "50 + 23", "7 + 3"]', 3, '7 + 3 = 10, no 73; las otras tres sí equivalen a 73.', 'intermedia', 35),
  ('Un número se descompone en 8 decenas y 5 unidades. ¿Cuál es el número?', '["85", "58", "805", "13"]', 0, '8 decenas equivalen a 80; 80 + 5 = 85.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_2_basico' and lo.short_name = 'Composición y descomposición hasta 100'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si divides una torta en 2 partes iguales, ¿cómo se llama cada parte?', '["Un medio (1/2)", "Un cuarto (1/4)", "Un tercio (1/3)", "Un entero"]', 0, 'Al dividir en 2 partes iguales, cada parte es un medio (1/2).', 'inicial', 25),
  ('¿Cuántos cuartos forman un entero?', '["4", "2", "3", "8"]', 0, 'Un entero se divide en 4 cuartos (4 x 1/4 = 1).', 'intermedia', 35),
  ('Si un chocolate se divide en 4 partes iguales y comes 1 parte, ¿qué fracción del chocolate comiste?', '["1/4", "1/2", "2/4", "4/4"]', 0, 'Comer 1 de las 4 partes iguales corresponde a la fracción 1/4.', 'intermedia', 35),
  ('Si comes 2 de los 4 cuartos de una pizza, ¿qué fracción equivalente representa lo que comiste?', '["1/2 de la pizza", "1/4 de la pizza", "3/4 de la pizza", "toda la pizza"]', 0, '2/4 es equivalente a 1/2; comer 2 de 4 cuartos es comer la mitad de la pizza.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_2_basico' and lo.short_name = 'Fracciones simples: mitades y cuartos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Usando el cálculo mental, ¿cuánto es 8 + 7?', '["15", "14", "16", "13"]', 0, '8 + 7 se puede pensar como 8 + 2 + 5 = 10 + 5 = 15.', 'inicial', 25),
  ('Para calcular 9 + 6 mentalmente, Marta piensa "9 + 1 + 5". ¿A qué resultado llega?', '["15", "14", "16", "10"]', 0, '9 + 1 = 10, y 10 + 5 = 15.', 'intermedia', 35),
  ('¿Cuál es una forma rápida de calcular 15 - 9 mentalmente?', '["Pensar en 15 - 10 + 1 = 6", "Pensar en 15 + 9 = 24", "Pensar en 9 - 15", "Contar desde 0 hasta 15"]', 0, '15 - 9 se puede calcular como 15 - 10 + 1 = 5 + 1 = 6.', 'intermedia', 35),
  ('Usando cálculo mental, ¿cuánto es 17 - 8?', '["9", "10", "8", "11"]', 0, '17 - 8 se puede pensar como 17 - 7 - 1 = 10 - 1 = 9.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_2_basico' and lo.short_name = 'Estrategias de cálculo mental'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: PATRONES Y ÁLGEBRA — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En la secuencia 5, 10, 15, 20, ¿cuál es la regla que la genera?', '["Sumar 5 cada vez", "Sumar 10 cada vez", "Restar 5 cada vez", "Multiplicar por 2"]', 0, 'Cada número aumenta en 5 respecto al anterior: la regla es sumar 5.', 'inicial', 25),
  ('Si la regla de una secuencia es "sumar 4" y comienza en 3, ¿cuáles son los primeros 4 términos?', '["3, 7, 11, 15", "3, 4, 8, 12", "3, 6, 9, 12", "4, 8, 12, 16"]', 0, 'Comenzando en 3 y sumando 4 cada vez: 3, 7, 11, 15.', 'intermedia', 35),
  ('¿Cuál es la regla de la secuencia 40, 35, 30, 25?', '["Restar 5 cada vez", "Sumar 5 cada vez", "Restar 10 cada vez", "Dividir por 5"]', 0, 'Cada número disminuye en 5 respecto al anterior: la regla es restar 5.', 'intermedia', 35),
  ('Una secuencia sigue la regla "sumar 6" y comienza en 2. ¿Cuál es el quinto término (contando el 2 como el primero)?', '["26", "20", "24", "28"]', 0, '2, 8, 14, 20, 26: el quinto término es 26.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_2_basico' and lo.short_name = 'Patrones numéricos con una regla'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Completa: 15 + ___ = 20', '["5", "4", "6", "35"]', 0, '15 + 5 = 20.', 'inicial', 25),
  ('Completa: ___ - 12 = 8', '["20", "4", "24", "16"]', 0, '20 - 12 = 8.', 'intermedia', 35),
  ('En 9 + 6 = ___ + 8, ¿qué número falta?', '["7", "6", "8", "15"]', 0, '9 + 6 = 15; para que ___ + 8 también sea 15, el número que falta es 7.', 'intermedia', 35),
  ('¿Cuál es el valor desconocido en 30 - ___ = 12 + 6?', '["12", "18", "42", "6"]', 0, '12 + 6 = 18; para que 30 - ___ sea 18, el número que falta es 12.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_2_basico' and lo.short_name = 'Valores desconocidos en igualdades'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es el doble de 8?', '["16", "4", "24", "10"]', 0, 'El doble de 8 es 8 x 2 = 16.', 'inicial', 25),
  ('¿Cuál es la mitad de 18?', '["9", "36", "8", "6"]', 0, 'La mitad de 18 es 18 ÷ 2 = 9.', 'intermedia', 35),
  ('¿Cuál es el triple de 6?', '["18", "12", "9", "24"]', 0, 'El triple de 6 es 6 x 3 = 18.', 'intermedia', 35),
  ('Si el doble de un número es 24, ¿cuál es ese número?', '["12", "48", "6", "26"]', 0, 'Si el doble es 24, el número original es 24 ÷ 2 = 12.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_2_basico' and lo.short_name = 'Doble, triple y mitad'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En la secuencia 2, 5, 8, 11, cada término se obtiene sumando un número al anterior. ¿Cuál es ese número?', '["3", "2", "5", "4"]', 0, '5 - 2 = 3, 8 - 5 = 3, 11 - 8 = 3: la regla es sumar 3.', 'inicial', 25),
  ('Una secuencia alterna sumar 2 y restar 1, comenzando en 5: 5, 7, 6, 8, 7, ___. ¿Qué número sigue?', '["9", "8", "6", "10"]', 0, 'Tras restar 1 (de 8 a 7), toca sumar 2: 7 + 2 = 9.', 'intermedia', 35),
  ('En la secuencia 3, 6, 5, 8, 7, 10, ___, el patrón alterna sumar 3 y restar 1. ¿Qué número sigue después del 10?', '["9", "13", "11", "7"]', 0, 'Después de sumar 3 (de 7 a 10), toca restar 1: 10 - 1 = 9.', 'intermedia', 35),
  ('Una secuencia sigue la regla "multiplicar por 2 y luego sumar 1": 3, 7, 15, 31, ___. ¿Qué número sigue?', '["63", "62", "32", "64"]', 0, '31 x 2 = 62, y 62 + 1 = 63.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_2_basico' and lo.short_name = 'Secuencias con dos operaciones'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Una balanza está en equilibrio con 8 en un lado y 8 en el otro. Si agregas 3 al lado izquierdo, ¿qué debes hacer para mantener el equilibrio?', '["Agregar 3 al lado derecho también", "Quitar 3 del lado derecho", "No hacer nada", "Agregar 6 al lado derecho"]', 0, 'Para mantener el equilibrio, lo que se agrega a un lado debe agregarse también al otro.', 'inicial', 25),
  ('En una balanza equilibrada, un lado tiene 10 y el otro tiene 6 + ___. ¿Qué número falta?', '["4", "16", "6", "10"]', 0, '6 + 4 = 10, igualando ambos lados de la balanza.', 'intermedia', 35),
  ('Una balanza en equilibrio tiene 12 en un lado y 7 + ___ en el otro. ¿Qué número falta?', '["5", "19", "7", "12"]', 0, '7 + 5 = 12, igualando ambos lados.', 'intermedia', 35),
  ('Una balanza equilibrada tiene 15 + 3 en un lado. Si el otro lado tiene 20 - ___, ¿qué número falta para mantener el equilibrio?', '["2", "18", "20", "38"]', 0, '15 + 3 = 18; para que 20 - ___ también sea 18, el número que falta es 2.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_2_basico' and lo.short_name = 'Uso de la balanza para igualdades'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOMETRÍA — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una cuadrícula, un objeto está en la fila 2 y columna 3. ¿Cómo se describe su posición?', '["Fila 2, columna 3", "Fila 3, columna 2", "Fila 2, fila 3", "Columna 2, columna 3"]', 0, 'La posición se describe indicando primero la fila y luego la columna: fila 2, columna 3.', 'inicial', 25),
  ('Si un objeto se mueve de la columna 1 a la columna 4 sin cambiar de fila, ¿cuántas columnas se desplazó?', '["3", "4", "1", "5"]', 0, 'De la columna 1 a la columna 4 hay un desplazamiento de 3 columnas.', 'intermedia', 35),
  ('Dos objetos están en la misma fila pero en columnas distintas. ¿Qué se puede afirmar sobre su ubicación?', '["Están alineados horizontalmente", "Están alineados verticalmente", "Están en la misma columna", "No se puede describir su ubicación"]', 0, 'Si comparten la misma fila, están alineados horizontalmente.', 'intermedia', 35),
  ('Un objeto está en fila 3, columna 2. Se mueve 2 filas hacia abajo y 1 columna hacia la derecha. ¿Cuál es su nueva posición?', '["Fila 5, columna 3", "Fila 5, columna 1", "Fila 1, columna 3", "Fila 3, columna 3"]', 0, 'Al bajar 2 filas desde la fila 3 se llega a la fila 5; al mover 1 columna a la derecha desde la columna 2 se llega a la columna 3.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_2_basico' and lo.short_name = 'Ubicación mediante coordenadas informales'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas figuras tiene una línea de simetría que la divide en dos mitades iguales?', '["Un círculo", "Una figura sin forma definida", "Una mancha irregular", "Ninguna figura tiene simetría"]', 0, 'Un círculo tiene infinitas líneas de simetría que lo dividen en mitades iguales.', 'inicial', 25),
  ('Si doblas un cuadrado por la mitad y ambas partes coinciden exactamente, ¿qué se puede decir de esa línea de doblez?', '["Es una línea de simetría", "No tiene relación con la simetría", "Es una línea diagonal siempre", "Divide la figura en partes distintas"]', 0, 'Cuando ambas partes coinciden exactamente al doblar, esa línea es una línea de simetría.', 'intermedia', 35),
  ('¿Cuántas líneas de simetría tiene un rectángulo (no cuadrado)?', '["2", "1", "4", "0"]', 0, 'Un rectángulo no cuadrado tiene 2 líneas de simetría: una horizontal y una vertical, ambas por el centro.', 'intermedia', 35),
  ('¿Cuál de estas letras mayúsculas tiene una línea de simetría vertical?', '["A", "F", "G", "P"]', 0, 'La letra A tiene una línea de simetría vertical que la divide en dos mitades iguales; F, G y P no tienen esa simetría.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_2_basico' and lo.short_name = 'Simetría en figuras 2D'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es una guarda en diseño geométrico?', '["Un patrón de figuras que se repite en una franja", "Una figura 3D con muchas caras", "Un número que no tiene fin", "Una línea curva sin patrón"]', 0, 'Una guarda es un patrón de figuras que se repite a lo largo de una franja.', 'inicial', 25),
  ('Para crear un teselado simple con triángulos, ¿qué característica deben tener las figuras al combinarse?', '["Deben cubrir el plano sin dejar espacios ni superponerse", "Deben tener colores distintos siempre", "Deben ser todas curvas", "Deben superponerse parcialmente"]', 0, 'Un teselado cubre el plano completamente, sin dejar espacios vacíos ni superponer las figuras.', 'intermedia', 35),
  ('¿Cuál de estas figuras permite formar un teselado simple usando solo esa figura, sin dejar espacios?', '["El cuadrado", "El círculo", "Una estrella de 5 puntas", "Un óvalo"]', 0, 'El cuadrado puede repetirse y cubrir el plano sin dejar espacios, a diferencia del círculo o el óvalo.', 'intermedia', 35),
  ('Una guarda se forma repitiendo el patrón "triángulo, cuadrado, triángulo, cuadrado". Si la guarda tiene 10 figuras en total, ¿cuántos cuadrados hay?', '["5", "10", "4", "6"]', 0, 'El patrón alterna triángulo y cuadrado; en 10 figuras hay 5 triángulos y 5 cuadrados.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_2_basico' and lo.short_name = 'Guardas y teselados'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es una red o desarrollo plano de un cuerpo 3D?', '["La figura que se obtiene al \"desdoblar\" sus caras sobre un plano", "Un dibujo del cuerpo visto desde arriba solamente", "Una lista de sus vértices", "El nombre del cuerpo en otro idioma"]', 0, 'La red de un cuerpo 3D es la figura plana que se obtiene al desdoblar todas sus caras.', 'inicial', 25),
  ('¿Cuántas caras cuadradas tiene la red de un cubo?', '["6", "4", "8", "12"]', 0, 'Un cubo tiene 6 caras cuadradas, y su red muestra las 6 desdobladas en un plano.', 'intermedia', 35),
  ('¿Qué cuerpo 3D se forma al doblar una red compuesta por 2 triángulos y 3 rectángulos?', '["Un prisma triangular", "Un cubo", "Una esfera", "Un cono"]', 0, 'Un prisma triangular tiene 2 caras triangulares (bases) y 3 caras rectangulares (laterales).', 'intermedia', 35),
  ('Si la red de un cuerpo 3D tiene 1 cara cuadrada y 4 caras triangulares, ¿qué cuerpo representa?', '["Una pirámide de base cuadrada", "Un cubo", "Un prisma rectangular", "Un cilindro"]', 0, 'Una pirámide de base cuadrada tiene 1 base cuadrada y 4 caras triangulares laterales.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_2_basico' and lo.short_name = 'Figuras 3D a partir de redes simples'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si caminas adelante y luego giras para mirar hacia el lado contrario, ¿qué tipo de giro hiciste?', '["Un giro de media vuelta", "Un giro de un cuarto de vuelta", "No giraste", "Un giro hacia arriba"]', 0, 'Girar para mirar hacia el lado contrario corresponde a un giro de media vuelta (180°).', 'inicial', 25),
  ('Si giras un cuarto de vuelta hacia la derecha estando de frente al norte, ¿hacia dónde quedas mirando?', '["Hacia el este", "Hacia el oeste", "Hacia el sur", "Sigues mirando al norte"]', 0, 'Un cuarto de vuelta hacia la derecha desde el norte lleva a mirar hacia el este.', 'intermedia', 35),
  ('Describes un trayecto: "avanza, gira a la izquierda, avanza, gira a la derecha, avanza". ¿Cuántos giros tiene el trayecto?', '["2", "3", "1", "5"]', 0, 'El trayecto tiene 2 giros: uno a la izquierda y otro a la derecha.', 'intermedia', 35),
  ('Estando de frente al este, das un giro de media vuelta y luego un cuarto de vuelta hacia la derecha. ¿Hacia dónde quedas mirando?', '["Hacia el norte", "Hacia el sur", "Hacia el este", "Hacia el oeste"]', 0, 'Desde el este, una media vuelta lleva a mirar al oeste; un cuarto de vuelta hacia la derecha desde el oeste lleva a mirar al norte.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_2_basico' and lo.short_name = 'Descripción de trayectos con giros'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: MEDICIÓN — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué instrumento se usa para medir la longitud de un lápiz en centímetros?', '["Una regla", "Una balanza", "Un reloj", "Un termómetro"]', 0, 'La regla es el instrumento adecuado para medir longitudes en centímetros.', 'inicial', 25),
  ('Si una mesa mide 120 centímetros, ¿cuántos metros es aproximadamente?', '["Un poco más de 1 metro", "Exactamente 2 metros", "Menos de medio metro", "Exactamente 12 metros"]', 0, '120 cm equivale a 1 metro y 20 cm, es decir, un poco más de 1 metro.', 'intermedia', 35),
  ('Un lápiz mide 15 cm y una regla mide 30 cm. ¿Cuántos lápices, uno tras otro, se necesitan para igualar la longitud de la regla?', '["2", "3", "1", "4"]', 0, '30 cm ÷ 15 cm = 2; se necesitan 2 lápices puestos uno tras otro.', 'intermedia', 35),
  ('Se mide una cinta con una regla de 30 cm dos veces completas y sobran 5 cm. ¿Cuánto mide la cinta en total?', '["65 cm", "35 cm", "60 cm", "70 cm"]', 0, 'Dos veces 30 cm son 60 cm, más los 5 cm que sobran, da 65 cm en total.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_2_basico' and lo.short_name = 'Medición de longitudes'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si la manecilla larga está en el 6 y la corta entre el 3 y el 4, ¿qué hora es?', '["Las 3 y media", "Las 6 en punto", "Las 4 en punto", "Las 3 en punto"]', 0, 'Cuando la manecilla larga está en el 6, son "y media"; la corta entre el 3 y 4 indica las 3 y media.', 'inicial', 25),
  ('¿Cómo se muestra "las 8 y media" en un reloj digital?', '["8:30", "8:06", "08:03", "3:08"]', 0, 'Las 8 y media corresponden a 8:30 en formato digital.', 'intermedia', 35),
  ('Si son las 5 y media, ¿cuántos minutos faltan para las 6 en punto?', '["30 minutos", "15 minutos", "60 minutos", "45 minutos"]', 0, 'De las 5:30 a las 6:00 hay 30 minutos.', 'intermedia', 35),
  ('Un evento comienza a las 2 y media y dura 1 hora. ¿A qué hora termina?', '["Las 3 y media", "Las 2 y media", "Las 4 en punto", "Las 3 en punto"]', 0, 'Una hora después de las 2 y media son las 3 y media.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_2_basico' and lo.short_name = 'Hora en punto y media hora'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué objeto pesa más, sin usar una balanza?', '["Un elefante pesa más que una hormiga", "Una hormiga pesa más que un elefante", "Ambos pesan lo mismo", "No se puede estimar sin balanza"]', 0, 'Por su tamaño, es razonable estimar que un elefante pesa mucho más que una hormiga.', 'inicial', 25),
  ('¿Cuál es una forma no estandarizada de estimar el peso de una manzana?', '["Comparándola con el peso de una pelota conocida en la mano", "Usando un termómetro", "Usando un reloj", "Usando una regla"]', 0, 'Para estimar peso sin instrumentos, se puede comparar con el peso de un objeto conocido sostenido en la mano.', 'intermedia', 35),
  ('Si una bolsa de arroz pesa más que una bolsa de algodón del mismo tamaño, ¿qué se puede afirmar?', '["El arroz es más pesado que el algodón en ese volumen", "El algodón es más pesado que el arroz", "Ambos pesan igual siempre", "El tamaño determina el peso, no el material"]', 0, 'Si la bolsa de arroz pesa más con el mismo tamaño, el arroz es más pesado que el algodón en ese volumen.', 'intermedia', 35),
  ('Tienes tres objetos: A pesa más que B, y B pesa más que C. ¿Cuál es el objeto más liviano?', '["El objeto C", "El objeto A", "El objeto B", "No se puede saber"]', 0, 'Si A es mayor que B y B es mayor que C en peso, entonces C es el más liviano de los tres.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_2_basico' and lo.short_name = 'Estimación de peso'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué recipiente tiene mayor capacidad: un balde o un vaso?', '["El balde", "El vaso", "Ambos tienen la misma capacidad", "Depende del color"]', 0, 'El balde tiene mayor capacidad que el vaso; puede contener más líquido.', 'inicial', 25),
  ('Si una botella contiene 1 litro y un vaso contiene medio litro, ¿cuántos vasos se necesitan para llenar la botella?', '["2", "1", "4", "3"]', 0, '1 litro ÷ 0,5 litro = 2 vasos.', 'intermedia', 35),
  ('Un jarro tiene una capacidad de 2 litros. ¿Cuántos jarros se necesitan para juntar 6 litros?', '["3", "6", "2", "4"]', 0, '6 litros ÷ 2 litros = 3 jarros.', 'intermedia', 35),
  ('Un balde de 5 litros está lleno hasta la mitad. ¿Cuántos litros de agua tiene actualmente?', '["2,5 litros", "5 litros", "2 litros", "10 litros"]', 0, 'La mitad de 5 litros es 2,5 litros.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_2_basico' and lo.short_name = 'Comparación de capacidades'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: DATOS Y PROBABILIDADES — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es un buen ejemplo de pregunta para recolectar datos sobre gustos de un curso?', '["¿Cuál es tu fruta favorita?", "¿Cuánto es 2+2?", "¿Cómo te llamas?", "¿Qué día es hoy?"]', 0, 'Una pregunta sobre gustos, como la fruta favorita, permite recolectar datos comparables entre varias personas.', 'inicial', 25),
  ('Después de formular una pregunta, ¿qué se debe hacer para recolectar los datos?', '["Preguntar a un grupo de personas y registrar sus respuestas", "Adivinar las respuestas sin preguntar", "Inventar los datos", "Solo preguntar a una persona y generalizar"]', 0, 'Recolectar datos implica preguntar a un grupo de personas y registrar cada respuesta.', 'intermedia', 35),
  ('Si formulas la pregunta "¿Cuántas mascotas tienes?", ¿qué tipo de dato esperas recibir como respuesta?', '["Un número", "Un color", "Un nombre propio", "Una fecha"]', 0, 'La pregunta pide una cantidad, por lo que la respuesta esperada es un número.', 'intermedia', 35),
  ('Un estudiante quiere saber cuál es el deporte favorito de su curso. ¿Cuál de estas preguntas es más adecuada para recolectar ese dato?', '["¿Cuál es tu deporte favorito?", "¿Te gusta el deporte?", "¿Cuántos años tienes?", "¿Dónde vives?"]', 0, 'Preguntar directamente por el deporte favorito permite recolectar el dato específico buscado, a diferencia de una pregunta de sí/no o de otro tema.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_2_basico' and lo.short_name = 'Preguntas y recolección de datos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En un gráfico de barras, ¿qué representa la altura de cada barra?', '["La cantidad de esa categoría", "El color de la categoría", "El orden alfabético", "El nombre de la categoría"]', 0, 'La altura de la barra representa la cantidad correspondiente a esa categoría.', 'inicial', 25),
  ('En un gráfico de barras, la barra de "perro" llega a 8 y la de "gato" llega a 5. ¿Cuántos más son los perros que los gatos?', '["3", "8", "5", "13"]', 0, '8 - 5 = 3 más perros que gatos.', 'intermedia', 35),
  ('Si en un gráfico de barras la categoría con mayor cantidad es "fútbol" con 12, ¿qué se puede afirmar sobre esa categoría?', '["Es la más elegida entre las opciones del gráfico", "Es la menos elegida", "Tiene el mismo valor que las demás", "No se puede saber su valor"]', 0, 'La barra más alta representa la categoría más elegida o con mayor cantidad.', 'intermedia', 35),
  ('Un gráfico de barras muestra: rojo (6), azul (4), verde (2). ¿Cuántas respuestas se registraron en total?', '["12", "6", "10", "8"]', 0, '6 + 4 + 2 = 12 respuestas en total.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_2_basico' and lo.short_name = 'Pictogramas y gráficos de barra simples'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Una bolsa tiene 9 bolitas rojas y 1 bolita azul. ¿Qué color es más probable sacar al azar?', '["Rojo", "Azul", "Ambos son igual de probables", "No se puede saber"]', 0, 'Como hay muchas más bolitas rojas (9) que azules (1), es más probable sacar una roja.', 'inicial', 25),
  ('Una bolsa tiene 5 bolitas rojas y 5 azules. ¿Qué se puede decir sobre la probabilidad de sacar cada color?', '["Ambos colores son igual de probables", "El rojo es más probable", "El azul es más probable", "No se puede sacar ninguno"]', 0, 'Con la misma cantidad de cada color, ambos son igual de probables.', 'intermedia', 35),
  ('¿Cuál de estos eventos es MENOS probable si lanzas un dado de 6 caras?', '["Sacar un número mayor que 5 (solo el 6 cumple)", "Sacar un número menor que 5", "Sacar un número par", "Sacar un número impar"]', 0, 'Solo el número 6 es mayor que 5 (1 de 6 opciones), por lo que ese evento es el menos probable de los cuatro.', 'intermedia', 35),
  ('Una bolsa tiene 3 bolitas verdes, 2 amarillas y 1 roja. Ordena los colores del más probable al menos probable al sacar uno al azar.', '["Verde, amarillo, rojo", "Rojo, amarillo, verde", "Amarillo, verde, rojo", "Rojo, verde, amarillo"]', 0, 'Verde tiene 3 bolitas (más probable), amarillo 2, y rojo solo 1 (menos probable).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_2_basico' and lo.short_name = 'Eventos más o menos probables'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 2° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una tabla de conteo, ¿qué representa cada marca o rayita?', '["Una respuesta u observación registrada", "El nombre de la categoría", "El color de la categoría", "El total general siempre"]', 0, 'Cada marca en una tabla de conteo representa una respuesta u observación individual registrada.', 'inicial', 25),
  ('En una tabla de conteo, "manzana" tiene 6 marcas y "plátano" tiene 4 marcas. ¿Cuál fruta fue elegida más veces?', '["Manzana", "Plátano", "Ambas por igual", "No se puede saber"]', 0, '6 marcas es más que 4 marcas, por lo que manzana fue elegida más veces.', 'intermedia', 35),
  ('Una tabla de conteo registra: lunes (3), martes (5), miércoles (2). ¿Cuántas observaciones se registraron en total?', '["10", "8", "7", "5"]', 0, '3 + 5 + 2 = 10 observaciones en total.', 'intermedia', 35),
  ('En una tabla de conteo de colores preferidos: azul (7), rojo (7), verde (3). ¿Qué se puede afirmar sobre azul y rojo?', '["Fueron elegidos la misma cantidad de veces", "Azul fue elegido más veces que rojo", "Rojo fue elegido más veces que azul", "Ninguno fue elegido"]', 0, 'Azul y rojo tienen ambos 7 marcas, es decir, la misma cantidad.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_2_basico' and lo.short_name = 'Tablas de conteo'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
