-- Dominio: Contenido y preguntas
-- Banco de preguntas de selección múltiple para Matemática, Currículum
-- Regular, 7° Básico (D.S. 614/2013), 4 ejes: Números, Álgebra, Geometría,
-- Probabilidad y Estadística. 4 preguntas por cada uno de los 22 objetivos
-- de aprendizaje ya cargados en
-- supabase/seed/0012_curriculum_matematica_regular_7basico_2medio.sql
-- (unit_id + level_id + short_name, NUNCA ids hardcodeados).
--
-- ============================================================================
-- ESTADO EDITORIAL Y DE VALIDACIÓN (léase antes de usar en un ensayo)
-- ============================================================================
-- Todas las preguntas de este archivo quedan:
--   - `review_status = 'borrador'`: ciclo editorial sin revisar. Un
--     administrador humano debe leer, corregir y aprobar cada pregunta desde
--     el panel antes de que pueda usarse.
--   - `validation_status = 'ai_generated_review_required'`: se usa este
--     estado (agregado en supabase/migrations/0023_question_generation_
--     pipeline.sql) en vez del genérico 'unverified', porque describe con
--     más precisión el origen real de estas preguntas: generadas por un
--     agente (`generated_by`/`generated_at` quedan poblados), pendientes de
--     revisión humana. El propio trigger `prevent_ai_self_approval` (0023)
--     impide que salten directo a un estado de revisión humana sin pasar
--     antes por 'automatically_validated'.
--   - `is_active = true`: no están ocultas del panel administrativo, pero
--     `lib/data/essays.ts` (`selectEssayQuestions`) solo toma preguntas con
--     `reviewStatus === 'aprobado'` para un ensayo real, y
--     `lib/data/essay-coverage.ts` exige además
--     `validation_status = 'approved_for_exam'` para el chequeo de
--     publicación. Es decir: ESTAS PREGUNTAS NO SE MUESTRAN A NINGÚN
--     ESTUDIANTE hasta que un administrador las revise y apruebe una por una
--     (o en lote) desde `/admin` (ver `lib/data/question-review.ts`).
--
-- `source_type = 'validapp_original'` (ninguna pregunta es cita textual de
-- una fuente MINEDUC; son ejercicios originales ValidApp alineados al
-- objetivo). `framework_id` queda NULL: el Currículum Regular no usa
-- `curriculum_frameworks` (mismo criterio documentado en 0012).
--
-- ============================================================================
-- content_hash: limitación explícita
-- ============================================================================
-- `questions.content_hash` (0023) se calcula en TypeScript
-- (`lib/data/question-validators.ts: computeContentHash`, que normaliza con
-- NFD + strip de tildes + minúsculas antes del SHA-256). Replicar ese
-- algoritmo exacto en SQL puro (sin depender de `unaccent`, que no es
-- idéntico a un strip NFD) arriesga generar un hash que NO coincida con el
-- que usaría el resto del pipeline, lo que sería peor que no tener hash.
-- Se deja `content_hash` en NULL en todo este archivo. Recomendación para
-- `/validapp-db` o un script posterior: correr `computeContentHash` sobre
-- `prompt` de estas filas para poblar `content_hash` antes de que el banco
-- entre al flujo automático de detección de duplicados con preguntas
-- generadas por ese pipeline.
--
-- Duplicados/casi-duplicados: se evitaron manualmente al redactar (cada una
-- de las 4 preguntas por objetivo cubre un ángulo distinto del objetivo:
-- caso directo simple, problema contextualizado, caso con error conceptual
-- típico a discriminar, problema de mayor dificultad con varios pasos).
--
-- ============================================================================
-- IDEMPOTENCIA
-- ============================================================================
-- `questions` no tiene clave natural única (ver nota en
-- supabase/seed/0001_epja_pilot_matematica.sql). Se resuelve con
-- `where not exists (select 1 from public.questions q2 where
-- q2.learning_objective_id = lo.id and q2.prompt = v.prompt)` en cada
-- INSERT...SELECT: reintentar este script no duplica preguntas ya
-- insertadas (comparación exacta de prompt contra el mismo objetivo).
--
-- Seed SOLO local: no se ha ejecutado contra ningún Supabase (ni local ni
-- remoto).

-- ============================================================================
-- EJE: NÚMEROS — 7° BÁSICO (6 objetivos x 4 preguntas = 24)
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
  ('Operatoria con números enteros', '¿Cuál es el resultado de -8 + 5?', '["-13","-3","3","13"]', 1, 'Al sumar un entero negativo con uno positivo, se resta el menor valor absoluto al mayor y se conserva el signo del número con mayor valor absoluto: -8 + 5 = -3.', 'inicial', 60),
  ('Operatoria con números enteros', 'Un buzo desciende 12 metros bajo el nivel del mar y luego asciende 7 metros. ¿A qué profundidad respecto al nivel del mar queda?', '["19 metros bajo el nivel del mar","5 metros bajo el nivel del mar","5 metros sobre el nivel del mar","12 metros bajo el nivel del mar"]', 1, 'Descender 12 m equivale a -12 y ascender 7 m equivale a +7: -12 + 7 = -5, es decir, queda 5 m bajo el nivel del mar.', 'intermedia', 90),
  ('Operatoria con números enteros', '¿Cuál es el resultado de (-6) × (-4) ÷ (-3)?', '["-8","8","-2","2"]', 0, 'El producto de dos números negativos es positivo: (-6)×(-4) = 24. Luego, 24 dividido por -3 es -8, porque positivo dividido por negativo da negativo.', 'intermedia', 90),
  ('Operatoria con números enteros', 'Camila tiene -15 puntos en un juego. Gana 3 rondas de 8 puntos cada una y luego pierde 12 puntos. ¿Cuántos puntos tiene al final?', '["-3","3","21","-27"]', 0, 'Primero se calcula la multiplicación: 3×8 = 24. Luego: -15 + 24 - 12 = -3.', 'avanzada', 120),

  ('Fracciones y decimales positivos y negativos', '¿Cuál de los siguientes números es mayor: -0,5 o -0,8?', '["-0,5","-0,8","Son iguales","No se pueden comparar"]', 0, 'Entre dos números negativos, es mayor el que está más cerca de cero: -0,5 está más cerca de 0 que -0,8, por lo tanto -0,5 > -0,8.', 'inicial', 60),
  ('Fracciones y decimales positivos y negativos', 'Ordena de menor a mayor: -3/4, 0,5, -1, 1/4', '["-1, -3/4, 1/4, 0,5","-3/4, -1, 1/4, 0,5","0,5, 1/4, -3/4, -1","-1, 1/4, -3/4, 0,5"]', 0, 'Convertidos a decimal: -1, -0,75, 0,25 y 0,5. Ordenados de menor a mayor: -1, -3/4, 1/4, 0,5.', 'intermedia', 90),
  ('Fracciones y decimales positivos y negativos', '¿Qué número decimal corresponde a la fracción -5/8?', '["-0,625","-0,675","-1,6","-0,58"]', 0, '5 ÷ 8 = 0,625, y se conserva el signo negativo de la fracción: -5/8 = -0,625.', 'intermedia', 90),
  ('Fracciones y decimales positivos y negativos', 'En la recta numérica, ¿qué fracción negativa se ubica exactamente entre -1 y -1/2?', '["-3/4","-1/4","-2/3","-5/4"]', 0, 'El punto medio entre -1 y -1/2 es (-1 + (-1/2)) ÷ 2 = -3/4.', 'avanzada', 120),

  ('Problemas con porcentajes', '¿A qué fracción equivale el 40%?', '["2/5","4/5","1/4","3/4"]', 0, '40% = 40/100, que simplificado equivale a 2/5.', 'inicial', 60),
  ('Problemas con porcentajes', 'En un curso de 25 estudiantes, el 60% aprobó una prueba. ¿Cuántos estudiantes aprobaron?', '["10","12","15","20"]', 2, '60% de 25 = 0,6 × 25 = 15 estudiantes.', 'intermedia', 90),
  ('Problemas con porcentajes', 'El precio de una bicicleta subió de $40.000 a $46.000. ¿Cuál fue el porcentaje de aumento?', '["6%","13%","15%","20%"]', 2, 'El aumento fue de $6.000. Como porcentaje del precio original: 6.000/40.000 = 0,15 = 15%.', 'intermedia', 90),
  ('Problemas con porcentajes', 'Un producto cuesta $30.000 más IVA de 19%. ¿Cuál es el precio final con IVA incluido?', '["$35.700","$30.190","$33.000","$35.900"]', 0, 'El 19% de $30.000 es $5.700. El precio final es $30.000 + $5.700 = $35.700.', 'avanzada', 120),

  ('Potencias de base entera y exponente natural', '¿Cuál es el valor de (-2)³?', '["-8","8","-6","6"]', 0, 'Un exponente impar sobre una base negativa da un resultado negativo: (-2)×(-2)×(-2) = -8.', 'inicial', 60),
  ('Potencias de base entera y exponente natural', '¿Cuál es el resultado de 3² + 2³?', '["17","30","13","25"]', 0, '3² = 9 y 2³ = 8. Sumando ambos resultados: 9 + 8 = 17.', 'intermedia', 90),
  ('Potencias de base entera y exponente natural', '¿Cuál de las siguientes potencias tiene resultado negativo?', '["(-3)²","(-2)⁴","(-5)³","(-1)¹⁰"]', 2, '(-5)³ tiene exponente impar sobre base negativa, por lo que su resultado es negativo (-125). Las otras tres tienen exponente par, que siempre da resultado positivo.', 'intermedia', 90),
  ('Potencias de base entera y exponente natural', 'Se sabe que 2ⁿ = 32. ¿Cuál es el valor de n?', '["4","5","6","16"]', 1, '2⁵ = 32, por lo tanto n = 5.', 'avanzada', 120),

  ('Múltiplos, divisores y factorización prima', '¿Cuál de los siguientes números es un divisor de 36?', '["5","6","8","10"]', 1, '36 ÷ 6 = 6 exactamente, por lo que 6 es divisor de 36. Ninguno de los otros números divide a 36 sin dejar resto.', 'inicial', 60),
  ('Múltiplos, divisores y factorización prima', '¿Cuál es la descomposición en factores primos de 60?', '["2² × 3 × 5","2 × 3 × 10","2² × 15","2 × 30"]', 0, '60 = 2 × 30 = 2 × 2 × 15 = 2 × 2 × 3 × 5 = 2² × 3 × 5, y todos los factores de esta descomposición son primos.', 'intermedia', 90),
  ('Múltiplos, divisores y factorización prima', '¿Cuál es el mínimo común múltiplo (mcm) entre 8 y 12?', '["24","48","4","96"]', 0, 'Los múltiplos comunes de 8 y 12 son 24, 48, 72... El menor de ellos es 24.', 'intermedia', 90),
  ('Múltiplos, divisores y factorización prima', 'El máximo común divisor (MCD) entre 48 y 60 es 12. ¿Cuál es el resultado de dividir ambos números por su MCD y sumar los cocientes?', '["9","12","4","5"]', 0, '48 ÷ 12 = 4 y 60 ÷ 12 = 5. La suma de ambos cocientes es 4 + 5 = 9.', 'avanzada', 120),

  ('Razones, proporciones y porcentajes en contexto financiero', 'Una tienda ofrece un descuento del 20% en un producto de $15.000. ¿Cuánto dinero se descuenta?', '["$3.000","$1.500","$2.000","$5.000"]', 0, 'El 20% de $15.000 es 0,20 × 15.000 = $3.000.', 'inicial', 60),
  ('Razones, proporciones y porcentajes en contexto financiero', 'Un artículo de $20.000 tiene un recargo del 10% por pago en cuotas. ¿Cuál es el precio final?', '["$22.000","$20.100","$21.000","$18.000"]', 0, 'El 10% de $20.000 es $2.000. El precio final es $20.000 + $2.000 = $22.000.', 'intermedia', 90),
  ('Razones, proporciones y porcentajes en contexto financiero', 'La razón entre el precio de contado y el precio en cuotas de un producto es 4:5. Si el precio de contado es $40.000, ¿cuál es el precio en cuotas?', '["$50.000","$45.000","$32.000","$36.000"]', 0, 'Si 4 partes equivalen a $40.000, cada parte vale $10.000. El precio en cuotas (5 partes) es 5 × $10.000 = $50.000.', 'intermedia', 90),
  ('Razones, proporciones y porcentajes en contexto financiero', 'Un producto tiene un descuento del 15% y luego, sobre el precio ya rebajado, se aplica un recargo del 10% por atraso en el pago. Si el precio original era $10.000, ¿cuál es el precio final?', '["$9.350","$9.500","$10.000","$8.500"]', 0, 'Con el 15% de descuento: $10.000 × 0,85 = $8.500. Luego, con el 10% de recargo sobre ese valor: $8.500 × 1,10 = $9.350.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Números')
      and name = 'Números — 7° Básico'
  )
cross join (select id from public.levels where code = 'regular_7_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: ÁLGEBRA — 7° BÁSICO (6 objetivos x 4 preguntas = 24)
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
  ('Relación entre variables', 'En una tabla que relaciona el número de horas trabajadas con el pago recibido, ¿cuál es la variable dependiente?', '["El número de horas trabajadas","El pago recibido","El día de la semana","El nombre del trabajador"]', 1, 'El pago recibido depende de las horas trabajadas, por lo que es la variable dependiente; las horas trabajadas son la variable independiente.', 'inicial', 60),
  ('Relación entre variables', 'Si el precio a pagar por bencina depende de los litros comprados, ¿cuál es la variable independiente?', '["El precio a pagar","Los litros comprados","El tipo de vehículo","La marca de la bencina"]', 1, 'Los litros comprados determinan el precio a pagar, por lo que son la variable independiente.', 'intermedia', 90),
  ('Relación entre variables', 'En un gráfico donde el eje horizontal representa el tiempo en minutos y el eje vertical la distancia recorrida por un ciclista, ¿qué variable es la independiente?', '["La distancia recorrida","El tiempo","La velocidad máxima","El tipo de bicicleta"]', 1, 'El eje horizontal suele representar la variable independiente; en este caso, el tiempo determina la distancia recorrida.', 'intermedia', 90),
  ('Relación entre variables', 'Una tabla muestra que, a medida que aumenta el número de entradas vendidas, aumenta el ingreso total de un evento. ¿Cuál afirmación describe correctamente esta relación?', '["El ingreso total es la variable independiente y depende de las entradas","Las entradas vendidas son la variable independiente y el ingreso total es la variable dependiente","No existe relación entre ambas variables","El ingreso total determina el número de entradas vendidas"]', 1, 'El número de entradas vendidas es lo que se decide primero (independiente) y de ello depende el ingreso total obtenido (dependiente).', 'avanzada', 120),

  ('Reducción de expresiones algebraicas', '¿Cuál es el resultado de reducir 3x + 5x?', '["8x","15x","8x²","2x"]', 0, 'Al sumar términos semejantes (misma parte literal) se suman sus coeficientes: 3x + 5x = 8x.', 'inicial', 60),
  ('Reducción de expresiones algebraicas', 'Reduce la expresión: 4a + 3b - 2a + b', '["2a + 4b","6a + 4b","2a + 2b","6a + 3b"]', 0, 'Se agrupan los términos semejantes: (4a - 2a) + (3b + b) = 2a + 4b.', 'intermedia', 90),
  ('Reducción de expresiones algebraicas', '¿Cuál es el resultado de reducir 5x² - 2x + 3x² + x?', '["8x² - x","8x² + x","5x² - x","8x⁴ - x"]', 0, 'Se agrupan los términos con x²: 5x² + 3x² = 8x², y los términos con x: -2x + x = -x. El resultado es 8x² - x.', 'intermedia', 90),
  ('Reducción de expresiones algebraicas', 'Reduce: 2(x + 3) - (x - 4)', '["x + 10","x + 2","3x - 2","x - 2"]', 0, 'Se distribuye: 2x + 6 - x + 4 (ojo: el signo menos delante del paréntesis cambia el signo de ambos términos). Reduciendo: x + 10.', 'avanzada', 120),

  ('Ecuaciones e inecuaciones lineales', '¿Cuál es la solución de la ecuación x + 7 = 12?', '["5","19","-5","7"]', 0, 'Restando 7 a ambos lados: x = 12 - 7 = 5.', 'inicial', 60),
  ('Ecuaciones e inecuaciones lineales', '¿Cuál es la solución de 3x - 4 = 11?', '["5","3","7","25/3"]', 0, 'Sumando 4 a ambos lados: 3x = 15. Dividiendo por 3: x = 5.', 'intermedia', 90),
  ('Ecuaciones e inecuaciones lineales', '¿Cuál es el conjunto solución de la inecuación 2x + 3 > 9?', '["x > 3","x < 3","x > 6","x > 12"]', 0, 'Restando 3: 2x > 6. Dividiendo por 2 (positivo, no cambia el sentido de la desigualdad): x > 3.', 'intermedia', 90),
  ('Ecuaciones e inecuaciones lineales', 'Al resolver la inecuación -2x + 5 ≤ 1, ¿cuál es el conjunto solución? (Recuerda invertir la desigualdad al dividir por un número negativo)', '["x ≥ 2","x ≤ 2","x ≥ -2","x ≤ -2"]', 0, 'Restando 5: -2x ≤ -4. Al dividir por -2 se invierte la desigualdad: x ≥ 2.', 'avanzada', 120),

  ('Lenguaje algebraico y su traducción', '¿Cuál expresión algebraica representa "el doble de un número aumentado en 5"?', '["2x + 5","2(x+5)","x + 5","5x + 2"]', 0, 'El doble de un número es 2x; aumentado en 5 se traduce en sumar 5: 2x + 5.', 'inicial', 60),
  ('Lenguaje algebraico y su traducción', '¿Cuál enunciado representa correctamente la expresión 3(x - 2)?', '["El triple de la diferencia entre un número y 2","El triple de un número menos 2","La diferencia entre el triple de un número y 2","Un número menos el triple de 2"]', 0, 'El paréntesis indica que primero se calcula la diferencia (x - 2) y luego se multiplica por 3, es decir, "el triple de la diferencia".', 'intermedia', 90),
  ('Lenguaje algebraico y su traducción', 'La edad de Pedro es el triple de la edad de su hermana menos 4 años. Si la edad de la hermana es "h", ¿cuál expresión representa la edad de Pedro?', '["3h - 4","3(h-4)","h/3 - 4","3h + 4"]', 0, '"El triple de h" es 3h, y "menos 4" se resta al resultado del triple: 3h - 4.', 'intermedia', 90),
  ('Lenguaje algebraico y su traducción', 'Un rectángulo tiene un largo que es el doble de su ancho más 3 cm. Si el ancho es "a", ¿cuál expresión representa el perímetro del rectángulo?', '["6a + 6","2a + 3","3a + 3","4a + 6"]', 0, 'El largo es 2a + 3. El perímetro es 2×(ancho + largo) = 2×(a + 2a + 3) = 2×(3a + 3) = 6a + 6.', 'avanzada', 120),

  ('Valorización de expresiones algebraicas', 'Si x = 3, ¿cuál es el valor de 2x + 4?', '["10","9","24","14"]', 0, 'Reemplazando x por 3: 2×3 + 4 = 6 + 4 = 10.', 'inicial', 60),
  ('Valorización de expresiones algebraicas', 'Si a = -2 y b = 5, ¿cuál es el valor de 3a + b?', '["-1","1","-11","17"]', 0, 'Reemplazando: 3×(-2) + 5 = -6 + 5 = -1.', 'intermedia', 90),
  ('Valorización de expresiones algebraicas', 'Si x = -3, ¿cuál es el valor de x² - 2x?', '["15","3","-15","-3"]', 0, 'Reemplazando: (-3)² - 2×(-3) = 9 - (-6) = 9 + 6 = 15. Ojo: restar un número negativo equivale a sumarlo.', 'intermedia', 90),
  ('Valorización de expresiones algebraicas', 'Si a = 2 y b = -1, ¿cuál es el valor de (a + b)² - ab?', '["3","1","-1","5"]', 0, 'Reemplazando: (2 + (-1))² - (2×(-1)) = (1)² - (-2) = 1 + 2 = 3.', 'avanzada', 120),

  ('Proporcionalidad directa e inversa', 'Si 4 kg de manzanas cuestan $3.200, ¿cuánto cuestan 6 kg (proporcionalidad directa)?', '["$4.800","$4.200","$5.400","$3.800"]', 0, 'El precio por kg es 3.200 ÷ 4 = $800. Para 6 kg: 6 × 800 = $4.800.', 'inicial', 60),
  ('Proporcionalidad directa e inversa', '6 obreros terminan una obra en 10 días. ¿Cuántos días tardarán 4 obreros en hacer la misma obra (proporcionalidad inversa)?', '["15","8","12","20"]', 0, 'El trabajo total es 6 × 10 = 60 obrero-días. Con 4 obreros: 60 ÷ 4 = 15 días.', 'intermedia', 90),
  ('Proporcionalidad directa e inversa', '¿Cuál de las siguientes tablas representa una relación de proporcionalidad directa entre x e y?', '["x: 1, 2, 3 — y: 5, 10, 15","x: 1, 2, 3 — y: 5, 7, 9","x: 1, 2, 4 — y: 10, 10, 10","x: 1, 2, 3 — y: 5, 4, 3"]', 0, 'En una proporcionalidad directa, la razón y/x debe ser constante. Solo en la primera tabla y/x = 5 para todos los pares.', 'intermedia', 90),
  ('Proporcionalidad directa e inversa', 'Un auto recorre una distancia fija en un tiempo que depende de su velocidad (proporcionalidad inversa). Si a 60 km/h demora 3 horas, ¿cuánto demorará a 90 km/h?', '["2 horas","2,5 horas","4 horas","1,5 horas"]', 0, 'La distancia es 60 × 3 = 180 km. A 90 km/h: 180 ÷ 90 = 2 horas.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Álgebra')
      and name = 'Álgebra — 7° Básico'
  )
cross join (select id from public.levels where code = 'regular_7_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: GEOMETRÍA — 7° BÁSICO (5 objetivos x 4 preguntas = 20)
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
  ('Construcción de triángulos y cuadriláteros', '¿Cuál es la condición para poder construir un triángulo con tres segmentos dados?', '["La suma de los dos lados menores debe ser mayor que el lado mayor","La suma de todos los lados debe ser 180°","Los tres lados deben ser iguales","Dos lados deben ser paralelos"]', 0, 'La desigualdad triangular exige que la suma de las longitudes de dos lados cualesquiera sea mayor que la longitud del tercer lado.', 'inicial', 60),
  ('Construcción de triángulos y cuadriláteros', '¿Es posible construir un triángulo con lados de 3 cm, 4 cm y 8 cm?', '["No, porque 3 + 4 < 8","Sí, porque la suma de los tres lados es mayor que 0","No, porque los lados no son iguales","Sí, porque 8 es el lado mayor"]', 0, 'La suma de los dos lados menores (3 + 4 = 7) debe ser mayor que el lado mayor (8), pero 7 < 8, por lo que no se cumple la desigualdad triangular.', 'intermedia', 90),
  ('Construcción de triángulos y cuadriláteros', 'Al construir un cuadrilátero, ¿cuál de las siguientes condiciones garantiza que la figura sea un paralelogramo?', '["Los lados opuestos son paralelos y de igual longitud","Todos los ángulos son rectos","Las diagonales son perpendiculares","Todos los lados son iguales"]', 0, 'Un paralelogramo se define por tener ambos pares de lados opuestos paralelos y de igual longitud; las otras condiciones describen casos particulares (rectángulo, rombo) no la definición general.', 'intermedia', 90),
  ('Construcción de triángulos y cuadriláteros', 'Se quiere construir un triángulo isósceles con dos lados de 6 cm y un ángulo de 50° entre ellos. ¿Qué criterio de construcción se está usando?', '["Dos lados congruentes y el ángulo comprendido entre ellos (criterio LAL)","Solo los tres ángulos del triángulo","Un lado y dos ángulos no adyacentes a él","Las tres alturas del triángulo"]', 0, 'Conocer dos lados y el ángulo comprendido entre ellos (Lado-Ángulo-Lado) permite construir un único triángulo.', 'avanzada', 120),

  ('Área y volumen de prismas y pirámides', '¿Cuál es el volumen de un prisma rectangular de 4 cm de largo, 3 cm de ancho y 5 cm de alto?', '["60 cm³","12 cm³","35 cm³","70 cm³"]', 0, 'El volumen de un prisma rectangular es largo × ancho × alto: 4 × 3 × 5 = 60 cm³.', 'inicial', 60),
  ('Área y volumen de prismas y pirámides', 'Una pirámide tiene un volumen de 120 cm³ y su base tiene un área de 30 cm². ¿Cuál es su altura?', '["12 cm","4 cm","36 cm","10 cm"]', 0, 'El volumen de una pirámide es (1/3) × área de la base × altura. Despejando: altura = (3 × 120) / 30 = 12 cm.', 'intermedia', 90),
  ('Área y volumen de prismas y pirámides', '¿Cuál es el área total de un prisma cuya base es un cuadrado de 4 cm de lado y cuya altura es 6 cm?', '["128 cm²","96 cm²","112 cm²","144 cm²"]', 0, 'El área total es 2 veces el área de la base más el área lateral: 2×(4×4) + 4×(4×6) = 32 + 96 = 128 cm².', 'intermedia', 90),
  ('Área y volumen de prismas y pirámides', 'Una pirámide de base cuadrada tiene lado de la base 6 cm y altura 8 cm. ¿Cuál es su volumen?', '["96 cm³","288 cm³","48 cm³","144 cm³"]', 0, 'El área de la base es 6×6 = 36 cm². El volumen es (1/3) × 36 × 8 = 96 cm³.', 'avanzada', 120),

  ('Teorema de Pitágoras', 'En un triángulo rectángulo, los catetos miden 3 cm y 4 cm. ¿Cuánto mide la hipotenusa?', '["5 cm","7 cm","12 cm","25 cm"]', 0, 'Por el teorema de Pitágoras: hipotenusa² = 3² + 4² = 9 + 16 = 25, por lo que la hipotenusa mide 5 cm.', 'inicial', 60),
  ('Teorema de Pitágoras', 'La hipotenusa de un triángulo rectángulo mide 13 cm y uno de sus catetos mide 5 cm. ¿Cuánto mide el otro cateto?', '["12 cm","8 cm","18 cm","144 cm"]', 0, 'Despejando: cateto² = 13² - 5² = 169 - 25 = 144, por lo que el cateto mide 12 cm.', 'intermedia', 90),
  ('Teorema de Pitágoras', '¿Cuál de los siguientes tríos de números NO corresponde a los lados de un triángulo rectángulo?', '["6, 8, 10","5, 12, 13","8, 15, 17","4, 6, 8"]', 3, 'En un triángulo rectángulo, el cuadrado del lado mayor debe ser igual a la suma de los cuadrados de los otros dos. Para 4, 6, 8: 4² + 6² = 16 + 36 = 52, que no es igual a 8² = 64.', 'intermedia', 90),
  ('Teorema de Pitágoras', 'Una escalera de 10 m se apoya en una pared, con su base a 6 m de la pared. ¿A qué altura de la pared llega la escalera?', '["8 m","6 m","16 m","4 m"]', 0, 'Por el teorema de Pitágoras: altura² = 10² - 6² = 100 - 36 = 64, por lo que la altura es 8 m.', 'avanzada', 120),

  ('Ángulos interiores de polígonos', '¿Cuánto suman los ángulos interiores de un triángulo?', '["180°","360°","90°","270°"]', 0, 'La suma de los ángulos interiores de cualquier triángulo siempre es 180°.', 'inicial', 60),
  ('Ángulos interiores de polígonos', '¿Cuánto suman los ángulos interiores de un cuadrilátero?', '["360°","180°","540°","720°"]', 0, 'Un cuadrilátero se puede dividir en 2 triángulos, cada uno con 180°: 2 × 180° = 360°.', 'intermedia', 90),
  ('Ángulos interiores de polígonos', '¿Cuál es la suma de los ángulos interiores de un pentágono (5 lados)?', '["540°","450°","360°","900°"]', 0, 'La fórmula general es (n - 2) × 180°. Para n = 5: (5 - 2) × 180° = 540°.', 'intermedia', 90),
  ('Ángulos interiores de polígonos', 'Un hexágono regular (6 lados) tiene todos sus ángulos interiores iguales. ¿Cuánto mide cada ángulo interior?', '["120°","108°","135°","144°"]', 0, 'La suma total es (6 - 2) × 180° = 720°. Al ser regular, cada ángulo mide 720° ÷ 6 = 120°.', 'avanzada', 120),

  ('Construcciones con regla y compás', '¿Qué instrumento se usa, junto con la regla, para trazar la mediatriz de un segmento?', '["El compás","El transportador","La escuadra","El goniómetro"]', 0, 'La mediatriz se construye trazando arcos con el compás desde ambos extremos del segmento, con el mismo radio.', 'inicial', 60),
  ('Construcciones con regla y compás', '¿Qué representa la mediatriz de un segmento?', '["La recta perpendicular al segmento que pasa por su punto medio","La recta que biseca un ángulo","La recta paralela al segmento","El punto medio del segmento"]', 0, 'Por definición, la mediatriz de un segmento es la recta perpendicular a él que pasa exactamente por su punto medio.', 'intermedia', 90),
  ('Construcciones con regla y compás', 'Al construir la bisectriz de un ángulo con regla y compás, ¿qué se obtiene?', '["Una recta que divide al ángulo en dos ángulos de igual medida","Una recta perpendicular a uno de los lados del ángulo","Un segmento paralelo a uno de los lados","Un punto equidistante de los tres vértices de un triángulo"]', 0, 'La bisectriz de un ángulo es la recta que lo divide en dos ángulos congruentes.', 'intermedia', 90),
  ('Construcciones con regla y compás', 'Para construir un triángulo equilátero de lado 5 cm usando solo regla y compás, ¿cuál es el procedimiento correcto?', '["Trazar un segmento de 5 cm y, con centro en cada extremo y radio 5 cm, trazar dos arcos que se intersecten","Trazar un segmento de 5 cm y bisecarlo tres veces","Trazar tres segmentos de distinta longitud y unir sus extremos","Trazar un círculo de radio 5 cm e inscribir un triángulo cualquiera"]', 0, 'Los dos arcos de radio igual al lado, trazados desde cada extremo del segmento, se intersectan en el punto que forma el tercer vértice del triángulo equilátero.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Geometría')
      and name = 'Geometría — 7° Básico'
  )
cross join (select id from public.levels where code = 'regular_7_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: PROBABILIDAD Y ESTADÍSTICA — 7° BÁSICO (5 objetivos x 4 preguntas = 20)
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
  ('Medidas de tendencia central y de posición', '¿Cuál es la media (promedio) de los datos 4, 6, 8, 10, 12?', '["8","6","10","40"]', 0, 'La media es la suma de los datos dividida por su cantidad: (4+6+8+10+12)/5 = 40/5 = 8.', 'inicial', 60),
  ('Medidas de tendencia central y de posición', '¿Cuál es la mediana del conjunto de datos 3, 7, 9, 12, 15?', '["9","7","12","9,2"]', 0, 'Con 5 datos ya ordenados, la mediana es el valor central: 9.', 'intermedia', 90),
  ('Medidas de tendencia central y de posición', 'En el conjunto de datos 2, 2, 3, 5, 5, 5, 8, ¿cuál es la moda?', '["5","2","3","8"]', 0, 'La moda es el valor que más se repite. El 5 aparece 3 veces, más que cualquier otro dato.', 'intermedia', 90),
  ('Medidas de tendencia central y de posición', 'Un conjunto de 20 datos está ordenado de menor a mayor. ¿Qué percentil corresponde aproximadamente al dato ubicado en la posición 15?', '["Percentil 75","Percentil 15","Percentil 60","Percentil 20"]', 0, 'La posición relativa es 15/20 = 0,75, es decir, el 75% de los datos están en esa posición o antes: percentil 75.', 'avanzada', 120),

  ('Comparación de poblaciones y muestras', '¿Cuál es la diferencia principal entre una población y una muestra en estadística?', '["La muestra es un subconjunto de la población","La población siempre es más pequeña que la muestra","No hay diferencia, son sinónimos","La muestra incluye solo datos falsos"]', 0, 'Una muestra es una parte (subconjunto) seleccionada de la población total que se quiere estudiar.', 'inicial', 60),
  ('Comparación de poblaciones y muestras', 'Dos cursos rinden la misma prueba. El curso A tiene un promedio de 5,8 y el curso B de 5,2. ¿Qué se puede afirmar con esta sola información?', '["En promedio, el curso A obtuvo mejores resultados que el curso B","Todos los estudiantes del curso A sacaron mejor nota que los del curso B","El curso B tuvo más estudiantes que el curso A","Los dos cursos tuvieron resultados idénticos"]', 0, 'El promedio más alto indica un mejor rendimiento general del curso A, pero no garantiza que cada estudiante individual haya superado a los del curso B.', 'intermedia', 90),
  ('Comparación de poblaciones y muestras', 'Si se quiere comparar el rendimiento de dos poblaciones con promedios similares, ¿qué otra medida es útil considerar?', '["La dispersión de los datos (por ejemplo, el rango)","El nombre de los estudiantes","La fecha de la evaluación","El color usado en el gráfico"]', 0, 'Cuando los promedios son similares, medir la dispersión (rango, por ejemplo) ayuda a saber qué tan parejos o variables son los resultados de cada grupo.', 'intermedia', 90),
  ('Comparación de poblaciones y muestras', 'Un estudio compara los ingresos de dos comunas usando la media. En la comuna X, un ingreso extremadamente alto sube el promedio general. ¿Qué medida representaría mejor a la mayoría de la población en este caso?', '["La mediana, porque no se ve afectada por valores extremos","La media, porque siempre es representativa","La moda de los ingresos más bajos","El rango de los ingresos"]', 0, 'La mediana no se ve alterada por valores extremos (outliers) como sí le ocurre a la media, por lo que representa mejor a la mayoría de los datos en este caso.', 'avanzada', 120),

  ('Probabilidad de eventos simples y compuestos', 'Al lanzar un dado de 6 caras, ¿cuál es la probabilidad de obtener un número par?', '["1/2","1/3","1/6","2/3"]', 0, 'Hay 3 números pares (2, 4, 6) de 6 posibles: 3/6 = 1/2.', 'inicial', 60),
  ('Probabilidad de eventos simples y compuestos', 'Se lanza una moneda y luego un dado. ¿Cuál es la probabilidad de obtener "cara" y un número mayor que 4?', '["1/6","1/2","1/3","1/12"]', 0, 'P(cara) = 1/2 y P(número mayor que 4) = 2/6 = 1/3. Como son eventos independientes, se multiplican: 1/2 × 1/3 = 1/6.', 'intermedia', 90),
  ('Probabilidad de eventos simples y compuestos', 'En una bolsa hay 4 bolitas rojas y 6 azules. ¿Cuál es la probabilidad de sacar una bolita roja?', '["2/5","3/5","1/4","1/6"]', 0, 'Hay 10 bolitas en total y 4 son rojas: 4/10 = 2/5.', 'intermedia', 90),
  ('Probabilidad de eventos simples y compuestos', 'Se lanzan dos dados. ¿Cuál es la probabilidad de que la suma de los resultados sea 7?', '["1/6","1/12","1/36","1/4"]', 0, 'De los 36 resultados posibles, 6 combinaciones suman 7 (1-6, 2-5, 3-4, 4-3, 5-2, 6-1): 6/36 = 1/6.', 'avanzada', 120),

  ('Recolección de datos y tipos de muestreo', '¿Qué tipo de muestreo consiste en seleccionar al azar a los participantes, de modo que todos tengan la misma probabilidad de ser elegidos?', '["Muestreo aleatorio simple","Muestreo por conveniencia","Muestreo intencionado","Censo"]', 0, 'En el muestreo aleatorio simple, cada elemento de la población tiene la misma probabilidad de ser seleccionado.', 'inicial', 60),
  ('Recolección de datos y tipos de muestreo', 'Un investigador encuesta solo a las personas que pasan frente a su oficina. ¿Qué tipo de muestreo está usando y qué problema tiene?', '["Muestreo por conveniencia; puede no representar a toda la población","Muestreo aleatorio simple; siempre es representativo","Censo; incluye a toda la población","Muestreo estratificado; es el más preciso"]', 0, 'Encuestar solo a quienes pasan por un lugar específico es muestreo por conveniencia, que puede introducir sesgo porque no todos tienen la misma probabilidad de ser encuestados.', 'intermedia', 90),
  ('Recolección de datos y tipos de muestreo', 'Para estudiar la opinión de estudiantes de un colegio, se selecciona una cantidad proporcional de estudiantes de cada curso. ¿Qué tipo de muestreo es este?', '["Muestreo estratificado","Muestreo por conveniencia","Muestreo sistemático","Censo"]', 0, 'Dividir la población en grupos (estratos, en este caso los cursos) y elegir proporcionalmente de cada uno es muestreo estratificado.', 'intermedia', 90),
  ('Recolección de datos y tipos de muestreo', 'Una encuesta telefónica solo llama a números de teléfonos fijos para estudiar hábitos de uso de internet. ¿Cuál es la principal limitación de esta muestra?', '["Puede excluir a personas que solo usan celular, sesgando los resultados","No tiene ninguna limitación, es representativa","Incluye a toda la población por igual","El costo es demasiado alto para ser válida"]', 0, 'Si se excluye a quienes no tienen teléfono fijo (por ejemplo, personas que solo usan celular), la muestra puede no representar a toda la población, generando un sesgo.', 'avanzada', 120),

  ('Espacio muestral de un experimento', '¿Cuál es el espacio muestral al lanzar una moneda?', '["{cara, sello}","{cara}","{sello}","{cara, sello, ninguno}"]', 0, 'El espacio muestral incluye todos los resultados posibles de un experimento; al lanzar una moneda, son cara y sello.', 'inicial', 60),
  ('Espacio muestral de un experimento', '¿Cuántos elementos tiene el espacio muestral al lanzar un dado de 6 caras dos veces?', '["36","12","6","72"]', 0, 'Cada lanzamiento tiene 6 resultados posibles; al combinar dos lanzamientos: 6 × 6 = 36.', 'intermedia', 90),
  ('Espacio muestral de un experimento', 'Al lanzar dos monedas, ¿cuál es el espacio muestral correcto?', '["{CC, CS, SC, SS}","{CC, SS}","{C, S}","{CC, CS, SS}"]', 0, 'Cada moneda tiene 2 resultados posibles, por lo que hay 2×2 = 4 combinaciones distintas: CC, CS, SC y SS.', 'intermedia', 90),
  ('Espacio muestral de un experimento', 'Un experimento consiste en sacar una bolita de una bolsa con 3 colores (rojo, azul, verde) y lanzar una moneda. ¿Cuántos elementos tiene el espacio muestral compuesto?', '["6","5","9","3"]', 0, 'Hay 3 resultados posibles al sacar la bolita y 2 al lanzar la moneda: 3 × 2 = 6 combinaciones posibles.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Matemática') and name = 'Probabilidad y Estadística')
      and name = 'Probabilidad y Estadística — 7° Básico'
  )
cross join (select id from public.levels where code = 'regular_7_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );
