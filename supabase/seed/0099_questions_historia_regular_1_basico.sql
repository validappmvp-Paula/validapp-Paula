-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 1° Básico. Cubre los 12 objetivos de
-- aprendizaje de 1° Básico cargados por
-- supabase/seed/0021_curriculum_historia_regular_basica_1_6.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'. Ninguna fila es
-- usable en un ensayo o diagnóstico real hasta revisión pedagógica humana.
--
-- FORMATO: preguntas concretas y situacionales apropiadas para 1° Básico
-- (identificar, ordenar, describir), sin contenido histórico sensible en
-- este nivel (los temas de pueblos originarios, conquista, dictadura, etc.
-- se abordan recién desde 2°-3° Básico en adelante, según la progresión
-- curricular). Se rotó la posición de la respuesta correcta de forma
-- aproximadamente pareja entre las 4 alternativas dentro de cada objetivo.
-- `framework_id`, `source_id` y `content_hash` quedan NULL (mismo criterio
-- que el resto de la serie).

-- ============================================================================
-- EJE: HISTORIA — 1° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos hechos ocurre primero en la vida de una persona?', '["Nacer","Aprender a leer","Entrar a la escuela","Cumplir 10 años"]', 0, 'Nacer es el primer hecho en la vida de una persona, antes de aprender a leer, entrar a la escuela o cumplir años.', 'inicial', 20),
  ('¿Para qué sirve ordenar los hechos importantes de la vida de una persona en una línea de tiempo?', '["Para mostrar en qué orden ocurrieron los hechos a lo largo del tiempo","Para dibujar de forma bonita, sin ningún orden","Para no tener que recordar nada","Para cambiar el orden real en que ocurrieron los hechos"]', 0, 'Una línea de tiempo sirve para mostrar en qué orden ocurrieron los hechos importantes a lo largo del tiempo.', 'intermedia', 30),
  ('Un estudiante quiere ordenar en una línea de tiempo estos momentos de su vida: su nacimiento, su primer día de clases y su último cumpleaños. ¿Cuál es el orden correcto?', '["Nacimiento, primer día de clases, último cumpleaños","Último cumpleaños, nacimiento, primer día de clases","Primer día de clases, último cumpleaños, nacimiento","Último cumpleaños, primer día de clases, nacimiento"]', 0, 'El orden correcto según el tiempo en que ocurrieron es: nacimiento, primer día de clases y último cumpleaños.', 'intermedia', 35),
  ('Una niña quiere mostrar la historia de su familia usando tres fotografías: la boda de sus abuelos, su propio nacimiento y una foto reciente con sus primos. ¿Cómo debería ordenar las fotografías en una línea de tiempo?', '["Desde el hecho más antiguo hasta el más reciente","Desde el hecho más reciente hasta el más antiguo, sin ningún motivo","Mezclando las fotografías sin ningún orden","Usando solo la fotografía más bonita, sin las demás"]', 0, 'En una línea de tiempo, los hechos se ordenan desde el más antiguo hasta el más reciente, para mostrar correctamente su secuencia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_1_basico' and lo.short_name = 'Línea de tiempo personal y familiar'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas cosas ha cambiado con el tiempo en la vida cotidiana de muchas familias?', '["La forma de comunicarse a distancia, gracias a nuevas tecnologías","La necesidad de dormir todos los días","La necesidad de alimentarse","El hecho de tener una familia"]', 0, 'La forma de comunicarse a distancia ha cambiado con el tiempo, por ejemplo gracias a los teléfonos, mientras que necesidades como dormir o alimentarse permanecen.', 'inicial', 20),
  ('¿Por qué es útil comparar cómo vivía una familia antes con cómo vive ahora?', '["Porque permite reconocer qué cosas han cambiado y cuáles se mantienen con el tiempo","Porque el pasado no tiene ninguna relación con el presente","Porque siempre todo cambia por completo, sin nada que se mantenga","Porque no sirve de nada conocer cómo se vivía antes"]', 0, 'Comparar el pasado y el presente permite reconocer qué cosas han cambiado y cuáles se mantienen con el tiempo.', 'intermedia', 30),
  ('¿Cuál de estas es una permanencia (algo que no ha cambiado) en la vida cotidiana de las familias a lo largo del tiempo?', '["Compartir una comida en familia","El tipo de aparato que se usa para ver televisión","La forma de enviar mensajes a otra persona","El tipo de transporte que se usa para viajar lejos"]', 0, 'Compartir una comida en familia es una costumbre que se ha mantenido en el tiempo, aunque otras cosas, como la tecnología, hayan cambiado.', 'intermedia', 30),
  ('Un niño conversa con su abuelo y descubre que antes las familias escuchaban noticias por radio, mientras que ahora muchas las ven por internet en un celular. Pero en ambas épocas, las familias se reunían para conversar sobre lo que escuchaban o veían. ¿Qué muestra esta conversación?', '["Que existen cambios (la tecnología) y permanencias (reunirse a conversar) en la vida familiar","Que absolutamente todo en la vida familiar ha cambiado","Que absolutamente nada ha cambiado en la vida familiar","Que la tecnología nunca ha influido en la vida familiar"]', 0, 'Esta conversación muestra que existen cambios, como la tecnología usada, y permanencias, como la costumbre de reunirse a conversar en familia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_1_basico' and lo.short_name = 'Cambios y permanencias en la vida cotidiana'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una costumbre o tradición que puede compartir una familia?', '["Celebrar juntos un cumpleaños de forma especial cada año","Solo trabajar sin ningún tipo de celebración","Evitar cualquier tipo de reunión familiar","No compartir ninguna actividad en conjunto"]', 0, 'Celebrar juntos un cumpleaños de forma especial cada año es un ejemplo de costumbre o tradición familiar.', 'inicial', 20),
  ('¿Por qué es importante conocer las costumbres y tradiciones de la propia familia?', '["Porque ayudan a entender la identidad y la historia de la familia","Porque no tienen ninguna relación con quiénes somos","Porque son iguales en todas las familias del mundo","Porque impiden conocer a otras personas"]', 0, 'Conocer las costumbres y tradiciones de la propia familia ayuda a entender la identidad y la historia de esa familia.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra una celebración o tradición propia de una comunidad?', '["Un grupo de vecinos que se reúne cada año para una fiesta tradicional del barrio","Una persona que camina sola por la calle","Un niño que hace su tarea en silencio","Una tienda que abre todos los días de la semana"]', 0, 'La reunión anual de vecinos para una fiesta tradicional del barrio es un ejemplo de celebración propia de una comunidad.', 'intermedia', 30),
  ('Una familia cuenta que cada año, en la misma fecha, preparan juntos una comida especial que aprendieron de sus abuelos, y que esta actividad los ayuda a sentirse unidos. ¿Qué representa esta actividad para la familia?', '["Una costumbre o tradición familiar que se transmite entre generaciones","Un hecho sin ninguna importancia para la familia","Una actividad que ocurre solo una vez en la vida","Una obligación impuesta sin ningún significado"]', 0, 'Esta actividad representa una costumbre o tradición familiar que se transmite entre generaciones y fortalece la unión familiar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_1_basico' and lo.short_name = 'Costumbres y tradiciones familiares'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un símbolo patrio de Chile?', '["La bandera de Chile","El menú de un restaurante","El nombre de una calle cualquiera","Un juguete cualquiera"]', 0, 'La bandera de Chile es uno de los principales símbolos patrios del país.', 'inicial', 20),
  ('¿Por qué se recuerdan las efemérides, como el Día de la Independencia?', '["Porque marcan hechos importantes para la historia y la identidad de un país","Porque son fechas elegidas al azar sin ningún significado","Porque ocurren todos los días del año","Porque no tienen relación con la comunidad"]', 0, 'Las efemérides se recuerdan porque marcan hechos importantes para la historia y la identidad de un país.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra respeto por un símbolo patrio?', '["Cantar el himno nacional durante un acto escolar","Ensuciar intencionalmente la bandera","Ignorar por completo cualquier acto conmemorativo","Burlarse de los símbolos de otro país"]', 0, 'Cantar el himno nacional durante un acto escolar es una forma de mostrar respeto por un símbolo patrio.', 'intermedia', 30),
  ('Un curso se prepara para un acto escolar en una efeméride importante para el país: izan la bandera, cantan el himno nacional y escuchan una breve explicación sobre el significado de la fecha. ¿Qué está aprendiendo el curso con esta actividad?', '["A reconocer y valorar los símbolos patrios y el significado de una efeméride relevante","A ignorar por completo la historia del país","A no participar nunca en actividades escolares","A confundir los símbolos patrios de distintos países"]', 0, 'Con esta actividad el curso está aprendiendo a reconocer y valorar los símbolos patrios y el significado de una efeméride relevante para el país.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_1_basico' and lo.short_name = 'Símbolos patrios y efemérides'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 1° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un lugar de la vida cotidiana de un niño o niña?', '["Su casa","Un planeta lejano","Un país que nunca ha visitado","Una ciudad que no conoce"]', 0, 'La casa es un lugar de la vida cotidiana que un niño o niña conoce bien.', 'inicial', 20),
  ('¿Por qué es útil saber ubicar lugares cotidianos, como la casa o la escuela, usando referencias simples (por ejemplo, "al lado de", "cerca de")?', '["Porque ayuda a orientarse y a explicar a otras personas cómo llegar a un lugar","Porque no tiene ninguna utilidad en la vida diaria","Porque solo sirve para dibujar mapas complicados","Porque impide comunicarse con otras personas"]', 0, 'Saber ubicar lugares cotidianos con referencias simples ayuda a orientarse y a explicar a otras personas cómo llegar a un lugar.', 'intermedia', 30),
  ('¿Cuál de estas frases describe correctamente la ubicación de un lugar usando un referente cercano?', '["\"La biblioteca está al lado de la sala de clases\"","\"La biblioteca existe en algún lugar del mundo\"","\"La biblioteca es un edificio\"","\"La biblioteca tiene libros\""]', 0, 'La frase "La biblioteca está al lado de la sala de clases" describe la ubicación del lugar usando un referente cercano.', 'intermedia', 30),
  ('Un niño explica a su amigo cómo llegar a su casa diciendo: "Mi casa está frente a la plaza y al lado de un almacén". ¿Qué habilidad está aplicando al dar esta explicación?', '["Ubicar un lugar cotidiano usando referentes espaciales simples","Describir un hecho histórico de su familia","Explicar una norma de convivencia","Comparar dos países distintos"]', 0, 'El niño está aplicando la habilidad de ubicar un lugar cotidiano usando referentes espaciales simples, como "frente a" y "al lado de".', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_1_basico' and lo.short_name = 'Ubicación de lugares cotidianos'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un ejemplo de punto de referencia que puede ayudar a describir un trayecto cotidiano?', '["Un semáforo conocido en el camino a la escuela","Una nube en el cielo","Un número al azar","Un color cualquiera"]', 0, 'Un semáforo conocido en el camino a la escuela es un ejemplo de punto de referencia útil para describir un trayecto.', 'inicial', 20),
  ('¿Por qué es útil usar puntos de referencia para describir un trayecto que se recorre todos los días?', '["Porque ayuda a explicar el camino de forma más clara a otra persona","Porque hace el trayecto más largo","Porque no tiene relación con orientarse en el camino","Porque impide llegar al lugar deseado"]', 0, 'Usar puntos de referencia ayuda a explicar el camino de forma más clara a otra persona.', 'intermedia', 30),
  ('¿Cuál de estas descripciones de un trayecto usa puntos de referencia de forma clara?', '["\"Camino desde mi casa, paso por la plaza y llego a la escuela\"","\"Camino por ahí y llego a algún lugar\"","\"Camino sin pasar por ningún lugar conocido\"","\"Camino hacia un lugar que no puedo describir\""]', 0, 'La descripción "Camino desde mi casa, paso por la plaza y llego a la escuela" usa puntos de referencia de forma clara para describir el trayecto.', 'intermedia', 30),
  ('Una niña quiere explicarle a una compañera nueva cómo llegar desde la entrada del colegio hasta la sala de clases, y decide mencionar el patio, la biblioteca y un mural conocido en el camino. ¿Qué está haciendo la niña al incluir estos elementos en su explicación?', '["Usando puntos de referencia cercanos para describir un trayecto cotidiano","Inventando un trayecto que no existe","Describiendo un hecho histórico","Comparando dos países distintos"]', 0, 'La niña está usando puntos de referencia cercanos (el patio, la biblioteca, un mural) para describir un trayecto cotidiano de forma clara.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_1_basico' and lo.short_name = 'Trayectos y puntos de referencia cercanos'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos forma parte del paisaje geográfico de un lugar?', '["Un cerro cercano","Una palabra escrita en un cuaderno","Un número en una lista","Un sonido musical"]', 0, 'Un cerro cercano es un elemento del paisaje geográfico de un lugar.', 'inicial', 20),
  ('¿Por qué el paisaje geográfico puede ser distinto entre un lugar y otro?', '["Porque cada lugar tiene características propias, como su relieve, clima o vegetación","Porque todos los paisajes del mundo son exactamente iguales","Porque el paisaje no depende de las características del lugar","Porque el paisaje cambia todos los días al azar"]', 0, 'El paisaje geográfico puede ser distinto entre un lugar y otro porque cada lugar tiene características propias, como su relieve, clima o vegetación.', 'intermedia', 30),
  ('¿Cuál de estas descripciones corresponde a un paisaje geográfico costero?', '["Un lugar cercano al mar, con playas y barcos pesqueros","Un lugar con edificios de oficinas, sin ninguna relación con el entorno natural","Un lugar sin ninguna característica geográfica particular","Un lugar que solo existe en un dibujo imaginario"]', 0, 'Un lugar cercano al mar, con playas y barcos pesqueros, corresponde a un paisaje geográfico costero.', 'intermedia', 30),
  ('Un niño observa que, cerca de su casa, hay un cerro, un río pequeño y árboles, mientras que en la casa de su prima, en otra ciudad, el entorno es plano y cercano al mar. ¿Qué muestra esta observación?', '["Que el paisaje geográfico del entorno puede variar según el lugar","Que todos los paisajes geográficos son idénticos en cualquier lugar","Que el paisaje geográfico no tiene ninguna característica propia","Que el entorno de una persona nunca influye en el paisaje"]', 0, 'Esta observación muestra que el paisaje geográfico del entorno puede variar según el lugar, con características propias como cerros, ríos o cercanía al mar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_1_basico' and lo.short_name = 'Paisaje geográfico del entorno'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma simple de representar un espacio conocido, como la sala de clases?', '["Un dibujo que muestra la ubicación de la pizarra, las mesas y la puerta","Un número escrito al azar","Una palabra sin ninguna relación con el espacio","Un sonido grabado"]', 0, 'Un dibujo que muestra la ubicación de la pizarra, las mesas y la puerta es una forma simple de representar un espacio conocido.', 'inicial', 20),
  ('¿Por qué es útil hacer un dibujo o una maqueta simple de un espacio conocido, como el barrio?', '["Porque ayuda a mostrar cómo están ubicados los distintos lugares de ese espacio","Porque no tiene relación con conocer el espacio representado","Porque reemplaza por completo la necesidad de visitar el lugar","Porque solo sirve para jugar, sin ningún otro propósito"]', 0, 'Hacer un dibujo o maqueta simple de un espacio conocido ayuda a mostrar cómo están ubicados los distintos lugares de ese espacio.', 'intermedia', 30),
  ('¿Cuál de estos elementos debería incluir una maqueta simple del patio de una escuela?', '["Los principales lugares del patio, como los juegos y las canchas, en su ubicación aproximada","Solo un color, sin ninguna forma reconocible","Elementos que no existen en el patio real","Nada relacionado con el patio de la escuela"]', 0, 'Una maqueta simple del patio de una escuela debería incluir sus principales lugares, como los juegos y las canchas, en su ubicación aproximada.', 'intermedia', 30),
  ('Un grupo de estudiantes construye una maqueta simple de su sala de clases, ubicando correctamente la pizarra, las mesas, las ventanas y la puerta, tal como están en la sala real. ¿Qué habilidad están practicando al construir esta maqueta?', '["Representar un espacio conocido de forma simple y ordenada","Describir un hecho histórico de su comunidad","Explicar una norma de convivencia escolar","Comparar dos países distintos"]', 0, 'Los estudiantes están practicando la habilidad de representar un espacio conocido de forma simple y ordenada, respetando la ubicación real de sus elementos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_1_basico' and lo.short_name = 'Representación simple de espacios conocidos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 1° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una norma de convivencia habitual en una sala de clases?', '["Pedir la palabra antes de hablar","Interrumpir a los demás en cualquier momento","Ignorar las indicaciones del profesor o profesora","Hacer ruido constante durante la clase"]', 0, 'Pedir la palabra antes de hablar es una norma de convivencia habitual en una sala de clases.', 'inicial', 20),
  ('¿Por qué es importante que un curso tenga normas y acuerdos de convivencia?', '["Porque ayudan a que todos puedan aprender y relacionarse en un ambiente de respeto","Porque no tienen ninguna relación con el aprendizaje","Porque sirven solo para limitar la libertad de las personas","Porque son iguales a las normas de cualquier otro lugar, sin ningún propósito"]', 0, 'Las normas y acuerdos de convivencia ayudan a que todos puedan aprender y relacionarse en un ambiente de respeto.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra el cumplimiento de un acuerdo de convivencia en el aula?', '["Un estudiante que levanta la mano para pedir la palabra","Un estudiante que grita sin esperar su turno","Un estudiante que se burla de un compañero","Un estudiante que rompe el material de otro compañero"]', 0, 'Levantar la mano para pedir la palabra es un ejemplo de cumplimiento de un acuerdo de convivencia en el aula.', 'intermedia', 30),
  ('Un curso conversa y decide, entre todos, algunas normas para su sala de clases, como escuchar cuando otro habla y cuidar los materiales compartidos. Al tiempo, el curso nota que se llevan mejor y trabajan con más orden. ¿Qué muestra esta situación sobre la importancia de las normas de convivencia?', '["Que las normas y acuerdos de convivencia ayudan a mejorar la relación y el trabajo dentro del curso","Que las normas no tienen ningún efecto en la convivencia del curso","Que es mejor no tener ninguna norma en la sala de clases","Que las normas solo sirven para castigar a los estudiantes"]', 0, 'Esta situación muestra que las normas y acuerdos de convivencia ayudan a mejorar la relación y el trabajo dentro del curso.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_1_basico' and lo.short_name = 'Normas y acuerdos de convivencia en el aula'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas afirmaciones sobre las familias es correcta?', '["Las familias pueden estar formadas de distintas maneras","Todas las familias son exactamente iguales","Solo existe un tipo de familia","Las familias nunca pueden cambiar con el tiempo"]', 0, 'Las familias pueden estar formadas de distintas maneras, y esa diversidad es parte de la sociedad.', 'inicial', 20),
  ('¿Por qué es importante respetar las distintas formas de familia que existen en una comunidad?', '["Porque cada familia es igualmente valiosa, aunque esté formada de manera distinta","Porque solo un tipo de familia merece respeto","Porque no existen diferencias entre las familias","Porque respetar la diversidad familiar no tiene ninguna importancia"]', 0, 'Es importante respetar las distintas formas de familia porque cada una es igualmente valiosa, aunque esté formada de manera distinta.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra respeto por la diversidad de las familias?', '["Un curso donde se conversa con naturalidad sobre las distintas formas de familia de cada estudiante","Un curso donde se se burla de un estudiante por la forma de su familia","Un curso donde solo se acepta un tipo de familia como válido","Un curso donde se evita hablar de las familias de los demás"]', 0, 'Conversar con naturalidad sobre las distintas formas de familia de cada estudiante muestra respeto por la diversidad familiar.', 'intermedia', 30),
  ('En un curso, algunos estudiantes viven con sus dos padres, otros con uno de sus padres, otros con sus abuelos y otros con otros familiares. La profesora conversa con el curso sobre que todas estas formas de familia son válidas y merecen respeto. ¿Qué valor está promoviendo la profesora con esta conversación?', '["El respeto por la diversidad de las familias presentes en la comunidad","La idea de que solo existe una forma correcta de familia","La comparación de las familias para decidir cuál es mejor","La idea de que las familias no tienen ninguna importancia"]', 0, 'La profesora está promoviendo el respeto por la diversidad de las familias presentes en la comunidad, reconociendo que todas son válidas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_1_basico' and lo.short_name = 'Diversidad de las familias'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una responsabilidad habitual de un estudiante en la escuela?', '["Cuidar sus materiales y los de la sala de clases","Decidir las notas de sus compañeros","Elegir el contenido de las clases","Reemplazar al profesor o profesora en sus tareas"]', 0, 'Cuidar sus materiales y los de la sala de clases es una responsabilidad habitual de un estudiante en la escuela.', 'inicial', 20),
  ('¿Por qué es importante que cada integrante de una familia o de un curso cumpla con sus responsabilidades?', '["Porque así se contribuye al buen funcionamiento del grupo en su conjunto","Porque las responsabilidades no tienen ninguna relación con el grupo","Porque solo una persona debería tener responsabilidades","Porque cumplir responsabilidades no aporta a la convivencia"]', 0, 'Cumplir con las responsabilidades ayuda al buen funcionamiento del grupo, sea la familia o el curso.', 'intermedia', 30),
  ('¿Cuál de estos es un ejemplo de un rol dentro de la familia?', '["Un hermano mayor que ayuda a cuidar a su hermano menor","Una persona que no tiene ninguna relación con la familia","Un objeto cualquiera de la casa","Un lugar geográfico lejano"]', 0, 'Un hermano mayor que ayuda a cuidar a su hermano menor es un ejemplo de un rol dentro de la familia.', 'intermedia', 30),
  ('En una familia, cada integrante colabora con una tarea del hogar según su edad: los adultos trabajan y organizan la casa, y los niños ordenan sus propios juguetes y ayudan en tareas simples. En la escuela, ese mismo estudiante también cumple con su responsabilidad de hacer sus tareas y cuidar el material compartido. ¿Qué muestra esta situación?', '["Que las personas cumplen distintos roles y responsabilidades tanto en la familia como en la escuela","Que solo los adultos tienen responsabilidades en la familia","Que los niños no deberían tener ninguna responsabilidad","Que los roles familiares y escolares no tienen ninguna relación entre sí"]', 0, 'Esta situación muestra que las personas cumplen distintos roles y responsabilidades tanto en la familia como en la escuela, según su edad y su lugar en cada grupo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_1_basico' and lo.short_name = 'Roles y responsabilidades en la familia y la escuela'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma de trabajo colaborativo en la sala de clases?', '["Un grupo de estudiantes que arma juntos un rompecabezas, turnándose para colocar las piezas","Un estudiante que trabaja solo y no permite que nadie más participe","Un grupo que discute sin llegar a ningún acuerdo","Un estudiante que hace la tarea de todo el grupo sin la participación de los demás"]', 0, 'Un grupo de estudiantes que arma juntos un rompecabezas, turnándose, es un ejemplo de trabajo colaborativo simple.', 'inicial', 20),
  ('¿Por qué es útil respetar los turnos y las opiniones de los demás al trabajar en grupo?', '["Porque permite que todos participen y el trabajo resulte mejor para el grupo","Porque no tiene ninguna relación con el resultado del trabajo","Porque solo una persona debería decidir todo","Porque respetar turnos hace más lento cualquier trabajo, sin ningún beneficio"]', 0, 'Respetar los turnos y las opiniones de los demás permite que todos participen y el trabajo resulte mejor para el grupo.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra un trabajo colaborativo bien realizado?', '["Un grupo que se reparte las tareas y se ayuda entre compañeros para terminar una actividad","Un grupo donde solo una persona trabaja y el resto no participa","Un grupo donde se discute sin escuchar a nadie más","Un grupo que no logra ponerse de acuerdo en nada"]', 0, 'Un grupo que se reparte las tareas y se ayuda entre compañeros para terminar una actividad muestra un buen trabajo colaborativo.', 'intermedia', 30),
  ('Un grupo de estudiantes debe construir juntos una torre con bloques. Se ponen de acuerdo en quién coloca cada pieza, se turnan y se ayudan cuando alguna pieza no encaja. Al final, logran construir la torre entre todos. ¿Qué principio del trabajo colaborativo simple se refleja en esta situación?', '["Participar en una actividad grupal respetando turnos y ayudando a los demás","Trabajar solo, sin la participación de los demás integrantes del grupo","Ignorar las opiniones de los compañeros durante la actividad","Competir contra los demás integrantes del grupo"]', 0, 'Esta situación refleja el principio de participar en una actividad grupal respetando turnos y ayudando a los demás, propio del trabajo colaborativo simple.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_1_basico' and lo.short_name = 'Trabajo colaborativo simple'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
