-- Dominio: Contenido y preguntas
-- Banco de preguntas de selección múltiple para Matemática, Currículum
-- Regular, 1° Medio (D.S. 614/2013), 4 ejes: Números, Álgebra, Geometría,
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
-- Seed SOLO local: no se ha ejecutado contra ningún Supabase (ni local ni
-- remoto).

-- ============================================================================
-- EJE: NÚMEROS — 1° MEDIO (6 objetivos x 4 preguntas = 24)
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
  ('Operatoria con números enteros en contexto', 'Un termómetro marca -3°C en la mañana y sube 8°C durante el día. ¿Qué temperatura marca al final del día?', '["5°C","11°C","-11°C","-5°C"]', 0, 'Sumando: -3 + 8 = 5°C.', 'inicial', 60),
  ('Operatoria con números enteros en contexto', 'Una cuenta bancaria tiene -$25.000 (deuda). Se deposita $18.000 y luego se retiran $10.000 más. ¿Cuál es el saldo final?', '["-$17.000","$17.000","-$7.000","$7.000"]', 0, '-25.000 + 18.000 - 10.000 = -17.000, es decir, sigue en deuda por $17.000.', 'intermedia', 90),
  ('Operatoria con números enteros en contexto', '¿Cuál es el resultado correcto de comparar -15 y -(-15)?', '["-15 < 15","-15 > 15","-15 = 15","No se pueden comparar"]', 0, '-(-15) = 15. Como -15 es negativo y 15 es positivo, -15 < 15.', 'intermedia', 90),
  ('Operatoria con números enteros en contexto', 'Un ascensor está en el piso -2 (subterráneo). Sube 5 pisos, baja 3 y luego sube 4. ¿En qué piso queda?', '["Piso 4","Piso 6","Piso 2","Piso -4"]', 0, '-2 + 5 - 3 + 4 = 4.', 'avanzada', 120),

  ('Proporcionalidad directa, inversa y porcentual', 'Si 3 entradas al cine cuestan $9.000, ¿cuánto cuestan 5 entradas (proporcionalidad directa)?', '["$15.000","$12.000","$18.000","$10.000"]', 0, 'El precio por entrada es 9.000 ÷ 3 = $3.000. Para 5 entradas: 5 × 3.000 = $15.000.', 'inicial', 60),
  ('Proporcionalidad directa, inversa y porcentual', '5 máquinas producen cierta cantidad de piezas en 12 horas. ¿Cuántas horas tardarían 3 máquinas en producir la misma cantidad (proporcionalidad inversa)?', '["20 horas","7,2 horas","36 horas","15 horas"]', 0, 'El trabajo total es 5 × 12 = 60 máquina-horas. Con 3 máquinas: 60 ÷ 3 = 20 horas.', 'intermedia', 90),
  ('Proporcionalidad directa, inversa y porcentual', 'Un salario aumentó de $400.000 a $460.000. ¿Cuál fue el porcentaje de aumento?', '["15%","12%","20%","6%"]', 0, 'El aumento fue de $60.000. Como porcentaje del salario original: 60.000/400.000 = 0,15 = 15%.', 'intermedia', 90),
  ('Proporcionalidad directa, inversa y porcentual', 'En una encuesta a 160 personas, el 30% prefiere el producto A y el resto se reparte en partes iguales entre B y C. ¿Cuántas personas prefieren el producto B?', '["56","48","64","52"]', 0, 'El 30% de 160 es 48 personas para A. Quedan 160 - 48 = 112 personas repartidas en partes iguales entre B y C: 112 ÷ 2 = 56.', 'avanzada', 120),

  ('Potencias de base racional y exponente entero', '¿Cuál es el valor de (2/3)²?', '["4/9","2/3","4/6","2/9"]', 0, '(2/3)² = (2×2)/(3×3) = 4/9.', 'inicial', 60),
  ('Potencias de base racional y exponente entero', '¿Cuál es el valor de 5⁻²?', '["1/25","-10","-25","10"]', 0, 'Un exponente negativo invierte la base: 5⁻² = 1/5² = 1/25.', 'intermedia', 90),
  ('Potencias de base racional y exponente entero', '¿Cuál es el valor de la potencia con exponente negativo (1/2)⁻³?', '["8","1/8","-8","6"]', 0, 'El exponente negativo invierte la fracción y luego se eleva al cubo: (1/2)⁻³ = 2³ = 8.', 'intermedia', 90),
  ('Potencias de base racional y exponente entero', 'Simplifica: (3/2)² × (2/3)³', '["2/3","4/3","8/9","1"]', 0, '(3/2)² = 9/4 y (2/3)³ = 8/27. Multiplicando: (9/4) × (8/27) = 72/108 = 2/3.', 'avanzada', 120),

  ('Raíces enésimas', '¿Cuál es el valor de ∛27?', '["3","9","13,5","6"]', 0, '3 × 3 × 3 = 27, por lo tanto ∛27 = 3.', 'inicial', 60),
  ('Raíces enésimas', '¿Cuál es el valor de ⁴√16?', '["2","4","8","64"]', 0, '2 × 2 × 2 × 2 = 16, por lo tanto ⁴√16 = 2.', 'intermedia', 90),
  ('Raíces enésimas', '¿Cuál es el valor de ∛(-8)?', '["-2","2","-4","No existe"]', 0, 'A diferencia de la raíz cuadrada, la raíz cúbica de un número negativo sí existe y es negativa: (-2)³ = -8.', 'intermedia', 90),
  ('Raíces enésimas', 'Simplifica la expresión √50 dejándola con el menor número posible bajo la raíz.', '["5√2","25√2","2√25","10√5"]', 0, '50 = 25 × 2, y √25 = 5, por lo tanto √50 = 5√2.', 'avanzada', 120),

  ('Notación científica en contextos científicos', 'La velocidad de la luz es aproximadamente 300.000.000 m/s. ¿Cómo se expresa en notación científica?', '["3 × 10⁸ m/s","3 × 10⁷ m/s","30 × 10⁷ m/s","3 × 10⁹ m/s"]', 0, 'Se corre el punto decimal 8 lugares: 3 × 10⁸ m/s.', 'inicial', 60),
  ('Notación científica en contextos científicos', 'Una célula mide aproximadamente 0,00002 m de diámetro. ¿Cómo se expresa en notación científica?', '["2 × 10⁻⁵ m","2 × 10⁵ m","20 × 10⁻⁶ m","2 × 10⁻⁴ m"]', 0, 'Se corre el punto decimal 5 lugares hacia la derecha, por lo que el exponente es -5: 2 × 10⁻⁵ m.', 'intermedia', 90),
  ('Notación científica en contextos científicos', '¿Cuál es el resultado de (2 × 10³) × (3 × 10⁴)?', '["6 × 10⁷","6 × 10¹²","5 × 10⁷","6 × 10⁴"]', 0, 'Se multiplican los coeficientes (2×3=6) y se suman los exponentes (3+4=7): 6 × 10⁷.', 'intermedia', 90),
  ('Notación científica en contextos científicos', 'La masa de la Tierra es aproximadamente 5,97 × 10²⁴ kg y la masa de la Luna es 7,3 × 10²² kg. ¿Aproximadamente cuántas veces más masiva es la Tierra que la Luna?', '["Aproximadamente 82 veces","Aproximadamente 8 veces","Aproximadamente 820 veces","Aproximadamente 8,2 veces"]', 0, 'Dividiendo: (5,97 × 10²⁴) ÷ (7,3 × 10²²) ≈ 0,818 × 10² ≈ 81,8, aproximadamente 82 veces.', 'avanzada', 120),

  ('Aproximación y truncamiento', '¿Cuál es el resultado de aproximar 7,368 a la décima más cercana?', '["7,4","7,3","7,37","7,0"]', 0, 'El dígito de la centésima (6) es mayor o igual a 5, por lo que se redondea hacia arriba: 7,4.', 'inicial', 60),
  ('Aproximación y truncamiento', '¿Cuál es el resultado de truncar 5,987 a la centésima (sin redondear)?', '["5,98","5,99","6,0","5,9"]', 0, 'Al truncar simplemente se eliminan las cifras siguientes sin redondear: 5,987 truncado a la centésima es 5,98.', 'intermedia', 90),
  ('Aproximación y truncamiento', 'Al aproximar 12,647 a la centésima más cercana, ¿cuál es el resultado?', '["12,65","12,64","12,60","12,7"]', 0, 'El dígito de la milésima (7) es mayor o igual a 5, por lo que se redondea hacia arriba: 12,65.', 'intermedia', 90),
  ('Aproximación y truncamiento', 'Un ingeniero trunca (en vez de redondear) una medida de 3,479 m a la décima, obteniendo 3,4 m. ¿Cuál es el error absoluto cometido respecto al valor original?', '["0,079 m","0,021 m","0,479 m","0,1 m"]', 0, 'El error absoluto es la diferencia entre el valor real y el aproximado: |3,479 - 3,4| = 0,079 m.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Números')
      and name = 'Números — 1° Medio'
  )
cross join (select id from public.levels where code = 'regular_1_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: ÁLGEBRA — 1° MEDIO (6 objetivos x 4 preguntas = 24)
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
  ('Lenguaje algebraico', '¿Cuál expresión representa "la mitad de un número disminuido en 3"?', '["x/2 - 3","2x - 3","x/2 + 3","3 - x/2"]', 0, 'La mitad de un número es x/2, y "disminuido en 3" significa restar 3: x/2 - 3.', 'inicial', 60),
  ('Lenguaje algebraico', 'Si el largo de un rectángulo es el triple de su ancho "a", ¿cuál expresión representa su área?', '["3a²","3a","a² + 3","6a"]', 0, 'El largo es 3a. El área es ancho × largo = a × 3a = 3a².', 'intermedia', 90),
  ('Lenguaje algebraico', 'La suma de tres números enteros consecutivos, siendo "n" el primero, se representa como:', '["3n + 3","3n","n + 3","3n + 1"]', 0, 'Los tres números son n, n+1 y n+2. Sumándolos: n + (n+1) + (n+2) = 3n + 3.', 'intermedia', 90),
  ('Lenguaje algebraico', 'Un número "x" se aumenta en un 20% y luego el resultado se disminuye en un 10%. ¿Cuál expresión representa el valor final?', '["1,08x","1,1x","1,2x","0,9x"]', 0, 'Aumentar en 20% equivale a multiplicar por 1,2; disminuir el resultado en 10% equivale a multiplicar por 0,9: 1,2 × 0,9 = 1,08, es decir, 1,08x.', 'avanzada', 120),

  ('Productos notables', '¿Cuál es el resultado de (x + 4)²?', '["x² + 8x + 16","x² + 16","x² + 4x + 16","x² + 8x + 8"]', 0, 'Cuadrado de binomio: x² + 2(4x) + 4² = x² + 8x + 16.', 'inicial', 60),
  ('Productos notables', '¿Cuál es el resultado de (x - 5)²?', '["x² - 10x + 25","x² - 25","x² - 10x - 25","x² - 5x + 25"]', 0, 'Cuadrado de binomio: x² - 2(5x) + 5² = x² - 10x + 25.', 'intermedia', 90),
  ('Productos notables', '¿Cuál es el resultado de (3x + 2)(3x - 2)?', '["9x² - 4","9x² + 4","6x² - 4","9x² - 6x - 4"]', 0, 'Suma por su diferencia: (3x)² - 2² = 9x² - 4.', 'intermedia', 90),
  ('Productos notables', '¿Cuál es el resultado de (x + 3)(x - 5)?', '["x² - 2x - 15","x² + 2x - 15","x² - 8x - 15","x² - 2x + 15"]', 0, 'Aplicando la propiedad distributiva: x² - 5x + 3x - 15 = x² - 2x - 15.', 'avanzada', 120),

  ('Ecuaciones y sistemas de primer grado', '¿Cuál es la solución de la ecuación 2x + 5 = 17?', '["6","11","6,5","22"]', 0, 'Restando 5: 2x = 12. Dividiendo por 2: x = 6.', 'inicial', 60),
  ('Ecuaciones y sistemas de primer grado', 'El doble de un número más 7 es igual a 23. ¿Cuál es el número?', '["8","16","9","15"]', 0, 'Planteando: 2x + 7 = 23, entonces 2x = 16, x = 8.', 'intermedia', 90),
  ('Ecuaciones y sistemas de primer grado', 'Un sistema de ecuaciones x + y = 15, 2x - y = 0 tiene como solución:', '["x=5, y=10","x=10, y=5","x=7,5, y=7,5","x=0, y=15"]', 0, 'Sumando ambas ecuaciones: 3x = 15, x = 5. Reemplazando: 5 + y = 15, y = 10.', 'intermedia', 90),
  ('Ecuaciones y sistemas de primer grado', 'En un corral hay conejos y gallinas: 20 cabezas y 56 patas en total. ¿Cuántos conejos hay?', '["8","10","12","6"]', 0, 'Planteando x + y = 20 (cabezas) y 4x + 2y = 56 (patas): despejando y = 20 - x y reemplazando, 4x + 2(20-x) = 56, 2x + 40 = 56, x = 8.', 'avanzada', 120),

  ('Factorización de expresiones algebraicas', '¿Cuál es la factorización de 4x² + 8x?', '["4x(x + 2)","4(x² + 2x)","2x(2x + 4)","4x²(1+2)"]', 0, 'El factor común de 4x² y 8x es 4x: 4x(x + 2).', 'inicial', 60),
  ('Factorización de expresiones algebraicas', '¿Cuál es la factorización de x² - 9?', '["(x - 3)(x + 3)","(x - 9)(x + 9)","(x - 3)²","(x + 3)²"]', 0, 'x² - 9 = x² - 3², una diferencia de cuadrados: (x - 3)(x + 3).', 'intermedia', 90),
  ('Factorización de expresiones algebraicas', '¿Cuál es la factorización de x² - 6x + 9?', '["(x - 3)²","(x + 3)²","(x - 3)(x + 3)","(x - 9)²"]', 0, 'x² - 6x + 9 es un cuadrado de binomio, ya que 9 = 3² y 6x = 2(3x): (x - 3)².', 'intermedia', 90),
  ('Factorización de expresiones algebraicas', '¿Cuál es la factorización completa de 3x² - 27?', '["3(x - 3)(x + 3)","3(x - 9)(x + 9)","(3x - 9)(x + 3)","3(x - 3)²"]', 0, 'Se extrae el factor común 3: 3(x² - 9). Luego se factoriza la diferencia de cuadrados: 3(x - 3)(x + 3).', 'avanzada', 120),

  ('Función lineal como modelo', 'Un plan de telefonía cobra $5.000 fijos más $50 por minuto hablado. ¿Cuál función representa el costo total según los minutos "m"?', '["C = 5.000 + 50m","C = 50 + 5.000m","C = 5.000m","C = 5.050m"]', 0, 'El costo total es el cargo fijo más el costo variable por minuto: C = 5.000 + 50m.', 'inicial', 60),
  ('Función lineal como modelo', 'Usando la función C = 5.000 + 50m, ¿cuál es el costo de hablar 40 minutos?', '["$7.000","$5.500","$2.000","$5.050"]', 0, 'Reemplazando: C = 5.000 + 50(40) = 5.000 + 2.000 = $7.000.', 'intermedia', 90),
  ('Función lineal como modelo', 'En la función y = -3x + 12 que modela el agua restante en un estanque, ¿qué representa la pendiente -3?', '["El estanque pierde 3 litros por cada unidad de tiempo","El estanque gana 3 litros por unidad de tiempo","El estanque parte con 3 litros","El estanque nunca se vacía"]', 0, 'La pendiente negativa indica una disminución constante: por cada unidad de tiempo, el estanque pierde 3 litros.', 'intermedia', 90),
  ('Función lineal como modelo', 'Un taxi cobra una tarifa fija de $600 más $500 por cada kilómetro recorrido. Si un viaje costó $3.600, ¿cuántos kilómetros recorrió?', '["6 km","7,2 km","6,6 km","8 km"]', 0, 'Planteando 600 + 500k = 3.600: 500k = 3.000, k = 6 km.', 'avanzada', 120),

  ('Sistemas de ecuaciones: métodos de resolución', '¿Cuál método consiste en despejar una variable en una ecuación y reemplazarla en la otra?', '["Sustitución","Igualación","Reducción","Gráfico"]', 0, 'El método de sustitución despeja una variable en una ecuación y la reemplaza en la otra.', 'inicial', 60),
  ('Sistemas de ecuaciones: métodos de resolución', 'Al resolver por igualación el sistema y = 2x + 1, y = -x + 7, ¿cuál ecuación se obtiene al igualar ambas expresiones?', '["2x + 1 = -x + 7","2x + 1 = x + 7","x = 2x - x + 7","y = 2x - x"]', 0, 'Como ambas expresiones son iguales a y, se igualan entre sí: 2x + 1 = -x + 7.', 'intermedia', 90),
  ('Sistemas de ecuaciones: métodos de resolución', 'Resolviendo el sistema del ejercicio anterior (2x + 1 = -x + 7), ¿cuál es el valor de x?', '["2","3","6","-2"]', 0, 'Sumando x en ambos lados: 3x + 1 = 7. Restando 1: 3x = 6. Dividiendo por 3: x = 2.', 'intermedia', 90),
  ('Sistemas de ecuaciones: métodos de resolución', 'Al resolver por reducción el sistema 3x + 2y = 16, x - 2y = 0, ¿cuál es el valor de x?', '["4","8","2","6"]', 0, 'Sumando ambas ecuaciones, los términos con y se cancelan: 4x = 16, x = 4.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Álgebra')
      and name = 'Álgebra — 1° Medio'
  )
cross join (select id from public.levels where code = 'regular_1_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: GEOMETRÍA — 1° MEDIO (5 objetivos x 4 preguntas = 20)
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
  ('Semejanza y teorema de Thales', 'Un mapa tiene una escala 1:50.000. Si la distancia en el mapa entre dos ciudades es 4 cm, ¿cuál es la distancia real?', '["2 km","4 km","20 km","0,2 km"]', 0, '4 cm × 50.000 = 200.000 cm = 2.000 m = 2 km.', 'inicial', 60),
  ('Semejanza y teorema de Thales', 'Dos figuras son semejantes con razón de semejanza 5. Si un lado de la figura menor mide 3 cm, ¿cuánto mide el lado correspondiente en la figura mayor?', '["15 cm","8 cm","3/5 cm","5/3 cm"]', 0, 'El lado correspondiente se multiplica por la razón de semejanza: 3 × 5 = 15 cm.', 'intermedia', 90),
  ('Semejanza y teorema de Thales', 'Aplicando el teorema de Thales en un triángulo, un segmento paralelo a un lado divide a los otros dos lados en razón 2:3. Si un segmento mide 10 cm, ¿cuánto mide el segmento proporcional correspondiente?', '["15 cm","6,67 cm","20 cm","5 cm"]', 0, 'Por proporcionalidad: 10/2 = x/3, por lo tanto x = (10 × 3)/2 = 15 cm.', 'intermedia', 90),
  ('Semejanza y teorema de Thales', 'Una persona de 1,7 m de altura proyecta una sombra de 2 m. En el mismo instante, un árbol proyecta una sombra de 12 m. ¿Cuál es la altura del árbol?', '["10,2 m","14,1 m","6 m","20,4 m"]', 0, 'Por semejanza de triángulos: altura/1,7 = 12/2, entonces altura = (1,7 × 12) / 2 = 10,2 m.', 'avanzada', 120),

  ('Transformaciones isométricas', '¿Qué transformación isométrica se obtiene al "voltear" una figura respecto a un eje?', '["Reflexión","Traslación","Rotación","Homotecia"]', 0, 'La reflexión invierte la figura respecto a un eje de simetría, como un espejo.', 'inicial', 60),
  ('Transformaciones isométricas', 'Un triángulo se rota 90° en sentido horario en torno al origen. ¿Qué característica se mantiene en la figura resultante?', '["El tamaño y la forma del triángulo","Solo el tamaño","Solo la orientación","Ninguna característica se mantiene"]', 0, 'Las rotaciones son isometrías: conservan tanto el tamaño como la forma de la figura original.', 'intermedia', 90),
  ('Transformaciones isométricas', 'Al reflejar el punto (3, 5) respecto al eje x, ¿cuáles son sus nuevas coordenadas?', '["(3, -5)","(-3, 5)","(-3, -5)","(5, 3)"]', 0, 'Al reflejar respecto al eje x, la coordenada x se mantiene y la coordenada y cambia de signo: (3, -5).', 'intermedia', 90),
  ('Transformaciones isométricas', 'Se aplica una traslación según el vector (-2, 3) a un punto y luego se refleja el resultado respecto al eje y. Si el punto original es (4, 1), ¿cuáles son las coordenadas finales?', '["(-2, 4)","(2, 4)","(-2, -4)","(2, -4)"]', 0, 'La traslación da (4-2, 1+3) = (2, 4). Al reflejar respecto al eje y, la coordenada x cambia de signo: (-2, 4).', 'avanzada', 120),

  ('Perímetro, área y volumen de cuerpos geométricos', '¿Cuál es el perímetro de un rectángulo de 8 cm de largo y 5 cm de ancho?', '["26 cm","40 cm","13 cm","20 cm"]', 0, 'El perímetro es 2×(largo + ancho) = 2×(8+5) = 26 cm.', 'inicial', 60),
  ('Perímetro, área y volumen de cuerpos geométricos', '¿Cuál es el área de un círculo de radio 4 cm? (usa π ≈ 3,14)', '["50,24 cm²","25,12 cm²","12,56 cm²","100,48 cm²"]', 0, 'El área de un círculo es π × r² = 3,14 × 16 = 50,24 cm².', 'intermedia', 90),
  ('Perímetro, área y volumen de cuerpos geométricos', '¿Cuál es el volumen de un prisma cuya base es un triángulo de área 12 cm² y cuya altura es 7 cm?', '["84 cm³","19 cm³","42 cm³","168 cm³"]', 0, 'El volumen de un prisma es área de la base × altura: 12 × 7 = 84 cm³.', 'intermedia', 90),
  ('Perímetro, área y volumen de cuerpos geométricos', 'Un jardín rectangular de 10 m × 6 m tiene un camino de 1 m de ancho alrededor de todo su borde exterior. ¿Cuál es el área del camino?', '["36 m²","60 m²","96 m²","16 m²"]', 0, 'El área total incluyendo el camino es 12 × 8 = 96 m². El área del jardín es 10 × 6 = 60 m². El área del camino es 96 - 60 = 36 m².', 'avanzada', 120),

  ('Trigonometría en el triángulo rectángulo', 'En un triángulo rectángulo, ¿cuál razón trigonométrica corresponde a cateto opuesto sobre hipotenusa?', '["Seno","Coseno","Tangente","Cotangente"]', 0, 'El seno de un ángulo se define como cateto opuesto dividido por la hipotenusa.', 'inicial', 60),
  ('Trigonometría en el triángulo rectángulo', 'En un triángulo rectángulo, el cateto opuesto a un ángulo mide 6 cm y la hipotenusa mide 10 cm. ¿Cuál es el seno de ese ángulo?', '["0,6","0,8","1,67","0,4"]', 0, 'Seno = cateto opuesto / hipotenusa = 6/10 = 0,6.', 'intermedia', 90),
  ('Trigonometría en el triángulo rectángulo', 'Si el coseno de un ángulo en un triángulo rectángulo es 0,8 y la hipotenusa mide 15 cm, ¿cuánto mide el cateto adyacente?', '["12 cm","18,75 cm","0,8 cm","9,6 cm"]', 0, 'Coseno = cateto adyacente / hipotenusa, entonces cateto adyacente = 0,8 × 15 = 12 cm.', 'intermedia', 90),
  ('Trigonometría en el triángulo rectángulo', 'Desde un punto en el suelo a 20 m de la base de un edificio, la tangente del ángulo de elevación hasta la punta del edificio es 1,5. ¿Cuál es la altura del edificio?', '["30 m","13,3 m","21,5 m","18,5 m"]', 0, 'Tangente = cateto opuesto (altura) / cateto adyacente (distancia), entonces altura = 1,5 × 20 = 30 m.', 'avanzada', 120),

  ('Vectores en el plano', '¿Cuáles son las componentes del vector que va desde el punto A(1,2) hasta el punto B(4,6)?', '["(3, 4)","(5, 8)","(4, 6)","(1, 2)"]', 0, 'Las componentes se obtienen restando las coordenadas: (4-1, 6-2) = (3, 4).', 'inicial', 60),
  ('Vectores en el plano', '¿Cuál es el resultado de sumar los vectores (2, 3) y (-1, 5)?', '["(1, 8)","(3, -2)","(1, -2)","(-2, 15)"]', 0, 'Se suman componente a componente: (2+(-1), 3+5) = (1, 8).', 'intermedia', 90),
  ('Vectores en el plano', '¿Cuál es la magnitud (módulo) del vector (3, 4)?', '["5","7","12","25"]', 0, 'La magnitud se calcula con √(3² + 4²) = √(9+16) = √25 = 5.', 'intermedia', 90),
  ('Vectores en el plano', 'Si el vector u = (2, -1) se multiplica por el escalar -3, ¿cuál es el vector resultante?', '["(-6, 3)","(6, -3)","(-6, -3)","(6, 3)"]', 0, 'Se multiplica cada componente por el escalar: (-3×2, -3×(-1)) = (-6, 3).', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Geometría')
      and name = 'Geometría — 1° Medio'
  )
cross join (select id from public.levels where code = 'regular_1_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: PROBABILIDAD Y ESTADÍSTICA — 1° MEDIO (5 objetivos x 4 preguntas = 20)
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
  ('Medidas de tendencia central con datos agrupados', 'Al calcular la media de datos agrupados en intervalos, ¿qué valor se usa para representar cada intervalo?', '["La marca de clase (punto medio del intervalo)","El límite inferior del intervalo","El límite superior del intervalo","La cantidad de intervalos"]', 0, 'La marca de clase, es decir, el punto medio del intervalo, se usa como valor representativo de todos los datos de ese intervalo.', 'inicial', 60),
  ('Medidas de tendencia central con datos agrupados', 'Un intervalo de frecuencia es [10-20) y tiene 8 datos. ¿Cuál es la marca de clase de este intervalo?', '["15","10","20","8"]', 0, 'La marca de clase es el promedio entre el límite inferior y superior: (10+20)/2 = 15.', 'intermedia', 90),
  ('Medidas de tendencia central con datos agrupados', 'Dados los intervalos [0-10) con 4 datos y marca de clase 5, y [10-20) con 6 datos y marca de clase 15, ¿cuál es la media aproximada?', '["11","10","12","9"]', 0, 'Media ponderada: (4×5 + 6×15) / (4+6) = (20+90)/10 = 11.', 'intermedia', 90),
  ('Medidas de tendencia central con datos agrupados', 'En una tabla de datos agrupados, la clase modal es aquella que tiene:', '["La mayor frecuencia","El menor valor de marca de clase","El mayor valor de marca de clase","La menor frecuencia"]', 0, 'La clase modal es el intervalo con mayor frecuencia, análogo a la moda en datos no agrupados.', 'avanzada', 120),

  ('Regla de Laplace', 'Según la regla de Laplace, ¿cómo se calcula la probabilidad de un evento?', '["Casos favorables dividido por casos posibles","Casos posibles dividido por casos favorables","Casos favorables multiplicado por casos posibles","Casos favorables menos casos posibles"]', 0, 'La regla de Laplace define la probabilidad como el número de casos favorables dividido por el número de casos posibles (equiprobables).', 'inicial', 60),
  ('Regla de Laplace', 'En una bolsa hay 5 bolitas numeradas del 1 al 5. ¿Cuál es la probabilidad de sacar un número mayor que 3?', '["2/5","3/5","1/5","4/5"]', 0, 'Los casos favorables son 4 y 5 (2 casos) de 5 posibles: 2/5.', 'intermedia', 90),
  ('Regla de Laplace', 'Al lanzar un dado de 6 caras, ¿cuál es la probabilidad de obtener un múltiplo de 3?', '["1/3","1/2","1/6","2/3"]', 0, 'Los múltiplos de 3 entre 1 y 6 son 3 y 6 (2 casos) de 6 posibles: 2/6 = 1/3.', 'intermedia', 90),
  ('Regla de Laplace', 'En una baraja de 52 cartas, ¿cuál es la probabilidad de sacar una carta que sea As o de corazones (sin contar el As de corazones dos veces)?', '["4/13","17/52","1/13","5/13"]', 0, 'Hay 4 Ases y 13 cartas de corazones, pero el As de corazones se cuenta una sola vez: 4 + 13 - 1 = 16 casos favorables de 52: 16/52 = 4/13.', 'avanzada', 120),

  ('Tablas de frecuencia y gráficos', 'En una tabla de frecuencias, ¿qué representa la frecuencia relativa?', '["La proporción de datos que corresponde a cada categoría respecto al total","El número absoluto de datos de una categoría","La suma de todas las frecuencias","El promedio de los datos"]', 0, 'La frecuencia relativa es la frecuencia absoluta de una categoría dividida por el total de datos.', 'inicial', 60),
  ('Tablas de frecuencia y gráficos', 'Si en una encuesta a 40 personas, 10 prefieren el color azul, ¿cuál es la frecuencia relativa (en porcentaje) del color azul?', '["25%","10%","40%","4%"]', 0, 'Frecuencia relativa = 10/40 = 0,25 = 25%.', 'intermedia', 90),
  ('Tablas de frecuencia y gráficos', 'En un gráfico circular (de torta), un sector ocupa 90° de los 360° totales. ¿Qué porcentaje del total representa ese sector?', '["25%","90%","36%","10%"]', 0, 'El porcentaje se calcula como 90°/360° = 0,25 = 25%.', 'intermedia', 90),
  ('Tablas de frecuencia y gráficos', 'Una tabla muestra las frecuencias acumuladas de las notas de un curso. Si la frecuencia acumulada hasta la nota 5,0 es 18 de un total de 30 estudiantes, ¿qué porcentaje de estudiantes tiene nota 5,0 o menos?', '["60%","18%","30%","12%"]', 0, 'El porcentaje se calcula como 18/30 = 0,6 = 60%.', 'avanzada', 120),

  ('Variable aleatoria discreta simple', '¿Cuál de las siguientes es un ejemplo de variable aleatoria discreta?', '["El número de caras obtenidas al lanzar 3 monedas","La estatura exacta de una persona","El tiempo exacto que demora una carrera","El peso exacto de un objeto"]', 0, 'Una variable discreta toma valores contables y separados (0, 1, 2, 3), a diferencia de una variable continua como la estatura o el tiempo exacto.', 'inicial', 60),
  ('Variable aleatoria discreta simple', 'Al lanzar dos monedas, la variable X representa el número de caras obtenidas. ¿Cuáles son los valores posibles de X?', '["0, 1, 2","1, 2","0, 1, 2, 3","2, 4"]', 0, 'Al lanzar dos monedas se pueden obtener 0, 1 o 2 caras.', 'intermedia', 90),
  ('Variable aleatoria discreta simple', 'Para la variable X del número de caras al lanzar dos monedas, ¿cuál es la probabilidad de que X = 1?', '["1/2","1/4","1/3","3/4"]', 0, 'De los 4 resultados posibles (CC, CS, SC, SS), 2 tienen exactamente una cara (CS y SC): 2/4 = 1/2.', 'intermedia', 90),
  ('Variable aleatoria discreta simple', 'Una variable aleatoria X tiene la siguiente distribución: P(X=0)=0,2; P(X=1)=0,5; P(X=2)=0,3. ¿Cuál es el valor esperado E(X)?', '["1,1","1,0","0,8","1,5"]', 0, 'El valor esperado es la suma de cada valor multiplicado por su probabilidad: 0×0,2 + 1×0,5 + 2×0,3 = 0 + 0,5 + 0,6 = 1,1.', 'avanzada', 120),

  ('Diseño de un estudio estadístico simple', '¿Cuál es el primer paso al diseñar un estudio estadístico?', '["Formular una pregunta de investigación clara","Elegir el gráfico a usar","Calcular la media de los datos","Publicar los resultados"]', 0, 'Todo estudio estadístico parte de una pregunta de investigación clara que guía el resto del proceso (recolección, análisis y conclusiones).', 'inicial', 60),
  ('Diseño de un estudio estadístico simple', 'Al diseñar una encuesta escolar, ¿por qué es importante definir bien la población objetivo?', '["Para asegurar que los resultados se puedan generalizar correctamente a quienes corresponde","Para que la encuesta sea más corta","Para evitar hacer gráficos","Para que la encuesta tenga menos preguntas"]', 0, 'Definir bien la población objetivo evita sacar conclusiones incorrectas o generalizarlas a un grupo que no fue efectivamente estudiado.', 'intermedia', 90),
  ('Diseño de un estudio estadístico simple', '¿Qué instrumento de recolección de datos es más adecuado para medir opiniones con respuestas cerradas de varios estudiantes?', '["Un cuestionario estructurado","Una entrevista abierta muy extensa","Una observación no estructurada","Ninguno, no se pueden medir opiniones"]', 0, 'Un cuestionario estructurado con preguntas cerradas permite recolectar y comparar de forma sistemática las opiniones de muchos estudiantes.', 'intermedia', 90),
  ('Diseño de un estudio estadístico simple', 'Un estudiante quiere estudiar si el tiempo de uso de redes sociales afecta el promedio de notas de sus compañeros de curso. ¿Cuál es un diseño adecuado para este estudio?', '["Recolectar datos de tiempo de uso y promedio de notas de una muestra representativa del curso y analizar su relación","Preguntar solo a sus mejores amigos","Usar únicamente su propio caso como ejemplo","Buscar la opinión de personas fuera del colegio"]', 0, 'Para estudiar una relación entre dos variables en el curso, se necesita recolectar datos de ambas variables en una muestra representativa del curso, no solo de un subgrupo sesgado o de una sola persona.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Probabilidad y Estadística')
      and name = 'Probabilidad y Estadística — 1° Medio'
  )
cross join (select id from public.levels where code = 'regular_1_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );
