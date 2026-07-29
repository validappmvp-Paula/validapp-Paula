-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 7° Básico. Cubre los 14 objetivos de aprendizaje de 7° Básico
-- cargados por
-- supabase/seed/0018_curriculum_ciencias_regular_7basico_2medio.sql, con 4
-- preguntas por objetivo, total 56 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí).

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 7° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos sistemas participa directamente en el proceso de nutrición del cuerpo humano?', '["El sistema digestivo","El sistema esquelético exclusivamente","El sistema nervioso exclusivamente","El sistema tegumentario exclusivamente"]', 0, 'El sistema digestivo participa directamente en el proceso de nutrición, transformando los alimentos.', 'inicial', 25),
  ('¿Qué función cumple el sistema excretor en relación con la nutrición?', '["Elimina los desechos que resultan de los procesos del cuerpo","Produce los alimentos que se consumen","Absorbe directamente el oxígeno del aire","Genera el movimiento del cuerpo"]', 1, 'El sistema excretor elimina los desechos producidos por los procesos del cuerpo, incluidos los relacionados con la nutrición.', 'intermedia', 35),
  ('¿Cuál de estos sistemas transporta los nutrientes obtenidos de la digestión hacia las células del cuerpo?', '["El sistema circulatorio","El sistema esquelético","El sistema muscular","El sistema tegumentario"]', 2, 'El sistema circulatorio transporta los nutrientes obtenidos de la digestión hacia las células del cuerpo.', 'intermedia', 35),
  ('Un estudiante explica que, tras comer, el sistema digestivo transforma los alimentos, el sistema respiratorio capta oxígeno, el sistema circulatorio transporta nutrientes y oxígeno a las células, y el sistema excretor elimina los desechos. ¿Qué idea general resume mejor esta descripción?', '["Cada sistema funciona de forma aislada, sin relación con los demás","Solo el sistema digestivo participa en la nutrición del cuerpo","Varios sistemas del cuerpo trabajan de forma coordinada para lograr la nutrición","La nutrición depende únicamente del sistema nervioso"]', 3, 'Varios sistemas del cuerpo (digestivo, respiratorio, circulatorio y excretor) trabajan de forma coordinada para lograr la nutrición del organismo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_7_basico' and lo.short_name = 'Sistemas del cuerpo humano relacionados con la nutrición'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué característica tiene una dieta equilibrada?', '["Incluye una variedad adecuada de nutrientes según las necesidades de la persona","Se basa únicamente en un solo tipo de alimento","Excluye completamente las frutas y verduras","Solo incluye alimentos altos en azúcar"]', 0, 'Una dieta equilibrada incluye una variedad adecuada de nutrientes según las necesidades de cada persona.', 'inicial', 25),
  ('¿Por qué una dieta compuesta solo de alimentos altos en grasas y azúcares no es equilibrada?', '["Porque no aporta la variedad de nutrientes que el cuerpo necesita","Porque aporta demasiadas vitaminas","Porque es la dieta más recomendada por los médicos","Porque no tiene ningún efecto en la salud"]', 1, 'Una dieta compuesta solo de grasas y azúcares no aporta la variedad de nutrientes que el cuerpo necesita para funcionar bien.', 'intermedia', 35),
  ('¿Qué factor se debe considerar al evaluar si una dieta es equilibrada para una persona en particular?', '["Sus necesidades nutricionales según edad, actividad física y salud","El precio de los alimentos únicamente","El color de los alimentos","La marca de los alimentos"]', 2, 'Al evaluar una dieta equilibrada se deben considerar las necesidades nutricionales según la edad, actividad física y estado de salud de la persona.', 'intermedia', 35),
  ('Un estudiante analiza dos situaciones: una persona que realiza mucha actividad física diaria y otra con un trabajo sedentario. Ambas siguen exactamente la misma dieta con la misma cantidad de calorías. ¿Qué evaluación es más adecuada sobre el concepto de dieta equilibrada en este caso?', '["Ambas dietas son igual de equilibradas sin importar el nivel de actividad física","Una dieta equilibrada no depende en nada del nivel de actividad física de la persona","Es posible que la misma dieta no sea igualmente equilibrada para ambas personas, dado que sus necesidades energéticas son distintas","Solo la persona sedentaria necesita una dieta equilibrada"]', 3, 'Dado que sus necesidades energéticas son distintas, la misma dieta podría no ser igualmente equilibrada para ambas personas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_7_basico' and lo.short_name = 'Dieta equilibrada'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es una población, en el contexto de la ecología?', '["El conjunto de individuos de la misma especie que viven en un mismo lugar y tiempo","Un grupo de especies distintas en un lugar","El conjunto de todos los componentes abióticos de un lugar","Un tipo de ecosistema marino"]', 0, 'Una población es el conjunto de individuos de la misma especie que viven en un mismo lugar y tiempo.', 'inicial', 25),
  ('¿Qué es una comunidad, en el contexto de la ecología?', '["El conjunto de todas las poblaciones de distintas especies que viven en un mismo lugar","Un solo individuo de una especie","El conjunto de rocas y agua de un lugar","Un tipo específico de ecosistema acuático"]', 1, 'Una comunidad es el conjunto de todas las poblaciones de distintas especies que conviven en un mismo lugar.', 'intermedia', 35),
  ('¿Qué relación existe entre comunidad y ecosistema?', '["Son exactamente lo mismo","El ecosistema incluye a la comunidad de seres vivos junto con los factores abióticos del ambiente","La comunidad no tiene relación con el ecosistema","El ecosistema es más pequeño que la comunidad siempre"]', 2, 'El ecosistema incluye a la comunidad de seres vivos junto con los factores abióticos (agua, suelo, clima) que interactúan con ella.', 'intermedia', 35),
  ('Un estudiante describe un bosque donde viven varias poblaciones de árboles, aves e insectos, junto con el suelo, el agua y el clima del lugar. Si se enfoca solo en las poblaciones de seres vivos que interactúan entre sí, sin considerar los factores abióticos, ¿de qué nivel de organización está hablando?', '["De un ecosistema completo","De una sola población","De una comunidad","De un bioma"]', 3, 'Al enfocarse solo en las poblaciones de seres vivos que interactúan entre sí, sin los factores abióticos, se está describiendo una comunidad.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_7_basico' and lo.short_name = 'Relaciones entre población, comunidad y ecosistema'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa que los seres vivos de un ecosistema sean interdependientes?', '["Que dependen unos de otros de distintas formas para sobrevivir","Que viven completamente aislados unos de otros","Que solo los animales dependen de otros seres vivos","Que las plantas no dependen de ningún otro ser vivo"]', 0, 'La interdependencia significa que los seres vivos dependen unos de otros de distintas formas para sobrevivir, como en las relaciones alimentarias.', 'inicial', 25),
  ('¿Cuál de estas es una consecuencia posible de una alta interdependencia entre especies de un ecosistema?', '["Que la desaparición de una especie puede afectar a varias otras","Que ninguna especie se ve afectada por la desaparición de otra","Que todas las especies son completamente independientes entre sí","Que la interdependencia no tiene ningún efecto en el ecosistema"]', 1, 'Debido a la interdependencia, la desaparición de una especie puede afectar a varias otras que dependían de ella de alguna forma.', 'intermedia', 35),
  ('¿Cuál de estos ejemplos muestra claramente interdependencia entre especies?', '["Las abejas que dependen de las flores para alimentarse, y las flores que dependen de las abejas para polinizarse","Una piedra que no interactúa con ningún ser vivo","El viento moviendo las nubes","El agua evaporándose del mar"]', 2, 'Las abejas y las flores muestran interdependencia: las abejas obtienen alimento de las flores, y estas dependen de las abejas para su polinización.', 'intermedia', 35),
  ('En un ecosistema, cierta especie de ave se alimenta exclusivamente de un tipo de insecto, y ese insecto poliniza una planta específica de la cual depende otra especie de mamífero para alimentarse. Si el insecto desapareciera por completo, ¿qué efecto es más probable que ocurra en este ecosistema?', '["Ningún efecto, porque las especies son completamente independientes entre sí","Solo se vería afectada la especie del insecto, sin ningún efecto en las demás","Podrían verse afectadas tanto el ave como la planta y, en consecuencia, el mamífero que depende de ella","Solo se vería afectada la planta, sin ningún efecto en el ave ni en el mamífero"]', 3, 'Debido a la interdependencia entre especies, la desaparición del insecto podría afectar al ave (que se alimenta de él), a la planta (que depende de su polinización) y, en consecuencia, al mamífero que depende de esa planta.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_7_basico' and lo.short_name = 'Efectos de la interdependencia de los seres vivos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 7° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos ejemplos corresponde a un movimiento rectilíneo?', '["Un auto avanzando en línea recta por una carretera","Una rueda de la fortuna girando","La Tierra girando sobre su eje","Un carrusel dando vueltas"]', 0, 'Un auto avanzando en línea recta por una carretera es un ejemplo de movimiento rectilíneo.', 'inicial', 25),
  ('¿Cuál de estos ejemplos corresponde a un movimiento circular?', '["Una pelota rodando en línea recta por el suelo","Un tren avanzando en línea recta por las vías","Las aspas de un ventilador girando","Una persona caminando en línea recta"]', 1, 'Las aspas de un ventilador girando describen un movimiento circular.', 'intermedia', 35),
  ('¿Qué elementos son necesarios para describir completamente el movimiento de un objeto, como su rapidez y hacia dónde se dirige?', '["Solo su color y su peso","Su rapidez y su dirección","Su temperatura y su sabor","Su nombre y su origen"]', 2, 'Para describir completamente un movimiento se necesita conocer tanto su rapidez como su dirección.', 'intermedia', 35),
  ('Un estudiante observa dos situaciones: un auto que avanza en línea recta por una autopista y una moneda que gira sobre una mesa alrededor de un punto fijo. ¿Qué tipo de movimiento describe cada situación, en ese orden?', '["Circular y rectilíneo","Ambos son movimientos circulares","Ambos son movimientos rectilíneos","Rectilíneo y circular"]', 3, 'El auto que avanza en línea recta describe un movimiento rectilíneo, y la moneda que gira alrededor de un punto fijo describe un movimiento circular.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_7_basico' and lo.short_name = 'Movimientos rectilíneos y circulares'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos ejemplos corresponde a una mezcla heterogénea, en la que se distinguen sus componentes a simple vista?', '["Agua con sal completamente disuelta","Agua con arena, donde la arena se ve claramente","Agua pura sin ningún soluto","Aire limpio sin partículas visibles"]', 0, 'Agua con arena es una mezcla heterogénea, ya que se puede distinguir la arena a simple vista.', 'inicial', 25),
  ('¿Qué método de separación es más adecuado para separar limaduras de hierro de una mezcla con arena?', '["El uso de un imán","La evaporación","La filtración con papel","El tamizado con una malla muy fina"]', 1, 'Un imán permite separar limaduras de hierro de una mezcla con arena, ya que el hierro es atraído por el imán.', 'intermedia', 35),
  ('¿Qué método de separación es más adecuado para recuperar sal disuelta en agua?', '["El uso de un imán","El tamizado","La evaporación del agua","La decantación de líquidos inmiscibles"]', 2, 'La evaporación del agua permite recuperar la sal, que queda como residuo sólido al evaporarse el agua.', 'intermedia', 35),
  ('Un estudiante tiene una mezcla de arena, sal disuelta en agua y limaduras de hierro, y debe diseñar un procedimiento para separar los tres componentes. ¿Cuál de estas secuencias de métodos sería más adecuada?', '["Solo evaporar toda la mezcla de una vez","Solo usar un tamiz sin ningún otro método","Filtrar primero, luego usar un imán y finalmente evaporar, en cualquier orden sin considerar las propiedades","Usar un imán para retirar el hierro, filtrar para separar la arena del agua con sal, y luego evaporar el agua para recuperar la sal"]', 3, 'Un procedimiento adecuado sería usar un imán para el hierro, filtrar para separar la arena, y finalmente evaporar el agua para recuperar la sal disuelta.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_7_basico' and lo.short_name = 'Tipos de mezclas y métodos de separación'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué indica la concentración de una disolución?', '["La cantidad de soluto disuelto en una cantidad determinada de solvente","El color de la disolución","La temperatura de la disolución","El nombre del solvente utilizado"]', 0, 'La concentración indica la cantidad de soluto disuelto en una cantidad determinada de solvente.', 'inicial', 25),
  ('Si se disuelve más azúcar en la misma cantidad de agua, ¿qué ocurre con la concentración de la disolución?', '["Disminuye","Aumenta","Se mantiene exactamente igual","Desaparece"]', 1, 'Al disolver más azúcar en la misma cantidad de agua, aumenta la concentración de la disolución.', 'intermedia', 35),
  ('¿Cuál de estas dos disoluciones de sal en agua tiene mayor concentración, si ambas usan la misma cantidad de agua?', '["La que tiene menos sal disuelta","La que tiene más sal disuelta","Ambas tienen la misma concentración necesariamente","No se puede determinar sin conocer el color"]', 2, 'La disolución que tiene más sal disuelta en la misma cantidad de agua tiene mayor concentración.', 'intermedia', 35),
  ('Un estudiante prepara dos vasos con la misma cantidad de agua: en el vaso A disuelve 5 gramos de sal y en el vaso B disuelve 20 gramos de sal. ¿Qué se puede afirmar sobre la concentración de ambas disoluciones?', '["El vaso A tiene mayor concentración que el vaso B","Ambos vasos tienen exactamente la misma concentración","La concentración no depende de la cantidad de soluto disuelto","El vaso B tiene mayor concentración que el vaso A"]', 3, 'El vaso B tiene mayor concentración que el vaso A, ya que contiene más soluto (sal) disuelto en la misma cantidad de solvente (agua).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_7_basico' and lo.short_name = 'Concepto de concentración de una disolución'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué necesita una onda sonora para propagarse, a diferencia de una onda luminosa?', '["Un medio material, como el aire o el agua","No necesita nada para propagarse","Solo puede propagarse en el vacío","Necesita oscuridad total"]', 0, 'Una onda sonora necesita un medio material, como el aire o el agua, para propagarse; no puede hacerlo en el vacío.', 'inicial', 25),
  ('¿Qué característica tiene la luz que le permite propagarse incluso en el vacío del espacio?', '["Es una onda que no necesita un medio material para propagarse","Necesita aire para propagarse, igual que el sonido","No puede propagarse en absoluto sin materia","Solo se propaga dentro del agua"]', 1, 'La luz es una onda que no necesita un medio material para propagarse, por eso puede viajar a través del vacío del espacio.', 'intermedia', 35),
  ('¿Cuál de estas aplicaciones prácticas se basa en el uso de ondas sonoras?', '["Los sonares que usan los barcos para detectar objetos bajo el agua","Los paneles solares que generan electricidad","Las lentes de los anteojos","Los espejos que reflejan la luz"]', 2, 'Los sonares usan ondas sonoras para detectar objetos bajo el agua, aprovechando su capacidad de propagarse en el agua.', 'intermedia', 35),
  ('Un estudiante investiga que, en el espacio exterior, dos astronautas no pueden escucharse hablando directamente entre sí sin un dispositivo de radio, aunque sí pueden verse mutuamente gracias a la luz que reciben. ¿Qué explica esta diferencia entre el sonido y la luz en el espacio?', '["El sonido y la luz se comportan exactamente igual en el vacío","El sonido necesita un medio material para propagarse, mientras que la luz no lo necesita","La luz no puede propagarse en el espacio exterior","El sonido se propaga mejor en el vacío que la luz"]', 3, 'El sonido necesita un medio material para propagarse, por lo que no puede transmitirse en el vacío del espacio; la luz, en cambio, sí puede propagarse sin necesidad de un medio material.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_7_basico' and lo.short_name = 'Ondas sonoras y luminosas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 7° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué relación existe entre las capas de la Tierra y el movimiento de las placas tectónicas?', '["Las placas tectónicas forman parte de la capa externa de la Tierra y se desplazan sobre el manto","No existe ninguna relación entre ellas","Las placas tectónicas están ubicadas en la atmósfera","Las placas tectónicas se encuentran solo en el núcleo de la Tierra"]', 0, 'Las placas tectónicas forman parte de la capa externa de la Tierra y se desplazan lentamente sobre el manto.', 'inicial', 25),
  ('¿Qué puede ocurrir cuando dos placas tectónicas chocan entre sí?', '["Puede formarse una cordillera montañosa","Se detiene por completo el movimiento de la Tierra","Se forma automáticamente un océano nuevo","No ocurre ningún fenómeno geológico"]', 1, 'Cuando dos placas tectónicas chocan, puede formarse una cordillera montañosa, entre otros fenómenos geológicos.', 'intermedia', 35),
  ('¿Por qué se producen muchos terremotos en zonas donde dos placas tectónicas se rozan o deslizan una sobre otra?', '["Porque se libera energía acumulada por la fricción entre las placas","Porque el clima de esa zona es muy caluroso","Porque hay muchos volcanes activos, sin relación con las placas","Porque la Luna influye directamente en el movimiento de las placas"]', 2, 'Los terremotos en esas zonas se producen porque se libera la energía acumulada por la fricción entre las placas tectónicas.', 'intermedia', 35),
  ('Un estudiante investiga que Chile se ubica en el borde de la placa Sudamericana y la placa de Nazca, las cuales interactúan constantemente. ¿Qué relación se puede establecer entre esta ubicación y la frecuencia de terremotos en el país?', '["No existe relación entre la ubicación de las placas y los terremotos en Chile","La ubicación en el borde de placas tectónicas activas explica la alta frecuencia de terremotos en Chile","Los terremotos en Chile se deben únicamente al clima","Chile no se ubica en ningún borde de placas tectónicas"]', 3, 'La ubicación de Chile en el borde de interacción entre la placa Sudamericana y la placa de Nazca explica la alta frecuencia de terremotos en el país.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_7_basico' and lo.short_name = 'Capas de la Tierra y placas tectónicas'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos recursos naturales se clasifica como renovable?', '["La energía solar","El carbón","El petróleo","El gas natural"]', 0, 'La energía solar se clasifica como un recurso renovable, ya que no se agota con su uso.', 'inicial', 25),
  ('¿Cuál de estos recursos naturales se clasifica como no renovable?', '["El viento","El agua de lluvia","El petróleo","La energía solar"]', 1, 'El petróleo se clasifica como un recurso no renovable, ya que tarda millones de años en formarse y se agota con su extracción.', 'intermedia', 35),
  ('¿Qué criterio se usa principalmente para clasificar un recurso natural como renovable o no renovable?', '["Su capacidad de regenerarse en un tiempo comparable al de su uso","Su color","Su ubicación geográfica exacta","Su precio en el mercado"]', 2, 'El criterio principal es la capacidad del recurso de regenerarse en un tiempo comparable al de su uso o extracción.', 'intermedia', 35),
  ('Un estudiante compara dos recursos: la madera de un bosque manejado de forma sustentable, que puede volver a crecer en pocas décadas, y el carbón, que tarda millones de años en formarse geológicamente. ¿Qué clasificación es correcta para ambos recursos?', '["Ambos son recursos no renovables por igual","La madera es no renovable y el carbón es renovable","Ambos son recursos renovables por igual","La madera es un recurso renovable y el carbón es un recurso no renovable"]', 3, 'La madera, manejada de forma sustentable, es un recurso renovable, mientras que el carbón, que tarda millones de años en formarse, es un recurso no renovable.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_7_basico' and lo.short_name = 'Clasificación de recursos naturales'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un riesgo geológico común en Chile?', '["Los terremotos","Los huracanes tropicales","Las nevadas en el desierto de Atacama todos los días","La formación de arrecifes de coral"]', 0, 'Los terremotos son un riesgo geológico común en Chile debido a su ubicación en una zona de gran actividad tectónica.', 'inicial', 25),
  ('¿Cuál de estas es una medida de prevención adecuada frente a un riesgo geológico como los terremotos?', '["Fijar bien los muebles altos y objetos pesados en la casa","Colocar objetos pesados sin fijar en las repisas más altas","Ignorar completamente los simulacros de emergencia","No informarse sobre qué hacer en caso de terremoto"]', 1, 'Fijar bien los muebles y objetos pesados es una medida de prevención adecuada frente a los terremotos.', 'intermedia', 35),
  ('¿Por qué es importante conocer las zonas de riesgo volcánico cercanas a una comunidad?', '["Para poder planificar medidas de evacuación y prevención adecuadas","Porque no tiene ninguna utilidad práctica","Porque los volcanes nunca representan un riesgo","Para aumentar la construcción de viviendas justo en esas zonas sin ninguna medida"]', 2, 'Conocer las zonas de riesgo volcánico permite planificar medidas de evacuación y prevención adecuadas para la comunidad.', 'intermedia', 35),
  ('Una comunidad ubicada cerca de un volcán activo desarrolla un plan de evacuación, instala sistemas de alerta temprana y realiza simulacros periódicos. ¿Qué relación tienen estas acciones con la prevención de riesgos geológicos?', '["No tienen ninguna relación con la prevención de riesgos","Aumentan el riesgo geológico de la zona","Corresponden a medidas de prevención que buscan reducir el impacto de una posible erupción volcánica","Solo sirven para fines educativos, sin relación con la seguridad real"]', 3, 'Estas acciones corresponden a medidas de prevención que buscan reducir el impacto de una posible erupción volcánica sobre la comunidad.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_7_basico' and lo.short_name = 'Riesgos geológicos y prevención'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 7° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En un experimento sobre el crecimiento de plantas según la cantidad de agua recibida, ¿cuál es la variable independiente?', '["La cantidad de agua que recibe cada planta","La altura final de la planta","El color de las hojas","El tipo de maceta utilizada"]', 0, 'La variable independiente es la cantidad de agua, ya que es la que el investigador modifica deliberadamente.', 'inicial', 25),
  ('En el mismo experimento sobre plantas y agua, ¿cuál sería la variable dependiente?', '["La cantidad de agua entregada","El crecimiento de la planta, que se mide como resultado","El tipo de suelo utilizado","El día en que se inicia el experimento"]', 1, 'La variable dependiente es el crecimiento de la planta, ya que es el resultado que se observa y depende de la variable independiente.', 'intermedia', 35),
  ('¿Qué variables deberían mantenerse controladas (constantes) en un experimento que compara el crecimiento de plantas regadas con distinta cantidad de agua?', '["El tipo de planta, la cantidad de luz y el tipo de suelo, entre otras","La cantidad de agua entregada, ya que es la variable en estudio","El resultado final del experimento","Ninguna variable necesita mantenerse constante"]', 2, 'Se deben mantener constantes variables como el tipo de planta, la cantidad de luz y el tipo de suelo, para poder atribuir los resultados a la cantidad de agua.', 'intermedia', 35),
  ('Un estudiante diseña un experimento para investigar si la cantidad de sal afecta el punto de ebullición del agua, usando la misma cantidad de agua y el mismo tipo de recipiente en cada prueba, y variando solo la cantidad de sal agregada. ¿Cuáles son, respectivamente, la variable independiente y la variable dependiente de este experimento?', '["La cantidad de agua y el tipo de recipiente","El tipo de recipiente y la cantidad de sal","La temperatura ambiente y la cantidad de agua","La cantidad de sal agregada y la temperatura a la que hierve el agua"]', 3, 'La variable independiente es la cantidad de sal agregada (lo que se modifica), y la variable dependiente es la temperatura a la que hierve el agua (lo que se mide como resultado).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_7_basico' and lo.short_name = 'Diseño de una investigación controlando variables'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al analizar los datos de una investigación, ¿qué se busca identificar en los resultados obtenidos?', '["Tendencias o patrones que permitan responder la pregunta de investigación","El color de los materiales utilizados","El nombre de los estudiantes que participaron","La hora exacta en que se realizó el experimento"]', 0, 'El análisis de datos busca identificar tendencias o patrones que permitan responder la pregunta de investigación.', 'inicial', 25),
  ('Un estudiante obtiene los siguientes datos sobre el tiempo que demora en disolverse el azúcar en agua a distintas temperaturas: 10°C: 90 segundos; 30°C: 50 segundos; 50°C: 20 segundos. ¿Qué patrón se puede identificar en estos datos?', '["El azúcar se disuelve más rápido a menor temperatura","No existe ningún patrón identificable en estos datos","El azúcar se disuelve más rápido a mayor temperatura","El tiempo de disolución no depende de la temperatura"]', 1, 'Los datos muestran que el azúcar se disuelve más rápido a mayor temperatura, ya que el tiempo disminuye conforme aumenta la temperatura.', 'intermedia', 35),
  ('¿Por qué es importante analizar los datos obtenidos en una investigación antes de sacar conclusiones?', '["Porque el análisis permite identificar si los datos apoyan o no la hipótesis planteada","Porque los datos no tienen ninguna relación con las conclusiones","Porque se pueden sacar conclusiones sin revisar los datos obtenidos","Porque el análisis de datos es un paso opcional en toda investigación"]', 2, 'El análisis de datos permite identificar si estos apoyan o no la hipótesis planteada, siendo un paso fundamental antes de concluir.', 'intermedia', 35),
  ('Un grupo de estudiantes midió el crecimiento de plantas regadas con distinta frecuencia y obtuvo los siguientes datos: riego diario: 18 cm; riego cada 3 días: 12 cm; riego semanal: 6 cm, todos medidos después de un mes. Al analizar estos datos, ¿qué relación se puede identificar entre la frecuencia de riego y el crecimiento de la planta?', '["No existe ninguna relación entre las variables medidas","A mayor frecuencia de riego, en este experimento, mayor fue el crecimiento observado","A mayor frecuencia de riego, menor fue el crecimiento observado","El crecimiento fue exactamente igual en los tres casos"]', 3, 'Al analizar los datos, se identifica que, en este experimento, a mayor frecuencia de riego, mayor fue el crecimiento observado en las plantas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_7_basico' and lo.short_name = 'Análisis de datos de una investigación'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 7° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué elementos debería incluir un informe simple sobre una investigación científica?', '["Pregunta de investigación, procedimiento, resultados y conclusiones","Solo un dibujo, sin ninguna explicación","Solo la opinión personal del estudiante","Solo el nombre del experimento, sin más detalles"]', 0, 'Un informe simple debe incluir la pregunta de investigación, el procedimiento seguido, los resultados obtenidos y las conclusiones.', 'inicial', 25),
  ('¿Por qué es importante incluir el procedimiento en un informe de investigación?', '["Para que otras personas puedan entender y, si quieren, repetir el experimento","Porque no es necesario que otros entiendan cómo se hizo el experimento","Porque el procedimiento no tiene relación con los resultados","Para que el informe sea más largo sin ningún propósito"]', 1, 'Incluir el procedimiento permite que otras personas entiendan cómo se realizó el experimento y, si lo desean, puedan repetirlo.', 'intermedia', 35),
  ('Un estudiante presenta un informe que solo dice ''hice un experimento con plantas y me fue bien'', sin detallar el procedimiento ni los resultados numéricos obtenidos. ¿Qué problema tiene este informe?', '["Ningún problema, es un informe completo","Le falta detallar el procedimiento y los resultados obtenidos de forma clara","Es demasiado detallado","No necesita ninguna mejora"]', 2, 'Al informe le falta detallar el procedimiento seguido y los resultados obtenidos de forma clara y verificable.', 'intermedia', 35),
  ('Un grupo de estudiantes escribe un informe que incluye la pregunta de investigación, los materiales usados, los pasos seguidos, una tabla con los datos obtenidos y una conclusión basada en esos datos. ¿Qué característica de un buen informe científico cumple este trabajo?', '["No cumple ninguna característica de un buen informe","Incluye todos los elementos necesarios para comunicar la investigación de forma clara y verificable","Solo cumple con incluir una opinión personal","Omite información relevante sobre el procedimiento"]', 3, 'Este informe incluye todos los elementos necesarios (pregunta, procedimiento, datos y conclusión) para comunicar la investigación de forma clara y verificable.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_7_basico' and lo.short_name = 'Comunicación de resultados mediante informes simples'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
