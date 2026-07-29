-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 8° Básico. Cubre los 14 objetivos de aprendizaje de 8° Básico
-- cargados por
-- supabase/seed/0018_curriculum_ciencias_regular_7basico_2medio.sql, con 4
-- preguntas por objetivo, total 56 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí).
--
-- NOTA PEDAGÓGICA ADICIONAL sobre los objetivos ''Pubertad y sistema
-- reproductor'' y ''Prevención de infecciones de transmisión sexual'': las
-- preguntas se redactaron con un enfoque estrictamente biológico/preventivo
-- (funciones de órganos, medidas de prevención de salud), sin contenido
-- explícito ni gráfico, apropiado para 8° Básico. Se recomienda revisión
-- pedagógica adicional (más allá de la revisión general que ya requieren
-- todas las preguntas de este banco) antes de su uso, dada la sensibilidad
-- del tema.

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 8° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué función cumple el sistema óseo en relación con el movimiento del cuerpo?', '["Da soporte y sirve de punto de apoyo para que los músculos generen movimiento","Produce la energía que usan los músculos","Controla los pensamientos del cuerpo","Filtra el aire que se respira"]', 0, 'El sistema óseo da soporte al cuerpo y sirve de punto de apoyo para que los músculos generen movimiento.', 'inicial', 25),
  ('¿Cómo se relacionan los músculos con los huesos para producir movimiento?', '["Los músculos se contraen y tiran de los huesos, generando movimiento en las articulaciones","Los huesos se mueven por sí solos, sin ayuda de los músculos","Los músculos no tienen ninguna relación con los huesos","Los huesos producen la energía que usan los músculos"]', 1, 'Los músculos se contraen y tiran de los huesos a través de tendones, generando movimiento en las articulaciones.', 'intermedia', 35),
  ('¿Qué función cumple una articulación, como la rodilla, en el sistema óseo y muscular?', '["Permite el movimiento entre dos huesos que se conectan en ese punto","Impide cualquier tipo de movimiento del cuerpo","Produce directamente la fuerza muscular","Reemplaza la función del sistema nervioso"]', 2, 'Una articulación permite el movimiento entre dos huesos que se conectan en ese punto, como ocurre en la rodilla.', 'intermedia', 35),
  ('Un estudiante explica que, al doblar el brazo, un músculo se contrae y tira del hueso del antebrazo, mientras la articulación del codo permite el giro necesario para ese movimiento. ¿Qué relación general ilustra este ejemplo entre el sistema óseo y el sistema muscular?', '["El sistema óseo y el sistema muscular funcionan de forma completamente independiente","El sistema muscular actúa sobre los huesos, a través de las articulaciones, para producir movimiento","Solo el sistema óseo participa en este movimiento","Las articulaciones impiden que los músculos generen movimiento"]', 3, 'Este ejemplo ilustra cómo el sistema muscular actúa sobre los huesos, aprovechando las articulaciones, para producir el movimiento del cuerpo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_8_basico' and lo.short_name = 'Sistemas óseo y muscular relacionados con el movimiento'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué proceso caracteriza el inicio de la pubertad en el cuerpo humano?', '["El comienzo de una serie de cambios físicos y hormonales que llevan a la madurez reproductiva","La detención completa del crecimiento del cuerpo","La pérdida de todas las funciones del sistema reproductor","Un cambio que ocurre exclusivamente en la niñez temprana"]', 0, 'La pubertad es el inicio de una serie de cambios físicos y hormonales que llevan gradualmente a la madurez reproductiva.', 'inicial', 25),
  ('¿Cuál es la función general del sistema reproductor femenino?', '["Producir células reproductoras (óvulos) y posibilitar la gestación","Producir la energía muscular del cuerpo","Filtrar el aire que se respira","Controlar el movimiento de las piernas"]', 1, 'El sistema reproductor femenino produce óvulos y posibilita el proceso de gestación.', 'intermedia', 35),
  ('¿Cuál es la función general del sistema reproductor masculino?', '["Filtrar los desechos del cuerpo","Producir células reproductoras (espermatozoides)","Controlar los latidos del corazón","Producir hormonas del crecimiento óseo exclusivamente"]', 2, 'El sistema reproductor masculino produce espermatozoides, las células reproductoras masculinas.', 'intermedia', 35),
  ('Un estudiante investiga que, durante la pubertad, comienzan a producirse hormonas que activan cambios en los sistemas reproductores femenino y masculino, además de otros cambios físicos en el cuerpo. ¿Qué idea general resume esta información?', '["La pubertad no tiene relación con los sistemas reproductores","Los cambios de la pubertad están asociados a procesos hormonales que activan la maduración de los sistemas reproductores","Los sistemas reproductores se desarrollan completamente antes de la pubertad","La pubertad ocurre de forma idéntica y al mismo tiempo en todas las personas"]', 3, 'Los cambios de la pubertad están asociados a procesos hormonales que activan gradualmente la maduración de los sistemas reproductores.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_8_basico' and lo.short_name = 'Pubertad y sistema reproductor'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué son las infecciones de transmisión sexual (ITS)?', '["Infecciones que se pueden transmitir principalmente a través del contacto sexual","Infecciones que solo se transmiten por el aire","Infecciones que afectan exclusivamente a los huesos","Infecciones que no tienen relación con la salud humana"]', 0, 'Las infecciones de transmisión sexual son infecciones que se pueden transmitir principalmente a través del contacto sexual.', 'inicial', 25),
  ('¿Cuál de estas es una medida de prevención frente a las infecciones de transmisión sexual mencionada habitualmente en programas de salud escolar?', '["El uso de métodos de barrera, como el preservativo","Evitar cualquier tipo de información sobre el tema","Ignorar las recomendaciones de los centros de salud","No informarse en absoluto sobre el tema"]', 1, 'El uso de métodos de barrera, como el preservativo, es una medida de prevención frente a las infecciones de transmisión sexual.', 'intermedia', 35),
  ('¿Por qué es importante que las personas se informen sobre la prevención de infecciones de transmisión sexual?', '["Porque la información y las medidas de prevención ayudan a cuidar la salud propia y de otras personas","Porque la información no tiene ninguna utilidad para la salud","Porque estas infecciones no afectan la salud de las personas","Porque el tema no debería estudiarse en la escuela"]', 2, 'Informarse sobre prevención ayuda a cuidar la salud propia y de otras personas, reduciendo el riesgo de contagio.', 'intermedia', 35),
  ('Un centro de salud realiza una campaña educativa sobre el uso de métodos de prevención y la importancia de realizarse exámenes médicos periódicos para detectar a tiempo posibles infecciones de transmisión sexual. ¿Qué objetivo general tiene esta campaña, considerando la prevención en salud?', '["Reducir el acceso a la información sobre el tema","Aumentar el riesgo de contagio en la población","Contribuir a que las personas cuiden su salud mediante la prevención y la detección temprana","No tiene relación con la prevención de enfermedades"]', 3, 'La campaña busca contribuir a que las personas cuiden su salud mediante medidas de prevención y la detección temprana de posibles infecciones.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_8_basico' and lo.short_name = 'Prevención de infecciones de transmisión sexual'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué propone el modelo corpuscular de la materia?', '["Que toda la materia está formada por partículas muy pequeñas","Que la materia es completamente continua, sin partículas","Que solo los líquidos están formados por partículas","Que la materia no tiene ninguna estructura interna"]', 0, 'El modelo corpuscular propone que toda la materia está formada por partículas muy pequeñas.', 'inicial', 25),
  ('¿Cuál es el nivel de organización más simple entre los seres vivos, según el modelo corpuscular aplicado a la biología?', '["El organismo completo","La célula","El sistema de órganos","El tejido"]', 1, 'La célula es el nivel de organización más simple entre los niveles biológicos considerados aquí.', 'intermedia', 35),
  ('Ordena de menor a mayor complejidad los siguientes niveles de organización de un ser vivo: tejido, célula, órgano, sistema de órganos. ¿Cuál es el orden correcto?', '["Órgano, tejido, célula, sistema de órganos","Sistema de órganos, órgano, tejido, célula","Célula, tejido, órgano, sistema de órganos","Tejido, célula, sistema de órganos, órgano"]', 2, 'El orden de menor a mayor complejidad es: célula, tejido, órgano y sistema de órganos.', 'intermedia', 35),
  ('Un estudiante explica que el corazón (un órgano) está formado por tejido muscular cardíaco, y este tejido está formado por células musculares especializadas, las que a su vez están formadas por partículas muy pequeñas según el modelo corpuscular. ¿Qué relación general ilustra esta descripción entre los niveles de organización de la vida?', '["Los niveles de organización no tienen relación entre sí","Cada nivel de organización más complejo está formado por unidades de niveles más simples","El órgano es la unidad más simple de organización","Las partículas del modelo corpuscular no tienen relación con los niveles de organización biológica"]', 3, 'Esta descripción ilustra que cada nivel de organización más complejo (órgano) está formado por unidades de niveles más simples (tejido, célula, partículas).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_8_basico' and lo.short_name = 'Modelo corpuscular de la materia y niveles de organización de la vida'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 8° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la fuerza neta que actúa sobre un objeto?', '["La suma de todas las fuerzas que actúan sobre ese objeto, considerando su dirección","Solo la fuerza más grande que actúa sobre el objeto","El peso del objeto exclusivamente","La fuerza que ejerce el objeto sobre sí mismo"]', 0, 'La fuerza neta es la suma de todas las fuerzas que actúan sobre un objeto, considerando su dirección.', 'inicial', 25),
  ('¿Qué ocurre con un objeto cuando la fuerza neta que actúa sobre él es igual a cero?', '["Permanece en reposo o se mueve con velocidad constante","Siempre se detiene inmediatamente si estaba en movimiento","Siempre acelera con fuerza","Cambia de forma constantemente"]', 1, 'Cuando la fuerza neta es igual a cero, el objeto permanece en reposo o se mueve con velocidad constante (estado de equilibrio).', 'intermedia', 35),
  ('Si dos personas empujan una caja en direcciones opuestas con fuerzas de igual magnitud, ¿cuál es la fuerza neta sobre la caja?', '["Una fuerza neta muy grande hacia un lado","Una fuerza neta igual a cero","Una fuerza neta que cambia de dirección constantemente","No se puede calcular la fuerza neta en este caso"]', 2, 'Cuando dos fuerzas de igual magnitud actúan en direcciones opuestas, la fuerza neta resultante es igual a cero.', 'intermedia', 35),
  ('Un estudiante empuja una caja hacia la derecha con una fuerza de 20 N, mientras que la fricción del suelo actúa con una fuerza de 20 N hacia la izquierda. ¿Qué se puede concluir sobre el estado de movimiento de la caja, considerando la fuerza neta?', '["La caja acelerará rápidamente hacia la derecha","La caja permanecerá en equilibrio (en reposo o con velocidad constante), ya que la fuerza neta es cero","La caja se moverá hacia la izquierda con fuerza","No es posible determinar el estado de la caja con esta información"]', 3, 'Como las fuerzas de 20 N en direcciones opuestas se anulan entre sí, la fuerza neta es cero y la caja permanece en equilibrio.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_8_basico' and lo.short_name = 'Fuerza neta y equilibrio'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la presión en un fluido?', '["La fuerza que ejerce el fluido por unidad de área","El color del fluido","La temperatura exacta del fluido","El volumen total del fluido"]', 0, 'La presión en un fluido es la fuerza que este ejerce distribuida sobre una unidad de área.', 'inicial', 25),
  ('¿Qué ocurre con la presión del agua a medida que aumenta la profundidad en un océano?', '["Disminuye","Aumenta","Se mantiene siempre igual","Desaparece por completo"]', 1, 'La presión del agua aumenta a medida que aumenta la profundidad, debido al peso del agua que se encuentra por encima.', 'intermedia', 35),
  ('¿Por qué los buzos que bucean a grandes profundidades deben usar equipos especiales?', '["Porque la presión del agua a mayor profundidad es más alta y puede afectar el cuerpo","Porque el agua a mayor profundidad es más caliente","Porque no existe presión bajo el agua","Porque el color del agua cambia demasiado"]', 2, 'A mayor profundidad, la presión del agua es más alta y puede afectar el cuerpo, por lo que se necesitan equipos especiales.', 'intermedia', 35),
  ('Un estudiante investiga que, al sumergirse en una piscina, siente más presión en los oídos mientras más profundo baja. ¿Qué relación explica mejor esta sensación, considerando el concepto de presión en fluidos?', '["La presión del agua no cambia con la profundidad","La presión disminuye a mayor profundidad, lo que explicaría esa sensación","La presión aumenta con la profundidad debido al peso del agua por encima del cuerpo","La sensación no tiene relación con la presión del agua"]', 3, 'La presión aumenta con la profundidad debido al peso del agua que se encuentra por encima, lo que explica la sensación en los oídos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_8_basico' and lo.short_name = 'Presión en fluidos'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es un elemento químico?', '["Una sustancia pura formada por un solo tipo de átomo","Una mezcla de varias sustancias distintas","Un tipo de solución líquida únicamente","Un objeto no relacionado con la química"]', 0, 'Un elemento químico es una sustancia pura formada por un solo tipo de átomo.', 'inicial', 25),
  ('¿Qué es un compuesto químico?', '["Una sustancia formada por dos o más elementos combinados químicamente en proporciones fijas","Una mezcla de materiales que se puede separar fácilmente por métodos físicos","Un elemento puro sin combinar con otros","Un objeto sólido sin ninguna composición química"]', 1, 'Un compuesto químico es una sustancia formada por dos o más elementos combinados químicamente en proporciones fijas, como el agua.', 'intermedia', 35),
  ('¿Cuál de estos ejemplos corresponde a una mezcla, y no a un compuesto ni a un elemento?', '["El oxígeno puro","El agua (H2O)","Agua con sal disuelta, que se puede separar por evaporación","El hierro puro"]', 2, 'Agua con sal disuelta es una mezcla, ya que sus componentes se pueden separar por métodos físicos como la evaporación.', 'intermedia', 35),
  ('Un estudiante analiza tres sustancias: oxígeno puro (O2), agua (H2O) y agua con sal disuelta. Clasifica correctamente cada una como elemento, compuesto o mezcla, en ese orden.', '["Compuesto, mezcla y elemento","Mezcla, elemento y compuesto","Elemento, compuesto y mezcla","Compuesto, elemento y mezcla"]', 3, 'El oxígeno puro es un elemento, el agua (H2O) es un compuesto (dos elementos combinados químicamente) y el agua con sal disuelta es una mezcla.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_8_basico' and lo.short_name = 'Elementos, compuestos y mezclas'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Según un modelo simple del átomo, ¿qué partícula se encuentra en el núcleo con carga positiva?', '["El protón","El electrón","El neutrón sin carga","La molécula"]', 0, 'El protón es la partícula del núcleo con carga positiva.', 'inicial', 25),
  ('¿Qué partícula del átomo se encuentra girando alrededor del núcleo, con carga negativa?', '["El neutrón","El protón","El electrón","El fotón"]', 1, 'El electrón es la partícula con carga negativa que se encuentra alrededor del núcleo del átomo.', 'intermedia', 35),
  ('¿Qué partícula del núcleo del átomo no tiene carga eléctrica?', '["El protón","El electrón","El neutrón","El ion"]', 2, 'El neutrón es la partícula del núcleo que no tiene carga eléctrica.', 'intermedia', 35),
  ('Un estudiante arma un modelo simple de un átomo con bolitas de un color en el centro representando partículas con carga positiva, otras sin color representando partículas sin carga, y bolitas más pequeñas de otro color girando alrededor, con carga negativa. ¿Qué partículas representa cada parte del modelo, en ese orden?', '["Electrones, neutrones y protones","Protones, electrones y neutrones","Neutrones, protones y electrones","Protones, neutrones y electrones"]', 3, 'Las bolitas del centro con carga positiva representan protones, las bolitas del centro sin carga representan neutrones, y las bolitas que giran alrededor con carga negativa representan electrones.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_8_basico' and lo.short_name = 'Modelo atómico simple'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 8° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿A qué galaxia pertenece el Sistema Solar?', '["A la Vía Láctea","A la galaxia de Andrómeda","A ninguna galaxia","A una galaxia sin identificar"]', 0, 'El Sistema Solar pertenece a la galaxia conocida como Vía Láctea.', 'inicial', 25),
  ('¿Qué relación existe entre el universo, las galaxias y el Sistema Solar, en términos de escala?', '["El universo contiene galaxias, y una de ellas contiene al Sistema Solar","El Sistema Solar contiene al universo completo","Las galaxias son más pequeñas que el Sistema Solar","El universo y las galaxias son exactamente lo mismo"]', 1, 'El universo contiene una enorme cantidad de galaxias, y una de ellas, la Vía Láctea, contiene al Sistema Solar.', 'intermedia', 35),
  ('¿Cuál de estas afirmaciones describe correctamente la posición del Sistema Solar dentro de la Vía Láctea?', '["El Sistema Solar se ubica en una de las zonas de la Vía Láctea, no en su totalidad","El Sistema Solar constituye toda la Vía Láctea","La Vía Láctea es más pequeña que el Sistema Solar","El Sistema Solar no forma parte de ninguna galaxia"]', 2, 'El Sistema Solar se ubica en una zona particular de la Vía Láctea, que contiene muchísimos otros sistemas estelares.', 'intermedia', 35),
  ('Un estudiante compara el tamaño del Sistema Solar con el de la Vía Láctea, y descubre que la Vía Láctea contiene cientos de miles de millones de estrellas, mientras que el Sistema Solar tiene una sola estrella (el Sol) con sus planetas. ¿Qué conclusión sobre la escala del universo es más adecuada a partir de esta comparación?', '["El Sistema Solar es más grande que toda la Vía Láctea","El Sistema Solar es solo una pequeña parte de una galaxia mucho más grande, la Vía Láctea","La Vía Láctea y el Sistema Solar tienen exactamente el mismo tamaño","El universo contiene solo al Sistema Solar"]', 3, 'Esta comparación muestra que el Sistema Solar es solo una pequeña parte de una galaxia mucho más grande, la Vía Láctea.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_8_basico' and lo.short_name = 'El universo, galaxias y el Sistema Solar'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la teoría científica más aceptada actualmente sobre el origen del universo, a nivel introductorio?', '["La teoría del Big Bang","La teoría de que el universo siempre fue exactamente igual a como es hoy","La teoría de que el universo fue creado por un solo planeta","No existe ninguna teoría científica sobre el origen del universo"]', 0, 'La teoría del Big Bang es la explicación científica más aceptada actualmente sobre el origen del universo.', 'inicial', 25),
  ('Según la teoría del Big Bang, ¿qué ha ocurrido con el universo desde su origen hasta hoy?', '["Se ha mantenido exactamente del mismo tamaño","Se ha ido expandiendo con el tiempo","Se ha ido contrayendo constantemente","Ha desaparecido varias veces"]', 1, 'Según la teoría del Big Bang, el universo se ha ido expandiendo con el tiempo desde su origen.', 'intermedia', 35),
  ('¿Qué tipo de evidencia científica apoya la teoría del Big Bang, a nivel introductorio?', '["La observación de que las galaxias se alejan entre sí y otras evidencias astronómicas","La opinión de una sola persona sin ningún dato","La ausencia total de evidencia científica","Solo mitos y leyendas antiguas"]', 2, 'La observación de que las galaxias se alejan entre sí, junto con otras evidencias astronómicas, apoya la teoría del Big Bang.', 'intermedia', 35),
  ('Un estudiante investiga que los científicos han observado que las galaxias parecen alejarse unas de otras con el paso del tiempo, lo que es consistente con la idea de que el universo comenzó siendo muy pequeño y se ha expandido desde entonces. ¿Qué teoría sobre el origen del universo se relaciona con esta evidencia?', '["La teoría de que el universo es estático y no cambia","La teoría de que el universo se está contrayendo","La teoría del Big Bang","No existe relación entre esta evidencia y ninguna teoría científica"]', 3, 'Esta evidencia (el alejamiento de las galaxias) se relaciona con la teoría del Big Bang, que propone que el universo se ha expandido desde un origen muy pequeño.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_8_basico' and lo.short_name = 'Origen del universo'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Para qué se utiliza principalmente un telescopio en astronomía?', '["Para observar con más detalle objetos astronómicos lejanos","Para medir la masa de un objeto pequeño","Para escuchar sonidos del espacio","Para predecir el clima diario"]', 0, 'Un telescopio se utiliza principalmente para observar con más detalle objetos astronómicos lejanos, como estrellas y planetas.', 'inicial', 25),
  ('¿Qué ventaja tienen los satélites artificiales para la observación astronómica, en comparación con los telescopios ubicados en la superficie terrestre?', '["Pueden observar el espacio sin la interferencia de la atmósfera terrestre","No pueden observar ningún objeto astronómico","Solo sirven para comunicaciones, sin relación con la astronomía","Producen menos información que un telescopio terrestre"]', 1, 'Los satélites artificiales pueden observar el espacio sin la interferencia de la atmósfera terrestre, lo que mejora la calidad de las observaciones.', 'intermedia', 35),
  ('¿Cuál de estas herramientas tecnológicas ha permitido a los científicos obtener información detallada sobre otros planetas del Sistema Solar mediante misiones no tripuladas?', '["Las sondas espaciales","Los microscopios","Los termómetros","Las balanzas"]', 2, 'Las sondas espaciales son herramientas tecnológicas que han permitido obtener información detallada sobre otros planetas mediante misiones no tripuladas.', 'intermedia', 35),
  ('Un estudiante investiga que, gracias a telescopios espaciales y sondas enviadas a otros planetas, los científicos han podido observar detalles de galaxias lejanas y estudiar la superficie de planetas como Marte. ¿Qué papel cumplen estas herramientas tecnológicas en el avance del conocimiento astronómico?', '["No aportan ningún avance al conocimiento astronómico","Permiten obtener información y evidencia que sería imposible conseguir solo a simple vista","Reemplazan por completo la necesidad de investigación científica","Solo sirven para fines de entretenimiento"]', 3, 'Estas herramientas tecnológicas permiten obtener información y evidencia astronómica que sería imposible conseguir solo a simple vista, aportando al avance del conocimiento científico.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_8_basico' and lo.short_name = 'Herramientas tecnológicas para la observación astronómica'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 8° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué característica debe tener una hipótesis científica para ser considerada contrastable?', '["Debe poder ponerse a prueba mediante observación o experimentación","Debe ser una opinión personal sin ninguna evidencia posible","Debe ser imposible de comprobar de cualquier forma","No necesita relacionarse con ninguna pregunta de investigación"]', 0, 'Una hipótesis contrastable debe poder ponerse a prueba mediante observación o experimentación.', 'inicial', 25),
  ('¿Cuál de estas hipótesis es contrastable mediante un experimento?', '["Si aumento la cantidad de luz, las plantas de esta especie crecerán más rápido","Las plantas son más bonitas que los animales","A las plantas les gusta más un color que otro","Las plantas tienen sentimientos como las personas"]', 1, 'La hipótesis sobre la luz y el crecimiento de las plantas es contrastable, ya que se puede comprobar mediante un experimento.', 'intermedia', 35),
  ('¿Por qué la hipótesis ''las plantas son más bonitas que los animales'' no es una hipótesis científica contrastable?', '["Porque depende de una opinión personal, no de evidencia observable o medible","Porque menciona tanto plantas como animales","Porque es demasiado larga","Porque no menciona ningún ser vivo"]', 2, 'Esta afirmación depende de una opinión personal sobre estética, no de evidencia observable o medible, por lo que no es una hipótesis científica contrastable.', 'intermedia', 35),
  ('Un estudiante propone la hipótesis: ''si la temperatura del agua aumenta, entonces una pastilla efervescente se disolverá más rápido''. ¿Por qué esta hipótesis es adecuada para una investigación científica?', '["Porque es una opinión personal sobre las pastillas","Porque no menciona ninguna variable medible","Porque plantea una relación entre variables que se puede poner a prueba mediante un experimento controlado","Porque no es posible medir el tiempo de disolución"]', 3, 'Esta hipótesis es adecuada porque plantea una relación clara entre dos variables (temperatura y tiempo de disolución) que se puede poner a prueba mediante un experimento controlado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_8_basico' and lo.short_name = 'Formulación de hipótesis contrastables'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué debería incluir el diseño de un procedimiento experimental para poner a prueba una hipótesis?', '["Los pasos a seguir, los materiales y el control de variables","Solo el resultado esperado, sin ningún paso a seguir","Solo una lista de nombres de estudiantes","Ninguna referencia a la hipótesis planteada"]', 0, 'El diseño de un procedimiento experimental debe incluir los pasos a seguir, los materiales necesarios y el control de variables.', 'inicial', 25),
  ('Para poner a prueba la hipótesis ''si aumenta la temperatura, una pastilla efervescente se disuelve más rápido'', ¿qué procedimiento experimental sería más adecuado?', '["Probar con agua a distintas temperaturas, usando la misma cantidad de agua y de pastilla en cada prueba, midiendo el tiempo de disolución","Probar solo una vez con agua a temperatura ambiente, sin comparar con otras temperaturas","Cambiar el tipo de pastilla en cada prueba, sin variar la temperatura","No es necesario diseñar ningún procedimiento para poner a prueba esta hipótesis"]', 1, 'Un procedimiento adecuado prueba distintas temperaturas manteniendo constantes las demás variables (cantidad de agua y de pastilla), midiendo el tiempo de disolución.', 'intermedia', 35),
  ('¿Por qué es importante repetir un procedimiento experimental varias veces (repeticiones) antes de sacar conclusiones?', '["Para aumentar la confianza en los resultados obtenidos, reduciendo el efecto de errores puntuales","Porque una sola medición siempre es suficiente para cualquier conclusión","Porque repetir el experimento cambia la hipótesis planteada","Porque las repeticiones no aportan ninguna información adicional"]', 2, 'Repetir el procedimiento varias veces aumenta la confianza en los resultados, reduciendo el efecto de errores puntuales o casuales.', 'intermedia', 35),
  ('Un estudiante diseña un procedimiento para probar si el tipo de superficie afecta la distancia que recorre un carrito de juguete al soltarlo desde una rampa, usando la misma rampa y el mismo carrito, y probando en tres superficies distintas, repitiendo cada prueba tres veces. ¿Qué elementos de un buen diseño experimental están presentes en este procedimiento?', '["Ningún elemento de un buen diseño experimental","Solo el uso de materiales, sin ningún control de variables","Control de variables (misma rampa y carrito), variación de la variable en estudio (superficie) y repeticiones para mayor confianza","Solo la repetición, sin control de ninguna otra variable"]', 3, 'Este procedimiento incluye control de variables (misma rampa y carrito), variación de la variable en estudio (tipo de superficie) y repeticiones para aumentar la confianza en los resultados.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_8_basico' and lo.short_name = 'Diseño de procedimientos experimentales'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 8° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa evaluar si la evidencia obtenida en una investigación apoya o refuta una hipótesis?', '["Comparar los resultados obtenidos con lo que la hipótesis predecía","Ignorar los resultados y mantener siempre la hipótesis original","Cambiar la hipótesis sin revisar los resultados obtenidos","Aceptar la hipótesis sin importar los resultados"]', 0, 'Evaluar la evidencia implica comparar los resultados obtenidos con lo que la hipótesis predecía, para ver si la apoya o la refuta.', 'inicial', 25),
  ('Un estudiante planteó la hipótesis ''si aumenta la temperatura, la pastilla se disuelve más rápido'', y los resultados mostraron que efectivamente se disolvió más rápido a mayor temperatura en todas las pruebas. ¿Qué se puede concluir al evaluar esta evidencia?', '["La evidencia refuta la hipótesis","La evidencia no tiene relación con la hipótesis","La evidencia obtenida apoya la hipótesis planteada","No es posible evaluar la evidencia en este caso"]', 1, 'Como los resultados coinciden con lo que predecía la hipótesis, se concluye que la evidencia obtenida apoya la hipótesis planteada.', 'intermedia', 35),
  ('Un grupo de estudiantes planteó que ''el color del recipiente afecta el tiempo de disolución de una pastilla'', pero al repetir el experimento varias veces no encontraron ninguna diferencia notoria entre los distintos colores probados. ¿Qué se puede concluir al evaluar esta evidencia?', '["La evidencia apoya fuertemente la hipótesis planteada","La evidencia obtenida no apoya la hipótesis planteada","No es posible sacar ninguna conclusión con estos resultados","La hipótesis queda automáticamente comprobada"]', 2, 'Como los resultados no muestran diferencias notorias entre los colores, la evidencia obtenida no apoya la hipótesis planteada.', 'intermedia', 35),
  ('Un estudiante realizó un experimento una sola vez y, basándose en ese único resultado, concluyó de forma definitiva que su hipótesis era completamente correcta para todos los casos posibles. ¿Qué problema tiene esta forma de evaluar la evidencia?', '["Ningún problema, un solo experimento siempre es suficiente","Generaliza de forma excesiva a partir de una evidencia limitada (una sola repetición)","La evaluación de la evidencia no tiene ninguna importancia en ciencia","El problema es que repitió el experimento demasiadas veces"]', 3, 'El problema es que generaliza de forma excesiva una conclusión definitiva a partir de una evidencia limitada, obtenida de una sola repetición del experimento.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_8_basico' and lo.short_name = 'Evaluación de la evidencia obtenida'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
