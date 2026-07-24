-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Matemática,
-- 3° Básico. Mismo patrón, alcance, estado editorial e idempotencia que
-- supabase/seed/0026_questions_matematica_regular_1basico.sql (ver ese
-- archivo para el detalle completo de las decisiones de diseño).

-- ============================================================================
-- EJE: NÚMEROS — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se escribe 452 en palabras?', '["cuatrocientos cincuenta y dos", "cuatrocientos veinticinco", "quinientos cuarenta y dos", "cuatrocientos cinco"]', 0, '452 se escribe "cuatrocientos cincuenta y dos".', 'inicial', 25),
  ('Ordena de mayor a menor: 305, 350, 503.', '["503, 350, 305", "305, 350, 503", "350, 305, 503", "503, 305, 350"]', 0, '503 > 350 > 305.', 'intermedia', 35),
  ('¿Qué número está compuesto por 6 centenas, 0 decenas y 8 unidades?', '["608", "680", "068", "806"]', 0, '6 centenas + 0 decenas + 8 unidades = 608.', 'intermedia', 35),
  ('Un número tiene 7 centenas y es mayor que 715 pero menor que 720. ¿Cuál puede ser ese número?', '["718", "705", "725", "810"]', 0, '718 tiene 7 centenas y está entre 715 y 720.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_3_basico' and lo.short_name = 'Números hasta 1.000'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('245 + 132 = ?', '["377", "367", "387", "350"]', 0, '245 + 132 = 377.', 'inicial', 25),
  ('Un colegio tenía 620 estudiantes y se retiraron 185. ¿Cuántos estudiantes quedan?', '["435", "445", "425", "405"]', 0, '620 - 185 = 435.', 'intermedia', 35),
  ('478 + 256 = ?', '["734", "724", "744", "714"]', 0, '478 + 256 = 734.', 'intermedia', 35),
  ('En una bodega hay 340 cajas de manzanas y 275 cajas de peras. Si se venden 200 cajas de manzanas, ¿cuántas cajas quedan en total?', '["415", "440", "615", "140"]', 0, '340 + 275 = 615 cajas en total; al vender 200, quedan 615 - 200 = 415.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_3_basico' and lo.short_name = 'Adición y sustracción hasta 1.000'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuánto es 6 x 4?', '["24", "20", "28", "10"]', 0, '6 x 4 = 24.', 'inicial', 25),
  ('36 ÷ 6 = ?', '["6", "5", "7", "4"]', 0, '36 ÷ 6 = 6.', 'intermedia', 35),
  ('Si tienes 5 grupos de 7 lápices cada uno, ¿cuántos lápices hay en total?', '["35", "30", "25", "40"]', 0, '5 x 7 = 35.', 'intermedia', 35),
  ('Se reparten 48 caramelos en partes iguales entre 8 niños. ¿Cuántos caramelos recibe cada niño?', '["6", "5", "7", "8"]', 0, '48 ÷ 8 = 6.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_3_basico' and lo.short_name = 'Multiplicación y división hasta el 10'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En el número 736, ¿qué valor representa el dígito 3?', '["3 decenas (30)", "3 centenas (300)", "3 unidades", "3 unidades de mil"]', 0, 'El dígito 3 está en el lugar de las decenas, por lo que representa 3 decenas, es decir, 30.', 'inicial', 25),
  ('¿Cuántas centenas hay en el número 500?', '["5", "50", "500", "0"]', 0, '500 está formado por 5 centenas (5 x 100 = 500).', 'intermedia', 35),
  ('¿Qué número tiene 4 centenas, 2 decenas y 7 unidades?', '["427", "472", "247", "724"]', 0, '4 centenas + 2 decenas + 7 unidades = 427.', 'intermedia', 35),
  ('Si a 999 le sumas 1, ¿qué número obtienes y cuántas unidades de mil tiene?', '["1.000, con 1 unidad de mil", "990, con 0 unidades de mil", "1.001, con 1 unidad de mil", "900, con 0 unidades de mil"]', 0, '999 + 1 = 1.000, que tiene exactamente 1 unidad de mil.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_3_basico' and lo.short_name = 'Valor posicional hasta la unidad de mil'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si divides una barra de chocolate en 3 partes iguales, ¿cómo se llama cada parte?', '["Un tercio (1/3)", "Un medio (1/2)", "Un cuarto (1/4)", "Un entero"]', 0, 'Al dividir en 3 partes iguales, cada parte es un tercio (1/3).', 'inicial', 25),
  ('Un grupo de 8 fichas se divide en 4 partes iguales. ¿Cuántas fichas representa 1/4 del grupo?', '["2", "4", "8", "1"]', 0, '8 ÷ 4 = 2 fichas por cada cuarta parte.', 'intermedia', 35),
  ('¿Qué fracción representa 3 partes coloreadas de un total de 4 partes iguales?', '["3/4", "4/3", "1/4", "3/3"]', 0, '3 de 4 partes iguales corresponde a la fracción 3/4.', 'intermedia', 35),
  ('De un grupo de 12 caramelos, se separa 1/3. ¿Cuántos caramelos son 1/3 del grupo?', '["4", "3", "6", "12"]', 0, '12 ÷ 3 = 4 caramelos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_3_basico' and lo.short_name = 'Fracciones como parte de un todo'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Usando un arreglo rectangular de 3 filas y 5 columnas, ¿cuántos elementos hay en total?', '["15", "8", "10", "20"]', 0, '3 x 5 = 15.', 'inicial', 25),
  ('Para calcular 6 x 7, Juan piensa "6 x 5 + 6 x 2". ¿A qué resultado llega?', '["42", "36", "48", "35"]', 0, '6 x 5 = 30 y 6 x 2 = 12; 30 + 12 = 42.', 'intermedia', 35),
  ('¿Cuál es una forma de construir la tabla del 9 a partir de la tabla del 10?', '["Restar el número una vez a su producto en la tabla del 10 (10 x n - n)", "Sumar 10 al resultado de la tabla del 10", "Multiplicar por 19", "No hay relación entre ambas tablas"]', 0, '9 x n = 10 x n - n; por ejemplo, 9 x 4 = 40 - 4 = 36.', 'intermedia', 35),
  ('Usando la propiedad de que 8 x 6 = 8 x 5 + 8 x 1, ¿cuál es el resultado de 8 x 6?', '["48", "40", "46", "56"]', 0, '8 x 5 = 40, y 40 + 8 = 48.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_3_basico' and lo.short_name = 'Estrategias de multiplicación'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: PATRONES Y ÁLGEBRA — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Calcula mentalmente: 25 + 19', '["44", "45", "43", "54"]', 0, '25 + 19 = 25 + 20 - 1 = 45 - 1 = 44.', 'inicial', 25),
  ('Para calcular 48 - 19 mentalmente, se puede pensar en 48 - 20 + 1. ¿Cuál es el resultado?', '["29", "28", "30", "27"]', 0, '48 - 20 = 28, y 28 + 1 = 29.', 'intermedia', 35),
  ('Calcula mentalmente: 60 - 24', '["36", "46", "34", "26"]', 0, '60 - 24 = 60 - 20 - 4 = 40 - 4 = 36.', 'intermedia', 35),
  ('Usando cálculo mental, ¿cuánto es 99 + 47?', '["146", "147", "136", "156"]', 0, '99 + 47 = 100 + 47 - 1 = 147 - 1 = 146.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_3_basico' and lo.short_name = 'Cálculo mental'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Resuelve: x + 7 = 15', '["8", "7", "22", "9"]', 0, 'x = 15 - 7 = 8.', 'inicial', 25),
  ('Resuelve: x - 9 = 14', '["23", "5", "22", "24"]', 0, 'x = 14 + 9 = 23.', 'intermedia', 35),
  ('Resuelve: 5 x n = 35', '["7", "6", "8", "30"]', 0, 'n = 35 ÷ 5 = 7.', 'intermedia', 35),
  ('Resuelve: n ÷ 4 = 9', '["36", "13", "5", "40"]', 0, 'n = 9 x 4 = 36.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_3_basico' and lo.short_name = 'Ecuaciones simples de un paso'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En la secuencia 4, 8, 12, 16, ¿qué operación genera el patrón?', '["Sumar 4 cada vez", "Restar 4 cada vez", "Dividir por 4", "Multiplicar por 2"]', 0, 'Cada término aumenta en 4 respecto al anterior.', 'inicial', 25),
  ('En la secuencia 100, 90, 80, 70, ¿qué operación genera el patrón?', '["Restar 10 cada vez", "Sumar 10 cada vez", "Dividir por 10", "Multiplicar por 10"]', 0, 'Cada término disminuye en 10 respecto al anterior.', 'intermedia', 35),
  ('En la secuencia 2, 4, 8, 16, ¿qué operación genera el patrón?', '["Multiplicar por 2 cada vez", "Sumar 2 cada vez", "Restar 2 cada vez", "Dividir por 2 cada vez"]', 0, 'Cada término es el doble del anterior (2, 4, 8, 16).', 'intermedia', 35),
  ('Una secuencia sigue la regla "dividir por 2": 80, 40, 20, ___. ¿Qué número sigue?', '["10", "30", "5", "15"]', 0, '20 ÷ 2 = 10.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_3_basico' and lo.short_name = 'Patrones con las cuatro operaciones'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la regla de la secuencia 3, 6, 9, 12?', '["Sumar 3 cada vez", "Sumar 4 cada vez", "Multiplicar por 3", "Restar 3 cada vez"]', 0, 'Cada término aumenta en 3 respecto al anterior.', 'inicial', 25),
  ('Si la regla es "multiplicar por 3" y la secuencia comienza en 2, ¿cuáles son los primeros 3 términos?', '["2, 6, 18", "2, 5, 8", "2, 6, 9", "3, 6, 9"]', 0, '2, 2x3=6, 6x3=18.', 'intermedia', 35),
  ('En la secuencia 50, 45, 40, 35, ¿cuál es la regla?', '["Restar 5 cada vez", "Sumar 5 cada vez", "Restar 10 cada vez", "Dividir por 5"]', 0, 'Cada término disminuye en 5 respecto al anterior.', 'intermedia', 35),
  ('Una secuencia sigue la regla "sumar 7" y comienza en 4. ¿Cuál es el sexto término (contando el 4 como el primero)?', '["39", "32", "36", "46"]', 0, '4, 11, 18, 25, 32, 39: el sexto término es 39.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_3_basico' and lo.short_name = 'Reglas de formación de patrones'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si 6 x 7 = 42, ¿cuál de estas divisiones es correcta?', '["42 ÷ 6 = 7", "42 ÷ 6 = 8", "42 ÷ 7 = 5", "42 ÷ 6 = 6"]', 0, 'Como 6 x 7 = 42, entonces 42 ÷ 6 = 7.', 'inicial', 25),
  ('Sabiendo que 8 x 5 = 40, ¿cuánto es 40 ÷ 8?', '["5", "8", "40", "4"]', 0, '40 ÷ 8 = 5, la operación inversa de 8 x 5 = 40.', 'intermedia', 35),
  ('Si 9 x 4 = 36, ¿cuál de estas afirmaciones es verdadera?', '["36 ÷ 9 = 4 y 36 ÷ 4 = 9", "36 ÷ 9 = 5", "36 ÷ 4 = 8", "36 ÷ 9 = 3"]', 0, 'La multiplicación y la división son operaciones inversas: 36 ÷ 9 = 4 y 36 ÷ 4 = 9.', 'intermedia', 35),
  ('Un número dividido en 7 grupos iguales da 8 en cada grupo. ¿Cuál es ese número, y qué multiplicación lo confirma?', '["56, porque 7 x 8 = 56", "48, porque 6 x 8 = 48", "64, porque 8 x 8 = 64", "63, porque 7 x 9 = 63"]', 0, 'Si al dividir en 7 grupos iguales resultan 8 en cada uno, el número original es 7 x 8 = 56.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_3_basico' and lo.short_name = 'Relación entre multiplicación y división'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOMETRÍA — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuántas caras tiene un prisma rectangular?', '["6", "4", "8", "5"]', 0, 'Un prisma rectangular tiene 6 caras (2 bases y 4 caras laterales).', 'inicial', 25),
  ('¿Cuántos vértices tiene una pirámide de base cuadrada?', '["5", "4", "6", "8"]', 0, 'Tiene 4 vértices en la base más 1 vértice superior (el ápice): 5 en total.', 'intermedia', 35),
  ('¿Qué diferencia principal hay entre un prisma y una pirámide?', '["El prisma tiene dos bases paralelas iguales; la pirámide tiene una sola base y caras triangulares que se unen en un vértice", "El prisma no tiene caras", "La pirámide siempre tiene forma redonda", "No hay diferencia entre ambos"]', 0, 'Un prisma tiene dos bases paralelas e iguales; una pirámide tiene una sola base y caras triangulares que convergen en un vértice.', 'intermedia', 35),
  ('Un cuerpo geométrico tiene 5 caras: 2 triangulares y 3 rectangulares. ¿Qué cuerpo es?', '["Un prisma triangular", "Una pirámide de base cuadrada", "Un cubo", "Un prisma rectangular"]', 0, 'Un prisma triangular tiene 2 bases triangulares y 3 caras rectangulares laterales, sumando 5 caras.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_3_basico' and lo.short_name = 'Prismas y pirámides'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al trasladar una figura sobre una cuadrícula, ¿qué característica de la figura se mantiene?', '["Su forma y tamaño", "Su posición exacta", "Su color siempre cambia", "Su número de lados cambia"]', 0, 'Una traslación mueve la figura sin cambiar su forma ni su tamaño.', 'inicial', 25),
  ('Si un cuadrado se traslada 3 cuadros hacia la derecha, ¿qué ocurre con su tamaño?', '["No cambia, sigue siendo el mismo cuadrado", "Se duplica", "Se reduce a la mitad", "Se convierte en un rectángulo"]', 0, 'La traslación solo cambia la posición, no el tamaño ni la forma de la figura.', 'intermedia', 35),
  ('Una figura se traslada 5 cuadros hacia abajo y luego 2 cuadros hacia arriba. ¿Cuál es el desplazamiento neto vertical?', '["3 cuadros hacia abajo", "3 cuadros hacia arriba", "7 cuadros hacia abajo", "2 cuadros hacia abajo"]', 0, '5 cuadros hacia abajo menos 2 hacia arriba dejan un desplazamiento neto de 3 cuadros hacia abajo.', 'intermedia', 35),
  ('Una figura se traslada 4 cuadros a la derecha y 3 hacia abajo, y luego 2 cuadros a la izquierda y 1 hacia arriba. ¿Cuál es el desplazamiento neto?', '["2 cuadros a la derecha y 2 hacia abajo", "4 cuadros a la derecha y 3 hacia abajo", "2 cuadros a la izquierda y 2 hacia arriba", "6 cuadros a la derecha y 4 hacia abajo"]', 0, 'Horizontalmente: 4 - 2 = 2 a la derecha. Verticalmente: 3 - 1 = 2 hacia abajo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_3_basico' and lo.short_name = 'Traslaciones de figuras 2D'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En el primer cuadrante de un plano cartesiano, ¿qué signo tienen las coordenadas x e y?', '["Ambas son positivas", "Ambas son negativas", "x positiva, y negativa", "x negativa, y positiva"]', 0, 'En el primer cuadrante, tanto x como y son valores positivos.', 'inicial', 25),
  ('¿Cuál es la ubicación del punto (3, 2) en el primer cuadrante?', '["3 unidades a la derecha del origen y 2 unidades hacia arriba", "2 unidades a la derecha y 3 hacia arriba", "3 unidades hacia abajo y 2 a la izquierda", "2 unidades a la izquierda y 3 hacia abajo"]', 0, 'La primera coordenada (3) indica el desplazamiento horizontal y la segunda (2) el vertical.', 'intermedia', 35),
  ('Si un punto está en (0, 5), ¿en qué eje se ubica?', '["Sobre el eje y (vertical)", "Sobre el eje x (horizontal)", "Fuera del plano cartesiano", "En el origen"]', 0, 'Cuando la coordenada x es 0, el punto se ubica sobre el eje y.', 'intermedia', 35),
  ('Un punto se ubica 4 unidades a la derecha y 6 hacia arriba del origen. ¿Cuáles son sus coordenadas en el primer cuadrante?', '["(4, 6)", "(6, 4)", "(4, 0)", "(0, 6)"]', 0, 'La coordenada x corresponde al desplazamiento horizontal (4) y la y al vertical (6).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_3_basico' and lo.short_name = 'Plano cartesiano — primer cuadrante'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos objetos tiene comúnmente ángulos rectos en sus esquinas?', '["Una hoja de cuaderno rectangular", "Una pelota", "Un plato redondo", "Una rueda de bicicleta"]', 0, 'Una hoja rectangular tiene 4 esquinas con ángulos rectos (90°).', 'inicial', 25),
  ('Usando una escuadra, ¿cómo se comprueba si un ángulo es recto?', '["Verificando que coincida exactamente con la esquina de la escuadra (90°)", "Midiendo la longitud de sus lados", "Contando el número de lados de la figura", "Comparando su color"]', 0, 'La escuadra tiene un ángulo de 90°; si coincide exactamente con el ángulo medido, este es recto.', 'intermedia', 35),
  ('¿Cuántos ángulos rectos tiene un rectángulo?', '["4", "2", "3", "0"]', 0, 'Un rectángulo tiene 4 ángulos rectos, uno en cada esquina.', 'intermedia', 35),
  ('Un triángulo tiene un ángulo recto y dos ángulos agudos. ¿Cómo se llama ese tipo de triángulo?', '["Triángulo rectángulo", "Triángulo equilátero", "Triángulo obtusángulo", "Triángulo isósceles"]', 0, 'Un triángulo con un ángulo de 90° se llama triángulo rectángulo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_3_basico' and lo.short_name = 'Ángulos rectos en el entorno'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué ocurre con una figura al reflejarla respecto a una línea de simetría?', '["Se obtiene una imagen espejo, del mismo tamaño y forma", "Se reduce a la mitad de tamaño", "Cambia de forma completamente", "Se convierte en un cuerpo 3D"]', 0, 'La reflexión produce una imagen espejo de la figura original, conservando su tamaño y forma.', 'inicial', 25),
  ('¿Cuántos ejes de simetría tiene un triángulo equilátero?', '["3", "1", "2", "0"]', 0, 'Un triángulo equilátero tiene 3 ejes de simetría, uno desde cada vértice al punto medio del lado opuesto.', 'intermedia', 35),
  ('¿Cuál de estas figuras NO tiene ningún eje de simetría?', '["Un triángulo escaleno (con todos sus lados distintos)", "Un cuadrado", "Un círculo", "Un rectángulo"]', 0, 'Un triángulo escaleno, al tener todos sus lados y ángulos distintos, no tiene ningún eje de simetría.', 'intermedia', 35),
  ('Al reflejar la letra "M" respecto a una línea vertical que pasa por su centro, ¿qué ocurre con la imagen resultante?', '["La imagen reflejada se ve igual a la M original", "La imagen reflejada se ve como una W", "La imagen desaparece", "La imagen se invierte de arriba hacia abajo"]', 0, 'La letra M tiene un eje de simetría vertical, por lo que su reflejo respecto a ese eje se ve igual a la M original.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_3_basico' and lo.short_name = 'Simetría de reflexión'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: MEDICIÓN — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es el perímetro de un cuadrado de lado 5 cm?', '["20 cm", "25 cm", "10 cm", "15 cm"]', 0, 'El perímetro del cuadrado es 4 x 5 cm = 20 cm.', 'inicial', 25),
  ('Un rectángulo mide 8 cm de largo y 3 cm de ancho. ¿Cuál es su perímetro?', '["22 cm", "24 cm", "11 cm", "33 cm"]', 0, 'Perímetro = 2 x (8 + 3) = 2 x 11 = 22 cm.', 'intermedia', 35),
  ('Un triángulo tiene lados de 4 cm, 5 cm y 6 cm. ¿Cuál es su perímetro?', '["15 cm", "20 cm", "10 cm", "9 cm"]', 0, 'Perímetro = 4 + 5 + 6 = 15 cm.', 'intermedia', 35),
  ('Un terreno rectangular mide 12 m de largo y 7 m de ancho. Si se coloca una cerca alrededor de todo el terreno, ¿cuántos metros de cerca se necesitan?', '["38 m", "19 m", "84 m", "42 m"]', 0, 'Perímetro = 2 x (12 + 7) = 2 x 19 = 38 m.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_3_basico' and lo.short_name = 'Perímetro de figuras 2D'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si una actividad comienza a las 3:00 y termina a las 3:45, ¿cuánto tiempo duró?', '["45 minutos", "35 minutos", "1 hora", "15 minutos"]', 0, 'De las 3:00 a las 3:45 pasan 45 minutos.', 'inicial', 25),
  ('Una clase dura 90 minutos. ¿Cuántas horas y minutos son?', '["1 hora y 30 minutos", "1 hora y 90 minutos", "9 horas", "30 minutos"]', 0, '90 minutos = 60 minutos (1 hora) + 30 minutos.', 'intermedia', 35),
  ('Un viaje comienza a las 10:15 y dura 1 hora y 20 minutos. ¿A qué hora termina?', '["11:35", "11:15", "10:35", "12:35"]', 0, '10:15 + 1:20 = 11:35.', 'intermedia', 35),
  ('Si son las 8:50 y una reunión dura 25 minutos, ¿a qué hora termina la reunión?', '["9:15", "9:05", "8:75", "9:25"]', 0, '8:50 + 10 minutos son las 9:00, y quedan 15 minutos más: 9:15.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_3_basico' and lo.short_name = 'Paso del tiempo'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se puede estimar el volumen de una caja usando cubos pequeños?', '["Contando cuántos cubos se necesitan para llenarla completamente", "Midiendo solo su altura", "Pesándola en una balanza", "Contando sus caras"]', 0, 'El volumen se estima contando cuántos cubos unitarios caben completamente dentro de la caja.', 'inicial', 25),
  ('Si una caja pequeña se llena con 12 cubos unitarios y otra caja más grande se llena con 30, ¿cuál caja tiene mayor volumen?', '["La caja que se llenó con 30 cubos", "La caja que se llenó con 12 cubos", "Ambas tienen el mismo volumen", "No se puede comparar con cubos"]', 0, 'A mayor cantidad de cubos necesarios para llenarla, mayor es el volumen de la caja.', 'intermedia', 35),
  ('Si una caja tiene capacidad para 2 capas de 10 cubos cada una, ¿cuántos cubos caben en total?', '["20", "10", "12", "30"]', 0, '2 x 10 = 20 cubos en total.', 'intermedia', 35),
  ('Una caja tiene 3 capas, y cada capa tiene un arreglo de 4 filas por 5 columnas de cubos. ¿Cuántos cubos caben en total en la caja?', '["60", "20", "15", "45"]', 0, 'Cada capa tiene 4 x 5 = 20 cubos; en 3 capas hay 20 x 3 = 60 cubos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_3_basico' and lo.short_name = 'Estimación de volumen con unidades no estandarizadas'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si un mes tiene 30 días y hoy es el día 15, ¿cuántos días quedan para que termine el mes?', '["15 días", "14 días", "16 días", "30 días"]', 0, '30 - 15 = 15 días.', 'inicial', 25),
  ('Si un evento ocurre el 10 de marzo y dura 2 semanas, ¿en qué fecha aproximada termina?', '["24 de marzo", "17 de marzo", "10 de abril", "20 de marzo"]', 0, '2 semanas son 14 días; 10 + 14 = 24 de marzo.', 'intermedia', 35),
  ('¿Cuántos meses del año tienen exactamente 31 días?', '["7", "6", "12", "4"]', 0, 'Enero, marzo, mayo, julio, agosto, octubre y diciembre: 7 meses tienen 31 días.', 'intermedia', 35),
  ('Si hoy es martes 5 de un mes, ¿qué día de la semana será el 12 del mismo mes?', '["Martes", "Miércoles", "Lunes", "Jueves"]', 0, 'Del 5 al 12 hay exactamente 7 días, una semana completa; por eso cae el mismo día de la semana: martes.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_3_basico' and lo.short_name = 'Lectura de calendarios'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: DATOS Y PROBABILIDADES — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En un gráfico de barras simple, ¿cuántas barras hay por cada categoría?', '["1", "2", "3", "0"]', 0, 'En un gráfico de barras simple, cada categoría tiene una sola barra.', 'inicial', 25),
  ('En un gráfico de barras doble que compara "niños" y "niñas" en dos cursos, ¿cuántas barras hay por cada curso?', '["2", "1", "4", "3"]', 0, 'Un gráfico doble muestra 2 barras por curso: una para niños y otra para niñas.', 'intermedia', 35),
  ('Un gráfico de barras doble muestra que en el curso A hay 12 niños y 10 niñas, y en el curso B hay 9 niños y 14 niñas. ¿Qué curso tiene más niñas?', '["El curso B", "El curso A", "Ambos tienen las mismas niñas", "No se puede comparar"]', 0, 'El curso B tiene 14 niñas, más que las 10 niñas del curso A.', 'intermedia', 35),
  ('Con los mismos datos (curso A: 12 niños y 10 niñas; curso B: 9 niños y 14 niñas), ¿qué curso tiene más estudiantes en total?', '["El curso B, con 23 estudiantes", "El curso A, con 22 estudiantes", "Ambos cursos tienen 22 estudiantes", "No se puede calcular el total"]', 0, 'Curso A: 12+10=22; curso B: 9+14=23. El curso B tiene más estudiantes en total.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_3_basico' and lo.short_name = 'Gráficos de barra simple y doble'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al lanzar una moneda 10 veces y anotar cada resultado, ¿qué se está haciendo?', '["Registrando los resultados de un experimento aleatorio", "Prediciendo el futuro con certeza", "Calculando un promedio directamente", "Midiendo una longitud"]', 0, 'Anotar los resultados de lanzamientos repetidos es registrar un experimento aleatorio.', 'inicial', 25),
  ('Si lanzas un dado 20 veces y registras que salió el número 4 en 5 ocasiones, ¿qué representa ese registro?', '["La frecuencia con la que salió el número 4 en el experimento", "La probabilidad exacta de sacar un 4 en cualquier lanzamiento", "El número total de lanzamientos", "El resultado del próximo lanzamiento"]', 0, 'El conteo de 5 veces es la frecuencia observada del número 4 en ese experimento particular.', 'intermedia', 35),
  ('Al repetir 10 veces el experimento de lanzar una moneda, se registran 6 caras y 4 sellos. ¿Cuál salió con más frecuencia?', '["Cara", "Sello", "Ambos con la misma frecuencia", "No se puede determinar"]', 0, '6 es mayor que 4, por lo que cara salió con más frecuencia en este registro.', 'intermedia', 35),
  ('En un experimento aleatorio se registran los siguientes resultados al lanzar un dado 30 veces: número par (18 veces), número impar (12 veces). ¿Qué se puede concluir de este registro?', '["En este experimento, salió más veces un número par que uno impar", "Salieron la misma cantidad de veces", "Es imposible que salga un número impar", "El dado tiene solo números pares"]', 0, '18 es mayor que 12, por lo que en este registro salió más veces un número par.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_3_basico' and lo.short_name = 'Registro de experimentos aleatorios'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Para calcular el promedio de 4, 6 y 8, ¿qué se debe hacer?', '["Sumar los tres números y dividir por 3", "Sumar los tres números y dividir por 2", "Multiplicar los tres números", "Restar el menor del mayor"]', 0, 'El promedio se calcula sumando todos los valores y dividiendo por la cantidad de datos, en este caso 3.', 'inicial', 25),
  ('¿Cuál es el promedio de 10, 20 y 30?', '["20", "30", "15", "60"]', 0, '(10 + 20 + 30) ÷ 3 = 60 ÷ 3 = 20.', 'intermedia', 35),
  ('¿Cuál es el promedio de 5, 7, 9 y 11?', '["8", "9", "7", "32"]', 0, '(5 + 7 + 9 + 11) ÷ 4 = 32 ÷ 4 = 8.', 'intermedia', 35),
  ('Un estudiante obtuvo las notas 4, 6, 5 y 7 en cuatro pruebas. ¿Cuál es su promedio?', '["5,5", "5", "6", "22"]', 0, '(4 + 6 + 5 + 7) ÷ 4 = 22 ÷ 4 = 5,5.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_3_basico' and lo.short_name = 'Promedio de un conjunto de datos'
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
  'Pregunta ValidApp (borrador), Matemática 3° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas preguntas es una buena pregunta estadística, porque admite distintas respuestas en un grupo?', '["¿Cuántos hermanos tiene cada estudiante del curso?", "¿Cuánto es 2 + 2?", "¿Cómo se llama el director del colegio?", "¿En qué país vivimos?"]', 0, 'Una pregunta estadística útil es aquella cuya respuesta puede variar entre las personas del grupo, como la cantidad de hermanos.', 'inicial', 25),
  ('Para investigar el medio de transporte que más usan los estudiantes para llegar al colegio, ¿qué se debe hacer primero?', '["Formular la pregunta y luego recolectar los datos de cada estudiante", "Inventar los resultados sin preguntar", "Solo preguntar a un estudiante", "Calcular un promedio sin datos"]', 0, 'Un estudio estadístico comienza formulando la pregunta y luego recolectando los datos de todo el grupo.', 'intermedia', 35),
  ('¿Cuál de estas preguntas NO es adecuada para un estudio estadístico de un curso?', '["¿Cuál es tu nombre?", "¿Cuántas mascotas tienes?", "¿Cuál es tu color favorito?", "¿Cuántos años tienes?"]', 0, 'El nombre es un dato único e identificador que no se puede resumir ni comparar estadísticamente entre el grupo, a diferencia de la cantidad de mascotas, el color favorito o la edad.', 'intermedia', 35),
  ('Un estudiante quiere comparar cuántos libros leyó cada compañero durante las vacaciones. ¿Cuál pregunta estadística es más adecuada para recolectar ese dato?', '["¿Cuántos libros leíste durante las vacaciones?", "¿Te gusta leer?", "¿Cuál es tu libro favorito?", "¿Dónde compraste tu último libro?"]', 0, 'Preguntar directamente la cantidad de libros leídos permite recolectar el dato numérico necesario para la comparación.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_3_basico' and lo.short_name = 'Formulación de preguntas estadísticas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
