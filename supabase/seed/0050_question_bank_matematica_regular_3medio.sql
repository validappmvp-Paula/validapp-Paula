-- Dominio: Contenido y preguntas
-- Banco de preguntas de selección múltiple — Matemática, 3° Medio (Currículum
-- Regular, Formación General), para los 21 objetivos de aprendizaje cargados
-- por supabase/seed/0013_curriculum_matematica_regular_3_4medio.sql.
--
-- ============================================================================
-- QUÉ CUBRE Y QUÉ NO
-- ============================================================================
-- 4 preguntas de selección múltiple (4 alternativas cada una) por cada uno de
-- los 21 objetivos de 3° Medio (5 Números + 6 Álgebra y Funciones +
-- 5 Geometría + 5 Probabilidad y Estadística) = 84 preguntas.
--
-- Ninguno de los objetivos de 3° Medio está marcado de confianza BAJA en
-- 0013 (la advertencia de confianza baja aplica solo a 5 objetivos puntuales
-- de 4° Medio, ver supabase/seed/0027). Aun así, el TEXTO de cada objetivo en
-- 0013 sigue siendo una paráfrasis ValidApp sin verificación línea por línea
-- contra el PDF oficial (decreto 193/2019 verificado, redacción exacta del
-- OA pendiente) — por lo tanto, estas preguntas son contenido ORIGINAL
-- ValidApp inspirado en el objetivo tal como está descrito en 0013, no una
-- adaptación de un ítem oficial MINEDUC. `source_type = 'validapp_original'`
-- en todas las filas.
--
-- No cubre Formación Diferenciada. No agrega lecciones nuevas. No modifica
-- `learning_objectives` (0013 no se toca).
--
-- ============================================================================
-- ESTADO EDITORIAL — honestidad, mismo criterio que el resto del banco EPJA
-- ============================================================================
-- Todas las preguntas quedan:
--   - review_status    = 'borrador'    (ciclo editorial, 0011)
--   - validation_status = 'unverified' (¿usable en ensayo publicado?, 0017)
--   - is_active        = true          (visible para el panel admin, pero
--     NO seleccionable en ensayos publicados: `buildCandidatePool` con
--     `requirePublishable: true` — usado por la publicación real y por
--     `essay-coverage.ts` — exige `is_active=true` AND
--     `validation_status='approved_for_exam'` AND `review_status='aprobado'`,
--     ver lib/data/essays.ts y lib/data/essay-coverage.ts).
-- Ninguna pregunta de este archivo puede llegar a un estudiante hasta que un
-- administrador humano las revise y las promueva explícitamente
-- (review_status -> 'aprobado' + validation_status -> 'approved_for_exam').
-- El generador de borradores de ensayos (`generateEssay`, sin
-- `requirePublishable`) sí puede incluirlas en una vista previa/borrador
-- administrativo — eso es intencional y no afecta a diagnósticos o ensayos
-- ya publicados a estudiantes.
--
-- ============================================================================
-- VÍNCULO CURRICULAR — sin ids hardcodeados
-- ============================================================================
-- Cada bloque de preguntas resuelve `learning_objective_id` mediante
-- `short_name` + `level_id` (subquery, no valores fijos). Todos los
-- `short_name` de 3° Medio en 0013 son únicos dentro de ese nivel, así que
-- no hace falta además filtrar por eje/unidad. Si el objetivo no existe
-- (0013 no se ha ejecutado, o el short_name cambió), el `cross join` no
-- produce filas y el bloque correspondiente no inserta nada — no falla en
-- silencio insertando en un objetivo equivocado.
--
-- ============================================================================
-- CALIDAD DE ÍTEM
-- ============================================================================
-- 4 alternativas por pregunta, una única respuesta correcta, distractores
-- plausibles (errores de cálculo o conceptuales típicos, no absurdos). Se
-- evita "todas/ninguna de las anteriores", pistas de longitud y fuga de la
-- respuesta en el enunciado (mismos criterios que
-- lib/data/question-validators.ts). Distribución de dificultad por objetivo:
-- 1 inicial + 2 intermedia + 1 avanzada.
--
-- ============================================================================
-- IDEMPOTENCIA
-- ============================================================================
-- Cada bloque usa `where not exists (select 1 from questions q2 where
-- q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
-- and q2.generated_by = 'claude-sonnet-5-assessments')`: si esas 4 preguntas
-- ya se cargaron para ese objetivo, el bloque no vuelve a insertar. Esto es
-- una idempotencia a nivel de LOTE por objetivo (no fila por fila): si un
-- administrador borra o edita 1 de las 4 preguntas sin borrar las otras 3,
-- reintentar el seed NO completa el lote — se detecta la fila marcadora
-- restante (mismo criterio de granularidad que el resto del repo, ver 0001).
--
-- Seed SOLO local: no se ha ejecutado contra ningún Supabase (ni dev ni
-- producción). Requiere que supabase/seed/0013 ya se haya ejecutado antes.

-- ============================================================================
-- EJE: NÚMEROS — 3° MEDIO
-- ============================================================================

-- Objetivo: "Operatoria con números reales en contexto"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Un producto cuesta $45.000 y se paga en 3 cuotas iguales sin interés. ¿Cuánto corresponde a cada cuota?',
   '["$13.500", "$15.000", "$16.500", "$45.000"]', 1,
   '45.000 dividido en 3 cuotas iguales es 15.000 por cuota.', 'inicial', 40),
  ('Se mezclan 2,5 litros de una solución y se le agregan 0,25 litros más. Si el total se reparte en partes iguales entre 3 envases, ¿cuántos litros contiene cada envase (aproximado a la centésima)?',
   '["0,85 L", "0,92 L", "1,08 L", "2,75 L"]', 1,
   '2,5 + 0,25 = 2,75 litros; 2,75 / 3 ≈ 0,92 litros por envase.', 'intermedia', 60),
  ('Un terreno rectangular mide 12,5 m de largo por 8,4 m de ancho. Si se quiere cercar solo el largo y los dos anchos (3 de sus 4 lados), ¿cuántos metros de cerco se necesitan?',
   '["29,3 m", "37,8 m", "20,9 m", "41,8 m"]', 0,
   '12,5 + 8,4 + 8,4 = 29,3 metros de cerco.', 'intermedia', 60),
  ('En un experimento, la temperatura de una muestra pasa de -12,5 °C a 8,3 °C. ¿En cuántos grados aumentó la temperatura?',
   '["16,4 °C", "20,8 °C", "4,2 °C", "-4,2 °C"]', 1,
   '8,3 - (-12,5) = 20,8 grados de aumento.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Operatoria con números reales en contexto'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Logaritmo como inverso de la potencia"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál es el valor de log₂ 8?',
   '["2", "3", "4", "8"]', 1,
   '2³ = 8, por lo tanto log₂ 8 = 3.', 'inicial', 40),
  ('¿A qué es igual log₁₀ 1000?',
   '["2", "3", "10", "100"]', 1,
   '10³ = 1000, por lo tanto log₁₀ 1000 = 3.', 'intermedia', 50),
  ('¿Cuál expresión representa correctamente la definición de logaritmo como inverso de la potencia, para log_b(a) = c?',
   '["b^c = a", "c^b = a", "a^c = b", "a^b = c"]', 0,
   'Por definición, log_b(a) = c equivale a decir que b elevado a c da como resultado a.', 'intermedia', 60),
  ('Si log₃ x = 4, ¿cuál es el valor de x?',
   '["12", "64", "81", "243"]', 2,
   '3⁴ = 81, por lo tanto x = 81.', 'avanzada', 75)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Logaritmo como inverso de la potencia'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Notación científica"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cómo se expresa 45.000.000 en notación científica?',
   '["4,5 × 10⁶", "4,5 × 10⁷", "4,5 × 10⁸", "45 × 10⁷"]', 1,
   '45.000.000 = 4,5 × 10⁷ (7 corrimientos de la coma decimal).', 'inicial', 45),
  ('El diámetro de un glóbulo rojo es aproximadamente 0,000007 m. Exprésalo en notación científica.',
   '["7 × 10⁻⁶", "7 × 10⁻⁵", "7 × 10⁻⁷", "7 × 10⁶"]', 0,
   '0,000007 = 7 × 10⁻⁶ (la coma se corre 6 lugares hacia la derecha).', 'intermedia', 60),
  ('Al multiplicar (3 × 10⁴) × (2 × 10³), ¿cuál es el resultado en notación científica?',
   '["6 × 10⁷", "6 × 10¹²", "5 × 10⁷", "6 × 10¹"]', 0,
   '(3 × 2) × 10^(4+3) = 6 × 10⁷.', 'intermedia', 60),
  ('Estima el orden de magnitud del resultado de (8 × 10⁹) ÷ (4 × 10⁻³).',
   '["2 × 10⁶", "2 × 10¹²", "2 × 10³", "4 × 10¹²"]', 1,
   '(8/4) × 10^(9-(-3)) = 2 × 10¹².', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Notación científica'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Interés compuesto y crecimiento exponencial"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál fórmula corresponde al monto final C con interés compuesto, capital inicial C₀, tasa i por período y n períodos?',
   '["C = C₀(1+i)ⁿ", "C = C₀(1+i·n)", "C = C₀·iⁿ", "C = C₀+i·n"]', 0,
   'El interés compuesto capitaliza cada período: C = C₀(1+i)ⁿ.', 'inicial', 45),
  ('Si se invierten $100.000 al 10% anual con interés compuesto, ¿cuánto dinero hay después de 2 años?',
   '["$110.000", "$120.000", "$121.000", "$100.000"]', 2,
   '100.000 × 1,1² = 100.000 × 1,21 = 121.000.', 'intermedia', 60),
  ('Una población de bacterias se duplica cada hora. Si inicialmente hay 200 bacterias, ¿cuántas habrá después de 3 horas?',
   '["600", "800", "1.600", "2.400"]', 2,
   '200 × 2³ = 200 × 8 = 1.600 bacterias.', 'intermedia', 60),
  ('¿Cuál de las siguientes situaciones NO corresponde a un modelo de crecimiento exponencial?',
   '["El valor de una inversión con interés compuesto", "La desintegración radiactiva de una sustancia", "La distancia recorrida por un auto a velocidad constante", "El crecimiento poblacional con tasa constante"]', 2,
   'Un auto a velocidad constante recorre distancia proporcional al tiempo: es un modelo lineal, no exponencial.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Interés compuesto y crecimiento exponencial'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Propiedades de los logaritmos"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál es el resultado de log₂ 4 + log₂ 8?',
   '["5", "6", "7", "32"]', 0,
   'log₂ 4 = 2 y log₂ 8 = 3; 2 + 3 = 5 (equivale a log₂ 32).', 'inicial', 45),
  ('Aplicando la propiedad del logaritmo de un cociente, ¿a qué es igual log₅(25/5)?',
   '["1", "2", "4", "5"]', 0,
   'log₅(25/5) = log₅25 - log₅5 = 2 - 1 = 1.', 'intermedia', 60),
  ('¿Qué propiedad permite escribir log(x³) como 3·log(x)?',
   '["Logaritmo de una potencia", "Logaritmo de un producto", "Logaritmo de un cociente", "Cambio de base"]', 0,
   'La propiedad del logaritmo de una potencia permite bajar el exponente como factor.', 'intermedia', 55),
  ('Si log x = 2 y log y = 3, ¿cuál es el valor de log(x²·y)?',
   '["5", "6", "7", "12"]', 2,
   'log(x²·y) = 2·log x + log y = 2(2) + 3 = 7.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Propiedades de los logaritmos'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- ============================================================================
-- EJE: ÁLGEBRA Y FUNCIONES — 3° MEDIO
-- ============================================================================

-- Objetivo: "Funciones potencia, exponencial y logarítmica"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál de las siguientes funciones corresponde a una función exponencial?',
   '["f(x) = 2^x", "f(x) = x²", "f(x) = 2x", "f(x) = √x"]', 0,
   'En una función exponencial la variable x está en el exponente, como en f(x) = 2^x.', 'inicial', 45),
  ('¿Cuál es el dominio de la función f(x) = log(x)?',
   '["Todos los números reales", "Los reales positivos (x > 0)", "Los reales negativos", "Solo los números enteros"]', 1,
   'El logaritmo solo está definido para argumentos estrictamente positivos.', 'intermedia', 55),
  ('A medida que x aumenta, ¿qué ocurre con el gráfico de f(x) = (1/2)^x?',
   '["Crece indefinidamente", "Decrece acercándose a 0", "Se mantiene constante", "Oscila entre valores positivos y negativos"]', 1,
   'Con base entre 0 y 1, la función exponencial decrece y se acerca asintóticamente a 0.', 'intermedia', 60),
  ('¿Cuál es la principal diferencia entre el gráfico de f(x) = x³ (función potencia) y g(x) = 3^x (función exponencial) para valores grandes de x?',
   '["La exponencial crece mucho más rápido que la potencia", "La potencia siempre supera a la exponencial", "Ambas crecen exactamente igual", "La exponencial decrece mientras la potencia crece"]', 0,
   'Para x suficientemente grande, toda función exponencial con base mayor que 1 supera a cualquier función potencia.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Funciones potencia, exponencial y logarítmica'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Modelamiento con funciones exponenciales y logarítmicas"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Un modelo de crecimiento poblacional está dado por P(t) = 500·(1,05)^t, con t en años. ¿Cuál es la población inicial?',
   '["5", "50", "500", "1,05"]', 2,
   'La población inicial corresponde a P(0) = 500·(1,05)⁰ = 500.', 'inicial', 45),
  ('Usando P(t) = 500·(1,05)^t, ¿cuál es la población aproximada después de 1 año?',
   '["505", "525", "550", "600"]', 1,
   'P(1) = 500 × 1,05 = 525.', 'intermedia', 55),
  ('El pH de una solución se calcula como pH = -log[H⁺]. Si [H⁺] = 10⁻⁴, ¿cuál es el pH?',
   '["-4", "4", "10", "0,0001"]', 1,
   'pH = -log(10⁻⁴) = -(-4) = 4.', 'intermedia', 60),
  ('La magnitud de un sismo en la escala de Richter es proporcional al logaritmo de la energía liberada. Si un sismo A libera 100 veces más energía que uno B, ¿en cuánto difiere aproximadamente su magnitud?',
   '["1", "2", "10", "100"]', 1,
   'log₁₀(100) = 2, por lo tanto la diferencia de magnitud es aproximadamente 2.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Modelamiento con funciones exponenciales y logarítmicas'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Ecuaciones exponenciales y logarítmicas"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Resuelve 2^x = 16. ¿Cuál es el valor de x?',
   '["2", "3", "4", "8"]', 2,
   '2⁴ = 16, por lo tanto x = 4.', 'inicial', 45),
  ('Resuelve log₃(x) = 2. ¿Cuál es el valor de x?',
   '["6", "8", "9", "27"]', 2,
   '3² = 9, por lo tanto x = 9.', 'intermedia', 55),
  ('Resuelve 3^(x+1) = 27. ¿Cuál es el valor de x?',
   '["1", "2", "3", "9"]', 1,
   '27 = 3³, entonces x + 1 = 3, por lo tanto x = 2.', 'intermedia', 65),
  ('Resuelve log(x) + log(x-3) = 1 (base 10), considerando solo soluciones válidas del dominio.',
   '["-2", "2", "5", "10"]', 2,
   'log(x(x-3)) = 1 implica x(x-3) = 10, es decir x² - 3x - 10 = 0, cuyas soluciones son x = 5 y x = -2; solo x = 5 cumple el dominio (x > 3).', 'avanzada', 100)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Ecuaciones exponenciales y logarítmicas'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Función inversa"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Qué condición debe cumplir una función para tener función inversa en todo su dominio?',
   '["Ser biyectiva (inyectiva y sobreyectiva)", "Ser creciente en un único punto", "Tener gráfico simétrico respecto al eje Y", "Ser una parábola"]', 0,
   'Solo las funciones biyectivas garantizan que cada valor tenga una única preimagen, condición necesaria para la inversa.', 'inicial', 50),
  ('Si f(x) = 2x + 6, ¿cuál es su función inversa f⁻¹(x)?',
   '["f⁻¹(x) = (x-6)/2", "f⁻¹(x) = (x+6)/2", "f⁻¹(x) = 2x-6", "f⁻¹(x) = x/2 - 6"]', 0,
   'Despejando x de y = 2x+6: x = (y-6)/2, por lo tanto f⁻¹(x) = (x-6)/2.', 'intermedia', 65),
  ('Geométricamente, el gráfico de la función inversa f⁻¹(x) es la reflexión del gráfico de f(x) respecto a:',
   '["La recta y = x", "El eje X", "El eje Y", "El origen"]', 0,
   'La función inversa se obtiene reflejando el gráfico original respecto a la recta y = x.', 'intermedia', 55),
  ('Si f(x) = log₂(x), ¿cuál es su función inversa?',
   '["f⁻¹(x) = 2^x", "f⁻¹(x) = x²", "f⁻¹(x) = log₂(1/x)", "f⁻¹(x) = x/2"]', 0,
   'Como f y f⁻¹ son operaciones inversas, si f(x) = log₂(x), entonces f⁻¹(x) = 2^x.', 'avanzada', 85)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Función inversa'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Composición de funciones"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Si f(x) = x+2 y g(x) = 3x, ¿cuál es (f∘g)(x)?',
   '["3x+2", "3x+6", "x+6", "3(x+2)"]', 0,
   '(f∘g)(x) = f(g(x)) = f(3x) = 3x + 2.', 'inicial', 50),
  ('Usando f(x) = x+2 y g(x) = 3x, ¿cuál es (g∘f)(2)?',
   '["8", "10", "12", "14"]', 2,
   '(g∘f)(2) = g(f(2)) = g(4) = 12.', 'intermedia', 60),
  ('Si f(x) = x² y g(x) = x-1, ¿cuál es (f∘g)(x)?',
   '["x² - 2x + 1", "x² - 1", "x - 1²", "x² + 2x + 1"]', 0,
   '(f∘g)(x) = f(g(x)) = (x-1)² = x² - 2x + 1.', 'intermedia', 70),
  ('¿Es la composición de funciones una operación conmutativa en general (es decir, f∘g = g∘f)?',
   '["Sí, siempre son iguales", "No, en general f∘g ≠ g∘f", "Solo si ambas son funciones lineales", "Solo si ambas son la función identidad"]', 1,
   'La composición de funciones no es conmutativa en general; el orden de composición importa.', 'avanzada', 80)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Composición de funciones'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Modelos de crecimiento y decrecimiento en ciencias"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('La desintegración radiactiva de una sustancia sigue un modelo de la forma N(t) = N₀·e^(-kt). ¿Qué representa N₀?',
   '["La cantidad inicial de sustancia", "La tasa de desintegración", "El tiempo transcurrido", "La cantidad final de sustancia"]', 0,
   'N₀ es la cantidad de sustancia presente en t = 0, es decir, la cantidad inicial.', 'inicial', 50),
  ('Una población de bacterias decrece según N(t) = 800·(0,9)^t. ¿La población está en crecimiento o decrecimiento?',
   '["Crecimiento, porque la base es mayor que 1", "Decrecimiento, porque la base está entre 0 y 1", "Crecimiento constante, no exponencial", "No se puede determinar sin más datos"]', 1,
   'Con base 0,9 (entre 0 y 1), el modelo describe un decrecimiento exponencial.', 'intermedia', 60),
  ('La vida media de una sustancia radiactiva es el tiempo que demora en reducirse a la mitad. Si una sustancia tiene vida media de 5 años y hoy hay 80 g, ¿cuántos gramos habrá en 10 años (2 vidas medias)?',
   '["10", "20", "40", "60"]', 1,
   'Cada vida media reduce la cantidad a la mitad: 80 → 40 (5 años) → 20 (10 años).', 'intermedia', 65),
  ('¿Cuál afirmación describe mejor la comparación entre un crecimiento exponencial cada vez más rápido y un crecimiento lineal?',
   '["El crecimiento exponencial eventualmente supera al lineal, sin importar las condiciones iniciales", "El crecimiento lineal siempre supera al exponencial", "Ambos crecen a la misma tasa en el largo plazo", "El crecimiento exponencial se detiene después de cierto tiempo"]', 0,
   'Toda función exponencial creciente supera eventualmente a cualquier función lineal, sin importar el punto de partida.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Modelos de crecimiento y decrecimiento en ciencias'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- ============================================================================
-- EJE: GEOMETRÍA — 3° MEDIO
-- ============================================================================

-- Objetivo: "Teorema del seno y del coseno"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('El teorema del coseno generaliza a triángulos no rectángulos el:',
   '["Teorema de Pitágoras", "Teorema de Thales", "Teorema del ángulo inscrito", "Teorema de la altura"]', 0,
   'El teorema del coseno es una generalización del teorema de Pitágoras para cualquier triángulo.', 'inicial', 50),
  ('Según el teorema del seno, en un triángulo ABC, ¿cuál relación es correcta?',
   '["a/sen(A) = b/sen(B) = c/sen(C)", "a·sen(A) = b·sen(B)", "a² = b²+c²", "a/cos(A) = b/cos(B)"]', 0,
   'El teorema del seno establece que el cociente entre cada lado y el seno de su ángulo opuesto es constante.', 'intermedia', 60),
  ('En un triángulo con lados a=7, b=9 y ángulo C=60° entre ellos, ¿qué fórmula usarías para hallar el lado c?',
   '["c² = a² + b² - 2ab·cos(C)", "c = a·sen(C)/b", "c² = a²+b²", "c/sen(C) = a/sen(A)"]', 0,
   'Conocidos dos lados y el ángulo comprendido (caso LAL), corresponde el teorema del coseno.', 'intermedia', 65),
  ('Un triángulo tiene lados a=6, b=8 y ángulo C=90°. Usando el teorema del coseno, ¿cuál es el valor de c²?',
   '["100", "36", "64", "196"]', 0,
   'c² = 6² + 8² - 2(6)(8)cos(90°) = 36 + 64 - 0 = 100.', 'avanzada', 85)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Teorema del seno y del coseno'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Vectores en el plano cartesiano"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Un vector que va del punto A(1,2) al punto B(4,6) tiene componentes:',
   '["(3, 4)", "(5, 8)", "(4, 6)", "(3, 8)"]', 0,
   'Las componentes se calculan restando coordenadas: (4-1, 6-2) = (3, 4).', 'inicial', 50),
  ('¿Cuál es la magnitud (módulo) del vector v = (3, 4)?',
   '["5", "7", "12", "25"]', 0,
   '|v| = √(3² + 4²) = √25 = 5.', 'intermedia', 55),
  ('Si u = (2, -1) y w = (-3, 5), ¿cuál es u + w?',
   '["(-1, 4)", "(5, -6)", "(-1, -4)", "(1, 4)"]', 0,
   'u + w = (2 + (-3), -1 + 5) = (-1, 4).', 'intermedia', 60),
  ('Dos vectores son paralelos si:',
   '["Uno es múltiplo escalar del otro", "Su producto punto es cero", "Tienen igual magnitud", "Están ubicados en ejes distintos"]', 0,
   'Dos vectores son paralelos cuando uno se puede escribir como un escalar multiplicado por el otro.', 'avanzada', 80)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Vectores en el plano cartesiano'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Figuras 3D y proyecciones"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál de los siguientes es un cuerpo geométrico 3D?',
   '["Cubo", "Triángulo", "Circunferencia", "Rectángulo"]', 0,
   'El cubo es un cuerpo tridimensional; los otros son figuras planas (2D).', 'inicial', 45),
  ('La proyección ortogonal de un cubo sobre un plano paralelo a una de sus caras es:',
   '["Un cuadrado", "Un círculo", "Un triángulo", "Una línea recta"]', 0,
   'Al proyectar un cubo sobre un plano paralelo a una cara, se obtiene un cuadrado igual a esa cara.', 'intermedia', 60),
  ('¿Cuántas caras tiene un prisma de base pentagonal?',
   '["5", "6", "7", "10"]', 2,
   'Un prisma pentagonal tiene 2 caras basales (pentágonos) + 5 caras laterales (rectángulos) = 7 caras.', 'intermedia', 65),
  ('Al proyectar un cilindro sobre un plano perpendicular a su eje, ¿qué figura se obtiene?',
   '["Un círculo", "Un rectángulo", "Un triángulo", "Una elipse"]', 0,
   'La proyección perpendicular al eje del cilindro corresponde a su base circular.', 'avanzada', 85)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Figuras 3D y proyecciones'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Resolución de triángulos oblicuángulos"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Un triángulo oblicuángulo es aquel que:',
   '["No tiene ningún ángulo recto", "Tiene un ángulo recto", "Es equilátero", "Tiene todos sus lados iguales"]', 0,
   'Un triángulo oblicuángulo carece de ángulos de 90°; puede ser acutángulo u obtusángulo.', 'inicial', 45),
  ('Para resolver un triángulo oblicuángulo del que se conocen dos lados y el ángulo comprendido entre ellos (caso LAL), ¿qué teorema conviene aplicar primero?',
   '["Teorema del coseno", "Teorema de Pitágoras", "Teorema de Thales", "Teorema del seno únicamente"]', 0,
   'El caso LAL se resuelve primero con el teorema del coseno para obtener el lado faltante.', 'intermedia', 60),
  ('Si conoces los tres lados de un triángulo oblicuángulo (caso LLL) y quieres encontrar sus ángulos, ¿qué teorema usarías?',
   '["Teorema del coseno", "Teorema del seno", "Teorema de Pitágoras", "No es posible resolverlo"]', 0,
   'Con los tres lados conocidos, el teorema del coseno despejado permite obtener cada ángulo.', 'intermedia', 65),
  ('En un triángulo con A=40°, B=75° y lado a=10, ¿qué relación usarías para encontrar el lado b?',
   '["b/sen(B) = a/sen(A)", "b² = a²+c²-2ac·cos(B)", "b = a·cos(B)", "b/cos(B) = a/cos(A)"]', 0,
   'Con dos ángulos y un lado opuesto conocido (caso AAL), corresponde el teorema del seno.', 'avanzada', 85)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Resolución de triángulos oblicuángulos'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Aplicaciones de vectores en física"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('En física, una fuerza se representa comúnmente como un:',
   '["Vector", "Escalar", "Número entero", "Ángulo únicamente"]', 0,
   'La fuerza tiene magnitud y dirección, por lo que se representa como un vector.', 'inicial', 45),
  ('Un objeto se desplaza 3 km al este y luego 4 km al norte. ¿Cuál es la magnitud de su desplazamiento resultante?',
   '["5 km", "7 km", "12 km", "25 km"]', 0,
   'Por Pitágoras: √(3² + 4²) = √25 = 5 km.', 'intermedia', 60),
  ('Si dos fuerzas de igual magnitud actúan en direcciones opuestas sobre un objeto, la fuerza resultante es:',
   '["Cero", "El doble de una de ellas", "La mitad de una de ellas", "Igual a una de ellas"]', 0,
   'Fuerzas de igual magnitud y direcciones opuestas se cancelan, dando una resultante nula.', 'intermedia', 55),
  ('Un vector velocidad de un avión es (300, 0) km/h respecto al aire, y el viento aporta un vector (0, -40) km/h. ¿Cuál es el vector velocidad resultante respecto al suelo?',
   '["(300, -40)", "(300, 40)", "(340, 0)", "(260, 0)"]', 0,
   'La velocidad resultante es la suma vectorial: (300+0, 0+(-40)) = (300, -40).', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Aplicaciones de vectores en física'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- ============================================================================
-- EJE: PROBABILIDAD Y ESTADÍSTICA — 3° MEDIO
-- ============================================================================

-- Objetivo: "Medidas de dispersión"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál de las siguientes es una medida de dispersión?',
   '["Desviación estándar", "Media aritmética", "Moda", "Mediana"]', 0,
   'La desviación estándar mide qué tan dispersos están los datos respecto a la media; las otras son medidas de tendencia central.', 'inicial', 45),
  ('Si dos conjuntos de datos tienen la misma media pero distinta desviación estándar, ¿qué se puede afirmar?',
   '["El conjunto con mayor desviación estándar tiene datos más dispersos", "Ambos conjuntos son idénticos", "El conjunto con menor desviación estándar tiene datos más dispersos", "No se puede comparar su dispersión"]', 0,
   'A mayor desviación estándar, mayor dispersión de los datos respecto a la media.', 'intermedia', 60),
  ('La varianza de un conjunto de datos es 16. ¿Cuál es su desviación estándar?',
   '["4", "8", "16", "256"]', 0,
   'La desviación estándar es la raíz cuadrada de la varianza: √16 = 4.', 'intermedia', 55),
  ('Un conjunto de datos {2, 4, 4, 4, 5, 5, 7, 9} tiene media 5. ¿Cuál es aproximadamente su varianza?',
   '["2", "4", "8", "16"]', 1,
   'La suma de las desviaciones al cuadrado respecto a la media es 32; dividido en 8 datos da varianza 4.', 'avanzada', 100)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Medidas de dispersión'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Variable aleatoria discreta"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál de las siguientes es un ejemplo de variable aleatoria discreta?',
   '["El número de caras al lanzar 3 monedas", "La estatura de una persona", "El tiempo que demora en llover", "El peso exacto de una fruta"]', 0,
   'El número de caras solo puede tomar valores enteros (0, 1, 2, 3), lo que la hace discreta.', 'inicial', 50),
  ('Para que una función de probabilidad de una variable aleatoria discreta sea válida, la suma de todas sus probabilidades debe ser:',
   '["1", "0", "100", "Depende del caso"]', 0,
   'La suma de las probabilidades de todos los valores posibles de una variable aleatoria siempre debe ser igual a 1.', 'intermedia', 55),
  ('Si X es el número de caras al lanzar una moneda 2 veces, ¿cuál es P(X=1)?',
   '["0,25", "0,5", "0,75", "1"]', 1,
   'De los 4 resultados posibles (CC, CS, SC, SS), 2 tienen exactamente 1 cara: P(X=1) = 2/4 = 0,5.', 'intermedia', 65),
  ('El valor esperado E(X) de una variable aleatoria discreta representa:',
   '["El promedio ponderado de los valores según su probabilidad", "El valor más probable siempre", "El valor máximo posible", "La mediana de la distribución"]', 0,
   'E(X) es la suma de cada valor multiplicado por su probabilidad, es decir, un promedio ponderado.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Variable aleatoria discreta'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Distribución normal"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('La distribución normal se representa gráficamente mediante una curva:',
   '["Con forma de campana, simétrica respecto a la media", "Con forma de línea recta", "Con forma de escalera", "Con forma de círculo"]', 0,
   'La curva normal es simétrica respecto a la media y tiene forma acampanada.', 'inicial', 45),
  ('En una distribución normal, ¿qué porcentaje aproximado de los datos se encuentra dentro de una desviación estándar de la media?',
   '["50%", "68%", "95%", "99,7%"]', 1,
   'La regla empírica establece que aproximadamente el 68% de los datos está dentro de ±1 desviación estándar.', 'intermedia', 60),
  ('En una distribución normal estándar, la media es 0 y la desviación estándar es:',
   '["0", "1", "10", "100"]', 1,
   'Por definición, la distribución normal estándar tiene media 0 y desviación estándar 1.', 'intermedia', 50),
  ('Si una variable se distribuye normalmente con media 100 y desviación estándar 15, ¿en qué intervalo se espera encontrar aproximadamente el 95% de los datos?',
   '["70 a 130", "85 a 115", "55 a 145", "100 a 130"]', 0,
   'El 95% de los datos se encuentra dentro de ±2 desviaciones estándar: 100 ± 30 = [70, 130].', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Distribución normal'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Comparación de distribuciones de datos"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Al comparar dos distribuciones de datos, ¿qué se debe considerar además de la media?',
   '["La dispersión de los datos", "Solo el valor máximo", "Solo el valor mínimo", "El número de datos únicamente"]', 0,
   'Comparar solo la media es insuficiente; también hay que considerar cuán dispersos están los datos.', 'inicial', 50),
  ('Dos cursos rinden la misma prueba. El curso A tiene media 5,5 y desviación estándar 0,5; el curso B tiene media 5,5 y desviación estándar 1,8. ¿Qué se puede afirmar?',
   '["El curso B tiene resultados más heterogéneos que el curso A", "El curso A tiene resultados más heterogéneos que el curso B", "Ambos cursos son igual de homogéneos", "No se puede comparar la dispersión"]', 0,
   'Una mayor desviación estándar (curso B) indica resultados más dispersos/heterogéneos.', 'intermedia', 60),
  ('Si se compara el rango de dos conjuntos de datos, se está comparando:',
   '["La diferencia entre el valor máximo y el mínimo", "El promedio de los datos", "La moda de los datos", "La cantidad de datos"]', 0,
   'El rango se define como la diferencia entre el valor máximo y el mínimo de un conjunto de datos.', 'intermedia', 55),
  ('Al comparar diagramas de caja (boxplots) de dos grupos de datos, una caja más ancha indica:',
   '["Mayor dispersión en el rango intercuartílico", "Mayor media", "Menor cantidad de datos", "Menor dispersión"]', 0,
   'El ancho de la caja en un boxplot representa el rango intercuartílico (Q3-Q1); una caja más ancha indica mayor dispersión central.', 'avanzada', 85)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Comparación de distribuciones de datos'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Curva normal y su uso en la toma de decisiones"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_3_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('La curva normal se utiliza en la toma de decisiones principalmente para:',
   '["Estimar la probabilidad de que un valor esté en cierto rango", "Calcular la moda de los datos", "Determinar el número total de datos", "Ordenar los datos de menor a mayor"]', 0,
   'La curva normal permite estimar probabilidades de que una variable tome valores dentro de un rango dado.', 'inicial', 55),
  ('Si los puntajes de una prueba estandarizada se distribuyen normalmente, un puntaje muy alejado de la media (por ejemplo, a más de 3 desviaciones estándar) se considera:',
   '["Un valor atípico o poco frecuente", "El valor más común", "Un error de cálculo siempre", "Igual de probable que la media"]', 0,
   'Valores muy alejados de la media (más de 3 desviaciones estándar) son estadísticamente poco frecuentes.', 'intermedia', 60),
  ('Una empresa usa la distribución de los tiempos de entrega (normal) para decidir cuántos días prometer a sus clientes con alta confianza. Esto es un ejemplo de uso de la curva normal para:',
   '["Tomar decisiones basadas en probabilidades", "Calcular exactamente cada tiempo de entrega", "Eliminar la variabilidad del proceso", "Ignorar los datos atípicos"]', 0,
   'La curva normal permite tomar decisiones informadas usando probabilidades, no valores exactos.', 'intermedia', 65),
  ('Si el 95% de los tiempos de entrega están entre 2 y 8 días (media 5, y esto corresponde a 2 desviaciones estándar), ¿cuál es aproximadamente la desviación estándar?',
   '["1", "1,5", "2", "3"]', 1,
   'El intervalo [2,8] tiene un ancho total de 6 días, que corresponde a 4 desviaciones estándar (±2σ): σ = 6/4 = 1,5.', 'avanzada', 95)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_3_medio')
    and short_name = 'Curva normal y su uso en la toma de decisiones'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );
