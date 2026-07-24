-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Matemática,
-- 6° Básico. Mismo patrón, alcance, estado editorial e idempotencia que
-- supabase/seed/0026_questions_matematica_regular_1basico.sql (ver ese
-- archivo para el detalle completo de las decisiones de diseño). Con este
-- archivo se completa la cobertura de los 144 objetivos de 0011
-- (1° a 6° Básico, 5 ejes) con banco de preguntas de selección múltiple.

-- ============================================================================
-- EJE: NÚMEROS — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un problema requiere calcular 45 x 12 - 60. ¿Cuál es el resultado?', '["480", "540", "420", "600"]', 0, '45 x 12 = 540; 540 - 60 = 480.', 'inicial', 25),
  ('Se compran 8 cajas de 15 lápices cada una y se reparten en partes iguales entre 4 salas. ¿Cuántos lápices recibe cada sala?', '["30", "24", "20", "40"]', 0, '8 x 15 = 120 lápices en total; 120 ÷ 4 = 30 por sala.', 'intermedia', 35),
  ('Un estacionamiento tiene 6 filas de 24 autos cada una. Si se retiran 50 autos, ¿cuántos autos quedan?', '["94", "104", "84", "144"]', 0, '6 x 24 = 144 autos en total; 144 - 50 = 94.', 'intermedia', 35),
  ('Una empresa produce 250 unidades diarias durante 12 días, y luego reduce su producción a 180 unidades diarias durante 8 días más. ¿Cuántas unidades produjo en total?', '["4.440", "3.000", "1.440", "5.560"]', 0, '250 x 12 = 3.000; 180 x 8 = 1.440; 3.000 + 1.440 = 4.440.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_6_basico' and lo.short_name = 'Cuatro operaciones con números naturales'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('2/3 + 1/6 = ?', '["5/6", "3/9", "1/2", "3/6"]', 0, 'Usando denominador común 6: 4/6 + 1/6 = 5/6.', 'inicial', 25),
  ('0,4 x 0,5 = ?', '["0,2", "0,9", "2", "0,45"]', 0, '0,4 x 0,5 = 0,2.', 'intermedia', 35),
  ('3/4 x 2/3 = ?', '["1/2 (6/12)", "5/7", "2/4", "6/7"]', 0, '(3x2)/(4x3) = 6/12, que se simplifica a 1/2.', 'intermedia', 35),
  ('1,8 ÷ 0,3 = ?', '["6", "0,6", "0,54", "5,4"]', 0, '1,8 ÷ 0,3 = 6.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_6_basico' and lo.short_name = 'Cuatro operaciones con fracciones y decimales'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuánto es el 10% de 200?', '["20", "10", "200", "2"]', 0, '10% de 200 = 200 x 0,10 = 20.', 'inicial', 25),
  ('Un producto de $5.000 tiene un descuento del 20%. ¿Cuánto es el descuento en pesos?', '["$1.000", "$500", "$2.000", "$4.000"]', 0, '5.000 x 0,20 = 1.000.', 'intermedia', 35),
  ('Si el 25% de un número es 40, ¿cuál es ese número?', '["160", "10", "100", "400"]', 0, '40 ÷ 0,25 = 160.', 'intermedia', 35),
  ('Un artículo cuesta $12.000 y tiene un descuento del 15%. ¿Cuál es el precio final?', '["$10.200", "$1.800", "$10.800", "$9.000"]', 0, '15% de 12.000 = 1.800; 12.000 - 1.800 = 10.200.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_6_basico' and lo.short_name = 'Porcentaje en situaciones cotidianas'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('La temperatura en una ciudad es -3°C. ¿Qué significa ese valor?', '["Que la temperatura está 3 grados bajo cero", "Que la temperatura es 3 grados sobre cero", "Que no hay temperatura registrada", "Que la temperatura es exactamente 0°C"]', 0, 'Un valor negativo de temperatura indica grados bajo cero.', 'inicial', 25),
  ('Ordena de menor a mayor: -5, 3, -8, 0.', '["-8, -5, 0, 3", "-5, -8, 0, 3", "3, 0, -5, -8", "-8, 0, -5, 3"]', 0, '-8 < -5 < 0 < 3.', 'intermedia', 35),
  ('Un buzo se encuentra a -15 metros de altitud (15 metros bajo el nivel del mar) y sube 8 metros. ¿A qué altitud queda?', '["-7 metros", "-23 metros", "7 metros", "23 metros"]', 0, '-15 + 8 = -7.', 'intermedia', 35),
  ('La temperatura era de -4°C en la mañana y subió 10°C durante el día. ¿Cuál fue la temperatura al final del día?', '["6°C", "14°C", "-14°C", "-6°C"]', 0, '-4 + 10 = 6.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_6_basico' and lo.short_name = 'Números negativos en contexto'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es el máximo común divisor (MCD) de 8 y 12?', '["4", "2", "24", "96"]', 0, 'El mayor divisor común de 8 y 12 es 4.', 'inicial', 25),
  ('¿Cuál es el mínimo común múltiplo (MCM) de 4 y 6?', '["12", "24", "10", "2"]', 0, 'El menor múltiplo común de 4 y 6 es 12.', 'intermedia', 35),
  ('¿Cuál es el MCD de 18 y 24?', '["6", "3", "2", "12"]', 0, 'El mayor divisor común de 18 y 24 es 6.', 'intermedia', 35),
  ('Dos autobuses salen juntos de una terminal. Uno regresa cada 15 minutos y el otro cada 20 minutos. ¿Cada cuántos minutos vuelven a salir juntos?', '["Cada 60 minutos", "Cada 35 minutos", "Cada 300 minutos", "Cada 5 minutos"]', 0, 'El mínimo común múltiplo de 15 y 20 es 60.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_6_basico' and lo.short_name = 'Mínimo común múltiplo y máximo común divisor'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una razón de 3:4, si el primer término es 6, ¿cuál es el segundo término manteniendo la proporción?', '["8", "6", "12", "4"]', 0, '3:4 = 6:8, manteniendo la proporción.', 'inicial', 25),
  ('Si por cada 2 lápices se pagan $600, ¿cuánto se paga por 5 lápices manteniendo la misma razón?', '["$1.500", "$1.200", "$3.000", "$600"]', 0, '600 ÷ 2 = 300 por lápiz; 300 x 5 = 1.500.', 'intermedia', 35),
  ('En una receta, la razón de harina a azúcar es 3:1. Si se usan 9 tazas de harina, ¿cuántas tazas de azúcar se necesitan?', '["3", "1", "9", "27"]', 0, '9 ÷ 3 = 3 tazas de azúcar, manteniendo la razón 3:1.', 'intermedia', 35),
  ('Una razón de 5:8 se mantiene proporcional. Si el segundo término es 40, ¿cuál es el primer término?', '["25", "64", "45", "32"]', 0, '5:8 = 25:40, manteniendo la proporción.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_6_basico' and lo.short_name = 'Razones y proporciones'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: PATRONES Y ÁLGEBRA — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Reduce la expresión: 3n + 2n', '["5n", "6n", "n", "5n²"]', 0, '3n + 2n = 5n.', 'inicial', 25),
  ('Reduce la expresión: 7n - 3n + 2', '["4n + 2", "4n", "10n + 2", "7n - 1"]', 0, '7n - 3n = 4n; queda 4n + 2.', 'intermedia', 35),
  ('Reduce la expresión: 5n + 3 - 2n + 1', '["3n + 4", "3n + 3", "7n + 4", "2n + 4"]', 0, '5n - 2n = 3n; 3 + 1 = 4; queda 3n + 4.', 'intermedia', 35),
  ('Reduce la expresión: 4(n + 2) - 3n', '["n + 8", "4n + 8", "n + 2", "n - 8"]', 0, '4(n+2) = 4n + 8; 4n + 8 - 3n = n + 8.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_6_basico' and lo.short_name = 'Reducción de expresiones algebraicas simples'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Resuelve: n + (-5) = 3', '["8", "-2", "2", "-8"]', 0, 'n = 3 - (-5) = 8.', 'inicial', 25),
  ('Resuelve: n - 7 = -10', '["-3", "3", "17", "-17"]', 0, 'n = -10 + 7 = -3.', 'intermedia', 35),
  ('Resuelve la inecuación: n - 4 > -2. ¿Cuál de estos valores enteros cumple la inecuación?', '["3", "2", "1", "0"]', 0, 'Si n - 4 > -2, entonces n > 2; el único valor mayor que 2 entre las opciones es 3.', 'intermedia', 35),
  ('Resuelve: 3n + 5 = -4', '["-3", "3", "-9", "9"]', 0, '3n = -4 - 5 = -9; n = -9 ÷ 3 = -3.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_6_basico' and lo.short_name = 'Ecuaciones e inecuaciones con enteros'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una tabla, cuando x=1, y=3; cuando x=2, y=6; cuando x=3, y=9. ¿Qué tipo de relación es esta?', '["Proporcionalidad directa", "Proporcionalidad inversa", "No hay relación", "Relación decreciente"]', 0, 'y siempre es el triple de x, manteniendo una razón constante: es proporcionalidad directa.', 'inicial', 25),
  ('Si la constante de proporcionalidad directa es 5, y x=4, ¿cuál es el valor de y?', '["20", "9", "1,25", "45"]', 0, 'y = 5 x 4 = 20.', 'intermedia', 35),
  ('En una tabla de proporcionalidad directa, si x=6 corresponde a y=18, ¿cuál es la constante de proporcionalidad?', '["3", "6", "18", "24"]', 0, '18 ÷ 6 = 3.', 'intermedia', 35),
  ('En un gráfico de proporcionalidad directa, la línea pasa por el origen (0,0) y por el punto (4, 12). ¿Cuál es el valor de y cuando x = 7?', '["21", "28", "19", "24"]', 0, 'La constante es 12 ÷ 4 = 3; y = 3 x 7 = 21.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_6_basico' and lo.short_name = 'Proporcionalidad en tablas y gráficos'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si x representa el número de entradas al cine y cada entrada cuesta $3.500, ¿qué expresión representa el costo total?', '["3.500x", "x + 3.500", "3.500/x", "x - 3.500"]', 0, 'El costo total es el precio por entrada multiplicado por la cantidad de entradas: 3.500x.', 'inicial', 25),
  ('Si un taxi cobra $500 fijos más $200 por cada kilómetro recorrido (k), ¿qué expresión representa el costo total?', '["500 + 200k", "500k + 200", "500 - 200k", "(500+200)k"]', 0, 'El costo fijo se suma al costo variable por kilómetro: 500 + 200k.', 'intermedia', 35),
  ('Si el perímetro de un cuadrado de lado L se representa como P, ¿cuál es la expresión algebraica de P?', '["P = 4L", "P = L/4", "P = L + 4", "P = L²"]', 0, 'El perímetro de un cuadrado es 4 veces la medida de su lado.', 'intermedia', 35),
  ('Un plan de telefonía cobra $2.000 fijos más $50 por cada minuto (m) usado. Si un cliente gastó $4.500 en total, ¿qué ecuación permite encontrar los minutos usados?', '["2.000 + 50m = 4.500", "50 + 2.000m = 4.500", "2.000m + 50 = 4.500", "2.000 - 50m = 4.500"]', 0, 'El costo fijo más el costo variable por minuto debe ser igual al total gastado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_6_basico' and lo.short_name = 'Expresiones algebraicas para representar relaciones'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si 3 kilogramos de manzanas cuestan $2.400, ¿cuánto cuestan 6 kilogramos manteniendo la misma proporción?', '["$4.800", "$2.400", "$7.200", "$1.200"]', 0, '2.400 ÷ 3 = 800 por kilo; 800 x 6 = 4.800.', 'inicial', 25),
  ('Un auto recorre 180 km con 15 litros de bencina. ¿Cuántos km recorre con 5 litros, manteniendo la misma proporción?', '["60 km", "36 km", "90 km", "15 km"]', 0, '180 ÷ 15 = 12 km por litro; 12 x 5 = 60 km.', 'intermedia', 35),
  ('Si por cada 2 horas de trabajo se ganan $8.000, ¿cuánto se gana por 5 horas de trabajo, manteniendo la misma proporción?', '["$20.000", "$16.000", "$10.000", "$40.000"]', 0, '8.000 ÷ 2 = 4.000 por hora; 4.000 x 5 = 20.000.', 'intermedia', 35),
  ('Una receta para 4 personas usa 300 gramos de arroz. Si se quiere preparar la misma receta para 10 personas, manteniendo la proporción, ¿cuántos gramos de arroz se necesitan?', '["750 gramos", "600 gramos", "1.200 gramos", "300 gramos"]', 0, '300 ÷ 4 = 75 gramos por persona; 75 x 10 = 750 gramos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_6_basico' and lo.short_name = 'Resolución de problemas con proporcionalidad directa'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOMETRÍA — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué instrumento se usa para construir un ángulo de una medida específica?', '["El transportador", "La balanza", "El reloj", "El calendario"]', 0, 'El transportador permite trazar y verificar la medida exacta de un ángulo.', 'inicial', 25),
  ('Para construir un ángulo de 90°, ¿qué se debe hacer con el transportador?', '["Marcar el punto donde la escala indica 90° desde el rayo inicial", "Marcar el punto donde la escala indica 45°", "Medir la longitud del rayo", "Contar el número de lados de la figura"]', 0, 'Se traza un rayo desde el vértice hasta el punto donde la escala del transportador marca 90°.', 'intermedia', 35),
  ('Si construyes un ángulo de 120° y luego uno de 60° con el mismo vértice y un lado en común, ¿qué se puede afirmar sobre ellos?', '["El de 120° es el doble del de 60°", "El de 60° es mayor que el de 120°", "Ambos ángulos son iguales", "No se pueden comparar"]', 0, '120° es exactamente el doble de 60°.', 'intermedia', 35),
  ('Se construye un ángulo de 35° y luego se le agrega otro ángulo de 55° adyacente (compartiendo un lado). ¿Cuál es la medida del ángulo total?', '["90°", "20°", "1.925°", "180°"]', 0, '35° + 55° = 90°.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_6_basico' and lo.short_name = 'Construcción de ángulos'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Una figura compuesta está formada por un rectángulo de 8 cm x 5 cm y un triángulo de base 5 cm y altura 4 cm. ¿Cuál es el área total?', '["50 cm²", "40 cm²", "30 cm²", "45 cm²"]', 0, 'Área del rectángulo: 40 cm²; área del triángulo: (5x4)÷2=10 cm²; total: 50 cm².', 'inicial', 25),
  ('Una figura compuesta tiene un perímetro formado por 2 lados de 6 cm, 2 lados de 4 cm y 1 lado de 3 cm. ¿Cuál es su perímetro total?', '["23 cm", "20 cm", "19 cm", "26 cm"]', 0, '2x6 + 2x4 + 3 = 12+8+3 = 23 cm.', 'intermedia', 35),
  ('Una figura en forma de "L" se compone de un rectángulo de 10x6 cm menos un rectángulo de 4x3 cm recortado en una esquina. ¿Cuál es el área de la figura?', '["48 cm²", "60 cm²", "12 cm²", "54 cm²"]', 0, '10x6=60; 4x3=12; 60-12=48 cm².', 'intermedia', 35),
  ('Una figura compuesta está formada por un cuadrado de lado 6 cm y un semicírculo de diámetro 6 cm adosado a uno de sus lados. Usando 3,14 para pi, ¿cuál es el área total aproximada?', '["Aproximadamente 50,1 cm²", "Aproximadamente 36 cm²", "Aproximadamente 64,3 cm²", "Aproximadamente 42 cm²"]', 0, 'Área del cuadrado: 36 cm²; área del semicírculo (radio 3 cm): (3,14x9)÷2≈14,13 cm²; total≈50,1 cm².', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_6_basico' and lo.short_name = 'Área y perímetro de figuras compuestas'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa "teselar el plano" con una figura?', '["Cubrir completamente una superficie con esa figura, sin dejar espacios ni superponerla", "Dibujar la figura una sola vez", "Medir el área de la figura", "Colorear la figura de distintos colores"]', 0, 'Teselar el plano significa cubrirlo completamente con una o más figuras, sin espacios vacíos ni superposiciones.', 'inicial', 25),
  ('¿Cuál de estos polígonos regulares SÍ permite teselar el plano usando solo esa figura?', '["El hexágono regular", "El pentágono regular", "El heptágono regular", "El octágono regular"]', 0, 'El hexágono regular tesela el plano perfectamente, ya que sus ángulos internos (120°) permiten que 3 de ellos se junten exactamente en 360° alrededor de un punto.', 'intermedia', 35),
  ('Al combinar triángulos equiláteros para teselar el plano, ¿cuántos triángulos se juntan alrededor de un mismo punto?', '["6", "3", "4", "12"]', 0, 'Cada ángulo interior de un triángulo equilátero mide 60°; 360° ÷ 60° = 6 triángulos.', 'intermedia', 35),
  ('Una teselación combina cuadrados y triángulos alrededor de un punto. Si cada cuadrado aporta 90° y cada triángulo aporta 60°, ¿cuántos triángulos se necesitan junto con 2 cuadrados para completar 360° alrededor del punto?', '["3 triángulos", "2 triángulos", "4 triángulos", "6 triángulos"]', 0, '2 cuadrados aportan 180°; quedan 180° por completar; 180° ÷ 60° = 3 triángulos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_6_basico' and lo.short_name = 'Teselaciones del plano'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Cuando una recta transversal corta dos rectas paralelas, ¿cómo se llaman los ángulos que quedan en la misma posición relativa en cada intersección?', '["Ángulos correspondientes", "Ángulos opuestos por el vértice", "Ángulos complementarios", "Ángulos suplementarios únicamente"]', 0, 'Los ángulos en la misma posición relativa en cada intersección se llaman ángulos correspondientes, y son iguales entre sí cuando las rectas son paralelas.', 'inicial', 25),
  ('Si dos rectas paralelas son cortadas por una transversal, y un ángulo correspondiente mide 70°, ¿cuánto mide su ángulo correspondiente en la otra intersección?', '["70°", "110°", "20°", "180°"]', 0, 'Los ángulos correspondientes entre rectas paralelas son iguales: 70°.', 'intermedia', 35),
  ('Los ángulos alternos internos formados por una transversal que corta dos rectas paralelas, ¿qué relación tienen entre sí?', '["Son iguales entre sí", "Suman 90°", "Son siempre de 45°", "No tienen relación"]', 0, 'Los ángulos alternos internos entre rectas paralelas son siempre iguales entre sí.', 'intermedia', 35),
  ('Una transversal corta dos rectas paralelas. Un ángulo mide 65° y su ángulo alterno interno mide "x". Además, ese mismo ángulo de 65° y otro ángulo son suplementarios (suman 180°). ¿Cuánto miden x y el ángulo suplementario, respectivamente?', '["x = 65° y el suplementario = 115°", "x = 115° y el suplementario = 65°", "x = 90° y el suplementario = 90°", "x = 65° y el suplementario = 65°"]', 0, 'El ángulo alterno interno es igual: x = 65°; el ángulo suplementario es 180° - 65° = 115°.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_6_basico' and lo.short_name = 'Ángulos entre rectas y un transversal'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la longitud aproximada de la circunferencia de un círculo con radio 5 cm? (usa pi ≈ 3,14)', '["31,4 cm", "15,7 cm", "78,5 cm", "10 cm"]', 0, 'Circunferencia = 2 x pi x radio = 2 x 3,14 x 5 = 31,4 cm.', 'inicial', 25),
  ('¿Cuál es el área aproximada de un círculo con radio 4 cm? (usa pi ≈ 3,14)', '["50,24 cm²", "25,12 cm²", "12,56 cm²", "100,48 cm²"]', 0, 'Área = pi x radio² = 3,14 x 16 = 50,24 cm².', 'intermedia', 35),
  ('Si el diámetro de un círculo es 10 cm, ¿cuál es su área aproximada? (usa pi ≈ 3,14)', '["78,5 cm²", "31,4 cm²", "157 cm²", "50 cm²"]', 0, 'El radio es 5 cm; área = 3,14 x 25 = 78,5 cm².', 'intermedia', 35),
  ('Un círculo tiene una circunferencia de 62,8 cm (usa pi ≈ 3,14). ¿Cuál es aproximadamente su radio?', '["10 cm", "20 cm", "5 cm", "31,4 cm"]', 0, 'Radio = circunferencia ÷ (2 x pi) = 62,8 ÷ 6,28 = 10 cm.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_6_basico' and lo.short_name = 'Circunferencia: longitud y área del círculo'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: MEDICIÓN — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la fórmula para calcular el volumen de un prisma recto?', '["Volumen = área de la base x altura", "Volumen = perímetro de la base x altura", "Volumen = área de la base ÷ altura", "Volumen = perímetro x área"]', 0, 'El volumen de un prisma recto se calcula multiplicando el área de su base por su altura.', 'inicial', 25),
  ('Un prisma rectangular tiene una base de 5 cm x 4 cm y una altura de 6 cm. ¿Cuál es su volumen?', '["120 cm³", "110 cm³", "96 cm³", "15 cm³"]', 0, 'Área de la base: 5x4=20 cm²; volumen: 20x6=120 cm³.', 'intermedia', 35),
  ('Un prisma tiene una base triangular con área de 12 cm² y una altura de 10 cm. ¿Cuál es su volumen?', '["120 cm³", "22 cm³", "60 cm³", "132 cm³"]', 0, 'Volumen = área de la base x altura = 12 x 10 = 120 cm³.', 'intermedia', 35),
  ('Un prisma rectangular tiene un volumen de 180 cm³. Si su base mide 6 cm x 5 cm, ¿cuál es su altura?', '["6 cm", "5 cm", "30 cm", "3 cm"]', 0, 'Área de la base: 6x5=30 cm²; altura = 180 ÷ 30 = 6 cm.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_6_basico' and lo.short_name = 'Volumen de prismas rectos con fórmula'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuántos centímetros cuadrados tiene 1 metro cuadrado?', '["10.000", "100", "1.000", "100.000"]', 0, '1 m² equivale a 100 x 100 = 10.000 cm².', 'inicial', 25),
  ('¿Cuántos centímetros cúbicos tiene 1 metro cúbico?', '["1.000.000", "10.000", "100.000", "1.000"]', 0, '1 m³ equivale a 100 x 100 x 100 = 1.000.000 cm³.', 'intermedia', 35),
  ('Si un terreno tiene 3 m² de superficie, ¿cuántos cm² son?', '["30.000 cm²", "3.000 cm²", "300.000 cm²", "300 cm²"]', 0, '3 x 10.000 = 30.000 cm².', 'intermedia', 35),
  ('Un recipiente tiene un volumen de 2 m³. ¿Cuántos litros equivale, sabiendo que 1 m³ = 1.000 litros?', '["2.000 litros", "200 litros", "20.000 litros", "2 litros"]', 0, '2 x 1.000 = 2.000 litros.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_6_basico' and lo.short_name = 'Conversión de unidades de superficie y volumen'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un jardín rectangular mide 6 m x 4 m. ¿Cuál es su perímetro y su área?', '["Perímetro 20 m y área 24 m²", "Perímetro 24 m y área 20 m²", "Perímetro 10 m y área 24 m²", "Perímetro 20 m y área 10 m²"]', 0, 'Perímetro = 2 x (6+4) = 20 m; área = 6 x 4 = 24 m².', 'inicial', 25),
  ('Una caja tiene una base de 3 m x 2 m y una altura de 2 m. ¿Cuál es su volumen?', '["12 m³", "7 m³", "10 m³", "24 m³"]', 0, '3 x 2 x 2 = 12 m³.', 'intermedia', 35),
  ('Un patio cuadrado tiene un área de 49 m². ¿Cuál es su perímetro?', '["28 m", "49 m", "14 m", "7 m"]', 0, 'El lado mide 7 m (7x7=49); perímetro = 4 x 7 = 28 m.', 'intermedia', 35),
  ('Una piscina rectangular mide 8 m de largo, 4 m de ancho y 1,5 m de profundidad. ¿Cuántos metros cúbicos de agua se necesitan para llenarla completamente?', '["48 m³", "32 m³", "13,5 m³", "96 m³"]', 0, '8 x 4 x 1,5 = 48 m³.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_6_basico' and lo.short_name = 'Problemas combinados de perímetro, área y volumen'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué representa el área de superficie de un prisma?', '["La suma de las áreas de todas sus caras", "Solo el área de su base", "El volumen del prisma", "El perímetro de una sola cara"]', 0, 'El área de superficie de un prisma es la suma de las áreas de todas sus caras.', 'inicial', 25),
  ('Un cubo tiene arista de 4 cm. ¿Cuál es su área de superficie total?', '["96 cm²", "64 cm²", "24 cm²", "16 cm²"]', 0, 'Cada cara mide 4x4=16 cm²; con 6 caras: 16x6=96 cm².', 'intermedia', 35),
  ('Un prisma rectangular tiene dimensiones 5 cm x 3 cm x 2 cm. Si se calcula el área de solo dos caras opuestas de 5x3 cm, ¿cuál es esa área combinada?', '["30 cm²", "15 cm²", "10 cm²", "6 cm²"]', 0, 'Cada cara mide 5x3=15 cm²; entre las dos caras opuestas: 2x15=30 cm².', 'intermedia', 35),
  ('Un prisma rectangular mide 4 cm x 3 cm x 2 cm. ¿Cuál es su área de superficie total, sumando las áreas de sus 6 caras?', '["52 cm²", "24 cm²", "26 cm²", "48 cm²"]', 0, '2 x (4x3 + 4x2 + 3x2) = 2 x (12+8+6) = 2 x 26 = 52 cm².', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_6_basico' and lo.short_name = 'Área de superficie de prismas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: DATOS Y PROBABILIDADES — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué tipo de gráfico es más adecuado para mostrar la evolución de la temperatura durante una semana?', '["Gráfico de línea", "Gráfico circular", "Pictograma con 1 símbolo", "Ninguno, no se puede graficar el tiempo"]', 0, 'El gráfico de línea es el más adecuado para mostrar cómo cambia un dato a lo largo del tiempo.', 'inicial', 25),
  ('¿Qué tipo de gráfico es más adecuado para mostrar la proporción de cada color favorito respecto al total de un curso?', '["Gráfico circular", "Gráfico de línea", "Tabla vacía", "Ninguno de los anteriores"]', 0, 'El gráfico circular muestra bien la proporción de cada categoría respecto al total.', 'intermedia', 35),
  ('Para comparar la cantidad de ventas de 4 productos distintos en un mes, ¿qué gráfico es más adecuado?', '["Gráfico de barras", "Gráfico de línea (para datos sin orden temporal entre productos)", "Gráfico circular únicamente", "Ningún gráfico es adecuado"]', 0, 'El gráfico de barras permite comparar cantidades entre categorías distintas de forma clara.', 'intermedia', 35),
  ('Se quiere mostrar cómo cambian las ventas mensuales de una tienda durante todo el año, y también comparar la proporción de ventas por categoría de producto en un mes específico. ¿Qué combinación de gráficos es más adecuada?', '["Un gráfico de línea para las ventas mensuales y un gráfico circular para las proporciones por categoría", "Solo un gráfico de barras para todo", "Un pictograma únicamente", "Ningún gráfico puede mostrar esta información"]', 0, 'El gráfico de línea es adecuado para la evolución en el tiempo, y el gráfico circular para mostrar proporciones dentro de un total.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_6_basico' and lo.short_name = 'Comparación de distintos tipos de gráficos'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es una población en un estudio estadístico?', '["El conjunto completo de elementos que se quiere estudiar", "Solo una parte pequeña del grupo total", "Un gráfico circular", "Un tipo de pregunta estadística"]', 0, 'La población es el conjunto completo de elementos sobre el que se quiere obtener información.', 'inicial', 25),
  ('¿Qué es una muestra en un estudio estadístico?', '["Una parte representativa de la población, seleccionada para el estudio", "La población completa", "Un gráfico de barras", "El promedio de los datos"]', 0, 'La muestra es una parte representativa de la población, usada para hacer el estudio sin encuestar a todos.', 'intermedia', 35),
  ('Si se quiere conocer la opinión de todos los estudiantes de un colegio con 2.000 estudiantes, pero solo se encuesta a 100 de ellos, ¿qué representan esos 100 estudiantes?', '["Una muestra de la población total", "La población completa", "Un gráfico circular", "Un promedio exacto"]', 0, 'Los 100 estudiantes encuestados representan una muestra de la población total de 2.000.', 'intermedia', 35),
  ('Un estudio encuesta a una muestra de 200 personas de una ciudad de 500.000 habitantes para estimar sus preferencias. ¿Por qué se usa una muestra en vez de encuestar a toda la población?', '["Porque encuestar a toda la población sería mucho más costoso y demoroso, y una muestra representativa permite estimar resultados similares", "Porque los resultados de una muestra siempre son más exactos que los de la población completa", "Porque la población completa no puede ser estudiada nunca", "Porque las muestras y las poblaciones dan siempre resultados idénticos"]', 0, 'Usar una muestra representativa es más eficiente en tiempo y costo, y permite estimar resultados similares a los de la población completa.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_6_basico' and lo.short_name = 'Estudios con muestras y poblaciones'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al lanzar un dado de 6 caras, ¿cuál es la probabilidad de obtener el número 4?', '["1/6", "1/4", "4/6", "1/2"]', 0, 'Hay 1 caso favorable (el 4) de 6 casos posibles: 1/6.', 'inicial', 25),
  ('En una bolsa hay 10 bolitas: 4 rojas y 6 azules. ¿Cuál es la probabilidad de sacar una bolita roja?', '["4/10 (2/5)", "6/10", "4/6", "10/4"]', 0, '4 casos favorables de 10 posibles: 4/10, que se simplifica a 2/5.', 'intermedia', 35),
  ('Al lanzar un dado de 6 caras, ¿cuál es la probabilidad de obtener un número par?', '["3/6 (1/2)", "2/6", "1/6", "4/6"]', 0, 'Los números pares son 2, 4 y 6: 3 casos favorables de 6, es decir, 3/6 = 1/2.', 'intermedia', 35),
  ('En una bolsa hay 20 bolitas numeradas del 1 al 20. ¿Cuál es la probabilidad de sacar un número múltiplo de 5?', '["4/20 (1/5)", "5/20", "1/20", "4/5"]', 0, 'Los múltiplos de 5 hasta el 20 son 5, 10, 15 y 20: 4 casos favorables de 20, es decir, 4/20 = 1/5.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_6_basico' and lo.short_name = 'Probabilidad como razón de casos favorables'
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
  'Pregunta ValidApp (borrador), Matemática 6° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si lanzas una moneda y un dado a la vez, ¿cuántos resultados posibles hay en total?', '["12", "8", "6", "2"]', 0, '2 resultados de la moneda x 6 del dado = 12 combinaciones posibles.', 'inicial', 25),
  ('Usando un diagrama de árbol, ¿cuántas combinaciones distintas se pueden formar al elegir 1 color entre 3 (rojo, azul, verde) y 1 talla entre 2 (chica, grande)?', '["6", "5", "3", "2"]', 0, '3 colores x 2 tallas = 6 combinaciones.', 'intermedia', 35),
  ('Si tienes 2 tipos de pan y 4 tipos de relleno, ¿cuántos sándwiches distintos puedes formar combinando un pan con un relleno?', '["8", "6", "4", "2"]', 0, '2 panes x 4 rellenos = 8 combinaciones.', 'intermedia', 35),
  ('Un menú de restaurante ofrece 3 entradas, 4 platos principales y 2 postres. ¿Cuántas combinaciones distintas de un menú completo (entrada, plato principal y postre) se pueden formar?', '["24", "9", "20", "12"]', 0, '3 x 4 x 2 = 24 combinaciones distintas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_6_basico' and lo.short_name = 'Combinaciones simples en experimentos aleatorios'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
