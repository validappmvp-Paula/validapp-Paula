-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 5° Básico. Cubre los 12 objetivos de
-- aprendizaje de 5° Básico cargados por
-- supabase/seed/0021_curriculum_historia_regular_basica_1_6.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'. Sin temas
-- históricos sensibles de la historia reciente de Chile en este nivel (las
-- civilizaciones antiguas de Mesopotamia, Egipto, Grecia, Roma y la Edad
-- Media se abordan con tono descriptivo estándar, sin contenido sensible).

-- ============================================================================
-- EJE: HISTORIA — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos ríos fue fundamental para el desarrollo de la civilización egipcia antigua?', '["El río Nilo","El río Amazonas","El río Mapocho","El río Sena"]', 0, 'El río Nilo fue fundamental para el desarrollo de la civilización egipcia antigua, ya que sus aguas permitían la agricultura en un territorio desértico.', 'inicial', 20),
  ('¿Cuál de estos fue un aporte importante de la civilización de Mesopotamia?', '["La creación de uno de los primeros sistemas de escritura conocidos","La invención del automóvil","La creación de internet","El descubrimiento de la electricidad"]', 0, 'La civilización de Mesopotamia creó uno de los primeros sistemas de escritura conocidos por la humanidad.', 'intermedia', 30),
  ('¿Por qué se dice que tanto Mesopotamia como Egipto se desarrollaron cerca de grandes ríos?', '["Porque el agua de los ríos permitía la agricultura y el desarrollo de estas civilizaciones en zonas de clima seco","Porque los ríos no tenían ninguna relación con la vida de estas civilizaciones","Porque estas civilizaciones vivían exclusivamente del mar","Porque los ríos solo se usaban para el transporte, sin relación con la agricultura"]', 0, 'Tanto Mesopotamia como Egipto se desarrollaron cerca de grandes ríos porque el agua permitía la agricultura y el desarrollo de estas civilizaciones en zonas de clima seco.', 'intermedia', 35),
  ('Un estudiante investiga que tanto la civilización egipcia como la de Mesopotamia desarrollaron sistemas de escritura, calendarios y una organización política con gobernantes centralizados, aunque cada una tuvo sus propias características. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que las civilizaciones antiguas de Egipto y Mesopotamia alcanzaron avances importantes de forma independiente entre sí","Que Egipto y Mesopotamia fueron exactamente la misma civilización","Que ninguna de estas civilizaciones desarrolló ningún sistema de organización","Que estas civilizaciones no tuvieron ningún aporte relevante para la historia"]', 0, 'Esta información es consistente con la idea de que las civilizaciones antiguas de Egipto y Mesopotamia alcanzaron avances importantes, cada una con sus propias características.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_5_basico' and lo.short_name = 'Civilizaciones antiguas de Mesopotamia y Egipto'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un aporte de la antigua Grecia que se mantiene presente en la actualidad?', '["La idea de la democracia como forma de gobierno","La invención de la computadora","El uso del petróleo como fuente de energía","La creación de las redes sociales"]', 0, 'La idea de la democracia como forma de gobierno es un aporte de la antigua Grecia que se mantiene presente en la actualidad.', 'inicial', 20),
  ('¿Cuál de estos es un aporte de la antigua Roma presente en muchos países actuales, incluido Chile?', '["Bases del derecho y de sistemas legales usados en distintos países","El uso exclusivo del idioma griego antiguo","La organización política de las civilizaciones mesoamericanas","La invención de la imprenta moderna"]', 0, 'Las bases del derecho y de sistemas legales usados en distintos países, incluido Chile, son un aporte de la antigua Roma.', 'intermedia', 30),
  ('¿Por qué se dice que Grecia y Roma dejaron un legado importante para la civilización occidental?', '["Porque aportaron ideas políticas, filosóficas y jurídicas que aún influyen en muchas sociedades actuales","Porque no tuvieron ninguna influencia en las sociedades posteriores","Porque todos los países del mundo copiaron exactamente su forma de gobierno","Porque su legado desapareció por completo con el paso del tiempo"]', 0, 'Grecia y Roma dejaron un legado importante porque aportaron ideas políticas, filosóficas y jurídicas que aún influyen en muchas sociedades actuales.', 'intermedia', 35),
  ('Un estudiante investiga que en Chile, como en muchos países, existen tribunales que aplican leyes escritas, un sistema republicano de gobierno y edificios públicos inspirados en la arquitectura clásica. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el legado de Grecia y Roma se puede reconocer en distintos aspectos de sociedades actuales, como Chile","Que Chile copió exactamente la forma de gobierno de la antigua Grecia sin ningún cambio","Que Grecia y Roma no tuvieron ninguna influencia fuera de Europa","Que los tribunales actuales no tienen ninguna relación con el derecho romano"]', 0, 'Esta información es consistente con la idea de que el legado de Grecia y Roma se puede reconocer en distintos aspectos de sociedades actuales, como Chile.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_5_basico' and lo.short_name = 'Legado de Grecia y Roma en la civilización occidental'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un elemento característico de la organización social durante la Edad Media europea?', '["La existencia de un sistema conocido como feudalismo, con señores y campesinos","El uso de teléfonos celulares","La existencia de fábricas modernas con robots","El uso de internet para comunicarse"]', 0, 'La existencia de un sistema conocido como feudalismo, con señores y campesinos, es un elemento característico de la organización social medieval.', 'inicial', 20),
  ('¿Cuál fue el rol de la Iglesia católica durante gran parte de la Edad Media europea?', '["Tuvo una influencia importante en la vida social, cultural y política de la época","No tuvo ninguna influencia en la sociedad de ese período","Se dedicó exclusivamente a actividades comerciales","Desapareció por completo durante todo ese período"]', 0, 'La Iglesia católica tuvo una influencia importante en la vida social, cultural y política durante gran parte de la Edad Media europea.', 'intermedia', 30),
  ('¿Por qué se dice que la sociedad feudal estaba organizada de forma jerárquica?', '["Porque existían distintos niveles, como señores, vasallos y campesinos, con derechos y obligaciones diferentes","Porque todas las personas de la época tenían exactamente los mismos derechos y obligaciones","Porque no existía ninguna forma de organización social","Porque la sociedad medieval era idéntica a la sociedad actual"]', 0, 'La sociedad feudal estaba organizada de forma jerárquica porque existían distintos niveles, como señores, vasallos y campesinos, con derechos y obligaciones diferentes.', 'intermedia', 35),
  ('Un estudiante investiga que, durante la Edad Media europea, los campesinos trabajaban la tierra de un señor feudal a cambio de protección, mientras que los señores feudales tenían el control militar y económico de sus territorios. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la organización feudal se basaba en relaciones jerárquicas de trabajo y protección entre distintos grupos sociales","Que todos los grupos sociales de la Edad Media tenían exactamente el mismo poder","Que no existía ninguna relación entre señores feudales y campesinos","Que la Edad Media no tuvo ninguna forma de organización social"]', 0, 'Esta información es consistente con la idea de que la organización feudal se basaba en relaciones jerárquicas de trabajo y protección entre distintos grupos sociales.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_5_basico' and lo.short_name = 'Nociones generales de la Edad Media europea'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una fuente histórica escrita, útil para estudiar un hecho del pasado?', '["Un documento antiguo, como una carta o un decreto","Un juego de video moderno","Un dibujo imaginario sin ninguna base real","Una predicción sobre el futuro"]', 0, 'Un documento antiguo, como una carta o un decreto, es una fuente histórica escrita útil para estudiar un hecho del pasado.', 'inicial', 20),
  ('¿Por qué es útil comparar distintas fuentes históricas sobre un mismo hecho, como una imagen, un texto y un objeto de la época?', '["Porque permite obtener una visión más completa y contrastada del hecho estudiado","Porque todas las fuentes históricas siempre entregan exactamente la misma información","Porque comparar fuentes hace más difícil comprender un hecho histórico","Porque una sola fuente siempre es suficiente para entender un hecho completo"]', 0, 'Comparar distintas fuentes históricas sobre un mismo hecho permite obtener una visión más completa y contrastada de ese hecho.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra el uso adecuado de distintas fuentes históricas para estudiar un hecho del pasado?', '["Comparar un mapa antiguo, un texto escrito y una imagen de la época para entender mejor un mismo hecho","Usar una sola fuente sin comparar con ninguna otra","Ignorar cualquier fuente histórica disponible","Inventar información sin ninguna base en fuentes reales"]', 0, 'Comparar un mapa antiguo, un texto escrito y una imagen de la época para entender mejor un mismo hecho muestra el uso adecuado de distintas fuentes históricas.', 'intermedia', 35),
  ('Un estudiante investiga un mismo hecho histórico a partir de un texto escrito por un cronista de la época, un mapa antiguo del lugar donde ocurrió el hecho, y una imagen que lo representa. Al compararlos, nota que aportan información distinta pero complementaria sobre lo ocurrido. ¿Qué habilidad está aplicando el estudiante?', '["Comparar información sobre un mismo hecho histórico a partir de distintas fuentes","Inventar información sin ninguna base documental","Ignorar la información entregada por las fuentes históricas","Describir solo su opinión personal, sin usar ninguna fuente"]', 0, 'El estudiante está aplicando la habilidad de comparar información sobre un mismo hecho histórico a partir de distintas fuentes.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_5_basico' and lo.short_name = 'Comparación de fuentes históricas diversas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos forma parte del relieve del territorio chileno?', '["La Cordillera de los Andes","El Océano Pacífico","El clima mediterráneo","La población de una ciudad"]', 0, 'La Cordillera de los Andes es un elemento del relieve del territorio chileno.', 'inicial', 20),
  ('¿Cuál de estas es una característica hidrográfica (relacionada con el agua) importante en el norte de Chile?', '["La escasez de ríos y de precipitaciones","La abundancia de ríos caudalosos todo el año","La presencia de grandes lagos glaciares","Un clima extremadamente lluvioso todo el año"]', 0, 'La escasez de ríos y de precipitaciones es una característica hidrográfica importante en el norte de Chile.', 'intermedia', 30),
  ('¿Por qué el relieve, la hidrografía y el clima de Chile varían tanto entre sus distintas zonas?', '["Porque el territorio chileno se extiende a lo largo de una gran distancia, con diferencias importantes de latitud y altitud","Porque todo el territorio chileno tiene exactamente el mismo relieve y clima","Porque el relieve y el clima no tienen ninguna relación con la ubicación geográfica","Porque la hidrografía de un país nunca varía según la zona"]', 0, 'El relieve, la hidrografía y el clima de Chile varían tanto porque el territorio se extiende a lo largo de una gran distancia, con diferencias importantes de latitud y altitud.', 'intermedia', 35),
  ('Un estudiante compara la zona Norte de Chile, con escasas lluvias, ríos poco caudalosos y un relieve desértico, con la zona Sur, con abundantes lluvias, ríos caudalosos y un relieve de bosques y lagos. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que el relieve, la hidrografía y el clima de Chile presentan una gran variación entre sus distintas zonas","Que todas las zonas de Chile tienen exactamente el mismo relieve, hidrografía y clima","Que la hidrografía de Chile no tiene ninguna relación con el clima de cada zona","Que el relieve de Chile es idéntico en todo su territorio"]', 0, 'Esta comparación es consistente con la idea de que el relieve, la hidrografía y el clima de Chile presentan una gran variación entre sus distintas zonas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_5_basico' and lo.short_name = 'Relieve, hidrografía y clima de Chile por zonas'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un ejemplo de recurso natural renovable?', '["El agua de un río, si se usa de forma sustentable","El cobre","El petróleo","El carbón mineral"]', 0, 'El agua de un río es un ejemplo de recurso natural renovable, si se usa de forma sustentable, ya que puede regenerarse con el tiempo.', 'inicial', 20),
  ('¿Cuál de estos es un ejemplo de recurso natural no renovable?', '["El cobre","La energía solar","El viento","La madera de un bosque bien manejado"]', 0, 'El cobre es un ejemplo de recurso natural no renovable, ya que su formación toma un tiempo extremadamente largo en comparación con su uso.', 'intermedia', 30),
  ('¿Por qué es importante distinguir entre recursos naturales renovables y no renovables al planificar su uso en la economía?', '["Porque los recursos no renovables se agotan con el tiempo y requieren un uso más cuidadoso","Porque todos los recursos naturales se renuevan exactamente de la misma forma","Porque esta distinción no tiene ninguna relación con la economía de un país","Porque los recursos renovables nunca deberían usarse"]', 0, 'Es importante distinguir entre recursos renovables y no renovables porque los no renovables se agotan con el tiempo y requieren un uso más cuidadoso.', 'intermedia', 35),
  ('Un estudiante investiga que Chile es un importante productor de cobre, un recurso no renovable, y también aprovecha recursos renovables, como el agua para generar energía hidroeléctrica. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la economía chilena aprovecha tanto recursos naturales renovables como no renovables, cada uno con distintas implicancias para su uso futuro","Que Chile solo utiliza recursos naturales no renovables","Que Chile solo utiliza recursos naturales renovables","Que los recursos renovables y no renovables se agotan exactamente de la misma manera"]', 0, 'Esta información es consistente con la idea de que la economía chilena aprovecha tanto recursos naturales renovables como no renovables, cada uno con distintas implicancias para su uso futuro.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_5_basico' and lo.short_name = 'Recursos naturales renovables y no renovables'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un riesgo natural presente en el territorio chileno?', '["Los terremotos","La invasión de otro país","Una crisis económica mundial","Un conflicto internacional"]', 0, 'Los terremotos son un riesgo natural presente en el territorio chileno, debido a su ubicación geográfica.', 'inicial', 20),
  ('¿Cuál de estas es una medida de prevención frente a un riesgo natural, como un terremoto?', '["Tener un plan de evacuación conocido por toda la familia o la escuela","Ignorar por completo cualquier simulacro de emergencia","No informarse nunca sobre qué hacer frente a una emergencia","Actuar sin ningún plan frente a una emergencia"]', 0, 'Tener un plan de evacuación conocido por toda la familia o la escuela es una medida de prevención frente a un riesgo natural, como un terremoto.', 'intermedia', 30),
  ('¿Por qué es importante que las comunidades conozcan los riesgos naturales de su territorio y las medidas de prevención asociadas?', '["Porque permite reducir el impacto de un riesgo natural cuando ocurre","Porque conocer los riesgos naturales no aporta ningún beneficio a la comunidad","Porque los riesgos naturales nunca pueden prevenirse de ninguna forma","Porque solo las autoridades deberían conocer estos riesgos"]', 0, 'Conocer los riesgos naturales y las medidas de prevención es importante porque permite reducir el impacto de un riesgo natural cuando ocurre.', 'intermedia', 35),
  ('Una escuela realiza simulacros periódicos de evacuación frente a un terremoto, enseña a los estudiantes zonas seguras dentro del edificio y coordina con las familias planes de emergencia para el hogar. ¿Qué principio de prevención de riesgos naturales se aplica en esta situación?', '["Prepararse anticipadamente frente a un riesgo natural para reducir su impacto","Ignorar por completo los riesgos naturales del territorio","Actuar solo después de que ocurra una emergencia, sin ninguna preparación previa","Confiar en que un riesgo natural nunca va a ocurrir"]', 0, 'Esta situación aplica el principio de prepararse anticipadamente frente a un riesgo natural para reducir su impacto, un componente clave de la prevención.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_5_basico' and lo.short_name = 'Riesgos naturales y prevención'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas actividades económicas se relaciona con una zona de suelos fértiles y buen clima para el cultivo?', '["La agricultura","La pesca de altamar","La minería de alta montaña","La cría de renos en climas polares"]', 0, 'La agricultura se relaciona con una zona de suelos fértiles y buen clima para el cultivo.', 'inicial', 20),
  ('¿Por qué se dice que la geografía de una zona influye en las actividades económicas que allí se desarrollan?', '["Porque las personas aprovechan las condiciones naturales disponibles, como el clima, el relieve o los recursos","Porque las actividades económicas no tienen ninguna relación con las condiciones naturales del territorio","Porque todas las zonas geográficas ofrecen exactamente las mismas posibilidades económicas","Porque la geografía de una zona nunca influye en la economía"]', 0, 'La geografía de una zona influye en las actividades económicas porque las personas aprovechan las condiciones naturales disponibles, como el clima, el relieve o los recursos.', 'intermedia', 30),
  ('¿Cuál de estas actividades es más probable que se desarrolle en una zona con abundantes bosques nativos?', '["La actividad forestal","La pesca de altamar","La extracción de petróleo en el mar","El cultivo intensivo en el desierto"]', 0, 'La actividad forestal es más probable que se desarrolle en una zona con abundantes bosques nativos.', 'intermedia', 30),
  ('Un estudiante compara distintas zonas de Chile y nota que en el norte, con abundantes yacimientos minerales, predomina la minería; en el centro, con suelos fértiles, predomina la agricultura; y en el sur, con bosques y lluvias abundantes, predomina la actividad forestal y ganadera. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que las actividades económicas de una zona suelen relacionarse estrechamente con sus características geográficas","Que las actividades económicas de una zona no tienen ninguna relación con su geografía","Que la minería, la agricultura y la actividad forestal se desarrollan exactamente igual en cualquier zona de Chile","Que la geografía de Chile es idéntica en todas sus zonas"]', 0, 'Esta información es consistente con la idea de que las actividades económicas de una zona suelen relacionarse estrechamente con sus características geográficas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_5_basico' and lo.short_name = 'Relación entre geografía y actividades económicas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿En cuál de estas unidades territoriales se organiza políticamente Chile, además de en regiones?', '["Comunas","Continentes","Océanos","Husos horarios exclusivamente"]', 0, 'Chile se organiza políticamente en regiones, provincias y comunas, entre otras unidades territoriales.', 'inicial', 20),
  ('¿Cuál es la autoridad principal encargada de gobernar una región de Chile?', '["El gobernador o gobernadora regional","El alcalde de otra comuna","El presidente de otro país","Un vecino elegido al azar"]', 0, 'El gobernador o gobernadora regional es la autoridad encargada de gobernar una región de Chile.', 'intermedia', 30),
  ('¿Por qué es útil que un país como Chile se organice en regiones, provincias y comunas?', '["Porque permite administrar de forma más cercana las necesidades de distintas zonas del territorio","Porque esta organización no tiene ninguna utilidad práctica","Porque todas las unidades territoriales de Chile tienen exactamente las mismas necesidades","Porque un país nunca debería dividirse en distintas unidades territoriales"]', 0, 'Organizar un país en regiones, provincias y comunas permite administrar de forma más cercana las necesidades de distintas zonas del territorio.', 'intermedia', 35),
  ('Un estudiante investiga que Chile está dividido en varias regiones, cada una con un gobernador o gobernadora regional, y que cada región se divide, a su vez, en provincias y comunas, cada una con sus propias autoridades locales. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que Chile presenta una organización política y territorial en distintos niveles, con autoridades propias en cada uno","Que Chile tiene una única autoridad para todo el territorio, sin ninguna división","Que las regiones, provincias y comunas de Chile no tienen ninguna autoridad propia","Que la organización territorial de Chile no tiene ninguna relación con la administración del país"]', 0, 'Esta información es consistente con la idea de que Chile presenta una organización política y territorial en distintos niveles, con autoridades propias en cada uno.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_5_basico' and lo.short_name = 'Organización política y territorial de Chile'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos poderes del Estado se encarga de resolver conflictos según las leyes vigentes?', '["El Poder Judicial","El Poder Ejecutivo","El Poder Legislativo","Ninguno de los poderes del Estado"]', 0, 'El Poder Judicial es el poder del Estado encargado de resolver conflictos según las leyes vigentes.', 'inicial', 20),
  ('¿Cuál es la función principal del Poder Ejecutivo en Chile?', '["Gobernar el país y administrar sus políticas públicas","Elaborar todas las leyes del país sin ninguna otra intervención","Juzgar directamente los conflictos legales del país","Reemplazar a las municipalidades en sus funciones"]', 0, 'Gobernar el país y administrar sus políticas públicas es la función principal del Poder Ejecutivo en Chile.', 'intermedia', 30),
  ('¿Por qué se considera importante que los tres poderes del Estado (Ejecutivo, Legislativo y Judicial) actúen de forma independiente entre sí?', '["Porque esto ayuda a evitar que un solo poder concentre demasiada autoridad sobre el país","Porque los tres poderes deberían depender completamente uno del otro","Porque la independencia entre poderes no tiene ninguna relación con el buen funcionamiento del Estado","Porque un solo poder debería controlar completamente a los otros dos"]', 0, 'Es importante que los tres poderes actúen de forma independiente porque esto ayuda a evitar que un solo poder concentre demasiada autoridad sobre el país.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, el Congreso Nacional (Poder Legislativo) aprueba una nueva ley, el gobierno (Poder Ejecutivo) la pone en práctica, y los tribunales (Poder Judicial) resuelven los conflictos que puedan surgir a partir de su aplicación. ¿Qué idea general sobre los poderes del Estado refleja esta información?', '["Que los tres poderes del Estado cumplen funciones distintas pero relacionadas dentro del funcionamiento del país","Que un solo poder del Estado cumple todas las funciones necesarias para el país","Que los poderes del Estado no tienen ninguna relación entre sí","Que las leyes se aplican sin ninguna intervención de los poderes del Estado"]', 0, 'Esta información refleja que los tres poderes del Estado cumplen funciones distintas pero relacionadas dentro del funcionamiento del país.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_5_basico' and lo.short_name = 'Poderes del Estado'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma de participación ciudadana disponible para las personas de una comunidad?', '["Participar en una junta de vecinos","Ignorar por completo cualquier actividad de la comunidad","Impedir que otras personas participen en la comunidad","No informarse nunca sobre temas de la comunidad"]', 0, 'Participar en una junta de vecinos es una forma de participación ciudadana disponible para las personas de una comunidad.', 'inicial', 20),
  ('¿Cuál es el rol de una organización social, como un centro de padres o una junta de vecinos?', '["Representar intereses comunes de un grupo de personas y proponer soluciones a necesidades compartidas","Reemplazar completamente a las autoridades del Estado","Impedir la participación de otras personas de la comunidad","No tener ninguna función dentro de la comunidad"]', 0, 'El rol de una organización social es representar intereses comunes de un grupo de personas y proponer soluciones a necesidades compartidas.', 'intermedia', 30),
  ('¿Por qué se considera importante la participación ciudadana para el funcionamiento de una comunidad?', '["Porque permite que las personas expresen sus necesidades y colaboren en la búsqueda de soluciones","Porque la participación ciudadana no tiene ninguna relación con las necesidades de la comunidad","Porque solo las autoridades deberían tomar decisiones, sin la opinión de la comunidad","Porque participar en la comunidad siempre genera más problemas que beneficios"]', 0, 'La participación ciudadana es importante porque permite que las personas expresen sus necesidades y colaboren en la búsqueda de soluciones.', 'intermedia', 35),
  ('Un grupo de vecinos, preocupado por la falta de áreas verdes en su barrio, se organiza en una junta de vecinos, presenta una propuesta a la municipalidad y logra que se construya una nueva plaza. ¿Qué principio de participación ciudadana y organización social se refleja en esta situación?', '["La organización de las personas para representar intereses comunes y proponer soluciones a necesidades compartidas","La actuación de una sola persona sin ninguna organización","La ausencia total de participación ciudadana en la comunidad","La imposibilidad de que los vecinos influyan en decisiones de su comunidad"]', 0, 'Esta situación refleja el principio de organizar a las personas para representar intereses comunes y proponer soluciones a necesidades compartidas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_5_basico' and lo.short_name = 'Participación ciudadana y organizaciones sociales'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 5° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un derecho que corresponde a los miembros de una comunidad escolar y territorial?', '["El derecho a ser tratado con respeto","El derecho a imponer su voluntad sobre los demás sin ningún límite","El derecho a ignorar las normas de convivencia","El derecho exclusivo de un solo grupo de personas"]', 0, 'El derecho a ser tratado con respeto corresponde a todos los miembros de una comunidad escolar y territorial.', 'inicial', 20),
  ('¿Cuál de estas es una responsabilidad que corresponde a los miembros de una comunidad, junto con sus derechos?', '["Cuidar los espacios y bienes compartidos por la comunidad","No cumplir ninguna norma de convivencia","Imponer decisiones sin considerar a los demás miembros","Ignorar las necesidades de otros miembros de la comunidad"]', 0, 'Cuidar los espacios y bienes compartidos por la comunidad es una responsabilidad que corresponde a sus miembros, junto con sus derechos.', 'intermedia', 30),
  ('¿Por qué se dice que los derechos y las responsabilidades están relacionados dentro de una comunidad?', '["Porque ejercer los propios derechos implica también respetar los derechos y responsabilidades de los demás miembros","Porque tener derechos significa no tener ninguna responsabilidad","Porque las responsabilidades no tienen ninguna relación con los derechos de las personas","Porque una comunidad puede funcionar sin que nadie cumpla ninguna responsabilidad"]', 0, 'Los derechos y las responsabilidades están relacionados porque ejercer los propios derechos implica también respetar los derechos y responsabilidades de los demás miembros.', 'intermedia', 35),
  ('En un curso, todos los estudiantes tienen derecho a usar la biblioteca escolar, pero también tienen la responsabilidad de cuidar los libros y devolverlos a tiempo para que otros compañeros también puedan usarlos. ¿Qué idea general sobre derechos y responsabilidades refleja esta situación?', '["Que los derechos de los miembros de una comunidad vienen acompañados de responsabilidades hacia los demás","Que solo algunos estudiantes tienen derecho a usar la biblioteca","Que tener un derecho significa no tener ninguna responsabilidad asociada","Que las responsabilidades no tienen ninguna relación con el buen funcionamiento de la comunidad"]', 0, 'Esta situación refleja que los derechos de los miembros de una comunidad vienen acompañados de responsabilidades hacia los demás.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_5_basico' and lo.short_name = 'Derechos y responsabilidades como miembros de una comunidad'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
