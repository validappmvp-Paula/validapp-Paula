-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Matemática,
-- 4° Básico. Mismo patrón, alcance, estado editorial e idempotencia que
-- supabase/seed/0026_questions_matematica_regular_1basico.sql (ver ese
-- archivo para el detalle completo de las decisiones de diseño).

-- ============================================================================
-- EJE: NÚMEROS — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se escribe 3.482 en palabras?', '["tres mil cuatrocientos ochenta y dos", "tres mil cuatrocientos ochenta", "cuatro mil trescientos ochenta y dos", "tres mil doscientos ochenta y cuatro"]', 0, '3.482 se escribe "tres mil cuatrocientos ochenta y dos".', 'inicial', 25),
  ('Ordena de menor a mayor: 4.500, 4.050, 5.400.', '["4.050, 4.500, 5.400", "5.400, 4.500, 4.050", "4.500, 4.050, 5.400", "4.050, 5.400, 4.500"]', 0, '4.050 < 4.500 < 5.400.', 'intermedia', 35),
  ('¿Qué número tiene 7 unidades de mil, 2 centenas, 0 decenas y 5 unidades?', '["7.205", "7.025", "7.250", "2.705"]', 0, '7 unidades de mil + 2 centenas + 0 decenas + 5 unidades = 7.205.', 'intermedia', 35),
  ('Un número está entre 6.800 y 6.900, y tiene 9 decenas. ¿Cuál puede ser ese número?', '["6.895", "6.809", "6.950", "6.190"]', 0, '6.895 está entre 6.800 y 6.900 y su dígito de las decenas es 9.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_4_basico' and lo.short_name = 'Números hasta 10.000'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('2.340 + 1.560 = ?', '["3.900", "3.800", "4.000", "3.700"]', 0, '2.340 + 1.560 = 3.900.', 'inicial', 25),
  ('Una fábrica produjo 5.200 piezas y vendió 3.750. ¿Cuántas piezas le quedan?', '["1.450", "1.550", "1.350", "2.450"]', 0, '5.200 - 3.750 = 1.450.', 'intermedia', 35),
  ('4.685 + 2.750 = ?', '["7.435", "7.335", "7.535", "6.435"]', 0, '4.685 + 2.750 = 7.435.', 'intermedia', 35),
  ('En una bodega hay 6.400 sacos de harina. Llegan 2.850 sacos más y luego se despachan 3.900. ¿Cuántos sacos quedan?', '["5.350", "5.450", "5.250", "6.350"]', 0, '6.400 + 2.850 = 9.250; 9.250 - 3.900 = 5.350.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_4_basico' and lo.short_name = 'Adición y sustracción hasta 10.000'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('234 x 3 = ?', '["702", "602", "712", "642"]', 0, '234 x 3 = 702.', 'inicial', 25),
  ('1.248 ÷ 4 = ?', '["312", "302", "322", "412"]', 0, '1.248 ÷ 4 = 312.', 'intermedia', 35),
  ('156 x 4 = ?', '["624", "614", "724", "524"]', 0, '156 x 4 = 624.', 'intermedia', 35),
  ('Se reparten 2.500 hojas en partes iguales entre 5 salas. Si además cada sala recibe 3 cajas de 20 lápices, ¿cuántas hojas y lápices recibe cada sala en total?', '["500 hojas y 60 lápices (560 en total)", "500 hojas y 20 lápices", "250 hojas y 60 lápices", "500 hojas y 3 lápices"]', 0, '2.500 ÷ 5 = 500 hojas por sala; 3 cajas x 20 = 60 lápices por sala; en total 500 + 60 = 560.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_4_basico' and lo.short_name = 'Multiplicación y división con el algoritmo'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas fracciones es equivalente a 1/2?', '["2/4", "1/4", "3/4", "1/3"]', 0, '2/4 se simplifica a 1/2.', 'inicial', 25),
  ('¿Cuál de estas fracciones es equivalente a 2/3?', '["4/6", "3/4", "2/6", "4/3"]', 0, '4/6 se simplifica a 2/3.', 'intermedia', 35),
  ('Si simplificas la fracción 6/8, ¿qué fracción equivalente más simple obtienes?', '["3/4", "2/4", "6/4", "3/8"]', 0, '6/8 se simplifica dividiendo por 2: 3/4.', 'intermedia', 35),
  ('¿Cuál de estas fracciones NO es equivalente a 3/6?', '["2/5", "1/2", "4/8", "5/10"]', 0, '3/6 se simplifica a 1/2; 1/2, 4/8 y 5/10 son equivalentes a 1/2, pero 2/5 no lo es.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_4_basico' and lo.short_name = 'Equivalencia de fracciones'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('1/5 + 2/5 = ?', '["3/5", "3/10", "2/5", "1/5"]', 0, 'Con igual denominador, se suman los numeradores: 1 + 2 = 3, quedando 3/5.', 'inicial', 25),
  ('0,3 + 0,4 = ?', '["0,7", "0,07", "7", "0,34"]', 0, '0,3 + 0,4 = 0,7.', 'intermedia', 35),
  ('3/7 - 1/7 = ?', '["2/7", "2/14", "4/7", "3/7"]', 0, 'Con igual denominador, se restan los numeradores: 3 - 1 = 2, quedando 2/7.', 'intermedia', 35),
  ('0,8 - 0,35 = ?', '["0,45", "0,55", "0,35", "1,15"]', 0, '0,8 - 0,35 = 0,45.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_4_basico' and lo.short_name = 'Adición y sustracción de fracciones y decimales simples'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Números. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Antes de calcular 198 + 302, ¿cuál es una buena estimación redondeando a la centena?', '["Aproximadamente 500", "Aproximadamente 400", "Aproximadamente 600", "Aproximadamente 300"]', 0, '198 se redondea a 200 y 302 a 300; 200 + 300 = 500.', 'inicial', 25),
  ('Se estima que 596 - 205 es "aproximadamente 400" (redondeando a la centena: 600 - 200). ¿Es razonable esta estimación comparada con el resultado exacto 391?', '["Sí, 400 está cerca de 391", "No, 400 está muy lejos de 391", "No, porque la resta no se puede estimar", "Sí, porque siempre da exacto"]', 0, '400 está muy cerca del resultado exacto 391, por lo que la estimación es razonable.', 'intermedia', 35),
  ('¿Cuál es una estimación razonable de 48 x 5, redondeando 48 a 50?', '["Aproximadamente 250", "Aproximadamente 200", "Aproximadamente 300", "Aproximadamente 500"]', 0, '50 x 5 = 250, una estimación razonable de 48 x 5.', 'intermedia', 35),
  ('Al estimar 812 - 398 redondeando a la centena (800 - 400 = 400), el resultado exacto es 414. ¿Qué se puede concluir?', '["La estimación fue razonable, porque está cerca del resultado exacto", "La estimación fue incorrecta porque no coincide exactamente", "El resultado exacto está mal calculado", "Las estimaciones siempre deben coincidir con el resultado exacto"]', 0, '400 está muy cerca de 414, por lo que la estimación es razonable aunque no sea el valor exacto.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Números' and l.code = 'regular_4_basico' and lo.short_name = 'Estimación de resultados'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: PATRONES Y ÁLGEBRA — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una tabla, cuando x = 1, y = 2; cuando x = 2, y = 4; cuando x = 3, y = 6. ¿Cuál es la regla que relaciona x e y?', '["y es el doble de x", "y es la mitad de x", "y es x más 2", "y es x menos 1"]', 0, 'En cada caso, y es exactamente el doble de x (2=2x1, 4=2x2, 6=2x3).', 'inicial', 25),
  ('Usando la regla "y = x + 3", si x = 5, ¿cuál es el valor de y?', '["8", "5", "15", "2"]', 0, 'y = 5 + 3 = 8.', 'intermedia', 35),
  ('En una tabla de valores, x = 2 corresponde a y = 6, y x = 4 corresponde a y = 12. ¿Cuál es la regla?', '["y es el triple de x", "y es el doble de x", "y es x más 4", "y es x menos 2"]', 0, '6 = 3x2 y 12 = 3x4: la regla es y es el triple de x.', 'intermedia', 35),
  ('Si la regla es "y = 2x + 1" y se grafican los pares (1,3), (2,5), (3,7) en el plano cartesiano, ¿qué valor de y corresponde a x = 4?', '["9", "8", "7", "10"]', 0, 'y = 2 x 4 + 1 = 8 + 1 = 9.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_4_basico' and lo.short_name = 'Patrones en tablas y plano cartesiano'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Resuelve: 250 + ___ = 400', '["150", "650", "140", "160"]', 0, '400 - 250 = 150.', 'inicial', 25),
  ('Resuelve: ___ - 180 = 320', '["500", "140", "460", "510"]', 0, '320 + 180 = 500.', 'intermedia', 35),
  ('En 340 + 260 = ___ + 300, ¿qué número falta?', '["300", "600", "900", "240"]', 0, '340 + 260 = 600; 600 - 300 = 300.', 'intermedia', 35),
  ('¿Cuál es el valor desconocido en 1.000 - ___ = 250 + 350?', '["400", "600", "1.600", "350"]', 0, '250 + 350 = 600; 1.000 - 600 = 400.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_4_basico' and lo.short_name = 'Valores desconocidos en adición y sustracción'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Según la propiedad distributiva, 4 x (3 + 2) es igual a:', '["4x3 + 4x2", "4+3 x 4+2", "4x3 - 4x2", "3+2+4"]', 0, 'La propiedad distributiva reparte la multiplicación sobre cada término de la suma: 4x3 + 4x2.', 'inicial', 25),
  ('Usando la propiedad distributiva, calcula 6 x (10 + 2).', '["72", "62", "82", "70"]', 0, '6x10 + 6x2 = 60 + 12 = 72.', 'intermedia', 35),
  ('¿Cuál de estas expresiones es equivalente a 7 x (5 + 3) usando la propiedad distributiva?', '["7x5 + 7x3", "7+5 x 7+3", "7x5 - 7x3", "5x3 + 7"]', 0, 'La propiedad distributiva reparte el 7 sobre cada término: 7x5 + 7x3.', 'intermedia', 35),
  ('Usando la propiedad distributiva, calcula 9 x 23 descomponiendo 23 como 20 + 3.', '["207", "197", "217", "189"]', 0, '9x20 = 180 y 9x3 = 27; 180 + 27 = 207.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_4_basico' and lo.short_name = 'Propiedad distributiva'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Resuelve: 6 x n = 48', '["8", "6", "42", "54"]', 0, 'n = 48 ÷ 6 = 8.', 'inicial', 25),
  ('Resuelve: n ÷ 5 = 12', '["60", "17", "7", "65"]', 0, 'n = 12 x 5 = 60.', 'intermedia', 35),
  ('Resuelve: 9 x n = 72', '["8", "9", "63", "81"]', 0, 'n = 72 ÷ 9 = 8.', 'intermedia', 35),
  ('Resuelve: (n ÷ 3) x 2 = 10', '["15", "30", "6", "20"]', 0, 'Si (n÷3) x 2 = 10, entonces n÷3 = 5, por lo tanto n = 15.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_4_basico' and lo.short_name = 'Ecuaciones simples con multiplicación y división'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Patrones y Álgebra. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Una secuencia sigue la regla "multiplicar por 2 y luego sumar 3": 4, 11, 25, ___. ¿Qué número sigue?', '["53", "50", "28", "56"]', 0, '25 x 2 = 50, y 50 + 3 = 53.', 'inicial', 25),
  ('Una secuencia sigue la regla "sumar 5 y luego multiplicar por 2", comenzando en 3: 3, 16, ___. ¿Qué número sigue?', '["42", "32", "21", "37"]', 0, '(16 + 5) x 2 = 21 x 2 = 42.', 'intermedia', 35),
  ('Una secuencia sigue la regla "restar 2 y luego multiplicar por 3", comenzando en 10: 10, 24, ___. ¿Qué número sigue?', '["66", "72", "22", "60"]', 0, '(24 - 2) x 3 = 22 x 3 = 66.', 'intermedia', 35),
  ('Una secuencia sigue la regla "multiplicar por 3 y luego restar 4", comenzando en 5: 5, 11, 29, ___. ¿Qué número sigue?', '["83", "81", "87", "79"]', 0, '29 x 3 = 87, y 87 - 4 = 83.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Patrones y Álgebra' and l.code = 'regular_4_basico' and lo.short_name = 'Reglas de dos operaciones combinadas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOMETRÍA — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es un ángulo?', '["La abertura entre dos rayos que comparten un origen común", "Una línea recta sin fin", "La distancia entre dos puntos", "Un tipo de figura con 4 lados"]', 0, 'Un ángulo es la abertura formada entre dos rayos que comparten un mismo origen (vértice).', 'inicial', 25),
  ('¿Cuál de estos ángulos es mayor: uno de 30° o uno de 60°?', '["El de 60°", "El de 30°", "Son iguales", "No se puede comparar"]', 0, '60° es mayor que 30°.', 'intermedia', 35),
  ('Si dos ángulos comparten el mismo vértice y uno es más "abierto" que el otro, ¿qué se puede afirmar sobre sus medidas?', '["El más abierto tiene mayor medida en grados", "El más abierto tiene menor medida en grados", "Ambos tienen la misma medida", "La abertura no se relaciona con los grados"]', 0, 'A mayor abertura entre los rayos, mayor es la medida del ángulo en grados.', 'intermedia', 35),
  ('Un ángulo recto mide 90°. Si un segundo ángulo es la mitad de abierto que un ángulo recto, ¿cuántos grados mide aproximadamente?', '["45°", "90°", "180°", "30°"]', 0, 'La mitad de 90° es 45°.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_4_basico' and lo.short_name = 'Ángulos como abertura entre rayos'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es el área de un rectángulo de 6 cm de largo por 4 cm de ancho?', '["24 cm²", "20 cm²", "10 cm²", "28 cm²"]', 0, 'Área = largo x ancho = 6 x 4 = 24 cm².', 'inicial', 25),
  ('¿Cuál es el área de un cuadrado de lado 7 cm?', '["49 cm²", "28 cm²", "14 cm²", "35 cm²"]', 0, 'Área = lado x lado = 7 x 7 = 49 cm².', 'intermedia', 35),
  ('Un rectángulo tiene un área de 30 cm² y su ancho es 5 cm. ¿Cuál es su largo?', '["6 cm", "5 cm", "25 cm", "35 cm"]', 0, 'Largo = área ÷ ancho = 30 ÷ 5 = 6 cm.', 'intermedia', 35),
  ('Un patio rectangular mide 9 m de largo por 5 m de ancho. Si se quiere cubrir todo el patio con pasto, ¿cuántos metros cuadrados de pasto se necesitan?', '["45 m²", "28 m²", "14 m²", "50 m²"]', 0, 'Área = 9 x 5 = 45 m².', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_4_basico' and lo.short_name = 'Perímetro y área de rectángulos y cuadrados'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué transformación produce una imagen "espejo" de una figura?', '["La reflexión", "La traslación", "La ampliación", "La reducción"]', 0, 'La reflexión produce una imagen espejo de la figura respecto a una línea (eje de reflexión).', 'inicial', 25),
  ('¿Qué transformación hace girar una figura alrededor de un punto fijo?', '["La rotación", "La reflexión", "La traslación", "La simetría axial únicamente"]', 0, 'La rotación gira la figura alrededor de un punto fijo llamado centro de rotación.', 'intermedia', 35),
  ('Si rotas un cuadrado 90° alrededor de su centro, ¿qué ocurre con su forma y tamaño?', '["Se mantienen iguales, solo cambia su orientación", "Se duplican", "Se reducen a la mitad", "Cambia a un rectángulo"]', 0, 'La rotación conserva la forma y el tamaño de la figura; solo cambia su orientación.', 'intermedia', 35),
  ('Una figura se refleja respecto a una línea vertical y luego se rota 180° respecto a su centro. ¿Qué se puede afirmar sobre el tamaño de la figura final?', '["Se mantiene igual al de la figura original", "Se duplica", "Se reduce a la mitad", "No se puede saber"]', 0, 'Ni la reflexión ni la rotación cambian el tamaño de una figura; solo modifican su orientación y posición.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_4_basico' and lo.short_name = 'Reflexiones y rotaciones'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo se llama un triángulo con sus 3 lados de igual longitud?', '["Equilátero", "Isósceles", "Escaleno", "Rectángulo"]', 0, 'Un triángulo con sus 3 lados iguales se llama equilátero.', 'inicial', 25),
  ('¿Cómo se llama un triángulo con solo 2 lados de igual longitud?', '["Isósceles", "Equilátero", "Escaleno", "Obtusángulo"]', 0, 'Un triángulo con exactamente 2 lados iguales se llama isósceles.', 'intermedia', 35),
  ('¿Cuál de estos cuadriláteros tiene sus 4 lados de igual longitud pero no necesariamente ángulos rectos?', '["El rombo", "El rectángulo", "El trapecio", "El pentágono"]', 0, 'El rombo tiene sus 4 lados iguales, pero sus ángulos no son necesariamente rectos (a diferencia del cuadrado).', 'intermedia', 35),
  ('Un cuadrilátero tiene solo un par de lados paralelos. ¿Cómo se llama esa figura?', '["Trapecio", "Paralelogramo", "Rombo", "Rectángulo"]', 0, 'Un cuadrilátero con exactamente un par de lados paralelos se llama trapecio.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_4_basico' and lo.short_name = 'Clasificación de triángulos y cuadriláteros'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Geometría. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿En qué cuadrante se ubica un punto con x negativa e y positiva?', '["Segundo cuadrante", "Primer cuadrante", "Tercer cuadrante", "Cuarto cuadrante"]', 0, 'x negativa e y positiva corresponden al segundo cuadrante.', 'inicial', 25),
  ('¿En qué cuadrante se ubica el punto (-3, -4)?', '["Tercer cuadrante", "Primer cuadrante", "Segundo cuadrante", "Cuarto cuadrante"]', 0, 'Ambas coordenadas negativas corresponden al tercer cuadrante.', 'intermedia', 35),
  ('¿En qué cuadrante se ubica el punto (5, -2)?', '["Cuarto cuadrante", "Primer cuadrante", "Segundo cuadrante", "Tercer cuadrante"]', 0, 'x positiva e y negativa corresponden al cuarto cuadrante.', 'intermedia', 35),
  ('Un punto está en el segundo cuadrante y se traslada hacia la derecha hasta que su x pasa a ser positiva, mientras su y sigue siendo positiva. ¿En qué cuadrante queda ahora?', '["Primer cuadrante", "Segundo cuadrante", "Tercer cuadrante", "Cuarto cuadrante"]', 0, 'Si x pasa a ser positiva y la y se mantiene positiva, el punto queda en el primer cuadrante.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Geometría' and l.code = 'regular_4_basico' and lo.short_name = 'Coordenadas en los cuatro cuadrantes'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: MEDICIÓN — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuántos minutos tiene 1 hora?', '["60", "100", "24", "30"]', 0, '1 hora tiene 60 minutos.', 'inicial', 25),
  ('¿Cuántas horas tiene un día?', '["24", "12", "60", "7"]', 0, 'Un día tiene 24 horas.', 'intermedia', 35),
  ('Si un evento dura 150 minutos, ¿a cuántas horas y minutos equivale?', '["2 horas y 30 minutos", "1 hora y 50 minutos", "2 horas y 50 minutos", "1 hora y 30 minutos"]', 0, '150 minutos = 120 minutos (2 horas) + 30 minutos.', 'intermedia', 35),
  ('Si un viaje dura 3 horas y 45 minutos, ¿cuántos minutos son en total?', '["225 minutos", "185 minutos", "245 minutos", "165 minutos"]', 0, '3 horas = 180 minutos; 180 + 45 = 225 minutos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_4_basico' and lo.short_name = 'Conversión de unidades de tiempo'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué instrumento se usa para medir ángulos?', '["El transportador", "La regla", "La balanza", "El reloj"]', 0, 'El transportador es el instrumento usado para medir ángulos en grados.', 'inicial', 25),
  ('Si un ángulo mide 45° según el transportador, ¿cómo se clasifica?', '["Ángulo agudo (menor que 90°)", "Ángulo recto (90°)", "Ángulo obtuso (mayor que 90°)", "Ángulo llano (180°)"]', 0, '45° es menor que 90°, por lo que se clasifica como ángulo agudo.', 'intermedia', 35),
  ('Un ángulo mide 120° según el transportador. ¿Cómo se clasifica?', '["Ángulo obtuso", "Ángulo agudo", "Ángulo recto", "Ángulo nulo"]', 0, '120° es mayor que 90° y menor que 180°, por lo que se clasifica como ángulo obtuso.', 'intermedia', 35),
  ('Al medir dos ángulos con el transportador se obtiene 35° y 55°. Si se suman, ¿qué tipo de ángulo resulta?', '["Un ángulo recto (90°)", "Un ángulo agudo", "Un ángulo obtuso", "Un ángulo llano"]', 0, '35° + 55° = 90°, que corresponde a un ángulo recto.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_4_basico' and lo.short_name = 'Medición exploratoria de ángulos'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un jardín rectangular mide 5 m de largo y 3 m de ancho. ¿Cuál es su área?', '["15 m²", "16 m²", "8 m²", "10 m²"]', 0, 'Área = 5 x 3 = 15 m².', 'inicial', 25),
  ('Un patio cuadrado tiene un perímetro de 24 m. ¿Cuánto mide cada lado?', '["6 m", "4 m", "8 m", "12 m"]', 0, '24 ÷ 4 = 6 m por lado.', 'intermedia', 35),
  ('Se quiere cercar un terreno rectangular de 10 m de largo y 6 m de ancho. ¿Cuántos metros de cerca se necesitan (perímetro)?', '["32 m", "16 m", "60 m", "26 m"]', 0, 'Perímetro = 2 x (10 + 6) = 32 m.', 'intermedia', 35),
  ('Un salón rectangular mide 8 m de largo y 5 m de ancho. Si se quiere cubrir el piso con baldosas de 1 m² cada una, ¿cuántas baldosas se necesitan?', '["40 baldosas", "26 baldosas", "13 baldosas", "45 baldosas"]', 0, 'Área = 8 x 5 = 40 m², es decir, 40 baldosas de 1 m².', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_4_basico' and lo.short_name = 'Problemas de perímetro y área'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Medición. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuántos centímetros tiene 1 metro?', '["100", "10", "1.000", "50"]', 0, '1 metro tiene 100 centímetros.', 'inicial', 25),
  ('¿Cuántos gramos tiene 1 kilogramo?', '["1.000", "100", "10", "10.000"]', 0, '1 kilogramo tiene 1.000 gramos.', 'intermedia', 35),
  ('Si un objeto mide 250 cm, ¿cuántos metros es?', '["2,5 metros", "25 metros", "0,25 metros", "250 metros"]', 0, '250 cm ÷ 100 = 2,5 metros.', 'intermedia', 35),
  ('Un paquete pesa 2,5 kg. ¿Cuántos gramos pesa?', '["2.500 gramos", "250 gramos", "25.000 gramos", "2.500 kilogramos"]', 0, '2,5 kg x 1.000 = 2.500 gramos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Medición' and l.code = 'regular_4_basico' and lo.short_name = 'Conversión de unidades de longitud y masa'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: DATOS Y PROBABILIDADES — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Para qué se usa principalmente un gráfico de línea?', '["Para mostrar cómo cambia un dato a lo largo del tiempo", "Para comparar categorías sin orden temporal", "Para mostrar solo un dato único", "Para representar la probabilidad de un evento"]', 0, 'El gráfico de línea es útil para representar la evolución de un dato a lo largo del tiempo.', 'inicial', 25),
  ('En un gráfico de línea, si la línea sube entre dos puntos, ¿qué indica?', '["Que el valor aumentó en ese período", "Que el valor disminuyó en ese período", "Que el valor se mantuvo igual", "Que no hay datos en ese período"]', 0, 'Una línea ascendente entre dos puntos indica que el valor aumentó en ese período.', 'intermedia', 35),
  ('Un gráfico de línea muestra la temperatura de 10°C el lunes y 15°C el martes. ¿Qué ocurrió con la temperatura?', '["Aumentó 5°C", "Disminuyó 5°C", "Se mantuvo igual", "Aumentó 10°C"]', 0, '15 - 10 = 5°C de aumento.', 'intermedia', 35),
  ('Un gráfico de línea muestra las ventas de una tienda: lunes 200, martes 250, miércoles 220. ¿Entre qué días la línea muestra una disminución?', '["Entre martes y miércoles", "Entre lunes y martes", "Entre lunes y miércoles solamente", "La línea nunca disminuye"]', 0, 'De martes (250) a miércoles (220) las ventas bajaron, por lo que la línea desciende en ese tramo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_4_basico' and lo.short_name = 'Gráficos de línea'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es una tabla de frecuencia?', '["Una tabla que muestra cuántas veces se repite cada dato", "Una tabla que muestra solo los nombres de las personas encuestadas", "Un tipo de gráfico circular", "Una lista sin organizar de respuestas"]', 0, 'Una tabla de frecuencia organiza los datos mostrando cuántas veces se repite cada valor u opción.', 'inicial', 25),
  ('En una encuesta sobre color favorito, se obtuvo: azul (10), rojo (8), verde (6). ¿Cuál es la frecuencia del color rojo?', '["8", "10", "6", "24"]', 0, 'La frecuencia del color rojo es 8, según los datos.', 'intermedia', 35),
  ('Con los datos azul (10), rojo (8), verde (6), ¿cuántas personas fueron encuestadas en total?', '["24", "18", "16", "20"]', 0, '10 + 8 + 6 = 24 personas encuestadas.', 'intermedia', 35),
  ('En una tabla de frecuencia de deportes preferidos: fútbol (15), básquetbol (9), vóleibol (6). Si se encuestó a 30 estudiantes en total, ¿cuántos no eligieron ninguno de estos tres deportes?', '["Ninguno; los 30 estudiantes eligieron alguno de los tres deportes", "6 estudiantes", "9 estudiantes", "15 estudiantes"]', 0, '15 + 9 + 6 = 30, que corresponde exactamente al total de estudiantes encuestados.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_4_basico' and lo.short_name = 'Encuestas y tablas de frecuencia'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Una bolsa tiene 4 bolitas en total: 1 roja y 3 azules. ¿Qué fracción representa la probabilidad de sacar una bolita roja?', '["1/4", "3/4", "1/3", "4/1"]', 0, '1 bolita roja de 4 en total corresponde a la fracción 1/4.', 'inicial', 25),
  ('Una bolsa tiene 10 bolitas: 5 verdes y 5 amarillas. ¿Qué fracción representa la probabilidad de sacar una bolita verde?', '["1/2 (5/10)", "1/5", "2/5", "1/10"]', 0, '5 de 10 bolitas es 5/10, que se simplifica a 1/2.', 'intermedia', 35),
  ('Una bolsa tiene 6 bolitas: 2 rojas, 2 azules y 2 verdes. ¿Qué fracción representa la probabilidad de sacar una bolita azul?', '["1/3 (2/6)", "2/3", "1/2", "1/6"]', 0, '2 de 6 bolitas es 2/6, que se simplifica a 1/3.', 'intermedia', 35),
  ('Una bolsa tiene 8 bolitas: 3 rojas y 5 azules. Si se compara la probabilidad de sacar roja con la de sacar azul, ¿cuál es mayor?', '["La de sacar azul (5/8) es mayor que la de sacar roja (3/8)", "La de sacar roja es mayor", "Ambas probabilidades son iguales", "No se pueden comparar con fracciones"]', 0, '5/8 es mayor que 3/8, por lo que es más probable sacar una bolita azul.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_4_basico' and lo.short_name = 'Probabilidad con fracciones simples'
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
  'Pregunta ValidApp (borrador), Matemática 4° Básico, eje Datos y Probabilidades. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la moda de un conjunto de datos?', '["El valor que se repite con mayor frecuencia", "El valor más pequeño del conjunto", "El valor más grande del conjunto", "El promedio de todos los valores"]', 0, 'La moda es el valor que aparece con mayor frecuencia en el conjunto de datos.', 'inicial', 25),
  ('¿Cuál es la moda del conjunto de datos: 3, 5, 5, 7, 5, 8?', '["5", "7", "8", "3"]', 0, 'El número 5 se repite 3 veces, más que cualquier otro valor.', 'intermedia', 35),
  ('En una tabla de colores preferidos: azul (9), rojo (4), verde (4), ¿cuál es la moda?', '["Azul", "Rojo", "Verde", "No hay moda"]', 0, 'Azul tiene la mayor frecuencia (9), por lo que es la moda.', 'intermedia', 35),
  ('En el conjunto de datos 2, 4, 4, 6, 6, 8, hay dos valores que se repiten la misma cantidad de veces (2 veces cada uno). ¿Qué se puede afirmar sobre la moda de este conjunto?', '["El conjunto tiene dos modas: 4 y 6 (es bimodal)", "La moda es 8, porque es el valor más grande", "No existe la moda cuando hay empate", "La moda es 2, porque es el primer valor"]', 0, 'Cuando dos valores se repiten con la misma frecuencia máxima, el conjunto es bimodal: tiene dos modas, en este caso 4 y 6.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Matemática') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Matemática')
    and s.name = 'Datos y Probabilidades' and l.code = 'regular_4_basico' and lo.short_name = 'Interpretación de la moda en un conjunto de datos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
