-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 3° Básico. Cubre los 14 objetivos de aprendizaje de 3° Básico
-- cargados por supabase/seed/0017_curriculum_ciencias_regular_basica_1_6.sql,
-- con 4 preguntas por objetivo, total 56 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí).

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una característica observable que permite clasificar animales?', '["El tipo de cubierta corporal (plumas, pelo, escamas)","El nombre que le pusieron sus dueños","El país donde vive su dueño","El precio del animal"]', 0, 'El tipo de cubierta corporal es una característica observable útil para clasificar animales.', 'inicial', 25),
  ('¿Cuál de estos grupos está formado por animales con el mismo tipo de cubierta corporal (plumas)?', '["Perro, gato y vaca","Águila, gallina y pingüino","Serpiente, lagarto y tortuga","Pez, tiburón y salmón"]', 1, 'El águila, la gallina y el pingüino son aves y comparten la cubierta corporal de plumas.', 'intermedia', 35),
  ('Un estudiante clasifica plantas según el tipo de hoja que tienen. ¿Qué tipo de característica está usando para clasificar?', '["Una característica del sonido que hacen","Una característica observable de la planta","El precio de la planta","El nombre científico completo"]', 2, 'El tipo de hoja es una característica observable que permite clasificar plantas.', 'intermedia', 35),
  ('Un estudiante observa cuatro animales: un pez con escamas, una serpiente con escamas, un perro con pelo y un loro con plumas. Si debe agrupar por tipo de cubierta corporal, ¿cuáles quedarían en el mismo grupo?', '["El perro y el loro","El pez y el perro","El loro y la serpiente","El pez y la serpiente"]', 3, 'El pez y la serpiente comparten el mismo tipo de cubierta corporal: escamas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_3_basico' and lo.short_name = 'Clasificación de seres vivos según características observables'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una función vital que realizan todos los seres vivos?', '["La nutrición","Usar ropa","Tener nombre propio","Vivir en una casa"]', 0, 'La nutrición es una función vital que realizan todos los seres vivos para obtener energía y nutrientes.', 'inicial', 25),
  ('¿Qué función vital le permite a un ser vivo dar origen a nuevos individuos de su misma especie?', '["La respiración","La reproducción","El movimiento","La digestión"]', 1, 'La reproducción es la función vital que permite dar origen a nuevos individuos de la misma especie.', 'intermedia', 35),
  ('¿Cuál de estas acciones corresponde a la función vital de respiración?', '["Un pez tomando oxígeno del agua con sus branquias","Una planta produciendo semillas","Un perro corriendo por el patio","Un gato durmiendo en el sillón"]', 2, 'Un pez tomando oxígeno del agua con sus branquias es un ejemplo de la función vital de respiración.', 'intermedia', 35),
  ('Un estudiante observa que una planta absorbe agua y nutrientes del suelo, produce flores y semillas, y libera oxígeno. ¿Qué funciones vitales está realizando la planta, en ese orden?', '["Reproducción, nutrición y respiración","Respiración, reproducción y nutrición","Movimiento, nutrición y reproducción","Nutrición, reproducción y respiración"]', 3, 'La planta realiza nutrición al absorber agua y nutrientes, reproducción al producir flores y semillas, y respiración al liberar oxígeno.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_3_basico' and lo.short_name = 'Funciones vitales de los seres vivos'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos es un componente biótico de un ecosistema?', '["Un árbol","Una piedra","El agua de un río","El aire"]', 0, 'Un árbol es un componente biótico porque es un ser vivo.', 'inicial', 25),
  ('¿Cuál de estos elementos es un componente abiótico de un ecosistema?', '["Un pez","Una bacteria","El suelo","Un ave"]', 1, 'El suelo es un componente abiótico porque no es un ser vivo.', 'intermedia', 35),
  ('En un bosque cercano hay árboles, insectos, rocas y aire. ¿Cuáles de estos son componentes bióticos?', '["Las rocas y el aire","Los árboles y el aire","Los árboles y los insectos","Las rocas y los insectos"]', 2, 'Los árboles y los insectos son componentes bióticos porque son seres vivos.', 'intermedia', 35),
  ('Un estudiante lista los elementos de un estanque: peces, algas, agua, piedras y luz solar. Si debe separar los componentes bióticos de los abióticos, ¿cuál de estas listas es correcta?', '["Bióticos: agua y piedras. Abióticos: peces y algas.","Bióticos: peces y algas. Abióticos: agua, piedras y luz solar.","Bióticos: luz solar y agua. Abióticos: peces y piedras.","Bióticos: piedras y luz solar. Abióticos: peces y algas."]', 3, 'Los peces y las algas son seres vivos (bióticos); el agua, las piedras y la luz solar no lo son (abióticos).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_3_basico' and lo.short_name = 'Componentes bióticos y abióticos de un ecosistema'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una relación entre un ser vivo y su ambiente?', '["Una abeja polinizando una flor","Una piedra rodando por una ladera","El viento moviendo las nubes","El agua evaporándose del mar"]', 0, 'Una abeja polinizando una flor es un ejemplo de relación entre un ser vivo y su ambiente.', 'inicial', 25),
  ('¿Qué relación se establece cuando un árbol da sombra y refugio a varios animales?', '["El árbol y los animales no se relacionan","El árbol beneficia a los animales al darles refugio","El árbol daña a los animales","Los animales destruyen siempre al árbol"]', 1, 'El árbol beneficia a los animales al darles sombra y refugio, estableciendo una relación con su ambiente.', 'intermedia', 35),
  ('¿Cuál de estas situaciones muestra una relación de alimentación entre seres vivos de un mismo ecosistema?', '["Un zorro cazando un conejo","Una piedra cayendo al agua","El Sol calentando la tierra","El viento moviendo las hojas secas"]', 2, 'Un zorro cazando un conejo es un ejemplo de relación de alimentación entre seres vivos.', 'intermedia', 35),
  ('Un estudiante observa que las lombrices remueven la tierra de un jardín, lo que ayuda a que las plantas crezcan mejor. ¿Qué tipo de relación describe esta observación?', '["Una relación sin ningún efecto en el ambiente","Una relación en la que un ser vivo modifica su ambiente de forma beneficiosa","Una relación en la que las lombrices dañan siempre a las plantas","Una relación exclusivamente entre objetos no vivos"]', 3, 'Las lombrices modifican el suelo de forma beneficiosa para el crecimiento de las plantas, mostrando una relación entre un ser vivo y su ambiente.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_3_basico' and lo.short_name = 'Relaciones entre los seres vivos y su ambiente'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se forma cuando un objeto opaco bloquea el paso de la luz?', '["Una sombra","Un eco","Un olor","Un imán"]', 0, 'Cuando un objeto opaco bloquea el paso de la luz, se forma una sombra.', 'inicial', 25),
  ('¿Qué ocurre cuando la luz choca contra la superficie de un espejo?', '["Se refleja","Desaparece por completo","Se transforma en sonido","Cambia de color siempre"]', 1, 'Cuando la luz choca contra un espejo, se refleja en otra dirección.', 'intermedia', 35),
  ('¿Cuál de estas situaciones muestra un efecto de la luz sobre un objeto?', '["La sombra de un árbol proyectada en el suelo durante el día","El sonido de un tambor al ser golpeado","El olor de una flor","El sabor de una fruta"]', 2, 'La sombra de un árbol proyectada en el suelo es un efecto de la luz sobre un objeto opaco.', 'intermedia', 35),
  ('Un estudiante coloca un espejo frente a una linterna encendida en una habitación oscura y observa que la luz cambia de dirección al chocar con el espejo. ¿Qué fenómeno de la luz está observando?', '["La absorción total de la luz","La transformación de la luz en sonido","La desaparición de la luz","La reflexión de la luz"]', 3, 'El cambio de dirección de la luz al chocar con una superficie como un espejo corresponde a la reflexión.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_3_basico' and lo.short_name = 'La luz y sus efectos'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una fuente de energía luminosa?', '["El Sol","Un tambor","Un hielo","Una piedra"]', 0, 'El Sol es una fuente de energía luminosa (además de calórica).', 'inicial', 25),
  ('¿Cuál de estas situaciones representa energía en forma de sonido?', '["Una campana sonando","Una vela encendida","Un imán atrayendo un clavo","Agua congelándose"]', 1, 'Una campana sonando representa energía en forma de sonido.', 'intermedia', 35),
  ('¿Cuál de estas fuentes de energía es renovable y proviene del viento?', '["La energía eólica","La energía del carbón","La energía del petróleo","La energía nuclear"]', 2, 'La energía eólica proviene del viento y es una fuente renovable de energía.', 'intermedia', 35),
  ('Un estudiante observa un molino de viento que gira y genera electricidad para su casa. ¿Qué tipo de energía se está transformando en electricidad?', '["La energía química de una pila","La energía del Sol directamente","La energía del movimiento del viento (energía eólica)","La energía del agua de un río"]', 3, 'El molino de viento transforma la energía del movimiento del viento (energía eólica) en electricidad.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_3_basico' and lo.short_name = 'Formas de energía y sus fuentes'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué fuerza hace que un objeto lanzado hacia arriba vuelva a caer al suelo?', '["La fuerza de gravedad","La fuerza magnética","La fuerza del viento","La fuerza eléctrica"]', 0, 'La fuerza de gravedad atrae los objetos hacia el centro de la Tierra, haciendo que caigan.', 'inicial', 25),
  ('¿Qué le ocurriría a una pelota lanzada hacia arriba si no existiera la fuerza de gravedad?', '["Caería igual de rápido","Se quedaría flotando o seguiría alejándose sin volver","Explotaría en el aire","Cambiaría de color"]', 1, 'Sin la fuerza de gravedad, la pelota no sería atraída de vuelta hacia la Tierra.', 'intermedia', 35),
  ('¿Cuál de estas situaciones muestra el efecto de la fuerza de gravedad?', '["Una manzana cayendo de un árbol","Un imán atrayendo un clavo","Una vela encendida","Un globo inflándose"]', 2, 'Una manzana cayendo de un árbol es un ejemplo directo del efecto de la fuerza de gravedad.', 'intermedia', 35),
  ('Un estudiante deja caer al mismo tiempo una pelota de goma y una hoja de papel extendida desde la misma altura. Observa que la pelota llega primero al suelo. ¿Qué se puede concluir sobre la fuerza de gravedad en este caso?', '["Que la gravedad no actúa sobre la hoja de papel","Que la gravedad actúa sobre ambos objetos, pero el aire frena más a la hoja","Que la pelota no fue afectada por la gravedad","Que la hoja de papel no tiene peso"]', 3, 'La gravedad actúa sobre ambos objetos, pero la resistencia del aire frena más a la hoja de papel debido a su forma extendida.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_3_basico' and lo.short_name = 'La fuerza de gravedad'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué cambio se produce en una pelota de plastilina al aplastarla con la mano?', '["Cambia de forma","Cambia de color","Desaparece","Se vuelve líquida"]', 0, 'Al aplastar la plastilina con la mano, se aplica una fuerza que cambia su forma.', 'inicial', 25),
  ('¿Qué cambio produce una fuerza al empujar suavemente una pelota que está detenida?', '["No produce ningún cambio","Hace que la pelota comience a moverse","Hace que la pelota desaparezca","Hace que la pelota se vuelva más pesada"]', 1, 'Empujar la pelota aplica una fuerza que produce un cambio en su movimiento: comienza a moverse.', 'intermedia', 35),
  ('¿Cuál de estas situaciones muestra un cambio de forma producido por la aplicación de una fuerza?', '["Estirar una liga con las manos","Un vaso de agua evaporándose al sol","Una hoja cayendo de un árbol por el viento","Una vela derritiéndose por el calor"]', 2, 'Estirar una liga con las manos es un ejemplo de cambio de forma producido por una fuerza aplicada directamente.', 'intermedia', 35),
  ('Un estudiante golpea suavemente una pelota de goma con el pie y luego la golpea con mucha más fuerza. ¿Qué cambio se observa en el movimiento de la pelota al aumentar la fuerza aplicada?', '["La pelota se mueve exactamente igual en ambos casos","La pelota deja de moverse por completo","La pelota cambia de forma permanentemente","La pelota se mueve una distancia mayor y con más rapidez"]', 3, 'Al aumentar la fuerza aplicada sobre la pelota, esta se mueve una distancia mayor y con más rapidez.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_3_basico' and lo.short_name = 'Cambios producidos por la aplicación de una fuerza'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos cuerpos celestes se encuentra en el centro del Sistema Solar?', '["El Sol","La Luna","Marte","Un cometa"]', 0, 'El Sol se encuentra en el centro del Sistema Solar.', 'inicial', 25),
  ('¿Qué son los planetas que giran alrededor del Sol?', '["Parte del Sistema Solar","Estrellas independientes","Satélites de la Luna","Cometas fijos"]', 1, 'Los planetas que giran alrededor del Sol forman parte del Sistema Solar.', 'intermedia', 35),
  ('¿Cuál de estos es el planeta en el que vivimos?', '["Marte","Venus","La Tierra","Júpiter"]', 2, 'La Tierra es el planeta del Sistema Solar en el que vivimos.', 'intermedia', 35),
  ('Un estudiante arma una maqueta con una esfera grande en el centro y varias esferas más pequeñas girando a su alrededor, para representar el Sistema Solar. ¿Qué representa la esfera grande del centro?', '["Un planeta cualquiera","La Luna","El Sol","Un cometa"]', 3, 'La esfera grande del centro representa al Sol, alrededor del cual giran los planetas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_3_basico' and lo.short_name = 'El Sistema Solar'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos recursos naturales es renovable?', '["La energía solar","El petróleo","El carbón","El gas natural"]', 0, 'La energía solar es un recurso renovable porque no se agota con su uso.', 'inicial', 25),
  ('¿Qué característica tiene un recurso natural no renovable?', '["Se puede regenerar rápidamente","Existe en cantidad limitada y tarda mucho tiempo en formarse","Nunca se agota","Se produce todos los días de forma natural"]', 1, 'Un recurso no renovable existe en cantidad limitada y tarda muchísimo tiempo en formarse nuevamente.', 'intermedia', 35),
  ('¿Cuál de estos recursos naturales es no renovable?', '["El agua de lluvia","El viento","El petróleo","La luz solar"]', 2, 'El petróleo es un recurso no renovable porque se agota y tarda millones de años en formarse.', 'intermedia', 35),
  ('Un estudiante compara la madera de un bosque manejado sustentablemente con el petróleo extraído de un yacimiento. ¿Qué diferencia principal existe entre ambos recursos?', '["Ambos son renovables por igual","Ambos son no renovables por igual","La madera puede regenerarse con manejo adecuado; el petróleo tarda millones de años en formarse","El petróleo se regenera más rápido que la madera"]', 3, 'La madera, con un manejo adecuado del bosque, puede regenerarse; el petróleo es un recurso no renovable que tarda millones de años en formarse.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_3_basico' and lo.short_name = 'Recursos naturales renovables y no renovables'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una acción de uso responsable del agua?', '["Cerrar la llave mientras te enjabonas las manos","Dejar la llave abierta sin usarla","Regar el jardín en exceso todos los días","Llenar la tina hasta el borde cada día"]', 0, 'Cerrar la llave mientras te enjabonas las manos es una acción de uso responsable del agua.', 'inicial', 25),
  ('¿Por qué es importante usar de forma responsable los recursos naturales?', '["Porque son ilimitados y nunca se acaban","Porque muchos recursos son limitados y su uso excesivo puede agotarlos o dañar el ambiente","Porque así se gasta más dinero","Porque no tiene ninguna importancia"]', 1, 'Muchos recursos naturales son limitados; usarlos de forma responsable ayuda a que no se agoten ni se dañe el ambiente.', 'intermedia', 35),
  ('¿Cuál de estas acciones ayuda a un uso responsable de la energía eléctrica en la casa?', '["Dejar las luces encendidas todo el día sin necesidad","Apagar las luces al salir de una habitación","Dejar los aparatos electrónicos encendidos siempre","Usar la mayor cantidad de electrodomésticos posible al mismo tiempo"]', 2, 'Apagar las luces al salir de una habitación es una acción de uso responsable de la energía eléctrica.', 'intermedia', 35),
  ('Un curso decide reciclar el papel usado, cerrar bien las llaves de agua y apagar las luces que no se usan. ¿Qué relación tienen estas acciones con el uso responsable de los recursos naturales?', '["No tienen ninguna relación entre sí","Solo sirven para ganar un premio","Aumentan el uso de recursos naturales","Contribuyen a reducir el uso innecesario de recursos naturales"]', 3, 'Reciclar, cerrar las llaves de agua y apagar luces innecesarias contribuyen a reducir el uso innecesario de recursos naturales.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_3_basico' and lo.short_name = 'Uso responsable de los recursos naturales'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas preguntas se puede investigar mediante una observación o un experimento sencillo?', '["¿Crecen más rápido las plantas con más luz solar?","¿Cuál es el color favorito de mi compañero?","¿Qué día es hoy?","¿Cuántos estudiantes hay en mi curso?"]', 0, '¿Crecen más rápido las plantas con más luz solar? es una pregunta investigable mediante observación o experimento.', 'inicial', 25),
  ('¿Por qué es importante que una pregunta de investigación se pueda responder observando o experimentando?', '["Porque así se puede comprobar con evidencia, no solo con opiniones","Porque las preguntas de opinión son más importantes","Porque no es necesario comprobar nada en ciencia","Porque toda pregunta sirve igual para investigar"]', 1, 'Una pregunta investigable permite obtener evidencia mediante observación o experimentación, en vez de basarse solo en opiniones.', 'intermedia', 35),
  ('¿Cuál de estas preguntas NO es investigable mediante un experimento sencillo?', '["¿Se disuelve más rápido el azúcar en agua caliente o fría?","¿Flotan más objetos livianos que pesados en el agua?", "¿Cuál es el mejor color para una mochila?", "¿Germinan más rápido las semillas con más agua?"]', 2, '¿Cuál es el mejor color para una mochila? depende de gustos personales, no se puede responder con un experimento científico.', 'intermedia', 35),
  ('Un estudiante quiere investigar si las plantas crecen mejor con agua de la llave o con agua de lluvia. ¿Cuál de estas preguntas está mejor formulada para su investigación?', '["¿Te gustan más las plantas regadas con agua de lluvia?", "¿Qué planta es más bonita?", "¿Cuánto cuesta el agua de la llave?", "¿Crecen más las plantas regadas con agua de lluvia que las regadas con agua de la llave?"]', 3, 'Esta pregunta es investigable porque se puede comprobar comparando el crecimiento de plantas regadas con ambos tipos de agua.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_3_basico' and lo.short_name = 'Formulación de preguntas investigables'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Antes de realizar un experimento, ¿qué es importante planificar?', '["Los materiales y los pasos a seguir","El color del cuaderno","La hora de almuerzo","El nombre del curso"]', 0, 'Planificar un experimento implica definir los materiales necesarios y los pasos a seguir.', 'inicial', 25),
  ('¿Por qué es útil escribir los pasos de una investigación antes de realizarla?', '["Para que el experimento sea más difícil","Para asegurarse de seguir un orden y no olvidar materiales importantes","Porque no es necesario seguir un orden","Para hacer el experimento más lento a propósito"]', 1, 'Escribir los pasos previamente ayuda a seguir un orden claro y no olvidar materiales importantes.', 'intermedia', 35),
  ('Un grupo de estudiantes quiere investigar si las semillas germinan más rápido con más agua. ¿Cuál de estos pasos debería ir primero en su planificación?', '["Escribir las conclusiones finales","Reunir los materiales necesarios y definir cuánta agua usar en cada grupo de semillas","Comunicar los resultados al curso","Guardar las semillas sin hacer nada más"]', 2, 'Antes de comenzar el experimento, se deben reunir los materiales y definir claramente las condiciones que se van a comparar.', 'intermedia', 35),
  ('Un estudiante planifica un experimento sobre la germinación de semillas, pero olvida definir cuánta agua le dará a cada grupo de plantas. ¿Qué problema podría tener esto para su investigación?', '["Ningún problema, la planificación no es importante","No podría comparar de forma clara los resultados entre los grupos","El experimento sería más rápido","Las semillas germinarían igual de todas formas"]', 3, 'Sin definir claramente las condiciones de cada grupo, sería difícil comparar de forma clara los resultados de la investigación.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_3_basico' and lo.short_name = 'Planificación de una investigación sencilla'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 3° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Después de realizar un experimento sencillo, ¿qué acción corresponde a analizar los resultados?', '["Revisar y comparar lo que se observó con lo esperado","Guardar el experimento sin mirarlo","Olvidar lo que pasó","Repetir el experimento sin ningún registro"]', 0, 'Analizar los resultados implica revisar y comparar lo observado con lo que se esperaba encontrar.', 'inicial', 25),
  ('Un grupo de estudiantes plantó semillas con distinta cantidad de agua y midió cuánto crecieron después de dos semanas. ¿Qué acción corresponde al análisis de resultados?', '["Comparar el crecimiento de las plantas según la cantidad de agua recibida","Plantar nuevas semillas sin medir nada","Guardar las plantas sin observarlas","Cambiar el experimento a la mitad sin registrar nada"]', 1, 'Comparar el crecimiento de las plantas según la cantidad de agua recibida es un ejemplo de análisis de resultados.', 'intermedia', 35),
  ('En un experimento, los estudiantes predijeron que el hielo se derretiría más rápido al sol, y al medir el tiempo comprobaron que efectivamente fue así. ¿Qué se puede concluir al analizar estos resultados?', '["Que la predicción fue incorrecta","Que los resultados no tienen relación con la predicción","Que el experimento no sirvió de nada","Que los resultados obtenidos apoyan la predicción inicial"]', 2, 'Cuando los resultados coinciden con la predicción inicial, se concluye que los resultados apoyan esa predicción.', 'intermedia', 35),
  ('Un grupo midió el crecimiento de dos plantas: una regada todos los días y otra regada una vez por semana. Después de un mes, la planta regada todos los días creció más. ¿Qué conclusión es más adecuada al analizar estos resultados?', '["El riego no influye en el crecimiento de las plantas","No se puede sacar ninguna conclusión de este experimento","Ambas plantas crecieron exactamente igual","En este experimento, el riego más frecuente se relacionó con un mayor crecimiento de la planta"]', 3, 'Al analizar los resultados, se observa que la planta regada con mayor frecuencia creció más, lo que permite relacionar el riego con el crecimiento.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_3_basico' and lo.short_name = 'Análisis de resultados de un experimento sencillo'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
