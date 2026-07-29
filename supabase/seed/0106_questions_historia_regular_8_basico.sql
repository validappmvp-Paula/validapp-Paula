-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 8° Básico. Cubre los 12 objetivos de
-- aprendizaje de 8° Básico cargados por
-- supabase/seed/0022_curriculum_historia_regular_7basico_2medio.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'.
--
-- NOTA PEDAGÓGICA IMPORTANTE (tema histórico sensible): los objetivos
-- "Descubrimiento y conquista de América" (que exige explícitamente
-- analizar sus consecuencias para los pueblos originarios) y "Organización
-- política, económica y social de la Colonia" (que incluye el sistema de
-- encomienda) se redactaron con tono factual y neutral: se reconoce que la
-- conquista implicó pérdida de autonomía política y territorial, trabajo
-- forzado bajo el sistema de encomienda, y graves epidemias para los
-- pueblos originarios, ciñéndose a hechos ampliamente documentados, sin
-- lenguaje valorativo ni atribución de responsabilidad colectiva a ningún
-- país o pueblo actual, y sin minimizar el impacto de estos procesos.

-- ============================================================================
-- EJE: HISTORIA — 8° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿En qué año llegó una expedición europea, encabezada por Cristóbal Colón, a tierras americanas por primera vez?', '["1492","1810","1973","1990"]', 0, 'En 1492 llegó a tierras americanas una expedición europea encabezada por Cristóbal Colón.', 'inicial', 20),
  ('¿Cuál de estas fue una consecuencia documentada del proceso de conquista de América para los pueblos originarios?', '["La pérdida de autonomía política y territorial de numerosos pueblos originarios","Un beneficio inmediato y sin ninguna consecuencia negativa para todos los pueblos","Ningún cambio en su organización social ni política","El fortalecimiento total de sus gobiernos previos, sin ninguna alteración"]', 0, 'La pérdida de autonomía política y territorial de numerosos pueblos originarios es una consecuencia documentada del proceso de conquista de América.', 'intermedia', 30),
  ('¿Por qué las enfermedades traídas por los europeos, como la viruela, tuvieron un impacto tan grave en la población indígena de América?', '["Porque los pueblos originarios no tenían defensas inmunológicas desarrolladas contra esas enfermedades","Porque las enfermedades no tuvieron ninguna relación con la población indígena","Porque los pueblos originarios ya conocían y controlaban esas enfermedades","Porque estas enfermedades solo afectaron a los expedicionarios europeos"]', 0, 'Las enfermedades tuvieron un impacto tan grave porque los pueblos originarios no tenían defensas inmunológicas desarrolladas contra ellas, lo que provocó epidemias devastadoras.', 'intermedia', 35),
  ('Un estudiante investiga que el proceso de conquista de América significó, para muchos pueblos originarios, la pérdida de sus territorios y formas de gobierno, graves epidemias y, en algunos casos, trabajo forzado, mientras que también dio origen a nuevas ciudades, rutas comerciales y procesos de mestizaje cultural. ¿Qué idea general refleja mejor esta información?', '["Que el proceso de conquista de América tuvo consecuencias complejas, incluyendo graves impactos para los pueblos originarios","Que el proceso de conquista no tuvo ninguna consecuencia para los pueblos originarios de América","Que todos los pueblos originarios se beneficiaron por igual del proceso de conquista","Que este proceso histórico no puede analizarse a partir de ninguna evidencia disponible"]', 0, 'Esta información refleja que el proceso de conquista de América tuvo consecuencias complejas, incluyendo graves impactos documentados para los pueblos originarios.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_8_basico' and lo.short_name = 'Descubrimiento y conquista de América'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas instituciones administraba el territorio colonial de Chile en nombre de la Corona española?', '["La Real Audiencia y el Gobernador","El Congreso Nacional","La Organización de las Naciones Unidas","El Banco Central de Chile"]', 0, 'La Real Audiencia y el Gobernador eran instituciones que administraban el territorio colonial de Chile en nombre de la Corona española.', 'inicial', 20),
  ('¿Qué fue la encomienda, un sistema utilizado durante el período colonial en América?', '["Un sistema en el que un colono español recibía el derecho a exigir trabajo o tributo de un grupo de indígenas, a cambio de \"protegerlos\" y evangelizarlos","Un sistema de votación democrática entre los indígenas","Un tipo de escuela creada exclusivamente para españoles","Un sistema de comercio libre sin ninguna obligación entre las partes"]', 0, 'La encomienda fue un sistema en el que un colono español recibía el derecho a exigir trabajo o tributo de un grupo de indígenas, a cambio de "protegerlos" y evangelizarlos, un sistema que en la práctica implicó trabajo forzado y abusos documentados.', 'intermedia', 35),
  ('¿Cuál de estas fue una característica de la organización social durante la Colonia en Chile?', '["Una sociedad jerárquica, con diferencias entre españoles peninsulares, criollos, mestizos e indígenas","Una sociedad sin ninguna diferencia entre sus habitantes","Una sociedad organizada exclusivamente por votación popular","Una sociedad idéntica a la organización política actual de Chile"]', 0, 'Una sociedad jerárquica, con diferencias entre españoles peninsulares, criollos, mestizos e indígenas, fue una característica de la organización social durante la Colonia en Chile.', 'intermedia', 30),
  ('Un estudiante investiga que, durante la Colonia, la economía de Chile se organizó en torno a la agricultura, la ganadería y algo de minería, con una sociedad jerárquica donde los criollos comenzaron a acumular riqueza e influencia, pero con escasa participación política, ya que los cargos más altos solían reservarse para españoles peninsulares. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la organización colonial combinaba una estructura económica, social y política con jerarquías y desigualdades entre distintos grupos","Que durante la Colonia todos los habitantes de Chile tenían exactamente los mismos derechos políticos","Que la economía colonial no tuvo ninguna relación con la organización social","Que los criollos ocupaban los cargos políticos más altos durante la Colonia"]', 0, 'Esta información es consistente con la idea de que la organización colonial combinaba una estructura económica, social y política con jerarquías y desigualdades entre distintos grupos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_8_basico' and lo.short_name = 'Organización política, económica y social de la Colonia'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos personajes es reconocido como un actor destacado del proceso de Independencia de Chile?', '["Bernardo O''Higgins","Cristóbal Colón","Pedro de Valdivia","Un emperador romano"]', 0, 'Bernardo O''Higgins es reconocido como un actor destacado del proceso de Independencia de Chile.', 'inicial', 20),
  ('¿Cuál de estos grupos participó activamente en el proceso de Independencia de Chile, además de figuras militares y políticas destacadas?', '["Criollos que buscaban mayor autonomía política respecto de España","Habitantes de otro continente sin ninguna relación con Chile","Un grupo que no existió en esa época histórica","Solo un único actor histórico, sin ninguna otra participación"]', 0, 'Criollos que buscaban mayor autonomía política respecto de España participaron activamente en el proceso de Independencia de Chile.', 'intermedia', 30),
  ('¿Por qué se describe el proceso de Independencia de Chile como un proceso con distintas etapas y no como un hecho único?', '["Porque incluyó, entre otras, la Patria Vieja, la Reconquista española y la Patria Nueva, con avances, retrocesos y distintos actores","Porque Chile se independizó en un único acto, sin ningún proceso previo","Porque no existió ningún conflicto ni participación de distintos actores","Porque este proceso ocurrió antes de la llegada de los españoles al territorio"]', 0, 'El proceso de Independencia de Chile incluyó distintas etapas, como la Patria Vieja, la Reconquista española y la Patria Nueva, con avances, retrocesos y distintos actores.', 'intermedia', 35),
  ('Un estudiante investiga que, en el proceso de Independencia de Chile, participaron tanto figuras militares como Bernardo O''Higgins y José de San Martín, como sectores criollos que promovían mayor autonomía, en un contexto influido por ideas de la Ilustración y por procesos de independencia de otros países americanos. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el proceso de Independencia de Chile involucró a distintos actores y estuvo influido por un contexto histórico más amplio","Que la Independencia de Chile fue obra de un único actor histórico, sin ninguna otra participación","Que este proceso ocurrió de forma aislada, sin ninguna relación con otros procesos americanos","Que las ideas de la Ilustración no tuvieron ninguna influencia en este proceso"]', 0, 'Esta información es consistente con la idea de que el proceso de Independencia de Chile involucró a distintos actores y estuvo influido por un contexto histórico más amplio.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_8_basico' and lo.short_name = 'Independencia de Chile: proceso y actores'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa construir un relato histórico fundamentado en evidencia?', '["Explicar un proceso del pasado apoyándose en información obtenida de fuentes históricas confiables","Inventar una historia sin ninguna base documental","Repetir una opinión personal sin relacionarla con ninguna fuente","Afirmar hechos sobre el pasado sin consultar ninguna fuente"]', 0, 'Construir un relato histórico fundamentado en evidencia significa explicar un proceso del pasado apoyándose en información obtenida de fuentes históricas confiables.', 'inicial', 20),
  ('¿Por qué es importante contrastar distintas fuentes al construir un relato histórico sobre un proceso complejo, como la Independencia de Chile?', '["Porque permite construir una explicación más completa, considerando distintos actores y perspectivas","Porque una sola fuente siempre entrega toda la información necesaria para construir un relato completo","Porque contrastar fuentes dificulta la construcción de un relato histórico","Porque todas las fuentes históricas siempre coinciden exactamente entre sí"]', 0, 'Contrastar distintas fuentes es importante porque permite construir una explicación más completa, considerando distintos actores y perspectivas.', 'intermedia', 30),
  ('¿Cuál de estos elementos debería incluir un relato histórico bien construido sobre un proceso del pasado?', '["Referencias a las fuentes utilizadas para fundamentar cada afirmación","Afirmaciones inventadas sin ninguna base documental","Opiniones personales sin relación con ninguna evidencia","Información que contradiga la evidencia disponible, sin ninguna justificación"]', 0, 'Un relato histórico bien construido debería incluir referencias a las fuentes utilizadas para fundamentar cada afirmación.', 'intermedia', 35),
  ('Un estudiante construye un relato sobre el proceso de Independencia de Chile, citando un documento de la época que expresa el descontento de sectores criollos, un mapa que muestra el avance de las campañas militares, y un texto que explica el contexto de las ideas de la Ilustración. ¿Qué habilidad está aplicando el estudiante?', '["Construir un relato histórico fundamentado en evidencia de distintas fuentes","Inventar un relato sin ninguna base documental","Ignorar cualquier fuente disponible sobre el proceso histórico","Repetir una opinión personal sin relacionarla con ninguna evidencia"]', 0, 'El estudiante está aplicando la habilidad de construir un relato histórico fundamentado en evidencia de distintas fuentes.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_8_basico' and lo.short_name = 'Construcción de relatos históricos con evidencia'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 8° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una región geográfica reconocible dentro del continente americano?', '["América Latina","El continente africano","El continente asiático","Oceanía"]', 0, 'América Latina es una región geográfica reconocible dentro del continente americano.', 'inicial', 20),
  ('¿Cuál de estos es un paisaje característico de la región amazónica, en América del Sur?', '["Selva tropical con alta biodiversidad","Desierto extremadamente árido","Glaciares y hielo permanente","Estepa fría todo el año"]', 0, 'La selva tropical con alta biodiversidad es un paisaje característico de la región amazónica, en América del Sur.', 'intermedia', 30),
  ('¿Por qué las distintas regiones de América Latina presentan paisajes tan variados entre sí?', '["Porque la región abarca zonas con climas, relieves y latitudes muy diferentes","Porque toda América Latina tiene exactamente el mismo paisaje geográfico","Porque los paisajes de América Latina no dependen del clima ni del relieve","Porque América Latina se ubica en una única franja climática"]', 0, 'Las distintas regiones de América Latina presentan paisajes variados porque la región abarca zonas con climas, relieves y latitudes muy diferentes.', 'intermedia', 35),
  ('Un estudiante compara el paisaje de la región amazónica, con selva tropical y abundantes lluvias, con el paisaje del altiplano andino, con clima frío y seco, y con el paisaje de la Patagonia, con glaciares y estepas. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que América Latina presenta una gran diversidad de paisajes y regiones geográficas","Que toda América Latina tiene exactamente el mismo clima y relieve","Que la diversidad de paisajes de América Latina no tiene relación con su geografía","Que la región amazónica y la Patagonia tienen paisajes idénticos"]', 0, 'Esta comparación es consistente con la idea de que América Latina presenta una gran diversidad de paisajes y regiones geográficas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_8_basico' and lo.short_name = 'Regiones y paisajes de América'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un recurso natural relevante para la economía de varios países de América Latina?', '["El cobre, importante para países como Chile y Perú","El petróleo del Mar del Norte","La nieve permanente de zonas polares","Un recurso que no existe en el territorio latinoamericano"]', 0, 'El cobre es un recurso natural relevante para la economía de varios países de América Latina, como Chile y Perú.', 'inicial', 20),
  ('¿Por qué se dice que la abundancia de recursos naturales puede influir en el desarrollo económico de un país de América Latina?', '["Porque estos recursos pueden generar ingresos importantes a través de su explotación y exportación","Porque los recursos naturales no tienen ninguna relación con la economía de un país","Porque la abundancia de recursos naturales siempre garantiza automáticamente el desarrollo de un país","Porque ningún país de América Latina cuenta con recursos naturales relevantes"]', 0, 'La abundancia de recursos naturales puede influir en el desarrollo económico de un país porque estos recursos pueden generar ingresos importantes a través de su explotación y exportación.', 'intermedia', 30),
  ('¿Cuál de estos es un desafío frecuente relacionado con el uso de recursos naturales en países de América Latina?', '["Lograr un equilibrio entre la explotación económica de un recurso y el cuidado del medioambiente","La ausencia total de cualquier recurso natural en la región","La imposibilidad de que un recurso natural genere algún beneficio económico","La inexistencia de cualquier impacto ambiental asociado a la explotación de recursos"]', 0, 'Lograr un equilibrio entre la explotación económica de un recurso y el cuidado del medioambiente es un desafío frecuente relacionado con el uso de recursos naturales en la región.', 'intermedia', 35),
  ('Un estudiante investiga que, en distintos países de América Latina, la extracción de recursos como el cobre, el petróleo o la madera ha generado importantes ingresos económicos, pero también ha planteado desafíos relacionados con el cuidado del medioambiente y de las comunidades cercanas a las zonas de extracción. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el uso de recursos naturales en América Latina implica tanto oportunidades económicas como desafíos ambientales y sociales","Que la explotación de recursos naturales en la región no genera ningún ingreso económico","Que el uso de recursos naturales nunca genera ningún desafío ambiental","Que ningún país de América Latina ha desarrollado actividades económicas basadas en recursos naturales"]', 0, 'Esta información es consistente con la idea de que el uso de recursos naturales en América Latina implica tanto oportunidades económicas como desafíos ambientales y sociales.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_8_basico' and lo.short_name = 'Recursos naturales de América Latina'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un problema ambiental actual que afecta a distintas zonas del mundo, incluida América Latina?', '["La deforestación de bosques nativos","La abundancia excesiva de agua potable en todo el mundo","La ausencia total de contaminación en las grandes ciudades","La inexistencia de cualquier cambio climático"]', 0, 'La deforestación de bosques nativos es un problema ambiental actual que afecta a distintas zonas del mundo, incluida América Latina.', 'inicial', 20),
  ('¿Qué se entiende por "desarrollo sostenible"?', '["Un tipo de desarrollo que busca satisfacer necesidades actuales sin comprometer los recursos de las futuras generaciones","Un tipo de desarrollo que ignora por completo el cuidado del medioambiente","Un desarrollo económico que no considera ningún aspecto ambiental","Un concepto sin ninguna relación con el uso de recursos naturales"]', 0, 'El desarrollo sostenible es un tipo de desarrollo que busca satisfacer necesidades actuales sin comprometer los recursos de las futuras generaciones.', 'intermedia', 30),
  ('¿Por qué se relaciona la deforestación con el concepto de desarrollo sostenible?', '["Porque una deforestación no planificada puede comprometer recursos naturales necesarios para el futuro","Porque la deforestación no tiene ninguna relación con el desarrollo sostenible","Porque el desarrollo sostenible implica siempre eliminar por completo cualquier actividad forestal","Porque la deforestación siempre contribuye positivamente al desarrollo sostenible"]', 0, 'La deforestación se relaciona con el desarrollo sostenible porque una deforestación no planificada puede comprometer recursos naturales necesarios para el futuro.', 'intermedia', 35),
  ('Un estudiante investiga que, en algunas zonas de América Latina, se han implementado políticas de manejo forestal sostenible, que permiten la explotación controlada de la madera junto con la reforestación planificada, mientras que en otras zonas la deforestación sin control ha generado pérdida de biodiversidad. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que aplicar principios de desarrollo sostenible puede ayudar a equilibrar la actividad económica con el cuidado ambiental","Que el desarrollo sostenible no tiene ninguna relación con la actividad forestal","Que la deforestación sin control nunca genera ningún problema ambiental","Que todas las zonas de América Latina aplican exactamente las mismas políticas forestales"]', 0, 'Esta comparación es consistente con la idea de que aplicar principios de desarrollo sostenible puede ayudar a equilibrar la actividad económica con el cuidado ambiental.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_8_basico' and lo.short_name = 'Problemas ambientales y desarrollo sostenible'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas actividades productivas se relaciona con las llanuras fértiles de la región pampeana, en Argentina?', '["La agricultura y la ganadería a gran escala","La pesca en aguas polares","La extracción de petróleo en el Ártico","La minería de alta montaña"]', 0, 'La agricultura y la ganadería a gran escala se relacionan con las llanuras fértiles de la región pampeana, en Argentina.', 'inicial', 20),
  ('¿Por qué la distribución de las actividades productivas en un territorio suele relacionarse con las características geográficas de cada zona?', '["Porque las personas aprovechan las condiciones naturales disponibles para desarrollar ciertas actividades económicas","Porque las actividades productivas no tienen ninguna relación con la geografía del territorio","Porque todas las zonas de un territorio ofrecen exactamente las mismas posibilidades productivas","Porque la distribución de actividades productivas ocurre siempre al azar"]', 0, 'La distribución de las actividades productivas suele relacionarse con las características geográficas de cada zona porque las personas aprovechan las condiciones naturales disponibles.', 'intermedia', 30),
  ('¿Cuál de estas actividades productivas es más probable que se desarrolle en una zona costera con aguas ricas en recursos marinos?', '["La actividad pesquera","La minería de alta montaña","El cultivo de trigo en el desierto","La ganadería en zonas polares"]', 0, 'La actividad pesquera es más probable que se desarrolle en una zona costera con aguas ricas en recursos marinos.', 'intermedia', 35),
  ('Un estudiante compara la distribución de actividades productivas en distintas zonas de América Latina: la agricultura y ganadería en las llanuras pampeanas, la minería en zonas andinas ricas en minerales, y la pesca en zonas costeras. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que la distribución espacial de las actividades productivas suele relacionarse con las características geográficas de cada zona","Que las actividades productivas de una zona no tienen ninguna relación con su geografía","Que todas las zonas de América Latina desarrollan exactamente las mismas actividades productivas","Que la geografía de un territorio nunca influye en sus actividades económicas"]', 0, 'Esta comparación es consistente con la idea de que la distribución espacial de las actividades productivas suele relacionarse con las características geográficas de cada zona.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_8_basico' and lo.short_name = 'Distribución espacial de actividades productivas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 8° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos suele formar parte de la identidad nacional de un país, como Chile?', '["Símbolos patrios, celebraciones y una historia compartida","Un elemento sin ninguna relación con la historia del país","Solo el nombre de una ciudad extranjera","Un idioma que no se habla en ese país"]', 0, 'Símbolos patrios, celebraciones y una historia compartida suelen formar parte de la identidad nacional de un país, como Chile.', 'inicial', 20),
  ('¿Por qué se dice que la construcción de la identidad nacional de Chile fue un proceso que se desarrolló principalmente durante el siglo XIX, tras la Independencia?', '["Porque fue en esa época cuando se promovieron símbolos, relatos y celebraciones que buscaban unir a la nueva nación","Porque la identidad nacional de Chile existió exactamente igual desde antes de la llegada de los españoles","Porque la identidad nacional no tiene ninguna relación con procesos históricos","Porque este proceso ocurrió completamente después del siglo XX"]', 0, 'La construcción de la identidad nacional de Chile se desarrolló principalmente durante el siglo XIX, cuando se promovieron símbolos, relatos y celebraciones que buscaban unir a la nueva nación tras la Independencia.', 'intermedia', 35),
  ('¿Cuál de estos elementos contribuyó a la construcción de la identidad nacional chilena durante el siglo XIX?', '["La promoción de símbolos patrios, como la bandera y el himno nacional","La eliminación de cualquier símbolo relacionado con el país","La adopción exacta de los símbolos de otro país","La ausencia total de cualquier relato compartido sobre la historia del país"]', 0, 'La promoción de símbolos patrios, como la bandera y el himno nacional, contribuyó a la construcción de la identidad nacional chilena durante el siglo XIX.', 'intermedia', 30),
  ('Un estudiante investiga que, tras la Independencia, el nuevo Estado chileno promovió símbolos patrios, una historia oficial sobre los próceres de la Independencia, y celebraciones cívicas, buscando generar un sentido de pertenencia común entre los habitantes del nuevo país. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la identidad nacional chilena fue, en parte, un proceso construido deliberadamente durante el siglo XIX","Que la identidad nacional chilena existió exactamente igual antes de la Independencia","Que la construcción de la identidad nacional no tuvo ninguna relación con símbolos ni relatos históricos","Que este proceso no tuvo ninguna intención de generar un sentido de pertenencia común"]', 0, 'Esta información es consistente con la idea de que la identidad nacional chilena fue, en parte, un proceso construido deliberadamente durante el siglo XIX.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_8_basico' and lo.short_name = 'Construcción de la identidad nacional'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una institución republicana creada en Chile durante el siglo XIX?', '["El Congreso Nacional","Una institución exclusivamente colonial sin ningún cambio","Una institución creada recién en el siglo XXI","Una institución propia de otro país sin relación con Chile"]', 0, 'El Congreso Nacional es una institución republicana creada en Chile durante el siglo XIX.', 'inicial', 20),
  ('¿Cuál era la función principal de la Constitución de 1833 dentro de las instituciones republicanas de Chile?', '["Establecer el marco legal e institucional que organizaba el nuevo Estado republicano","Reemplazar por completo cualquier forma de gobierno en Chile","Anular cualquier institución creada anteriormente","No tener ninguna relación con la organización del Estado"]', 0, 'La Constitución de 1833 establecía el marco legal e institucional que organizaba el nuevo Estado republicano de Chile.', 'intermedia', 30),
  ('¿Por qué se considera relevante el desarrollo de instituciones republicanas, como el Congreso Nacional, durante el siglo XIX en Chile?', '["Porque permitieron organizar la participación política y la elaboración de leyes en el nuevo Estado independiente","Porque estas instituciones no tuvieron ninguna función durante el siglo XIX","Porque el Congreso Nacional se creó recién en el siglo XXI","Porque estas instituciones eliminaron por completo cualquier participación política"]', 0, 'El desarrollo de instituciones republicanas fue relevante porque permitieron organizar la participación política y la elaboración de leyes en el nuevo Estado independiente.', 'intermedia', 35),
  ('Un estudiante investiga que, durante el siglo XIX, Chile desarrolló instituciones como el Congreso Nacional, un sistema de tribunales y una Constitución que organizaba los poderes del Estado, sentando las bases de la organización política del país. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que las instituciones republicanas del siglo XIX sentaron bases importantes para la organización política posterior de Chile","Que estas instituciones no tuvieron ninguna relación con la organización política de Chile","Que Chile no desarrolló ninguna institución republicana durante el siglo XIX","Que la Constitución del siglo XIX no organizó ningún poder del Estado"]', 0, 'Esta información es consistente con la idea de que las instituciones republicanas del siglo XIX sentaron bases importantes para la organización política posterior de Chile.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_8_basico' and lo.short_name = 'Instituciones republicanas del siglo XIX'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma de participación ciudadana en una democracia?', '["Votar en una elección","Impedir que otras personas voten","Ignorar por completo cualquier proceso electoral","Imponer una decisión sin ninguna votación"]', 0, 'Votar en una elección es una forma de participación ciudadana en una democracia.', 'inicial', 20),
  ('¿Por qué se considera importante que los ciudadanos participen activamente en la vida democrática de su país?', '["Porque su participación contribuye a que las decisiones públicas reflejen, en alguna medida, la voluntad ciudadana","Porque la participación ciudadana no tiene ninguna relación con las decisiones públicas","Porque solo las autoridades deberían participar en la vida democrática del país","Porque la participación ciudadana siempre dificulta el funcionamiento de la democracia"]', 0, 'Es importante que los ciudadanos participen activamente porque su participación contribuye a que las decisiones públicas reflejen, en alguna medida, la voluntad ciudadana.', 'intermedia', 30),
  ('¿Cuál de estas es una forma de ejercer la ciudadanía además de votar en elecciones?', '["Informarse sobre temas públicos y participar en organizaciones sociales","Ignorar cualquier tema relacionado con la vida pública del país","Evitar por completo cualquier tipo de participación social","Rechazar toda forma de organización ciudadana"]', 0, 'Informarse sobre temas públicos y participar en organizaciones sociales es una forma de ejercer la ciudadanía además de votar en elecciones.', 'intermedia', 35),
  ('Un estudiante investiga que, en una democracia, la ciudadanía puede participar votando en elecciones, informándose sobre temas públicos, integrándose a organizaciones sociales o comunicándose con sus representantes políticos. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que existen distintas formas de ejercer la ciudadanía y participar en una democracia, más allá de votar","Que la única forma válida de participación ciudadana es votar en elecciones","Que la ciudadanía no tiene ninguna forma de participar entre una elección y otra","Que participar en organizaciones sociales no tiene ninguna relación con la ciudadanía"]', 0, 'Esta información es consistente con la idea de que existen distintas formas de ejercer la ciudadanía y participar en una democracia, más allá de votar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_8_basico' and lo.short_name = 'Participación y ciudadanía en democracia'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 8° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un ejemplo histórico de ampliación de derechos ciudadanos en Chile?', '["El reconocimiento del derecho a voto de las mujeres","La eliminación total del derecho a votar","La reducción del número de personas con derecho a participar en elecciones","La anulación de cualquier derecho ciudadano"]', 0, 'El reconocimiento del derecho a voto de las mujeres es un ejemplo histórico de ampliación de derechos ciudadanos en Chile.', 'inicial', 20),
  ('¿Por qué se dice que el derecho a sufragio (votar) en Chile se fue ampliando de forma gradual a lo largo de la historia?', '["Porque, en distintos momentos históricos, se fueron incorporando nuevos grupos que antes no podían votar, como las mujeres","Porque el derecho a voto siempre incluyó exactamente a las mismas personas desde el inicio de la República","Porque el derecho a voto se eliminó por completo en algún momento de la historia de Chile","Porque este derecho no ha cambiado nunca desde la Independencia"]', 0, 'El derecho a sufragio se fue ampliando de forma gradual porque, en distintos momentos históricos, se fueron incorporando nuevos grupos que antes no podían votar, como las mujeres.', 'intermedia', 30),
  ('¿Cuál de estos procesos históricos representa una ampliación de derechos ciudadanos documentada en Chile durante el siglo XX?', '["La incorporación del voto femenino en elecciones","La restricción del voto exclusivamente a un grupo reducido de personas","La eliminación completa de cualquier proceso electoral","La reducción de la participación ciudadana en la vida pública"]', 0, 'La incorporación del voto femenino en elecciones representa una ampliación de derechos ciudadanos documentada en Chile durante el siglo XX.', 'intermedia', 35),
  ('Un estudiante investiga que, en sus primeras décadas como república, Chile restringía el derecho a voto a un grupo reducido de hombres con ciertas condiciones económicas, y que, con el paso del tiempo, este derecho se fue ampliando hasta incluir a las mujeres y, más adelante, a un sufragio más universal. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los derechos ciudadanos en Chile, como el derecho a voto, se ampliaron de manera gradual a lo largo de su historia","Que el derecho a voto en Chile incluyó siempre a toda la población desde el inicio de la República","Que los derechos ciudadanos nunca han cambiado a lo largo de la historia de Chile","Que el voto femenino se incorporó antes que el sufragio de los hombres sin condición económica"]', 0, 'Esta información es consistente con la idea de que los derechos ciudadanos en Chile, como el derecho a voto, se ampliaron de manera gradual a lo largo de su historia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_8_basico' and lo.short_name = 'Ampliación histórica de derechos ciudadanos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
