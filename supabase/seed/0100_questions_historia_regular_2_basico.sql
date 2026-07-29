-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 2° Básico. Cubre los 12 objetivos de
-- aprendizaje de 2° Básico cargados por
-- supabase/seed/0021_curriculum_historia_regular_basica_1_6.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en supabase/seed/0099 (no se repite íntegro
-- aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'.
--
-- NOTA PEDAGÓGICA: este archivo incluye el primer objetivo sobre pueblos
-- originarios de Chile ("Costumbres de pueblos originarios de Chile"). Las
-- preguntas se limitan a describir formas de vida, costumbres y actividades
-- (alimentación, vivienda, oficios) de forma factual y respetuosa, sin
-- abordar todavía el proceso de conquista ni conflictos históricos (que se
-- tratan recién desde 3°-4° Básico en adelante, según la progresión
-- curricular), y sin generalizaciones ni estereotipos: se habla de "algunos
-- pueblos originarios" y de pueblos concretos (mapuche, aymara, rapa nui),
-- nunca de forma homogeneizante ni en tiempo pasado cuando corresponde
-- señalar que estos pueblos existen en la actualidad.

-- ============================================================================
-- EJE: HISTORIA — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una unidad convencional para medir el tiempo?', '["La semana","El color de un objeto","El tamaño de una persona","El sabor de una comida"]', 0, 'La semana es una unidad convencional para medir el tiempo, junto con el día, el mes y el año.', 'inicial', 20),
  ('¿Por qué es útil usar unidades como el mes o el año para ubicar un hecho en una línea de tiempo?', '["Porque permiten ordenar los hechos con mayor precisión que usando solo palabras como \"antes\" o \"después\"","Porque no aportan ninguna precisión a la línea de tiempo","Porque reemplazan la necesidad de recordar los hechos","Porque solo sirven para contar objetos, no hechos"]', 0, 'Usar unidades convencionales como el mes o el año permite ordenar los hechos con mayor precisión que usando solo palabras generales.', 'intermedia', 30),
  ('Un estudiante quiere anotar cuándo ocurrió su cumpleaños, cuándo empezaron las vacaciones y cuándo comenzó el año escolar, usando el mes en que ocurrió cada hecho. ¿Qué unidad de tiempo está utilizando?', '["El mes","El color","El sabor","El tamaño"]', 0, 'El estudiante está utilizando el mes como unidad convencional de tiempo para ubicar estos hechos.', 'intermedia', 30),
  ('Un curso registra en un calendario los cumpleaños de todos sus compañeros, anotando el día y el mes exacto de cada uno. Al final del año, pueden saber quién cumple años primero y quién después. ¿Qué habilidad están practicando al usar el calendario de esta forma?', '["Ubicar hechos y actividades en una línea de tiempo usando unidades convencionales de tiempo","Describir una costumbre de un pueblo originario","Explicar una norma de convivencia","Comparar dos paisajes geográficos distintos"]', 0, 'El curso está practicando la habilidad de ubicar hechos en una línea de tiempo usando unidades convencionales, como el día y el mes.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_2_basico' and lo.short_name = 'Unidades convencionales de tiempo'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un pueblo originario que ha habitado el territorio actual de Chile?', '["El pueblo mapuche","Los vikingos","Los antiguos egipcios","Los romanos"]', 0, 'El pueblo mapuche es uno de los pueblos originarios que ha habitado el territorio actual de Chile.', 'inicial', 20),
  ('¿Por qué es importante conocer las costumbres de los pueblos originarios de Chile?', '["Porque forman parte de la historia y la diversidad cultural del país","Porque no tienen ninguna relación con la historia de Chile","Porque son exactamente iguales entre todos los pueblos originarios del mundo","Porque ya no existen personas de estos pueblos en la actualidad"]', 0, 'Conocer las costumbres de los pueblos originarios de Chile es importante porque forman parte de la historia y la diversidad cultural del país, y muchas de sus comunidades existen hasta hoy.', 'intermedia', 30),
  ('¿Cuál de estas actividades describe una costumbre tradicional asociada a algunos pueblos originarios de Chile, como el trabajo textil?', '["Tejer prendas de lana usando técnicas transmitidas de generación en generación","Construir rascacielos de más de cien pisos","Viajar en avión de un continente a otro","Usar únicamente tecnología digital para comunicarse"]', 0, 'Tejer prendas de lana con técnicas transmitidas de generación en generación es una costumbre tradicional asociada a algunos pueblos originarios de Chile.', 'intermedia', 30),
  ('Un estudiante investiga que el pueblo rapa nui, que habita Isla de Pascua, tiene costumbres propias como la talla en piedra de los moáis y celebraciones tradicionales que se mantienen hasta hoy. ¿Qué muestra esta información sobre los pueblos originarios de Chile?', '["Que tienen costumbres propias que forman parte de su identidad cultural y que perduran en el presente","Que todos los pueblos originarios de Chile tienen exactamente las mismas costumbres","Que estas costumbres ya no existen en la actualidad","Que los pueblos originarios no tienen ninguna relación con la cultura de Chile"]', 0, 'Esta información muestra que los pueblos originarios de Chile, como el rapa nui, tienen costumbres propias que forman parte de su identidad cultural y que perduran en el presente.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_2_basico' and lo.short_name = 'Costumbres de pueblos originarios de Chile'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas herramientas se usaba para lavar la ropa antes de que existieran las lavadoras eléctricas?', '["Las manos y una batea con agua","Un teléfono celular","Una computadora","Un televisor"]', 0, 'Antes de que existieran las lavadoras eléctricas, la ropa se lavaba con las manos, usando una batea con agua.', 'inicial', 20),
  ('¿Por qué es útil comparar la vida cotidiana del pasado con la del presente usando evidencia, como fotografías u objetos antiguos?', '["Porque permite reconocer con mayor precisión qué ha cambiado y qué se ha mantenido","Porque las fotografías y objetos antiguos no aportan ninguna información","Porque el pasado no puede compararse con el presente de ninguna forma","Porque solo sirve para adivinar el futuro"]', 0, 'Comparar usando evidencia, como fotografías u objetos antiguos, permite reconocer con mayor precisión qué ha cambiado y qué se ha mantenido en la vida cotidiana.', 'intermedia', 30),
  ('Un estudiante observa una fotografía antigua de una cocina, donde se ve una cocina a leña, y la compara con la cocina de su casa actual, que funciona con gas y electricidad. ¿Qué está haciendo el estudiante al realizar esta comparación?', '["Comparando aspectos de la vida cotidiana del pasado y del presente a partir de evidencia simple","Inventando una historia sin ninguna base real","Describiendo una norma de convivencia","Explicando un símbolo patrio"]', 0, 'El estudiante está comparando aspectos de la vida cotidiana del pasado y del presente a partir de evidencia simple, como una fotografía antigua.', 'intermedia', 35),
  ('Un curso reúne fotografías antiguas de su comunidad y las compara con fotografías actuales de los mismos lugares, notando que algunas calles han cambiado mucho, mientras que un antiguo edificio se mantiene igual. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que la vida cotidiana y el entorno de una comunidad pueden presentar tanto cambios como permanencias con el tiempo","Que absolutamente todo en la comunidad ha cambiado por completo","Que absolutamente nada en la comunidad ha cambiado nunca","Que las fotografías antiguas no sirven para comparar épocas distintas"]', 0, 'Esta comparación es consistente con la idea de que la vida cotidiana y el entorno de una comunidad pueden presentar tanto cambios como permanencias con el tiempo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_2_basico' and lo.short_name = 'Comparación de la vida cotidiana en distintas épocas'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una efeméride relevante para la comunidad o el país?', '["El aniversario de la fundación de una ciudad","El color favorito de un vecino","El menú de un restaurante local","El nombre de una mascota"]', 0, 'El aniversario de la fundación de una ciudad es un ejemplo de efeméride relevante para la comunidad.', 'inicial', 20),
  ('¿Por qué las comunidades suelen recordar efemérides importantes con actos o celebraciones?', '["Porque ayudan a valorar y recordar hechos significativos para esa comunidad","Porque son fechas elegidas sin ningún significado","Porque ocurren todos los días sin ninguna diferencia entre ellas","Porque no tienen relación con la identidad de la comunidad"]', 0, 'Las comunidades recuerdan efemérides importantes con actos o celebraciones porque ayudan a valorar y recordar hechos significativos para ellas.', 'intermedia', 30),
  ('¿Cuál de estas actividades es propia de la celebración de una efeméride comunitaria?', '["Un acto conmemorativo con la participación de vecinos y autoridades locales","Un día cualquiera de trabajo sin ninguna actividad especial","Una actividad que no tiene relación con la historia de la comunidad","Un evento que se realiza sin ningún motivo particular"]', 0, 'Un acto conmemorativo con la participación de vecinos y autoridades locales es propio de la celebración de una efeméride comunitaria.', 'intermedia', 30),
  ('Cada año, la comunidad de un estudiante celebra el aniversario de su pueblo con una feria, música y la presencia de las autoridades locales, recordando la historia de cómo se fundó ese lugar. ¿Qué representa esta celebración para la comunidad?', '["El reconocimiento de una efeméride relevante para la identidad y la historia de la comunidad","Un evento sin ninguna relación con la historia del lugar","Una actividad que ocurre por casualidad, sin ningún significado","Una fecha que no tiene relación con la comunidad"]', 0, 'Esta celebración representa el reconocimiento de una efeméride relevante para la identidad y la historia de la comunidad.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_2_basico' and lo.short_name = 'Efemérides de la comunidad'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos podría aparecer en un plano simple de una sala de clases?', '["La ubicación de las mesas y la pizarra","El sabor de un alimento","El nombre de un país lejano","Un color favorito"]', 0, 'La ubicación de las mesas y la pizarra es un elemento que puede aparecer en un plano simple de una sala de clases.', 'inicial', 20),
  ('¿Por qué es útil interpretar un plano simple de un espacio conocido, como el barrio?', '["Porque ayuda a entender cómo están ubicados los distintos lugares de ese espacio","Porque no aporta ninguna información sobre el espacio","Porque reemplaza por completo la necesidad de conocer el lugar","Porque solo sirve para decorar, sin ningún propósito práctico"]', 0, 'Interpretar un plano simple ayuda a entender cómo están ubicados los distintos lugares de un espacio conocido.', 'intermedia', 30),
  ('Un grupo de estudiantes elabora un plano simple de su sala de clases, dibujando la ubicación de la puerta, las ventanas, la pizarra y las mesas, tal como están en la realidad. ¿Qué habilidad están practicando?', '["Interpretar y elaborar planos simples de un espacio conocido","Describir una costumbre de un pueblo originario","Explicar una norma de convivencia","Comparar dos épocas históricas distintas"]', 0, 'Los estudiantes están practicando la habilidad de interpretar y elaborar planos simples de un espacio conocido.', 'intermedia', 30),
  ('Un estudiante recibe el plano simple de su escuela y lo usa para explicarle a un compañero nuevo dónde está ubicada la biblioteca en relación con la sala de clases y el patio. ¿Qué utilidad del plano se muestra en esta situación?', '["Que un plano simple permite ubicar y explicar la posición de distintos lugares de un espacio conocido","Que un plano no tiene ninguna utilidad práctica","Que un plano solo sirve para memorizar colores","Que un plano reemplaza la necesidad de conocer el espacio real"]', 0, 'Esta situación muestra que un plano simple permite ubicar y explicar la posición de distintos lugares de un espacio conocido, como una escuela.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_2_basico' and lo.short_name = 'Planos simples del entorno'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un tipo de paisaje geográfico que se puede encontrar en Chile?', '["Un paisaje montañoso, como la cordillera de los Andes","Un paisaje que solo existe en otro planeta","Un paisaje que no tiene relación con el territorio","Un paisaje imaginario sin ninguna característica real"]', 0, 'Un paisaje montañoso, como la cordillera de los Andes, es un tipo de paisaje geográfico que se encuentra en Chile.', 'inicial', 20),
  ('¿Por qué Chile presenta paisajes geográficos tan distintos entre unas zonas y otras?', '["Porque su territorio se extiende a lo largo de una gran distancia, con climas y relieves diferentes","Porque todo el territorio de Chile tiene exactamente el mismo paisaje","Porque el paisaje de un país no depende de su ubicación geográfica","Porque los paisajes cambian todos los días al azar"]', 0, 'Chile presenta paisajes tan distintos porque su territorio se extiende a lo largo de una gran distancia, con climas y relieves diferentes en cada zona.', 'intermedia', 30),
  ('¿Cuál de estas descripciones corresponde a un paisaje urbano?', '["Un lugar con muchos edificios, calles y una alta concentración de personas","Un lugar cubierto completamente de hielo, sin ninguna construcción","Un desierto sin ninguna presencia humana","Un bosque sin ningún camino ni construcción"]', 0, 'Un lugar con muchos edificios, calles y una alta concentración de personas corresponde a un paisaje urbano.', 'intermedia', 30),
  ('Un estudiante compara fotografías de distintas zonas de Chile: una del desierto de Atacama, una de bosques del sur y una de la zona austral con glaciares. Nota que cada una tiene un paisaje geográfico muy distinto. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que Chile presenta una gran diversidad de paisajes geográficos a lo largo de su territorio","Que todas las zonas de Chile tienen exactamente el mismo paisaje","Que el paisaje de Chile no varía según la zona","Que estas fotografías no representan paisajes reales de Chile"]', 0, 'Esta comparación es consistente con la idea de que Chile presenta una gran diversidad de paisajes geográficos a lo largo de su territorio.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_2_basico' and lo.short_name = 'Paisajes geográficos de Chile'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un recurso natural que se debe cuidar?', '["El agua","Un juguete de plástico","Una silla","Un libro de cuentos"]', 0, 'El agua es un recurso natural fundamental que se debe cuidar.', 'inicial', 20),
  ('¿Por qué es importante cuidar los recursos naturales del entorno, como el agua o los bosques?', '["Porque son necesarios para la vida de las personas y de otros seres vivos","Porque no tienen ninguna relación con la vida de las personas","Porque siempre estarán disponibles sin ningún límite","Porque cuidarlos no aporta ningún beneficio"]', 0, 'Cuidar los recursos naturales es importante porque son necesarios para la vida de las personas y de otros seres vivos.', 'intermedia', 30),
  ('¿Cuál de estas acciones ayuda a cuidar el agua como recurso natural?', '["Cerrar la llave mientras se cepillan los dientes","Dejar las llaves de agua abiertas sin necesidad","Usar toda el agua disponible sin ningún cuidado","Contaminar una fuente de agua cercana"]', 0, 'Cerrar la llave mientras se cepillan los dientes es una acción simple que ayuda a cuidar el agua como recurso natural.', 'intermedia', 30),
  ('Un curso organiza una campaña para cuidar una plaza cercana a la escuela, recogiendo basura, regando las plantas y pidiendo a la comunidad que no corte los árboles sin necesidad. ¿Qué están practicando los estudiantes con esta campaña?', '["El cuidado de los recursos naturales y del entorno cercano","La construcción de un plano de la escuela","La comparación de dos épocas históricas","El reconocimiento de una efeméride nacional"]', 0, 'Los estudiantes están practicando el cuidado de los recursos naturales y del entorno cercano con esta campaña.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_2_basico' and lo.short_name = 'Recursos naturales y su cuidado'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas actividades humanas se relaciona directamente con vivir cerca del mar?', '["La pesca","La minería en alta montaña","El cultivo de trigo en una zona sin agua","La crianza de renos en climas polares"]', 0, 'La pesca es una actividad humana que se relaciona directamente con vivir cerca del mar.', 'inicial', 20),
  ('¿Por qué las actividades económicas de una zona suelen relacionarse con las características de su entorno geográfico?', '["Porque las personas aprovechan los recursos y condiciones que ofrece ese entorno","Porque las actividades económicas no tienen relación con el entorno geográfico","Porque todas las zonas geográficas ofrecen exactamente las mismas posibilidades","Porque el entorno geográfico nunca influye en la vida de las personas"]', 0, 'Las actividades económicas de una zona suelen relacionarse con su entorno geográfico porque las personas aprovechan los recursos y condiciones que este ofrece.', 'intermedia', 30),
  ('¿Cuál de estas actividades es más probable que se desarrolle en una zona con suelos fértiles y buen clima para los cultivos?', '["La agricultura","La pesca de altamar","La extracción de minerales de alta montaña","La cría de renos en climas muy fríos"]', 0, 'La agricultura es una actividad que se desarrolla frecuentemente en zonas con suelos fértiles y buen clima para los cultivos.', 'intermedia', 30),
  ('Un estudiante investiga que en una zona cercana a la cordillera, muchas familias se dedican a la minería, mientras que en una zona costera cercana, muchas familias se dedican a la pesca. ¿Qué relación explica mejor esta diferencia?', '["Que las actividades humanas de cada zona se relacionan con las características de su entorno geográfico","Que las personas eligen su actividad económica sin relación con el entorno donde viven","Que la minería y la pesca se pueden desarrollar exactamente igual en cualquier entorno","Que el entorno geográfico no tiene ninguna influencia en las actividades económicas"]', 0, 'Esta diferencia se explica porque las actividades humanas de cada zona se relacionan con las características de su entorno geográfico, como la cercanía a la cordillera o al mar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_2_basico' and lo.short_name = 'Actividades humanas y el entorno geográfico'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un derecho reconocido de los niños y niñas?', '["El derecho a la educación","El derecho a no asistir nunca a la escuela","El derecho a decidir todas las normas de la casa","El derecho a no cumplir ninguna responsabilidad"]', 0, 'El derecho a la educación es uno de los derechos reconocidos de los niños y niñas.', 'inicial', 20),
  ('¿Por qué, junto con tener derechos, los niños y niñas también tienen deberes, como respetar a sus compañeros?', '["Porque los deberes ayudan a la buena convivencia y al respeto mutuo entre las personas","Porque los deberes no tienen ninguna relación con la convivencia","Porque tener derechos significa no tener ninguna responsabilidad","Porque los deberes solo existen para los adultos"]', 0, 'Los deberes, junto con los derechos, ayudan a la buena convivencia y al respeto mutuo entre las personas.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra el cumplimiento de un deber, junto con el ejercicio de un derecho, por parte de un estudiante?', '["Un estudiante que asiste a la escuela (derecho a la educación) y respeta a sus compañeros (deber de respeto)","Un estudiante que exige sus derechos pero maltrata a sus compañeros","Un estudiante que no asiste nunca a la escuela","Un estudiante que impide que otros compañeros ejerzan sus derechos"]', 0, 'Un estudiante que asiste a la escuela y respeta a sus compañeros muestra tanto el ejercicio de un derecho como el cumplimiento de un deber.', 'intermedia', 30),
  ('Un curso conversa sobre que todos los niños y niñas tienen derecho a jugar, a estudiar y a ser tratados con respeto, pero que también tienen el deber de respetar esos mismos derechos en sus compañeros. ¿Qué idea principal se transmite en esta conversación?', '["Que los derechos de los niños vienen acompañados de deberes hacia los demás","Que los niños no tienen ningún derecho reconocido","Que los derechos solo existen para algunos niños y no para otros","Que los deberes eliminan por completo los derechos de los niños"]', 0, 'Esta conversación transmite la idea de que los derechos de los niños vienen acompañados de deberes hacia los demás, como respetar esos mismos derechos en sus compañeros.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_2_basico' and lo.short_name = 'Derechos y deberes de los niños'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una institución cercana a la comunidad?', '["La municipalidad","Una nube en el cielo","Un animal silvestre","Un juguete cualquiera"]', 0, 'La municipalidad es una institución cercana a la comunidad.', 'inicial', 20),
  ('¿Por qué es útil conocer instituciones cercanas, como la municipalidad o el consultorio de salud?', '["Porque ayudan a resolver necesidades de las personas de la comunidad","Porque no cumplen ninguna función para la comunidad","Porque solo existen en algunas comunidades del mundo","Porque impiden que las personas resuelvan sus necesidades"]', 0, 'Conocer instituciones cercanas, como la municipalidad o el consultorio de salud, es útil porque ayudan a resolver necesidades de las personas de la comunidad.', 'intermedia', 30),
  ('¿Cuál de estas es una función de la junta de vecinos en una comunidad?', '["Organizar actividades y representar los intereses de los vecinos del sector","Fabricar productos para vender en otros países","Decidir las leyes de todo el país","Reemplazar a la familia de cada persona"]', 0, 'Organizar actividades y representar los intereses de los vecinos del sector es una función de la junta de vecinos.', 'intermedia', 30),
  ('Un estudiante investiga que, cuando su familia necesita atención de salud, acude al consultorio del barrio, y que cuando hay un problema en las calles del sector, los vecinos avisan a la municipalidad para que lo solucione. ¿Qué muestra esta información sobre las instituciones cercanas de la comunidad?', '["Que cumplen funciones importantes para resolver necesidades de las personas de la comunidad","Que no tienen ninguna relación con las necesidades de las personas","Que solo existen para cumplir trámites sin ninguna utilidad","Que reemplazan por completo a la familia de cada persona"]', 0, 'Esta información muestra que las instituciones cercanas, como el consultorio y la municipalidad, cumplen funciones importantes para resolver necesidades de las personas de la comunidad.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_2_basico' and lo.short_name = 'Instituciones cercanas de la comunidad'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma pacífica de resolver un conflicto entre dos compañeros?', '["Conversar y escuchar los puntos de vista de ambos para llegar a un acuerdo","Gritar y no escuchar al otro","Ignorar el conflicto para siempre, sin ninguna solución","Responder con un golpe"]', 0, 'Conversar y escuchar los puntos de vista de ambos, para llegar a un acuerdo, es una forma pacífica de resolver un conflicto.', 'inicial', 20),
  ('¿Por qué es mejor resolver un conflicto cotidiano mediante el diálogo, en vez de con violencia?', '["Porque el diálogo permite llegar a soluciones sin dañar a nadie","Porque el diálogo nunca sirve para resolver ningún conflicto","Porque la violencia siempre resuelve los conflictos de forma más rápida y mejor","Porque conversar hace que los conflictos empeoren siempre"]', 0, 'Resolver un conflicto mediante el diálogo es mejor porque permite llegar a soluciones sin dañar a nadie.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra una propuesta adecuada para resolver un conflicto cotidiano, como una discusión por un juego?', '["Proponer turnarse para usar el juego, escuchando a ambas partes","Quitarle el juego al otro por la fuerza","Dejar de hablarle al compañero para siempre","Insultar al compañero con quien se tiene el conflicto"]', 0, 'Proponer turnarse para usar el juego, escuchando a ambas partes, es una propuesta adecuada para resolver un conflicto cotidiano de forma pacífica.', 'intermedia', 30),
  ('Dos compañeros de curso discuten porque ambos quieren usar el mismo balón durante el recreo. Con ayuda de un adulto, conversan, explican lo que cada uno quiere y acuerdan turnarse el balón por tiempos iguales. ¿Qué forma de resolver el conflicto se aplicó en esta situación?', '["Una forma pacífica y dialogada, basada en escuchar a ambas partes y llegar a un acuerdo","Una forma violenta, sin ningún diálogo","Una forma que ignora por completo el conflicto","Una forma que solo beneficia a uno de los compañeros"]', 0, 'En esta situación se aplicó una forma pacífica y dialogada de resolver el conflicto, basada en escuchar a ambas partes y llegar a un acuerdo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_2_basico' and lo.short_name = 'Resolución de conflictos cotidianos'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es un ejemplo de rol simple dentro de un trabajo grupal?', '["Un estudiante encargado de repartir los materiales al resto del grupo","Un estudiante que no participa en ninguna parte del trabajo","Un estudiante que decide todo sin escuchar al grupo","Un estudiante que impide que otros participen"]', 0, 'Un estudiante encargado de repartir los materiales al resto del grupo es un ejemplo de rol simple dentro de un trabajo grupal.', 'inicial', 20),
  ('¿Por qué es útil que cada integrante de un grupo tenga un rol simple y distinto durante un trabajo colaborativo?', '["Porque ayuda a organizar el trabajo y a que todos participen de alguna forma","Porque hace que el trabajo sea imposible de terminar","Porque no aporta ninguna organización al grupo","Porque impide que el grupo termine el trabajo a tiempo"]', 0, 'Que cada integrante tenga un rol simple y distinto ayuda a organizar el trabajo y a que todos participen de alguna forma.', 'intermedia', 30),
  ('En un trabajo grupal sobre un afiche, un estudiante dibuja, otro escribe los textos y otro reparte los materiales, y todos acuerdan estos roles antes de comenzar. ¿Qué principio del trabajo colaborativo con roles simples se aplica en esta situación?', '["Asumir un rol simple dentro de un grupo, acordado previamente entre todos","Trabajar todos exactamente en la misma tarea al mismo tiempo, sin ningún rol","Dejar que solo una persona haga todo el trabajo","Elegir roles sin ningún acuerdo previo del grupo"]', 0, 'Esta situación aplica el principio de asumir un rol simple dentro de un grupo, acordado previamente entre todos los integrantes.', 'intermedia', 35),
  ('Un grupo de estudiantes debe preparar una presentación para el curso. Antes de comenzar, conversan y deciden que uno buscará información, otro hará los dibujos y otro presentará frente al curso, respetando los acuerdos tomados y ayudándose entre ellos durante el proceso. ¿Qué habilidad están practicando principalmente?', '["Participar en un trabajo colaborativo asumiendo roles simples y respetando acuerdos comunes","Resolver un conflicto mediante la violencia","Ubicar hechos en una línea de tiempo","Describir un paisaje geográfico"]', 0, 'Los estudiantes están practicando la habilidad de participar en un trabajo colaborativo asumiendo roles simples y respetando acuerdos comunes.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_2_basico' and lo.short_name = 'Trabajo colaborativo con roles simples'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
