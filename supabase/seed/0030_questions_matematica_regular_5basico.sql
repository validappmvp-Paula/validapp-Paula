-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Matemática,
-- 5° Básico. Mismo patrón, alcance, estado editorial e idempotencia que
-- supabase/seed/0026_questions_matematica_regular_1basico.sql (ver ese
-- archivo para el detalle completo de las decisiones de diseño).

-- ============================================================================
-- EJE: NÚMEROS — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se escribe 250.000 en palabras?', '["doscientos cincuenta mil", "veinticinco mil", "doscientos cincuenta", "dos millones quinientos mil"]', 0, '250.000 se escribe "doscientos cincuenta mil".', 'inicial', 25),
  ('Ordena de mayor a menor: 480.000, 84.000, 800.400.', '["800.400, 480.000, 84.000", "84.000, 480.000, 800.400", "480.000, 800.400, 84.000", "800.400, 84.000, 480.000"]', 0, '800.400 > 480.000 > 84.000.', 'intermedia', 35),
  ('¿Qué número está formado por 7 centenas de mil y 3 unidades de mil?', '["703.000", "730.000", "70.300", "7.300.000"]', 0, '7 centenas de mil = 700.000; sumadas a 3 unidades de mil (3.000) da 703.000.', 'intermedia', 35),
  ('Un número tiene 5 centenas de mil y es mayor que 520.000 pero menor que 530.000. ¿Cuál puede ser ese número?', '["525.000", "510.000", "535.000", "500.500"]', 0, '525.000 tiene 5 centenas de mil y está entre 520.000 y 530.000.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_5_basico' and lo.short_name = 'Números hasta 1.000.000'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('2/5 + 1/5 = ?', '["3/5", "3/10", "1/5", "2/10"]', 0, 'Con igual denominador: 2 + 1 = 3, quedando 3/5.', 'inicial', 25),
  ('3/4 - 1/4 = ?', '["1/2 (2/4)", "1/4", "3/8", "1/8"]', 0, '3 - 1 = 2, quedando 2/4, que se simplifica a 1/2.', 'intermedia', 35),
  ('1/2 + 1/3 = ?', '["5/6", "2/5", "1/6", "2/6"]', 0, 'Usando denominador común 6: 3/6 + 2/6 = 5/6.', 'intermedia', 35),
  ('El número mixto 2 1/4 se convierte en fracción impropia. ¿Cuál es esa fracción?', '["9/4", "8/4", "2/4", "6/4"]', 0, '2 enteros equivalen a 8/4; sumando 1/4 da 9/4.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_5_basico' and lo.short_name = 'Operatoria con fracciones'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se lee el número decimal 0,25?', '["Veinticinco centésimos", "Veinticinco décimos", "Dos coma cinco", "Veinticinco unidades"]', 0, '0,25 se lee "veinticinco centésimos".', 'inicial', 25),
  ('¿Cuál de estos decimales es mayor: 0,45 o 0,5?', '["0,5", "0,45", "Son iguales", "No se pueden comparar"]', 0, '0,5 equivale a 0,50, que es mayor que 0,45.', 'intermedia', 35),
  ('¿Qué fracción representa el decimal 0,75?', '["75/100 (3/4)", "7,5/100", "75/10", "3/100"]', 0, '0,75 equivale a 75/100, que se simplifica a 3/4.', 'intermedia', 35),
  ('Ordena de menor a mayor: 0,6; 0,06; 0,66.', '["0,06; 0,6; 0,66", "0,6; 0,06; 0,66", "0,66; 0,6; 0,06", "0,06; 0,66; 0,6"]', 0, '0,06 < 0,6 < 0,66.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_5_basico' and lo.short_name = 'Decimales hasta la centésima'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos números es múltiplo de 4?', '["16", "18", "22", "15"]', 0, '16 = 4 x 4, por lo que es múltiplo de 4.', 'inicial', 25),
  ('¿Cuáles son todos los divisores de 12?', '["1, 2, 3, 4, 6, 12", "1, 2, 4, 12", "1, 3, 6, 12", "2, 3, 4, 6"]', 0, 'Los divisores de 12 son 1, 2, 3, 4, 6 y 12.', 'intermedia', 35),
  ('¿Cuál es el menor múltiplo común de 3 y 4, distinto de 0?', '["12", "7", "24", "6"]', 0, 'Los múltiplos de 3 y de 4 coinciden por primera vez (sin contar el 0) en 12.', 'intermedia', 35),
  ('¿Cuál de estos números NO es divisor de 30?', '["8", "5", "6", "10"]', 0, '30 no es divisible exactamente por 8; en cambio 5, 6 y 10 sí dividen exactamente a 30.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_5_basico' and lo.short_name = 'Múltiplos y divisores'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('3,5 x 2 = ?', '["7", "6,5", "7,5", "3,7"]', 0, '3,5 x 2 = 7.', 'inicial', 25),
  ('8,4 ÷ 2 = ?', '["4,2", "4,4", "2,4", "4,8"]', 0, '8,4 ÷ 2 = 4,2.', 'intermedia', 35),
  ('1,2 x 4 = ?', '["4,8", "4,2", "1,8", "5,2"]', 0, '1,2 x 4 = 4,8.', 'intermedia', 35),
  ('6,3 ÷ 3 = ?', '["2,1", "2,3", "3,1", "1,2"]', 0, '6,3 ÷ 3 = 2,1.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_5_basico' and lo.short_name = 'Multiplicación y división de decimales'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿A qué porcentaje equivale la fracción 1/2?', '["50%", "25%", "75%", "100%"]', 0, '1/2 equivale a 50%.', 'inicial', 25),
  ('¿A qué decimal equivale 1/4?', '["0,25", "0,4", "0,14", "0,75"]', 0, '1/4 equivale a 0,25.', 'intermedia', 35),
  ('¿A qué porcentaje equivale el decimal 0,75?', '["75%", "25%", "50%", "7,5%"]', 0, '0,75 equivale a 75%.', 'intermedia', 35),
  ('Si 1/2 = 0,5 = 50%, ¿cuál es la relación equivalente para 3/4?', '["3/4 = 0,75 = 75%", "3/4 = 0,34 = 34%", "3/4 = 0,43 = 43%", "3/4 = 4,3 = 430%"]', 0, '3/4 equivale a 0,75, que a su vez equivale a 75%.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_5_basico' and lo.short_name = 'Relación entre fracciones, decimales y porcentajes'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: PATRONES Y ÁLGEBRA — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Calcula: 2 + 3 x 4', '["14", "20", "24", "9"]', 0, 'Primero se multiplica: 3 x 4 = 12; luego se suma: 2 + 12 = 14.', 'inicial', 25),
  ('Si primero resuelves el paréntesis, ¿cuál es el resultado de (2 + 3) x 4?', '["20", "14", "9", "24"]', 0, 'El paréntesis se resuelve primero: 2 + 3 = 5; luego 5 x 4 = 20.', 'intermedia', 35),
  ('Calcula: 10 - 2 x 3', '["4", "24", "8", "6"]', 0, 'Primero se multiplica: 2 x 3 = 6; luego se resta: 10 - 6 = 4.', 'intermedia', 35),
  ('Calcula: 5 x (6 - 2) + 3', '["23", "35", "17", "32"]', 0, 'Paréntesis primero: 6-2=4; luego 5x4=20; finalmente 20+3=23.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_5_basico' and lo.short_name = 'Prioridad de operaciones'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se representa "un número aumentado en 5" usando lenguaje algebraico?', '["n + 5", "5n", "n - 5", "5/n"]', 0, '"Aumentado en 5" significa sumar 5 al número: n + 5.', 'inicial', 25),
  ('¿Cómo se representa "el doble de un número" en lenguaje algebraico?', '["2n", "n + 2", "n/2", "n²"]', 0, '"El doble" significa multiplicar por 2: 2n.', 'intermedia', 35),
  ('¿Qué representa la expresión algebraica "3n - 2"?', '["El triple de un número, menos 2", "El triple de un número, más 2", "Un número dividido en 3, menos 2", "La mitad de un número, menos 2"]', 0, '3n es el triple de n, y luego se resta 2.', 'intermedia', 35),
  ('Si n representa la edad de Ana, ¿cuál expresión algebraica representa "el doble de la edad de Ana, más 3 años"?', '["2n + 3", "n + 3", "2n - 3", "3n + 2"]', 0, 'El doble de n es 2n, y luego se suman 3: 2n + 3.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_5_basico' and lo.short_name = 'Lenguaje algebraico simple'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Resuelve: n + 12 = 20', '["8", "32", "12", "20"]', 0, 'n = 20 - 12 = 8.', 'inicial', 25),
  ('Resuelve la inecuación: n + 5 > 10. ¿Cuál de estos valores cumple la inecuación?', '["6", "5", "4", "3"]', 0, 'Si n + 5 > 10, entonces n > 5; el único valor mayor que 5 entre las opciones es 6.', 'intermedia', 35),
  ('Resuelve: 4n = 28', '["7", "24", "32", "112"]', 0, 'n = 28 ÷ 4 = 7.', 'intermedia', 35),
  ('Resuelve la inecuación: 2n - 3 < 9. ¿Cuál de estos valores cumple la inecuación?', '["5", "6", "7", "8"]', 0, 'Si 2n - 3 < 9, entonces 2n < 12 y n < 6; el único valor menor que 6 entre las opciones es 5.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_5_basico' and lo.short_name = 'Ecuaciones e inecuaciones de un paso'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En la secuencia 0,5; 1,0; 1,5; 2,0; ___, ¿qué número sigue?', '["2,5", "3,0", "2,0", "1,5"]', 0, 'Cada término aumenta en 0,5; después de 2,0 sigue 2,5.', 'inicial', 25),
  ('En la secuencia 1/4, 2/4, 3/4, ___, ¿qué fracción sigue?', '["4/4 (1 entero)", "5/4", "2/4", "3/4"]', 0, 'Cada término aumenta un cuarto; después de 3/4 sigue 4/4, que equivale a 1 entero.', 'intermedia', 35),
  ('En la secuencia 0,2; 0,4; 0,6; ___, ¿qué número sigue?', '["0,8", "1,0", "0,6", "0,7"]', 0, 'Cada término aumenta en 0,2; después de 0,6 sigue 0,8.', 'intermedia', 35),
  ('En la secuencia 1/8, 2/8, 4/8, ___, cada término se relaciona con el anterior multiplicando por 2. ¿Qué fracción sigue?', '["8/8 (1 entero)", "6/8", "5/8", "16/8"]', 0, '4/8 x 2 = 8/8, que equivale a 1 entero.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_5_basico' and lo.short_name = 'Secuencias con números decimales y fracciones'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una tabla, por cada 1 kilogramo de manzanas se pagan $1.000. ¿Cuánto se paga por 3 kilogramos?', '["$3.000", "$1.000", "$2.000", "$4.000"]', 0, '1.000 x 3 = 3.000.', 'inicial', 25),
  ('En un gráfico que relaciona horas trabajadas y dinero ganado, si por 2 horas se ganan $6.000, ¿cuánto se gana por hora?', '["$3.000", "$6.000", "$2.000", "$12.000"]', 0, '6.000 ÷ 2 = 3.000 por hora.', 'intermedia', 35),
  ('Si la relación entre x e y es "y = 4x" y se representa en una tabla, ¿cuál es el valor de y cuando x = 5?', '["20", "9", "1,25", "45"]', 0, 'y = 4 x 5 = 20.', 'intermedia', 35),
  ('Un gráfico muestra que por cada 2 litros de bencina se recorren 20 km. Si un auto recorre 60 km, ¿cuántos litros de bencina utilizó, manteniendo la misma relación?', '["6 litros", "3 litros", "10 litros", "30 litros"]', 0, '60 km es el triple de 20 km, por lo que se usan 2 x 3 = 6 litros.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_5_basico' and lo.short_name = 'Representación gráfica de relaciones simples'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOMETRÍA — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Para construir un triángulo, ¿qué instrumentos son más adecuados?', '["Regla y transportador", "Solo una balanza", "Solo un reloj", "Solo un calendario"]', 0, 'La regla permite medir los lados y el transportador los ángulos, ambos necesarios para construir un triángulo con precisión.', 'inicial', 25),
  ('¿Es posible construir un triángulo con lados de 2 cm, 2 cm y 10 cm?', '["No, porque la suma de los dos lados menores (4 cm) es menor que el lado mayor (10 cm)", "Sí, siempre es posible con cualquier medida", "No, porque los triángulos no pueden tener lados desiguales", "Sí, porque la suma de todos los lados es 14 cm"]', 0, 'Para formar un triángulo, la suma de dos lados cualesquiera debe ser mayor que el tercero; aquí 2+2=4 es menor que 10.', 'intermedia', 35),
  ('Si conoces la medida de los 3 lados de un triángulo, ¿qué se puede afirmar sobre la construcción de ese triángulo?', '["Existe un único triángulo posible con esas medidas (si cumplen la desigualdad triangular)", "Existen infinitos triángulos distintos", "No se puede construir ningún triángulo", "Solo se puede construir un triángulo equilátero"]', 0, 'Conociendo los 3 lados (que cumplan la desigualdad triangular), el triángulo queda completamente determinado.', 'intermedia', 35),
  ('¿Cuál de estos conjuntos de medidas SÍ permite construir un triángulo?', '["5 cm, 6 cm, 8 cm", "2 cm, 3 cm, 6 cm", "1 cm, 1 cm, 5 cm", "4 cm, 4 cm, 9 cm"]', 0, 'La suma de dos lados cualesquiera debe superar al tercero: 5+6=11>8 se cumple; en las otras opciones no se cumple esta condición.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_5_basico' and lo.short_name = 'Construcción de triángulos'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es el área de un triángulo con base 8 cm y altura 5 cm?', '["20 cm²", "40 cm²", "13 cm²", "10 cm²"]', 0, 'Área = (base x altura) ÷ 2 = (8 x 5) ÷ 2 = 20 cm².', 'inicial', 25),
  ('¿Cuál es el área de un paralelogramo con base 6 cm y altura 4 cm?', '["24 cm²", "10 cm²", "12 cm²", "20 cm²"]', 0, 'Área = base x altura = 6 x 4 = 24 cm².', 'intermedia', 35),
  ('Un triángulo tiene área de 18 cm² y su base mide 6 cm. ¿Cuál es su altura?', '["6 cm", "3 cm", "12 cm", "9 cm"]', 0, 'De área = (base x altura) ÷ 2, despejando: altura = (18 x 2) ÷ 6 = 6 cm.', 'intermedia', 35),
  ('Un paralelogramo tiene la misma base y altura que un triángulo. Si el área del paralelogramo es 40 cm², ¿cuál es el área del triángulo?', '["20 cm²", "40 cm²", "80 cm²", "10 cm²"]', 0, 'El área de un triángulo es la mitad del área de un paralelogramo con la misma base y altura: 40 ÷ 2 = 20 cm².', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_5_basico' and lo.short_name = 'Área de triángulos y paralelogramos'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se llama la línea donde se unen dos caras de un cuerpo 3D?', '["Arista", "Vértice", "Cara", "Base"]', 0, 'La línea donde se unen dos caras de un cuerpo 3D se llama arista.', 'inicial', 25),
  ('¿Cómo se llama el punto donde se unen 3 o más aristas de un cuerpo 3D?', '["Vértice", "Arista", "Cara", "Diagonal"]', 0, 'El punto donde se unen varias aristas se llama vértice.', 'intermedia', 35),
  ('¿Cuántas aristas tiene un cubo?', '["12", "6", "8", "10"]', 0, 'Un cubo tiene 12 aristas.', 'intermedia', 35),
  ('Un cuerpo 3D tiene 8 vértices, 12 aristas y 6 caras. ¿Qué cuerpo es?', '["Un cubo (o prisma rectangular)", "Una pirámide de base cuadrada", "Un cilindro", "Una esfera"]', 0, 'Un cubo (o prisma rectangular) tiene exactamente 8 vértices, 12 aristas y 6 caras.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_5_basico' and lo.short_name = 'Elementos de figuras 3D'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se llama el punto central de un círculo, equidistante de todos sus puntos?', '["Centro", "Radio", "Diámetro", "Circunferencia"]', 0, 'El punto central, equidistante de todos los puntos del círculo, se llama centro.', 'inicial', 25),
  ('Si el radio de un círculo mide 5 cm, ¿cuánto mide su diámetro?', '["10 cm", "5 cm", "2,5 cm", "15 cm"]', 0, 'El diámetro es el doble del radio: 5 x 2 = 10 cm.', 'intermedia', 35),
  ('¿Cómo se llama la línea curva que forma el borde de un círculo?', '["Circunferencia", "Radio", "Diámetro", "Cuerda"]', 0, 'El borde curvo del círculo se llama circunferencia.', 'intermedia', 35),
  ('Si el diámetro de un círculo mide 18 cm, ¿cuánto mide su radio?', '["9 cm", "18 cm", "36 cm", "4,5 cm"]', 0, 'El radio es la mitad del diámetro: 18 ÷ 2 = 9 cm.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_5_basico' and lo.short_name = 'Círculo y sus elementos'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuántos rectángulos forman la red de un prisma rectangular, sin contar sus bases?', '["4", "6", "2", "8"]', 0, 'Un prisma rectangular tiene 4 caras laterales rectangulares, además de sus 2 bases.', 'inicial', 25),
  ('Al construir la red de un cubo, ¿cuántos cuadrados se necesitan en total?', '["6", "4", "8", "12"]', 0, 'Un cubo tiene 6 caras cuadradas, todas presentes en su red.', 'intermedia', 35),
  ('La red de una pirámide de base triangular está formada solo por triángulos. ¿Cuántos triángulos tiene esa red en total?', '["4", "3", "6", "1"]', 0, 'Una pirámide de base triangular tiene 1 cara triangular de base y 3 caras triangulares laterales: 4 en total.', 'intermedia', 35),
  ('Se arma un cuerpo 3D a partir de una red compuesta por 2 círculos y 1 rectángulo. ¿Qué cuerpo se forma?', '["Un cilindro", "Un cono", "Una esfera", "Un cubo"]', 0, 'Un cilindro tiene 2 bases circulares y una cara lateral que se representa como un rectángulo en su red.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_5_basico' and lo.short_name = 'Redes de cuerpos geométricos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: MEDICIÓN — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si una figura se forma con 12 cubos unitarios, ¿cuál es su volumen?', '["12 unidades cúbicas", "6 unidades cúbicas", "24 unidades cúbicas", "4 unidades cúbicas"]', 0, 'El volumen corresponde a la cantidad de cubos unitarios que forman la figura: 12.', 'inicial', 25),
  ('Un prisma se arma con 3 capas de 8 cubos cada una. ¿Cuál es su volumen total?', '["24 unidades cúbicas", "11 unidades cúbicas", "8 unidades cúbicas", "32 unidades cúbicas"]', 0, '3 x 8 = 24 unidades cúbicas.', 'intermedia', 35),
  ('Un prisma rectangular mide 4 cubos de largo, 3 de ancho y 2 de alto. ¿Cuál es su volumen en cubos unitarios?', '["24", "9", "20", "14"]', 0, '4 x 3 x 2 = 24 cubos unitarios.', 'intermedia', 35),
  ('Un prisma rectangular tiene un volumen de 60 cubos unitarios. Si su largo es 5 cubos y su ancho es 4 cubos, ¿cuál es su altura?', '["3 cubos", "4 cubos", "12 cubos", "20 cubos"]', 0, '60 ÷ (5 x 4) = 60 ÷ 20 = 3 cubos de altura.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_5_basico' and lo.short_name = 'Volumen mediante conteo de cubos'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuántos mililitros tiene 1 litro?', '["1.000", "100", "10", "10.000"]', 0, '1 litro tiene 1.000 mililitros.', 'inicial', 25),
  ('¿Cuántos metros tiene 1 kilómetro?', '["1.000", "100", "10.000", "10"]', 0, '1 kilómetro tiene 1.000 metros.', 'intermedia', 35),
  ('Si un recipiente tiene 2,5 litros, ¿cuántos mililitros son?', '["2.500 ml", "250 ml", "25.000 ml", "2.500 litros"]', 0, '2,5 x 1.000 = 2.500 ml.', 'intermedia', 35),
  ('Un corredor recorre 3,2 km. ¿Cuántos metros recorrió?', '["3.200 m", "320 m", "32.000 m", "3,2 m"]', 0, '3,2 x 1.000 = 3.200 m.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_5_basico' and lo.short_name = 'Conversión de unidades del Sistema Internacional'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Una figura compuesta está formada por un cuadrado de lado 4 cm y un rectángulo de 4 cm x 2 cm unidos por un lado. ¿Cuál es el área total?', '["24 cm²", "20 cm²", "16 cm²", "32 cm²"]', 0, 'Área del cuadrado: 4x4=16; área del rectángulo: 4x2=8; total: 16+8=24 cm².', 'inicial', 25),
  ('Una figura en forma de "L" se forma restando un cuadrado pequeño de 2x2 cm de un cuadrado grande de 6x6 cm. ¿Cuál es el área de la figura en forma de L?', '["32 cm²", "36 cm²", "4 cm²", "28 cm²"]', 0, 'Área grande: 36 cm²; área pequeña: 4 cm²; 36-4=32 cm².', 'intermedia', 35),
  ('Una figura compuesta tiene un perímetro formado por 3 lados de 5 cm y 2 lados de 3 cm. ¿Cuál es su perímetro total?', '["21 cm", "18 cm", "15 cm", "24 cm"]', 0, '3x5 + 2x3 = 15 + 6 = 21 cm.', 'intermedia', 35),
  ('Una figura compuesta está formada por un rectángulo de 10 cm x 4 cm y un triángulo con base 4 cm y altura 3 cm adosado a uno de sus lados. ¿Cuál es el área total de la figura?', '["46 cm²", "40 cm²", "52 cm²", "34 cm²"]', 0, 'Área del rectángulo: 40 cm²; área del triángulo: (4x3)÷2=6 cm²; total: 40+6=46 cm².', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_5_basico' and lo.short_name = 'Perímetro y área de figuras compuestas'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Antes de medir un ángulo con el transportador, ¿qué estimación es razonable para un ángulo que se ve claramente "más abierto que un ángulo recto"?', '["Más de 90°", "Menos de 90°", "Exactamente 90°", "Exactamente 0°"]', 0, 'Un ángulo más abierto que uno recto (90°) debe medir más de 90°.', 'inicial', 25),
  ('Si estimas que un ángulo mide "aproximadamente 45°" y al medirlo con el transportador obtienes 50°, ¿fue razonable tu estimación?', '["Sí, 45° está cerca de 50°", "No, porque no coincide exactamente", "No, porque 45° es un ángulo recto", "Sí, porque siempre se estima igual que se mide"]', 0, 'Una estimación es razonable cuando está cerca del valor real medido; 45° está muy cerca de 50°.', 'intermedia', 35),
  ('Al medir un ángulo con el transportador se obtiene 175°. ¿Cómo se clasifica?', '["Ángulo obtuso, cercano a un ángulo llano (180°)", "Ángulo agudo", "Ángulo recto", "Ángulo nulo"]', 0, '175° es mayor que 90° y menor que 180°, por lo que es un ángulo obtuso, cercano al ángulo llano.', 'intermedia', 35),
  ('Se estima que dos ángulos suman "aproximadamente 180°" (ángulos suplementarios). Al medirlos con el transportador se obtiene 110° y 68°. ¿Es razonable la estimación inicial?', '["Sí, 178° está muy cerca de 180°", "No, porque 178° no es exactamente 180°", "No, porque los ángulos suplementarios no existen", "Sí, porque cualquier suma es razonable"]', 0, '110° + 68° = 178°, que está muy cerca de 180°, por lo que la estimación fue razonable.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_5_basico' and lo.short_name = 'Estimación y medición de ángulos con transportador'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: DATOS Y PROBABILIDADES — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué representa cada sector de un gráfico circular?', '["La proporción de una categoría respecto al total", "El orden alfabético de las categorías", "El color favorito del creador del gráfico", "La cantidad exacta sin relación al total"]', 0, 'Cada sector representa la proporción de esa categoría respecto al total de datos.', 'inicial', 25),
  ('Un gráfico circular muestra que el 50% de los estudiantes prefiere fútbol. ¿Qué representa ese 50% en el gráfico?', '["La mitad del círculo completo", "Un cuarto del círculo", "Todo el círculo", "Un décimo del círculo"]', 0, '50% corresponde exactamente a la mitad del círculo.', 'intermedia', 35),
  ('En un gráfico circular, si una categoría ocupa 25% del círculo, ¿qué fracción del total representa?', '["1/4", "1/2", "3/4", "1/10"]', 0, '25% equivale a la fracción 1/4.', 'intermedia', 35),
  ('Un gráfico circular muestra 3 categorías: A (40%), B (35%), C (25%). ¿Cuál es la diferencia porcentual entre la categoría más grande y la más pequeña?', '["15 puntos porcentuales", "10 puntos porcentuales", "5 puntos porcentuales", "65 puntos porcentuales"]', 0, '40% - 25% = 15 puntos porcentuales de diferencia.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_5_basico' and lo.short_name = 'Gráficos circulares'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la media (promedio) de 4, 6 y 8?', '["6", "18", "4", "8"]', 0, '(4+6+8) ÷ 3 = 18 ÷ 3 = 6.', 'inicial', 25),
  ('¿Cuál es el rango del conjunto de datos 3, 7, 12, 5?', '["9", "12", "3", "27"]', 0, 'Rango = valor máximo - valor mínimo = 12 - 3 = 9.', 'intermedia', 35),
  ('¿Cuál es la moda del conjunto 2, 3, 3, 5, 3, 7?', '["3", "5", "7", "2"]', 0, 'El número 3 se repite 3 veces, más que cualquier otro valor.', 'intermedia', 35),
  ('Un conjunto de datos es 10, 12, 12, 14, 12, 16, 18. Calcula su media, su moda y su rango.', '["Media ≈ 13,4; moda = 12; rango = 8", "Media = 14; moda = 14; rango = 6", "Media ≈ 13,4; moda = 14; rango = 8", "Media = 12; moda = 12; rango = 18"]', 0, 'Suma = 94; 94÷7≈13,4 (media); 12 se repite 3 veces (moda); 18-10=8 (rango).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_5_basico' and lo.short_name = 'Media, moda y rango'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al lanzar una moneda 100 veces, se obtiene 52 caras y 48 sellos. ¿Qué representa esta información?', '["La probabilidad experimental obtenida en ese conjunto de lanzamientos", "La probabilidad teórica exacta de la moneda", "Un resultado imposible de obtener", "El número total de monedas usadas"]', 0, 'Los resultados observados en un experimento repetido corresponden a la probabilidad experimental.', 'inicial', 25),
  ('¿Cuál es la probabilidad teórica de obtener cara al lanzar una moneda equilibrada?', '["1/2", "1/4", "1", "0"]', 0, 'Una moneda equilibrada tiene 2 resultados igualmente posibles; la probabilidad de cada uno es 1/2.', 'intermedia', 35),
  ('Si la probabilidad teórica de sacar un número par en un dado de 6 caras es 1/2, y al lanzarlo 20 veces salió un número par 8 veces, ¿qué se puede afirmar?', '["La probabilidad experimental (8/20) fue distinta de la teórica (1/2), lo cual puede ocurrir por variación al azar", "Es imposible que esto ocurra", "La probabilidad teórica cambió a 8/20", "El dado dejó de ser justo"]', 0, 'La probabilidad experimental puede diferir de la teórica en un número limitado de repeticiones, sin que eso signifique que el dado sea injusto.', 'intermedia', 35),
  ('En un experimento se lanza un dado 60 veces y sale el número 6 en 9 ocasiones. La probabilidad teórica de sacar un 6 es 1/6. ¿Cómo se compara la probabilidad experimental (9/60) con la teórica?', '["Son bastante cercanas, ambas cerca de 0,15-0,17", "Son completamente distintas y no se relacionan", "La experimental siempre debe ser mayor que la teórica", "No se pueden comparar fracciones con decimales"]', 0, '9/60 = 0,15 y 1/6 ≈ 0,167; ambos valores están bastante cerca entre sí.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_5_basico' and lo.short_name = 'Probabilidad experimental y teórica'
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
  'Pregunta ValidApp (borrador), Matemática 5° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('El curso A tiene un promedio de notas de 5,5 y el curso B tiene un promedio de 6,0. ¿Qué curso tiene mejor promedio?', '["El curso B", "El curso A", "Ambos tienen el mismo promedio", "No se puede comparar"]', 0, '6,0 es mayor que 5,5, por lo que el curso B tiene mejor promedio.', 'inicial', 25),
  ('Dos gráficos muestran las ventas semanales de dos tiendas. La tienda 1 tiene un rango de 50 y la tienda 2 tiene un rango de 20. ¿Qué tienda tuvo mayor variación en sus ventas?', '["La tienda 1", "La tienda 2", "Ambas tuvieron la misma variación", "No se puede determinar con el rango"]', 0, 'Un rango mayor indica mayor variación entre los valores máximo y mínimo de los datos.', 'intermedia', 35),
  ('El curso A tiene una moda de 6 en sus notas y el curso B tiene una moda de 5. ¿Qué se puede afirmar?', '["La nota que más se repite en el curso A es mayor que en el curso B", "La nota que más se repite en el curso B es mayor", "Ambos cursos tienen la misma moda", "No se puede comparar la moda entre cursos"]', 0, 'La moda del curso A (6) es mayor que la del curso B (5).', 'intermedia', 35),
  ('El curso A tiene media 5,8 y rango 3; el curso B tiene media 5,8 y rango 1. Aunque tienen la misma media, ¿qué se puede afirmar sobre la dispersión de sus datos?', '["El curso A tiene mayor dispersión (más variación) que el curso B", "El curso B tiene mayor dispersión", "Ambos tienen la misma dispersión", "La media determina la dispersión"]', 0, 'Un rango mayor (3 frente a 1) indica que los datos del curso A están más dispersos, aunque ambos cursos compartan la misma media.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_5_basico' and lo.short_name = 'Comparación de dos conjuntos de datos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
