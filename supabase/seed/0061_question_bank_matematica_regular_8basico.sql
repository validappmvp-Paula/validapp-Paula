-- Dominio: Contenido y preguntas
-- Banco de preguntas de selección múltiple para Matemática, Currículum
-- Regular, 8° Básico (D.S. 614/2013), 4 ejes: Números, Álgebra, Geometría,
-- Probabilidad y Estadística. 4 preguntas por cada uno de los 22 objetivos
-- de aprendizaje ya cargados en
-- supabase/seed/0012_curriculum_matematica_regular_7basico_2medio.sql
-- (unit_id + level_id + short_name, NUNCA ids hardcodeados).
--
-- Mismo criterio documentado en supabase/seed/0060 (mismo lote de trabajo):
-- estado editorial `review_status='borrador'`, `validation_status=
-- 'ai_generated_review_required'` (0023), `is_active=true`,
-- `source_type='validapp_original'`, `framework_id` NULL (Currículum Regular
-- no usa `curriculum_frameworks`), `content_hash` NULL (limitación explícita
-- documentada en 0060 -- no se replica en SQL puro el algoritmo TypeScript
-- de `computeContentHash`), idempotencia vía `not exists` contra
-- (learning_objective_id, prompt) exacto. Ninguna pregunta de este archivo
-- es visible para un estudiante hasta revisión y aprobación humana (ver
-- filtro `reviewStatus === 'aprobado'` en `lib/data/essay-selection.ts`).
--
-- Seed SOLO local: no se ha ejecutado contra ningún Supabase (ni local ni
-- remoto).

-- ============================================================================
-- EJE: NÚMEROS — 8° BÁSICO (6 objetivos x 4 preguntas = 24)
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
  ('Potencias de base racional y exponente entero', '¿Cuál es el valor de (1/2)³?', '["1/8","3/2","1/6","1/9"]', 0, '(1/2)³ = (1×1×1)/(2×2×2) = 1/8.', 'inicial', 60),
  ('Potencias de base racional y exponente entero', '¿Cuál es el valor de la potencia con exponente negativo 2⁻³?', '["1/8","-8","-6","8"]', 0, 'Un exponente negativo invierte la base: 2⁻³ = 1/2³ = 1/8.', 'intermedia', 90),
  ('Potencias de base racional y exponente entero', '¿Cuál es el valor de (3/4)⁻¹?', '["4/3","-4/3","3/4","-3/4"]', 0, 'El exponente -1 invierte la fracción: (3/4)⁻¹ = 4/3.', 'intermedia', 90),
  ('Potencias de base racional y exponente entero', '¿Cuál es el resultado de (2/5)⁻² × (5/2)?', '["125/8","25/10","4/25","8/125"]', 0, '(2/5)⁻² = (5/2)² = 25/4. Multiplicando: 25/4 × 5/2 = 125/8.', 'avanzada', 120),

  ('Raíces cuadradas y cúbicas', '¿Cuál es el valor de √81?', '["9","81","40,5","3"]', 0, '9 × 9 = 81, por lo tanto √81 = 9.', 'inicial', 60),
  ('Raíces cuadradas y cúbicas', '¿Cuál es el valor de ∛64?', '["4","8","21,3","2"]', 0, '4 × 4 × 4 = 64, por lo tanto ∛64 = 4.', 'intermedia', 90),
  ('Raíces cuadradas y cúbicas', '¿Cuál es el valor de √(25/16)?', '["5/4","5/8","25/4","4/5"]', 0, '√25 = 5 y √16 = 4, por lo tanto √(25/16) = 5/4.', 'intermedia', 90),
  ('Raíces cuadradas y cúbicas', 'Un cuadrado tiene un área de 144 cm². ¿Cuánto mide su lado?', '["12 cm","72 cm","24 cm","36 cm"]', 0, 'El lado de un cuadrado es la raíz cuadrada de su área: √144 = 12 cm.', 'avanzada', 120),

  ('Aproximación de números irracionales', '¿Cuál de los siguientes números es irracional?', '["√2","4/5","0,25","9"]', 0, '√2 no puede expresarse como una fracción exacta y tiene infinitas cifras decimales no periódicas; los otros números son racionales.', 'inicial', 60),
  ('Aproximación de números irracionales', '¿Entre qué par de números enteros consecutivos se ubica √50?', '["7 y 8","6 y 7","5 y 6","8 y 9"]', 0, '7² = 49 y 8² = 64. Como 49 < 50 < 64, entonces 7 < √50 < 8.', 'intermedia', 90),
  ('Aproximación de números irracionales', '¿Cuál es una aproximación razonable de √20 a la décima más cercana?', '["4,5","4,0","5,0","4,4"]', 0, '√20 ≈ 4,47, que redondeado a la décima más cercana es 4,5.', 'intermedia', 90),
  ('Aproximación de números irracionales', '¿Cuál de las siguientes afirmaciones sobre π es verdadera?', '["Es un número irracional con infinitas cifras decimales no periódicas","Es exactamente igual a 22/7","Es un número racional","Es igual a 3,14 exactamente"]', 0, 'π es un número irracional; 3,14 y 22/7 son solo aproximaciones usadas en cálculos.', 'avanzada', 120),

  ('Operatoria con números racionales', '¿Cuál es el resultado de 2/3 + 1/6?', '["5/6","3/9","1/2","5/9"]', 0, '2/3 = 4/6. Sumando: 4/6 + 1/6 = 5/6.', 'inicial', 60),
  ('Operatoria con números racionales', '¿Cuál es el resultado de -3/4 × 2/5?', '["-3/10","-6/9","3/10","-5/9"]', 0, 'Multiplicando numeradores y denominadores: (-3×2)/(4×5) = -6/20, que simplificado es -3/10.', 'intermedia', 90),
  ('Operatoria con números racionales', '¿Cuál es el resultado de 0,75 ÷ (-0,5)?', '["-1,5","1,5","-0,375","0,375"]', 0, 'Al dividir un positivo por un negativo, el resultado es negativo: 0,75 ÷ 0,5 = 1,5, con signo negativo: -1,5.', 'intermedia', 90),
  ('Operatoria con números racionales', '¿Cuál es el resultado de (1/2 - 1/3) × (3/4 + 1/4)?', '["1/6","1/3","1/12","1/4"]', 0, '1/2 - 1/3 = 1/6, y 3/4 + 1/4 = 1. Multiplicando: 1/6 × 1 = 1/6.', 'avanzada', 120),

  ('Notación científica', '¿Cuál es la notación científica de 45.000.000?', '["4,5 × 10⁷","45 × 10⁶","4,5 × 10⁶","0,45 × 10⁸"]', 0, 'Se corre el punto decimal 7 lugares hasta dejar un solo dígito antes de la coma: 4,5 × 10⁷.', 'inicial', 60),
  ('Notación científica', '¿Cuál es la notación científica de 0,00032?', '["3,2 × 10⁻⁴","3,2 × 10⁴","32 × 10⁻⁵","0,32 × 10⁻³"]', 0, 'Se corre el punto decimal 4 lugares hacia la derecha, por lo que el exponente es negativo: 3,2 × 10⁻⁴.', 'intermedia', 90),
  ('Notación científica', '¿A qué número corresponde 6,02 × 10²³?', '["602.000.000.000.000.000.000.000","60.200.000","6.020.000.000","602.000"]', 0, 'Se corre el punto decimal 23 lugares hacia la derecha, agregando ceros.', 'intermedia', 90),
  ('Notación científica', 'El diámetro de un átomo es aproximadamente 1 × 10⁻¹⁰ m y el de una pelota de fútbol es aproximadamente 2 × 10⁻¹ m. ¿Cuántas veces más grande es la pelota que el átomo?', '["2 × 10⁹ veces","2 × 10¹¹ veces","2 × 10⁻⁹ veces","5 × 10⁸ veces"]', 0, 'Se divide: (2 × 10⁻¹) ÷ (1 × 10⁻¹⁰) = 2 × 10⁻¹⁻⁽⁻¹⁰⁾ = 2 × 10⁹.', 'avanzada', 120),

  ('Propiedades de las potencias', '¿Cuál es el resultado de 2³ × 2⁴?', '["2⁷","2¹²","4⁷","2¹"]', 0, 'Al multiplicar potencias de igual base, se suman los exponentes: 2³ × 2⁴ = 2⁷.', 'inicial', 60),
  ('Propiedades de las potencias', '¿Cuál es el resultado de 5⁶ ÷ 5²?', '["5⁴","5³","5¹²","25⁴"]', 0, 'Al dividir potencias de igual base, se restan los exponentes: 5⁶ ÷ 5² = 5⁴.', 'intermedia', 90),
  ('Propiedades de las potencias', '¿Cuál es el resultado de (3²)³?', '["3⁶","3⁵","9⁶","3⁹"]', 0, 'Una potencia elevada a otra potencia se resuelve multiplicando los exponentes: (3²)³ = 3⁶.', 'intermedia', 90),
  ('Propiedades de las potencias', 'Simplifica: (2³ × 2⁵) ÷ 2⁴', '["2⁴","2¹²","2²","2⁸"]', 0, 'Primero se suman los exponentes del producto: 2³ × 2⁵ = 2⁸. Luego se resta el exponente de la división: 2⁸ ÷ 2⁴ = 2⁴.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Números')
      and name = 'Números — 8° Básico'
  )
cross join (select id from public.levels where code = 'regular_8_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: ÁLGEBRA — 8° BÁSICO (6 objetivos x 4 preguntas = 24)
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
  ('Operatoria de expresiones algebraicas', '¿Cuál es el resultado de multiplicar 3x × 4x²?', '["12x³","12x²","7x³","12x"]', 0, 'Se multiplican los coeficientes (3×4=12) y se suman los exponentes de la misma variable (x¹×x²=x³): 12x³.', 'inicial', 60),
  ('Operatoria de expresiones algebraicas', '¿Cuál es el resultado de (x + 3)(x + 2)?', '["x² + 5x + 6","x² + 6x + 5","x² + 5","2x + 5"]', 0, 'Aplicando la propiedad distributiva: x² + 2x + 3x + 6 = x² + 5x + 6.', 'intermedia', 90),
  ('Operatoria de expresiones algebraicas', '¿Cuál es el resultado de (x + 5)² usando el producto notable "cuadrado de binomio"?', '["x² + 10x + 25","x² + 25","x² + 5x + 25","x² + 10x + 10"]', 0, 'El cuadrado de un binomio es: primer término al cuadrado, más el doble producto, más el segundo término al cuadrado: x² + 2(5x) + 25 = x² + 10x + 25.', 'intermedia', 90),
  ('Operatoria de expresiones algebraicas', '¿Cuál es el resultado de (2x - 3)(2x + 3), un producto notable de "suma por su diferencia"?', '["4x² - 9","4x² - 6x - 9","2x² - 9","4x² + 9"]', 0, 'La suma por su diferencia da como resultado la diferencia de cuadrados: (2x)² - 3² = 4x² - 9.', 'avanzada', 120),

  ('Factorización de expresiones algebraicas', '¿Cuál es la factorización de 6x + 9?', '["3(2x + 3)","6(x + 9)","3(2x + 9)","9(x + 1)"]', 0, 'El factor común de 6x y 9 es 3: 3(2x + 3).', 'inicial', 60),
  ('Factorización de expresiones algebraicas', '¿Cuál es la factorización de x² - 16 usando diferencia de cuadrados?', '["(x - 4)(x + 4)","(x - 8)(x + 8)","(x - 4)²","(x + 4)²"]', 0, 'x² - 16 = x² - 4², que corresponde a la diferencia de cuadrados (x - 4)(x + 4).', 'intermedia', 90),
  ('Factorización de expresiones algebraicas', '¿Cuál es la factorización de x² + 8x + 16?', '["(x + 4)²","(x + 8)²","(x + 4)(x - 4)","(x + 16)"]', 0, 'x² + 8x + 16 es un cuadrado de binomio, ya que 16 = 4² y 8x = 2(4x): (x + 4)².', 'intermedia', 90),
  ('Factorización de expresiones algebraicas', '¿Cuál es la factorización completa de 2x² - 8?', '["2(x - 2)(x + 2)","2(x - 4)(x + 4)","(2x - 4)(x + 2)","2(x - 2)²"]', 0, 'Primero se extrae el factor común 2: 2(x² - 4). Luego se factoriza la diferencia de cuadrados: 2(x - 2)(x + 2).', 'avanzada', 120),

  ('Sistemas de dos ecuaciones lineales', '¿Cuál es la solución del sistema x + y = 10, x - y = 2?', '["x=6, y=4","x=4, y=6","x=8, y=2","x=5, y=5"]', 0, 'Sumando ambas ecuaciones: 2x = 12, x = 6. Reemplazando: 6 + y = 10, y = 4.', 'inicial', 60),
  ('Sistemas de dos ecuaciones lineales', 'Al resolver el sistema 2x + y = 7 y x - y = 2 sumando ambas ecuaciones (método de reducción), ¿qué ecuación se obtiene?', '["3x = 9","x + 2y = 9","3x = 5","x - 2y = 9"]', 0, 'Sumando las dos ecuaciones, los términos con y se cancelan: (2x + x) + (y - y) = 7 + 2, es decir, 3x = 9.', 'intermedia', 90),
  ('Sistemas de dos ecuaciones lineales', '¿Cuál es la solución del sistema y = 2x, x + y = 9?', '["x=3, y=6","x=6, y=3","x=9, y=18","x=2, y=4"]', 0, 'Sustituyendo y = 2x en la segunda ecuación: x + 2x = 9, 3x = 9, x = 3, por lo tanto y = 2(3) = 6.', 'intermedia', 90),
  ('Sistemas de dos ecuaciones lineales', 'La suma de las edades de dos hermanos es 24 años y la diferencia es 4 años. ¿Cuáles son sus edades?', '["14 y 10","12 y 12","16 y 8","20 y 4"]', 0, 'Planteando x + y = 24 y x - y = 4: sumando, 2x = 28, x = 14; luego y = 24 - 14 = 10.', 'avanzada', 120),

  ('Función lineal y afín', '¿Cuál es la pendiente de la función y = 3x - 2?', '["3","-2","2","-3"]', 0, 'En la forma y = mx + n, m es la pendiente. Aquí m = 3.', 'inicial', 60),
  ('Función lineal y afín', '¿Cuál de las siguientes funciones es lineal, es decir, pasa por el origen?', '["y = 5x","y = 5x + 2","y = x²","y = 5"]', 0, 'Una función lineal tiene la forma y = mx (sin término independiente) y siempre pasa por el origen (0,0).', 'intermedia', 90),
  ('Función lineal y afín', '¿Cuál es el valor de y cuando x = 4 en la función y = 2x + 1?', '["9","8","7","6"]', 0, 'Reemplazando: y = 2(4) + 1 = 8 + 1 = 9.', 'intermedia', 90),
  ('Función lineal y afín', 'Una función afín tiene pendiente -2 y pasa por el punto (3, 1). ¿Cuál es su ecuación?', '["y = -2x + 7","y = -2x + 1","y = -2x - 7","y = 2x + 7"]', 0, 'Reemplazando en y = -2x + n: 1 = -2(3) + n, 1 = -6 + n, n = 7. La ecuación es y = -2x + 7.', 'avanzada', 120),

  ('Ecuaciones literales', 'Despeja x en la ecuación ax = b (con a ≠ 0)', '["x = b/a","x = a/b","x = ab","x = a - b"]', 0, 'Dividiendo ambos lados por a: x = b/a.', 'inicial', 60),
  ('Ecuaciones literales', 'Despeja h en la fórmula del área del triángulo: A = (b × h)/2', '["h = 2A/b","h = A/(2b)","h = 2A × b","h = A - b"]', 0, 'Multiplicando ambos lados por 2: 2A = b × h. Dividiendo por b: h = 2A/b.', 'intermedia', 90),
  ('Ecuaciones literales', 'Despeja v en la fórmula de la velocidad: d = v × t', '["v = d/t","v = d × t","v = t/d","v = d - t"]', 0, 'Dividiendo ambos lados por t: v = d/t.', 'intermedia', 90),
  ('Ecuaciones literales', 'Despeja x en la ecuación literal: 3x + a = 2x + b', '["x = b - a","x = a - b","x = a + b","x = (b - a)/5"]', 0, 'Restando 2x y a en ambos lados: 3x - 2x = b - a, es decir, x = b - a.', 'avanzada', 120),

  ('Inecuaciones lineales con una incógnita', '¿Cuál es el conjunto solución de x - 5 > 0?', '["x > 5","x < 5","x > -5","x < -5"]', 0, 'Sumando 5 a ambos lados: x > 5.', 'inicial', 60),
  ('Inecuaciones lineales con una incógnita', '¿Cuál es el conjunto solución de 3x ≤ 12?', '["x ≤ 4","x ≥ 4","x ≤ 36","x ≥ -4"]', 0, 'Dividiendo por 3 (positivo, no cambia el sentido de la desigualdad): x ≤ 4.', 'intermedia', 90),
  ('Inecuaciones lineales con una incógnita', '¿Cuál es el conjunto solución de -x + 2 > 5?', '["x < -3","x > -3","x < 3","x > 3"]', 0, 'Restando 2: -x > 3. Al multiplicar por -1 se invierte la desigualdad: x < -3.', 'intermedia', 90),
  ('Inecuaciones lineales con una incógnita', 'Al resolver 2(x - 1) ≥ x + 3, ¿cómo se representa el conjunto solución en la recta numérica?', '["x ≥ 5, incluye el 5 (círculo relleno)","x > 5, no incluye el 5 (círculo vacío)","x ≤ 5","x ≥ -5"]', 0, 'Distribuyendo: 2x - 2 ≥ x + 3. Restando x y sumando 2: x ≥ 5. Como la desigualdad incluye la igualdad (≥), el 5 se representa con círculo relleno.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Álgebra')
      and name = 'Álgebra — 8° Básico'
  )
cross join (select id from public.levels where code = 'regular_8_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: GEOMETRÍA — 8° BÁSICO (5 objetivos x 4 preguntas = 20)
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
  ('Transformaciones isométricas y homotecia', '¿Cuál de las siguientes transformaciones NO es una isometría (no conserva el tamaño de la figura)?', '["Homotecia con factor 2","Traslación","Reflexión","Rotación"]', 0, 'Traslación, reflexión y rotación son isometrías porque conservan la forma y el tamaño; la homotecia cambia el tamaño según su factor.', 'inicial', 60),
  ('Transformaciones isométricas y homotecia', 'Al aplicar una homotecia de razón 3 a un triángulo, ¿qué ocurre con sus lados y ángulos?', '["Los lados se triplican y los ángulos se mantienen iguales","Los ángulos se triplican","Los lados y ángulos se mantienen iguales","Los lados se reducen a un tercio"]', 0, 'Una homotecia de razón 3 multiplica por 3 la longitud de cada lado, pero mantiene los ángulos originales (la figura resultante es semejante a la original).', 'intermedia', 90),
  ('Transformaciones isométricas y homotecia', 'Un punto A(2,3) se traslada según el vector (4,-1). ¿Cuáles son las coordenadas del punto trasladado?', '["(6, 2)","(-2, 4)","(6, -2)","(2, 3)"]', 0, 'Se suman las componentes del vector a las coordenadas del punto: (2+4, 3+(-1)) = (6, 2).', 'intermedia', 90),
  ('Transformaciones isométricas y homotecia', 'Un cuadrado de lado 4 cm se somete a una homotecia de razón 1/2 con centro en uno de sus vértices. ¿Cuál es el área de la figura resultante?', '["4 cm²","8 cm²","2 cm²","16 cm²"]', 0, 'El nuevo lado es 4 × 1/2 = 2 cm. El área del cuadrado resultante es 2 × 2 = 4 cm².', 'avanzada', 120),

  ('Volumen y área de cilindros, conos y esferas', '¿Cuál es el volumen de un cilindro de radio 3 cm y altura 10 cm? (usa π ≈ 3,14)', '["282,6 cm³","94,2 cm³","188,4 cm³","30 cm³"]', 0, 'El volumen de un cilindro es π × r² × h = 3,14 × 9 × 10 = 282,6 cm³.', 'inicial', 60),
  ('Volumen y área de cilindros, conos y esferas', '¿Cuál es el volumen de un cono de radio 6 cm y altura 9 cm? (usa π ≈ 3,14)', '["339,12 cm³","1.017,36 cm³","113,04 cm³","169,56 cm³"]', 0, 'El volumen de un cono es (1/3) × π × r² × h = (1/3) × 3,14 × 36 × 9 = 339,12 cm³.', 'intermedia', 90),
  ('Volumen y área de cilindros, conos y esferas', '¿Cuál es el volumen de una esfera de radio 3 cm? (usa π ≈ 3,14, V = (4/3)πr³)', '["113,04 cm³","36 cm³","339,12 cm³","28,26 cm³"]', 0, 'V = (4/3) × 3,14 × 27 = 113,04 cm³.', 'intermedia', 90),
  ('Volumen y área de cilindros, conos y esferas', 'Un cilindro y un cono tienen la misma base y la misma altura. ¿Qué relación existe entre sus volúmenes?', '["El volumen del cilindro es el triple del volumen del cono","El volumen del cono es el doble del volumen del cilindro","Ambos volúmenes son iguales","El volumen del cilindro es la mitad del volumen del cono"]', 0, 'El volumen del cono es (1/3) del volumen del cilindro cuando comparten base y altura, por lo tanto el cilindro tiene el triple del volumen del cono.', 'avanzada', 120),

  ('Semejanza de figuras geométricas', 'Dos triángulos son semejantes si sus ángulos correspondientes son iguales y sus lados correspondientes son:', '["Proporcionales","Iguales","Perpendiculares","Paralelos"]', 0, 'La semejanza exige ángulos iguales y lados correspondientes en la misma proporción (razón de semejanza), no necesariamente iguales.', 'inicial', 60),
  ('Semejanza de figuras geométricas', 'Un triángulo tiene lados 3, 4 y 5 cm. Otro triángulo semejante tiene su lado menor de 6 cm. ¿Cuál es la razón de semejanza?', '["2","3","1/2","4"]', 0, 'La razón de semejanza es 6 ÷ 3 = 2 (el lado correspondiente del segundo triángulo mide el doble).', 'intermedia', 90),
  ('Semejanza de figuras geométricas', 'Si dos triángulos son semejantes con razón de semejanza 3, y el área del triángulo menor es 5 cm², ¿cuál es el área del triángulo mayor?', '["45 cm²","15 cm²","25 cm²","9 cm²"]', 0, 'La razón entre las áreas es el cuadrado de la razón de semejanza: 3² = 9. El área mayor es 5 × 9 = 45 cm².', 'intermedia', 90),
  ('Semejanza de figuras geométricas', 'Un edificio proyecta una sombra de 12 m, mientras que un poste de 2 m de altura proyecta una sombra de 1,5 m al mismo tiempo. ¿Cuál es la altura del edificio?', '["16 m","9 m","18 m","24 m"]', 0, 'Por semejanza de triángulos: altura del edificio / 12 = 2 / 1,5, entonces altura = (2 × 12) / 1,5 = 16 m.', 'avanzada', 120),

  ('Teorema de Thales', 'El teorema de Thales establece que rectas paralelas cortadas por dos transversales determinan segmentos:', '["Proporcionales","Iguales","Perpendiculares","De igual longitud siempre"]', 0, 'El teorema de Thales establece una relación de proporcionalidad entre los segmentos determinados por rectas paralelas sobre dos transversales.', 'inicial', 60),
  ('Teorema de Thales', 'En un triángulo, una recta paralela a uno de sus lados divide a los otros dos lados en segmentos de 4 y 6 cm en un lado, y 6 y x cm en el otro. ¿Cuál es el valor de x?', '["9","8","10","6"]', 0, 'Por Thales: 4/6 = 6/x, por lo tanto x = (6 × 6) / 4 = 9.', 'intermedia', 90),
  ('Teorema de Thales', 'Tres rectas paralelas son cortadas por dos transversales. En la primera transversal los segmentos miden 3 y 5 cm; en la segunda, el primer segmento mide 6 cm. ¿Cuánto mide el segundo segmento?', '["10 cm","8 cm","9 cm","15 cm"]', 0, 'Por Thales: 3/5 = 6/x, por lo tanto x = (6 × 5) / 3 = 10 cm.', 'intermedia', 90),
  ('Teorema de Thales', 'Aplicando el teorema de Thales, se sabe que AB/BC = 2/3 y que AC mide 25 cm. ¿Cuánto mide AB?', '["10 cm","15 cm","12,5 cm","5 cm"]', 0, 'Si AB = 2k y BC = 3k, entonces AC = AB + BC = 5k = 25 cm, por lo que k = 5. Entonces AB = 2 × 5 = 10 cm.', 'avanzada', 120),

  ('Vistas y desarrollos de cuerpos geométricos', '¿Cuál es el desarrollo plano (red) de un cubo?', '["6 cuadrados unidos por sus lados","4 triángulos y un cuadrado","2 círculos y un rectángulo","6 rectángulos distintos"]', 0, 'Un cubo tiene 6 caras cuadradas iguales; su desarrollo plano son 6 cuadrados congruentes unidos por sus lados.', 'inicial', 60),
  ('Vistas y desarrollos de cuerpos geométricos', '¿Cuántas caras, aristas y vértices tiene un prisma rectangular?', '["6 caras, 12 aristas, 8 vértices","4 caras, 6 aristas, 4 vértices","8 caras, 12 aristas, 6 vértices","6 caras, 8 aristas, 12 vértices"]', 0, 'Un prisma rectangular (ortoedro) tiene 6 caras rectangulares, 12 aristas y 8 vértices.', 'intermedia', 90),
  ('Vistas y desarrollos de cuerpos geométricos', 'Al observar un cilindro desde arriba (vista superior), ¿qué figura se ve?', '["Un círculo","Un rectángulo","Un triángulo","Un óvalo alargado"]', 0, 'La vista superior de un cilindro corresponde a su base circular, por lo que se observa un círculo.', 'intermedia', 90),
  ('Vistas y desarrollos de cuerpos geométricos', 'El desarrollo plano de un cono está compuesto por:', '["Un sector circular (manto) y un círculo (base)","Dos círculos y un rectángulo","Un triángulo y un círculo","Un sector circular y un cuadrado"]', 0, 'El manto de un cono, al desplegarse, forma un sector circular, y su base es un círculo.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Geometría')
      and name = 'Geometría — 8° Básico'
  )
cross join (select id from public.levels where code = 'regular_8_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: PROBABILIDAD Y ESTADÍSTICA — 8° BÁSICO (5 objetivos x 4 preguntas = 20)
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
  ('Diagramas de dispersión', 'En un diagrama de dispersión, ¿qué representa cada punto?', '["Un par de valores de dos variables","Solo el valor de una variable","El promedio de los datos","La moda de los datos"]', 0, 'Cada punto del diagrama de dispersión representa un par ordenado (x, y), es decir, los valores de dos variables para un mismo elemento.', 'inicial', 60),
  ('Diagramas de dispersión', 'Si en un diagrama de dispersión los puntos suben de izquierda a derecha, ¿qué tipo de relación sugieren entre las variables?', '["Una relación positiva (directa)","Una relación negativa (inversa)","Ninguna relación","Una relación exacta"]', 0, 'Cuando ambas variables aumentan juntas, la relación observada es positiva o directa.', 'intermedia', 90),
  ('Diagramas de dispersión', 'En un diagrama de dispersión, los puntos están muy dispersos sin ningún patrón claro. ¿Qué se puede concluir?', '["No parece haber una relación clara entre las variables","Existe una relación perfectamente lineal","Las variables son iguales","Los datos están mal medidos necesariamente"]', 0, 'Cuando los puntos no siguen ningún patrón reconocible, se concluye que no hay evidencia de una relación clara entre las variables.', 'intermedia', 90),
  ('Diagramas de dispersión', 'Un diagrama de dispersión muestra que, a medida que aumentan las horas de estudio, disminuyen los errores en una prueba. ¿Qué tipo de relación describe mejor esta situación?', '["Una relación negativa (inversa)","Una relación positiva (directa)","No hay relación","Una relación circular"]', 0, 'Cuando una variable aumenta mientras la otra disminuye, la relación observada es negativa o inversa.', 'avanzada', 120),

  ('Diagramas de árbol', '¿Para qué se usa principalmente un diagrama de árbol en probabilidad?', '["Para representar todos los resultados posibles de un experimento compuesto","Para calcular solo la media de un conjunto de datos","Para ordenar datos de menor a mayor","Para representar solo un evento simple"]', 0, 'Un diagrama de árbol organiza visualmente todas las combinaciones posibles de un experimento con varias etapas.', 'inicial', 60),
  ('Diagramas de árbol', 'Al lanzar una moneda y luego un dado, ¿cuántas ramas finales tiene el diagrama de árbol?', '["12","8","6","2"]', 0, 'La moneda tiene 2 resultados y el dado 6, por lo que el diagrama tiene 2 × 6 = 12 ramas finales.', 'intermedia', 90),
  ('Diagramas de árbol', 'Usando un diagrama de árbol para lanzar 3 monedas, ¿cuántos resultados posibles hay en total?', '["8","6","3","9"]', 0, 'Cada moneda tiene 2 resultados posibles: 2 × 2 × 2 = 8 resultados en total.', 'intermedia', 90),
  ('Diagramas de árbol', 'En una bolsa hay 2 bolitas rojas y 3 azules. Se sacan dos bolitas sin reposición. Usando un diagrama de árbol, ¿cuál es la probabilidad de sacar dos bolitas rojas seguidas?', '["1/10","2/5","1/5","1/4"]', 0, 'La probabilidad de la primera roja es 2/5. Como no hay reposición, la probabilidad de la segunda roja es 1/4. Multiplicando: 2/5 × 1/4 = 2/20 = 1/10.', 'avanzada', 120),

  ('Principio multiplicativo', 'Un restaurante ofrece 3 tipos de entrada y 4 tipos de plato de fondo. ¿Cuántas combinaciones distintas de entrada y plato de fondo se pueden formar?', '["12","7","3","4"]', 0, 'Por el principio multiplicativo, se multiplican las opciones de cada etapa: 3 × 4 = 12.', 'inicial', 60),
  ('Principio multiplicativo', 'Para crear una clave de 2 caracteres, el primero es una letra (de 5 posibles) y el segundo un dígito (de 10 posibles). ¿Cuántas claves distintas se pueden formar?', '["50","15","10","5"]', 0, 'Por el principio multiplicativo: 5 × 10 = 50 claves distintas.', 'intermedia', 90),
  ('Principio multiplicativo', 'Una persona debe elegir un color de polera (4 opciones), un tipo de pantalón (3 opciones) y un par de zapatillas (2 opciones). ¿De cuántas formas distintas puede vestirse?', '["24","9","12","20"]', 0, 'Por el principio multiplicativo: 4 × 3 × 2 = 24 combinaciones distintas.', 'intermedia', 90),
  ('Principio multiplicativo', 'Se debe formar una contraseña de 3 dígitos usando los números del 0 al 9, sin repetir dígitos. ¿Cuántas contraseñas distintas son posibles?', '["720","1.000","900","30"]', 0, 'Para el primer dígito hay 10 opciones, para el segundo 9 (sin repetir) y para el tercero 8: 10 × 9 × 8 = 720.', 'avanzada', 120),

  ('Medidas de posición: cuartiles', '¿Qué porcentaje de los datos queda por debajo del primer cuartil (Q1)?', '["25%","50%","75%","10%"]', 0, 'El primer cuartil divide al 25% inferior de los datos del resto.', 'inicial', 60),
  ('Medidas de posición: cuartiles', 'En un conjunto de datos ordenado, el segundo cuartil (Q2) corresponde a:', '["La mediana del conjunto de datos","El dato máximo","El dato mínimo","El promedio de los cuartiles"]', 0, 'El segundo cuartil (Q2) divide los datos exactamente por la mitad, por lo que coincide con la mediana.', 'intermedia', 90),
  ('Medidas de posición: cuartiles', 'Dado el conjunto ordenado 2, 4, 6, 8, 10, 12, 14, 16, ¿cuál es el valor aproximado del primer cuartil (Q1)?', '["5","4","6","8"]', 0, 'La mitad inferior de los datos es 2, 4, 6, 8. Su mediana (Q1) es el promedio entre 4 y 6, es decir, 5.', 'intermedia', 90),
  ('Medidas de posición: cuartiles', 'En un conjunto de datos, Q1 = 20 y Q3 = 35. ¿Cuál es el rango intercuartil (RIC)?', '["15","55","27,5","20"]', 0, 'El rango intercuartil es la diferencia entre el tercer y el primer cuartil: 35 - 20 = 15.', 'avanzada', 120),

  ('Probabilidad de eventos complementarios', 'Si la probabilidad de que llueva mañana es 0,3, ¿cuál es la probabilidad de que NO llueva?', '["0,7","0,3","1,3","0"]', 0, 'La probabilidad del evento complementario es 1 menos la probabilidad del evento: 1 - 0,3 = 0,7.', 'inicial', 60),
  ('Probabilidad de eventos complementarios', 'En una bolsa con 8 bolitas, 3 son verdes. ¿Cuál es la probabilidad de NO sacar una bolita verde?', '["5/8","3/8","3/5","5/3"]', 0, 'Hay 5 bolitas que no son verdes de un total de 8: 5/8.', 'intermedia', 90),
  ('Probabilidad de eventos complementarios', 'Si P(A) = 2/5, ¿cuál es el valor de P(no A)?', '["3/5","2/5","5/2","1/5"]', 0, 'P(no A) = 1 - P(A) = 1 - 2/5 = 3/5.', 'intermedia', 90),
  ('Probabilidad de eventos complementarios', 'La probabilidad de aprobar un examen es 0,85. Si dos estudiantes rinden el examen de forma independiente, ¿cuál es la probabilidad de que NINGUNO apruebe?', '["0,0225","0,15","0,225","0,7225"]', 0, 'La probabilidad de que un estudiante no apruebe es 1 - 0,85 = 0,15. Como son independientes, se multiplican: 0,15 × 0,15 = 0,0225.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Probabilidad y Estadística')
      and name = 'Probabilidad y Estadística — 8° Básico'
  )
cross join (select id from public.levels where code = 'regular_8_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );
