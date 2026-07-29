-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 6° Básico. Cubre los 12 objetivos de
-- aprendizaje de 6° Básico cargados por
-- supabase/seed/0021_curriculum_historia_regular_basica_1_6.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'.
--
-- NOTA PEDAGÓGICA IMPORTANTE (tema histórico sensible): el objetivo
-- "Descubrimiento y conquista de América desde una perspectiva americana"
-- exige explícitamente considerar distintas perspectivas, incluida la de
-- los pueblos originarios. Las preguntas se redactaron evitando el término
-- "descubrimiento" como si América no hubiese sido habitada antes (se usa
-- "llegada de los europeos" o "encuentro entre dos mundos" cuando
-- corresponde), y reconociendo, con tono factual y sin lenguaje valorativo,
-- que el proceso significó tanto el establecimiento de nuevas rutas e
-- intercambios como consecuencias graves y documentadas para los pueblos
-- originarios (pérdida de territorios y autonomía, resistencia armada,
-- epidemias). No se atribuye responsabilidad colectiva a ningún país o
-- pueblo actual por hechos históricos.

-- ============================================================================
-- EJE: HISTORIA — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Por qué muchos historiadores prefieren hablar de "encuentro entre dos mundos" o "llegada de los europeos a América" en vez de únicamente "descubrimiento de América"?', '["Porque América ya estaba habitada por millones de personas de distintos pueblos originarios antes de la llegada europea","Porque América no existía antes de 1492","Porque los pueblos originarios llegaron a América después que los europeos","Porque ningún historiador usa esos términos"]', 0, 'Se prefiere hablar de "encuentro" o "llegada de los europeos" porque América ya estaba habitada por millones de personas de distintos pueblos originarios antes de 1492.', 'inicial', 25),
  ('¿Cuál de estas es una consecuencia documentada, desde la perspectiva de los pueblos originarios, del proceso de conquista de América?', '["La pérdida de territorios, autonomía política y graves epidemias que redujeron su población","Un beneficio inmediato y sin ninguna consecuencia negativa para todos los pueblos originarios","Ningún cambio en su forma de vida ni organización","El fortalecimiento total de sus gobiernos previos, sin ninguna alteración"]', 0, 'La pérdida de territorios, autonomía política y graves epidemias que redujeron su población son consecuencias documentadas del proceso de conquista para los pueblos originarios.', 'intermedia', 30),
  ('¿Por qué es importante estudiar el proceso de conquista de América incluyendo la perspectiva de los pueblos originarios y no solo la de los expedicionarios europeos?', '["Porque permite comprender el proceso de forma más completa, considerando a todos los actores involucrados","Porque la perspectiva de los pueblos originarios no aporta ninguna información relevante","Porque solo la perspectiva europea es válida para estudiar este proceso","Porque los pueblos originarios no participaron de ninguna forma en este proceso histórico"]', 0, 'Estudiar este proceso incluyendo la perspectiva de los pueblos originarios permite comprenderlo de forma más completa, considerando a todos los actores involucrados.', 'intermedia', 35),
  ('Un estudiante compara dos relatos sobre la llegada de los europeos a América: uno escrito por un cronista español de la época, que describe la fundación de nuevas ciudades, y uno basado en registros orales de un pueblo originario, que describe la pérdida de su territorio y su resistencia frente al avance europeo. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que un mismo proceso histórico puede analizarse desde distintas perspectivas, que aportan información complementaria y a veces contrastante","Que solo uno de los dos relatos es históricamente válido y el otro debe descartarse por completo","Que ambos relatos describen exactamente los mismos hechos sin ninguna diferencia","Que la perspectiva de los pueblos originarios no tiene ningún valor histórico"]', 0, 'Esta comparación es consistente con la idea de que un mismo proceso histórico puede analizarse desde distintas perspectivas, que aportan información complementaria y a veces contrastante.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_6_basico' and lo.short_name = 'Descubrimiento y conquista de América desde una perspectiva americana'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿En qué año se realizó la Primera Junta Nacional de Gobierno, hito considerado el inicio del proceso de Independencia de Chile?', '["1810","1990","1973","1520"]', 0, 'La Primera Junta Nacional de Gobierno se realizó en 1810, hito considerado el inicio del proceso de Independencia de Chile.', 'inicial', 20),
  ('¿Cuál de estas fue una causa que impulsó el proceso de Independencia de Chile a comienzos del siglo XIX?', '["El descontento de criollos con algunas restricciones impuestas por la administración colonial española","La invención de internet","Un conflicto con un país asiático","La creación de la Organización de las Naciones Unidas"]', 0, 'El descontento de criollos con algunas restricciones impuestas por la administración colonial española fue una causa que impulsó el proceso de Independencia.', 'intermedia', 30),
  ('¿Por qué se dice que el proceso de Independencia de Chile tomó varios años y no ocurrió en un solo hecho?', '["Porque incluyó distintas etapas, como la Patria Vieja, la Reconquista y la Patria Nueva, con avances y retrocesos","Porque Chile se independizó en un único día, sin ningún proceso previo","Porque no existió ningún conflicto durante este proceso","Porque la Independencia de Chile ocurrió antes de la llegada de los españoles"]', 0, 'El proceso de Independencia de Chile tomó varios años porque incluyó distintas etapas, como la Patria Vieja, la Reconquista y la Patria Nueva, con avances y retrocesos.', 'intermedia', 35),
  ('Un estudiante investiga que el proceso de Independencia de Chile combinó factores internos, como el deseo de mayor autonomía de los criollos, con factores externos, como la influencia de ideas de la Ilustración y los procesos de independencia de otros países americanos. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la Independencia de Chile fue resultado de una combinación de causas internas y externas","Que la Independencia de Chile no tuvo ninguna causa identificable","Que la Independencia de Chile ocurrió sin ninguna influencia de otros procesos históricos","Que solo existió una única causa para este proceso histórico"]', 0, 'Esta información es consistente con la idea de que la Independencia de Chile fue resultado de una combinación de causas internas y externas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_6_basico' and lo.short_name = 'Independencia de Chile: causas y proceso'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas fue una característica de la organización política de Chile durante gran parte del siglo XIX?', '["La adopción de una república con una Constitución que organizaba el Estado","La continuidad exacta del sistema colonial español, sin ningún cambio","La ausencia total de cualquier forma de gobierno","La organización del país según el modelo de un imperio"]', 0, 'La adopción de una república con una Constitución que organizaba el Estado fue una característica de la organización política de Chile durante el siglo XIX.', 'inicial', 20),
  ('¿Cuál de estos fue un desafío que enfrentó la organización de la República de Chile en sus primeras décadas?', '["Lograr estabilidad política, ya que hubo conflictos y ensayos constitucionales antes de una organización más estable","La ausencia total de cualquier tipo de conflicto político","La inexistencia de cualquier forma de gobierno organizado","Un acuerdo inmediato y sin ninguna dificultad entre todos los sectores políticos"]', 0, 'Lograr estabilidad política fue un desafío en las primeras décadas de la República, ya que hubo conflictos y distintos ensayos constitucionales antes de una organización más estable.', 'intermedia', 30),
  ('¿Por qué se considera importante la Constitución de 1833 para la historia política de Chile en el siglo XIX?', '["Porque estableció un marco institucional que dio mayor estabilidad política al país durante varias décadas","Porque fue la primera Constitución del mundo","Porque eliminó por completo cualquier forma de gobierno en Chile","Porque no tuvo ninguna relación con la organización del Estado"]', 0, 'La Constitución de 1833 se considera importante porque estableció un marco institucional que dio mayor estabilidad política al país durante varias décadas.', 'intermedia', 35),
  ('Un estudiante investiga que, tras la Independencia, Chile experimentó distintos ensayos de organización política, con conflictos entre diferentes sectores, hasta que una nueva Constitución logró dar mayor estabilidad institucional al país durante buena parte del siglo XIX. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la organización de la República en Chile fue un proceso gradual, con avances y dificultades, hasta lograr mayor estabilidad","Que Chile logró una organización política estable de forma inmediata tras la Independencia, sin ninguna dificultad","Que no existió ningún proceso de organización política después de la Independencia","Que la Constitución de 1833 no tuvo ninguna relación con la estabilidad política del país"]', 0, 'Esta información es consistente con la idea de que la organización de la República en Chile fue un proceso gradual, con avances y dificultades, hasta lograr mayor estabilidad.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_6_basico' and lo.short_name = 'Organización de la República en el siglo XIX'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa fundamentar una idea sobre un proceso del pasado usando evidencia histórica?', '["Apoyar esa idea con información obtenida de fuentes históricas confiables","Afirmar una idea sin ninguna base en fuentes históricas","Inventar información sobre el pasado sin ninguna evidencia","Repetir una opinión personal sin relacionarla con ninguna fuente"]', 0, 'Fundamentar una idea sobre el pasado usando evidencia histórica significa apoyar esa idea con información obtenida de fuentes históricas confiables.', 'inicial', 20),
  ('¿Por qué es importante utilizar evidencia histórica, y no solo opiniones personales, para argumentar sobre un proceso del pasado, como la Independencia de Chile?', '["Porque la evidencia histórica permite sostener una interpretación con mayor rigor y confiabilidad","Porque las opiniones personales siempre son más confiables que la evidencia histórica","Porque no es necesario ningún tipo de evidencia para argumentar sobre el pasado","Porque la evidencia histórica no tiene relación con la forma de argumentar sobre un proceso"]', 0, 'Es importante utilizar evidencia histórica porque permite sostener una interpretación sobre el pasado con mayor rigor y confiabilidad.', 'intermedia', 30),
  ('¿Cuál de estas es una fuente de evidencia histórica que un estudiante podría usar para argumentar sobre las causas de la Independencia de Chile?', '["Un documento de la época que exprese el descontento de algunos sectores criollos","Una opinión sin ninguna relación con fuentes históricas","Un relato inventado sin ninguna base documental","Una predicción sobre hechos futuros"]', 0, 'Un documento de la época que exprese el descontento de algunos sectores criollos es una fuente de evidencia histórica útil para argumentar sobre las causas de la Independencia.', 'intermedia', 35),
  ('Un estudiante sostiene que la Independencia de Chile tuvo tanto causas internas como externas, y para argumentarlo, cita un documento de la época que menciona el descontento de los criollos y un texto que describe la influencia de las ideas de la Ilustración y de otros procesos americanos. ¿Qué habilidad está aplicando el estudiante?', '["Utilizar evidencia histórica para fundamentar una interpretación sobre un proceso del pasado","Afirmar una idea sin ninguna base en fuentes históricas","Ignorar cualquier evidencia disponible sobre el tema","Inventar información histórica sin ningún respaldo documental"]', 0, 'El estudiante está aplicando la habilidad de utilizar evidencia histórica para fundamentar una interpretación sobre un proceso del pasado.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_6_basico' and lo.short_name = 'Uso de evidencia histórica para argumentar'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una característica del relieve del continente americano?', '["La presencia de una gran cadena montañosa, la Cordillera de los Andes, en Sudamérica","La ausencia total de montañas en todo el continente","La existencia de un único tipo de clima en todo el continente","La ausencia de ríos importantes en el continente"]', 0, 'La presencia de la Cordillera de los Andes, una gran cadena montañosa en Sudamérica, es una característica del relieve del continente americano.', 'inicial', 20),
  ('¿Cuál de estas es una característica de la geografía humana de América?', '["La existencia de grandes ciudades con alta concentración de población","La ausencia total de población en todo el continente","La existencia de un único idioma hablado en todo el continente","La ausencia de cualquier tipo de actividad económica"]', 0, 'La existencia de grandes ciudades con alta concentración de población es una característica de la geografía humana de América.', 'intermedia', 30),
  ('¿Por qué se distingue entre geografía física y geografía humana al estudiar un continente como América?', '["Porque la geografía física estudia el relieve, el clima y los recursos, mientras que la humana estudia la población y sus actividades","Porque ambas estudian exactamente lo mismo, sin ninguna diferencia","Porque la geografía humana no tiene relación con el territorio","Porque la geografía física no considera ningún elemento del territorio"]', 0, 'Se distingue entre geografía física (relieve, clima, recursos) y geografía humana (población, actividades) porque estudian distintos aspectos de un mismo territorio.', 'intermedia', 35),
  ('Un estudiante investiga que América presenta una gran variedad de relieves (cordilleras, llanuras, selvas) y climas, y que su población se concentra de forma distinta según la zona, con grandes ciudades costeras y zonas rurales menos pobladas en el interior. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la geografía física y humana de América presentan una gran diversidad a lo largo del continente","Que toda América tiene exactamente el mismo relieve, clima y distribución de población","Que la geografía física de un continente no tiene relación con su geografía humana","Que la población de América se distribuye de forma idéntica en todas sus zonas"]', 0, 'Esta información es consistente con la idea de que la geografía física y humana de América presentan una gran diversidad a lo largo del continente.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_6_basico' and lo.short_name = 'Geografía física y humana de América'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es una migración?', '["El desplazamiento de personas desde un lugar de origen hacia otro lugar de destino","Un tipo de clima muy caluroso","Una forma de relieve montañoso","Un tipo de recurso natural no renovable"]', 0, 'Una migración es el desplazamiento de personas desde un lugar de origen hacia otro lugar de destino.', 'inicial', 20),
  ('¿Cuál de estos es un posible impacto territorial de la migración hacia una ciudad?', '["El crecimiento de la población y de la demanda de viviendas y servicios en esa ciudad","La disminución automática del tamaño del territorio de esa ciudad","La desaparición completa de la ciudad de destino","La eliminación de cualquier actividad económica en esa ciudad"]', 0, 'El crecimiento de la población y de la demanda de viviendas y servicios es un posible impacto territorial de la migración hacia una ciudad.', 'intermedia', 30),
  ('¿Por qué las personas migran de un lugar a otro, según causas frecuentemente estudiadas en geografía humana?', '["Por razones como buscar mejores oportunidades laborales, educativas o de seguridad","Porque nunca existe ningún motivo para migrar de un lugar a otro","Porque la migración ocurre siempre al azar, sin ninguna causa identificable","Porque las personas migran únicamente por razones climáticas"]', 0, 'Las personas migran frecuentemente por razones como buscar mejores oportunidades laborales, educativas o de seguridad.', 'intermedia', 35),
  ('Un estudiante investiga que, en las últimas décadas, distintas ciudades de Chile han recibido población proveniente de otras regiones del país y de otros países, lo que ha generado tanto un aumento en la demanda de viviendas y servicios, como un mayor intercambio cultural en esas ciudades. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la migración puede generar impactos territoriales y sociales importantes en las ciudades de destino","Que la migración no tiene ningún impacto en el territorio de una ciudad","Que la migración solo ocurre entre ciudades de un mismo país","Que el intercambio cultural nunca está relacionado con procesos migratorios"]', 0, 'Esta información es consistente con la idea de que la migración puede generar impactos territoriales y sociales importantes en las ciudades de destino.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_6_basico' and lo.short_name = 'Migraciones y su impacto territorial'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una herramienta tecnológica simple de información geográfica?', '["Un mapa digital interactivo, como los disponibles en aplicaciones de navegación","Un libro de cuentos sin ningún mapa","Un juego de mesa sin relación con la geografía","Un instrumento musical"]', 0, 'Un mapa digital interactivo, como los disponibles en aplicaciones de navegación, es una herramienta tecnológica simple de información geográfica.', 'inicial', 20),
  ('¿Por qué son útiles las tecnologías de información geográfica para analizar problemas territoriales, como la ubicación de servicios en una ciudad?', '["Porque permiten visualizar y comparar información geográfica de forma más rápida y precisa","Porque estas tecnologías no aportan ninguna información útil sobre el territorio","Porque reemplazan por completo la necesidad de conocer el territorio real","Porque solo sirven para jugar, sin ningún propósito práctico"]', 0, 'Las tecnologías de información geográfica son útiles porque permiten visualizar y comparar información geográfica de forma más rápida y precisa.', 'intermedia', 30),
  ('¿Cuál de estos es un ejemplo de uso de una herramienta tecnológica geográfica simple para comparar lugares?', '["Usar un mapa digital para comparar la distancia entre dos ciudades","Ignorar cualquier herramienta digital disponible","Usar una calculadora para sumar números sin relación con el territorio","Usar un diccionario para buscar el significado de una palabra"]', 0, 'Usar un mapa digital para comparar la distancia entre dos ciudades es un ejemplo de uso de una herramienta tecnológica geográfica simple.', 'intermedia', 35),
  ('Un estudiante utiliza un mapa digital interactivo para comparar la ubicación de distintos servicios (hospitales, escuelas, plazas) en dos comunas distintas, y a partir de esta comparación identifica que una comuna tiene menos áreas verdes que la otra. ¿Qué habilidad está aplicando el estudiante?', '["Utilizar herramientas tecnológicas simples de información geográfica para analizar un problema territorial","Ignorar la información entregada por una herramienta digital","Inventar información sin usar ninguna herramienta geográfica","Describir un hecho histórico sin relación con el territorio"]', 0, 'El estudiante está aplicando la habilidad de utilizar herramientas tecnológicas simples de información geográfica para analizar un problema territorial.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_6_basico' and lo.short_name = 'Uso de tecnologías de información geográfica'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas zonas suele concentrar mayor cantidad de población en Chile?', '["La zona central, donde se ubica la capital del país","La zona más austral y de menor accesibilidad","El desierto más árido del norte, sin ninguna ciudad","Una zona sin ningún tipo de infraestructura"]', 0, 'La zona central de Chile, donde se ubica la capital del país, suele concentrar mayor cantidad de población.', 'inicial', 20),
  ('¿Cuál de estos factores puede influir en que una zona concentre más población que otra?', '["La disponibilidad de servicios, empleo y buenas condiciones geográficas para habitar","El color del cielo en esa zona","El sabor de los alimentos típicos de la zona","El nombre elegido para esa zona"]', 0, 'La disponibilidad de servicios, empleo y buenas condiciones geográficas para habitar puede influir en que una zona concentre más población que otra.', 'intermedia', 30),
  ('¿Por qué la población de Chile y de América, en general, no se distribuye de forma pareja en todo el territorio?', '["Porque existen factores geográficos, económicos y sociales que hacen más atractivas ciertas zonas para habitar","Porque la población siempre se distribuye exactamente igual en todas las zonas de un país","Porque la distribución de la población no depende de ningún factor identificable","Porque todos los lugares de un país ofrecen exactamente las mismas condiciones para habitar"]', 0, 'La población no se distribuye de forma pareja porque existen factores geográficos, económicos y sociales que hacen más atractivas ciertas zonas para habitar.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, la mayor parte de la población se concentra en la zona central del país, mientras que la zona austral, con condiciones geográficas más extremas, tiene una densidad de población mucho menor. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la distribución de la población en el territorio suele relacionarse con las condiciones geográficas y económicas de cada zona","Que la población de Chile se distribuye exactamente igual en todas las zonas del país","Que la distribución de la población no tiene ninguna relación con la geografía","Que la zona austral concentra la mayor parte de la población de Chile"]', 0, 'Esta información es consistente con la idea de que la distribución de la población en el territorio suele relacionarse con las condiciones geográficas y económicas de cada zona.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_6_basico' and lo.short_name = 'Distribución de la población en el territorio'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la Constitución de un país?', '["La norma fundamental que organiza el Estado y establece derechos y deberes de las personas","Un documento sin ninguna relación con la organización del Estado","Un reglamento válido solo para un grupo reducido de personas","Una ley que puede ser ignorada libremente por cualquier autoridad"]', 0, 'La Constitución es la norma fundamental que organiza el Estado y establece derechos y deberes de las personas.', 'inicial', 20),
  ('¿Cuál de estos es un derecho fundamental que suele estar garantizado por la Constitución de un país?', '["El derecho a la vida","El derecho a ignorar cualquier norma del país","El derecho a imponer la propia voluntad sobre los demás","El derecho exclusivo de un solo grupo de personas"]', 0, 'El derecho a la vida es un derecho fundamental que suele estar garantizado por la Constitución de un país.', 'intermedia', 30),
  ('¿Por qué se considera que la Constitución es la norma de mayor jerarquía dentro de un país?', '["Porque todas las demás leyes deben respetar lo que la Constitución establece","Porque la Constitución no tiene ninguna relación con las demás leyes del país","Porque cualquier ley puede contradecir libremente a la Constitución","Porque la Constitución solo aplica a algunas personas del país"]', 0, 'La Constitución es la norma de mayor jerarquía porque todas las demás leyes deben respetar lo que ella establece.', 'intermedia', 35),
  ('Un estudiante investiga que la Constitución de Chile establece derechos como la libertad de expresión, la igualdad ante la ley y el derecho a la educación, y que estos derechos deben ser respetados por las leyes y las autoridades del país. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la Constitución cumple un rol central en garantizar derechos fundamentales frente a las leyes y autoridades del país","Que la Constitución no tiene ninguna relación con los derechos de las personas","Que las leyes del país pueden contradecir libremente a la Constitución","Que solo algunas personas están protegidas por los derechos constitucionales"]', 0, 'Esta información es consistente con la idea de que la Constitución cumple un rol central en garantizar derechos fundamentales frente a las leyes y autoridades del país.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_6_basico' and lo.short_name = 'La Constitución y los derechos fundamentales'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa que un país tenga una democracia representativa?', '["Que los ciudadanos eligen, mediante votación, a representantes que toman decisiones en su nombre","Que una sola persona toma todas las decisiones sin ninguna elección","Que ningún ciudadano puede participar en la elección de autoridades","Que las decisiones del país se toman sin ninguna votación"]', 0, 'Una democracia representativa significa que los ciudadanos eligen, mediante votación, a representantes que toman decisiones en su nombre.', 'inicial', 20),
  ('¿Cuál de estas es una característica del funcionamiento de la democracia representativa en Chile?', '["La realización de elecciones periódicas para elegir autoridades, como el presidente o presidenta y los parlamentarios","La ausencia total de cualquier tipo de elección","La imposición de una autoridad sin ningún proceso electoral","La prohibición de que los ciudadanos elijan a sus autoridades"]', 0, 'La realización de elecciones periódicas para elegir autoridades es una característica del funcionamiento de la democracia representativa en Chile.', 'intermedia', 30),
  ('¿Por qué se considera importante que los ciudadanos participen en las elecciones dentro de una democracia representativa?', '["Porque permite que las autoridades reflejen, en alguna medida, la voluntad de la ciudadanía","Porque la participación electoral no tiene ninguna relación con la elección de autoridades","Porque las elecciones no influyen de ninguna forma en quién gobierna el país","Porque en una democracia representativa no es necesario elegir a ninguna autoridad"]', 0, 'Es importante que los ciudadanos participen en las elecciones porque esto permite que las autoridades reflejen, en alguna medida, la voluntad de la ciudadanía.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, los ciudadanos eligen mediante votación al presidente o presidenta, a los parlamentarios y a otras autoridades, quienes luego toman decisiones en representación de la ciudadanía durante un período determinado. ¿Qué idea general sobre la democracia representativa refleja esta información?', '["Que en una democracia representativa, la ciudadanía delega, mediante elecciones, la toma de decisiones en autoridades elegidas","Que en una democracia representativa no existe ninguna relación entre ciudadanía y autoridades","Que las autoridades de Chile no son elegidas mediante ningún proceso electoral","Que la democracia representativa no requiere ninguna participación ciudadana"]', 0, 'Esta información refleja que en una democracia representativa, la ciudadanía delega, mediante elecciones, la toma de decisiones en autoridades elegidas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_6_basico' and lo.short_name = 'Funcionamiento de la democracia representativa'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un mecanismo de participación ciudadana disponible en una democracia?', '["Las elecciones para elegir autoridades","La imposición de decisiones sin ninguna consulta ciudadana","La prohibición de que los ciudadanos opinen sobre temas públicos","La exclusión de la ciudadanía de cualquier proceso de decisión"]', 0, 'Las elecciones para elegir autoridades son un mecanismo de participación ciudadana disponible en una democracia.', 'inicial', 20),
  ('¿Qué es un plebiscito?', '["Una consulta directa a la ciudadanía para que se pronuncie sobre un tema determinado","Una decisión tomada exclusivamente por una sola autoridad, sin ninguna consulta","Un tipo de elección exclusiva para autoridades locales","Un documento que reemplaza a la Constitución"]', 0, 'Un plebiscito es una consulta directa a la ciudadanía para que se pronuncie sobre un tema determinado.', 'intermedia', 30),
  ('¿Por qué se considera valioso que existan distintos mecanismos de participación ciudadana, además de las elecciones periódicas?', '["Porque permiten a la ciudadanía involucrarse en decisiones públicas de distintas formas y en distintos momentos","Porque los mecanismos de participación ciudadana no aportan ningún beneficio a la democracia","Porque las elecciones son el único mecanismo válido de participación en una democracia","Porque tener más de un mecanismo de participación dificulta el funcionamiento de la democracia"]', 0, 'Es valioso que existan distintos mecanismos de participación ciudadana porque permiten a la ciudadanía involucrarse en decisiones públicas de distintas formas y en distintos momentos.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, además de votar en elecciones periódicas, la ciudadanía puede participar en cabildos, presentar propuestas ante autoridades locales o, en ciertos casos, pronunciarse en un plebiscito sobre un tema relevante para el país. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que existen distintos mecanismos de participación ciudadana, más allá de las elecciones, disponibles en la democracia chilena","Que la única forma de participación ciudadana en Chile son las elecciones periódicas","Que los ciudadanos no pueden participar de ninguna forma entre una elección y otra","Que los cabildos y plebiscitos no tienen ninguna relación con la participación ciudadana"]', 0, 'Esta información es consistente con la idea de que existen distintos mecanismos de participación ciudadana, más allá de las elecciones, disponibles en la democracia chilena.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_6_basico' and lo.short_name = 'Mecanismos de participación ciudadana'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 6° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa el principio de no discriminación?', '["Que todas las personas deben ser tratadas con igual respeto, sin importar sus características personales","Que solo un grupo de personas merece un trato respetuoso","Que la discriminación es aceptable en ciertos casos particulares","Que las personas con características distintas a la mayoría no merecen el mismo trato"]', 0, 'El principio de no discriminación significa que todas las personas deben ser tratadas con igual respeto, sin importar sus características personales.', 'inicial', 20),
  ('¿Cuál de estas situaciones es un ejemplo de discriminación que debería evitarse en la vida en sociedad?', '["Excluir a una persona de una actividad por su origen o características personales","Incluir a todas las personas por igual en una actividad grupal","Tratar con respeto a una persona con una discapacidad","Celebrar la diversidad cultural de una comunidad"]', 0, 'Excluir a una persona de una actividad por su origen o características personales es un ejemplo de discriminación que debería evitarse.', 'intermedia', 30),
  ('¿Por qué se considera importante fundamentar, con argumentos, la importancia de la no discriminación en la vida en sociedad?', '["Porque permite comprender por qué el respeto a la diversidad es un valor central para una convivencia justa","Porque la no discriminación no requiere ningún tipo de argumento o justificación","Porque la discriminación siempre debería aceptarse sin ningún cuestionamiento","Porque este tema no tiene ninguna relación con la convivencia en sociedad"]', 0, 'Es importante fundamentar la importancia de la no discriminación porque permite comprender por qué el respeto a la diversidad es un valor central para una convivencia justa.', 'intermedia', 35),
  ('Un curso analiza un caso en que un estudiante fue excluido de un juego por tener un origen distinto al de la mayoría de sus compañeros. Tras conversar sobre la situación, el curso concluye que esa exclusión fue injusta y que todos merecen ser tratados con el mismo respeto, sin importar su origen. ¿Qué valor están fundamentando los estudiantes con esta conclusión?', '["La importancia de la no discriminación y el respeto a la diversidad en la vida en sociedad","La idea de que solo algunos estudiantes merecen participar en las actividades del curso","La aceptación de la discriminación como parte normal de la convivencia","La comparación entre estudiantes para decidir quién es mejor que otro"]', 0, 'Los estudiantes están fundamentando la importancia de la no discriminación y el respeto a la diversidad en la vida en sociedad.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_6_basico' and lo.short_name = 'Valoración de la diversidad y no discriminación'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
