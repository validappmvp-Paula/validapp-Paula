-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 1° Medio. Cubre los 12 objetivos de
-- aprendizaje de 1° Medio cargados por
-- supabase/seed/0022_curriculum_historia_regular_7basico_2medio.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'.
--
-- NOTA PEDAGÓGICA IMPORTANTE (tema histórico sensible): el objetivo
-- "Expansión territorial y Guerra del Pacífico" trata un conflicto bélico
-- entre Chile, Perú y Bolivia (1879-1883). Las preguntas se redactaron con
-- tono estrictamente factual: se describen causas económicas (disputas por
-- recursos como el salitre) y consecuencias territoriales documentadas,
-- sin lenguaje triunfalista, sin menospreciar a Perú ni a Bolivia como
-- países ni a sus habitantes actuales, y sin emitir juicios de valor sobre
-- quién tenía "razón" en el conflicto, ciñéndose a hechos históricos
-- ampliamente documentados (fechas, actores, consecuencias territoriales).

-- ============================================================================
-- EJE: HISTORIA — 1° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos formó parte del proceso de consolidación del Estado nación en Chile durante el siglo XIX?', '["El fortalecimiento de instituciones como el ejército, la administración pública y el sistema educativo","La desaparición completa de cualquier institución estatal","La eliminación de cualquier forma de gobierno organizado","La anulación de la Constitución de 1833"]', 0, 'El fortalecimiento de instituciones como el ejército, la administración pública y el sistema educativo formó parte del proceso de consolidación del Estado nación en Chile durante el siglo XIX.', 'inicial', 20),
  ('¿Por qué se dice que la Constitución de 1833 contribuyó a la consolidación del Estado chileno durante buena parte del siglo XIX?', '["Porque otorgó un marco institucional relativamente estable, tras un período de conflictos y ensayos constitucionales previos","Porque eliminó por completo cualquier forma de organización política","Porque fue reemplazada inmediatamente por otra Constitución sin ninguna vigencia","Porque no tuvo ninguna relación con la organización del Estado"]', 0, 'La Constitución de 1833 contribuyó a la consolidación del Estado chileno porque otorgó un marco institucional relativamente estable, tras un período de conflictos y ensayos constitucionales previos.', 'intermedia', 30),
  ('¿Cuál de estos procesos contribuyó a extender la presencia efectiva del Estado chileno sobre su territorio durante el siglo XIX?', '["La ocupación de la Araucanía y la incorporación de territorios australes al control estatal","La reducción del territorio administrado por el Estado chileno","La entrega de todo el territorio nacional a otro país","La eliminación de cualquier forma de administración territorial"]', 0, 'La ocupación de la Araucanía y la incorporación de territorios australes al control estatal contribuyó a extender la presencia efectiva del Estado chileno sobre su territorio.', 'intermedia', 35),
  ('Un estudiante investiga que, durante el siglo XIX, el Estado chileno fortaleció instituciones como el ejército y la administración pública, extendió su control efectivo sobre distintas zonas del territorio, y promovió una identidad nacional compartida mediante la educación y símbolos patrios. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la consolidación del Estado nación en Chile durante el siglo XIX fue un proceso que combinó fortalecimiento institucional, control territorial y construcción de identidad","Que el Estado chileno no cambió de ninguna forma durante el siglo XIX","Que la consolidación del Estado chileno ocurrió en un único año, sin ningún proceso previo","Que este proceso no tuvo ninguna relación con la organización territorial del país"]', 0, 'Esta información es consistente con la idea de que la consolidación del Estado nación en Chile durante el siglo XIX fue un proceso que combinó fortalecimiento institucional, control territorial y construcción de identidad.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_1_medio' and lo.short_name = 'Consolidación del Estado nación en Chile (siglo XIX)'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Entre qué países se desarrolló la Guerra del Pacífico (1879-1883)?', '["Chile, Perú y Bolivia","Chile y Argentina","Chile y España","Chile y Estados Unidos"]', 0, 'La Guerra del Pacífico (1879-1883) se desarrolló entre Chile, Perú y Bolivia.', 'inicial', 20),
  ('¿Cuál de estos fue un factor económico relacionado con el origen de la Guerra del Pacífico?', '["Disputas relacionadas con la explotación de recursos, como el salitre, en territorios del norte","Un conflicto relacionado con la Antártica","Una disputa sobre recursos pesqueros del sur de Chile","Un desacuerdo sobre el uso del idioma oficial de la región"]', 0, 'Disputas relacionadas con la explotación de recursos, como el salitre, en territorios del norte fueron un factor económico relacionado con el origen de la Guerra del Pacífico.', 'intermedia', 30),
  ('¿Cuál de estas fue una consecuencia territorial documentada de la Guerra del Pacífico para Chile?', '["La incorporación de territorios del norte, como Tarapacá y Antofagasta, al territorio chileno","La pérdida de todo el territorio norte de Chile","La incorporación de un territorio en el extremo sur del país","La anulación de cualquier cambio territorial tras el conflicto"]', 0, 'La incorporación de territorios del norte, como Tarapacá y Antofagasta, al territorio chileno fue una consecuencia territorial documentada de la Guerra del Pacífico.', 'intermedia', 35),
  ('Un estudiante investiga que la Guerra del Pacífico tuvo causas económicas relacionadas con la explotación de recursos naturales, involucró a tres países (Chile, Perú y Bolivia), y tuvo consecuencias territoriales que aún influyen en la geografía política de la región, siendo un tema que continúa siendo estudiado desde distintas perspectivas históricas en cada país. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la Guerra del Pacífico fue un proceso histórico complejo, con causas económicas y consecuencias territoriales de largo plazo para los países involucrados","Que la Guerra del Pacífico no tuvo ninguna consecuencia territorial para ningún país","Que este conflicto involucró únicamente a Chile, sin ningún otro país","Que las causas de este conflicto no tuvieron ninguna relación con recursos económicos"]', 0, 'Esta información es consistente con la idea de que la Guerra del Pacífico fue un proceso histórico complejo, con causas económicas y consecuencias territoriales de largo plazo para los países involucrados.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_1_medio' and lo.short_name = 'Expansión territorial y Guerra del Pacífico'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se entiende por la "cuestión social" en Chile a fines del siglo XIX e inicios del XX?', '["El conjunto de problemas relacionados con las malas condiciones de vida y trabajo de la clase obrera","Un conflicto exclusivamente relacionado con la política internacional","Un problema relacionado únicamente con la educación superior","Un concepto sin ninguna relación con las condiciones de vida de la población"]', 0, 'La "cuestión social" se refiere al conjunto de problemas relacionados con las malas condiciones de vida y trabajo de la clase obrera en Chile a fines del siglo XIX e inicios del XX.', 'inicial', 20),
  ('¿Cuál de estas fue una condición asociada a la vida de los trabajadores durante el período de la cuestión social en Chile?', '["Jornadas laborales extensas y condiciones de vivienda precarias en centros urbanos y mineros","Jornadas laborales muy cortas y viviendas de excelente calidad para todos los trabajadores","La ausencia total de cualquier tipo de trabajo asalariado","Salarios y condiciones de vida idénticas para todos los sectores sociales"]', 0, 'Jornadas laborales extensas y condiciones de vivienda precarias en centros urbanos y mineros fueron parte de las condiciones asociadas a la cuestión social en Chile.', 'intermedia', 30),
  ('¿Por qué se relaciona la cuestión social con el surgimiento del movimiento obrero en Chile?', '["Porque los trabajadores comenzaron a organizarse para exigir mejores condiciones laborales y sociales","Porque el movimiento obrero surgió sin ninguna relación con las condiciones de vida de los trabajadores","Porque la cuestión social no tuvo ninguna relación con la organización de los trabajadores","Porque los trabajadores de la época no enfrentaban ningún problema social"]', 0, 'La cuestión social se relaciona con el surgimiento del movimiento obrero porque los trabajadores comenzaron a organizarse para exigir mejores condiciones laborales y sociales.', 'intermedia', 35),
  ('Un estudiante investiga que, a fines del siglo XIX e inicios del XX, muchos trabajadores mineros y urbanos en Chile enfrentaban largas jornadas laborales y condiciones de vida precarias, lo que llevó a la formación de organizaciones obreras, como mutuales y sindicatos, que exigían mejoras laborales y sociales. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la cuestión social y el surgimiento del movimiento obrero estuvieron estrechamente relacionados en la historia chilena de ese período","Que la cuestión social no tuvo ninguna relación con la organización de los trabajadores","Que el movimiento obrero surgió sin ninguna causa relacionada con las condiciones laborales","Que todos los trabajadores de la época tenían exactamente las mismas condiciones de vida que otros sectores sociales"]', 0, 'Esta información es consistente con la idea de que la cuestión social y el surgimiento del movimiento obrero estuvieron estrechamente relacionados en la historia chilena de ese período.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_1_medio' and lo.short_name = 'Cuestión social y movimiento obrero'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una razón para usar múltiples fuentes al explicar un proceso histórico complejo, como la cuestión social?', '["Porque permite integrar información de distintos tipos (documentos, testimonios, estadísticas) para una explicación más completa","Porque una sola fuente siempre es suficiente para explicar cualquier proceso histórico","Porque usar múltiples fuentes dificulta la comprensión de un proceso histórico","Porque todas las fuentes históricas siempre entregan exactamente la misma información"]', 0, 'Usar múltiples fuentes permite integrar información de distintos tipos para una explicación más completa de un proceso histórico complejo.', 'inicial', 25),
  ('¿Cuál de estas es una fuente estadística útil para explicar la magnitud de la cuestión social en Chile?', '["Datos históricos sobre condiciones de vivienda y mortalidad en sectores populares","Una opinión personal sin ninguna base estadística","Un dibujo imaginario sin relación con hechos reales","Una predicción sobre el futuro"]', 0, 'Datos históricos sobre condiciones de vivienda y mortalidad en sectores populares son una fuente estadística útil para explicar la magnitud de la cuestión social en Chile.', 'intermedia', 30),
  ('¿Por qué es útil combinar fuentes cuantitativas (como estadísticas) con fuentes cualitativas (como testimonios) al estudiar un proceso histórico?', '["Porque permite comprender tanto la magnitud del fenómeno como la experiencia vivida por las personas involucradas","Porque las fuentes cuantitativas y cualitativas siempre entregan exactamente la misma información","Porque combinar estos tipos de fuentes dificulta la comprensión de un proceso histórico","Porque solo un tipo de fuente debería usarse al estudiar un proceso histórico"]', 0, 'Combinar fuentes cuantitativas y cualitativas permite comprender tanto la magnitud del fenómeno como la experiencia vivida por las personas involucradas.', 'intermedia', 35),
  ('Un estudiante explica el proceso de la cuestión social integrando datos estadísticos sobre condiciones de vivienda de la época, testimonios de trabajadores publicados en periódicos obreros, y un análisis de las leyes laborales existentes en ese momento. ¿Qué habilidad está aplicando el estudiante?', '["Explicar un proceso histórico complejo integrando información de múltiples fuentes","Explicar un proceso histórico usando una única fuente sin ningún contraste","Ignorar cualquier fuente histórica disponible sobre el tema","Inventar información sin ninguna base documental"]', 0, 'El estudiante está aplicando la habilidad de explicar un proceso histórico complejo integrando información de múltiples fuentes.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_1_medio' and lo.short_name = 'Uso de múltiples fuentes para explicar procesos históricos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 1° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un sector productivo relevante de la economía chilena, relacionado con la explotación de un recurso minero?', '["La minería del cobre","La producción de vino en Europa","La pesca en aguas polares","La industria automotriz de otro país"]', 0, 'La minería del cobre es un sector productivo relevante de la economía chilena, relacionado con la explotación de este recurso mineral.', 'inicial', 20),
  ('¿Cuál de estos sectores productivos se desarrolla principalmente en la zona centro-sur de Chile, aprovechando sus suelos fértiles?', '["La agricultura y la fruticultura","La minería del cobre en alta montaña","La explotación de petróleo en el mar","La ganadería en climas polares"]', 0, 'La agricultura y la fruticultura se desarrollan principalmente en la zona centro-sur de Chile, aprovechando sus suelos fértiles.', 'intermedia', 30),
  ('¿Por qué se dice que la geografía de Chile influye en la distribución de sus sectores productivos?', '["Porque cada zona del país presenta condiciones naturales distintas que favorecen ciertas actividades económicas","Porque todos los sectores productivos de Chile se distribuyen exactamente igual en todo el territorio","Porque la geografía no tiene ninguna relación con los sectores productivos de un país","Porque la economía chilena no depende de las condiciones geográficas del territorio"]', 0, 'La geografía de Chile influye en la distribución de sus sectores productivos porque cada zona del país presenta condiciones naturales distintas que favorecen ciertas actividades económicas.', 'intermedia', 35),
  ('Un estudiante compara la actividad minera en el norte de Chile, la actividad agrícola y frutícola en la zona centro-sur, y la actividad forestal y ganadera en el sur del país. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que los sectores productivos de Chile suelen distribuirse según las condiciones geográficas de cada zona del territorio","Que todos los sectores productivos de Chile se concentran exactamente en la misma zona","Que la actividad económica de Chile no tiene ninguna relación con su geografía","Que la minería, la agricultura y la actividad forestal se desarrollan exactamente igual en cualquier zona"]', 0, 'Esta comparación es consistente con la idea de que los sectores productivos de Chile suelen distribuirse según las condiciones geográficas de cada zona del territorio.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_1_medio' and lo.short_name = 'Geografía económica de Chile: sectores productivos'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se entiende por globalización, en el contexto de la economía y el territorio?', '["Un proceso de creciente interconexión económica, comercial y cultural entre distintos países del mundo","Un proceso de aislamiento total entre los países del mundo","Un fenómeno sin ninguna relación con la economía ni el territorio","Un proceso que solo afecta a un único país, sin ninguna relación con otros"]', 0, 'La globalización se refiere a un proceso de creciente interconexión económica, comercial y cultural entre distintos países del mundo.', 'inicial', 20),
  ('¿Cuál de estos es un ejemplo de impacto territorial de la globalización en Chile?', '["El desarrollo de puertos y rutas de transporte orientadas a la exportación de productos a otros países","La eliminación total de cualquier tipo de comercio internacional","La desaparición de cualquier actividad económica orientada a la exportación","La ausencia total de conexión entre Chile y otros países del mundo"]', 0, 'El desarrollo de puertos y rutas de transporte orientadas a la exportación de productos a otros países es un ejemplo de impacto territorial de la globalización en Chile.', 'intermedia', 30),
  ('¿Por qué la globalización puede generar cambios en la organización del territorio de un país exportador, como Chile?', '["Porque impulsa el desarrollo de infraestructura, como puertos y carreteras, orientada al comercio internacional","Porque la globalización no tiene ninguna relación con la organización del territorio","Porque un país exportador nunca modifica su territorio por razones comerciales","Porque la globalización elimina por completo cualquier tipo de actividad económica local"]', 0, 'La globalización puede generar cambios territoriales porque impulsa el desarrollo de infraestructura, como puertos y carreteras, orientada al comercio internacional.', 'intermedia', 35),
  ('Un estudiante investiga que, debido a la creciente exportación de productos chilenos, como el cobre, la fruta y el vino, se han desarrollado importantes puertos, carreteras y zonas industriales orientadas al comercio internacional, transformando el uso del territorio en algunas regiones del país. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la globalización puede generar transformaciones importantes en la organización del territorio de un país","Que la globalización no tiene ninguna relación con la infraestructura de un país","Que el territorio de Chile no ha sido afectado de ninguna forma por el comercio internacional","Que los puertos y carreteras de Chile no tienen ninguna relación con la exportación de productos"]', 0, 'Esta información es consistente con la idea de que la globalización puede generar transformaciones importantes en la organización del territorio de un país.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_1_medio' and lo.short_name = 'Globalización y su impacto territorial'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos océanos bordea la costa de Chile a lo largo de todo su territorio?', '["El Océano Pacífico","El Océano Índico","El Mar Rojo","El Mar Mediterráneo"]', 0, 'El Océano Pacífico bordea la costa de Chile a lo largo de todo su territorio.', 'inicial', 20),
  ('¿Cuál de estos es un recurso marino relevante para la economía chilena?', '["El salmón, producido en actividades de acuicultura en el sur del país","El petróleo del Mar del Norte","El coral de arrecifes tropicales","El hielo de zonas polares del hemisferio norte"]', 0, 'El salmón, producido en actividades de acuicultura en el sur del país, es un recurso marino relevante para la economía chilena.', 'intermedia', 30),
  ('¿Por qué se considera importante la geografía de los océanos para la economía y la vida de un país costero como Chile?', '["Porque los océanos aportan recursos marinos, rutas comerciales y otras oportunidades económicas importantes","Porque los océanos no tienen ninguna relación con la economía de un país costero","Porque un país costero nunca aprovecha los recursos de sus océanos","Porque la geografía marina no influye de ninguna forma en la vida de las personas"]', 0, 'La geografía de los océanos es importante porque aporta recursos marinos, rutas comerciales y otras oportunidades económicas importantes para un país costero.', 'intermedia', 35),
  ('Un estudiante investiga que Chile, gracias a su extenso litoral y a la riqueza de su zona económica exclusiva en el Océano Pacífico, desarrolla actividades como la pesca industrial, la acuicultura de salmón y el comercio marítimo internacional. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la geografía marina de Chile representa una oportunidad importante para el desarrollo de actividades económicas relacionadas con el mar","Que la geografía marina de Chile no tiene ninguna relación con su actividad económica","Que Chile no aprovecha ningún recurso proveniente del océano","Que la pesca y la acuicultura no tienen ninguna relación con la geografía costera del país"]', 0, 'Esta información es consistente con la idea de que la geografía marina de Chile representa una oportunidad importante para el desarrollo de actividades económicas relacionadas con el mar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_1_medio' and lo.short_name = 'Geografía de los océanos y recursos marinos'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un ejemplo de indicador territorial que permite comparar distintas regiones de un país?', '["El ingreso promedio de los hogares de una región","El color de la bandera de una región","El nombre elegido para una región","El sabor de un plato típico de la región"]', 0, 'El ingreso promedio de los hogares de una región es un ejemplo de indicador territorial útil para comparar distintas regiones de un país.', 'inicial', 20),
  ('¿Por qué es útil comparar indicadores territoriales, como el acceso a servicios básicos, entre distintas regiones de Chile?', '["Porque permite identificar desigualdades entre regiones y orientar políticas públicas","Porque comparar estos indicadores no aporta ninguna información relevante","Porque todas las regiones de Chile presentan exactamente los mismos indicadores","Porque los indicadores territoriales no tienen ninguna relación con las políticas públicas"]', 0, 'Comparar indicadores territoriales es útil porque permite identificar desigualdades entre regiones y orientar políticas públicas.', 'intermedia', 30),
  ('¿Cuál de estos indicadores permitiría comparar el nivel de urbanización entre dos regiones de Chile?', '["El porcentaje de población que vive en zonas urbanas respecto de zonas rurales","El color predominante en la bandera regional","El nombre de la capital regional","El clima promedio de la región, sin ninguna relación con la población"]', 0, 'El porcentaje de población que vive en zonas urbanas respecto de zonas rurales permite comparar el nivel de urbanización entre dos regiones de Chile.', 'intermedia', 35),
  ('Un estudiante compara indicadores territoriales de dos regiones de Chile, como el ingreso promedio de los hogares, el acceso a agua potable y el porcentaje de población urbana, y encuentra diferencias importantes entre ambas regiones. ¿Qué habilidad está aplicando el estudiante?', '["Comparar indicadores territoriales entre distintas regiones para analizar desigualdades","Ignorar cualquier indicador territorial disponible","Inventar datos sin ninguna base real sobre las regiones","Describir un hecho histórico sin relación con indicadores territoriales"]', 0, 'El estudiante está aplicando la habilidad de comparar indicadores territoriales entre distintas regiones para analizar desigualdades.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_1_medio' and lo.short_name = 'Comparación de indicadores territoriales'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 1° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un ejemplo de derecho social reconocido en tratados internacionales suscritos por Chile?', '["El derecho a la educación","El derecho a decidir las leyes de otro país","El derecho exclusivo de un solo grupo social","El derecho a ignorar las normas de convivencia"]', 0, 'El derecho a la educación es un ejemplo de derecho social reconocido en tratados internacionales suscritos por Chile.', 'inicial', 20),
  ('¿Cuál de estos es un ejemplo de derecho económico reconocido internacionalmente?', '["El derecho a condiciones de trabajo justas y favorables","El derecho a imponer condiciones de trabajo injustas a otras personas","El derecho a que una sola persona controle toda la economía de un país","El derecho exclusivo de un solo sector económico"]', 0, 'El derecho a condiciones de trabajo justas y favorables es un ejemplo de derecho económico reconocido internacionalmente.', 'intermedia', 30),
  ('¿Por qué se distinguen los derechos económicos, sociales y culturales de otros derechos, como los derechos civiles y políticos?', '["Porque se refieren a condiciones materiales y culturales necesarias para una vida digna, como el trabajo, la salud o la educación","Porque no tienen ninguna relación con la dignidad de las personas","Porque solo corresponden a un grupo reducido de personas en el mundo","Porque estos derechos no están reconocidos en ningún tratado internacional"]', 0, 'Los derechos económicos, sociales y culturales se distinguen porque se refieren a condiciones materiales y culturales necesarias para una vida digna, como el trabajo, la salud o la educación.', 'intermedia', 35),
  ('Un estudiante investiga que Chile ha suscrito tratados internacionales que reconocen derechos como la educación, la salud, el trabajo digno y la participación en la vida cultural, y que estos derechos buscan asegurar condiciones básicas de bienestar para toda la población. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los derechos económicos, sociales y culturales buscan garantizar condiciones básicas de bienestar reconocidas internacionalmente","Que estos derechos no tienen ninguna relación con el bienestar de las personas","Que Chile no ha reconocido ningún derecho económico, social o cultural","Que estos derechos solo benefician a un grupo reducido de la población"]', 0, 'Esta información es consistente con la idea de que los derechos económicos, sociales y culturales buscan garantizar condiciones básicas de bienestar reconocidas internacionalmente.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_1_medio' and lo.short_name = 'Derechos económicos, sociales y culturales'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una función que el Estado puede cumplir dentro de la economía de un país?', '["Regular ciertas actividades económicas mediante leyes y políticas públicas","Eliminar por completo cualquier tipo de actividad económica privada","No tener ninguna relación con la economía del país","Prohibir toda forma de comercio dentro del país"]', 0, 'Regular ciertas actividades económicas mediante leyes y políticas públicas es una función que el Estado puede cumplir dentro de la economía de un país.', 'inicial', 20),
  ('¿Por qué han existido, a lo largo de la historia reciente de Chile, distintas concepciones sobre el rol del Estado en la economía?', '["Porque distintos gobiernos y corrientes de pensamiento han propuesto distintos niveles de intervención estatal en la economía","Porque el rol del Estado en la economía siempre ha sido exactamente el mismo en toda la historia de Chile","Porque esta discusión no tiene ninguna relación con la historia política del país","Porque el Estado nunca ha tenido ninguna relación con la economía chilena"]', 0, 'Han existido distintas concepciones sobre el rol del Estado en la economía porque distintos gobiernos y corrientes de pensamiento han propuesto distintos niveles de intervención estatal.', 'intermedia', 30),
  ('¿Cuál de estas es una forma en que el Estado puede intervenir en la economía para proteger a los consumidores?', '["Estableciendo normas de protección al consumidor y regulando ciertos mercados","Eliminando por completo cualquier tipo de protección al consumidor","Prohibiendo toda forma de compra y venta de productos","Ignorando cualquier situación de abuso hacia los consumidores"]', 0, 'Establecer normas de protección al consumidor y regular ciertos mercados es una forma en que el Estado puede intervenir en la economía para proteger a los consumidores.', 'intermedia', 35),
  ('Un estudiante investiga que, en distintos períodos de la historia reciente de Chile, se han aplicado políticas económicas con mayor o menor participación del Estado, por ejemplo en la provisión de servicios de salud, educación o pensiones, generando distintos efectos y debates sobre su conveniencia. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el rol del Estado en la economía ha sido un tema de debate y cambio a lo largo de la historia reciente de Chile","Que el rol del Estado en la economía chilena nunca ha cambiado ni generado ningún debate","Que el Estado chileno nunca ha participado en la provisión de servicios como salud o educación","Que las políticas económicas de Chile han sido exactamente iguales en toda su historia"]', 0, 'Esta información es consistente con la idea de que el rol del Estado en la economía ha sido un tema de debate y cambio a lo largo de la historia reciente de Chile.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_1_medio' and lo.short_name = 'Rol del Estado en la economía'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es un ejemplo de organización de la sociedad civil?', '["Una fundación sin fines de lucro dedicada a una causa social","Un ministerio del gobierno","Un tribunal de justicia","Una empresa que busca únicamente obtener ganancias"]', 0, 'Una fundación sin fines de lucro dedicada a una causa social es un ejemplo de organización de la sociedad civil.', 'inicial', 20),
  ('¿Cuál es el rol habitual de las organizaciones de la sociedad civil en la promoción de derechos y demandas sociales?', '["Representar intereses de grupos específicos y visibilizar demandas ante la sociedad y el Estado","Reemplazar completamente al Estado en todas sus funciones","Impedir que otros grupos de la sociedad expresen sus demandas","No tener ninguna relación con los derechos o demandas de la población"]', 0, 'El rol habitual de las organizaciones de la sociedad civil es representar intereses de grupos específicos y visibilizar demandas ante la sociedad y el Estado.', 'intermedia', 30),
  ('¿Por qué se considera importante la existencia de organizaciones de la sociedad civil en una democracia?', '["Porque permiten canalizar demandas ciudadanas y fiscalizar la acción de las autoridades","Porque estas organizaciones no aportan ningún beneficio a la sociedad","Porque solo el Estado debería representar los intereses de las personas","Porque la existencia de estas organizaciones dificulta el funcionamiento de una democracia"]', 0, 'Es importante la existencia de organizaciones de la sociedad civil porque permiten canalizar demandas ciudadanas y fiscalizar la acción de las autoridades.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, distintas organizaciones de la sociedad civil (como ONG, fundaciones y agrupaciones ciudadanas) han impulsado demandas sociales relacionadas con derechos humanos, medioambiente o protección al consumidor, generando cambios en políticas públicas. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que las organizaciones de la sociedad civil pueden influir en la promoción de derechos y en la formulación de políticas públicas","Que estas organizaciones no tienen ninguna influencia en las políticas públicas","Que solo el Estado puede impulsar cambios en la sociedad, sin ninguna participación civil","Que las organizaciones de la sociedad civil no existen en Chile"]', 0, 'Esta información es consistente con la idea de que las organizaciones de la sociedad civil pueden influir en la promoción de derechos y en la formulación de políticas públicas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_1_medio' and lo.short_name = 'Organizaciones de la sociedad civil'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 1° Medio, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas acciones refleja un análisis crítico de una noticia sobre un tema ciudadano difundida en redes sociales?', '["Verificar si existen fuentes confiables que respalden la información antes de creerla o compartirla","Compartir la noticia de inmediato sin revisar su origen","Creer la noticia solo porque tiene muchas reacciones","Ignorar cualquier verificación de la información"]', 0, 'Verificar si existen fuentes confiables que respalden la información es un ejemplo de análisis crítico de una noticia sobre un tema ciudadano.', 'inicial', 20),
  ('¿Cuál de estas señales podría indicar que una fuente de información sobre un tema económico o ciudadano es poco confiable?', '["Que no mencione ninguna fuente ni evidencia que respalde sus afirmaciones","Que cite datos verificables de instituciones reconocidas","Que haya sido revisada por especialistas en el tema","Que explique claramente el origen de la información"]', 0, 'Que una fuente no mencione ninguna evidencia que respalde sus afirmaciones es una señal de que podría ser poco confiable.', 'intermedia', 30),
  ('¿Por qué es importante analizar críticamente las fuentes de información sobre temas ciudadanos y económicos de actualidad?', '["Porque permite formarse una opinión informada y evitar la desinformación","Porque toda la información disponible siempre es igualmente confiable","Porque no es necesario verificar ninguna fuente de información","Porque analizar fuentes de información dificulta formarse una opinión"]', 0, 'Es importante analizar críticamente las fuentes de información porque permite formarse una opinión informada y evitar la desinformación.', 'intermedia', 35),
  ('Un estudiante lee una publicación en redes sociales que afirma, sin citar ninguna fuente, un dato económico sobre el desempleo en Chile. Antes de compartirla, busca esa cifra en fuentes oficiales, como el Instituto Nacional de Estadísticas, y encuentra una diferencia importante con lo publicado. ¿Qué habilidad está aplicando el estudiante?', '["Analizar críticamente una fuente de información sobre un tema ciudadano de actualidad","Compartir información sin verificar su origen","Aceptar cualquier dato sin ninguna verificación","Ignorar la existencia de fuentes oficiales de información"]', 0, 'El estudiante está aplicando la habilidad de analizar críticamente una fuente de información sobre un tema ciudadano de actualidad.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_1_medio' and lo.short_name = 'Análisis crítico de fuentes sobre temas ciudadanos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
