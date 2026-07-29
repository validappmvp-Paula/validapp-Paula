-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 4° Básico. Cubre los 12 objetivos de
-- aprendizaje de 4° Básico cargados por
-- supabase/seed/0021_curriculum_historia_regular_basica_1_6.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'.
--
-- NOTA PEDAGÓGICA (tema histórico sensible): el objetivo "Proceso de
-- conquista de América" y "Legado indígena y español en la sociedad
-- actual" se redactaron con el mismo criterio factual y neutral usado en
-- supabase/seed/0101 (3° Básico) para la conquista de Chile: se describe el
-- proceso y sus consecuencias documentadas para los pueblos originarios de
-- América sin lenguaje valorativo ni estereotipos, reconociendo tanto el
-- legado cultural mestizo como el impacto grave que tuvo la conquista sobre
-- las civilizaciones indígenas (pérdida de autonomía política, epidemias,
-- cambios forzados).

-- ============================================================================
-- EJE: HISTORIA — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas civilizaciones se desarrolló en la zona de los Andes, en Sudamérica, antes de la llegada de los españoles?', '["La civilización inca","La civilización azteca","La civilización maya","La civilización romana"]', 0, 'La civilización inca se desarrolló en la zona de los Andes, en Sudamérica, antes de la llegada de los españoles.', 'inicial', 20),
  ('¿Cuál de estos fue un aporte importante de la civilización maya, desarrollada en la zona de Mesoamérica?', '["Un calendario y un sistema de escritura propios muy avanzados","La invención de la imprenta moderna","La construcción del primer avión","El descubrimiento de la electricidad"]', 0, 'La civilización maya desarrolló un calendario y un sistema de escritura propios muy avanzados para su época.', 'intermedia', 30),
  ('¿Cuál de estas obras es un ejemplo de la organización política y de ingeniería de la civilización inca?', '["La red de caminos (el Camino Inca) que conectaba distintas partes de su territorio","La construcción de rascacielos modernos","La invención del automóvil","La creación de internet"]', 0, 'La red de caminos, conocida como el Camino Inca, que conectaba distintas partes del territorio, es un ejemplo de la organización política y de ingeniería incaica.', 'intermedia', 35),
  ('Un estudiante investiga que la civilización azteca, en el centro de México, construyó la ciudad de Tenochtitlan sobre un lago, con canales y chinampas (islas artificiales) para cultivar alimentos, mostrando un alto nivel de organización urbana. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que las civilizaciones americanas anteriores a la llegada de los españoles alcanzaron altos niveles de organización política, social y tecnológica","Que las civilizaciones americanas no tuvieron ninguna forma de organización","Que solo la civilización europea alcanzó avances tecnológicos importantes","Que la ciudad de Tenochtitlan fue construida después de la llegada de los españoles"]', 0, 'Esta información es consistente con la idea de que las civilizaciones americanas, como la azteca, alcanzaron altos niveles de organización política, social y tecnológica antes de la llegada de los españoles.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_4_basico' and lo.short_name = 'Civilizaciones americanas: mayas, aztecas e incas'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿En qué siglo comenzó el proceso de conquista de América por parte de expedicionarios españoles y de otros países europeos?', '["En el siglo XV-XVI","En el siglo XX","En el siglo X","En el siglo XXV"]', 0, 'El proceso de conquista de América comenzó en el siglo XV-XVI, tras la llegada de expedicionarios europeos al continente.', 'inicial', 20),
  ('¿Cuál de estas fue una consecuencia documentada del proceso de conquista de América para las civilizaciones indígenas, como la azteca y la inca?', '["La pérdida de su autonomía política y grandes epidemias que redujeron drásticamente su población","Un aumento inmediato de su población sin ningún cambio","Ningún cambio en su organización política ni social","El fortalecimiento total de sus antiguos gobiernos, sin ninguna alteración"]', 0, 'La pérdida de autonomía política y las epidemias que redujeron drásticamente la población indígena son consecuencias documentadas del proceso de conquista.', 'intermedia', 35),
  ('¿Por qué se dice que la conquista de América fue un proceso complejo, con distintos actores y consecuencias?', '["Porque involucró a distintos pueblos indígenas, expedicionarios europeos, alianzas y conflictos, con consecuencias variadas según la zona","Porque fue un proceso idéntico en todo el continente, sin ninguna diferencia","Porque no involucró a ningún pueblo indígena","Porque no tuvo ninguna consecuencia para ningún grupo"]', 0, 'La conquista de América fue un proceso complejo porque involucró a distintos pueblos indígenas, expedicionarios europeos, alianzas y conflictos, con consecuencias variadas según la zona.', 'intermedia', 35),
  ('Un estudiante investiga que, durante la conquista de América, algunos pueblos indígenas se aliaron con los expedicionarios españoles para enfrentar a otros pueblos con los que tenían conflictos previos, mientras que otros pueblos resistieron el avance español durante largo tiempo. ¿Qué idea sobre el proceso de conquista refleja mejor esta información?', '["Que el proceso de conquista de América tuvo distintas dinámicas según el pueblo y la región, y no fue un proceso uniforme","Que todos los pueblos indígenas de América reaccionaron exactamente de la misma forma frente a la conquista","Que ningún pueblo indígena tuvo ninguna relación con los expedicionarios españoles","Que la conquista de América no involucró ningún tipo de conflicto"]', 0, 'Esta información refleja que el proceso de conquista de América tuvo distintas dinámicas según el pueblo y la región, y no fue un proceso uniforme en todo el continente.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_4_basico' and lo.short_name = 'Proceso de conquista de América'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos alimentos, hoy consumido en todo el mundo, proviene originalmente de civilizaciones indígenas de América?', '["La papa","El trigo","El arroz","La manzana europea"]', 0, 'La papa es un alimento originario de civilizaciones indígenas de América, como los pueblos andinos, y hoy se consume en todo el mundo.', 'inicial', 20),
  ('¿Cuál de estos elementos forma parte del legado español presente en la sociedad chilena actual?', '["El idioma español, hablado por la gran mayoría de la población","El idioma quechua como único idioma del país","La organización política de los incas sin ningún cambio","Un sistema de escritura maya usado de forma oficial"]', 0, 'El idioma español, hablado por la gran mayoría de la población, es un elemento del legado español presente en la sociedad chilena actual.', 'intermedia', 30),
  ('¿Cuál de estos elementos forma parte del legado indígena presente en la sociedad chilena actual?', '["Palabras de origen mapudungun o quechua usadas en el habla cotidiana","El uso exclusivo del idioma inglés","La ausencia total de tradiciones indígenas","Un sistema político copiado exactamente de la Roma antigua"]', 0, 'Palabras de origen mapudungun o quechua usadas en el habla cotidiana son parte del legado indígena presente en la sociedad chilena actual.', 'intermedia', 30),
  ('Un estudiante investiga que en la sociedad chilena actual conviven elementos como el idioma español, la religión católica traída por los españoles, junto con alimentos, palabras y tradiciones de origen indígena, como el mapudungun y ciertas celebraciones. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la sociedad actual refleja un legado combinado, con influencias tanto indígenas como españolas","Que la sociedad actual solo tiene influencia española, sin ningún elemento indígena","Que la sociedad actual solo tiene influencia indígena, sin ningún elemento español","Que no existe ninguna relación entre el pasado y la sociedad actual"]', 0, 'Esta información es consistente con la idea de que la sociedad actual refleja un legado combinado, con influencias tanto indígenas como españolas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_4_basico' and lo.short_name = 'Legado indígena y español en la sociedad actual'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos es útil incluir al elaborar una línea de tiempo sobre un proceso histórico, como la conquista de América?', '["Los hechos más importantes ordenados según el año en que ocurrieron","Solo dibujos sin ninguna relación con fechas","Hechos inventados sin ninguna base histórica","Información que no tiene relación con el tema estudiado"]', 0, 'Los hechos más importantes ordenados según el año en que ocurrieron son un elemento útil para elaborar una línea de tiempo sobre un proceso histórico.', 'inicial', 20),
  ('¿Cuál de estas es una fuente primaria útil para estudiar el proceso de conquista de América?', '["Una carta escrita por un expedicionario de la época","Un libro de historia escrito en el siglo XXI","Un video de entretenimiento actual","Una opinión personal sin ninguna base documental"]', 0, 'Una carta escrita por un expedicionario de la época es un ejemplo de fuente primaria útil para estudiar el proceso de conquista de América.', 'intermedia', 30),
  ('¿Por qué es importante usar tanto fuentes primarias como secundarias al elaborar una línea de tiempo sobre un proceso histórico?', '["Porque permite contrastar distintas miradas y construir una explicación más completa y fundamentada","Porque las fuentes secundarias siempre contradicen a las primarias sin ningún motivo","Porque usar más de un tipo de fuente dificulta entender el proceso histórico","Porque una sola fuente siempre entrega toda la información necesaria"]', 0, 'Usar fuentes primarias y secundarias permite contrastar distintas miradas y construir una explicación más completa y fundamentada de un proceso histórico.', 'intermedia', 35),
  ('Un estudiante elabora una línea de tiempo sobre el proceso de conquista de América, usando como fuentes un mapa de la época, un fragmento de una carta de un expedicionario y un libro de historia actual que explica el contexto general del proceso. ¿Qué habilidad está aplicando el estudiante?', '["Elaborar líneas de tiempo utilizando fuentes primarias y secundarias simples para estudiar el pasado","Inventar hechos históricos sin ninguna base documental","Ignorar cualquier fuente disponible sobre el tema","Describir únicamente su opinión personal sobre el tema, sin fuentes"]', 0, 'El estudiante está aplicando la habilidad de elaborar líneas de tiempo utilizando fuentes primarias y secundarias simples para estudiar el pasado.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_4_basico' and lo.short_name = 'Líneas de tiempo y fuentes históricas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un continente del mundo?', '["América","El Océano Pacífico","El Mar Mediterráneo","El río Amazonas"]', 0, 'América es uno de los continentes del mundo.', 'inicial', 20),
  ('¿Cuál de estos es un océano que rodea el territorio de Chile?', '["El Océano Pacífico","El Océano Ártico","El Mar Rojo","El Mar Negro"]', 0, 'El Océano Pacífico es el océano que bordea la costa oeste del territorio de Chile.', 'intermedia', 30),
  ('¿Por qué es útil ubicar los continentes y océanos del mundo en un mapa o globo terráqueo?', '["Porque ayuda a comprender la distribución de las tierras y aguas a nivel mundial","Porque los continentes y océanos no tienen ninguna ubicación fija","Porque no existe ninguna diferencia entre continentes y océanos","Porque ubicar continentes y océanos no aporta ninguna información útil"]', 0, 'Ubicar los continentes y océanos en un mapa o globo terráqueo ayuda a comprender la distribución de las tierras y aguas a nivel mundial.', 'intermedia', 30),
  ('Un estudiante observa un globo terráqueo y ubica los continentes de América, Europa, África, Asia y Oceanía, además de los océanos Pacífico, Atlántico, Índico, Ártico y Antártico. ¿Qué habilidad está practicando al realizar esta actividad?', '["Ubicar los continentes y océanos del mundo usando mapas y globos terráqueos","Describir una civilización americana antigua","Explicar una norma de convivencia escolar","Comparar dos épocas históricas distintas"]', 0, 'El estudiante está practicando la habilidad de ubicar los continentes y océanos del mundo usando mapas y globos terráqueos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_4_basico' and lo.short_name = 'Continentes y océanos del mundo'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas zonas climáticas se caracteriza por temperaturas muy bajas durante todo el año?', '["La zona polar","La zona ecuatorial","La zona tropical húmeda","La zona desértica cálida"]', 0, 'La zona polar se caracteriza por temperaturas muy bajas durante todo el año.', 'inicial', 20),
  ('¿Por qué las formas de vida humana pueden variar según la zona climática en que se habita?', '["Porque las personas adaptan su vivienda, vestimenta y alimentación a las condiciones del clima de su zona","Porque el clima no influye de ninguna forma en la vida de las personas","Porque todas las zonas climáticas del mundo tienen exactamente las mismas condiciones","Porque las personas nunca se adaptan a su entorno climático"]', 0, 'Las formas de vida humana varían según la zona climática porque las personas adaptan su vivienda, vestimenta y alimentación a las condiciones del clima de su zona.', 'intermedia', 30),
  ('¿Cuál de estas viviendas se relaciona con la adaptación de las personas a un clima muy frío?', '["Una vivienda bien aislada del frío, con paredes gruesas","Una vivienda abierta y ligera, pensada para climas muy calurosos","Una vivienda flotante en medio del océano","Una vivienda sin ningún tipo de aislamiento en zonas polares"]', 0, 'Una vivienda bien aislada del frío, con paredes gruesas, se relaciona con la adaptación de las personas a un clima muy frío.', 'intermedia', 30),
  ('Un estudiante compara la forma de vida de una comunidad que habita una zona muy calurosa y húmeda, con viviendas abiertas y ventiladas, con la de una comunidad que habita una zona muy fría, con viviendas cerradas y bien aisladas. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que las formas de vida humana suelen adaptarse a las condiciones climáticas de la zona donde se habita","Que el clima no tiene ninguna relación con la forma de vida de las personas","Que todas las comunidades del mundo construyen exactamente el mismo tipo de vivienda","Que la adaptación al clima solo ocurre en algunas partes del mundo, sin ningún patrón"]', 0, 'Esta comparación es consistente con la idea de que las formas de vida humana suelen adaptarse a las condiciones climáticas de la zona donde se habita.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_4_basico' and lo.short_name = 'Zonas climáticas y vida humana'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿En qué está organizado políticamente el territorio de Chile, además de en zonas geográficas?', '["En regiones","En continentes","En océanos","En husos horarios únicamente"]', 0, 'El territorio de Chile está organizado políticamente en regiones, además de dividirse en zonas geográficas.', 'inicial', 20),
  ('¿Cuál de estas es una característica de una región ubicada en el extremo norte de Chile?', '["Presencia del desierto de Atacama y actividad minera relevante","Presencia de grandes glaciares y clima muy frío todo el año","Predominio de bosques lluviosos","Un clima tropical húmedo todo el año"]', 0, 'La presencia del desierto de Atacama y una actividad minera relevante son características de una región del extremo norte de Chile.', 'intermedia', 30),
  ('¿Por qué las regiones de Chile pueden tener características geográficas y económicas distintas entre sí?', '["Porque cada una tiene su propio clima, relieve y recursos naturales, que influyen en su economía","Porque todas las regiones de Chile tienen exactamente el mismo clima y relieve","Porque las regiones no tienen ninguna diferencia entre sí","Porque la economía de una región no depende de su geografía"]', 0, 'Las regiones de Chile pueden tener características distintas porque cada una tiene su propio clima, relieve y recursos naturales, que influyen en su economía.', 'intermedia', 30),
  ('Un estudiante compara una región del extremo sur de Chile, con glaciares y bajas temperaturas, con una región del centro del país, con clima templado y suelos fértiles para la agricultura. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que las regiones de Chile presentan una diversidad de características geográficas que influyen en sus actividades económicas","Que todas las regiones de Chile tienen exactamente las mismas características geográficas","Que las actividades económicas de una región no tienen relación con su geografía","Que el sur y el centro de Chile tienen exactamente el mismo clima"]', 0, 'Esta comparación es consistente con la idea de que las regiones de Chile presentan una diversidad de características geográficas que influyen en sus actividades económicas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_4_basico' and lo.short_name = 'Regiones de Chile y sus características'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué muestra un mapa temático sobre población, a diferencia de un mapa físico?', '["La cantidad o distribución de personas en un territorio","Únicamente el relieve del territorio","Únicamente los ríos y océanos","Ninguna información relevante sobre el territorio"]', 0, 'Un mapa temático sobre población muestra la cantidad o distribución de personas en un territorio, a diferencia de un mapa físico centrado en el relieve.', 'inicial', 20),
  ('¿Por qué es útil interpretar un mapa temático simple, como uno que muestra las principales actividades económicas de un país?', '["Porque permite comprender cómo se distribuye una característica específica en el territorio","Porque los mapas temáticos no aportan ninguna información útil","Porque un mapa temático siempre muestra exactamente lo mismo que un mapa físico","Porque interpretar un mapa temático dificulta el análisis del territorio"]', 0, 'Interpretar un mapa temático simple permite comprender cómo se distribuye una característica específica, como una actividad económica, en el territorio.', 'intermedia', 30),
  ('Un mapa temático de Chile muestra, con distintos colores, las principales actividades económicas de cada zona: minería en el norte, agricultura en el centro y actividad forestal en el sur. ¿Qué tipo de información entrega este mapa?', '["Información temática sobre la distribución de actividades económicas en el territorio","Información únicamente sobre el clima de cada zona","Información sobre la cantidad de habitantes de cada ciudad","Ninguna información relevante sobre el territorio"]', 0, 'Este mapa entrega información temática sobre la distribución de actividades económicas en el territorio de Chile.', 'intermedia', 35),
  ('Un estudiante analiza un mapa temático que muestra la cantidad de precipitaciones en distintas zonas de Chile, notando que el norte tiene muy pocas lluvias y el sur tiene abundantes lluvias. A partir de esta información, explica por qué la agricultura de secano es más común en el sur. ¿Qué habilidad está aplicando el estudiante?', '["Interpretar información geográfica presentada en un mapa temático simple para explicar un fenómeno","Ignorar la información entregada por el mapa temático","Inventar datos que no aparecen en el mapa","Describir un hecho histórico sin relación con el mapa"]', 0, 'El estudiante está aplicando la habilidad de interpretar información geográfica presentada en un mapa temático simple para explicar un fenómeno.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_4_basico' and lo.short_name = 'Interpretación de mapas temáticos simples'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 4° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es uno de los poderes públicos del Estado de Chile?', '["El Poder Ejecutivo","El poder de una empresa privada","El poder de una familia","El poder de un club deportivo"]', 0, 'El Poder Ejecutivo es uno de los poderes públicos del Estado de Chile.', 'inicial', 20),
  ('¿Por qué se dice que el Estado se organiza en distintos poderes públicos?', '["Porque permite repartir funciones y evitar que una sola autoridad concentre todo el poder","Porque un Estado siempre debería tener un único poder concentrado en una sola persona","Porque los poderes públicos no tienen ninguna función específica","Porque la organización del Estado no influye en su funcionamiento"]', 0, 'El Estado se organiza en distintos poderes públicos porque esto permite repartir funciones y evitar que una sola autoridad concentre todo el poder.', 'intermedia', 30),
  ('¿Cuál de estas es una función asociada al Poder Legislativo?', '["Elaborar y aprobar leyes para el país","Juzgar delitos en los tribunales","Administrar directamente los ministerios del gobierno","Fabricar productos de exportación"]', 0, 'Elaborar y aprobar leyes para el país es una función asociada al Poder Legislativo.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, el Poder Ejecutivo (encabezado por el presidente o presidenta) gobierna el país, el Poder Legislativo elabora las leyes y el Poder Judicial resuelve conflictos según esas leyes. ¿Qué idea general sobre la organización del Estado refleja esta información?', '["Que el Estado chileno se organiza en distintos poderes con funciones específicas y complementarias","Que en Chile existe un único poder que concentra todas las funciones del Estado","Que los poderes del Estado no tienen ninguna relación entre sí","Que solo el Poder Ejecutivo tiene funciones importantes en el Estado"]', 0, 'Esta información refleja que el Estado chileno se organiza en distintos poderes con funciones específicas y complementarias.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_4_basico' and lo.short_name = 'Organización básica del Estado'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas afirmaciones sobre los derechos humanos es correcta?', '["Son derechos que corresponden a todas las personas, sin importar su origen o condición","Solo corresponden a un grupo específico de personas","Solo existen en algunos países del mundo","No tienen ninguna relación con la dignidad de las personas"]', 0, 'Los derechos humanos son derechos que corresponden a todas las personas, sin importar su origen o condición.', 'inicial', 20),
  ('¿Por qué se dice que los derechos humanos son acuerdos compartidos por gran parte de la humanidad?', '["Porque distintos países del mundo los reconocen en documentos internacionales, como acuerdos comunes","Porque cada país tiene derechos humanos completamente distintos y sin relación entre sí","Porque los derechos humanos fueron creados por un solo país para su propio beneficio","Porque no existe ningún acuerdo internacional relacionado con los derechos humanos"]', 0, 'Los derechos humanos son acuerdos compartidos porque distintos países del mundo los reconocen en documentos internacionales, como acuerdos comunes.', 'intermedia', 30),
  ('¿Cuál de estos es un ejemplo de derecho humano reconocido internacionalmente?', '["El derecho a la educación","El derecho a decidir las leyes de otro país","El derecho a no respetar a otras personas","El derecho exclusivo de un solo grupo social"]', 0, 'El derecho a la educación es un ejemplo de derecho humano reconocido internacionalmente.', 'intermedia', 30),
  ('Un estudiante investiga que, después de conflictos importantes en la historia mundial, distintos países se reunieron para acordar un documento que reconociera derechos básicos para todas las personas, sin importar su nacionalidad, género o condición social. ¿Qué idea general sobre el origen de los derechos humanos refleja esta información?', '["Que los derechos humanos surgieron como un acuerdo compartido para proteger la dignidad de todas las personas","Que los derechos humanos fueron impuestos por un único país al resto del mundo","Que los derechos humanos solo protegen a un grupo reducido de personas","Que los derechos humanos no tienen relación con ningún acuerdo internacional"]', 0, 'Esta información refleja que los derechos humanos surgieron como un acuerdo compartido para proteger la dignidad de todas las personas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_4_basico' and lo.short_name = 'Origen de los derechos humanos'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una práctica de convivencia democrática en la escuela?', '["La elección de un representante de curso mediante votación","La imposición de decisiones sin consultar a nadie","La prohibición de que los estudiantes opinen sobre temas del curso","La exclusión de algunos estudiantes de las actividades del curso"]', 0, 'La elección de un representante de curso mediante votación es una práctica de convivencia democrática en la escuela.', 'inicial', 20),
  ('¿Por qué es valioso que los estudiantes practiquen formas de convivencia democrática, como elegir representantes, desde temprana edad?', '["Porque ayuda a desarrollar hábitos de participación y respeto que son importantes para la vida en democracia","Porque no tiene ninguna relación con la vida fuera de la escuela","Porque las decisiones democráticas siempre son iguales a las decisiones de una sola persona","Porque practicar la democracia en la escuela no aporta ningún aprendizaje"]', 0, 'Es valioso practicar formas de convivencia democrática desde temprana edad porque ayuda a desarrollar hábitos de participación y respeto importantes para la vida en democracia.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra una convivencia democrática en un curso?', '["El curso vota para elegir el nombre de una actividad, respetando el resultado de la votación","El profesor decide todo sin consultar nunca al curso","Un grupo de estudiantes impone su decisión sin escuchar a los demás","El curso ignora por completo la opinión de la mayoría"]', 0, 'El curso vota para elegir el nombre de una actividad, respetando el resultado de la votación, es un ejemplo de convivencia democrática.', 'intermedia', 30),
  ('Un curso debe elegir a su directiva (presidente, tesorero, entre otros). Antes de votar, cada candidato presenta sus ideas al resto del curso, y luego todos votan en secreto para elegir a los representantes, respetando el resultado final. ¿Qué principio de convivencia democrática se aplica en esta situación?', '["La participación de todos en la elección de representantes y el respeto por el resultado de una votación","La imposición de una decisión sin ninguna votación","La exclusión de algunos estudiantes del proceso de elección","La elección de representantes sin ninguna presentación de ideas"]', 0, 'Esta situación aplica el principio de participación de todos en la elección de representantes y el respeto por el resultado de una votación, propio de la convivencia democrática.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_4_basico' and lo.short_name = 'Convivencia democrática en la escuela'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 4° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma de mostrar respeto por la diversidad presente en la comunidad escolar?', '["Tratar con respeto a compañeros con distintas características, orígenes o formas de pensar","Burlarse de un compañero por ser distinto a la mayoría","Excluir a un estudiante por su origen o características personales","Ignorar la diversidad presente en el curso"]', 0, 'Tratar con respeto a compañeros con distintas características, orígenes o formas de pensar es una forma de mostrar respeto por la diversidad escolar.', 'inicial', 20),
  ('¿Por qué es importante que la comunidad escolar reconozca y respete la diversidad presente en ella?', '["Porque contribuye a un ambiente escolar más justo, respetuoso e inclusivo para todos","Porque la diversidad no tiene ninguna relación con el ambiente escolar","Porque solo un tipo de estudiante debería ser aceptado en la escuela","Porque reconocer la diversidad genera más conflictos que beneficios"]', 0, 'Reconocer y respetar la diversidad presente en la comunidad escolar contribuye a un ambiente escolar más justo, respetuoso e inclusivo para todos.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra una actitud de trato respetuoso frente a la diversidad de la comunidad escolar?', '["Un curso que incluye y apoya a un nuevo estudiante que llega de otro país","Un curso que se burla del acento de un estudiante extranjero","Un curso que excluye a un estudiante con una discapacidad","Un curso que solo acepta a estudiantes con las mismas características"]', 0, 'Un curso que incluye y apoya a un nuevo estudiante que llega de otro país muestra una actitud de trato respetuoso frente a la diversidad escolar.', 'intermedia', 30),
  ('En un curso conviven estudiantes con distintos orígenes, capacidades y formas de pensar. La escuela organiza actividades para que todos se conozcan mejor y promueve que ningún estudiante sea discriminado por sus características personales. ¿Qué valor está promoviendo la escuela con estas acciones?', '["El reconocimiento y respeto por la diversidad presente en la comunidad escolar","La idea de que solo un tipo de estudiante merece respeto","La comparación entre estudiantes para decidir quién es mejor","La exclusión de estudiantes con características distintas a la mayoría"]', 0, 'La escuela está promoviendo el reconocimiento y respeto por la diversidad presente en la comunidad escolar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_4_basico' and lo.short_name = 'Diversidad y respeto en la comunidad escolar'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
