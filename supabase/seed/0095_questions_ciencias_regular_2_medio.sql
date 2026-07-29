-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 2° Medio. Cubre los 14 objetivos de aprendizaje de 2° Medio
-- cargados por
-- supabase/seed/0018_curriculum_ciencias_regular_7basico_2medio.sql, con 4
-- preguntas por objetivo, total 56 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí).

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 2° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué estructura celular contiene la información genética organizada en forma de cromosomas?', '["El núcleo","La mitocondria","La pared celular","El ribosoma"]', 0, 'El núcleo contiene la información genética organizada en forma de cromosomas.', 'inicial', 25),
  ('¿Qué proceso del ciclo celular permite que una célula se divida en dos células idénticas, para el crecimiento y reparación de tejidos?', '["La meiosis","La mitosis","La fotosíntesis","La respiración celular"]', 1, 'La mitosis es el proceso que permite que una célula se divida en dos células idénticas, útil para el crecimiento y reparación de tejidos.', 'intermedia', 35),
  ('¿Qué proceso del ciclo celular da origen a células reproductoras (óvulos y espermatozoides) con la mitad de la información genética?', '["La mitosis","La fotosíntesis","La meiosis","La respiración celular"]', 2, 'La meiosis da origen a células reproductoras con la mitad de la información genética de la célula original.', 'intermedia', 35),
  ('Un estudiante compara dos procesos: uno que produce dos células hijas genéticamente idénticas a la célula original, usado para el crecimiento del cuerpo, y otro que produce células con la mitad de la información genética, usado para la reproducción. ¿Qué procesos está comparando, en ese orden?', '["Meiosis y mitosis","Fotosíntesis y respiración celular","Mitosis y meiosis","Respiración celular y fotosíntesis"]', 3, 'Está comparando la mitosis (produce células idénticas, para crecimiento) y la meiosis (produce células con la mitad de la información genética, para la reproducción).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_2_medio' and lo.short_name = 'Información genética, cromosomas y ciclo celular'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Según los principios básicos de Mendel, ¿qué es un alelo dominante?', '["Una versión de un gen cuyo efecto se manifiesta incluso si solo está presente en una copia","Una versión de un gen que nunca se manifiesta","Un gen que desaparece después de una generación","Un gen exclusivo de las plantas"]', 0, 'Un alelo dominante es una versión de un gen cuyo efecto se manifiesta incluso si solo está presente en una copia.', 'inicial', 25),
  ('Según los principios básicos de Mendel, ¿cuándo se manifiesta un alelo recesivo en un organismo?', '["Siempre, sin importar qué otro alelo esté presente","Solo cuando el organismo tiene dos copias de ese alelo recesivo, sin ningún alelo dominante","Nunca se manifiesta bajo ninguna condición","Solo en las plantas, no en los animales"]', 1, 'Un alelo recesivo se manifiesta solo cuando el organismo tiene dos copias de ese alelo, sin ningún alelo dominante presente.', 'intermedia', 35),
  ('Si un organismo hereda un alelo dominante de un progenitor y un alelo recesivo del otro progenitor para una misma característica, ¿qué característica se espera que se manifieste, según los principios de Mendel?', '["La característica asociada al alelo recesivo","Ninguna de las dos características se manifiesta","La característica asociada al alelo dominante","Ambas características se manifiestan por igual siempre"]', 2, 'Cuando un organismo hereda un alelo dominante y uno recesivo, generalmente se manifiesta la característica asociada al alelo dominante.', 'intermedia', 35),
  ('Un estudiante representa el cruce entre dos plantas de arvejas: una con flores moradas (alelo dominante) y otra con flores blancas (alelo recesivo). Todas las plantas de la primera generación tienen flores moradas. ¿Qué explica mejor este resultado, según los principios básicos de Mendel?', '["Que el alelo de flor blanca es dominante sobre el de flor morada","Que ambos alelos desaparecieron en la primera generación","Que el alelo de flor morada es dominante sobre el de flor blanca, por eso se manifestó en toda la descendencia","Que los principios de Mendel no aplican a las plantas"]', 3, 'Que todas las plantas de la primera generación tengan flores moradas indica que el alelo de flor morada es dominante sobre el de flor blanca.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_2_medio' and lo.short_name = 'Leyes de Mendel a nivel introductorio'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué propone la teoría de la evolución de las especies mediante selección natural?', '["Que las especies cambian con el tiempo, y los individuos mejor adaptados tienen más probabilidad de sobrevivir y reproducirse","Que todas las especies aparecieron exactamente iguales a como son hoy","Que las especies nunca cambian con el tiempo","Que la selección natural no tiene relación con la supervivencia de los individuos"]', 0, 'La teoría de la evolución mediante selección natural propone que las especies cambian con el tiempo, favoreciendo a los individuos mejor adaptados a su ambiente.', 'inicial', 25),
  ('¿Qué evidencia científica se utiliza frecuentemente para apoyar la teoría de la evolución de las especies?', '["Los registros fósiles que muestran cambios graduales en distintas especies a lo largo del tiempo","La ausencia total de similitudes entre especies distintas","La opinión personal de una sola persona","La imposibilidad de estudiar organismos antiguos"]', 1, 'Los registros fósiles, que muestran cambios graduales en distintas especies a lo largo del tiempo, son una evidencia utilizada para apoyar la teoría de la evolución.', 'intermedia', 35),
  ('¿Por qué algunos individuos de una especie tienen mayor probabilidad de sobrevivir y reproducirse en un ambiente determinado, según la selección natural?', '["Porque poseen características que les permiten adaptarse mejor a las condiciones de ese ambiente","Porque todos los individuos de una especie son exactamente iguales","Porque la supervivencia no depende de ninguna característica del individuo","Porque el ambiente no influye en la supervivencia de los individuos"]', 2, 'Según la selección natural, los individuos con características que les permiten adaptarse mejor a su ambiente tienen mayor probabilidad de sobrevivir y reproducirse.', 'intermedia', 35),
  ('Un estudiante investiga que, en una población de insectos de un mismo color, tras varias generaciones en un ambiente donde predomina un color de fondo distinto, la mayoría de los insectos terminó teniendo un color similar al de ese fondo, lo que les ayuda a camuflarse de sus depredadores. ¿Qué proceso evolutivo explica mejor este cambio en la población?', '["Que el color de los insectos cambió por decisión propia de cada individuo","Que la selección natural favoreció a los individuos con un color que les permitía camuflarse mejor, aumentando su supervivencia","Que este cambio no tiene relación con la evolución de las especies","Que todos los insectos de la población eran exactamente iguales antes y después del cambio"]', 3, 'Este cambio se explica por la selección natural, que favoreció a los individuos con un color que les permitía camuflarse mejor de sus depredadores, aumentando su supervivencia y reproducción.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_2_medio' and lo.short_name = 'Evolución de las especies'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la función principal del sistema inmunológico?', '["Defender al cuerpo de agentes externos que pueden causar enfermedades","Producir el movimiento del cuerpo","Digerir los alimentos consumidos","Transportar oxígeno a las células"]', 0, 'La función principal del sistema inmunológico es defender al cuerpo de agentes externos, como virus y bacterias, que pueden causar enfermedades.', 'inicial', 25),
  ('¿Qué son los anticuerpos, en el contexto del sistema inmunológico?', '["Sustancias que produce el cuerpo para ayudar a combatir agentes específicos que causan enfermedades","Un tipo de hueso del cuerpo","Un órgano del sistema digestivo","Una sustancia que produce únicamente el sistema circulatorio, sin relación con las defensas"]', 1, 'Los anticuerpos son sustancias que produce el cuerpo para ayudar a combatir agentes específicos que causan enfermedades.', 'intermedia', 35),
  ('¿Qué principio general utilizan algunas vacunas para ayudar al sistema inmunológico a prepararse contra una enfermedad?', '["Exponer al cuerpo a una versión debilitada o inactivada de un agente, para que produzca defensas antes de un posible contagio real","Eliminar por completo el sistema inmunológico del cuerpo","Evitar cualquier tipo de contacto con agentes externos para siempre","Producir la enfermedad completa de forma intencional y sin control"]', 2, 'Algunas vacunas exponen al cuerpo a una versión debilitada o inactivada de un agente, para que el sistema inmunológico produzca defensas antes de un posible contagio real.', 'intermedia', 35),
  ('Un estudiante investiga que, tras superar cierta enfermedad, algunas personas desarrollan defensas que les ayudan a no volver a enfermarse de la misma forma frente al mismo agente en el futuro. ¿Qué concepto general relacionado con el sistema inmunológico explica esta situación?', '["Que el sistema inmunológico no guarda ningún registro de agentes anteriores","Que el cuerpo desarrolla una memoria inmunológica que ayuda a responder más rápido ante un agente ya conocido","Que las personas nunca pueden desarrollar defensas frente a ningún agente","Que este fenómeno no tiene relación con el sistema inmunológico"]', 3, 'Esta situación se explica por la memoria inmunológica: el cuerpo guarda un registro de agentes ya enfrentados, lo que ayuda a responder más rápido en el futuro.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_2_medio' and lo.short_name = 'Sistema inmunológico'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 2° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué establece el principio de conservación de la energía?', '["Que la energía no se crea ni se destruye, solo se transforma de una forma a otra","Que la energía siempre desaparece con el tiempo","Que la energía se puede crear libremente sin ninguna fuente","Que la energía solo existe en forma de calor"]', 0, 'El principio de conservación de la energía establece que la energía no se crea ni se destruye, solo se transforma de una forma a otra.', 'inicial', 25),
  ('En una caída libre, ¿en qué se transforma principalmente la energía potencial de un objeto a medida que cae?', '["En energía química","En energía cinética","En energía eléctrica directamente","En energía nuclear"]', 1, 'En una caída libre, la energía potencial se transforma principalmente en energía cinética a medida que el objeto cae.', 'intermedia', 35),
  ('¿Qué transformación de energía ocurre en un panel solar al generar electricidad a partir de la luz del Sol?', '["Energía química en energía eléctrica","Energía eléctrica en energía luminosa","Energía luminosa (solar) en energía eléctrica","Energía nuclear en energía luminosa"]', 2, 'Un panel solar transforma la energía luminosa (solar) en energía eléctrica.', 'intermedia', 35),
  ('Un estudiante analiza una situación: una persona sube en bicicleta hasta la cima de una colina (energía química de sus músculos transformándose en energía potencial), y luego baja rodando cada vez más rápido (energía potencial transformándose en energía cinética), sin ganar ni perder energía total en el sistema (despreciando la fricción). ¿Qué principio físico ilustra mejor esta situación?', '["Que la energía se destruye al final del recorrido","Que la energía se transforma de una forma a otra, conservándose en total (principio de conservación de la energía)","Que la energía se crea de la nada en la cima de la colina","Que este fenómeno no tiene relación con ningún principio físico"]', 3, 'Esta situación ilustra el principio de conservación de la energía: la energía se transforma de una forma a otra (química, potencial, cinética), pero se conserva en total.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_2_medio' and lo.short_name = 'Energía y sus transformaciones'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué tipo de enlace químico se forma cuando dos átomos comparten electrones entre sí?', '["El enlace covalente","El enlace iónico","El enlace metálico","No existe ningún tipo de enlace en ese caso"]', 0, 'El enlace covalente se forma cuando dos átomos comparten electrones entre sí.', 'inicial', 25),
  ('¿Qué tipo de enlace químico se forma cuando un átomo transfiere electrones a otro, formando iones con cargas opuestas que se atraen?', '["El enlace covalente","El enlace iónico","El enlace metálico","El enlace de hidrógeno exclusivamente"]', 1, 'El enlace iónico se forma cuando un átomo transfiere electrones a otro, formando iones con cargas opuestas que se atraen.', 'intermedia', 35),
  ('¿Cuál de estos compuestos es un ejemplo clásico de sustancia formada por enlace iónico?', '["La sal de mesa (cloruro de sodio)","El agua (formada mayormente por enlaces covalentes)","El oxígeno gaseoso (O2)","El diamante (formado por enlaces covalentes entre átomos de carbono)"]', 2, 'La sal de mesa (cloruro de sodio) es un ejemplo clásico de sustancia formada por enlace iónico, entre sodio y cloro.', 'intermedia', 35),
  ('Un estudiante compara dos sustancias: el agua (H2O), donde los átomos comparten electrones para formar la molécula, y la sal de mesa (NaCl), donde un átomo transfiere un electrón a otro formando iones con cargas opuestas. ¿Qué tipo de enlace corresponde a cada sustancia, en ese orden?', '["Iónico y covalente","Metálico y covalente","Iónico y metálico","Covalente e iónico"]', 3, 'El agua se forma principalmente por enlaces covalentes (los átomos comparten electrones), y la sal de mesa se forma por enlace iónico (transferencia de electrones).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_2_medio' and lo.short_name = 'Tipos de enlaces químicos'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué ocurre con un elemento cuando se oxida, en una reacción de óxido-reducción?', '["Pierde electrones","Gana electrones","No cambia su cantidad de electrones","Deja de ser un elemento químico"]', 0, 'Un elemento se oxida cuando pierde electrones en una reacción de óxido-reducción.', 'inicial', 25),
  ('¿Qué ocurre con un elemento cuando se reduce, en una reacción de óxido-reducción?', '["Pierde electrones","Gana electrones","No cambia su cantidad de electrones","Deja de existir como elemento"]', 1, 'Un elemento se reduce cuando gana electrones en una reacción de óxido-reducción.', 'intermedia', 35),
  ('¿Cuál de estos procesos biológicos involucra reacciones de óxido-reducción?', '["La respiración celular, donde se transfieren electrones para producir energía","El crecimiento del pelo, sin relación con transferencia de electrones","El color de los ojos, sin relación con este tipo de reacción","El tamaño de los huesos, sin relación con este tipo de reacción"]', 2, 'La respiración celular involucra reacciones de óxido-reducción, donde se transfieren electrones para producir energía utilizable por la célula.', 'intermedia', 35),
  ('Un estudiante observa que un clavo de fierro expuesto al aire húmedo durante varios días se cubre de óxido (oxidación del fierro), mientras que en ese mismo proceso el oxígeno del aire participa ganando electrones. ¿Qué está ocurriendo, en términos de óxido-reducción, con el fierro y el oxígeno respectivamente?', '["El fierro se reduce y el oxígeno se oxida","Ambos se oxidan al mismo tiempo","Ambos se reducen al mismo tiempo","El fierro se oxida (pierde electrones) y el oxígeno se reduce (gana electrones)"]', 3, 'En este proceso, el fierro se oxida al perder electrones, mientras que el oxígeno se reduce al ganar esos electrones.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_2_medio' and lo.short_name = 'Reacciones de óxido-reducción'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la radiactividad?', '["La emisión de energía y partículas desde el núcleo de ciertos átomos inestables","Un tipo de luz visible producida por el Sol","Un fenómeno exclusivo de los líquidos","Un proceso que ocurre solo en los seres vivos"]', 0, 'La radiactividad es la emisión de energía y partículas desde el núcleo de ciertos átomos inestables.', 'inicial', 25),
  ('¿Cuál de estas es una aplicación médica de la radiactividad, usada con fines de diagnóstico o tratamiento?', '["El uso de radioterapia para tratar ciertos tipos de cáncer","La producción de electricidad en un panel solar","El uso de un termómetro común","La fabricación de plástico"]', 1, 'La radioterapia, utilizada para tratar ciertos tipos de cáncer, es una aplicación médica de la radiactividad.', 'intermedia', 35),
  ('¿Por qué es importante manejar con precaución los materiales radiactivos?', '["Porque la exposición excesiva a la radiación puede tener efectos dañinos para la salud","Porque los materiales radiactivos no tienen ningún riesgo","Porque solo afectan a los objetos, sin relación con la salud humana","Porque son completamente inofensivos en cualquier cantidad"]', 2, 'Es importante manejar con precaución los materiales radiactivos porque la exposición excesiva a la radiación puede tener efectos dañinos para la salud.', 'intermedia', 35),
  ('Un estudiante investiga que la radiactividad se usa tanto en aplicaciones médicas beneficiosas (como el diagnóstico por imágenes o el tratamiento de tumores) como en fuentes de energía (como las centrales nucleares), pero que también implica riesgos si no se maneja adecuadamente. ¿Qué idea general sobre los fenómenos radiactivos refleja esta información?', '["Que la radiactividad no tiene ninguna aplicación útil","Que la radiactividad puede tener aplicaciones beneficiosas, pero también riesgos que deben manejarse con precaución","Que la radiactividad es completamente segura sin ninguna precaución","Que la radiactividad no se relaciona con la medicina ni la energía"]', 3, 'Esta información refleja que la radiactividad puede tener aplicaciones beneficiosas (medicina, energía), pero también implica riesgos que deben manejarse con precaución.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_2_medio' and lo.short_name = 'Fenómenos radiactivos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 2° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos recursos energéticos se considera renovable y sustentable?', '["La energía solar","El petróleo","El carbón","El gas natural"]', 0, 'La energía solar se considera un recurso energético renovable y sustentable.', 'inicial', 25),
  ('¿Qué significa que el uso de un recurso energético sea sustentable?', '["Que se puede usar sin comprometer la disponibilidad de ese recurso para las futuras generaciones","Que se puede usar sin ningún límite ni consideración ambiental","Que solo se refiere a recursos no renovables","Que no tiene relación con el uso responsable de los recursos"]', 1, 'Un uso sustentable de un recurso energético significa que se puede usar sin comprometer su disponibilidad para las futuras generaciones.', 'intermedia', 35),
  ('¿Cuál de estas medidas contribuye a un uso más sustentable de los recursos energéticos a nivel de un país?', '["Diversificar la matriz energética incluyendo fuentes renovables como la solar y la eólica","Depender exclusivamente de combustibles fósiles no renovables","Aumentar sin ningún control el uso de carbón","Eliminar por completo cualquier política de eficiencia energética"]', 2, 'Diversificar la matriz energética incluyendo fuentes renovables contribuye a un uso más sustentable de los recursos energéticos.', 'intermedia', 35),
  ('Un país decide invertir en parques solares y eólicos, además de establecer políticas de eficiencia energética en la industria y los hogares, con el objetivo de reducir su dependencia de combustibles fósiles en las próximas décadas. ¿Qué relación tiene esta estrategia con el uso sustentable de los recursos energéticos?', '["No tiene ninguna relación con el uso sustentable de recursos energéticos","Busca aumentar el uso de recursos no renovables","Refleja una estrategia orientada al uso sustentable de recursos energéticos, priorizando fuentes renovables y la eficiencia","Elimina por completo la necesidad de cualquier fuente de energía"]', 3, 'Esta estrategia refleja un enfoque orientado al uso sustentable de los recursos energéticos, priorizando fuentes renovables y la eficiencia en su consumo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_2_medio' and lo.short_name = 'Recursos energéticos y uso sustentable'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un fenómeno atmosférico?', '["La formación de nubes","La formación de rocas ígneas","El movimiento de placas tectónicas","La formación de un cristal en el suelo"]', 0, 'La formación de nubes es un fenómeno atmosférico.', 'inicial', 25),
  ('¿Qué relación existe entre los fenómenos atmosféricos y el clima de una región?', '["No tienen ninguna relación entre sí","Los patrones repetidos de fenómenos atmosféricos a lo largo del tiempo determinan el clima de una región","El clima determina completamente los fenómenos atmosféricos, sin relación inversa","Los fenómenos atmosféricos ocurren de forma idéntica en todo el planeta"]', 1, 'Los patrones repetidos de fenómenos atmosféricos (temperatura, precipitaciones, viento) a lo largo del tiempo determinan el clima de una región.', 'intermedia', 35),
  ('¿Cuál de estos fenómenos atmosféricos puede tener consecuencias importantes para una región costera de Chile?', '["Un temporal con fuertes lluvias y viento","Un cambio en la posición de las estrellas","Un movimiento de placas tectónicas exclusivamente","Un cambio en la composición de una roca"]', 2, 'Un temporal con fuertes lluvias y viento es un fenómeno atmosférico que puede tener consecuencias importantes para una región costera.', 'intermedia', 35),
  ('Un estudiante investiga que, en una región determinada, se registran veranos secos y calurosos, e inviernos con abundantes lluvias, de forma repetida año tras año durante décadas. ¿Qué se puede afirmar sobre esta información, distinguiendo entre clima y fenómenos atmosféricos puntuales?', '["Esta información describe el clima de esa región, ya que refleja un patrón repetido a lo largo del tiempo","Esta información describe solo un fenómeno atmosférico puntual de un único día","El clima y los fenómenos atmosféricos son exactamente lo mismo, sin ninguna diferencia","Esta información no tiene relación con el concepto de clima"]', 3, 'Esta información describe el clima de la región, ya que refleja un patrón repetido de fenómenos atmosféricos a lo largo de muchos años, no un evento puntual.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_2_medio' and lo.short_name = 'Fenómenos atmosféricos y el clima'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas actividades humanas contribuye a modificar la composición de la atmósfera?', '["La quema de combustibles fósiles, que libera gases de efecto invernadero","La observación de estrellas con un telescopio","La lectura de un libro","La práctica de un deporte al aire libre sin uso de vehículos"]', 0, 'La quema de combustibles fósiles libera gases de efecto invernadero que modifican la composición de la atmósfera.', 'inicial', 25),
  ('¿Qué efecto puede tener el aumento de gases de efecto invernadero en la atmósfera sobre el clima del planeta?', '["Puede contribuir al aumento de la temperatura promedio global","Reduce por completo la temperatura del planeta","No tiene ningún efecto sobre el clima","Elimina completamente los fenómenos climáticos"]', 1, 'El aumento de gases de efecto invernadero puede contribuir al aumento de la temperatura promedio global, un componente del cambio climático.', 'intermedia', 35),
  ('¿Cuál de estas acciones a nivel de una comunidad ayudaría a reducir el impacto de la actividad humana en la atmósfera?', '["Promover el uso de transporte público y bicicletas en vez de vehículos individuales a combustión","Aumentar sin ningún control el uso de vehículos a combustión","Eliminar por completo el transporte público","Aumentar la quema de combustibles fósiles sin ninguna regulación"]', 2, 'Promover el uso de transporte público y bicicletas ayuda a reducir las emisiones de gases contaminantes hacia la atmósfera.', 'intermedia', 35),
  ('Un estudiante investiga que, desde mediados del siglo XX, la concentración de dióxido de carbono en la atmósfera ha aumentado de forma sostenida, coincidiendo con el aumento del uso de combustibles fósiles en la industria y el transporte a nivel mundial. ¿Qué relación sugiere esta evidencia sobre el impacto de la actividad humana en la atmósfera?', '["No existe ninguna relación entre la actividad industrial y la composición de la atmósfera","La actividad humana relacionada con el uso de combustibles fósiles podría estar contribuyendo al aumento de dióxido de carbono en la atmósfera","La concentración de dióxido de carbono ha disminuido desde mediados del siglo XX","El uso de combustibles fósiles no tiene ninguna relación con los gases de la atmósfera"]', 3, 'Esta evidencia sugiere que la actividad humana relacionada con el uso de combustibles fósiles podría estar contribuyendo al aumento de dióxido de carbono en la atmósfera.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_2_medio' and lo.short_name = 'Impacto de la actividad humana en la atmósfera'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 2° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué etapas debería incluir el diseño de una investigación científica completa?', '["Pregunta, hipótesis, diseño experimental con control de variables, recolección de datos y análisis de resultados","Solo una pregunta, sin ninguna otra etapa","Solo la recolección de datos, sin ninguna pregunta previa","Solo una conclusión, sin ningún procedimiento previo"]', 0, 'Una investigación científica completa debería incluir pregunta, hipótesis, diseño experimental con control de variables, recolección de datos y análisis de resultados.', 'inicial', 25),
  ('¿Por qué es importante definir claramente la variable independiente y la variable dependiente antes de iniciar una investigación?', '["Para poder diseñar un experimento que permita analizar la relación entre esas variables de forma controlada","Porque no es necesario identificar ninguna variable en una investigación","Porque las variables no tienen relación con el diseño experimental","Porque las variables solo se definen después de obtener los resultados"]', 1, 'Definir claramente las variables permite diseñar un experimento que analice su relación de forma controlada, antes de iniciar la investigación.', 'intermedia', 35),
  ('Un estudiante diseña una investigación completa sobre el efecto del tipo de fertilizante en el crecimiento de una planta, definiendo la pregunta, la hipótesis, las variables, el control de otras condiciones, y planificando cómo registrará los datos. ¿Qué característica de una investigación científica completa está aplicando?', '["Ninguna característica relevante","Solo la definición de una pregunta, sin ningún otro elemento","Un diseño integral que contempla todas las etapas necesarias para una investigación rigurosa","Solo el control de variables, sin ninguna pregunta ni hipótesis"]', 2, 'El estudiante está aplicando un diseño integral que contempla todas las etapas necesarias (pregunta, hipótesis, variables, control y registro de datos) para una investigación rigurosa.', 'intermedia', 35),
  ('Un grupo de estudiantes diseña una investigación para determinar si el tipo de suelo afecta la germinación de semillas de una especie. Definen la pregunta, plantean una hipótesis, controlan variables como la cantidad de agua y luz, usan varias repeticiones para cada tipo de suelo, y planifican cómo registrarán y analizarán los datos obtenidos. ¿Qué aspecto de su diseño demuestra mayor rigor científico?', '["Que no controlaron ninguna variable adicional al tipo de suelo","Que usaron una sola semilla por tipo de suelo, sin repeticiones","Que combinaron el control de variables, las repeticiones y una planificación clara del análisis de datos","Que no definieron ninguna hipótesis antes de comenzar"]', 3, 'El mayor rigor científico se demuestra al combinar el control de variables, el uso de repeticiones y una planificación clara del análisis de los datos obtenidos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_2_medio' and lo.short_name = 'Diseño de una investigación científica completa'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué característica debería tener la comunicación de resultados de una investigación cuando se usa lenguaje científico?', '["Ser precisa, usar términos adecuados y presentar la evidencia cuantitativa obtenida","Usar únicamente opiniones personales sin ningún dato","Evitar mencionar cualquier dato numérico obtenido","Ser ambigua y poco clara para el público"]', 0, 'La comunicación con lenguaje científico debe ser precisa, usar términos adecuados y presentar la evidencia cuantitativa obtenida.', 'inicial', 25),
  ('¿Por qué es preferible decir ''la temperatura promedio aumentó 3°C en el período estudiado'' en vez de simplemente ''hizo más calor'', al comunicar resultados científicos?', '["Porque la primera expresión es más precisa y cuantitativa, propia del lenguaje científico","Porque ambas expresiones son igual de precisas","Porque la segunda expresión es más adecuada para un informe científico","Porque no hay ninguna diferencia entre ambas expresiones"]', 1, 'La primera expresión es más precisa y cuantitativa, características propias de una comunicación adecuada con lenguaje científico.', 'intermedia', 35),
  ('Un estudiante presenta sus resultados diciendo: ''las plantas con más luz crecieron bastante más que las otras''. ¿Cómo podría mejorar esta comunicación usando lenguaje científico más preciso?', '["Manteniendo la misma expresión, sin ningún cambio","Usando datos concretos, por ejemplo: ''las plantas con más luz crecieron en promedio 6 cm más que las plantas con menos luz''","Eliminando toda mención a los resultados obtenidos","Usando únicamente adjetivos como ''bastante'' o ''mucho'', sin ningún dato numérico"]', 2, 'Usar datos concretos y cuantitativos, como un promedio de crecimiento en centímetros, mejora la precisión de la comunicación con lenguaje científico.', 'intermedia', 35),
  ('Un estudiante redacta la conclusión de su investigación así: ''En este experimento, las plantas regadas diariamente crecieron en promedio 18 cm, mientras que las regadas semanalmente crecieron en promedio 6 cm, después de un mes de observación''. ¿Qué característica del lenguaje científico está aplicando correctamente en esta conclusión?', '["Ninguna característica relevante del lenguaje científico","El uso de opiniones personales sin ningún dato","El uso de datos cuantitativos precisos para respaldar la comunicación de resultados","La ambigüedad en la descripción de los resultados obtenidos"]', 3, 'El estudiante está aplicando correctamente el uso de datos cuantitativos precisos, una característica clave del lenguaje científico al comunicar resultados.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_2_medio' and lo.short_name = 'Comunicación de resultados con lenguaje científico'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Medio, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué aspecto es importante revisar al analizar de forma crítica una investigación científica publicada?', '["Si el método utilizado permite responder de forma adecuada a la pregunta de investigación planteada","Solo el título de la investigación, sin revisar el método","Solo la cantidad de páginas del artículo","Solo la opinión personal de quien lo lee, sin revisar el método"]', 0, 'Al analizar de forma crítica una investigación, es importante revisar si el método utilizado permite responder adecuadamente a la pregunta planteada.', 'inicial', 25),
  ('¿Por qué es relevante revisar el tamaño de la muestra utilizada en una investigación científica al analizarla de forma crítica?', '["Porque una muestra muy pequeña puede limitar qué tan generalizables son los resultados obtenidos","Porque el tamaño de la muestra nunca afecta la validez de una investigación","Porque solo importa el nombre de los investigadores, no el tamaño de la muestra","Porque una muestra pequeña siempre es mejor que una grande"]', 1, 'Una muestra muy pequeña puede limitar qué tan generalizables son los resultados obtenidos, por lo que es relevante revisarla al analizar críticamente una investigación.', 'intermedia', 35),
  ('Un estudiante lee una investigación que concluye, a partir de solo 3 participantes, que cierto hábito mejora la memoria en toda la población. ¿Qué crítica es más adecuada hacer a esta investigación?', '["Ninguna crítica, la conclusión es completamente válida","La conclusión generaliza demasiado a partir de una muestra muy pequeña (solo 3 participantes)","La investigación es perfecta porque usa pocos participantes","El tamaño de la muestra no tiene ninguna relación con la validez de la conclusión"]', 2, 'La crítica más adecuada es que la conclusión generaliza demasiado a partir de una muestra muy pequeña, lo cual limita la validez de la afirmación para toda la población.', 'intermedia', 35),
  ('Un estudiante analiza dos investigaciones sobre el mismo tema: una con 500 participantes, variables bien controladas y resultados replicados por otros equipos de investigación; y otra con 5 participantes, sin control claro de variables y sin haber sido replicada por nadie más. ¿Qué análisis crítico es más adecuado al comparar ambas investigaciones?', '["Ambas investigaciones son igual de confiables, sin importar el tamaño de la muestra ni el control de variables","La segunda investigación es más confiable, porque es más fácil de leer","La primera investigación ofrece, en general, evidencia más sólida, debido al mayor tamaño de muestra, control de variables y replicación de resultados","No es posible comparar la calidad de ambas investigaciones bajo ningún criterio"]', 3, 'La primera investigación ofrece, en general, evidencia más sólida debido al mayor tamaño de muestra, el control de variables y la replicación de resultados por otros equipos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_2_medio' and lo.short_name = 'Análisis crítico de investigaciones científicas publicadas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
