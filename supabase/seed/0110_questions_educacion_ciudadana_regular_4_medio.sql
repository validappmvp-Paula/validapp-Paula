-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Educación
-- Ciudadana (Formación General, asignatura DISTINTA de Historia, Geografía y
-- Ciencias Sociales, ver decisión de modelado en el encabezado de
-- supabase/seed/0098_curriculum_educacion_ciudadana_regular_3_4medio.sql),
-- 4° Medio. Cubre los 16 objetivos de aprendizaje de 4° Medio cargados por
-- 0098 (4 ejes x 4 objetivos), con 4 preguntas por objetivo, total 64
-- preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'. IMPORTANTE: este
-- archivo usa `subject.name = 'Educación Ciudadana'` (canonical_code
-- 'civic_education'), NO 'Estudios Sociales'.
--
-- ============================================================================
-- NOTA PEDAGÓGICA CRÍTICA: MEMORIA HISTÓRICA Y DERECHOS HUMANOS EN CHILE
-- ============================================================================
-- Este archivo incluye el objetivo "Memoria histórica y derechos humanos en
-- Chile", que trata las violaciones a los derechos humanos ocurridas
-- durante el régimen militar (1973-1990). Se aplica exactamente el mismo
-- criterio documentado in extenso en el encabezado de
-- supabase/seed/0108_questions_historia_regular_2_medio.sql (no se repite
-- íntegro aquí): los hechos se presentan como datos documentados
-- oficialmente por comisiones de verdad del propio Estado chileno (Informe
-- Rettig, 1991; Informe Valech, 2004/2011), sin atribuir responsabilidad
-- penal individual a personas vivas, sin juicios de valor sobre actores
-- políticos o partidos actuales, y sin lenguaje emotivo o valorativo. Se
-- recomienda ENFÁTICAMENTE una revisión pedagógica humana especializada de
-- este objetivo específico antes de cualquier aprobación.
--
-- El objetivo "Derechos de grupos históricamente vulnerados" se redactó
-- citando ejemplos ampliamente documentados y no controvertidos (mujeres,
-- pueblos originarios, personas con discapacidad) sin tomar posición sobre
-- políticas públicas específicas en debate actual.

-- ============================================================================
-- EJE: DEMOCRACIA E INSTITUCIONALIDAD — 4° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Democracia e Institucionalidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es un sistema electoral?', '["El conjunto de reglas que determinan cómo se traducen los votos en escaños o cargos representativos","Un tipo de documento sin ninguna relación con las elecciones","Una institución encargada exclusivamente de la educación","Un mecanismo que no tiene relación con la representación política"]', 0, 'Un sistema electoral es el conjunto de reglas que determinan cómo se traducen los votos en escaños o cargos representativos.', 'inicial', 20),
  ('¿Cuál de estos es un ejemplo de sistema electoral utilizado en distintos países del mundo?', '["El sistema proporcional, en el que los escaños se distribuyen según el porcentaje de votos obtenido","Un sistema en el que no se realiza ninguna elección","Un sistema en el que una sola persona decide todos los cargos","Un sistema que no tiene ninguna relación con la cantidad de votos obtenidos"]', 0, 'El sistema proporcional, en el que los escaños se distribuyen según el porcentaje de votos obtenido, es un ejemplo de sistema electoral utilizado en distintos países.', 'intermedia', 30),
  ('¿Por qué distintos sistemas electorales pueden generar distintos efectos en la representación política de un país?', '["Porque la forma en que se cuentan y traducen los votos puede favorecer más o menos a ciertos partidos o coaliciones","Porque todos los sistemas electorales generan exactamente el mismo resultado","Porque el sistema electoral no tiene ninguna relación con la representación política","Porque los votos siempre se traducen de la misma forma, sin importar el sistema utilizado"]', 0, 'Distintos sistemas electorales pueden generar distintos efectos en la representación porque la forma en que se cuentan y traducen los votos puede favorecer más o menos a ciertos partidos o coaliciones.', 'intermedia', 35),
  ('Un estudiante compara un sistema electoral proporcional, que tiende a reflejar de forma más fiel el porcentaje de votos de cada partido en el número de escaños, con un sistema mayoritario, donde el candidato con más votos en un distrito obtiene el escaño, incluso sin alcanzar la mayoría absoluta. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que distintos sistemas electorales pueden generar efectos diferentes sobre la representación de los partidos políticos","Que todos los sistemas electorales producen exactamente el mismo resultado en la representación política","Que el sistema electoral no tiene ninguna relación con el resultado de una elección","Que un sistema mayoritario siempre refleja de forma más fiel el porcentaje de votos obtenidos"]', 0, 'Esta comparación es consistente con la idea de que distintos sistemas electorales pueden generar efectos diferentes sobre la representación de los partidos políticos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Democracia e Institucionalidad' and l.code = 'regular_4_medio' and lo.short_name = 'Sistemas electorales y representación política'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Democracia e Institucionalidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es una función habitual de los partidos políticos en una democracia?', '["Articular y representar distintos intereses e ideas dentro de la sociedad","Impedir que la ciudadanía participe en la vida política","Reemplazar completamente a los tres poderes del Estado","No tener ninguna relación con la representación de la ciudadanía"]', 0, 'Articular y representar distintos intereses e ideas dentro de la sociedad es una función habitual de los partidos políticos en una democracia.', 'inicial', 20),
  ('¿Por qué se considera relevante la existencia de más de un partido político en una democracia?', '["Porque permite representar la diversidad de ideas e intereses presentes en la sociedad","Porque un solo partido político siempre representa a toda la sociedad por igual","Porque la existencia de partidos políticos no tiene relación con la representación de la ciudadanía","Porque en una democracia no deberían existir partidos políticos"]', 0, 'Es relevante que existan varios partidos políticos porque permite representar la diversidad de ideas e intereses presentes en la sociedad.', 'intermedia', 30),
  ('¿Cuál de estas es una forma en que los partidos políticos contribuyen a la gobernabilidad de un país?', '["Buscando acuerdos y coaliciones para impulsar proyectos de ley en el Congreso","Impidiendo cualquier tipo de acuerdo entre distintos sectores políticos","Actuando siempre de forma completamente aislada, sin ninguna negociación","Eliminando por completo la posibilidad de acuerdos legislativos"]', 0, 'Buscar acuerdos y coaliciones para impulsar proyectos de ley en el Congreso es una forma en que los partidos políticos contribuyen a la gobernabilidad de un país.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, distintos partidos políticos, con posturas ideológicas diversas, compiten en elecciones y luego negocian acuerdos en el Congreso Nacional para aprobar leyes que requieren apoyo de distintos sectores. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los partidos políticos cumplen un rol relevante tanto en la representación de la diversidad social como en la búsqueda de acuerdos legislativos","Que los partidos políticos no tienen ninguna relación con el funcionamiento del Congreso Nacional","Que en Chile solo existe un único partido político","Que los partidos políticos nunca negocian acuerdos entre sí"]', 0, 'Esta información es consistente con la idea de que los partidos políticos cumplen un rol relevante tanto en la representación de la diversidad social como en la búsqueda de acuerdos legislativos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Democracia e Institucionalidad' and l.code = 'regular_4_medio' and lo.short_name = 'Partidos políticos y su rol en la democracia'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Democracia e Institucionalidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una reforma institucional que ha modificado el funcionamiento del Estado chileno en las últimas décadas?', '["La creación del cargo de gobernador o gobernadora regional, elegido por votación popular","La eliminación completa del Congreso Nacional","La eliminación de cualquier tipo de elección en el país","La supresión total de los tribunales de justicia"]', 0, 'La creación del cargo de gobernador o gobernadora regional, elegido por votación popular, es una reforma institucional reciente en Chile.', 'inicial', 25),
  ('¿Por qué se han impulsado reformas institucionales en Chile en las últimas décadas, como cambios en la organización territorial o en mecanismos electorales?', '["Para adaptar la organización del Estado a nuevas necesidades y demandas de la sociedad","Porque el Estado chileno nunca requiere ningún tipo de cambio institucional","Porque las instituciones de un país nunca deberían modificarse","Porque estas reformas no tienen ninguna relación con las demandas de la sociedad"]', 0, 'Se han impulsado reformas institucionales para adaptar la organización del Estado a nuevas necesidades y demandas de la sociedad.', 'intermedia', 30),
  ('¿Cuál de estos procesos representa un ejemplo de reforma institucional relacionada con la elección de autoridades regionales en Chile?', '["El paso de gobernadores regionales designados por el Presidente a gobernadores elegidos por votación popular","La eliminación completa de cualquier autoridad regional","La creación de un cargo regional sin ninguna función definida","La designación de autoridades regionales exclusivamente por sorteo"]', 0, 'El paso de gobernadores regionales designados por el Presidente a gobernadores elegidos por votación popular es un ejemplo de reforma institucional relacionada con la elección de autoridades regionales.', 'intermedia', 35),
  ('Un estudiante investiga que, en las últimas décadas, Chile ha implementado reformas como la elección directa de gobernadores regionales y cambios en los mecanismos de inscripción electoral, buscando fortalecer la participación y la representación en distintos niveles de gobierno. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que Chile ha experimentado reformas institucionales recientes orientadas a modificar aspectos de su organización política y electoral","Que Chile no ha implementado ninguna reforma institucional en las últimas décadas","Que la organización política de Chile no ha cambiado desde el siglo XIX","Que los gobernadores regionales nunca han sido elegidos por votación popular en Chile"]', 0, 'Esta información es consistente con la idea de que Chile ha experimentado reformas institucionales recientes orientadas a modificar aspectos de su organización política y electoral.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Democracia e Institucionalidad' and l.code = 'regular_4_medio' and lo.short_name = 'Reformas institucionales recientes en Chile'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Democracia e Institucionalidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un elemento común a distintos sistemas democráticos del mundo?', '["La realización de elecciones periódicas para elegir autoridades","La ausencia total de cualquier tipo de elección","La imposición de una autoridad sin ningún proceso electoral","La eliminación de cualquier forma de participación ciudadana"]', 0, 'La realización de elecciones periódicas para elegir autoridades es un elemento común a distintos sistemas democráticos del mundo.', 'inicial', 20),
  ('¿Cuál de estas es una diferencia que puede existir entre distintos sistemas democráticos, como el chileno y otros del mundo?', '["El tipo de sistema electoral utilizado para elegir a los representantes","La existencia o no de cualquier tipo de elección","La presencia o ausencia total de una Constitución","La existencia o no de cualquier forma de gobierno"]', 0, 'El tipo de sistema electoral utilizado para elegir a los representantes es una diferencia que puede existir entre distintos sistemas democráticos.', 'intermedia', 30),
  ('¿Por qué es útil comparar el sistema democrático chileno con otros sistemas democráticos del mundo?', '["Porque permite identificar similitudes, diferencias y posibles aprendizajes para fortalecer la propia democracia","Porque todos los sistemas democráticos del mundo son exactamente iguales","Porque comparar sistemas democráticos no aporta ninguna información relevante","Porque la democracia chilena no tiene ninguna relación con otros sistemas democráticos"]', 0, 'Comparar el sistema democrático chileno con otros es útil porque permite identificar similitudes, diferencias y posibles aprendizajes para fortalecer la propia democracia.', 'intermedia', 35),
  ('Un estudiante compara el sistema democrático chileno, de tipo presidencial, con un sistema parlamentario de otro país, donde el jefe de gobierno depende de la confianza del parlamento, notando diferencias en la forma en que se organiza el poder Ejecutivo. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que existen distintos modelos de organización democrática, con diferencias importantes en la relación entre el Ejecutivo y el Legislativo","Que todos los sistemas democráticos del mundo organizan de la misma forma el poder Ejecutivo","Que un sistema parlamentario no tiene ninguna relación con la democracia","Que Chile no tiene ningún sistema de gobierno definido"]', 0, 'Esta comparación es consistente con la idea de que existen distintos modelos de organización democrática, con diferencias importantes en la relación entre el Ejecutivo y el Legislativo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Democracia e Institucionalidad' and l.code = 'regular_4_medio' and lo.short_name = 'Análisis comparado de sistemas democráticos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: DERECHOS, DEBERES Y ESTADO DE DERECHO — 4° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Derechos, Deberes y Estado de Derecho. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas instituciones fue creada por el Estado chileno, tras el retorno a la democracia, para investigar y documentar violaciones a los derechos humanos ocurridas entre 1973 y 1990?', '["La Comisión Nacional de Verdad y Reconciliación (que originó el Informe Rettig, 1991)","Un organismo dedicado exclusivamente al comercio internacional","Una institución sin ninguna relación con los derechos humanos","Un tribunal internacional creado por otro país"]', 0, 'La Comisión Nacional de Verdad y Reconciliación, que originó el Informe Rettig (1991), fue creada por el Estado chileno para investigar y documentar violaciones a los derechos humanos ocurridas entre 1973 y 1990.', 'inicial', 25),
  ('¿Qué documentó oficialmente el Informe Valech (2004, con una segunda etapa en 2011), otra comisión creada por el Estado chileno?', '["Casos de prisión política y tortura ocurridos durante el régimen militar","La ausencia total de cualquier violación a los derechos humanos en ese período","Un aumento generalizado del bienestar de toda la población sin ninguna excepción","La imposibilidad de investigar hechos ocurridos entre 1973 y 1990"]', 0, 'El Informe Valech documentó oficialmente casos de prisión política y tortura ocurridos durante el régimen militar en Chile.', 'intermedia', 35),
  ('¿Por qué se considera importante que el Estado chileno haya desarrollado políticas de memoria histórica, como sitios conmemorativos y medidas de reparación para víctimas, en relación con este período?', '["Porque contribuye al reconocimiento oficial de hechos documentados y a la reparación de las víctimas","Porque estas políticas no tienen ninguna relación con los derechos humanos","Porque olvidar completamente estos hechos siempre es preferible para el país","Porque este tema no tiene ninguna relevancia para la democracia actual"]', 0, 'Estas políticas son importantes porque contribuyen al reconocimiento oficial de hechos documentados y a la reparación de las víctimas.', 'intermedia', 35),
  ('Un estudiante investiga que, desde el retorno a la democracia en 1990, sucesivos gobiernos de distinto signo político han mantenido comisiones de verdad, medidas de reparación para víctimas y espacios de memoria relacionados con las violaciones a los derechos humanos documentadas oficialmente durante el régimen militar (1973-1990). ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el reconocimiento de estos hechos documentados y las políticas de reparación han sido sostenidas por distintos gobiernos democráticos, más allá de su orientación política","Que solo un gobierno específico ha reconocido estos hechos, sin ninguna continuidad posterior","Que no existe ningún reconocimiento oficial de estos hechos por parte del Estado chileno","Que las violaciones a los derechos humanos de este período nunca fueron documentadas oficialmente"]', 0, 'Esta información es consistente con la idea de que el reconocimiento de estos hechos documentados y las políticas de reparación han sido sostenidas por distintos gobiernos democráticos, más allá de su orientación política.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Derechos, Deberes y Estado de Derecho' and l.code = 'regular_4_medio' and lo.short_name = 'Memoria histórica y derechos humanos en Chile'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Derechos, Deberes y Estado de Derecho. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un ejemplo de grupo históricamente vulnerado en cuanto al reconocimiento de derechos en Chile?', '["Las mujeres, que históricamente enfrentaron restricciones para ejercer el derecho a voto","Un grupo que siempre tuvo reconocidos todos sus derechos, sin ninguna restricción","Un grupo sin ninguna relación con la historia de los derechos en Chile","Un grupo que nunca ha sido mencionado en ningún tratado de derechos humanos"]', 0, 'Las mujeres, que históricamente enfrentaron restricciones para ejercer el derecho a voto, son un ejemplo de grupo históricamente vulnerado en Chile.', 'inicial', 20),
  ('¿Cuál de estos derechos ha sido objeto de avances legales documentados en Chile en relación con los pueblos originarios?', '["El reconocimiento de derechos culturales y de participación de los pueblos originarios en distintas leyes e instituciones","La eliminación total de cualquier derecho para los pueblos originarios","La ausencia de cualquier ley relacionada con los pueblos originarios","La reducción de los derechos de los pueblos originarios a lo largo del tiempo, sin ningún avance"]', 0, 'El reconocimiento de derechos culturales y de participación de los pueblos originarios en distintas leyes e instituciones es un avance legal documentado en Chile.', 'intermedia', 30),
  ('¿Por qué se considera relevante estudiar los avances y desafíos pendientes en el reconocimiento de derechos de grupos históricamente vulnerados, como las personas con discapacidad?', '["Porque permite identificar tanto los progresos logrados como las tareas pendientes para una sociedad más inclusiva","Porque este tema no tiene ninguna relación con la inclusión social","Porque los derechos de estos grupos nunca han cambiado a lo largo de la historia","Porque no es relevante conocer los desafíos pendientes en esta materia"]', 0, 'Es relevante estudiar estos avances y desafíos porque permite identificar tanto los progresos logrados como las tareas pendientes para una sociedad más inclusiva.', 'intermedia', 35),
  ('Un estudiante investiga que, en las últimas décadas, Chile ha promulgado leyes relacionadas con la inclusión de personas con discapacidad, el reconocimiento de derechos de pueblos originarios y la ampliación de derechos políticos para las mujeres, aunque persisten desafíos en su implementación efectiva. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el reconocimiento de derechos de grupos históricamente vulnerados en Chile ha avanzado, aunque persisten desafíos pendientes","Que no existe ningún avance legal relacionado con estos grupos en Chile","Que todos los desafíos relacionados con estos grupos ya fueron completamente resueltos","Que estos grupos nunca han sido objeto de ninguna ley en Chile"]', 0, 'Esta información es consistente con la idea de que el reconocimiento de derechos de grupos históricamente vulnerados en Chile ha avanzado, aunque persisten desafíos pendientes.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Derechos, Deberes y Estado de Derecho' and l.code = 'regular_4_medio' and lo.short_name = 'Derechos de grupos históricamente vulnerados'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Derechos, Deberes y Estado de Derecho. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un deber cívico habitual de los ciudadanos en una democracia?', '["Respetar las leyes y las instituciones del país","Ignorar cualquier norma legal cuando lo estime conveniente","Imponer su voluntad sobre los demás sin ningún límite","Evitar cualquier tipo de responsabilidad frente a la sociedad"]', 0, 'Respetar las leyes y las instituciones del país es un deber cívico habitual de los ciudadanos en una democracia.', 'inicial', 20),
  ('¿Por qué se considera que la responsabilidad ciudadana es importante para el buen funcionamiento de una democracia?', '["Porque el cumplimiento de deberes cívicos, como informarse y participar, contribuye a una convivencia democrática más sólida","Porque la responsabilidad ciudadana no tiene ninguna relación con el funcionamiento de una democracia","Porque solo las autoridades deberían tener algún deber cívico","Porque cumplir deberes cívicos siempre dificulta el funcionamiento de una democracia"]', 0, 'La responsabilidad ciudadana es importante porque el cumplimiento de deberes cívicos, como informarse y participar, contribuye a una convivencia democrática más sólida.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra el cumplimiento de un deber cívico por parte de un ciudadano?', '["Informarse sobre los candidatos antes de votar en una elección","Votar sin informarse sobre ningún candidato ni propuesta","Impedir que otras personas ejerzan su derecho a voto","Ignorar por completo cualquier proceso electoral del país"]', 0, 'Informarse sobre los candidatos antes de votar en una elección muestra el cumplimiento de un deber cívico por parte de un ciudadano.', 'intermedia', 35),
  ('Un estudiante, antes de una elección, revisa las propuestas de distintos candidatos en fuentes confiables, participa en un debate escolar sobre el tema y finalmente vota de manera informada. ¿Qué principio de responsabilidad ciudadana y deberes cívicos está aplicando?', '["Informarse y participar de manera activa y responsable en los procesos democráticos","Votar sin ninguna información previa sobre los candidatos","Evitar cualquier tipo de participación en procesos electorales","Imponer su opinión sin considerar ninguna otra perspectiva"]', 0, 'El estudiante está aplicando el principio de informarse y participar de manera activa y responsable en los procesos democráticos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Derechos, Deberes y Estado de Derecho' and l.code = 'regular_4_medio' and lo.short_name = 'Responsabilidad ciudadana y deberes cívicos'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Derechos, Deberes y Estado de Derecho. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué implica analizar críticamente un caso de vulneración de derechos?', '["Examinar los hechos, las causas y las consecuencias del caso, considerando distintas fuentes de información","Aceptar la primera información disponible sin ninguna verificación","Ignorar cualquier caso de vulneración de derechos","Emitir una opinión sin considerar ninguna evidencia disponible"]', 0, 'Analizar críticamente un caso de vulneración de derechos implica examinar los hechos, las causas y las consecuencias del caso, considerando distintas fuentes de información.', 'inicial', 20),
  ('¿Por qué es importante contrastar distintas fuentes al analizar un caso actual de vulneración de derechos?', '["Porque permite construir una comprensión más completa y menos sesgada del caso","Porque una sola fuente siempre entrega toda la información necesaria sobre un caso","Porque contrastar fuentes dificulta la comprensión de un caso de vulneración de derechos","Porque todas las fuentes sobre un caso siempre entregan exactamente la misma información"]', 0, 'Contrastar distintas fuentes es importante porque permite construir una comprensión más completa y menos sesgada del caso.', 'intermedia', 30),
  ('¿Cuál de estos elementos es relevante considerar al analizar críticamente un caso de vulneración de derechos, como una situación de discriminación laboral?', '["Las circunstancias del caso, la normativa vigente aplicable y las posibles vías de reparación para la víctima","Únicamente la opinión de una sola persona involucrada en el caso","Ningún elemento en particular, ya que no es necesario ningún análisis","Solo la publicidad que ha recibido el caso en redes sociales"]', 0, 'Las circunstancias del caso, la normativa vigente aplicable y las posibles vías de reparación para la víctima son elementos relevantes al analizar críticamente un caso de vulneración de derechos.', 'intermedia', 35),
  ('Un estudiante analiza un caso reciente de discriminación laboral, revisando los hechos documentados, la normativa de protección al trabajador aplicable, y las posibles vías legales de reparación disponibles para la persona afectada, evitando basarse únicamente en una opinión no verificada. ¿Qué habilidad está aplicando el estudiante?', '["Analizar críticamente un caso actual de vulneración de derechos y sus posibles vías de reparación","Ignorar por completo un caso de vulneración de derechos","Aceptar sin ninguna verificación la primera versión disponible del caso","Evitar cualquier análisis sobre casos de vulneración de derechos"]', 0, 'El estudiante está aplicando la habilidad de analizar críticamente un caso actual de vulneración de derechos y sus posibles vías de reparación.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Derechos, Deberes y Estado de Derecho' and l.code = 'regular_4_medio' and lo.short_name = 'Análisis crítico de casos de vulneración de derechos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: PARTICIPACIÓN CIUDADANA Y SOCIEDAD CIVIL — 4° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Participación Ciudadana y Sociedad Civil. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es un movimiento social?', '["Una forma de organización colectiva que busca promover o resistir un cambio social determinado","Un tipo de institución exclusivamente gubernamental","Un concepto sin ninguna relación con la organización de personas","Un partido político oficial reconocido por ley"]', 0, 'Un movimiento social es una forma de organización colectiva que busca promover o resistir un cambio social determinado.', 'inicial', 20),
  ('¿Cuál de estos es un ejemplo de movimiento social relevante en la historia reciente de Chile?', '["El movimiento estudiantil que ha demandado cambios en el sistema educativo en distintos períodos","Un movimiento sin ninguna relación con demandas sociales","Una institución exclusivamente gubernamental","Un tratado internacional firmado entre dos países"]', 0, 'El movimiento estudiantil que ha demandado cambios en el sistema educativo en distintos períodos es un ejemplo de movimiento social relevante en la historia reciente de Chile.', 'intermedia', 30),
  ('¿Por qué se considera relevante analizar el rol de los movimientos sociales en la historia reciente de un país?', '["Porque han influido en cambios de políticas públicas y en la agenda pública de distintos períodos","Porque los movimientos sociales no tienen ninguna relación con las políticas públicas de un país","Porque estos movimientos nunca han generado ningún cambio en la sociedad","Porque analizar su rol no aporta ninguna información relevante sobre la historia reciente"]', 0, 'Es relevante analizar su rol porque los movimientos sociales han influido en cambios de políticas públicas y en la agenda pública de distintos períodos.', 'intermedia', 35),
  ('Un estudiante investiga que, en las últimas décadas, distintos movimientos sociales en Chile (estudiantiles, ambientales, de género, entre otros) han planteado demandas específicas, generando debates públicos y, en algunos casos, cambios en políticas o leyes relacionadas con sus demandas. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los movimientos sociales han cumplido un rol relevante en la historia reciente de Chile, influyendo en debates y políticas públicas","Que los movimientos sociales no han tenido ninguna influencia en la historia reciente de Chile","Que en Chile no ha existido ningún movimiento social en las últimas décadas","Que las demandas de los movimientos sociales nunca han generado ningún debate público"]', 0, 'Esta información es consistente con la idea de que los movimientos sociales han cumplido un rol relevante en la historia reciente de Chile, influyendo en debates y políticas públicas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Participación Ciudadana y Sociedad Civil' and l.code = 'regular_4_medio' and lo.short_name = 'Movimientos sociales en la historia reciente de Chile'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Participación Ciudadana y Sociedad Civil. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se entiende por "abstención electoral"?', '["La no participación de una persona habilitada para votar en un proceso electoral","La obligación legal de votar en toda elección","Un tipo de voto que siempre favorece a un mismo candidato","Un mecanismo para anular automáticamente una elección"]', 0, 'La abstención electoral se refiere a la no participación de una persona habilitada para votar en un proceso electoral.', 'inicial', 20),
  ('¿Cuál de estos es un factor mencionado frecuentemente al analizar la abstención electoral en Chile y otros países?', '["La percepción de desconfianza hacia las instituciones o los candidatos","La ausencia total de cualquier proceso electoral","La obligación estricta de votar sin ninguna excepción","La imposibilidad legal de votar para cualquier ciudadano"]', 0, 'La percepción de desconfianza hacia las instituciones o los candidatos es un factor mencionado frecuentemente al analizar la abstención electoral.', 'intermedia', 30),
  ('¿Por qué se considera relevante analizar las tendencias de participación electoral y abstención en una democracia?', '["Porque permite reflexionar sobre la legitimidad y la representatividad de las autoridades elegidas","Porque la participación electoral no tiene ninguna relación con la legitimidad de una democracia","Porque la abstención electoral no aporta ninguna información relevante para analizar","Porque en una democracia la participación electoral siempre es exactamente la misma"]', 0, 'Es relevante analizar estas tendencias porque permite reflexionar sobre la legitimidad y la representatividad de las autoridades elegidas.', 'intermedia', 35),
  ('Un estudiante investiga que, en algunas elecciones recientes en Chile, se ha registrado una participación electoral más baja que en otras, y que distintos análisis mencionan factores como la desconfianza institucional o la percepción de que el voto no genera cambios significativos. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la participación electoral y la abstención pueden estar influidas por factores relacionados con la confianza ciudadana en las instituciones","Que la participación electoral en Chile siempre ha sido exactamente la misma en todas las elecciones","Que la abstención electoral no tiene ninguna relación con la confianza en las instituciones","Que no existe ningún análisis disponible sobre la participación electoral en Chile"]', 0, 'Esta información es consistente con la idea de que la participación electoral y la abstención pueden estar influidas por factores relacionados con la confianza ciudadana en las instituciones.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Participación Ciudadana y Sociedad Civil' and l.code = 'regular_4_medio' and lo.short_name = 'Participación electoral y abstención'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Participación Ciudadana y Sociedad Civil. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una nueva forma de acción ciudadana facilitada por las redes sociales?', '["La organización rápida de campañas de difusión sobre una causa social","La eliminación de cualquier forma de organización ciudadana","La imposibilidad de comunicarse con otras personas sobre temas públicos","El reemplazo completo de las elecciones tradicionales"]', 0, 'La organización rápida de campañas de difusión sobre una causa social es una nueva forma de acción ciudadana facilitada por las redes sociales.', 'inicial', 20),
  ('¿Cuál de estos es un desafío relacionado con el uso de redes sociales para la acción ciudadana?', '["La posible difusión de información falsa o no verificada sobre una causa social","La imposibilidad total de organizar cualquier acción a través de redes sociales","La eliminación completa de cualquier posibilidad de comunicación digital","La ausencia total de cualquier forma de participación ciudadana en internet"]', 0, 'La posible difusión de información falsa o no verificada sobre una causa social es un desafío relacionado con el uso de redes sociales para la acción ciudadana.', 'intermedia', 30),
  ('¿Por qué se considera que las redes sociales han transformado algunas formas de organización y acción ciudadana en las últimas décadas?', '["Porque permiten conectar rápidamente a personas con intereses comunes, más allá de la distancia geográfica","Porque las redes sociales no tienen ninguna relación con la organización ciudadana","Porque antes de las redes sociales no existía ninguna forma de acción ciudadana","Porque las redes sociales eliminan por completo cualquier forma de organización presencial"]', 0, 'Las redes sociales han transformado algunas formas de acción ciudadana porque permiten conectar rápidamente a personas con intereses comunes, más allá de la distancia geográfica.', 'intermedia', 35),
  ('Un estudiante investiga que, en distintas causas sociales recientes, las redes sociales han permitido difundir información, coordinar acciones colectivas y visibilizar demandas de forma más rápida que en décadas anteriores, aunque también han facilitado la difusión de información no verificada. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que las redes sociales han generado nuevas oportunidades y desafíos para la acción ciudadana","Que las redes sociales solo han generado beneficios, sin ningún desafío asociado","Que las redes sociales solo han generado desafíos, sin ningún beneficio asociado","Que las redes sociales no tienen ninguna relación con la acción ciudadana"]', 0, 'Esta información es consistente con la idea de que las redes sociales han generado nuevas oportunidades y desafíos para la acción ciudadana.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Participación Ciudadana y Sociedad Civil' and l.code = 'regular_4_medio' and lo.short_name = 'Redes sociales y nuevas formas de acción ciudadana'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Participación Ciudadana y Sociedad Civil. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un primer paso adecuado para diseñar un proyecto de participación comunitaria?', '["Identificar una necesidad concreta de la comunidad","Comenzar el proyecto sin ninguna planificación previa","Ignorar por completo las necesidades de la comunidad","Imponer una solución sin consultar a la comunidad"]', 0, 'Identificar una necesidad concreta de la comunidad es un primer paso adecuado para diseñar un proyecto de participación comunitaria.', 'inicial', 20),
  ('¿Por qué es importante involucrar a la comunidad en el diseño de un proyecto orientado a resolver una necesidad local?', '["Porque permite que la solución propuesta responda mejor a las necesidades reales de esa comunidad","Porque involucrar a la comunidad dificulta el diseño de cualquier proyecto","Porque las necesidades de una comunidad nunca deberían considerarse al diseñar un proyecto","Porque un proyecto siempre debería diseñarse sin ninguna consulta previa"]', 0, 'Es importante involucrar a la comunidad porque permite que la solución propuesta responda mejor a las necesidades reales de esa comunidad.', 'intermedia', 30),
  ('¿Cuál de estos elementos debería incluir un proyecto de participación comunitaria bien diseñado?', '["Objetivos claros, un plan de acción y una forma de evaluar sus resultados","Ninguna meta específica ni forma de evaluación","Una solución impuesta sin ninguna relación con la comunidad","Un plan que ignore por completo los recursos disponibles"]', 0, 'Objetivos claros, un plan de acción y una forma de evaluar sus resultados son elementos que debería incluir un proyecto de participación comunitaria bien diseñado.', 'intermedia', 35),
  ('Un grupo de estudiantes, al notar la falta de áreas verdes en su barrio, conversa con vecinos para confirmar la necesidad, diseña un proyecto con objetivos claros para habilitar una pequeña plaza, y define una forma de medir si el proyecto logró su objetivo una vez implementado. ¿Qué principio de diseño de proyectos de participación comunitaria están aplicando?', '["Diseñar un proyecto de participación ciudadana orientado a una necesidad comunitaria real, con objetivos y evaluación claros","Implementar una solución sin ninguna relación con las necesidades de la comunidad","Ignorar la opinión de los vecinos sobre la necesidad identificada","Diseñar un proyecto sin ningún objetivo ni forma de evaluación"]', 0, 'Los estudiantes están aplicando el principio de diseñar un proyecto de participación ciudadana orientado a una necesidad comunitaria real, con objetivos y evaluación claros.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Participación Ciudadana y Sociedad Civil' and l.code = 'regular_4_medio' and lo.short_name = 'Diseño de proyectos de participación comunitaria'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIUDADANÍA, ECONOMÍA Y GLOBALIZACIÓN — 4° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Ciudadanía, Economía y Globalización. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un ejemplo de cómo la globalización puede influir en el ejercicio de la ciudadanía?', '["El acceso a información y noticias de otros países a través de internet","La eliminación total de cualquier intercambio de información entre países","El aislamiento absoluto de un país respecto del resto del mundo","La desaparición completa de la identidad de una comunidad local"]', 0, 'El acceso a información y noticias de otros países a través de internet es un ejemplo de cómo la globalización puede influir en el ejercicio de la ciudadanía.', 'inicial', 20),
  ('¿Por qué se dice que la globalización plantea desafíos para el ejercicio de la ciudadanía en temas que trascienden un solo país, como el cambio climático?', '["Porque estos temas requieren de una coordinación entre distintos países y ciudadanías para abordarse eficazmente","Porque estos temas solo afectan a un único país del mundo","Porque la globalización no tiene ninguna relación con el ejercicio de la ciudadanía","Porque un solo país puede resolver por sí solo cualquier problema global"]', 0, 'La globalización plantea desafíos porque temas como el cambio climático requieren coordinación entre distintos países y ciudadanías para abordarse eficazmente.', 'intermedia', 30),
  ('¿Cuál de estos es un ejemplo de ejercicio de ciudadanía en un contexto globalizado?', '["Participar en campañas internacionales relacionadas con derechos humanos o medioambiente","Ignorar por completo cualquier tema que trascienda las fronteras del propio país","Rechazar cualquier tipo de información proveniente de otros países","Evitar cualquier forma de participación relacionada con temas globales"]', 0, 'Participar en campañas internacionales relacionadas con derechos humanos o medioambiente es un ejemplo de ejercicio de ciudadanía en un contexto globalizado.', 'intermedia', 35),
  ('Un estudiante investiga que, gracias a la globalización, la ciudadanía puede informarse y participar en campañas relacionadas con temas globales, como el cambio climático o los derechos humanos, pero que esto también plantea el desafío de comprender problemas que trascienden las fronteras de un solo país. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la globalización amplía las posibilidades y los desafíos del ejercicio de la ciudadanía más allá de las fronteras nacionales","Que la globalización no tiene ninguna relación con el ejercicio de la ciudadanía","Que la ciudadanía solo puede ejercerse dentro de las fronteras del propio país","Que la globalización elimina por completo cualquier posibilidad de participación ciudadana"]', 0, 'Esta información es consistente con la idea de que la globalización amplía las posibilidades y los desafíos del ejercicio de la ciudadanía más allá de las fronteras nacionales.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Ciudadanía, Economía y Globalización' and l.code = 'regular_4_medio' and lo.short_name = 'Globalización y su impacto en la ciudadanía'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Ciudadanía, Economía y Globalización. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un factor que puede motivar procesos migratorios en un mundo globalizado?', '["La búsqueda de mejores oportunidades laborales o de seguridad","La ausencia total de cualquier motivo para migrar","La imposibilidad legal de desplazarse entre países","La eliminación completa de cualquier frontera entre países"]', 0, 'La búsqueda de mejores oportunidades laborales o de seguridad es un factor que puede motivar procesos migratorios en un mundo globalizado.', 'inicial', 20),
  ('¿Cuál de estos es un desafío ciudadano relacionado con los procesos migratorios recientes en Chile?', '["Promover la integración social y el respeto de los derechos de las personas migrantes","Eliminar por completo cualquier derecho de las personas migrantes","Ignorar cualquier necesidad de integración de las personas migrantes","Impedir cualquier forma de convivencia entre distintas comunidades"]', 0, 'Promover la integración social y el respeto de los derechos de las personas migrantes es un desafío ciudadano relacionado con los procesos migratorios recientes en Chile.', 'intermedia', 30),
  ('¿Por qué se considera relevante analizar la relación entre migración y ciudadanía en un mundo globalizado?', '["Porque los procesos migratorios plantean preguntas sobre derechos, deberes e integración social que afectan a distintas comunidades","Porque la migración no tiene ninguna relación con la ciudadanía","Porque los procesos migratorios no generan ningún desafío para la convivencia social","Porque este tema no tiene ninguna relevancia en la actualidad"]', 0, 'Es relevante analizar esta relación porque los procesos migratorios plantean preguntas sobre derechos, deberes e integración social que afectan a distintas comunidades.', 'intermedia', 35),
  ('Un estudiante investiga que, en las últimas décadas, Chile ha recibido población migrante proveniente de distintos países, lo que ha generado tanto un mayor intercambio cultural como desafíos relacionados con la integración social y el acceso a derechos para estas personas. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los procesos migratorios recientes plantean tanto oportunidades de intercambio cultural como desafíos de integración social y de derechos","Que la migración no ha generado ningún cambio en la sociedad chilena","Que los procesos migratorios solo generan desafíos, sin ningún tipo de intercambio cultural","Que Chile no ha recibido ningún tipo de migración en las últimas décadas"]', 0, 'Esta información es consistente con la idea de que los procesos migratorios recientes plantean tanto oportunidades de intercambio cultural como desafíos de integración social y de derechos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Ciudadanía, Economía y Globalización' and l.code = 'regular_4_medio' and lo.short_name = 'Migración y ciudadanía en un mundo globalizado'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Ciudadanía, Economía y Globalización. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué relación existe entre el concepto de desarrollo sostenible y la responsabilidad ciudadana?', '["Las decisiones individuales y colectivas de consumo y cuidado ambiental pueden contribuir o afectar el desarrollo sostenible","El desarrollo sostenible no tiene ninguna relación con las decisiones de las personas","La responsabilidad ciudadana no influye de ninguna forma en el desarrollo sostenible","Solo el Estado tiene alguna responsabilidad relacionada con el desarrollo sostenible"]', 0, 'Existe una relación porque las decisiones individuales y colectivas de consumo y cuidado ambiental pueden contribuir o afectar el desarrollo sostenible.', 'inicial', 20),
  ('¿Cuál de estas es una acción ciudadana que contribuye al desarrollo sostenible?', '["Reducir el consumo innecesario y reciclar materiales cuando sea posible","Aumentar sin ningún control el consumo de recursos naturales","Ignorar por completo cualquier consecuencia ambiental de las decisiones de consumo","Desechar todo tipo de material sin considerar el reciclaje"]', 0, 'Reducir el consumo innecesario y reciclar materiales cuando sea posible es una acción ciudadana que contribuye al desarrollo sostenible.', 'intermedia', 30),
  ('¿Por qué se considera que el desarrollo sostenible requiere de la responsabilidad tanto de los Estados como de la ciudadanía?', '["Porque las políticas públicas y las decisiones individuales de consumo influyen conjuntamente en el uso de los recursos naturales","Porque solo el Estado tiene alguna responsabilidad relacionada con el desarrollo sostenible","Porque las decisiones individuales no tienen ninguna relación con el desarrollo sostenible","Porque el desarrollo sostenible no depende de ningún actor social"]', 0, 'El desarrollo sostenible requiere responsabilidad tanto de los Estados como de la ciudadanía porque las políticas públicas y las decisiones individuales de consumo influyen conjuntamente en el uso de los recursos naturales.', 'intermedia', 35),
  ('Un estudiante investiga que, en distintas comunidades, iniciativas ciudadanas de reciclaje y reducción de consumo se han combinado con políticas públicas de fomento a las energías renovables, generando avances hacia un desarrollo más sostenible. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el desarrollo sostenible puede fortalecerse mediante la combinación de responsabilidad ciudadana y políticas públicas","Que el desarrollo sostenible depende exclusivamente de las decisiones del Estado, sin ninguna relación con la ciudadanía","Que las iniciativas ciudadanas no tienen ninguna relación con el desarrollo sostenible","Que las políticas públicas de energía renovable no tienen ninguna relación con el desarrollo sostenible"]', 0, 'Esta información es consistente con la idea de que el desarrollo sostenible puede fortalecerse mediante la combinación de responsabilidad ciudadana y políticas públicas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Ciudadanía, Economía y Globalización' and l.code = 'regular_4_medio' and lo.short_name = 'Desarrollo sostenible y responsabilidad ciudadana'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 4° Medio, eje Ciudadanía, Economía y Globalización. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un desafío ciudadano frente al cambio climático?', '["Adoptar hábitos de consumo y transporte que reduzcan la huella de carbono personal","Ignorar por completo cualquier información sobre el cambio climático","Aumentar sin ningún control el uso de recursos que generan emisiones contaminantes","Rechazar cualquier evidencia científica relacionada con el clima"]', 0, 'Adoptar hábitos de consumo y transporte que reduzcan la huella de carbono personal es un desafío ciudadano frente al cambio climático.', 'inicial', 20),
  ('¿Por qué se considera que el cambio climático es un desafío que requiere tanto acción ciudadana como acción estatal e internacional?', '["Porque sus causas y consecuencias trascienden las decisiones de una sola persona o de un solo país","Porque el cambio climático solo depende de las decisiones de un único ciudadano","Porque este desafío no tiene ninguna relación con la acción de los Estados","Porque el cambio climático no requiere ninguna acción coordinada entre países"]', 0, 'El cambio climático requiere acción ciudadana, estatal e internacional porque sus causas y consecuencias trascienden las decisiones de una sola persona o de un solo país.', 'intermedia', 30),
  ('¿Cuál de estas es una acción ciudadana concreta frente al desafío del cambio climático a nivel local?', '["Participar en iniciativas comunitarias de reforestación o reducción de residuos","Ignorar cualquier iniciativa relacionada con el cuidado del medioambiente","Aumentar el uso de productos desechables sin ninguna consideración ambiental","Rechazar cualquier participación en iniciativas comunitarias"]', 0, 'Participar en iniciativas comunitarias de reforestación o reducción de residuos es una acción ciudadana concreta frente al desafío del cambio climático a nivel local.', 'intermedia', 35),
  ('Un estudiante, junto a su comunidad, organiza una campaña de reducción de uso de plásticos de un solo uso, mientras investiga y difunde información sobre acuerdos internacionales relacionados con la reducción de emisiones de gases de efecto invernadero. ¿Qué principio de ciudadanía frente al cambio climático está aplicando?', '["Combinar la acción local concreta con la comprensión de desafíos y acuerdos de escala global relacionados con el cambio climático","Actuar únicamente a nivel local, sin ninguna relación con acuerdos internacionales","Ignorar cualquier acción posible frente al cambio climático","Rechazar cualquier tipo de acuerdo internacional sobre el clima"]', 0, 'El estudiante está aplicando el principio de combinar la acción local concreta con la comprensión de desafíos y acuerdos de escala global relacionados con el cambio climático.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Ciudadanía, Economía y Globalización' and l.code = 'regular_4_medio' and lo.short_name = 'Desafíos ciudadanos frente al cambio climático'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
