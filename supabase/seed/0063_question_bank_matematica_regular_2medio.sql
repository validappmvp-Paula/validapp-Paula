-- Dominio: Contenido y preguntas
-- Banco de preguntas de selección múltiple para Matemática, Currículum
-- Regular, 2° Medio (D.S. 614/2013), 4 ejes: Números, Álgebra, Geometría,
-- Probabilidad y Estadística. 4 preguntas por cada uno de los 22 objetivos
-- de aprendizaje ya cargados en
-- supabase/seed/0012_curriculum_matematica_regular_7basico_2medio.sql
-- (unit_id + level_id + short_name, NUNCA ids hardcodeados).
--
-- Mismo criterio documentado en supabase/seed/0060 (mismo lote de trabajo):
-- estado editorial `review_status='borrador'`, `validation_status=
-- 'ai_generated_review_required'` (0023), `is_active=true`,
-- `source_type='validapp_original'`, `framework_id` NULL, `content_hash`
-- NULL (limitación explícita documentada en 0060), idempotencia vía
-- `not exists` contra (learning_objective_id, prompt) exacto. Ninguna
-- pregunta de este archivo es visible para un estudiante hasta revisión y
-- aprobación humana.
--
-- Con este archivo se completa el banco de preguntas de selección múltiple
-- para los 88 objetivos de 7° Básico a 2° Medio cargados en 0012 (ver
-- 0060/0061/0062 para 7° Básico, 8° Básico y 1° Medio).
--
-- Seed SOLO local: no se ha ejecutado contra ningún Supabase (ni local ni
-- remoto).

-- ============================================================================
-- EJE: NÚMEROS — 2° MEDIO (6 objetivos x 4 preguntas = 24)
-- ============================================================================
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by, generated_at
)
select
  (select id from public.subjects where name = 'Matemática'),
  lv.id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'claude-sonnet-5 (validapp-assessments)', now()
from (values
  ('Raíces enésimas y potencias de exponente racional', '¿Cuál es el valor de 8^(1/3)?', '["2","8/3","24","4"]', 0, 'Elevar a 1/3 equivale a calcular la raíz cúbica: ∛8 = 2.', 'inicial', 60),
  ('Raíces enésimas y potencias de exponente racional', '¿Cuál es el valor de 16^(3/4)?', '["8","12","64","4"]', 0, '16^(3/4) = (16^(1/4))³ = 2³ = 8.', 'intermedia', 90),
  ('Raíces enésimas y potencias de exponente racional', '¿Cuál es el valor de 27^(2/3)?', '["9","18","3","81"]', 0, '27^(2/3) = (27^(1/3))² = 3² = 9.', 'intermedia', 90),
  ('Raíces enésimas y potencias de exponente racional', 'Expresa √(x⁵) como una potencia de exponente racional.', '["x^(5/2)","x^(2/5)","x^10","5x^(1/2)"]', 0, 'Una raíz cuadrada equivale a elevar a 1/2, y el exponente 5 se multiplica por ese exponente racional: x^(5×1/2) = x^(5/2).', 'avanzada', 120),

  ('Operatoria con números reales', '¿Cuál es el resultado de 3,5 + √4?', '["5,5","5","7","9"]', 0, '√4 = 2, entonces 3,5 + 2 = 5,5.', 'inicial', 60),
  ('Operatoria con números reales', '¿Cuál es el resultado de 2√3 + 5√3?', '["7√3","7√6","10√3","7√9"]', 0, 'Al sumar radicales semejantes (misma cantidad subradical), se suman sus coeficientes: 2√3 + 5√3 = 7√3.', 'intermedia', 90),
  ('Operatoria con números reales', '¿Cuál es el resultado de √8 × √2?', '["4","16","√10","2√10"]', 0, '√8 × √2 = √(8×2) = √16 = 4.', 'intermedia', 90),
  ('Operatoria con números reales', '¿Cuál es el resultado de (√5 + 2)(√5 - 2)?', '["1","5","√5","3"]', 0, 'Es una suma por su diferencia: (√5)² - 2² = 5 - 4 = 1.', 'avanzada', 120),

  ('Aproximaciones con números reales', '¿Cuál es una aproximación de √7 a la centésima más cercana?', '["2,65","2,64","2,60","2,70"]', 0, '√7 ≈ 2,6458, que redondeado a la centésima más cercana es 2,65.', 'inicial', 60),
  ('Aproximaciones con números reales', 'Al aproximar π a dos cifras decimales, ¿cuál es el valor correcto?', '["3,14","3,15","3,1","3,142"]', 0, 'π ≈ 3,14159..., que redondeado a dos decimales es 3,14.', 'intermedia', 90),
  ('Aproximaciones con números reales', '¿Cuál es el error absoluto al aproximar √2 (≈1,41421) como 1,414?', '["0,00021","0,0021","0,021","0,21"]', 0, 'El error absoluto es la diferencia entre el valor real y el aproximado: |1,41421 - 1,414| = 0,00021.', 'intermedia', 90),
  ('Aproximaciones con números reales', 'Se mide un terreno y se obtiene 45,678 m, pero el instrumento solo tiene precisión de una décima. ¿Cuál es la medida correctamente aproximada?', '["45,7 m","45,68 m","45,6 m","46 m"]', 0, 'Redondeando 45,678 a la décima más cercana: el dígito de la centésima (7) redondea hacia arriba, dando 45,7 m.', 'avanzada', 120),

  ('Racionalización de expresiones con raíces', '¿Cuál es la racionalización de 1/√2?', '["√2/2","1/2","√2","2/√2"]', 0, 'Multiplicando numerador y denominador por √2: (1×√2)/(√2×√2) = √2/2.', 'inicial', 60),
  ('Racionalización de expresiones con raíces', '¿Cuál es la racionalización de 3/√5?', '["3√5/5","3/5","√5/3","3√5"]', 0, 'Multiplicando por √5/√5: (3×√5)/(√5×√5) = 3√5/5.', 'intermedia', 90),
  ('Racionalización de expresiones con raíces', '¿Cuál es la racionalización de 2/(3√2)?', '["√2/3","√2/6","2/3","2√2/3"]', 0, 'Multiplicando por √2/√2: (2√2)/(3×2) = 2√2/6, que simplificado es √2/3.', 'intermedia', 90),
  ('Racionalización de expresiones con raíces', 'Racionaliza la expresión 1/(√5 - 2) multiplicando por el conjugado del denominador.', '["√5 + 2","√5 - 2","5 + 2","1/(√5+2)"]', 0, 'Multiplicando por (√5+2)/(√5+2): el denominador queda (√5)² - 2² = 5 - 4 = 1, y el numerador queda √5 + 2, por lo que el resultado es √5 + 2.', 'avanzada', 120),

  ('Intervalos numéricos', '¿Cómo se representa el intervalo que incluye todos los números entre 2 y 7, incluidos ambos extremos?', '["[2, 7]","(2, 7)","[2, 7)","(2, 7]"]', 0, 'Los corchetes [ ] indican que los extremos están incluidos en el intervalo.', 'inicial', 60),
  ('Intervalos numéricos', '¿Qué números pertenecen al intervalo (-3, 5]?', '["Todos los números mayores que -3 y menores o iguales a 5","Todos los números mayores o iguales a -3 y menores que 5","Solo -3 y 5","Todos los números entre -3 y 5, sin incluir ninguno"]', 0, 'El paréntesis en -3 indica que no se incluye, y el corchete en 5 indica que sí se incluye.', 'intermedia', 90),
  ('Intervalos numéricos', '¿Cuál es la intersección entre los intervalos [1, 6] y [4, 9]?', '["[4, 6]","[1, 9]","[1, 4]","[6, 9]"]', 0, 'La intersección son los valores que pertenecen a ambos intervalos a la vez: entre 4 y 6.', 'intermedia', 90),
  ('Intervalos numéricos', '¿Cuál es la unión entre los intervalos (-∞, 3) y [3, ∞)?', '["Todos los números reales (-∞, ∞)","Solo el número 3","El conjunto vacío","(-∞, 3) únicamente"]', 0, 'Juntando ambos intervalos se cubren todos los números reales, ya que uno incluye el 3 y el otro todos los valores menores.', 'avanzada', 120),

  ('Logaritmos como herramienta de cálculo', '¿Cuál es el valor de log₁₀(100)?', '["2","10","100","1"]', 0, 'log₁₀(100) pregunta a qué exponente hay que elevar 10 para obtener 100: 10² = 100, por lo tanto el logaritmo es 2.', 'inicial', 60),
  ('Logaritmos como herramienta de cálculo', '¿Cuál es el valor de log₂(8)?', '["3","4","2","8"]', 0, '2³ = 8, por lo tanto log₂(8) = 3.', 'intermedia', 90),
  ('Logaritmos como herramienta de cálculo', 'Si log₁₀(x) = 3, ¿cuál es el valor de x?', '["1.000","30","3.000","300"]', 0, 'Por definición de logaritmo: x = 10³ = 1.000.', 'intermedia', 90),
  ('Logaritmos como herramienta de cálculo', 'Una población de bacterias se multiplica por 10 cada cierto período. Para saber cuántos períodos deben pasar para que la población se multiplique por 1.000, ¿qué operación permite calcularlo directamente?', '["Calcular log₁₀(1.000)","Calcular 10^1.000","Dividir 1.000 por 10","Calcular √1.000"]', 0, 'El logaritmo responde directamente a la pregunta "¿a qué exponente hay que elevar 10 para obtener 1.000?", que es exactamente el número de períodos buscado.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Números')
      and name = 'Números — 2° Medio'
  )
cross join (select id from public.levels where code = 'regular_2_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: ÁLGEBRA — 2° MEDIO (6 objetivos x 4 preguntas = 24)
-- ============================================================================
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by, generated_at
)
select
  (select id from public.subjects where name = 'Matemática'),
  lv.id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'claude-sonnet-5 (validapp-assessments)', now()
from (values
  ('Ecuaciones cuadráticas', '¿Cuáles son las soluciones de la ecuación x² - 9 = 0?', '["x = 3 y x = -3","x = 9 y x = -9","x = 3 solamente","x = 81"]', 0, 'Despejando: x² = 9, por lo tanto x = ±3.', 'inicial', 60),
  ('Ecuaciones cuadráticas', '¿Cuáles son las soluciones de x² - 5x + 6 = 0, factorizando la expresión?', '["x = 2 y x = 3","x = -2 y x = -3","x = 1 y x = 6","x = 5 y x = 6"]', 0, 'Factorizando: (x - 2)(x - 3) = 0, por lo tanto x = 2 o x = 3.', 'intermedia', 90),
  ('Ecuaciones cuadráticas', 'Usando la fórmula general, ¿cuáles son las soluciones de x² + 2x - 8 = 0?', '["x = 2 y x = -4","x = -2 y x = 4","x = 8 y x = -1","x = 1 y x = -8"]', 0, 'El discriminante es 2² - 4(1)(-8) = 4 + 32 = 36. Las soluciones son x = (-2 ± 6)/2, es decir, x = 2 o x = -4.', 'intermedia', 90),
  ('Ecuaciones cuadráticas', 'El área de un rectángulo es 60 cm² y su largo es 4 cm más que su ancho. ¿Cuál es el ancho del rectángulo?', '["6 cm","10 cm","15 cm","4 cm"]', 0, 'Planteando a(a+4) = 60, se obtiene a² + 4a - 60 = 0, que factorizado es (a+10)(a-6) = 0. Como el ancho debe ser positivo, a = 6 cm.', 'avanzada', 120),

  ('Función cuadrática', '¿Cuál es el vértice de la parábola y = x²?', '["(0, 0)","(1, 1)","(-1, 0)","(0, 1)"]', 0, 'La parábola más simple y = x² tiene su vértice en el origen (0, 0).', 'inicial', 60),
  ('Función cuadrática', '¿Hacia dónde se abre la parábola y = -2x² + 3?', '["Hacia abajo","Hacia arriba","Hacia la derecha","Hacia la izquierda"]', 0, 'Cuando el coeficiente del término cuadrático es negativo, la parábola se abre hacia abajo.', 'intermedia', 90),
  ('Función cuadrática', '¿Cuál es el eje de simetría de la parábola y = x² - 4x + 3?', '["x = 2","x = -2","x = 4","x = 1"]', 0, 'El eje de simetría se calcula con x = -b/(2a) = -(-4)/(2×1) = 2.', 'intermedia', 90),
  ('Función cuadrática', '¿Cuáles son las coordenadas del vértice de la parábola y = x² - 4x + 3?', '["(2, -1)","(2, 1)","(-2, -1)","(4, 3)"]', 0, 'El eje de simetría es x = 2. Reemplazando: y = 2² - 4(2) + 3 = 4 - 8 + 3 = -1. El vértice es (2, -1).', 'avanzada', 120),

  ('Sistemas de inecuaciones lineales', '¿Cuál es el conjunto solución del sistema x > 2, x < 7?', '["2 < x < 7","x > 2 o x < 7","x < 2","x > 7"]', 0, 'La solución del sistema es la intersección de ambas condiciones: los valores que son mayores que 2 y a la vez menores que 7.', 'inicial', 60),
  ('Sistemas de inecuaciones lineales', '¿Cuál es la solución del sistema x ≥ -1, x ≤ 4?', '["-1 ≤ x ≤ 4","x ≥ -1 o x ≤ 4 por separado, sin intersección","x < -1","x > 4"]', 0, 'Un sistema de inecuaciones exige que se cumplan ambas condiciones a la vez (intersección), no una u otra por separado: -1 ≤ x ≤ 4.', 'intermedia', 90),
  ('Sistemas de inecuaciones lineales', 'Al resolver el sistema 2x - 1 > 3 y x + 2 < 8, ¿cuál es el conjunto solución?', '["2 < x < 6","x > 2","x < 6","x > 6"]', 0, 'La primera inecuación da x > 2 y la segunda da x < 6. La intersección de ambas es 2 < x < 6.', 'intermedia', 90),
  ('Sistemas de inecuaciones lineales', 'Un sistema de inecuaciones da como resultado x > 5 y x < 3 simultáneamente. ¿Qué se puede concluir sobre el conjunto solución?', '["El conjunto solución es vacío, no existe ningún x que cumpla ambas condiciones","El conjunto solución es todos los números reales","El conjunto solución es x = 4","El conjunto solución es 3 < x < 5"]', 0, 'No existe ningún número que sea simultáneamente mayor que 5 y menor que 3, por lo que la intersección es el conjunto vacío.', 'avanzada', 120),

  ('Discriminante y naturaleza de las raíces', '¿Cuál es el discriminante de la ecuación x² + 2x + 1 = 0?', '["0","4","-4","8"]', 0, 'El discriminante es b² - 4ac = 2² - 4(1)(1) = 4 - 4 = 0.', 'inicial', 60),
  ('Discriminante y naturaleza de las raíces', 'Si el discriminante de una ecuación cuadrática es positivo, ¿qué se puede afirmar sobre sus raíces?', '["Tiene dos raíces reales distintas","Tiene una raíz real doble","No tiene raíces reales","Tiene raíces complejas conjugadas"]', 0, 'Un discriminante positivo indica que la ecuación tiene dos soluciones reales distintas.', 'intermedia', 90),
  ('Discriminante y naturaleza de las raíces', '¿Cuál es el discriminante de x² + x + 1 = 0, y qué indica sobre sus raíces?', '["-3; no tiene raíces reales","-3; tiene dos raíces reales distintas","3; tiene una raíz doble","1; tiene raíces reales"]', 0, 'El discriminante es 1² - 4(1)(1) = 1 - 4 = -3. Al ser negativo, la ecuación no tiene raíces reales.', 'intermedia', 90),
  ('Discriminante y naturaleza de las raíces', 'Para la ecuación 2x² - 4x + k = 0, ¿qué valor de k hace que el discriminante sea igual a 0 (raíz doble)?', '["2","4","0","8"]', 0, 'El discriminante es (-4)² - 4(2)(k) = 16 - 8k. Igualando a 0: 16 - 8k = 0, por lo tanto k = 2.', 'avanzada', 120),

  ('Modelamiento con función cuadrática', 'La altura de una pelota lanzada al aire se modela con h(t) = -5t² + 20t. ¿Cuál es la altura al momento t = 0?', '["0","20","5","25"]', 0, 'Reemplazando t = 0: h(0) = -5(0)² + 20(0) = 0.', 'inicial', 60),
  ('Modelamiento con función cuadrática', 'Usando h(t) = -5t² + 20t, ¿en qué instante la pelota vuelve a tocar el suelo (h = 0, con t > 0)?', '["4 segundos","2 segundos","5 segundos","20 segundos"]', 0, 'Factorizando: -5t² + 20t = t(-5t + 20) = 0. Las soluciones son t = 0 (el lanzamiento) y t = 4 (cuando vuelve a tocar el suelo).', 'intermedia', 90),
  ('Modelamiento con función cuadrática', '¿En qué instante la pelota modelada por h(t) = -5t² + 20t alcanza su altura máxima?', '["2 segundos","4 segundos","5 segundos","10 segundos"]', 0, 'El instante de altura máxima corresponde al vértice de la parábola: t = -b/(2a) = -20/(2×(-5)) = 2 segundos.', 'intermedia', 90),
  ('Modelamiento con función cuadrática', '¿Cuál es la altura máxima que alcanza la pelota modelada por h(t) = -5t² + 20t?', '["20 m","10 m","40 m","25 m"]', 0, 'La altura máxima ocurre en t = 2: h(2) = -5(4) + 20(2) = -20 + 40 = 20 m.', 'avanzada', 120),

  ('Sistemas de ecuaciones lineales y cuadráticas', '¿Cuántas soluciones puede tener, como máximo, un sistema formado por una recta y una parábola?', '["2","1","3","4"]', 0, 'Geométricamente, una recta puede cortar a una parábola en, a lo más, dos puntos distintos.', 'inicial', 60),
  ('Sistemas de ecuaciones lineales y cuadráticas', 'Resuelve el sistema y = x², y = 4. ¿Cuáles son los valores de x?', '["x = 2 y x = -2","x = 4 y x = -4","x = 2 solamente","x = 16"]', 0, 'Igualando: x² = 4, por lo tanto x = 2 o x = -2.', 'intermedia', 90),
  ('Sistemas de ecuaciones lineales y cuadráticas', 'Resuelve el sistema y = x² - 1, y = x + 1. ¿Cuáles son los valores de x?', '["x = 2 y x = -1","x = -2 y x = 1","x = 1 y x = -1","x = 2 y x = 1"]', 0, 'Igualando: x² - 1 = x + 1, es decir, x² - x - 2 = 0. Factorizando: (x-2)(x+1) = 0, por lo tanto x = 2 o x = -1.', 'intermedia', 90),
  ('Sistemas de ecuaciones lineales y cuadráticas', 'El sistema y = x² + 2x + 5, y = 2x + 1 no tiene solución real. ¿Qué indica esto geométricamente?', '["La parábola y la recta no se intersectan en ningún punto real","La parábola y la recta son tangentes en un punto","La parábola y la recta se intersectan en dos puntos","La recta pasa por el vértice de la parábola"]', 0, 'Igualando ambas ecuaciones se obtiene x² + 4 = 0, que no tiene solución real, lo que significa que la recta y la parábola nunca se cruzan.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Álgebra')
      and name = 'Álgebra — 2° Medio'
  )
cross join (select id from public.levels where code = 'regular_2_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: GEOMETRÍA — 2° MEDIO (5 objetivos x 4 preguntas = 20)
-- ============================================================================
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by, generated_at
)
select
  (select id from public.subjects where name = 'Matemática'),
  lv.id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'claude-sonnet-5 (validapp-assessments)', now()
from (values
  ('Razones trigonométricas', 'En un triángulo rectángulo con un ángulo de 30°, ¿cuál es el valor del seno de 30°?', '["0,5","0,87","0,58","1"]', 0, 'El seno de 30° es un valor notable de la trigonometría: sen(30°) = 0,5.', 'inicial', 60),
  ('Razones trigonométricas', 'Un triángulo rectángulo tiene un ángulo de 45°. Si el cateto opuesto mide 5 cm, ¿cuánto mide aproximadamente la hipotenusa? (sen 45° ≈ 0,71)', '["Aproximadamente 7 cm","Aproximadamente 5 cm","Aproximadamente 3,5 cm","Aproximadamente 10 cm"]', 0, 'Seno = cateto opuesto / hipotenusa, entonces hipotenusa = 5 / 0,71 ≈ 7 cm.', 'intermedia', 90),
  ('Razones trigonométricas', 'Si tan(θ) = 3/4 en un triángulo rectángulo, ¿cuál es el valor de sen(θ)? (usa el triángulo 3-4-5)', '["3/5","4/5","3/4","4/3"]', 0, 'Si los catetos son 3 y 4, la hipotenusa es 5 (triángulo 3-4-5). Entonces sen(θ) = cateto opuesto/hipotenusa = 3/5.', 'intermedia', 90),
  ('Razones trigonométricas', 'Desde la base de un cerro, un excursionista camina 200 m en línea recta hasta la cima, con un ángulo de inclinación de 30°. ¿Cuál es la altura aproximada del cerro? (sen 30° = 0,5)', '["100 m","173,2 m","141,4 m","200 m"]', 0, 'La altura es el cateto opuesto al ángulo de inclinación: altura = 200 × sen(30°) = 200 × 0,5 = 100 m.', 'avanzada', 120),

  ('Teorema de Pitágoras y sus recíprocos', 'Los catetos de un triángulo rectángulo miden 9 cm y 12 cm. ¿Cuánto mide la hipotenusa?', '["15 cm","21 cm","10,5 cm","144 cm"]', 0, 'Por el teorema de Pitágoras: hipotenusa² = 9² + 12² = 81 + 144 = 225, por lo que la hipotenusa mide 15 cm.', 'inicial', 60),
  ('Teorema de Pitágoras y sus recíprocos', '¿El triángulo con lados 7, 24 y 25 cm es rectángulo? Usa el recíproco del teorema de Pitágoras para verificarlo.', '["Sí, porque 7² + 24² = 25²","No, porque 7 + 24 ≠ 25","Sí, porque los tres lados son distintos","No, porque 25 es muy grande"]', 0, '7² + 24² = 49 + 576 = 625 = 25², por lo tanto, según el recíproco del teorema de Pitágoras, el triángulo es rectángulo.', 'intermedia', 90),
  ('Teorema de Pitágoras y sus recíprocos', 'Un triángulo tiene lados 5, 6 y 8 cm. Usando el recíproco del teorema de Pitágoras, ¿qué se puede afirmar de este triángulo?', '["Es un triángulo obtusángulo, no rectángulo","Es un triángulo rectángulo","Es un triángulo acutángulo","No se puede determinar"]', 0, '5² + 6² = 25 + 36 = 61, que es menor que 8² = 64. Cuando la suma de los cuadrados de los lados menores es menor que el cuadrado del lado mayor, el triángulo es obtusángulo.', 'intermedia', 90),
  ('Teorema de Pitágoras y sus recíprocos', 'Una escalera de 5 m se apoya en una pared llegando a una altura de 4 m. Si se aleja la base hasta quedar a 4 m de la pared, y la escalera sigue teniendo 5 m, ¿a qué altura llegará ahora?', '["3 m","4 m","4,5 m","2 m"]', 0, 'Por el teorema de Pitágoras: altura² = 5² - 4² = 25 - 16 = 9, por lo que la altura es 3 m.', 'avanzada', 120),

  ('Cuerpos geométricos compuestos', 'Un cuerpo geométrico compuesto está formado, por ejemplo, por:', '["Un cilindro con un cono en su parte superior","Solo un cubo","Solo una esfera","Un cuerpo sin ninguna base"]', 0, 'Un cuerpo compuesto combina dos o más cuerpos geométricos simples, como un cilindro con un cono encima.', 'inicial', 60),
  ('Cuerpos geométricos compuestos', 'Un sólido está formado por un cilindro de volumen 200 cm³ y una semiesfera de volumen 50 cm³ en uno de sus extremos. ¿Cuál es el volumen total del sólido?', '["250 cm³","150 cm³","200 cm³","100 cm³"]', 0, 'El volumen total de un cuerpo compuesto es la suma de los volúmenes de sus partes: 200 + 50 = 250 cm³.', 'intermedia', 90),
  ('Cuerpos geométricos compuestos', 'Para calcular el volumen de un cuerpo compuesto por un cubo y una pirámide sobre una de sus caras, ¿qué se debe hacer?', '["Sumar el volumen del cubo y el volumen de la pirámide","Multiplicar ambos volúmenes","Restar el volumen de la pirámide al del cubo","Calcular solo el volumen del cubo"]', 0, 'El volumen de un cuerpo compuesto formado por partes unidas (no superpuestas) se obtiene sumando el volumen de cada parte.', 'intermedia', 90),
  ('Cuerpos geométricos compuestos', 'Un silo de almacenamiento está formado por un cilindro de 3 m de radio y 10 m de altura, coronado por un cono de la misma base y 2 m de altura. Usando π ≈ 3,14, ¿cuál es el volumen total aproximado?', '["301,44 m³","282,6 m³","320,28 m³","264 m³"]', 0, 'Volumen del cilindro: 3,14 × 9 × 10 = 282,6 m³. Volumen del cono: (1/3) × 3,14 × 9 × 2 = 18,84 m³. Sumando: 282,6 + 18,84 = 301,44 m³.', 'avanzada', 120),

  ('Vectores en el plano cartesiano', '¿Cuál es el resultado de sumar los vectores (4, -2) y (1, 5)?', '["(5, 3)","(3, 5)","(4, 3)","(5, -7)"]', 0, 'Se suman componente a componente: (4+1, -2+5) = (5, 3).', 'inicial', 60),
  ('Vectores en el plano cartesiano', '¿Cuál es el resultado de restar los vectores (6, 2) - (3, 5)?', '["(3, -3)","(9, 7)","(3, 3)","(-3, 3)"]', 0, 'Se restan componente a componente: (6-3, 2-5) = (3, -3).', 'intermedia', 90),
  ('Vectores en el plano cartesiano', 'Si el vector v = (4, 3) se multiplica por el escalar 2, ¿cuál es el vector resultante y su magnitud?', '["(8, 6), con magnitud 10","(8, 6), con magnitud 5","(6, 8), con magnitud 10","(4, 3), con magnitud 10"]', 0, 'Multiplicando cada componente por 2: (8, 6). Su magnitud es √(8²+6²) = √100 = 10.', 'intermedia', 90),
  ('Vectores en el plano cartesiano', 'Dados los vectores u = (2, 5) y w = (-3, 1), ¿cuál es el resultado de 2u - w?', '["(7, 9)","(1, 11)","(7, 11)","(-1, 9)"]', 0, '2u = (4, 10). Restando w: (4-(-3), 10-1) = (7, 9).', 'avanzada', 120),

  ('Ángulos de elevación y depresión', '¿Cómo se define el ángulo de elevación?', '["El ángulo formado entre la horizontal y la línea de visión hacia un objeto más alto","El ángulo formado entre dos objetos cualquiera","El ángulo formado entre la vertical y el suelo","El ángulo formado entre dos líneas horizontales"]', 0, 'El ángulo de elevación se mide desde la horizontal del observador hacia arriba, en dirección a un objeto más alto que él.', 'inicial', 60),
  ('Ángulos de elevación y depresión', 'Desde un punto a 50 m de la base de una torre, la tangente del ángulo de elevación hacia la punta de la torre es 0,8. ¿Cuál es la altura de la torre?', '["40 m","62,5 m","50,8 m","45 m"]', 0, 'Tangente = altura / distancia horizontal, entonces altura = 0,8 × 50 = 40 m.', 'intermedia', 90),
  ('Ángulos de elevación y depresión', 'Desde lo alto de un faro de 30 m de altura, la tangente del ángulo de depresión hacia un bote es 0,6. ¿A qué distancia horizontal está el bote del faro?', '["50 m","18 m","30,6 m","36 m"]', 0, 'Tangente = altura / distancia horizontal, entonces distancia = 30 / 0,6 = 50 m.', 'intermedia', 90),
  ('Ángulos de elevación y depresión', 'Un dron vuela a 80 m de altura. Observa un punto en el suelo con un ángulo de depresión cuya tangente es 0,4. ¿A qué distancia horizontal del punto bajo el dron se encuentra ese punto?', '["200 m","32 m","80,4 m","120 m"]', 0, 'Tangente = altura / distancia horizontal, entonces distancia = 80 / 0,4 = 200 m.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Geometría')
      and name = 'Geometría — 2° Medio'
  )
cross join (select id from public.levels where code = 'regular_2_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: PROBABILIDAD Y ESTADÍSTICA — 2° MEDIO (5 objetivos x 4 preguntas = 20)
-- ============================================================================
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by, generated_at
)
select
  (select id from public.subjects where name = 'Matemática'),
  lv.id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'claude-sonnet-5 (validapp-assessments)', now()
from (values
  ('Medidas de dispersión', '¿Cuál es el rango de los datos 4, 8, 15, 2, 10?', '["13","15","2","10"]', 0, 'El rango es la diferencia entre el dato mayor y el menor: 15 - 2 = 13.', 'inicial', 60),
  ('Medidas de dispersión', 'Dos cursos tienen el mismo promedio en una prueba, pero el curso A tiene una desviación estándar más alta que el curso B. ¿Qué significa esto?', '["Las notas del curso A están más dispersas (más variables) que las del curso B","El curso A tiene mejores notas que el curso B","El curso B tiene más estudiantes","No hay ninguna diferencia real entre los cursos"]', 0, 'Una desviación estándar más alta indica mayor variabilidad de los datos respecto a la media, es decir, notas más dispersas.', 'intermedia', 90),
  ('Medidas de dispersión', '¿Qué mide la varianza de un conjunto de datos?', '["El promedio de las distancias al cuadrado entre cada dato y la media","El valor máximo del conjunto de datos","La diferencia entre el mayor y el menor dato","La mediana del conjunto de datos"]', 0, 'La varianza se calcula promediando el cuadrado de las diferencias entre cada dato y la media del conjunto.', 'intermedia', 90),
  ('Medidas de dispersión', 'Un conjunto de datos tiene media 20 y desviación estándar 4. ¿Qué rango de valores corresponde aproximadamente a "media ± 1 desviación estándar"?', '["Entre 16 y 24","Entre 12 y 28","Entre 18 y 22","Entre 20 y 24"]', 0, 'Media ± 1 desviación estándar es 20 - 4 = 16 hasta 20 + 4 = 24.', 'avanzada', 120),

  ('Probabilidad condicional', '¿Qué representa P(A|B), la probabilidad condicional de A dado B?', '["La probabilidad de que ocurra A, sabiendo que ya ocurrió B","La probabilidad de que ocurran A y B al mismo tiempo","La probabilidad de que no ocurra ni A ni B","La probabilidad de B sin importar A"]', 0, 'La probabilidad condicional P(A|B) mide la probabilidad de A considerando que B ya ocurrió.', 'inicial', 60),
  ('Probabilidad condicional', 'En una bolsa hay 4 bolitas rojas y 6 azules. Se saca una bolita roja y NO se repone. ¿Cuál es la probabilidad de sacar una segunda bolita roja?', '["3/9","4/9","4/10","3/10"]', 0, 'Después de sacar una bolita roja sin reponerla, quedan 3 rojas de un total de 9 bolitas: 3/9.', 'intermedia', 90),
  ('Probabilidad condicional', 'Si P(A y B) = 0,2 y P(B) = 0,5, ¿cuál es el valor de P(A|B)?', '["0,4","0,1","2,5","0,7"]', 0, 'P(A|B) = P(A y B) / P(B) = 0,2 / 0,5 = 0,4.', 'intermedia', 90),
  ('Probabilidad condicional', 'En un curso, el 60% de los estudiantes aprobó Matemática y el 40% aprobó ambas asignaturas (Matemática y Lenguaje). ¿Cuál es la probabilidad de que un estudiante haya aprobado Lenguaje, dado que aprobó Matemática?', '["Aproximadamente 0,67","0,4","0,6","0,24"]', 0, 'P(Lenguaje|Matemática) = P(ambas) / P(Matemática) = 0,4 / 0,6 ≈ 0,67.', 'avanzada', 120),

  ('Permutaciones y combinaciones', '¿De cuántas formas distintas se pueden ordenar 4 libros diferentes en un estante?', '["24","16","4","12"]', 0, 'El número de ordenamientos posibles de 4 elementos distintos es 4! = 4×3×2×1 = 24.', 'inicial', 60),
  ('Permutaciones y combinaciones', '¿Cuántos grupos distintos de 2 personas se pueden formar a partir de un grupo de 5 personas (sin importar el orden)?', '["10","20","5","25"]', 0, 'Es una combinación: C(5,2) = 5!/(2!×3!) = 10.', 'intermedia', 90),
  ('Permutaciones y combinaciones', '¿Cuántas formas hay de elegir un presidente y un secretario (cargos distintos) de un grupo de 6 personas?', '["30","15","36","12"]', 0, 'Como los cargos son distintos, el orden importa: es una permutación. P(6,2) = 6×5 = 30.', 'intermedia', 90),
  ('Permutaciones y combinaciones', '¿Cuántas combinaciones de 3 números se pueden formar a partir de los dígitos 1 al 7, sin repetir y sin importar el orden?', '["35","210","21","49"]', 0, 'Es una combinación: C(7,3) = 7!/(3!×4!) = 35.', 'avanzada', 120),

  ('Variable aleatoria discreta y su distribución', '¿Qué debe cumplir la suma de todas las probabilidades en la distribución de una variable aleatoria discreta?', '["Debe ser igual a 1","Debe ser igual a 0","Debe ser mayor que 1","Puede ser cualquier valor"]', 0, 'La suma de todas las probabilidades de los posibles valores de una variable aleatoria siempre debe ser igual a 1.', 'inicial', 60),
  ('Variable aleatoria discreta y su distribución', 'Una variable aleatoria X tiene distribución P(X=1)=0,3; P(X=2)=0,5; P(X=3)=k. ¿Cuál es el valor de k?', '["0,2","0,3","0,5","0,8"]', 0, 'Como la suma de probabilidades debe ser 1: k = 1 - 0,3 - 0,5 = 0,2.', 'intermedia', 90),
  ('Variable aleatoria discreta y su distribución', 'Para la variable X con P(X=1)=0,3; P(X=2)=0,5; P(X=3)=0,2, ¿cuál es el valor esperado E(X)?', '["1,9","2,0","1,5","2,3"]', 0, 'E(X) = 1(0,3) + 2(0,5) + 3(0,2) = 0,3 + 1,0 + 0,6 = 1,9.', 'intermedia', 90),
  ('Variable aleatoria discreta y su distribución', 'Un juego de azar paga $1.000 con probabilidad 0,1 y $0 con probabilidad 0,9. ¿Cuál es la ganancia esperada de este juego?', '["$100","$1.000","$900","$0"]', 0, 'La ganancia esperada es 1.000×0,1 + 0×0,9 = $100.', 'avanzada', 120),

  ('Independencia de eventos', '¿Qué significa que dos eventos A y B sean independientes?', '["Que la ocurrencia de uno no afecta la probabilidad del otro","Que ambos eventos nunca pueden ocurrir juntos","Que ambos eventos son iguales","Que uno de los eventos es imposible"]', 0, 'Dos eventos son independientes cuando el hecho de que ocurra uno no cambia la probabilidad de que ocurra el otro.', 'inicial', 60),
  ('Independencia de eventos', 'Si P(A) = 0,4 y P(B) = 0,5, y A y B son independientes, ¿cuál es P(A y B)?', '["0,2","0,9","0,1","0,45"]', 0, 'Para eventos independientes, P(A y B) = P(A) × P(B) = 0,4 × 0,5 = 0,2.', 'intermedia', 90),
  ('Independencia de eventos', 'Se lanza un dado y una moneda. ¿Son independientes los eventos "obtener un 6 en el dado" y "obtener cara en la moneda"?', '["Sí, porque el resultado de uno no afecta al del otro","No, porque ambos ocurren al mismo tiempo","No, porque son parte del mismo experimento","Sí, pero solo si se lanzan en el mismo orden"]', 0, 'El resultado del dado no influye en el resultado de la moneda ni viceversa, por lo que son eventos independientes.', 'intermedia', 90),
  ('Independencia de eventos', 'Se sabe que P(A) = 0,3, P(B) = 0,6 y P(A y B) = 0,25. ¿Son A y B eventos independientes?', '["No, porque 0,3 × 0,6 = 0,18 ≠ 0,25","Sí, porque ambas probabilidades son distintas de 0","Sí, porque P(A y B) es menor que P(A) y P(B)","No se puede determinar con esta información"]', 0, 'Para que A y B fueran independientes, debería cumplirse que P(A y B) = P(A) × P(B) = 0,18, pero el valor dado es 0,25, por lo que no son independientes.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Probabilidad y Estadística')
      and name = 'Probabilidad y Estadística — 2° Medio'
  )
cross join (select id from public.levels where code = 'regular_2_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );
