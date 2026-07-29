-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 7° Básico. Cubre los 12 objetivos de
-- aprendizaje de 7° Básico cargados por
-- supabase/seed/0022_curriculum_historia_regular_7basico_2medio.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'. Sin temas
-- históricos sensibles de la historia reciente de Chile en este nivel.

-- ============================================================================
-- EJE: HISTORIA — 7° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un aporte institucional de la antigua Roma que influye en sistemas legales actuales, incluido el de Chile?', '["Bases del derecho romano, como principios sobre contratos y propiedad","La invención de internet","El sistema de escritura maya","La organización política de los incas"]', 0, 'Las bases del derecho romano, como principios sobre contratos y propiedad, son un aporte institucional que influye en sistemas legales actuales, incluido el de Chile.', 'inicial', 20),
  ('¿Cuál de estos elementos culturales de la antigua Roma se mantiene presente en la actualidad?', '["El uso del alfabeto latino, base de muchos idiomas actuales, incluido el español","El uso exclusivo del idioma griego antiguo","La organización política de las civilizaciones mesoamericanas","El sistema numérico maya"]', 0, 'El uso del alfabeto latino, base de muchos idiomas actuales, incluido el español, es un elemento cultural de la antigua Roma presente en la actualidad.', 'intermedia', 30),
  ('¿Por qué se dice que Roma dejó un legado institucional importante para muchas sociedades posteriores?', '["Porque desarrolló un sistema de derecho, una organización administrativa y una infraestructura que influyeron en gobiernos posteriores","Porque Roma no tuvo ninguna influencia después de su desaparición","Porque todos los países del mundo copiaron exactamente el gobierno romano sin ningún cambio","Porque el legado romano desapareció por completo con el paso del tiempo"]', 0, 'Roma dejó un legado institucional importante porque desarrolló un sistema de derecho, una organización administrativa y una infraestructura que influyeron en gobiernos posteriores.', 'intermedia', 35),
  ('Un estudiante investiga que muchos países actuales, incluido Chile, organizan su sistema legal en torno a principios de derecho escrito y códigos, una tradición que se remonta en parte al derecho romano, y que además usan el alfabeto latino para escribir su idioma. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el legado institucional y cultural de Roma puede reconocerse en distintos aspectos de sociedades actuales","Que Roma no tuvo ninguna influencia en las sociedades posteriores a su existencia","Que Chile copió exactamente el sistema político romano sin ningún cambio","Que el alfabeto latino no tiene ninguna relación con el idioma español"]', 0, 'Esta información es consistente con la idea de que el legado institucional y cultural de Roma puede reconocerse en distintos aspectos de sociedades actuales.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_7_basico' and lo.short_name = 'Legado institucional y cultural de Roma'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos grupos formaba parte de la organización social feudal durante la Edad Media europea?', '["Los señores feudales y los campesinos","Los astronautas","Los ingenieros de sistemas","Los pilotos de avión"]', 0, 'Los señores feudales y los campesinos formaban parte de la organización social feudal durante la Edad Media europea.', 'inicial', 20),
  ('¿Cuál fue un rol importante de la Iglesia católica en la organización social, cultural y política durante buena parte de la Edad Media europea?', '["Tuvo una influencia relevante en la educación, la cultura y las decisiones políticas de la época","No tuvo ninguna influencia en la sociedad medieval","Se dedicó exclusivamente a actividades comerciales","Desapareció completamente durante ese período histórico"]', 0, 'La Iglesia católica tuvo una influencia relevante en la educación, la cultura y las decisiones políticas durante buena parte de la Edad Media europea.', 'intermedia', 30),
  ('¿Por qué se describe la sociedad feudal como una sociedad jerárquica y basada en relaciones de dependencia?', '["Porque existían distintos niveles sociales, con obligaciones y derechos diferentes entre señores, vasallos y campesinos","Porque todos los grupos sociales de la época tenían exactamente los mismos derechos y obligaciones","Porque no existía ninguna forma de organización social durante la Edad Media","Porque la sociedad feudal era idéntica a la sociedad actual"]', 0, 'La sociedad feudal se describe como jerárquica porque existían distintos niveles sociales, con obligaciones y derechos diferentes entre señores, vasallos y campesinos.', 'intermedia', 35),
  ('Un estudiante investiga que, durante la Edad Media, muchos monasterios funcionaban como centros de conocimiento donde se copiaban libros y se enseñaba a leer y escribir, mientras que la nobleza feudal ejercía el poder militar y económico sobre los territorios. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la Iglesia y la nobleza feudal cumplían roles distintos pero relevantes en la organización de la sociedad medieval","Que la Iglesia no tuvo ninguna función durante la Edad Media","Que solo la nobleza feudal tuvo importancia durante este período histórico","Que la educación no existió de ninguna forma durante la Edad Media"]', 0, 'Esta información es consistente con la idea de que la Iglesia y la nobleza feudal cumplían roles distintos pero relevantes en la organización de la sociedad medieval.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_7_basico' and lo.short_name = 'Sociedad feudal y rol de la Iglesia en la Edad Media'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos procesos ocurrió hacia el final de la Edad Media y el inicio de la Edad Moderna en Europa?', '["La formación de monarquías con mayor poder centralizado en algunos territorios","La desaparición completa de cualquier forma de gobierno en Europa","El fin de toda forma de organización política en el mundo","La eliminación total del comercio europeo"]', 0, 'La formación de monarquías con mayor poder centralizado en algunos territorios ocurrió hacia el final de la Edad Media y el inicio de la Edad Moderna.', 'inicial', 20),
  ('¿Cuál de estos factores impulsó la expansión europea hacia otros continentes a partir del siglo XV?', '["La búsqueda de nuevas rutas comerciales y recursos","La ausencia total de interés por el comercio","La imposibilidad de construir barcos","La falta de cualquier avance en la navegación"]', 0, 'La búsqueda de nuevas rutas comerciales y recursos fue un factor que impulsó la expansión europea hacia otros continentes a partir del siglo XV.', 'intermedia', 30),
  ('¿Por qué se relaciona la formación de monarquías más centralizadas con la posterior expansión europea hacia otros continentes?', '["Porque monarquías con mayor poder y recursos pudieron financiar expediciones y proyectos de expansión territorial","Porque la formación de monarquías no tiene ninguna relación con la expansión europea","Porque la expansión europea ocurrió antes de la formación de cualquier monarquía","Porque solo los campesinos financiaron las expediciones de la época"]', 0, 'Monarquías con mayor poder y recursos pudieron financiar expediciones y proyectos de expansión territorial, lo que las relaciona con la posterior expansión europea.', 'intermedia', 35),
  ('Un estudiante investiga que, a partir del siglo XV, algunas monarquías europeas, con mayor poder centralizado y recursos económicos, financiaron expediciones marítimas en busca de nuevas rutas comerciales, lo que llevó a la llegada de expedicionarios europeos a distintos continentes, incluido América. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la formación de monarquías centralizadas y la expansión europea estuvieron relacionadas entre sí","Que la expansión europea no tuvo ninguna relación con la organización política de la época","Que ninguna monarquía europea financió expediciones marítimas","Que la formación de monarquías ocurrió después de la expansión europea hacia América"]', 0, 'Esta información es consistente con la idea de que la formación de monarquías centralizadas y la expansión europea estuvieron relacionadas entre sí.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_7_basico' and lo.short_name = 'Formación de monarquías y expansión europea'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una fuente histórica material, útil para estudiar un período del pasado?', '["Un objeto arqueológico, como una herramienta antigua","Una predicción sobre el futuro","Una opinión personal sin ninguna base documental","Un juego de video actual"]', 0, 'Un objeto arqueológico, como una herramienta antigua, es una fuente histórica material útil para estudiar un período del pasado.', 'inicial', 20),
  ('¿Por qué es importante analizar el contexto en que fue producida una fuente histórica, como un documento de la época?', '["Porque el contexto ayuda a comprender mejor la intención y la confiabilidad de la fuente","Porque el contexto de una fuente histórica no tiene ninguna relación con su interpretación","Porque todas las fuentes históricas deben interpretarse exactamente de la misma forma","Porque analizar el contexto dificulta el estudio de una fuente histórica"]', 0, 'Analizar el contexto en que fue producida una fuente histórica ayuda a comprender mejor su intención y su confiabilidad.', 'intermedia', 30),
  ('¿Cuál de estas es una razón para comparar distintos tipos de fuentes (escritas, materiales, visuales) al estudiar un proceso histórico?', '["Porque cada tipo de fuente puede aportar información distinta y complementaria sobre un mismo proceso","Porque todas las fuentes históricas siempre entregan exactamente la misma información","Porque comparar distintos tipos de fuentes dificulta la comprensión de un proceso histórico","Porque una sola fuente siempre es suficiente para comprender un proceso completo"]', 0, 'Comparar distintos tipos de fuentes es útil porque cada una puede aportar información distinta y complementaria sobre un mismo proceso.', 'intermedia', 35),
  ('Un estudiante analiza, para estudiar la sociedad feudal, un documento legal de la época, una imagen que representa a un señor feudal y sus vasallos, y restos arqueológicos de un castillo medieval. Al comparar esta información, construye una explicación más completa sobre cómo funcionaba esa sociedad. ¿Qué habilidad está aplicando el estudiante?', '["Analizar distintos tipos de fuentes históricas para fundamentar una interpretación sobre un proceso del pasado","Inventar información sin ninguna base documental","Ignorar cualquier fuente histórica disponible sobre el tema","Describir únicamente su opinión personal, sin usar fuentes"]', 0, 'El estudiante está aplicando la habilidad de analizar distintos tipos de fuentes históricas para fundamentar una interpretación sobre un proceso del pasado.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_7_basico' and lo.short_name = 'Análisis de fuentes históricas diversas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 7° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos forma parte del relieve de Chile, presente a lo largo de todo su territorio?', '["La Cordillera de los Andes","El Océano Índico","Un desierto ubicado en otro continente","Un río que no pertenece al territorio chileno"]', 0, 'La Cordillera de los Andes forma parte del relieve de Chile y está presente a lo largo de todo su territorio.', 'inicial', 20),
  ('¿Cuál de estos climas predomina en gran parte de la zona central de Chile?', '["El clima mediterráneo, con veranos secos e inviernos lluviosos","Un clima polar todo el año","Un clima tropical húmedo constante","Un clima desértico extremo todo el año"]', 0, 'El clima mediterráneo, con veranos secos e inviernos lluviosos, predomina en gran parte de la zona central de Chile.', 'intermedia', 30),
  ('¿Por qué el relieve, el clima y la hidrografía de Chile presentan una gran variación de norte a sur?', '["Porque el territorio chileno se extiende a lo largo de una gran distancia, con importantes cambios de latitud","Porque todo el territorio chileno tiene exactamente las mismas características geográficas","Porque el clima de un país nunca depende de su ubicación geográfica","Porque la hidrografía de Chile es idéntica en todas sus zonas"]', 0, 'El relieve, el clima y la hidrografía de Chile presentan una gran variación de norte a sur porque su territorio se extiende a lo largo de una gran distancia, con importantes cambios de latitud.', 'intermedia', 35),
  ('Un estudiante analiza que en el norte de Chile predomina un clima desértico con escasos ríos, en la zona central un clima mediterráneo con ríos de caudal variable, y en el sur un clima lluvioso con ríos caudalosos y numerosos lagos. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que Chile presenta una gran diversidad de climas, relieve e hidrografía entre sus distintas zonas","Que todo el territorio chileno presenta exactamente el mismo clima e hidrografía","Que la hidrografía de Chile no tiene ninguna relación con el clima de cada zona","Que solo el norte de Chile presenta variaciones climáticas"]', 0, 'Esta información es consistente con la idea de que Chile presenta una gran diversidad de climas, relieve e hidrografía entre sus distintas zonas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_7_basico' and lo.short_name = 'Relieve, clima e hidrografía de Chile'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un riesgo natural que puede afectar al territorio chileno debido a su ubicación geográfica?', '["Los tsunamis","Un huracán tropical típico del Caribe","Una tormenta de arena en el desierto del Sahara","Una erupción en un volcán de otro continente"]', 0, 'Los tsunamis son un riesgo natural que puede afectar al territorio chileno debido a su ubicación geográfica, cercana a zonas de actividad sísmica submarina.', 'inicial', 20),
  ('¿Cuál de estas es una medida de mitigación frente al riesgo de un tsunami en una zona costera?', '["Contar con señalización de rutas de evacuación y zonas de seguridad","Ignorar por completo cualquier alerta de tsunami","Construir viviendas justo en la orilla del mar sin ninguna consideración de riesgo","No informar nunca a la población sobre este riesgo"]', 0, 'Contar con señalización de rutas de evacuación y zonas de seguridad es una medida de mitigación frente al riesgo de un tsunami en una zona costera.', 'intermedia', 30),
  ('¿Por qué es importante que las comunidades costeras conozcan y practiquen protocolos de evacuación frente a riesgos naturales, como los tsunamis?', '["Porque una respuesta rápida y organizada puede reducir significativamente el riesgo para las personas","Porque practicar estos protocolos no aporta ningún beneficio a la comunidad","Porque los riesgos naturales nunca pueden mitigarse de ninguna forma","Porque solo las autoridades deberían conocer estos protocolos"]', 0, 'Es importante que las comunidades costeras conozcan y practiquen protocolos de evacuación porque una respuesta rápida y organizada puede reducir significativamente el riesgo para las personas.', 'intermedia', 35),
  ('Una comuna costera realiza simulacros anuales de evacuación por tsunami, instala señalética clara de rutas de evacuación y educa a la población sobre cómo reconocer las señales de alerta natural, como un fuerte sismo seguido de un retiro repentino del mar. ¿Qué principio de prevención de riesgos naturales aplica esta comuna?', '["Prepararse anticipadamente y educar a la población frente a un riesgo natural conocido de su territorio","Ignorar por completo los riesgos naturales de su territorio","Actuar únicamente después de ocurrido un tsunami, sin ninguna preparación previa","Confiar en que un tsunami nunca podría ocurrir en su territorio"]', 0, 'Esta comuna aplica el principio de prepararse anticipadamente y educar a la población frente a un riesgo natural conocido de su territorio.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_7_basico' and lo.short_name = 'Riesgos naturales y su prevención'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa usar un recurso natural de forma sustentable?', '["Usarlo de manera que se mantenga disponible para las generaciones futuras","Usarlo sin ningún límite hasta agotarlo por completo","Ignorar por completo cualquier consecuencia futura de su uso","Evitar completamente cualquier uso del recurso, sin ninguna excepción"]', 0, 'Usar un recurso natural de forma sustentable significa usarlo de manera que se mantenga disponible para las generaciones futuras.', 'inicial', 20),
  ('¿Cuál de estas prácticas refleja un uso sustentable de los recursos forestales de Chile?', '["La reforestación planificada tras la explotación de un bosque","La tala sin ningún plan de reforestación posterior","La quema descontrolada de bosques nativos","La extracción de madera sin ningún límite ni control"]', 0, 'La reforestación planificada tras la explotación de un bosque refleja un uso sustentable de los recursos forestales.', 'intermedia', 30),
  ('¿Por qué se considera importante evaluar la sustentabilidad al usar recursos naturales, como el agua o los bosques, en Chile?', '["Porque un uso no sustentable puede agotar los recursos y afectar a las futuras generaciones","Porque la sustentabilidad no tiene ninguna relación con los recursos naturales","Porque los recursos naturales siempre estarán disponibles sin ningún límite","Porque evaluar la sustentabilidad dificulta el uso de los recursos naturales"]', 0, 'Es importante evaluar la sustentabilidad porque un uso no sustentable puede agotar los recursos y afectar a las futuras generaciones.', 'intermedia', 35),
  ('Un estudiante investiga que, en una región de Chile, la extracción de un recurso pesquero se regula mediante cuotas basadas en estudios científicos sobre su capacidad de reproducción, mientras que en otra zona la sobreexplotación de un recurso similar llevó a su disminución drástica. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que evaluar la sustentabilidad en el uso de recursos naturales puede ayudar a evitar su agotamiento","Que la sustentabilidad no tiene ninguna relación con la disponibilidad futura de un recurso","Que todos los recursos naturales se comportan exactamente igual, sin importar cómo se usen","Que la sobreexplotación de un recurso nunca tiene ninguna consecuencia"]', 0, 'Esta comparación es consistente con la idea de que evaluar la sustentabilidad en el uso de recursos naturales puede ayudar a evitar su agotamiento.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_7_basico' and lo.short_name = 'Recursos naturales y sustentabilidad'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es un sistema de información geográfica (SIG) simple?', '["Una herramienta que permite visualizar, organizar y analizar datos ubicados en un territorio","Un sistema que no tiene ninguna relación con el territorio","Un tipo de calendario para organizar fechas importantes","Un instrumento musical usado en distintas culturas"]', 0, 'Un sistema de información geográfica (SIG) simple es una herramienta que permite visualizar, organizar y analizar datos ubicados en un territorio.', 'inicial', 20),
  ('¿Cuál de estos es un ejemplo de uso de un sistema de información geográfica simple para analizar un problema territorial?', '["Superponer en un mapa digital datos sobre riesgo de inundación y ubicación de viviendas","Usar una calculadora para sumar números sin relación con el territorio","Ignorar cualquier dato geográfico disponible sobre un problema","Usar un diccionario para definir una palabra sin relación con mapas"]', 0, 'Superponer en un mapa digital datos sobre riesgo de inundación y ubicación de viviendas es un ejemplo de uso de un sistema de información geográfica simple.', 'intermedia', 30),
  ('¿Por qué son útiles los sistemas de información geográfica para analizar problemas territoriales, como la distribución de un riesgo natural?', '["Porque permiten visualizar y relacionar distintos tipos de datos geográficos de forma más clara","Porque estos sistemas no aportan ninguna información útil para el análisis territorial","Porque reemplazan por completo la necesidad de conocer el territorio real","Porque solo sirven para fines decorativos, sin ningún propósito analítico"]', 0, 'Los sistemas de información geográfica son útiles porque permiten visualizar y relacionar distintos tipos de datos geográficos de forma más clara.', 'intermedia', 35),
  ('Un estudiante utiliza un sistema de información geográfica simple para superponer, en un mismo mapa, la ubicación de escuelas y la densidad de población de una comuna, y a partir de esto identifica una zona con alta población pero pocas escuelas cercanas. ¿Qué habilidad está aplicando el estudiante?', '["Utilizar sistemas de información geográfica simples para analizar un problema territorial","Ignorar la información geográfica disponible sobre la comuna","Inventar datos sin relación con el territorio real","Describir un hecho histórico sin relación con el territorio"]', 0, 'El estudiante está aplicando la habilidad de utilizar sistemas de información geográfica simples para analizar un problema territorial.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_7_basico' and lo.short_name = 'Uso de sistemas de información geográfica'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 7° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa que los derechos humanos sean "universales"?', '["Que corresponden a todas las personas, sin importar su nacionalidad, género o condición social","Que solo corresponden a las personas de un país determinado","Que corresponden únicamente a un grupo reducido de personas","Que pueden ser eliminados libremente por cualquier gobierno"]', 0, 'Que los derechos humanos sean universales significa que corresponden a todas las personas, sin importar su nacionalidad, género o condición social.', 'inicial', 20),
  ('¿Por qué se considera relevante la universalidad de los derechos humanos para la convivencia social?', '["Porque establece que la dignidad de todas las personas debe ser respetada por igual","Porque implica que solo algunas personas merecen respeto","Porque la universalidad no tiene ninguna relación con la convivencia social","Porque permite que un grupo tenga más derechos que otro"]', 0, 'La universalidad de los derechos humanos es relevante porque establece que la dignidad de todas las personas debe ser respetada por igual.', 'intermedia', 30),
  ('¿Cuál de estas situaciones refleja el principio de universalidad de los derechos humanos?', '["Reconocer el derecho a la educación tanto para niños de un país como de otro, sin distinción","Reconocer un derecho solo para las personas de una nacionalidad determinada","Negar un derecho fundamental a un grupo específico de personas","Aplicar los derechos humanos únicamente en algunos países del mundo"]', 0, 'Reconocer el derecho a la educación tanto para niños de un país como de otro, sin distinción, refleja el principio de universalidad de los derechos humanos.', 'intermedia', 35),
  ('Un estudiante investiga que la Declaración Universal de los Derechos Humanos, adoptada por distintos países tras conflictos importantes en la historia mundial, reconoce derechos como la vida, la educación y la libertad de expresión para todas las personas, sin importar su origen. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la universalidad es un principio central de los derechos humanos, reconocido por numerosos países del mundo","Que los derechos humanos solo aplican en el país donde fueron declarados por primera vez","Que la universalidad de los derechos humanos no tiene ningún respaldo internacional","Que cada país puede definir libremente a quién aplican los derechos humanos"]', 0, 'Esta información es consistente con la idea de que la universalidad es un principio central de los derechos humanos, reconocido por numerosos países del mundo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_7_basico' and lo.short_name = 'Universalidad de los derechos humanos'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas situaciones es un ejemplo de discriminación que debería evitarse en la convivencia social?', '["Excluir a una persona de una oportunidad laboral por su origen étnico","Tratar a todas las personas con el mismo respeto, sin importar su origen","Incluir a personas de distintos orígenes en una misma actividad","Celebrar la diversidad cultural de una comunidad"]', 0, 'Excluir a una persona de una oportunidad laboral por su origen étnico es un ejemplo de discriminación que debería evitarse.', 'inicial', 20),
  ('¿Por qué es importante analizar situaciones de discriminación y proponer formas de promover la no discriminación?', '["Porque permite identificar prácticas injustas y buscar soluciones para una convivencia más respetuosa","Porque la discriminación no tiene ninguna consecuencia negativa para las personas","Porque no es necesario abordar este tema en la convivencia social","Porque proponer soluciones frente a la discriminación no aporta ningún beneficio"]', 0, 'Es importante analizar situaciones de discriminación porque permite identificar prácticas injustas y buscar soluciones para una convivencia más respetuosa.', 'intermedia', 30),
  ('¿Cuál de estas es una acción concreta que puede promover la no discriminación en una comunidad escolar?', '["Implementar protocolos claros contra el acoso escolar por origen, género u otras características","Ignorar cualquier situación de discriminación que ocurra en la escuela","Permitir la exclusión de estudiantes con características distintas a la mayoría","Evitar hablar sobre la diversidad presente en la escuela"]', 0, 'Implementar protocolos claros contra el acoso escolar por origen, género u otras características es una acción concreta que puede promover la no discriminación.', 'intermedia', 35),
  ('Un curso analiza un caso real de discriminación laboral ocurrido en su comunidad, identifica las causas y consecuencias de esa situación, y propone, como grupo, difundir información sobre los derechos laborales y la importancia de la no discriminación. ¿Qué habilidad están practicando los estudiantes?', '["Analizar situaciones de discriminación y proponer formas de promover la no discriminación","Ignorar por completo un caso de discriminación","Justificar una práctica discriminatoria observada en la comunidad","Evitar cualquier análisis sobre temas de convivencia social"]', 0, 'Los estudiantes están practicando la habilidad de analizar situaciones de discriminación y proponer formas de promover la no discriminación.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_7_basico' and lo.short_name = 'Diversidad y no discriminación'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es uno de los tres poderes del Estado en Chile?', '["El Poder Legislativo","El poder de una empresa privada","El poder de un club deportivo","El poder de una organización internacional sin representación en Chile"]', 0, 'El Poder Legislativo es uno de los tres poderes del Estado en Chile.', 'inicial', 20),
  ('¿Cuál es la función principal del Poder Legislativo en Chile, ejercida por el Congreso Nacional?', '["Elaborar, discutir y aprobar leyes para el país","Gobernar directamente el país","Juzgar los conflictos legales del país","Administrar las municipalidades del país"]', 0, 'Elaborar, discutir y aprobar leyes para el país es la función principal del Poder Legislativo en Chile, ejercida por el Congreso Nacional.', 'intermedia', 30),
  ('¿Por qué se considera importante que los tres poderes del Estado en Chile funcionen de manera independiente entre sí?', '["Porque ayuda a evitar que una sola autoridad concentre un poder excesivo sobre el país","Porque los tres poderes deberían depender completamente uno del otro","Porque la independencia entre poderes no aporta ningún beneficio al funcionamiento del Estado","Porque un solo poder debería controlar completamente a los otros dos"]', 0, 'Es importante que los tres poderes funcionen de manera independiente porque ayuda a evitar que una sola autoridad concentre un poder excesivo sobre el país.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, el Congreso Nacional aprueba una ley, el Presidente de la República y su gobierno la implementan a través de distintos ministerios, y los tribunales de justicia resuelven los conflictos derivados de su aplicación. ¿Qué idea general sobre la organización política de Chile refleja esta información?', '["Que los tres poderes del Estado cumplen funciones distintas pero complementarias en el funcionamiento del país","Que un solo poder del Estado concentra todas las funciones necesarias para gobernar","Que los poderes del Estado en Chile no tienen ninguna relación entre sí","Que las leyes se aplican en Chile sin ninguna intervención de los poderes del Estado"]', 0, 'Esta información refleja que los tres poderes del Estado cumplen funciones distintas pero complementarias en el funcionamiento del país.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_7_basico' and lo.short_name = 'Organización política de Chile: poderes del Estado'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 7° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma de participación estudiantil disponible en muchos colegios de Chile?', '["El Centro de Estudiantes","La decisión unilateral de un solo estudiante sobre todo el colegio","La prohibición de que los estudiantes se organicen","La exclusión de los estudiantes de cualquier decisión escolar"]', 0, 'El Centro de Estudiantes es una forma de participación estudiantil disponible en muchos colegios de Chile.', 'inicial', 20),
  ('¿Cuál de estas es una forma de participación comunitaria disponible para adolescentes fuera del contexto escolar?', '["Integrarse a una organización juvenil o social de su comunidad","No participar nunca en ninguna actividad de su comunidad","Impedir que otros adolescentes participen en su comunidad","Ignorar por completo las necesidades de su comunidad"]', 0, 'Integrarse a una organización juvenil o social de su comunidad es una forma de participación comunitaria disponible para adolescentes.', 'intermedia', 30),
  ('¿Por qué se considera valioso evaluar las distintas formas de participación estudiantil y comunitaria disponibles para los adolescentes?', '["Porque permite identificar oportunidades concretas para que los adolescentes se involucren en decisiones que los afectan","Porque la participación de los adolescentes no tiene ninguna relevancia social","Porque los adolescentes no deberían participar en ninguna organización","Porque evaluar estas formas de participación no aporta ningún beneficio"]', 0, 'Es valioso evaluar las distintas formas de participación disponibles porque permite identificar oportunidades concretas para que los adolescentes se involucren en decisiones que los afectan.', 'intermedia', 35),
  ('Un grupo de estudiantes, integrantes del Centro de Estudiantes de su colegio, organiza una consulta para conocer la opinión de sus compañeros sobre un cambio en el reglamento escolar, y luego presenta una propuesta fundamentada a la dirección del colegio. ¿Qué principio de participación estudiantil se refleja en esta situación?', '["La organización estudiantil para representar la opinión de sus compañeros y proponer cambios ante la autoridad escolar","La imposición de una decisión sin ninguna consulta a los demás estudiantes","La ausencia total de participación estudiantil en el colegio","La imposibilidad de que los estudiantes influyan en decisiones escolares"]', 0, 'Esta situación refleja el principio de organización estudiantil para representar la opinión de sus compañeros y proponer cambios ante la autoridad escolar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_7_basico' and lo.short_name = 'Participación estudiantil y comunitaria'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
