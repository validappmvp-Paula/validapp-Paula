-- Dominio: Contenido y preguntas
-- Banco de preguntas de selección múltiple — Matemática, 4° Medio (Currículum
-- Regular, Formación General), para los 21 objetivos de aprendizaje cargados
-- por supabase/seed/0013_curriculum_matematica_regular_3_4medio.sql.
--
-- ============================================================================
-- QUÉ CUBRE Y QUÉ NO
-- ============================================================================
-- 16 objetivos (Números 5 + Álgebra y Funciones 4 + Geometría 5 +
-- Probabilidad y Estadística 2) con 4 preguntas cada uno = 64 preguntas.
-- 5 objetivos marcados de CONFIANZA BAJA en 0013 (ver advertencia específica
-- de 4° Medio en ese archivo) con solo 3 preguntas cada uno = 15 preguntas.
-- Total: 79 preguntas de selección múltiple (4 alternativas cada una).
--
-- ============================================================================
-- LOS 5 OBJETIVOS DE CONFIANZA BAJA — cobertura deliberadamente MÁS CONSERVADORA
-- ============================================================================
-- 0013 marca estos 5 objetivos con `pedagogical_notes` reforzado, agrupados
-- en 2 focos temáticos (ambos de la reforma 2019, alcance pedagógico exacto
-- no verificado -- Formación General vs. Diferenciada, y con qué
-- profundidad):
--   - Álgebra y Funciones: "Tasa de variación media" y "Relación entre tasa
--     de variación media y pendiente" (introducción intuitiva al concepto de
--     derivada).
--   - Probabilidad y Estadística: "Estudio estadístico e inferencia",
--     "Intervalos de confianza" y "Errores en la toma de decisiones basada
--     en datos" (bloque de inferencia estadística introductoria).
-- Para estos 5 objetivos, este archivo:
--   (a) genera solo 3 preguntas en vez de 4 (cobertura más conservadora,
--       proporcional a la incertidumbre pedagógica ya documentada en 0013,
--       no a falta de tiempo);
--   (b) restringe las preguntas a la interpretación MÁS BÁSICA e
--       inequívoca del concepto (definición operativa, lectura directa de
--       un ejemplo numérico), evitando deliberadamente matices de
--       profundidad o de qué tan cerca está el tratamiento del cálculo
--       diferencial/de la inferencia formal -- precisamente lo que está sin
--       verificar;
--   (c) NO avanza el `status` de esos 5 objetivos en `learning_objectives`
--       (no se toca 0013 desde este archivo) y dedica un comentario propio
--       antes de cada bloque de preguntas, dado que la tabla `questions` no
--       tiene una columna `pedagogical_notes` (esa columna vive en
--       `learning_objectives`, no en `questions`).
-- Un administrador/pedagogo debería revisar estos 5 bloques con especial
-- cuidado antes de promoverlos a `review_status='aprobado'`.
--
-- ============================================================================
-- ESTADO EDITORIAL, VÍNCULO CURRICULAR, IDEMPOTENCIA
-- ============================================================================
-- Mismo criterio que supabase/seed/0026 (ver ese archivo para el detalle
-- completo): `review_status='borrador'`, `validation_status='unverified'`,
-- `is_active=true`, `source_type='validapp_original'`. Ninguna pregunta de
-- este archivo es seleccionable hoy para un ensayo o diagnóstico PUBLICADO
-- (`buildCandidatePool` con `requirePublishable: true` exige
-- `validation_status='approved_for_exam'` + `review_status='aprobado'`, ver
-- lib/data/essays.ts y lib/data/essay-coverage.ts) -- solo un administrador
-- humano puede promoverlas después de revisarlas.
--
-- `learning_objective_id` se resuelve por `short_name` + `level_id`
-- (`regular_4_medio`), sin ids hardcodeados. Todos los `short_name` de
-- 4° Medio en 0013 son únicos dentro de ese nivel. Cada bloque es
-- idempotente por lote (`where not exists ... generated_by =
-- 'claude-sonnet-5-assessments'`), igual que 0026.
--
-- Seed SOLO local: no se ha ejecutado contra ningún Supabase (ni dev ni
-- producción). Requiere que supabase/seed/0013 ya se haya ejecutado antes.

-- ============================================================================
-- EJE: NÚMEROS — 4° MEDIO
-- ============================================================================

-- Objetivo: "Interés simple y compuesto"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál es la principal diferencia entre interés simple e interés compuesto?',
   '["El interés compuesto genera intereses sobre los intereses previos, el simple no", "El interés simple genera intereses sobre los intereses previos", "Ambos generan el mismo monto final siempre", "El interés simple solo se usa en préstamos"]', 0,
   'En el interés compuesto, cada período capitaliza el interés anterior; en el simple, el interés se calcula siempre sobre el capital original.', 'inicial', 50),
  ('Se invierten $200.000 a una tasa de interés simple del 5% anual. ¿Cuánto interés se genera en 3 años?',
   '["$10.000", "$20.000", "$30.000", "$40.000"]', 2,
   'Interés simple = 200.000 × 0,05 × 3 = 30.000.', 'intermedia', 60),
  ('Se invierten $200.000 al 5% anual con interés compuesto durante 2 años. ¿Cuál es el monto final aproximado?',
   '["$210.000", "$220.000", "$220.500", "$230.000"]', 2,
   '200.000 × 1,05² = 200.000 × 1,1025 = 220.500.', 'intermedia', 65),
  ('Para un mismo capital, tasa y número de períodos (mayor a 1), ¿qué relación existe entre el monto final con interés simple y con interés compuesto?',
   '["El monto con interés compuesto es mayor o igual al del simple", "El monto con interés simple siempre es mayor", "Ambos montos son siempre iguales", "No se pueden comparar"]', 0,
   'Para más de un período, el interés compuesto capitaliza los intereses previos, generando un monto igual o mayor al del interés simple.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Interés simple y compuesto'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Sucesiones y progresiones"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('En la progresión aritmética 3, 7, 11, 15, ..., ¿cuál es la diferencia común?',
   '["2", "3", "4", "7"]', 2,
   'Cada término aumenta en 4 respecto al anterior: 7-3=4, 11-7=4.', 'inicial', 45),
  ('¿Cuál es el décimo término de la progresión aritmética con primer término 5 y diferencia común 3?',
   '["27", "29", "32", "35"]', 2,
   'a₁₀ = 5 + 9×3 = 5 + 27 = 32.', 'intermedia', 60),
  ('En la progresión geométrica 2, 6, 18, 54, ..., ¿cuál es la razón común?',
   '["2", "3", "4", "6"]', 1,
   'Cada término se obtiene multiplicando el anterior por 3: 6/2=3, 18/6=3.', 'intermedia', 55),
  ('¿Cuál es la suma de los primeros 5 términos de la progresión geométrica 3, 6, 12, 24, ...?',
   '["45", "63", "93", "96"]', 2,
   'S₅ = 3(2⁵-1)/(2-1) = 3×31 = 93.', 'avanzada', 95)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Sucesiones y progresiones'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Crecimiento y decrecimiento exponencial"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Un modelo de la forma N(t) = N₀·(1+r)^t con r > 0 describe un proceso de:',
   '["Crecimiento exponencial", "Decrecimiento exponencial", "Crecimiento lineal", "Decrecimiento lineal"]', 0,
   'Con base (1+r) mayor que 1, el modelo describe un crecimiento exponencial.', 'inicial', 50),
  ('Si r = -0,2 en el modelo N(t) = N₀·(1+r)^t, el proceso corresponde a:',
   '["Crecimiento exponencial", "Decrecimiento exponencial", "Crecimiento constante", "No es un modelo válido"]', 1,
   'Con r=-0,2, la base (1+r)=0,8 está entre 0 y 1, lo que produce decrecimiento exponencial.', 'intermedia', 60),
  ('Una sustancia se reduce en un 15% cada año. Si hoy hay 500 g, ¿cuántos gramos quedan aproximadamente después de 1 año?',
   '["425", "450", "475", "500"]', 0,
   '500 × (1 - 0,15) = 500 × 0,85 = 425 g.', 'intermedia', 60),
  ('Comparando dos inversiones con el mismo capital inicial, una con crecimiento exponencial y otra con crecimiento lineal, en el largo plazo:',
   '["La inversión con crecimiento exponencial siempre supera a la lineal", "La inversión lineal siempre supera a la exponencial", "Ambas crecen igual en el largo plazo", "Depende solo del capital inicial"]', 0,
   'Toda función exponencial creciente supera eventualmente a cualquier función lineal en el largo plazo.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Crecimiento y decrecimiento exponencial'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Aplicaciones financieras de sucesiones"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Un plan de ahorro consiste en depositar $10.000 el primer mes, $12.000 el segundo, $14.000 el tercero, aumentando $2.000 cada mes. Este es un ejemplo de progresión:',
   '["Aritmética", "Geométrica", "Ninguna de las dos", "Exponencial"]', 0,
   'El aumento es siempre la misma cantidad fija ($2.000), característica de una progresión aritmética.', 'inicial', 50),
  ('Usando el plan de ahorro anterior (10.000, 12.000, 14.000, ... aumentando $2.000 cada mes), ¿cuánto se depositará en el mes 6?',
   '["$18.000", "$20.000", "$22.000", "$24.000"]', 1,
   'a₆ = 10.000 + 5×2.000 = 10.000 + 10.000 = 20.000.', 'intermedia', 60),
  ('Una deuda se paga en cuotas que forman una progresión geométrica decreciente. Si la primera cuota es $20.000 y la razón es 0,5, ¿cuál es la segunda cuota?',
   '["$5.000", "$10.000", "$15.000", "$20.000"]', 1,
   'La segunda cuota es 20.000 × 0,5 = 10.000.', 'intermedia', 60),
  ('Para calcular el monto total ahorrado en un plan de depósitos mensuales constantes que generan interés compuesto, se utiliza el concepto de:',
   '["Suma de una progresión geométrica (anualidad)", "Suma de una progresión aritmética únicamente", "Solo el interés simple", "La media aritmética de los depósitos"]', 0,
   'Los depósitos periódicos con interés compuesto se modelan como una anualidad, que corresponde a la suma de una progresión geométrica.', 'avanzada', 95)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Aplicaciones financieras de sucesiones'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Comparación de modelos de crecimiento"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál de los siguientes modelos corresponde a un crecimiento lineal?',
   '["f(x) = 3x + 2", "f(x) = 2^x", "f(x) = x²", "f(x) = log(x)"]', 0,
   'Un modelo lineal tiene la forma f(x) = mx + b, con tasa de cambio constante.', 'inicial', 50),
  ('Para valores grandes de x, ¿qué modelo crece más rápido: f(x)=x² (cuadrático) o g(x)=2^x (exponencial)?',
   '["g(x), el exponencial", "f(x), el cuadrático", "Ambos crecen igual", "Depende del valor inicial únicamente"]', 0,
   'Toda función exponencial con base mayor que 1 supera eventualmente a cualquier función polinomial.', 'intermedia', 65),
  ('Un modelo lineal y uno exponencial parten del mismo valor inicial. A corto plazo, el modelo exponencial puede crecer más lento que el lineal, pero a largo plazo:',
   '["El exponencial siempre termina superando al lineal", "El lineal siempre termina superando al exponencial", "Ambos convergen al mismo valor", "No se puede determinar en ningún caso"]', 0,
   'A largo plazo, el crecimiento exponencial siempre supera al lineal, sin importar el punto de partida.', 'intermedia', 70),
  ('Al comparar un modelo de crecimiento cuadrático f(x)=x² con uno exponencial g(x)=1,5^x, para valores de x muy grandes, ¿cuál crece más rápido?',
   '["g(x), porque toda función exponencial con base mayor que 1 supera eventualmente a cualquier función polinomial", "f(x), porque el cuadrado siempre es mayor", "Ambos crecen igual de rápido", "No se puede comparar sin una calculadora"]', 0,
   'Aunque a corto plazo x² puede ser mayor, para x suficientemente grande la exponencial 1,5^x siempre termina superándola.', 'avanzada', 95)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Comparación de modelos de crecimiento'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- ============================================================================
-- EJE: ÁLGEBRA Y FUNCIONES — 4° MEDIO
-- ============================================================================

-- Objetivo: "Funciones a trozos"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Una función a trozos (o por tramos) se caracteriza por:',
   '["Estar definida por distintas expresiones según el intervalo de x", "Ser siempre lineal", "No tener dominio definido", "Ser siempre discontinua"]', 0,
   'En una función a trozos, la regla de asignación cambia dependiendo del intervalo en que se encuentre x.', 'inicial', 50),
  ('Dada f(x) = { x+1 si x<0 ; x² si x≥0 }, ¿cuál es el valor de f(-2)?',
   '["-1", "4", "-2", "1"]', 0,
   'Como -2 < 0, se usa la primera expresión: f(-2) = -2+1 = -1.', 'intermedia', 60),
  ('Usando la misma función f(x) = { x+1 si x<0 ; x² si x≥0 }, ¿cuál es el valor de f(3)?',
   '["4", "6", "9", "3"]', 2,
   'Como 3 ≥ 0, se usa la segunda expresión: f(3) = 3² = 9.', 'intermedia', 60),
  ('¿En qué tipo de situaciones cotidianas se suele modelar con funciones a trozos?',
   '["Tarifas que cambian según rangos de consumo (por ejemplo, electricidad o telefonía)", "El área de un círculo según su radio", "La suma de dos números constantes", "El volumen de una esfera"]', 0,
   'Las tarifas escalonadas por rango de consumo son un ejemplo típico de función definida por tramos.', 'avanzada', 85)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Funciones a trozos'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Optimización con funciones cuadráticas"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('El vértice de una parábola f(x) = ax²+bx+c representa:',
   '["El punto máximo o mínimo de la función", "Siempre el punto máximo", "Siempre el punto mínimo", "Un punto donde la función no está definida"]', 0,
   'El vértice es un máximo si a<0 y un mínimo si a>0.', 'inicial', 50),
  ('¿Cuál es la coordenada x del vértice de f(x) = x²-4x+3?',
   '["1", "2", "3", "4"]', 1,
   'x_vértice = -b/(2a) = 4/2 = 2.', 'intermedia', 60),
  ('Un rectángulo tiene perímetro fijo de 40 m. Si x es el largo, el área se modela como A(x) = x(20-x). ¿Para qué valor de x el área es máxima?',
   '["5", "10", "15", "20"]', 1,
   'El vértice de A(x)=-x²+20x está en x=-20/(2×-1)=10.', 'intermedia', 70),
  ('Un objeto lanzado verticalmente sigue la trayectoria h(t) = -5t²+20t (h en metros, t en segundos). ¿En qué instante alcanza su altura máxima?',
   '["1", "2", "4", "10"]', 1,
   't_vértice = -20/(2×-5) = 2 segundos.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Optimización con funciones cuadráticas'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Tasa de variación media"
-- ADVERTENCIA (ver también encabezado de este archivo y 0013): objetivo de
-- CONFIANZA BAJA -- alcance pedagógico (Formación General vs. Diferenciada,
-- profundidad) no verificado. Cobertura conservadora: solo 3 preguntas,
-- limitadas a la definición operativa y a un ejemplo numérico directo, sin
-- entrar en matices de interpretación más propios del cálculo diferencial.
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('La tasa de variación media de una función f entre x=a y x=b se define como:',
   '["(f(b) - f(a)) / (b - a)", "f(b) - f(a)", "f(b) / f(a)", "(f(b) + f(a)) / 2"]', 0,
   'La tasa de variación media es el cociente entre el cambio de la función y el cambio de x en el intervalo.', 'inicial', 55),
  ('Si f(x) = x², ¿cuál es la tasa de variación media de f entre x=1 y x=3?',
   '["2", "4", "6", "8"]', 1,
   '[f(3)-f(1)] / (3-1) = (9-1)/2 = 4.', 'intermedia', 65),
  ('El volumen de una piscina que se está llenando pasa de 200 a 500 litros entre el minuto 2 y el minuto 7. ¿Cuál es la tasa de variación media del volumen en ese intervalo?',
   '["40 L/min", "50 L/min", "60 L/min", "75 L/min"]', 2,
   '(500-200) / (7-2) = 300/5 = 60 litros por minuto.', 'intermedia', 65)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Tasa de variación media'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Análisis de gráficos de funciones en contexto"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Al observar el gráfico de una función que representa la distancia recorrida por un ciclista en el tiempo, un tramo horizontal (pendiente 0) indica que:',
   '["El ciclista está detenido", "El ciclista avanza a velocidad constante", "El ciclista retrocede", "El ciclista acelera"]', 0,
   'Una pendiente 0 significa que la distancia no cambia con el tiempo, es decir, el ciclista está detenido.', 'inicial', 50),
  ('En un gráfico de temperatura versus tiempo, un tramo con pendiente negativa indica que la temperatura está:',
   '["Disminuyendo", "Aumentando", "Constante", "Oscilando"]', 0,
   'Una pendiente negativa indica que, a medida que avanza el tiempo, el valor de la función (temperatura) disminuye.', 'intermedia', 55),
  ('Un gráfico de ingresos de una empresa muestra una curva cóncava hacia abajo que luego comienza a decrecer. ¿Qué interpretación cualitativa es razonable?',
   '["Los ingresos crecieron cada vez más lento hasta alcanzar un máximo y luego comenzaron a disminuir", "Los ingresos crecieron todo el tiempo a tasa constante", "Los ingresos fueron siempre decrecientes", "Los ingresos se mantuvieron constantes todo el período"]', 0,
   'Una curva cóncava hacia abajo que luego decrece describe un crecimiento cada vez más lento hasta un máximo, seguido de una caída.', 'intermedia', 70),
  ('Al comparar dos gráficos de funciones que representan las ventas de dos empresas en el tiempo, la que tiene mayor pendiente promedio en un intervalo dado tuvo:',
   '["Un mayor crecimiento promedio de ventas en ese intervalo", "Un menor crecimiento promedio de ventas en ese intervalo", "Las mismas ventas totales", "Ventas constantes"]', 0,
   'Una mayor pendiente promedio (tasa de variación media) indica un mayor crecimiento promedio en ese intervalo.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Análisis de gráficos de funciones en contexto'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Modelamiento con funciones definidas por tramos"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Una empresa de telefonía cobra $10 por minuto hasta 100 minutos, y luego $5 por minuto adicional. Este plan tarifario se modela mejor con:',
   '["Una función definida por tramos", "Una función exponencial simple", "Una función cuadrática", "Una función constante"]', 0,
   'El cambio de tarifa según el rango de minutos consumidos requiere una función a trozos.', 'inicial', 55),
  ('Según el plan tarifario anterior (10 por minuto hasta 100 minutos, luego 5 adicional), ¿cuánto se paga por exactamente 100 minutos?',
   '["$500", "$800", "$1.000", "$1.500"]', 2,
   '100 minutos × $10 = $1.000 (dentro del primer tramo).', 'intermedia', 60),
  ('Siguiendo el mismo plan, ¿cuánto se paga por 110 minutos?',
   '["$1.000", "$1.050", "$1.100", "$1.500"]', 1,
   '100 × 10 + 10 × 5 = 1.000 + 50 = 1.050.', 'intermedia', 65),
  ('Al modelar un impuesto progresivo (donde la tasa aumenta según tramos de ingreso) con una función por tramos, ¿qué característica debe cumplir la función en los puntos donde cambian los tramos, para que el modelo sea razonable económicamente?',
   '["Debe ser continua (sin saltos abruptos en el monto a pagar)", "Debe ser discontinua siempre", "Debe decrecer siempre", "No importa su comportamiento en esos puntos"]', 0,
   'Un modelo tributario razonable evita saltos abruptos en el monto a pagar justo en el límite entre tramos.', 'avanzada', 95)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Modelamiento con funciones definidas por tramos'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Relación entre tasa de variación media y pendiente"
-- ADVERTENCIA (ver también encabezado de este archivo y 0013): objetivo de
-- CONFIANZA BAJA, extensión directa de "Tasa de variación media" -- mismo
-- criterio de cobertura conservadora (solo 3 preguntas, sin entrar en
-- matices de profundidad hacia el concepto de derivada).
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('La tasa de variación media de una función entre dos puntos de su gráfico corresponde geométricamente a:',
   '["La pendiente de la recta secante que une esos dos puntos", "La pendiente de la recta tangente en un punto", "El área bajo la curva entre esos puntos", "La distancia entre los dos puntos"]', 0,
   'La tasa de variación media entre dos puntos del gráfico es exactamente la pendiente de la recta secante que los une.', 'inicial', 55),
  ('Si los puntos A(1,2) y B(4,11) pertenecen al gráfico de una función f, ¿cuál es la pendiente de la recta secante que los une (y por tanto la tasa de variación media de f entre x=1 y x=4)?',
   '["2", "3", "4", "9"]', 1,
   'Pendiente = (11-2)/(4-1) = 9/3 = 3.', 'intermedia', 65),
  ('Si la tasa de variación media de una función en un intervalo es 0, ¿qué se puede afirmar sobre la recta secante en ese intervalo?',
   '["Es una recta horizontal (pendiente 0)", "Es una recta vertical", "No existe la recta secante", "Tiene pendiente indefinida"]', 0,
   'Una tasa de variación media igual a 0 corresponde a una recta secante horizontal.', 'intermedia', 60)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Relación entre tasa de variación media y pendiente'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- ============================================================================
-- EJE: GEOMETRÍA — 4° MEDIO
-- ============================================================================

-- Objetivo: "Cuerpos geométricos y transformaciones en el espacio"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál de los siguientes es un cuerpo geométrico de revolución?',
   '["Cilindro", "Cubo", "Pirámide", "Prisma rectangular"]', 0,
   'El cilindro se genera al rotar un rectángulo alrededor de uno de sus lados; es un cuerpo de revolución.', 'inicial', 50),
  ('Al rotar 360° un rectángulo alrededor de uno de sus lados, se genera un:',
   '["Cilindro", "Cono", "Esfera", "Cubo"]', 0,
   'La rotación completa de un rectángulo alrededor de uno de sus lados genera un cilindro.', 'intermedia', 55),
  ('Si se duplica el radio de una esfera, ¿en qué factor aumenta su volumen?',
   '["2", "4", "8", "16"]', 2,
   'El volumen de la esfera es proporcional al cubo del radio: 2³ = 8.', 'intermedia', 70),
  ('Un cono y un cilindro tienen la misma base circular y la misma altura. ¿Qué relación existe entre sus volúmenes?',
   '["El volumen del cono es un tercio del volumen del cilindro", "Ambos tienen el mismo volumen", "El volumen del cono es el doble del cilindro", "El volumen del cilindro es un tercio del cono"]', 0,
   'Vcono = (1/3) × Vcilindro cuando comparten base y altura.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Cuerpos geométricos y transformaciones en el espacio'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Vectores en problemas geométricos y físicos"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Dos vectores son ortogonales (perpendiculares) si su producto punto (producto escalar) es:',
   '["Cero", "Uno", "Igual a sus magnitudes", "Negativo siempre"]', 0,
   'El producto punto de dos vectores perpendiculares es siempre cero.', 'inicial', 50),
  ('¿Cuál es el producto punto de u=(2,3) y v=(4,-1)?',
   '["5", "8", "-3", "11"]', 0,
   'u·v = 2×4 + 3×(-1) = 8 - 3 = 5.', 'intermedia', 60),
  ('En un problema de física, dos fuerzas vectoriales F1=(3,4) N y F2=(-1,2) N actúan sobre un cuerpo. ¿Cuál es la fuerza resultante?',
   '["(2, 6)", "(2, 2)", "(4, 6)", "(-3, 8)"]', 0,
   'F1+F2 = (3+(-1), 4+2) = (2, 6).', 'intermedia', 65),
  ('Geométricamente, ¿qué representa el uso de vectores para verificar si tres puntos A, B y C son colineales?',
   '["Que los vectores AB y AC sean paralelos (uno múltiplo escalar del otro)", "Que los vectores AB y AC sean perpendiculares", "Que tengan la misma magnitud", "Que formen un triángulo rectángulo"]', 0,
   'Tres puntos son colineales si los vectores que forman entre sí son paralelos, es decir, uno es múltiplo escalar del otro.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Vectores en problemas geométricos y físicos'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Herramientas tecnológicas para lugares geométricos"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Un software de geometría dinámica (como GeoGebra) permite principalmente:',
   '["Representar y explorar de forma interactiva figuras y lugares geométricos", "Solo realizar cálculos aritméticos básicos", "Reemplazar completamente la demostración matemática", "Editar únicamente texto"]', 0,
   'Estos software permiten construir, mover y explorar dinámicamente objetos geométricos.', 'inicial', 50),
  ('Un lugar geométrico es:',
   '["El conjunto de todos los puntos que cumplen una condición dada", "Un único punto fijo en el plano", "Una recta cualquiera", "Un ángulo específico"]', 0,
   'Un lugar geométrico es el conjunto de puntos que satisface una propiedad o condición determinada.', 'intermedia', 55),
  ('Usando herramientas tecnológicas, se puede verificar dinámicamente que la circunferencia es el lugar geométrico de los puntos que:',
   '["Equidistan de un punto fijo llamado centro", "Están a distinta distancia del centro", "Forman un triángulo equilátero", "Son colineales con el centro"]', 0,
   'La circunferencia se define como el conjunto de puntos que equidistan de un punto fijo (el centro).', 'intermedia', 60),
  ('Al usar un deslizador (slider) en un software de geometría dinámica para variar un parámetro de una familia de rectas, se puede observar el lugar geométrico que describen sus:',
   '["Puntos de intersección o envolventes, según el parámetro variado", "Nombres asignados a cada recta", "Colores de cada recta", "Ninguna propiedad relevante"]', 0,
   'Variar dinámicamente un parámetro permite visualizar el lugar geométrico que trazan los puntos de interés de esa familia de rectas.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Herramientas tecnológicas para lugares geométricos'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Aplicaciones de la geometría analítica"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('La ecuación de la recta que pasa por dos puntos se puede obtener usando:',
   '["La pendiente y un punto conocido", "Solo el punto de origen", "El área bajo la recta", "La distancia al eje Y únicamente"]', 0,
   'Con la pendiente calculada a partir de los dos puntos y uno de ellos, se puede escribir la ecuación punto-pendiente.', 'inicial', 50),
  ('¿Cuál es la pendiente de la recta que pasa por los puntos (2,3) y (6,11)?',
   '["1", "2", "4", "8"]', 1,
   'm = (11-3)/(6-2) = 8/4 = 2.', 'intermedia', 60),
  ('¿Cuál es la ecuación de la recta con pendiente 2 que pasa por el punto (1,5)?',
   '["y = 2x + 3", "y = 2x + 5", "y = 2x - 3", "y = x + 3"]', 0,
   'y - 5 = 2(x - 1) → y = 2x - 2 + 5 = 2x + 3.', 'intermedia', 65),
  ('Dos rectas con pendientes m1 y m2 son perpendiculares si:',
   '["m1 · m2 = -1", "m1 = m2", "m1 + m2 = 0", "m1 · m2 = 1"]', 0,
   'Dos rectas son perpendiculares cuando el producto de sus pendientes es -1.', 'avanzada', 85)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Aplicaciones de la geometría analítica'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Proyecciones y sombras"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('El cálculo de la sombra proyectada por un poste en el suelo bajo la luz del sol se puede modelar usando:',
   '["Semejanza de triángulos y razones trigonométricas", "Solo el teorema de Pitágoras", "El área de un círculo", "Progresiones aritméticas"]', 0,
   'La relación entre altura del poste, longitud de la sombra y ángulo de elevación del sol se modela con semejanza de triángulos y trigonometría.', 'inicial', 55),
  ('Un poste de 4 m de altura proyecta una sombra de 6 m. En el mismo instante, un árbol proyecta una sombra de 15 m. Usando semejanza de triángulos, ¿cuál es la altura del árbol?',
   '["8 m", "10 m", "12 m", "20 m"]', 1,
   '4/6 = h/15 → h = (4×15)/6 = 10 m.', 'intermedia', 65),
  ('Si el ángulo de elevación del sol es de 45°, y un objeto mide 5 m de altura, ¿cuánto mide aproximadamente su sombra?',
   '["2,5 m", "5 m", "7,5 m", "10 m"]', 1,
   'Con ángulo de elevación 45°, tan(45°)=1, por lo que la sombra mide lo mismo que la altura: 5 m.', 'intermedia', 70),
  ('Si el ángulo de elevación del sol disminuye durante la tarde, ¿qué ocurre con la longitud de las sombras proyectadas por los objetos?',
   '["Aumentan", "Disminuyen", "Se mantienen iguales", "Desaparecen"]', 0,
   'A menor ángulo de elevación del sol, mayor es la longitud de la sombra proyectada.', 'avanzada', 85)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Proyecciones y sombras'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- ============================================================================
-- EJE: PROBABILIDAD Y ESTADÍSTICA — 4° MEDIO
-- ============================================================================

-- Objetivo: "Estudio estadístico e inferencia"
-- ADVERTENCIA (ver también encabezado de este archivo y 0013): objetivo de
-- CONFIANZA BAJA -- cobertura conservadora (3 preguntas), limitada a las
-- ideas más básicas e inequívocas del proceso de un estudio estadístico
-- (pregunta de investigación, qué es inferir, representatividad de la
-- muestra), sin entrar en técnicas formales de inferencia.
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('El primer paso al diseñar un estudio estadístico para responder una pregunta de interés es:',
   '["Formular claramente la pregunta de investigación", "Calcular la media de los datos", "Elegir el gráfico a usar", "Redactar las conclusiones"]', 0,
   'Todo estudio estadístico parte de una pregunta de investigación clara que orienta el resto del proceso.', 'inicial', 55),
  ('La inferencia estadística consiste en:',
   '["Sacar conclusiones sobre una población a partir de una muestra", "Describir únicamente los datos de la muestra sin generalizar", "Calcular solo la moda de los datos", "Dibujar gráficos sin analizarlos"]', 0,
   'Inferir estadísticamente es generalizar, con cierto nivel de confianza, resultados de una muestra hacia toda la población.', 'intermedia', 65),
  ('Para que las conclusiones de un estudio estadístico sobre una población sean confiables, la muestra utilizada debe ser, principalmente:',
   '["Representativa de la población de interés", "Lo más pequeña posible", "Elegida por conveniencia del investigador", "Compuesta solo por voluntarios"]', 0,
   'Una muestra representativa refleja adecuadamente las características de la población, condición clave para inferir con confianza.', 'intermedia', 65)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Estudio estadístico e inferencia'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Intervalos de confianza"
-- ADVERTENCIA (ver también encabezado de este archivo y 0013): objetivo de
-- CONFIANZA BAJA -- cobertura conservadora (3 preguntas), limitada a la
-- interpretación básica de un intervalo de confianza ya dado, sin entrar en
-- su construcción formal (error estándar, nivel de significancia, etc.).
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Un intervalo de confianza para un parámetro poblacional entrega:',
   '["Un rango de valores plausibles para el parámetro, junto con un nivel de confianza", "Un único valor exacto del parámetro", "La media de la muestra únicamente", "El tamaño de la muestra requerido"]', 0,
   'Un intervalo de confianza es un rango de valores plausibles, asociado a un nivel de confianza (por ejemplo, 95%).', 'inicial', 55),
  ('Si un intervalo de confianza del 95% para la estatura media de un curso es [160 cm, 170 cm], esto se interpreta como:',
   '["Con un 95% de confianza, la media poblacional está entre 160 y 170 cm", "El 95% de los estudiantes miden entre 160 y 170 cm", "Todos los estudiantes miden exactamente 165 cm", "La media de la muestra es siempre 170 cm"]', 0,
   'El intervalo de confianza se refiere a la media poblacional, no a los valores individuales de cada estudiante.', 'intermedia', 70),
  ('Si se aumenta el nivel de confianza de un intervalo (por ejemplo, de 90% a 99%), manteniendo el mismo tamaño de muestra, el intervalo tiende a:',
   '["Ampliarse (ser más ancho)", "Achicarse (ser más angosto)", "Mantenerse igual", "Desaparecer"]', 0,
   'A mayor nivel de confianza exigido, más ancho debe ser el intervalo para mantener esa confianza con la misma muestra.', 'intermedia', 65)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Intervalos de confianza'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Variable aleatoria continua"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('¿Cuál de las siguientes es un ejemplo de variable aleatoria continua?',
   '["El tiempo exacto que demora un corredor en completar una carrera", "El número de hijos de una familia", "El número de caras al lanzar una moneda", "El resultado de un dado"]', 0,
   'El tiempo puede tomar cualquier valor dentro de un intervalo (por ejemplo, 12,347 segundos), lo que la hace continua.', 'inicial', 50),
  ('A diferencia de una variable aleatoria discreta, una variable aleatoria continua puede tomar:',
   '["Cualquier valor dentro de un intervalo de números reales", "Solo valores enteros", "Solo un número finito de valores", "Solo valores positivos"]', 0,
   'Las variables continuas pueden tomar infinitos valores posibles dentro de un intervalo real.', 'intermedia', 55),
  ('Para una variable aleatoria continua, la probabilidad de que tome exactamente un valor puntual (por ejemplo, P(X=5)) es:',
   '["Cero (o prácticamente cero)", "Siempre 1", "Siempre 0,5", "Depende del valor"]', 0,
   'En variables continuas, la probabilidad de un valor puntual exacto es matemáticamente cero; solo tienen sentido las probabilidades sobre intervalos.', 'intermedia', 65),
  ('En una variable aleatoria continua, la probabilidad de que X esté en un intervalo [a,b] se calcula como:',
   '["El área bajo la curva de densidad entre a y b", "La suma de las probabilidades puntuales entre a y b", "El valor de la función de densidad en el punto medio", "La diferencia entre a y b únicamente"]', 0,
   'La probabilidad en un intervalo corresponde al área bajo la función de densidad entre esos dos valores.', 'avanzada', 90)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Variable aleatoria continua'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Muestreo aleatorio y representatividad"
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('El muestreo aleatorio es importante en un estudio estadístico principalmente porque:',
   '["Ayuda a que la muestra sea representativa de la población", "Hace que el estudio sea más rápido de realizar", "Elimina la necesidad de análisis estadístico", "Garantiza que todos los datos sean iguales"]', 0,
   'El muestreo aleatorio reduce el sesgo y favorece que la muestra represente adecuadamente a la población.', 'inicial', 55),
  ('Si una encuesta solo se aplica a personas que asisten a un gimnasio para estudiar hábitos de actividad física de toda la ciudad, esto es un ejemplo de:',
   '["Una muestra sesgada, poco representativa de la población general", "Un muestreo aleatorio adecuado", "Una muestra perfectamente representativa", "Un censo completo"]', 0,
   'Encuestar solo a personas que ya asisten a un gimnasio sobreestima el nivel de actividad física de la población general: es una muestra sesgada.', 'intermedia', 65),
  ('En el muestreo aleatorio simple, cada elemento de la población debe tener:',
   '["La misma probabilidad de ser seleccionado", "Mayor probabilidad si es más accesible", "Probabilidad cero de ser elegido", "Una probabilidad distinta según su opinión"]', 0,
   'El muestreo aleatorio simple exige que todos los elementos de la población tengan igual probabilidad de selección.', 'intermedia', 60),
  ('Aumentar el tamaño de la muestra (manteniendo un muestreo aleatorio adecuado) generalmente:',
   '["Reduce el margen de error de las estimaciones", "Aumenta el sesgo de la muestra", "Elimina por completo la necesidad de inferencia", "No tiene ningún efecto en la precisión"]', 0,
   'Una muestra más grande (bien seleccionada) generalmente reduce el margen de error de las estimaciones.', 'avanzada', 85)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Muestreo aleatorio y representatividad'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );

-- Objetivo: "Errores en la toma de decisiones basada en datos"
-- ADVERTENCIA (ver también encabezado de este archivo y 0013): objetivo de
-- CONFIANZA BAJA, asociado al mismo bloque de inferencia estadística
-- introductoria -- cobertura conservadora (3 preguntas), limitada a errores
-- de interpretación conceptualmente básicos y ampliamente documentados
-- (correlación/causalidad, sesgo de muestra, gráficos engañosos).
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by
)
select
  (select id from public.subjects where name = 'Matemática'),
  (select id from public.levels where code = 'regular_4_medio'),
  null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'unverified', true, 'validapp_original', 'claude-sonnet-5-assessments'
from (values
  ('Un error común en la interpretación de estudios estadísticos es confundir:',
   '["Correlación con causalidad", "La media con la mediana", "Un gráfico de barras con uno circular", "Un dato con una variable"]', 0,
   'Que dos variables estén correlacionadas no implica que una cause a la otra; este es uno de los errores de interpretación más comunes.', 'inicial', 55),
  ('Si una muestra pequeña y no representativa se usa para tomar una decisión importante sobre toda una población, el principal riesgo es:',
   '["Llegar a conclusiones erróneas o poco generalizables", "Que el cálculo sea demasiado lento", "Que se necesiten más gráficos", "Que el resultado sea siempre correcto"]', 0,
   'Una muestra pequeña y sesgada puede llevar a conclusiones que no reflejan la realidad de toda la población.', 'intermedia', 65),
  ('Al presentar datos de forma engañosa (por ejemplo, truncando el eje Y de un gráfico de barras para exagerar diferencias), se puede inducir a:',
   '["Interpretaciones erróneas o decisiones mal fundamentadas", "Una interpretación siempre más precisa", "La eliminación automática del sesgo", "Un análisis estadístico más riguroso"]', 0,
   'Manipular la escala de un gráfico para exagerar diferencias puede llevar a interpretaciones erróneas.', 'intermedia', 65)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select id from public.learning_objectives
  where level_id = (select id from public.levels where code = 'regular_4_medio')
    and short_name = 'Errores en la toma de decisiones basada en datos'
) as lo
where lo.id is not null
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.source_type = 'validapp_original'
      and q2.generated_by = 'claude-sonnet-5-assessments'
  );
