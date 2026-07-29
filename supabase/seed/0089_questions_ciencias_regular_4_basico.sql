-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 4° Básico. Cubre los 14 objetivos de aprendizaje de 4° Básico
-- cargados por supabase/seed/0017_curriculum_ciencias_regular_basica_1_6.sql,
-- con 4 preguntas por objetivo, total 56 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí).

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la función principal del sistema esquelético?', '["Dar soporte y forma al cuerpo","Digerir los alimentos","Bombear la sangre","Producir sonidos"]', 0, 'El sistema esquelético da soporte y forma al cuerpo, además de proteger órganos internos.', 'inicial', 25),
  ('¿Qué función cumplen los músculos en el cuerpo humano, junto con los huesos?', '["Permitir el movimiento del cuerpo","Filtrar el aire que respiramos","Producir imágenes en los ojos","Almacenar recuerdos"]', 1, 'Los músculos, junto con los huesos, permiten el movimiento del cuerpo.', 'intermedia', 35),
  ('¿Cuál de estas acciones depende principalmente del trabajo conjunto de huesos y músculos?', '["Caminar hacia la escuela","Escuchar una canción","Oler una flor","Ver un color"]', 2, 'Caminar depende del trabajo conjunto de los huesos, que dan soporte, y los músculos, que generan el movimiento.', 'intermedia', 35),
  ('Un estudiante se fractura un hueso de la pierna y no puede moverla con normalidad durante varias semanas. ¿Qué relación muestra esta situación entre el sistema esquelético y el movimiento?', '["El sistema esquelético no tiene relación con el movimiento","Los huesos dan soporte necesario para que los músculos generen el movimiento correctamente","El sistema muscular funciona igual sin importar los huesos","El movimiento depende solo de los músculos, sin relación con los huesos"]', 3, 'Esta situación muestra que los huesos son necesarios como soporte para que los músculos puedan generar movimiento de forma correcta.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_4_basico' and lo.short_name = 'Sistema esquelético y muscular'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la función principal del sistema nervioso?', '["Coordinar y controlar las funciones del cuerpo","Producir sonidos musicales","Fabricar huesos nuevos","Dar color a la piel"]', 0, 'El sistema nervioso coordina y controla las funciones del cuerpo, procesando la información de los sentidos.', 'inicial', 25),
  ('¿Qué órgano de los sentidos usamos principalmente para percibir los olores?', '["Los ojos","La nariz","Los oídos","La lengua"]', 1, 'La nariz es el órgano de los sentidos que usamos principalmente para percibir los olores.', 'intermedia', 35),
  ('¿Qué relación existe entre los órganos de los sentidos y el sistema nervioso?', '["No tienen ninguna relación entre sí","Los órganos de los sentidos envían información al sistema nervioso para que la procese","El sistema nervioso reemplaza a los órganos de los sentidos","Los órganos de los sentidos controlan al sistema nervioso"]', 2, 'Los órganos de los sentidos captan información del entorno y la envían al sistema nervioso, que la procesa.', 'intermedia', 35),
  ('Un estudiante toca accidentalmente una superficie muy caliente y retira la mano de inmediato. ¿Qué órgano de los sentidos detectó el estímulo y qué sistema procesó la información para generar la reacción?', '["La lengua detectó el estímulo y el sistema esquelético lo procesó","El oído detectó el estímulo y el sistema muscular lo procesó","La piel (tacto) detectó el estímulo y el sistema nervioso lo procesó","Los ojos detectaron el estímulo y el sistema digestivo lo procesó"]', 3, 'La piel, a través del sentido del tacto, detecta el calor, y el sistema nervioso procesa esa información para generar la reacción de retirar la mano.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_4_basico' and lo.short_name = 'Sistema nervioso y órganos de los sentidos'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué representa una cadena alimentaria?', '["El orden en que unos seres vivos se alimentan de otros","La lista de comidas favoritas de una persona","El horario de comidas de un colegio","El tamaño de los animales de un zoológico"]', 0, 'Una cadena alimentaria representa el orden en que unos seres vivos se alimentan de otros.', 'inicial', 25),
  ('En una cadena alimentaria simple (pasto → conejo → zorro), ¿qué rol cumple el conejo?', '["Es un productor","Es un consumidor","Es un descomponedor","No cumple ningún rol"]', 1, 'El conejo es un consumidor, ya que se alimenta del pasto (productor).', 'intermedia', 35),
  ('¿Cuál de estos seres vivos cumple el rol de productor en una cadena alimentaria?', '["El zorro","El conejo","El pasto","El águila"]', 2, 'El pasto es un productor porque elabora su propio alimento mediante la fotosíntesis.', 'intermedia', 35),
  ('Un estudiante arma la cadena alimentaria: alga → pez pequeño → pez grande. Si el pez pequeño desaparece de este ecosistema, ¿qué es lo más probable que ocurra con el pez grande?', '["No se vería afectado en absoluto","Tendría menos alimento disponible y podría verse afectado","Se alimentaría directamente del alga sin problema","Se convertiría en productor"]', 3, 'Si el pez pequeño desaparece, el pez grande, que depende de él como alimento, tendría menos alimento disponible.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_4_basico' and lo.short_name = 'Cadenas alimentarias simples'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la función principal de la raíz de una planta?', '["Absorber agua y nutrientes del suelo","Producir flores","Realizar la fotosíntesis principalmente","Producir frutos"]', 0, 'La raíz cumple principalmente la función de absorber agua y nutrientes del suelo.', 'inicial', 25),
  ('¿Qué función cumple el tallo en una planta?', '["Absorber agua directamente del suelo","Transportar agua y nutrientes entre la raíz y las hojas","Producir semillas exclusivamente","Percibir la luz solar como un ojo"]', 1, 'El tallo transporta agua y nutrientes entre la raíz y las hojas, y sostiene a la planta.', 'intermedia', 35),
  ('¿Cuál es la función principal de las hojas en la mayoría de las plantas?', '["Absorber agua del suelo","Sostener el peso de la planta","Realizar la fotosíntesis para producir alimento","Anclar la planta al suelo"]', 2, 'Las hojas realizan principalmente la fotosíntesis, proceso mediante el cual la planta produce su alimento.', 'intermedia', 35),
  ('Un estudiante corta el tallo de una planta a la mitad, sin dañar la raíz ni las hojas por separado. Aun así, la planta comienza a marchitarse. ¿Qué explica mejor lo ocurrido, considerando las funciones de raíz, tallo y hoja?', '["Las hojas dejaron de necesitar agua","El tallo, al estar dañado, no puede transportar agua y nutrientes entre la raíz y las hojas","La raíz dejó de existir","Las hojas absorbieron agua directamente sin necesitar el tallo"]', 3, 'Al dañarse el tallo, se interrumpe el transporte de agua y nutrientes entre la raíz y las hojas, lo que afecta a toda la planta.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_4_basico' and lo.short_name = 'Función de la raíz, el tallo y la hoja en las plantas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se necesita como mínimo para armar un circuito eléctrico simple que encienda una ampolleta?', '["Una pila, cables y una ampolleta conectados en un camino cerrado","Solo una ampolleta sola","Solo cables sin ninguna fuente de energía","Agua y una piedra"]', 0, 'Un circuito eléctrico simple necesita una fuente de energía (pila), cables y una ampolleta conectados en un camino cerrado.', 'inicial', 25),
  ('¿Qué ocurre si se interrumpe el camino de un circuito eléctrico simple, por ejemplo desconectando un cable?', '["La ampolleta se enciende con más fuerza","La ampolleta deja de encenderse","No cambia nada","La pila se llena de energía extra"]', 1, 'Si se interrumpe el camino del circuito, la corriente eléctrica no puede circular y la ampolleta deja de encenderse.', 'intermedia', 35),
  ('¿Cuál de estos elementos cumple la función de fuente de energía en un circuito eléctrico simple?', '["El cable","La ampolleta","La pila","El interruptor apagado"]', 2, 'La pila cumple la función de fuente de energía en un circuito eléctrico simple.', 'intermedia', 35),
  ('Un estudiante arma un circuito con una pila, cables y una ampolleta, pero esta no enciende. Al revisar, nota que uno de los cables no está bien conectado a la pila. ¿Qué explica que la ampolleta no encienda?', '["La ampolleta está rota necesariamente","El circuito no forma un camino cerrado, por lo que la corriente no circula","La pila tiene demasiada energía","Los cables no son necesarios en un circuito"]', 3, 'Si el cable no está bien conectado, el circuito no forma un camino cerrado y la corriente eléctrica no puede circular hasta la ampolleta.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_4_basico' and lo.short_name = 'Circuitos eléctricos simples'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿En qué se transforma la energía eléctrica cuando enciendes una ampolleta?', '["En energía luminosa (y algo de calor)","En energía del sonido únicamente","En energía química pura","En energía nuclear"]', 0, 'La energía eléctrica se transforma en energía luminosa (y algo de calor) al encender una ampolleta.', 'inicial', 25),
  ('¿En qué se transforma la energía química de una pila al usarse en una linterna?', '["En energía eléctrica, que luego se transforma en luz","En energía del viento","En energía sonora directamente","En energía nuclear"]', 1, 'La energía química de la pila se transforma en energía eléctrica, que luego se transforma en luz.', 'intermedia', 35),
  ('¿Cuál de estas situaciones muestra una transformación de energía de movimiento a energía eléctrica?', '["Una dinamo de bicicleta que enciende una luz al pedalear","Una vela encendida sin moverse","Un imán quieto sobre una mesa","Un vaso de agua evaporándose"]', 2, 'Una dinamo de bicicleta transforma la energía del movimiento (pedaleo) en energía eléctrica.', 'intermedia', 35),
  ('Un estudiante observa que, al frotar sus manos rápidamente, estas se calientan. ¿Qué transformación de energía explica este fenómeno?', '["Energía eléctrica en energía sonora","Energía luminosa en energía química","Energía nuclear en energía eléctrica","Energía de movimiento en energía calórica"]', 3, 'El frotamiento de las manos transforma la energía del movimiento en energía calórica, lo que produce la sensación de calor.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_4_basico' and lo.short_name = 'Transformación de la energía'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué característica del sonido se relaciona con qué tan fuerte o suave se escucha?', '["El volumen","El tono","El color","El sabor"]', 0, 'El volumen es la característica del sonido relacionada con qué tan fuerte o suave se escucha.', 'inicial', 25),
  ('¿Qué característica del sonido diferencia un sonido agudo (como el de un silbato) de uno grave (como el de un tambor grande)?', '["El volumen","El tono","La duración","El color"]', 1, 'El tono es la característica que diferencia los sonidos agudos de los graves.', 'intermedia', 35),
  ('¿Cómo se produce el sonido en general?', '["Por la vibración de un objeto","Por el color de un objeto","Por el peso de un objeto","Por la temperatura de un objeto"]', 2, 'El sonido se produce por la vibración de un objeto, que se transmite a través del aire u otro medio.', 'intermedia', 35),
  ('Un estudiante golpea suavemente un tambor y luego lo golpea con mucha más fuerza. ¿Qué característica del sonido cambia principalmente entre ambos golpes?', '["El tono del sonido","El color del tambor","El sabor del sonido","El volumen del sonido"]', 3, 'Al golpear con más fuerza, principalmente cambia el volumen del sonido producido, que se escucha más fuerte.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_4_basico' and lo.short_name = 'El sonido y sus características'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos materiales es un buen conductor de electricidad?', '["El cobre","La madera seca","El plástico","El vidrio"]', 0, 'El cobre es un buen conductor de electricidad, por eso se usa en los cables eléctricos.', 'inicial', 25),
  ('¿Cuál de estos materiales es un buen aislante de electricidad?', '["El aluminio","El hierro","El plástico","El cobre"]', 1, 'El plástico es un buen aislante de electricidad, por eso se usa para recubrir los cables.', 'intermedia', 35),
  ('¿Por qué los cables eléctricos suelen tener un recubrimiento de plástico o goma alrededor del metal conductor?', '["Para que se vean más bonitos","Para aislar y evitar descargas eléctricas al tocarlos","Para que conduzcan más electricidad","Para que pesen menos"]', 2, 'El recubrimiento aislante evita descargas eléctricas al tocar el cable, protegiendo a las personas.', 'intermedia', 35),
  ('Un estudiante arma un circuito y prueba distintos materiales para ver cuáles permiten que la ampolleta encienda: una moneda de metal, un trozo de madera y una cuchara de metal. ¿Qué materiales permitirían que la ampolleta encienda?', '["Solo el trozo de madera","La moneda y la cuchara de metal, porque son conductores","Ninguno de los tres materiales","Los tres materiales por igual"]', 3, 'La moneda y la cuchara de metal son materiales conductores de electricidad, por lo que permitirían que la ampolleta encienda; la madera es aislante.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_4_basico' and lo.short_name = 'Conductores y aislantes de electricidad'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una de las principales capas que componen la Tierra?', '["El núcleo","La atmósfera exterior","La Luna","El Sol"]', 0, 'El núcleo es una de las principales capas internas que componen la Tierra.', 'inicial', 25),
  ('¿Cuál es la capa más externa y delgada de la Tierra, sobre la que vivimos?', '["El núcleo","El manto","La corteza","El sol"]', 1, 'La corteza es la capa más externa y delgada de la Tierra, sobre la que vivimos.', 'intermedia', 35),
  ('¿Cuál de estas capas de la Tierra se encuentra entre la corteza y el núcleo?', '["La atmósfera","El manto","El espacio exterior","La Luna"]', 2, 'El manto es la capa que se encuentra entre la corteza y el núcleo de la Tierra.', 'intermedia', 35),
  ('Un estudiante arma una maqueta de la Tierra con tres capas: una capa fina exterior, una capa intermedia gruesa y una esfera central. ¿Qué representan, en orden desde afuera hacia adentro, estas tres partes?', '["Núcleo, manto y corteza","Manto, corteza y núcleo","Corteza, núcleo y manto","Corteza, manto y núcleo"]', 3, 'De afuera hacia adentro, las capas de la Tierra son: corteza, manto y núcleo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_4_basico' and lo.short_name = 'Capas de la Tierra'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas etapas forma parte del ciclo del agua?', '["La evaporación","La combustión","La fotosíntesis exclusivamente","La respiración"]', 0, 'La evaporación es una de las etapas del ciclo del agua.', 'inicial', 25),
  ('¿Qué ocurre durante la etapa de condensación del ciclo del agua?', '["El agua se transforma en vapor y sube","El vapor de agua se enfría y forma nubes","El agua cae en forma de lluvia","El agua se filtra en el suelo"]', 1, 'Durante la condensación, el vapor de agua se enfría y forma pequeñas gotas que dan origen a las nubes.', 'intermedia', 35),
  ('¿Qué etapa del ciclo del agua ocurre cuando el agua cae desde las nubes en forma de lluvia, nieve o granizo?', '["Evaporación","Condensación","Precipitación","Sublimación exclusiva"]', 2, 'La precipitación es la etapa en la que el agua cae desde las nubes en forma de lluvia, nieve o granizo.', 'intermedia', 35),
  ('Un estudiante observa que el agua de un charco desaparece en un día soleado, y días después llueve. ¿Qué relación existe entre estos dos hechos según el ciclo del agua?', '["No tienen ninguna relación","El agua del charco se evaporó, subió, se condensó formando nubes y luego cayó como lluvia","El agua del charco se convirtió directamente en hielo","La lluvia no tiene relación con la evaporación del agua"]', 3, 'El agua del charco se evaporó, subió a la atmósfera, se condensó formando nubes y finalmente cayó en forma de lluvia, mostrando el ciclo del agua.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_4_basico' and lo.short_name = 'El ciclo del agua'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un fenómeno natural de la Tierra?', '["Un terremoto","Un partido de fútbol","Una fiesta de cumpleaños","Una clase de matemáticas"]', 0, 'Un terremoto es un fenómeno natural relacionado con el movimiento de la Tierra.', 'inicial', 25),
  ('¿Qué es una erupción volcánica?', '["La salida de material desde el interior de la Tierra a través de un volcán","Un tipo de nube muy oscura","Un movimiento del agua del mar","Un cambio en la posición de las estrellas"]', 1, 'Una erupción volcánica es la salida de material (lava, gases, cenizas) desde el interior de la Tierra a través de un volcán.', 'intermedia', 35),
  ('¿Cuál de estas medidas ayuda a estar más seguro durante un terremoto?', '["Correr sin rumbo por la calle","Alejarse de objetos que puedan caer y protegerse en un lugar seguro","Quedarse justo debajo de una repisa llena de objetos","Salir corriendo por un ascensor"]', 2, 'Alejarse de objetos que puedan caer y protegerse en un lugar seguro es una medida adecuada durante un terremoto.', 'intermedia', 35),
  ('Chile se ubica en una zona donde ocurren frecuentemente terremotos y existen varios volcanes activos. ¿Qué relación tiene esto con la ubicación geológica del país?', '["Chile no tiene ninguna relación con fenómenos geológicos","Chile se ubica en una zona de gran actividad geológica, relacionada con el movimiento de las capas de la Tierra","Los terremotos en Chile no tienen relación con la estructura de la Tierra","Los volcanes de Chile no están relacionados con los terremotos"]', 3, 'Chile se ubica en una zona de gran actividad geológica, lo que explica la frecuencia de terremotos y la presencia de volcanes activos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_4_basico' and lo.short_name = 'Fenómenos naturales de la Tierra'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un estudiante quiere investigar si la cantidad de luz afecta el crecimiento de una planta. ¿Qué variable debería mantener igual (constante) para que el experimento sea justo?', '["La cantidad de agua y tierra que recibe cada planta","El color de la maceta únicamente","El nombre que le pone a cada planta","El día de la semana en que riega la planta"]', 0, 'Para que el experimento sea justo, se debe mantener constante la cantidad de agua y tierra, variando solo la cantidad de luz.', 'inicial', 25),
  ('¿Por qué es importante controlar variables en un experimento simple?', '["Para que el experimento dure más tiempo","Para poder atribuir los resultados a la variable que realmente se está estudiando","Porque no influye en los resultados","Para complicar el experimento sin necesidad"]', 1, 'Controlar variables permite atribuir los resultados observados a la variable que se está estudiando, y no a otros factores.', 'intermedia', 35),
  ('Un grupo de estudiantes compara el crecimiento de dos plantas, pero una recibe más agua y también más luz que la otra. ¿Qué problema tiene este experimento?', '["Ningún problema, está bien diseñado","No se puede saber si el crecimiento se debe al agua, a la luz o a ambas variables juntas","El experimento es perfecto porque usa varias variables","Las plantas crecerán exactamente igual de todas formas"]', 2, 'Al cambiar dos variables (agua y luz) al mismo tiempo, no se puede saber cuál de ellas causó la diferencia en el crecimiento.', 'intermedia', 35),
  ('Un estudiante diseña un experimento para saber si la temperatura del agua afecta la velocidad con que se disuelve el azúcar. Usa la misma cantidad de agua y de azúcar en ambos vasos, cambiando solo la temperatura. ¿Por qué este diseño es adecuado para controlar variables?', '["Porque usa dos vasos distintos","Porque mantiene constante todo excepto la variable que quiere estudiar (la temperatura)","Porque usa azúcar en vez de sal","Porque no es necesario controlar ninguna variable en este caso"]', 3, 'El diseño es adecuado porque mantiene constante la cantidad de agua y azúcar, variando únicamente la temperatura, que es la variable en estudio.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_4_basico' and lo.short_name = 'Control de variables en un experimento simple'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Para qué sirve registrar datos en una tabla durante una investigación?', '["Para organizar la información de forma ordenada y clara","Para que la investigación sea más difícil de entender","Para reemplazar la necesidad de observar","Para ocultar los resultados obtenidos"]', 0, 'Registrar datos en una tabla ayuda a organizar la información de forma ordenada y clara.', 'inicial', 25),
  ('¿Cuál de estas representaciones es más adecuada para comparar visualmente el crecimiento de tres plantas distintas a lo largo de un mes?', '["Un gráfico de barras","Un dibujo sin datos numéricos","Un poema","Una canción"]', 1, 'Un gráfico de barras permite comparar visualmente datos numéricos, como el crecimiento de distintas plantas.', 'intermedia', 35),
  ('Un estudiante mide la altura de una planta cada semana durante un mes y anota los datos en una tabla. ¿Qué ventaja tiene registrar estos datos en una tabla en vez de solo recordarlos de memoria?', '["Ninguna ventaja, es igual de útil recordarlos de memoria","Permite comparar los datos de forma precisa y no depender solo de la memoria","Hace que el experimento sea más lento","Impide comparar los resultados"]', 2, 'Registrar los datos en una tabla permite compararlos de forma precisa, sin depender únicamente de la memoria.', 'intermedia', 35),
  ('Un estudiante registró en una tabla la altura de su planta cada semana: semana 1: 5 cm, semana 2: 8 cm, semana 3: 12 cm, semana 4: 15 cm. Si transforma estos datos en un gráfico de barras, ¿qué mostraría ese gráfico?', '["Que la planta no cambió de tamaño","Que la altura de la planta disminuyó cada semana","Que la altura de la planta no se puede representar en un gráfico","Que la altura de la planta aumentó progresivamente cada semana"]', 3, 'El gráfico de barras mostraría que la altura de la planta aumentó progresivamente semana a semana, según los datos registrados.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_4_basico' and lo.short_name = 'Registro de datos en tablas y gráficos simples'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 4° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un estudiante predijo que un cubo de hielo se derretiría más rápido en agua caliente que en agua fría, y luego comprobó que efectivamente ocurrió así. ¿Qué se puede decir al comparar su predicción con los resultados?', '["El resultado coincidió con la predicción","El resultado contradijo la predicción","La predicción no tenía relación con el experimento","No es posible comparar predicción y resultado"]', 0, 'Cuando lo observado coincide con lo predicho, se dice que el resultado coincidió con la predicción.', 'inicial', 25),
  ('¿Por qué es útil comparar los resultados de un experimento con la predicción hecha antes de realizarlo?', '["Porque permite revisar si nuestras ideas previas se ajustan a la evidencia obtenida","Porque la predicción siempre debe ser correcta","Porque los resultados no importan si la predicción fue distinta","Porque así se evita hacer el experimento"]', 1, 'Comparar predicción y resultados permite revisar si nuestras ideas previas se ajustan a la evidencia real obtenida.', 'intermedia', 35),
  ('Un estudiante predijo que una moneda flotaría en el agua, pero al soltarla, se hundió. ¿Qué debería hacer con su predicción a partir de este resultado?', '["Ignorar el resultado y mantener la predicción original","Reconocer que la predicción no se cumplió y ajustar su idea según la evidencia","Repetir el experimento sin registrar nada","Decir que el agua estaba mal"]', 2, 'Cuando el resultado no coincide con la predicción, se debe reconocer esa diferencia y ajustar la idea según la evidencia obtenida.', 'intermedia', 35),
  ('Dos estudiantes predijeron cosas distintas sobre el mismo experimento: uno predijo que una esponja seca flotaría, y el otro que se hundiría. Al realizar el experimento, la esponja flotó. ¿Qué se puede concluir sobre las predicciones de ambos estudiantes?', '["Ambas predicciones fueron correctas por igual","Ninguna predicción tiene relación con el resultado","La predicción de que flotaría se ajustó al resultado observado; la otra no","El resultado no permite evaluar ninguna predicción"]', 3, 'La predicción de que la esponja flotaría se ajustó al resultado observado, mientras que la predicción de que se hundiría no se cumplió.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_4_basico' and lo.short_name = 'Comparación de resultados con predicciones'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
