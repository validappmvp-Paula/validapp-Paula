-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 2° Medio. Cubre los 12 objetivos de
-- aprendizaje de 2° Medio cargados por
-- supabase/seed/0022_curriculum_historia_regular_7basico_2medio.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'.
--
-- ============================================================================
-- NOTA PEDAGÓGICA CRÍTICA: RÉGIMEN MILITAR (1973-1990) Y DERECHOS HUMANOS
-- ============================================================================
-- Este es el archivo con mayor sensibilidad histórica y política de toda la
-- serie de Historia. Incluye los objetivos "Régimen militar y transición a
-- la democracia" y "Derechos humanos y memoria histórica", que tratan el
-- golpe de Estado del 11 de septiembre de 1973, el gobierno militar
-- encabezado por Augusto Pinochet (1973-1990), el plebiscito de 1988 y el
-- retorno a la democracia en 1990.
--
-- Criterio aplicado en la redacción de todas las preguntas de este archivo:
--   1. Se presentan como HECHOS los datos ampliamente documentados y sin
--      controversia historiográfica: fechas, actores institucionales,
--      resultado del plebiscito de 1988, fin del régimen militar en 1990.
--   2. Las violaciones a los derechos humanos ocurridas durante el régimen
--      militar (detenciones arbitrarias, tortura, ejecuciones y
--      desapariciones forzadas) se presentan como hechos documentados
--      oficialmente por comisiones de verdad del propio Estado chileno
--      (Informe Rettig, 1991, e Informe Valech, 2004/2011), no como una
--      opinión política de este agente ni de ValidApp. Citar estos hechos
--      no constituye sesgo: es el registro oficial reconocido por sucesivos
--      gobiernos democráticos de distinto signo político.
--   3. No se atribuye responsabilidad penal individual a ninguna persona
--      viva ni se emiten juicios de valor sobre actores políticos actuales
--      ni sobre partidos o coaliciones vigentes.
--   4. No se toma partido sobre interpretaciones historiográficas en
--      disputa (por ejemplo, las causas profundas o el balance completo del
--      período) más allá de lo documentado oficialmente.
--   5. Se evita lenguaje emotivo, adjetivos valorativos o comparaciones que
--      pudieran leerse como propaganda de cualquier signo.
-- Dado el nivel de sensibilidad, se recomienda ENFÁTICAMENTE una revisión
-- pedagógica humana adicional y especializada de este archivo específico
-- antes de cualquier aprobación, más allá de la revisión estándar que
-- aplica al resto del banco de preguntas.

-- ============================================================================
-- EJE: HISTORIA — 2° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas fue una característica del período conocido como parlamentarismo en Chile (fines del siglo XIX e inicios del XX)?', '["El Congreso Nacional concentraba una influencia política muy fuerte frente al Presidente de la República","El Presidente de la República tenía un poder absoluto, sin ningún Congreso","No existía ningún tipo de Congreso ni Presidente en Chile","El país era gobernado por un monarca"]', 0, 'Durante el período parlamentarista, el Congreso Nacional concentraba una influencia política muy fuerte frente al Presidente de la República.', 'inicial', 20),
  ('¿Cuál de estos fue un factor asociado a la crisis del sistema parlamentario en Chile?', '["La inestabilidad política, con numerosos cambios de gabinete y dificultades para gobernar","Una estabilidad política absoluta sin ningún conflicto","La ausencia total de cualquier tipo de gobierno","Un acuerdo permanente entre todos los sectores políticos, sin ninguna disputa"]', 0, 'La inestabilidad política, con numerosos cambios de gabinete y dificultades para gobernar, fue un factor asociado a la crisis del sistema parlamentario.', 'intermedia', 30),
  ('¿Qué cambio institucional se asocia con el fin del parlamentarismo y el inicio de un régimen con mayor poder presidencial en Chile, hacia 1925?', '["La promulgación de una nueva Constitución que fortaleció las atribuciones del Presidente de la República","La eliminación completa del cargo de Presidente","La creación de una monarquía en Chile","La anulación de cualquier tipo de Constitución"]', 0, 'La promulgación de una nueva Constitución en 1925, que fortaleció las atribuciones del Presidente de la República, se asocia con el fin del parlamentarismo.', 'intermedia', 35),
  ('Un estudiante investiga que, durante el período parlamentarista, la inestabilidad de los gabinetes ministeriales dificultó la implementación de políticas de largo plazo, lo que llevó a un proceso de reforma que fortaleció el rol del Presidente de la República a partir de 1925. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la crisis del parlamentarismo estuvo relacionada con problemas de gobernabilidad que impulsaron una reforma hacia un régimen presidencial más fuerte","Que el parlamentarismo no tuvo ninguna dificultad de gobernabilidad","Que el régimen presidencial se estableció sin ninguna relación con la crisis previa","Que Chile nunca tuvo un período de mayor influencia del Congreso frente al Presidente"]', 0, 'Esta información es consistente con la idea de que la crisis del parlamentarismo estuvo relacionada con problemas de gobernabilidad que impulsaron una reforma hacia un régimen presidencial más fuerte.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_2_medio' and lo.short_name = 'Crisis del parlamentarismo y régimen presidencial'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Qué fue la Guerra Fría?', '["Un período de tensión política, ideológica y militar entre Estados Unidos y la Unión Soviética, tras la Segunda Guerra Mundial","Un conflicto bélico directo entre Chile y otro país sudamericano","Un período de paz absoluta entre todos los países del mundo","Un tipo de clima extremadamente frío en varios continentes"]', 0, 'La Guerra Fría fue un período de tensión política, ideológica y militar entre Estados Unidos y la Unión Soviética, tras la Segunda Guerra Mundial.', 'inicial', 20),
  ('¿Cuál de estos elementos caracterizó la confrontación de la Guerra Fría a nivel mundial?', '["La existencia de dos bloques con modelos políticos y económicos distintos (capitalismo y comunismo)","La ausencia total de cualquier diferencia ideológica entre países","Un conflicto armado directo y permanente entre Estados Unidos y la Unión Soviética","La desaparición de cualquier país aliado de una de las dos potencias"]', 0, 'La existencia de dos bloques con modelos políticos y económicos distintos (capitalismo y comunismo) caracterizó la confrontación de la Guerra Fría.', 'intermedia', 30),
  ('¿De qué manera la Guerra Fría influyó en el contexto político de América Latina, incluido Chile, durante la segunda mitad del siglo XX?', '["Generó una fuerte polarización política interna, con sectores identificados con distintos modelos políticos y económicos en pugna a nivel mundial","No tuvo ninguna influencia en la política de los países latinoamericanos","Eliminó por completo cualquier diferencia política dentro de los países de la región","Unificó a todos los países de América Latina bajo una misma postura política"]', 0, 'La Guerra Fría generó una fuerte polarización política interna en distintos países de América Latina, incluido Chile, con sectores identificados con distintos modelos en pugna a nivel mundial.', 'intermedia', 35),
  ('Un estudiante investiga que, durante la Guerra Fría, tanto Estados Unidos como la Unión Soviética buscaron influir en los procesos políticos de distintos países del mundo, incluidos países de América Latina, en un contexto de fuerte polarización ideológica que también se expresó en la política interna de Chile durante esas décadas. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el contexto internacional de la Guerra Fría influyó en la polarización política que se vivió en Chile y en otros países de la región","Que la Guerra Fría no tuvo ninguna relación con la política interna de los países latinoamericanos","Que Chile estuvo completamente aislado del contexto internacional durante la Guerra Fría","Que la polarización política en Chile no tuvo relación con ningún factor internacional"]', 0, 'Esta información es consistente con la idea de que el contexto internacional de la Guerra Fría influyó en la polarización política que se vivió en Chile y en otros países de la región.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_2_medio' and lo.short_name = 'Guerra Fría y su impacto en Chile y el mundo'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿En qué fecha ocurrió el golpe de Estado que puso fin al gobierno del presidente Salvador Allende e inició un régimen militar en Chile?', '["El 11 de septiembre de 1973","El 18 de septiembre de 1810","El 5 de octubre de 1988","El 11 de marzo de 1990"]', 0, 'El golpe de Estado que puso fin al gobierno del presidente Salvador Allende ocurrió el 11 de septiembre de 1973, dando inicio a un régimen militar encabezado por una junta y, posteriormente, por Augusto Pinochet.', 'inicial', 25),
  ('Según los informes oficiales de comisiones de verdad creadas por el propio Estado chileno tras el retorno a la democracia (como el Informe Rettig de 1991 y el Informe Valech de 2004), ¿qué documentaron respecto del régimen militar (1973-1990)?', '["La ocurrencia de violaciones graves y sistemáticas a los derechos humanos, incluyendo detenciones arbitrarias, tortura y desapariciones forzadas","La ausencia total de cualquier violación a los derechos humanos durante ese período","Un aumento generalizado e ininterrumpido del bienestar de toda la población, sin ninguna excepción","La imposibilidad de investigar ningún hecho ocurrido entre 1973 y 1990"]', 0, 'Los informes oficiales de comisiones de verdad creadas por el Estado chileno (Rettig, 1991; Valech, 2004) documentaron violaciones graves y sistemáticas a los derechos humanos durante el régimen militar, incluyendo detenciones arbitrarias, tortura y desapariciones forzadas.', 'intermedia', 40),
  ('¿Qué ocurrió en el plebiscito realizado en Chile el 5 de octubre de 1988?', '["La ciudadanía votó mayoritariamente por la opción \"No\", lo que abrió paso a un llamado a elecciones y al fin del régimen militar","La ciudadanía votó por prolongar indefinidamente el régimen militar sin ninguna elección posterior","No se realizó ninguna votación en esa fecha","El resultado del plebiscito fue anulado y no tuvo ninguna consecuencia política"]', 0, 'En el plebiscito del 5 de octubre de 1988, la ciudadanía votó mayoritariamente por la opción "No", lo que abrió paso a un llamado a elecciones presidenciales y al fin del régimen militar.', 'intermedia', 35),
  ('Un estudiante investiga que, tras el plebiscito de 1988, se realizaron elecciones presidenciales y parlamentarias en 1989, y que en marzo de 1990 asumió un gobierno democráticamente electo, iniciando lo que se conoce como el proceso de transición a la democracia, en el marco del cual también comenzaron procesos de investigación sobre las violaciones a los derechos humanos ocurridas durante el régimen militar. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el retorno a la democracia en Chile fue un proceso institucional que incluyó elecciones y el inicio de procesos de verdad sobre hechos ocurridos durante el régimen militar","Que la transición a la democracia ocurrió sin ninguna elección posterior al plebiscito de 1988","Que no se investigó ningún hecho relacionado con derechos humanos tras el retorno a la democracia","Que el régimen militar continuó gobernando el país después de 1990"]', 0, 'Esta información es consistente con la idea de que el retorno a la democracia en Chile fue un proceso institucional que incluyó elecciones y el inicio de procesos de verdad sobre hechos ocurridos durante el régimen militar.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_2_medio' and lo.short_name = 'Régimen militar y transición a la democracia'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se entiende por "memoria histórica" en relación con procesos recientes, como el régimen militar en Chile?', '["El conjunto de esfuerzos por recordar, documentar y transmitir hechos relevantes del pasado reciente, especialmente sobre violaciones a los derechos humanos","Un ejercicio sin ninguna relación con hechos documentados","Una opinión personal sin ninguna base en evidencia","Un concepto que no tiene relación con la historia de un país"]', 0, 'La memoria histórica se refiere al conjunto de esfuerzos por recordar, documentar y transmitir hechos relevantes del pasado reciente, especialmente sobre violaciones a los derechos humanos.', 'inicial', 20),
  ('¿Cuál de estas es una fuente contemporánea útil para estudiar el régimen militar y la transición a la democracia en Chile?', '["Los informes oficiales de comisiones de verdad, como el Informe Rettig o el Informe Valech","Una opinión sin ninguna base documental","Un relato inventado sin ninguna relación con hechos reales","Una predicción sobre el futuro"]', 0, 'Los informes oficiales de comisiones de verdad, como el Informe Rettig o el Informe Valech, son una fuente contemporánea útil para estudiar este período.', 'intermedia', 30),
  ('¿Por qué es importante usar fuentes documentadas y contrastadas, como informes oficiales, al estudiar un período históricamente sensible, como el régimen militar en Chile?', '["Porque permite fundamentar una comprensión rigurosa del período, basada en hechos verificados y no en opiniones no sustentadas","Porque cualquier fuente, sin importar su origen, siempre es igualmente confiable","Porque no es necesario usar ninguna fuente documentada para estudiar este período","Porque las fuentes oficiales nunca aportan información relevante sobre procesos históricos"]', 0, 'Es importante usar fuentes documentadas y contrastadas porque permite fundamentar una comprensión rigurosa del período, basada en hechos verificados.', 'intermedia', 35),
  ('Un estudiante investiga el período del régimen militar y la transición a la democracia utilizando como fuentes el Informe Rettig, testimonios recopilados en el Informe Valech, y registros oficiales sobre el plebiscito de 1988, evitando basarse únicamente en opiniones no verificadas. ¿Qué habilidad está aplicando el estudiante?', '["Analizar un proceso de la historia reciente de Chile a partir de fuentes contemporáneas documentadas y ejercicios de memoria histórica","Inventar información sobre este período sin ninguna base documental","Ignorar cualquier fuente oficial disponible sobre el tema","Basar su análisis exclusivamente en opiniones personales sin ninguna evidencia"]', 0, 'El estudiante está aplicando la habilidad de analizar un proceso de la historia reciente de Chile a partir de fuentes contemporáneas documentadas y ejercicios de memoria histórica.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_2_medio' and lo.short_name = 'Uso de memoria histórica y fuentes contemporáneas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 2° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un organismo internacional relevante en la geopolítica mundial actual?', '["La Organización de las Naciones Unidas (ONU)","Una empresa privada de un solo país","Un club deportivo internacional","Una universidad de un país específico"]', 0, 'La Organización de las Naciones Unidas (ONU) es un organismo internacional relevante en la geopolítica mundial actual.', 'inicial', 20),
  ('¿Cuál es una función habitual de los organismos internacionales, como la ONU, en el escenario geopolítico mundial?', '["Promover la cooperación entre países y mediar en conflictos internacionales","Eliminar por completo la soberanía de todos los países del mundo","Imponer un único sistema político a todos los países","No tener ninguna función relacionada con la política internacional"]', 0, 'Promover la cooperación entre países y mediar en conflictos internacionales es una función habitual de organismos internacionales como la ONU.', 'intermedia', 30),
  ('¿Por qué se considera relevante estudiar la geopolítica mundial y el rol de organismos internacionales en la actualidad?', '["Porque ayuda a comprender cómo se relacionan los países y cómo se abordan problemas globales","Porque la geopolítica mundial no tiene ninguna relación con los problemas actuales","Porque los organismos internacionales no cumplen ninguna función relevante","Porque los países del mundo no tienen ninguna relación entre sí"]', 0, 'Estudiar la geopolítica mundial es relevante porque ayuda a comprender cómo se relacionan los países y cómo se abordan problemas globales.', 'intermedia', 35),
  ('Un estudiante investiga que, frente a un conflicto internacional reciente, distintos países han recurrido a organismos como la ONU para buscar mediación y acuerdos, mientras que también existen alianzas regionales que influyen en las decisiones geopolíticas de sus países miembros. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los organismos internacionales y las alianzas regionales cumplen un rol relevante en la geopolítica mundial actual","Que los organismos internacionales no tienen ninguna influencia en los conflictos mundiales","Que los países del mundo actúan siempre de forma aislada, sin ninguna alianza ni organismo internacional","Que la geopolítica mundial no tiene relación con ningún organismo internacional"]', 0, 'Esta información es consistente con la idea de que los organismos internacionales y las alianzas regionales cumplen un rol relevante en la geopolítica mundial actual.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_2_medio' and lo.short_name = 'Geopolítica mundial y organismos internacionales'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un indicador de desarrollo socioeconómico utilizado para comparar países?', '["El Índice de Desarrollo Humano (IDH)","El color de la bandera de un país","El nombre oficial de un país","El clima predominante de un país"]', 0, 'El Índice de Desarrollo Humano (IDH) es un indicador de desarrollo socioeconómico utilizado para comparar países.', 'inicial', 20),
  ('¿Qué dimensiones suele considerar un indicador como el Índice de Desarrollo Humano al comparar países?', '["Esperanza de vida, nivel educativo e ingreso per cápita","Únicamente el tamaño del territorio de un país","Únicamente el número de ciudades de un país","Únicamente el idioma oficial de un país"]', 0, 'El Índice de Desarrollo Humano suele considerar dimensiones como la esperanza de vida, el nivel educativo y el ingreso per cápita.', 'intermedia', 30),
  ('¿Por qué es útil comparar países usando indicadores de desarrollo socioeconómico, y no solo su tamaño territorial o población?', '["Porque permite comprender mejor la calidad de vida y las condiciones de bienestar de sus habitantes","Porque el tamaño territorial siempre refleja exactamente el nivel de desarrollo de un país","Porque estos indicadores no aportan ninguna información relevante sobre un país","Porque comparar países mediante indicadores dificulta la comprensión de su realidad"]', 0, 'Comparar países usando indicadores de desarrollo socioeconómico es útil porque permite comprender mejor la calidad de vida y las condiciones de bienestar de sus habitantes.', 'intermedia', 35),
  ('Un estudiante compara el Índice de Desarrollo Humano de distintos países, notando que dos países con un territorio de tamaño similar pueden tener niveles de desarrollo socioeconómico muy diferentes, debido a diferencias en esperanza de vida, educación e ingreso. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que el desarrollo socioeconómico de un país no depende únicamente de su tamaño territorial","Que el tamaño territorial de un país siempre determina su nivel de desarrollo socioeconómico","Que todos los países del mundo tienen exactamente el mismo nivel de desarrollo","Que los indicadores de desarrollo socioeconómico no tienen ninguna relación con la calidad de vida"]', 0, 'Esta comparación es consistente con la idea de que el desarrollo socioeconómico de un país no depende únicamente de su tamaño territorial.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_2_medio' and lo.short_name = 'Indicadores de desarrollo socioeconómico'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un ejemplo de globalización cultural?', '["La difusión de música, películas o series de un país en distintas partes del mundo, gracias a plataformas digitales","La eliminación total de cualquier intercambio cultural entre países","El aislamiento absoluto de un país respecto del resto del mundo","La desaparición completa de las culturas locales"]', 0, 'La difusión de música, películas o series de un país en distintas partes del mundo, gracias a plataformas digitales, es un ejemplo de globalización cultural.', 'inicial', 20),
  ('¿Cuál de estos es un ejemplo de globalización económica?', '["El comercio de productos entre empresas de distintos países mediante acuerdos comerciales","La eliminación total de cualquier tipo de comercio internacional","El aislamiento económico absoluto de todos los países del mundo","La desaparición completa de las economías nacionales"]', 0, 'El comercio de productos entre empresas de distintos países mediante acuerdos comerciales es un ejemplo de globalización económica.', 'intermedia', 30),
  ('¿Por qué la globalización cultural y económica puede generar tanto beneficios como desafíos para distintas sociedades?', '["Porque puede aumentar el intercambio y el acceso a bienes y culturas, pero también generar tensiones respecto de identidades locales o desigualdades económicas","Porque la globalización nunca genera ningún tipo de beneficio","Porque la globalización nunca genera ningún tipo de desafío","Porque la globalización no tiene ninguna relación con la cultura ni la economía de un país"]', 0, 'La globalización puede aumentar el intercambio y el acceso a bienes y culturas, pero también generar tensiones respecto de identidades locales o desigualdades económicas.', 'intermedia', 35),
  ('Un estudiante investiga que, gracias a la globalización, muchas personas en distintos países pueden acceder a productos, música y contenidos culturales de otras partes del mundo, pero que este proceso también ha generado debates sobre la preservación de identidades culturales locales y sobre desigualdades económicas entre países. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la globalización cultural y económica implica tanto oportunidades de intercambio como desafíos que distintas sociedades deben abordar","Que la globalización solo genera beneficios, sin ningún tipo de desafío","Que la globalización solo genera desafíos, sin ningún tipo de beneficio","Que la globalización no tiene ninguna relación con el intercambio cultural entre países"]', 0, 'Esta información es consistente con la idea de que la globalización cultural y económica implica tanto oportunidades de intercambio como desafíos que distintas sociedades deben abordar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_2_medio' and lo.short_name = 'Globalización cultural y económica'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un problema territorial de escala global?', '["El aumento del nivel del mar debido al cambio climático","El nombre de una calle específica de una ciudad","El color de la bandera de un país","El menú de un restaurante local"]', 0, 'El aumento del nivel del mar debido al cambio climático es un problema territorial de escala global.', 'inicial', 20),
  ('¿Cuál de estos es un ejemplo de desigualdad territorial a escala global?', '["Las diferencias en el acceso a agua potable y saneamiento entre distintas regiones del mundo","La existencia de un único idioma hablado en todo el mundo","La ausencia total de cualquier diferencia entre países","La existencia de un único tipo de clima en todo el planeta"]', 0, 'Las diferencias en el acceso a agua potable y saneamiento entre distintas regiones del mundo son un ejemplo de desigualdad territorial a escala global.', 'intermedia', 30),
  ('¿Por qué se considera que problemas como el cambio climático o la desigualdad territorial requieren de una cooperación internacional para abordarse?', '["Porque sus causas y consecuencias trascienden las fronteras de un solo país","Porque estos problemas solo afectan a un único país del mundo","Porque no existe ninguna forma de cooperación entre países para abordar estos problemas","Porque estos problemas no tienen ninguna relación con el territorio de los países"]', 0, 'Problemas como el cambio climático o la desigualdad territorial requieren cooperación internacional porque sus causas y consecuencias trascienden las fronteras de un solo país.', 'intermedia', 35),
  ('Un estudiante investiga que el aumento del nivel del mar, producto del cambio climático, amenaza a distintas zonas costeras del mundo, incluidas algunas comunidades insulares, y que distintos países han impulsado acuerdos internacionales para reducir las emisiones de gases de efecto invernadero. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los problemas territoriales de escala global, como el cambio climático, requieren respuestas coordinadas entre distintos países","Que el cambio climático no tiene ninguna relación con el territorio de los países","Que este problema solo afecta a un único país del mundo","Que no existe ningún acuerdo internacional relacionado con el cambio climático"]', 0, 'Esta información es consistente con la idea de que los problemas territoriales de escala global, como el cambio climático, requieren respuestas coordinadas entre distintos países.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_2_medio' and lo.short_name = 'Problemas territoriales de escala global'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 2° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un elemento del sistema político chileno actual?', '["Un sistema presidencial, con elecciones periódicas para elegir al Presidente de la República y al Congreso Nacional","Un sistema monárquico, sin ninguna elección","La ausencia total de un Congreso Nacional","Un sistema sin ninguna Constitución vigente"]', 0, 'Un sistema presidencial, con elecciones periódicas para elegir al Presidente de la República y al Congreso Nacional, es un elemento del sistema político chileno actual.', 'inicial', 20),
  ('¿Cuál es la función principal del Congreso Nacional dentro del sistema político chileno actual?', '["Elaborar, discutir y aprobar leyes, además de fiscalizar al gobierno","Gobernar directamente el país sin ninguna relación con el Presidente","Reemplazar completamente al Poder Judicial","No tener ninguna función dentro del sistema político actual"]', 0, 'La función principal del Congreso Nacional es elaborar, discutir y aprobar leyes, además de fiscalizar al gobierno.', 'intermedia', 30),
  ('¿Por qué se considera relevante que los ciudadanos comprendan el funcionamiento del sistema político chileno actual?', '["Porque les permite participar de forma más informada en la vida democrática del país","Porque comprender el sistema político no tiene ninguna relación con la participación ciudadana","Porque solo las autoridades necesitan comprender el sistema político del país","Porque el sistema político chileno no tiene ninguna relación con la vida de los ciudadanos"]', 0, 'Es relevante que los ciudadanos comprendan el sistema político porque les permite participar de forma más informada en la vida democrática del país.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, el sistema político actual contempla la elección periódica del Presidente de la República y de los miembros del Congreso Nacional, la existencia de tribunales independientes y mecanismos de fiscalización del uso de recursos públicos. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el sistema político chileno actual se organiza en torno a elecciones periódicas, separación de poderes y mecanismos de fiscalización","Que el sistema político chileno actual no contempla ninguna elección periódica","Que en Chile no existe ningún mecanismo de fiscalización del uso de recursos públicos","Que el Poder Judicial en Chile depende completamente del Presidente de la República"]', 0, 'Esta información es consistente con la idea de que el sistema político chileno actual se organiza en torno a elecciones periódicas, separación de poderes y mecanismos de fiscalización.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_2_medio' and lo.short_name = 'Sistema político chileno actual'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Por qué se considera importante la memoria histórica sobre violaciones a los derechos humanos ocurridas en el pasado reciente de un país?', '["Porque contribuye a que hechos graves documentados no se repitan y a reconocer a las víctimas","Porque la memoria histórica no tiene ninguna relación con los derechos humanos","Porque olvidar completamente el pasado siempre es preferible para una sociedad","Porque este tema no tiene ninguna relevancia para la democracia actual"]', 0, 'La memoria histórica sobre violaciones a los derechos humanos es importante porque contribuye a que hechos graves documentados no se repitan y a reconocer a las víctimas.', 'inicial', 25),
  ('¿Cuál de estos es un ejemplo de institución o mecanismo creado en Chile para documentar violaciones a los derechos humanos del pasado reciente?', '["Una comisión de verdad encargada de investigar y documentar estos hechos, como la que originó el Informe Rettig","Una institución dedicada exclusivamente al comercio internacional","Un organismo sin ninguna relación con los derechos humanos","Una entidad que solo administra impuestos"]', 0, 'Una comisión de verdad encargada de investigar y documentar estos hechos, como la que originó el Informe Rettig, es un ejemplo de mecanismo creado en Chile con este propósito.', 'intermedia', 35),
  ('¿Por qué se afirma que la protección de los derechos humanos es un valor fundamental para la democracia actual en Chile?', '["Porque una democracia se basa en el respeto a la dignidad y los derechos de todas las personas","Porque los derechos humanos no tienen ninguna relación con el funcionamiento de una democracia","Porque solo algunas personas deberían tener sus derechos humanos protegidos","Porque la protección de los derechos humanos es un tema irrelevante en la actualidad"]', 0, 'La protección de los derechos humanos es fundamental para la democracia porque esta se basa en el respeto a la dignidad y los derechos de todas las personas.', 'intermedia', 35),
  ('Un estudiante investiga que, desde el retorno a la democracia, el Estado chileno ha desarrollado comisiones de verdad, medidas de reparación para víctimas y espacios de memoria (como sitios conmemorativos) relacionados con las violaciones a los derechos humanos documentadas durante el régimen militar, con el objetivo de reconocer estos hechos y evitar que se repitan. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la fundamentación de la importancia de los derechos humanos y la memoria histórica se ha expresado en Chile mediante instituciones y políticas concretas de reconocimiento y reparación","Que el Estado chileno no ha desarrollado ninguna política relacionada con la memoria histórica","Que las violaciones a los derechos humanos durante el régimen militar no fueron documentadas por ninguna institución","Que las medidas de reparación no tienen ninguna relación con los derechos humanos"]', 0, 'Esta información es consistente con la idea de que la fundamentación de la importancia de los derechos humanos y la memoria histórica se ha expresado en Chile mediante instituciones y políticas concretas de reconocimiento y reparación.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_2_medio' and lo.short_name = 'Derechos humanos y memoria histórica'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es el rol habitual de los medios de comunicación en una democracia?', '["Informar a la ciudadanía y contribuir a la formación de la opinión pública","Reemplazar completamente a las autoridades electas","No tener ninguna relación con la participación ciudadana","Impedir que la ciudadanía se informe sobre temas públicos"]', 0, 'Informar a la ciudadanía y contribuir a la formación de la opinión pública es el rol habitual de los medios de comunicación en una democracia.', 'inicial', 20),
  ('¿Por qué se considera relevante que existan medios de comunicación diversos e independientes en una democracia?', '["Porque permiten que la ciudadanía acceda a distintas perspectivas antes de formarse una opinión","Porque tener medios de comunicación diversos dificulta la participación ciudadana","Porque un único medio de comunicación siempre es suficiente para informar a toda la ciudadanía","Porque los medios de comunicación no tienen ninguna relación con la opinión pública"]', 0, 'Es relevante que existan medios diversos e independientes porque permiten que la ciudadanía acceda a distintas perspectivas antes de formarse una opinión.', 'intermedia', 30),
  ('¿Cuál de estas es una forma en que los medios de comunicación pueden influir en la participación ciudadana?', '["Difundiendo información sobre temas públicos que motiven a la ciudadanía a involucrarse","Impidiendo por completo el acceso a cualquier información pública","Eliminando cualquier posibilidad de que la ciudadanía se informe","No teniendo ninguna relación con la participación ciudadana"]', 0, 'Difundir información sobre temas públicos que motiven a la ciudadanía a involucrarse es una forma en que los medios de comunicación pueden influir en la participación ciudadana.', 'intermedia', 35),
  ('Un estudiante investiga que, durante un debate público sobre un tema relevante para el país, distintos medios de comunicación entregaron información y análisis que ayudaron a la ciudadanía a formarse una opinión, mientras que las redes sociales también se transformaron en un espacio de participación y discusión ciudadana. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los medios de comunicación, junto con nuevas plataformas digitales, cumplen un rol relevante en la participación ciudadana actual","Que los medios de comunicación no tienen ninguna relación con la formación de opinión pública","Que las redes sociales no cumplen ningún rol en la participación ciudadana","Que solo un tipo de medio de comunicación puede influir en la opinión pública"]', 0, 'Esta información es consistente con la idea de que los medios de comunicación, junto con nuevas plataformas digitales, cumplen un rol relevante en la participación ciudadana actual.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_2_medio' and lo.short_name = 'Participación ciudadana y medios de comunicación'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 2° Medio, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica ESPECIALIZADA (ver nota crítica en el encabezado del archivo).',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un desafío frecuentemente mencionado respecto de la democracia chilena actual?', '["Los niveles de participación electoral en algunas elecciones","La ausencia total de cualquier tipo de elección en el país","La inexistencia de cualquier tipo de gobierno","La eliminación completa del Congreso Nacional"]', 0, 'Los niveles de participación electoral en algunas elecciones son un desafío frecuentemente mencionado respecto de la democracia chilena actual.', 'inicial', 20),
  ('¿Qué se entiende por "confianza institucional" al analizar los desafíos actuales de una democracia?', '["El grado en que la ciudadanía confía en instituciones públicas, como el Congreso o los tribunales","Un concepto sin ninguna relación con las instituciones públicas","La cantidad de dinero que administra una institución","El número de funcionarios que trabajan en una institución"]', 0, 'La confianza institucional se refiere al grado en que la ciudadanía confía en instituciones públicas, como el Congreso o los tribunales.', 'intermedia', 30),
  ('¿Por qué se considera relevante analizar desafíos como la participación electoral o la confianza institucional al estudiar la democracia actual?', '["Porque estos factores pueden influir en la legitimidad y el buen funcionamiento del sistema democrático","Porque estos desafíos no tienen ninguna relación con el funcionamiento de una democracia","Porque una democracia siempre funciona igual, sin importar estos factores","Porque analizar estos desafíos no aporta ningún beneficio a la sociedad"]', 0, 'Analizar estos desafíos es relevante porque pueden influir en la legitimidad y el buen funcionamiento del sistema democrático.', 'intermedia', 35),
  ('Un estudiante investiga que, en las últimas décadas, algunos análisis sobre la democracia chilena han señalado desafíos relacionados con la participación electoral, la confianza en instituciones públicas y la necesidad de fortalecer mecanismos de participación ciudadana más allá de las elecciones. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la democracia chilena actual enfrenta desafíos identificados que pueden analizarse para fortalecer su funcionamiento","Que la democracia chilena no enfrenta ningún desafío en la actualidad","Que la participación electoral no tiene ninguna relación con el funcionamiento de la democracia","Que la confianza institucional no es un tema relevante para analizar la democracia actual"]', 0, 'Esta información es consistente con la idea de que la democracia chilena actual enfrenta desafíos identificados que pueden analizarse para fortalecer su funcionamiento.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_2_medio' and lo.short_name = 'Desafíos actuales de la democracia'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
