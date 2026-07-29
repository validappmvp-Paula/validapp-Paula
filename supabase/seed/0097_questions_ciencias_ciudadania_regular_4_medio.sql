-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- para la Ciudadanía (Formación General, asignatura DISTINTA de Ciencias
-- Naturales, ver decisión de modelado en el encabezado de
-- supabase/seed/0019_curriculum_ciencias_ciudadania_regular_3_4medio.sql),
-- 4° Medio. Cubre los 16 objetivos de aprendizaje de 4° Medio cargados por
-- 0019 (4 módulos x 4 objetivos), con 4 preguntas por objetivo, total 64
-- preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí). IMPORTANTE: este archivo usa `subject.name = 'Ciencias
-- para la Ciudadanía'` (canonical_code 'citizen_science'), NO 'Ciencias
-- Naturales' -- ver la decisión de modelado documentada en 0019. Mismo
-- criterio que 0096 respecto de temas sensibles (aquí: terapias génicas,
-- reproducción asistida y clonación): enfoque científico/ético informativo,
-- sin contenido explícito, con recomendación de revisión pedagógica
-- adicional.

-- ============================================================================
-- MÓDULO: SEGURIDAD, PREVENCIÓN Y AUTOCUIDADO — 4° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Seguridad, Prevención y Autocuidado. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos riesgos podría evaluarse en un entorno laboral, como una fábrica?', '["La exposición a sustancias químicas sin protección adecuada","El color del uniforme de trabajo","La marca del computador de la oficina","El horario de almuerzo de los trabajadores"]', 0, 'La exposición a sustancias químicas sin protección adecuada es un riesgo relevante a evaluar en un entorno laboral.', 'inicial', 25),
  ('¿Por qué es importante que las empresas evalúen los riesgos presentes en el entorno laboral de sus trabajadores?', '["Para implementar medidas de prevención que protejan la salud y seguridad de las personas","Porque los riesgos laborales no afectan a los trabajadores","Porque no es necesario tomar ninguna medida de prevención en el trabajo","Porque evaluar riesgos laborales no tiene ninguna utilidad"]', 1, 'Evaluar los riesgos laborales permite implementar medidas de prevención que protejan la salud y seguridad de los trabajadores.', 'intermedia', 35),
  ('¿Cuál de estas medidas ayuda a reducir un riesgo evaluado en un entorno laboral, como el manejo de maquinaria pesada?', '["Capacitar a los trabajadores en el uso seguro de la maquinaria y proveer equipos de protección","No entregar ninguna capacitación a los trabajadores","Permitir el uso de la maquinaria sin ninguna supervisión","Ignorar cualquier norma de seguridad laboral"]', 2, 'Capacitar a los trabajadores y proveer equipos de protección son medidas que ayudan a reducir riesgos evaluados en el entorno laboral.', 'intermedia', 35),
  ('Una empresa realiza una evaluación de riesgos en su planta de producción y detecta que ciertos trabajadores están expuestos a niveles de ruido que podrían afectar su audición a largo plazo. A partir de esta evaluación, implementa el uso obligatorio de protectores auditivos. ¿Qué proceso general de gestión de riesgos laborales se refleja en esta situación?', '["Ignorar el riesgo detectado sin tomar ninguna medida","Evaluar un riesgo y luego implementar una medida de prevención basada en esa evaluación","Aumentar el riesgo detectado de forma intencional","Evaluar el riesgo sin ninguna consecuencia práctica posterior"]', 3, 'Esta situación refleja el proceso de evaluar un riesgo laboral y luego implementar una medida de prevención basada en esa evaluación.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Seguridad, Prevención y Autocuidado' and l.code = 'regular_4_medio' and lo.short_name = 'Evaluación de riesgos en el entorno laboral'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Seguridad, Prevención y Autocuidado. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una medida de seguridad recomendada frente a un terremoto en Chile?', '["Ubicarse en una zona segura de la vivienda y alejarse de objetos que puedan caer","Correr hacia el ascensor de inmediato","Pararse cerca de una ventana de vidrio","Ignorar cualquier indicación de seguridad"]', 0, 'Ubicarse en una zona segura de la vivienda y alejarse de objetos que puedan caer es una medida recomendada frente a un terremoto.', 'inicial', 25),
  ('¿Por qué es importante que las comunidades costeras conozcan las zonas de evacuación frente a un posible tsunami?', '["Porque permite reaccionar de forma más rápida y segura ante una alerta de tsunami","Porque las zonas de evacuación no tienen ninguna utilidad","Porque un tsunami nunca representa un riesgo para las zonas costeras","Porque no es necesario informarse sobre este tipo de riesgo"]', 1, 'Conocer las zonas de evacuación permite a las comunidades costeras reaccionar de forma más rápida y segura ante una alerta de tsunami.', 'intermedia', 35),
  ('¿Cuál de estas acciones forma parte de un plan de seguridad familiar frente a desastres naturales?', '["Definir un punto de encuentro seguro y preparar un kit de emergencia","No preparar ningún plan ni kit de emergencia","Ignorar las alertas de las autoridades","Improvisar sin ninguna planificación previa"]', 2, 'Definir un punto de encuentro seguro y preparar un kit de emergencia son acciones que forman parte de un plan de seguridad familiar frente a desastres naturales.', 'intermedia', 35),
  ('Una comunidad que vive cerca de un volcán activo participa en simulacros periódicos de evacuación, cuenta con rutas de evacuación señalizadas y recibe capacitación sobre qué hacer ante una alerta volcánica. ¿Qué relación tienen estas acciones con la seguridad ante desastres naturales?', '["No tienen ninguna relación con la seguridad de la comunidad","Aumentan el riesgo de la comunidad frente a una erupción volcánica","Corresponden a medidas de preparación que buscan reducir el riesgo para la comunidad ante una posible erupción","Solo tienen un propósito educativo, sin relación con la seguridad real"]', 3, 'Estas acciones corresponden a medidas de preparación que buscan reducir el riesgo para la comunidad ante una posible erupción volcánica.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Seguridad, Prevención y Autocuidado' and l.code = 'regular_4_medio' and lo.short_name = 'Seguridad ante desastres naturales'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Seguridad, Prevención y Autocuidado. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Por qué se recomienda seguir las indicaciones de un profesional de la salud sobre la dosis y duración de un medicamento?', '["Porque un uso inadecuado puede afectar la salud o reducir la efectividad del tratamiento","Porque las indicaciones médicas no tienen ninguna importancia","Porque cualquier dosis de un medicamento produce el mismo efecto","Porque los medicamentos nunca tienen efectos si se usan en exceso"]', 0, 'Seguir las indicaciones médicas sobre dosis y duración es importante porque un uso inadecuado puede afectar la salud o reducir la efectividad del tratamiento.', 'inicial', 25),
  ('¿Cuál de estas es una consecuencia posible del uso irresponsable de antibióticos, según evidencia científica?', '["El desarrollo de resistencia bacteriana, que dificulta tratar infecciones en el futuro","La eliminación completa de todas las bacterias del planeta","Ningún efecto negativo, ya que los antibióticos son siempre seguros en cualquier cantidad","Un aumento en la efectividad de los antibióticos con el tiempo"]', 1, 'El uso irresponsable de antibióticos puede favorecer el desarrollo de resistencia bacteriana, dificultando el tratamiento de infecciones en el futuro.', 'intermedia', 35),
  ('¿Qué acción refleja un uso responsable de medicamentos y sustancias?', '["Consultar a un profesional de la salud antes de automedicarse con un tratamiento prolongado","Compartir medicamentos recetados con otras personas sin indicación médica","Aumentar la dosis de un medicamento sin consultar a un profesional","Consumir sustancias sin considerar sus posibles efectos en la salud"]', 2, 'Consultar a un profesional de la salud antes de un tratamiento prolongado refleja un uso responsable de medicamentos.', 'intermedia', 35),
  ('Un estudiante investiga que el uso excesivo e injustificado de antibióticos en distintos países ha contribuido, según evidencia científica, al aumento de bacterias resistentes a estos medicamentos, complicando el tratamiento de ciertas infecciones. ¿Qué relación explica mejor esta evidencia entre el uso de medicamentos y la salud pública?', '["No existe ninguna relación entre el uso de antibióticos y la resistencia bacteriana","El uso responsable de medicamentos, como los antibióticos, es relevante para la salud pública a largo plazo, evitando problemas como la resistencia bacteriana","El uso excesivo de antibióticos siempre mejora la salud pública","La resistencia bacteriana no tiene relación con el uso de medicamentos"]', 3, 'Esta evidencia muestra que el uso responsable de medicamentos, como los antibióticos, es relevante para la salud pública a largo plazo, evitando problemas como la resistencia bacteriana.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Seguridad, Prevención y Autocuidado' and l.code = 'regular_4_medio' and lo.short_name = 'Uso responsable de medicamentos y sustancias'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Seguridad, Prevención y Autocuidado. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué característica debería tener la comunicación de un riesgo científico, como un posible brote de una enfermedad, a la comunidad?', '["Ser clara, oportuna y basada en evidencia confiable","Ser confusa y con información poco verificada","Evitar cualquier información sobre el riesgo real","Comunicarse solo cuando ya sea demasiado tarde para tomar medidas"]', 0, 'La comunicación de un riesgo a la comunidad debe ser clara, oportuna y basada en evidencia confiable.', 'inicial', 25),
  ('¿Por qué es importante que las autoridades comuniquen con claridad los riesgos ambientales o sanitarios a la comunidad?', '["Para que las personas puedan tomar medidas de prevención adecuadas de forma oportuna","Porque la comunidad nunca necesita informarse sobre riesgos","Porque comunicar riesgos genera más problemas que beneficios","Porque no es responsabilidad de las autoridades informar sobre riesgos"]', 1, 'Comunicar con claridad los riesgos permite que la comunidad tome medidas de prevención adecuadas de forma oportuna.', 'intermedia', 35),
  ('¿Cuál de estas es una buena práctica al comunicar un riesgo sanitario a la comunidad, como la propagación de una enfermedad infecciosa?', '["Explicar de forma clara las medidas de prevención recomendadas, basadas en evidencia científica","Generar pánico sin entregar información útil","Ocultar información relevante sobre el riesgo","Comunicar información contradictoria sin ninguna base científica"]', 2, 'Explicar de forma clara las medidas de prevención recomendadas, basadas en evidencia científica, es una buena práctica al comunicar un riesgo sanitario.', 'intermedia', 35),
  ('Durante un evento de contaminación del aire en una ciudad, las autoridades de salud comunican a la comunidad, mediante distintos medios, el nivel de riesgo, las recomendaciones para grupos vulnerables y las medidas que se están tomando para reducir la contaminación. ¿Qué principio de comunicación de riesgos están aplicando?', '["Ocultar información relevante para evitar preocupación en la comunidad","Comunicar de forma clara, con información basada en evidencia, para que la comunidad pueda tomar decisiones informadas","Comunicar información sin ninguna base científica","Evitar cualquier comunicación sobre el riesgo detectado"]', 3, 'Las autoridades están aplicando el principio de comunicar de forma clara, con información basada en evidencia, para que la comunidad pueda tomar decisiones informadas frente al riesgo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Seguridad, Prevención y Autocuidado' and l.code = 'regular_4_medio' and lo.short_name = 'Comunicación de riesgos a la comunidad'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- MÓDULO: TECNOLOGÍA Y SOCIEDAD — 4° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué relación existe entre la ciencia, la tecnología y el desarrollo sostenible?', '["La ciencia y la tecnología pueden aportar soluciones para enfrentar desafíos ambientales y sociales de forma sostenible","No existe ninguna relación entre estos conceptos","La tecnología siempre perjudica el desarrollo sostenible","La ciencia no tiene ninguna aplicación práctica en el desarrollo sostenible"]', 0, 'La ciencia y la tecnología pueden aportar soluciones para enfrentar desafíos ambientales y sociales de forma sostenible.', 'inicial', 25),
  ('¿Cuál de estos ejemplos muestra el aporte de la ciencia y la tecnología al desarrollo sostenible?', '["El desarrollo de tecnologías de energía renovable, como paneles solares más eficientes","La fabricación de productos desechables de un solo uso sin ningún control","El aumento sin límite del uso de combustibles fósiles","La eliminación de cualquier tipo de investigación científica"]', 1, 'El desarrollo de tecnologías de energía renovable, como paneles solares más eficientes, es un ejemplo del aporte de la ciencia y la tecnología al desarrollo sostenible.', 'intermedia', 35),
  ('¿Por qué se considera importante que el desarrollo tecnológico también contemple criterios de sostenibilidad ambiental y social?', '["Porque el desarrollo tecnológico puede tener efectos positivos o negativos sobre el ambiente y la sociedad, que deben considerarse","Porque la sostenibilidad no tiene ninguna relación con la tecnología","Porque el desarrollo tecnológico nunca afecta al ambiente","Porque los criterios sociales no deberían influir en el desarrollo tecnológico"]', 2, 'Es importante que el desarrollo tecnológico contemple criterios de sostenibilidad porque puede tener efectos positivos o negativos sobre el ambiente y la sociedad.', 'intermedia', 35),
  ('Un país invierte en investigación científica para desarrollar tecnologías de tratamiento de aguas residuales, energías renovables y agricultura más eficiente en el uso de recursos, con el objetivo de reducir su impacto ambiental sin frenar su desarrollo económico. ¿Qué relación general ilustra esta política entre ciencia, tecnología y desarrollo sostenible?', '["Que la ciencia y la tecnología no tienen relación con el desarrollo sostenible","Que la ciencia y la tecnología pueden orientarse hacia soluciones que concilien el desarrollo económico con la sostenibilidad ambiental","Que el desarrollo sostenible siempre implica detener cualquier avance tecnológico","Que esta política no tiene ningún objetivo relacionado con la sostenibilidad"]', 3, 'Esta política ilustra que la ciencia y la tecnología pueden orientarse hacia soluciones que concilien el desarrollo económico con la sostenibilidad ambiental.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Tecnología y Sociedad' and l.code = 'regular_4_medio' and lo.short_name = 'Ciencia, tecnología y desarrollo sostenible'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se entiende por ''big data'' en el contexto tecnológico actual?', '["Grandes volúmenes de datos que se recopilan, almacenan y analizan mediante tecnologías digitales","Un tipo de virus informático","Un dispositivo físico usado para almacenar fotografías","Un programa exclusivo para editar videos"]', 0, 'El ''big data'' se refiere a grandes volúmenes de datos que se recopilan, almacenan y analizan mediante tecnologías digitales.', 'inicial', 25),
  ('¿Qué preocupación ciudadana se relaciona frecuentemente con el uso de big data y la información personal de los usuarios?', '["La privacidad y el posible uso indebido de esa información","La ausencia total de cualquier riesgo relacionado con estos datos","La imposibilidad de que las empresas recopilen información alguna","La eliminación completa del uso de internet"]', 1, 'La privacidad y el posible uso indebido de la información personal es una preocupación ciudadana frecuente relacionada con el big data.', 'intermedia', 35),
  ('¿Cuál de estas acciones refleja un uso más responsable de la información personal por parte de una empresa que recopila datos de sus usuarios?', '["Informar claramente a los usuarios cómo se usará su información y pedir su consentimiento","Recopilar información sin informar a los usuarios sobre su uso","Compartir la información personal de los usuarios sin ningún control ni autorización","Ignorar cualquier normativa relacionada con la protección de datos personales"]', 2, 'Informar claramente a los usuarios sobre el uso de su información y pedir su consentimiento refleja un uso más responsable de los datos personales.', 'intermedia', 35),
  ('Un estudiante investiga que muchas aplicaciones recopilan datos sobre la ubicación, los hábitos de consumo y las preferencias de sus usuarios, y que esta información puede utilizarse tanto para mejorar servicios como para fines comerciales sin que los usuarios siempre estén plenamente conscientes de ello. ¿Qué reflexión ciudadana surge de esta información sobre el big data?', '["Que el uso de datos personales no genera ninguna preocupación ciudadana","Que es importante que exista transparencia y regulación sobre el uso de la información personal recopilada mediante tecnologías digitales","Que las empresas deberían poder usar la información de los usuarios sin ninguna restricción","Que esta información no tiene relación con la ciudadanía"]', 3, 'Esta información genera la reflexión de que es importante que exista transparencia y regulación sobre el uso de la información personal recopilada mediante tecnologías digitales.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Tecnología y Sociedad' and l.code = 'regular_4_medio' and lo.short_name = 'Big data y uso de información personal'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué efecto puede tener la automatización tecnológica en algunos puestos de trabajo?', '["Puede reemplazar ciertas tareas repetitivas que antes realizaban personas","Nunca afecta ningún tipo de empleo","Elimina automáticamente todos los empleos de un país","No tiene ninguna relación con el mercado laboral"]', 0, 'La automatización tecnológica puede reemplazar ciertas tareas repetitivas que antes realizaban personas, afectando algunos puestos de trabajo.', 'inicial', 25),
  ('¿Cuál de estas es una consecuencia posible de la innovación tecnológica sobre el empleo, además de eliminar ciertas tareas?', '["La creación de nuevos tipos de empleo relacionados con esas tecnologías","La eliminación absoluta de cualquier tipo de trabajo humano","La desaparición completa de la necesidad de formación laboral","Ningún efecto adicional sobre el mercado laboral"]', 1, 'La innovación tecnológica también puede generar la creación de nuevos tipos de empleo relacionados con esas tecnologías.', 'intermedia', 35),
  ('¿Por qué se considera importante la capacitación continua de los trabajadores frente a los cambios tecnológicos en el mundo laboral?', '["Porque permite adaptarse a nuevas herramientas y tipos de trabajo que van surgiendo","Porque la capacitación no tiene ninguna relación con los cambios tecnológicos","Porque los trabajadores nunca necesitan actualizar sus habilidades","Porque la tecnología nunca cambia la forma de trabajar"]', 2, 'La capacitación continua permite a los trabajadores adaptarse a nuevas herramientas y tipos de trabajo que surgen con la innovación tecnológica.', 'intermedia', 35),
  ('Un estudiante investiga que, en ciertas industrias, la automatización ha reemplazado tareas repetitivas realizadas antes por personas, pero al mismo tiempo ha generado nuevos empleos relacionados con el mantenimiento y programación de esas tecnologías. ¿Qué idea general sobre la innovación tecnológica y el empleo refleja esta información?', '["Que la innovación tecnológica siempre elimina empleos sin generar ninguno nuevo","Que la innovación tecnológica puede transformar el mercado laboral, eliminando algunas tareas y creando otras nuevas","Que la innovación tecnológica no tiene ningún efecto sobre el empleo","Que todos los empleos desaparecerán por completo debido a la tecnología"]', 3, 'Esta información refleja que la innovación tecnológica puede transformar el mercado laboral, eliminando algunas tareas y creando otras nuevas relacionadas con esas tecnologías.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Tecnología y Sociedad' and l.code = 'regular_4_medio' and lo.short_name = 'Innovación tecnológica y empleo'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma de participación ciudadana en decisiones relacionadas con ciencia y tecnología?', '["Participar en consultas públicas sobre un proyecto tecnológico que afecta a la comunidad","Ignorar cualquier información sobre proyectos científicos o tecnológicos locales","Evitar informarse sobre decisiones que afectan a la comunidad","No expresar ninguna opinión sobre temas científicos o tecnológicos"]', 0, 'Participar en consultas públicas sobre un proyecto tecnológico es una forma de participación ciudadana en decisiones relacionadas con ciencia y tecnología.', 'inicial', 25),
  ('¿Por qué es importante que la ciudadanía pueda participar en decisiones sobre proyectos científico-tecnológicos que afectan su entorno, como la instalación de una planta industrial?', '["Porque permite que se consideren las preocupaciones y necesidades de la comunidad afectada","Porque la ciudadanía nunca debería opinar sobre temas científicos o tecnológicos","Porque estos proyectos nunca afectan a las comunidades cercanas","Porque la participación ciudadana no tiene ninguna utilidad en estos casos"]', 1, 'La participación ciudadana permite que se consideren las preocupaciones y necesidades de la comunidad afectada por un proyecto científico-tecnológico.', 'intermedia', 35),
  ('¿Cuál de estos mecanismos permite a la ciudadanía informarse y opinar sobre un proyecto tecnológico antes de que se implemente, en muchos países?', '["Los procesos de evaluación de impacto ambiental con participación ciudadana","La ausencia total de cualquier mecanismo de información pública","La decisión exclusiva de una sola persona sin ninguna consulta","La imposibilidad legal de que la ciudadanía participe en estos procesos"]', 2, 'Los procesos de evaluación de impacto ambiental con participación ciudadana permiten a las personas informarse y opinar sobre un proyecto antes de su implementación.', 'intermedia', 35),
  ('Una comunidad se informa sobre un proyecto de instalación de una antena de telecomunicaciones cercana a su barrio, participa en una consulta pública organizada por la autoridad correspondiente, y expresa sus inquietudes sobre la ubicación propuesta. ¿Qué habilidad ciudadana relacionada con la ciencia y la tecnología está ejerciendo esta comunidad?', '["Ignorar cualquier decisión relacionada con proyectos tecnológicos en su entorno","Participar de forma informada en decisiones científico-tecnológicas que afectan a su comunidad","Rechazar automáticamente cualquier avance tecnológico sin ningún análisis","Evitar cualquier tipo de consulta pública sobre el tema"]', 3, 'Esta comunidad está ejerciendo la habilidad de participar de forma informada en decisiones científico-tecnológicas que afectan a su entorno.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Tecnología y Sociedad' and l.code = 'regular_4_medio' and lo.short_name = 'Participación ciudadana en decisiones científico-tecnológicas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- MÓDULO: ECOSISTEMA, COMUNIDAD Y SUSTENTABILIDAD — 4° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Ecosistema, Comunidad y Sustentabilidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es una política pública ambiental?', '["Una medida adoptada por el Estado para regular o proteger el ambiente","Una opinión personal sobre el clima","Una decisión exclusiva de una empresa privada sin ninguna regulación estatal","Un tipo de fenómeno natural"]', 0, 'Una política pública ambiental es una medida adoptada por el Estado para regular o proteger el ambiente.', 'inicial', 25),
  ('¿Cuál de estas es una posible política pública ambiental orientada a reducir la contaminación del aire en una ciudad?', '["Restringir la circulación de vehículos altamente contaminantes en ciertos días","Eliminar cualquier norma sobre emisiones vehiculares","Aumentar sin ningún control el uso de combustibles fósiles","Ignorar cualquier medición de la calidad del aire"]', 1, 'Restringir la circulación de vehículos altamente contaminantes es un ejemplo de política pública ambiental orientada a reducir la contaminación del aire.', 'intermedia', 35),
  ('¿Por qué es importante que las políticas públicas ambientales se basen en evidencia científica?', '["Porque permite diseñar medidas más efectivas para enfrentar problemas ambientales reales","Porque la evidencia científica no aporta ninguna información útil para estas políticas","Porque las políticas ambientales no deberían considerar ningún dato científico","Porque el ambiente no se ve afectado por las decisiones políticas"]', 2, 'Basar las políticas públicas ambientales en evidencia científica permite diseñar medidas más efectivas para enfrentar problemas ambientales reales.', 'intermedia', 35),
  ('Un país implementa una política pública que limita las emisiones de ciertas industrias, basándose en estudios científicos sobre el impacto de esas emisiones en la calidad del aire y la salud de la población. Años después, se observa una mejora en los indicadores de calidad del aire de las zonas afectadas. ¿Qué relación ilustra esta situación entre la ciencia y las políticas públicas ambientales?', '["Que la ciencia no tiene ninguna relación con el diseño de políticas públicas","Que basar una política pública en evidencia científica puede contribuir a mejorar problemas ambientales reales","Que las políticas públicas ambientales nunca logran ningún resultado","Que la calidad del aire no depende de las políticas públicas implementadas"]', 3, 'Esta situación ilustra que basar una política pública en evidencia científica puede contribuir a mejorar problemas ambientales reales, como la calidad del aire.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Ecosistema, Comunidad y Sustentabilidad' and l.code = 'regular_4_medio' and lo.short_name = 'Políticas públicas ambientales'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Ecosistema, Comunidad y Sustentabilidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una fuente de energía renovable relevante para la transición energética?', '["La energía solar fotovoltaica","El carbón","El petróleo","El gas natural"]', 0, 'La energía solar fotovoltaica es una fuente de energía renovable relevante para la transición energética.', 'inicial', 25),
  ('¿Qué se entiende por ''transición energética'' en el contexto de la sustentabilidad?', '["El proceso de cambiar progresivamente la matriz energética hacia fuentes más renovables y sustentables","La eliminación inmediata y total de cualquier fuente de energía","Un proceso que no tiene relación con la sustentabilidad ambiental","El aumento indefinido del uso de combustibles fósiles"]', 1, 'La transición energética se refiere al proceso de cambiar progresivamente la matriz energética hacia fuentes más renovables y sustentables.', 'intermedia', 35),
  ('¿Por qué se considera importante avanzar hacia energías renovables en el marco de la transición energética?', '["Porque contribuyen a reducir la emisión de gases de efecto invernadero, en comparación con los combustibles fósiles","Porque las energías renovables generan más contaminación que los combustibles fósiles","Porque no existe ninguna diferencia ambiental entre energías renovables y fósiles","Porque la transición energética no tiene relación con el cambio climático"]', 2, 'Avanzar hacia energías renovables contribuye a reducir la emisión de gases de efecto invernadero, en comparación con los combustibles fósiles.', 'intermedia', 35),
  ('Un país establece una meta para que, en las próximas décadas, un porcentaje cada vez mayor de su electricidad provenga de fuentes solares, eólicas e hidráulicas, reduciendo progresivamente su dependencia del carbón. ¿Qué proceso describe mejor esta meta?', '["Una política que no tiene relación con la sustentabilidad energética","Un ejemplo de transición energética hacia fuentes más renovables y sustentables","Un aumento en el uso de combustibles fósiles no renovables","Una eliminación inmediata de toda forma de energía en el país"]', 3, 'Esta meta describe un ejemplo de transición energética hacia fuentes más renovables y sustentables, reduciendo progresivamente la dependencia de combustibles fósiles.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Ecosistema, Comunidad y Sustentabilidad' and l.code = 'regular_4_medio' and lo.short_name = 'Energías renovables y transición energética'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Ecosistema, Comunidad y Sustentabilidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas actividades productivas puede tener un impacto ambiental relevante si no se gestiona adecuadamente?', '["La minería a gran escala","La lectura de libros","La práctica de yoga","La observación de estrellas"]', 0, 'La minería a gran escala puede tener un impacto ambiental relevante si no se gestiona adecuadamente, afectando el suelo, el agua o el aire.', 'inicial', 25),
  ('¿Qué medida puede ayudar a reducir el impacto ambiental de una actividad productiva, como una planta industrial?', '["Implementar sistemas de tratamiento de residuos y control de emisiones","Verter los residuos directamente en un río sin ningún tratamiento","Aumentar las emisiones sin ningún control","Ignorar cualquier normativa ambiental vigente"]', 1, 'Implementar sistemas de tratamiento de residuos y control de emisiones ayuda a reducir el impacto ambiental de una actividad productiva.', 'intermedia', 35),
  ('¿Por qué se realizan evaluaciones de impacto ambiental antes de aprobar ciertos proyectos productivos de gran escala?', '["Para identificar y mitigar posibles efectos negativos sobre el ambiente y las comunidades cercanas","Porque estas evaluaciones no tienen ninguna utilidad práctica","Porque los proyectos productivos nunca generan impacto ambiental","Porque no es necesario considerar el ambiente al aprobar un proyecto"]', 2, 'Las evaluaciones de impacto ambiental buscan identificar y mitigar posibles efectos negativos de un proyecto sobre el ambiente y las comunidades cercanas.', 'intermedia', 35),
  ('Una empresa agrícola implementa sistemas de riego más eficientes, reduce el uso de pesticidas mediante control biológico de plagas, y monitorea la calidad del agua de los canales cercanos a sus cultivos. ¿Qué relación tienen estas acciones con el impacto ambiental de su actividad productiva?', '["No tienen ninguna relación con el impacto ambiental de la actividad","Aumentan el impacto ambiental negativo de la actividad productiva","Buscan reducir el impacto ambiental negativo asociado a la actividad productiva","Eliminan por completo cualquier posible impacto ambiental, sin ningún esfuerzo adicional"]', 3, 'Estas acciones buscan reducir el impacto ambiental negativo asociado a la actividad productiva agrícola de la empresa.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Ecosistema, Comunidad y Sustentabilidad' and l.code = 'regular_4_medio' and lo.short_name = 'Impacto ambiental de actividades productivas'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Ecosistema, Comunidad y Sustentabilidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas acciones refleja un compromiso ciudadano con la sustentabilidad?', '["Participar en actividades de reciclaje y cuidado de áreas verdes de la comunidad","Ignorar cualquier iniciativa relacionada con el cuidado ambiental","Aumentar el consumo de productos desechables sin ninguna consideración","Oponerse a cualquier medida de cuidado ambiental en su comunidad"]', 0, 'Participar en actividades de reciclaje y cuidado de áreas verdes es un ejemplo de compromiso ciudadano con la sustentabilidad.', 'inicial', 25),
  ('¿Por qué se considera que el compromiso ciudadano es relevante para lograr avances en sustentabilidad ambiental, además de las políticas estatales?', '["Porque las acciones individuales y comunitarias, sumadas a las políticas públicas, pueden contribuir a un mayor impacto positivo","Porque el compromiso ciudadano no tiene ninguna relación con la sustentabilidad","Porque solo el Estado puede lograr avances en sustentabilidad, sin participación ciudadana","Porque las acciones individuales nunca tienen ningún efecto en la sustentabilidad"]', 1, 'Las acciones individuales y comunitarias, sumadas a las políticas públicas, pueden contribuir a un mayor impacto positivo en sustentabilidad ambiental.', 'intermedia', 35),
  ('¿Cuál de estas iniciativas comunitarias refleja un compromiso ciudadano con la sustentabilidad?', '["La organización de un programa vecinal de compostaje de residuos orgánicos","La quema de residuos sin ningún control en espacios comunes","El uso indiscriminado de productos de un solo uso sin ninguna consideración ambiental","La oposición a cualquier iniciativa de reciclaje en la comunidad"]', 2, 'La organización de un programa vecinal de compostaje de residuos orgánicos refleja un compromiso ciudadano con la sustentabilidad.', 'intermedia', 35),
  ('Un grupo de vecinos organiza una feria de intercambio de ropa y objetos en desuso, promueve el uso de bicicletas para trayectos cortos, y organiza jornadas de limpieza y reforestación en un parque cercano. ¿Qué idea general sobre el compromiso ciudadano con la sustentabilidad refleja esta iniciativa comunitaria?', '["Que las acciones comunitarias no tienen ningún efecto en la sustentabilidad","Que el compromiso ciudadano con la sustentabilidad puede expresarse mediante acciones concretas a nivel comunitario","Que solo las grandes empresas pueden contribuir a la sustentabilidad ambiental","Que estas acciones no tienen relación con el cuidado del ambiente"]', 3, 'Esta iniciativa refleja que el compromiso ciudadano con la sustentabilidad puede expresarse mediante acciones concretas a nivel comunitario, como el intercambio de objetos, el uso de bicicletas y la reforestación.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Ecosistema, Comunidad y Sustentabilidad' and l.code = 'regular_4_medio' and lo.short_name = 'Compromiso ciudadano con la sustentabilidad'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- MÓDULO: CÉLULA, TECNOLOGÍA Y SOCIEDAD — 4° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Célula, Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué busca una terapia génica, a nivel introductorio?', '["Corregir o compensar una alteración genética asociada a una enfermedad","Cambiar el color de ojos de una persona sin ningún fin médico","Eliminar por completo cualquier tipo de tratamiento médico tradicional","Aumentar la estatura de una persona sin relación con la salud"]', 0, 'Una terapia génica busca corregir o compensar una alteración genética asociada a una enfermedad.', 'inicial', 25),
  ('¿Cuál de estas es una posible implicancia a considerar en el desarrollo de terapias génicas?', '["Los riesgos y beneficios para la salud del paciente, además de consideraciones éticas sobre su uso","Solamente el costo del tratamiento, sin ninguna otra consideración","Ninguna implicancia relevante, ya que estas terapias no tienen riesgos","Solo la opinión de una persona sin conocimiento médico"]', 1, 'Al desarrollar terapias génicas es importante considerar los riesgos y beneficios para la salud del paciente, además de aspectos éticos sobre su uso.', 'intermedia', 35),
  ('¿Por qué el desarrollo de terapias génicas requiere una regulación y supervisión científica y ética cuidadosa?', '["Porque implica intervenir directamente en el material genético de una persona, lo que conlleva riesgos y consideraciones éticas importantes","Porque no existe ningún riesgo asociado a este tipo de terapia","Porque estas terapias no tienen ninguna relación con la genética","Porque la regulación no aporta ningún beneficio en este ámbito"]', 2, 'El desarrollo de terapias génicas requiere regulación y supervisión cuidadosa porque implica intervenir en el material genético de una persona, con riesgos y consideraciones éticas importantes.', 'intermedia', 35),
  ('Un estudiante investiga que una terapia génica experimental ha mostrado resultados prometedores para tratar cierta enfermedad hereditaria grave, pero que también conlleva riesgos que aún se están estudiando, y que su aprobación requiere rigurosos procesos de evaluación científica y ética. ¿Qué idea general sobre las terapias génicas refleja esta información?', '["Que las terapias génicas no requieren ninguna evaluación antes de su uso","Que las terapias génicas pueden ofrecer beneficios importantes para la salud, pero también implican riesgos e implicancias éticas que deben evaluarse cuidadosamente","Que las terapias génicas no tienen ninguna aplicación médica real","Que estas terapias no generan ningún debate ético en la sociedad"]', 3, 'Esta información refleja que las terapias génicas pueden ofrecer beneficios importantes para la salud, pero también implican riesgos e implicancias éticas que deben evaluarse cuidadosamente.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Célula, Tecnología y Sociedad' and l.code = 'regular_4_medio' and lo.short_name = 'Terapias génicas y sus implicancias'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Célula, Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es un alimento transgénico?', '["Un alimento cuyo material genético ha sido modificado mediante técnicas de biotecnología","Un alimento que creció sin ningún cuidado agrícola","Un alimento que solo se cultiva de forma orgánica tradicional","Un alimento que no tiene ninguna relación con la genética"]', 0, 'Un alimento transgénico es aquel cuyo material genético ha sido modificado mediante técnicas de biotecnología.', 'inicial', 25),
  ('¿Cuál de estas es una razón por la que se desarrollan ciertos cultivos transgénicos, según la evidencia disponible?', '["Aumentar la resistencia de los cultivos a ciertas plagas o condiciones ambientales adversas","Hacer que los alimentos pierdan todo su valor nutricional","Reducir intencionalmente la producción agrícola","Eliminar por completo la necesidad de agua para el cultivo"]', 1, 'Uno de los objetivos del desarrollo de cultivos transgénicos es aumentar su resistencia a plagas o condiciones ambientales adversas.', 'intermedia', 35),
  ('¿Por qué los alimentos transgénicos han generado debates sobre seguridad alimentaria en distintos países?', '["Porque existen distintas posturas sobre sus posibles efectos en la salud, el ambiente y la economía agrícola","Porque no existe ninguna controversia sobre este tema","Porque todos los países prohíben completamente estos alimentos sin ninguna excepción","Porque los alimentos transgénicos no tienen ninguna relación con la seguridad alimentaria"]', 2, 'Los alimentos transgénicos han generado debates porque existen distintas posturas sobre sus posibles efectos en la salud, el ambiente y la economía agrícola.', 'intermedia', 35),
  ('Un estudiante investiga que las principales agencias regulatorias de varios países han evaluado la seguridad de ciertos alimentos transgénicos autorizados para el consumo humano, mientras que algunos grupos de la sociedad civil continúan expresando preocupaciones sobre su impacto ambiental y económico a largo plazo. ¿Qué idea general sobre este tema refleja esta información?', '["Que no existe ningún debate sobre los alimentos transgénicos en la sociedad","Que el tema de los alimentos transgénicos combina evaluación científica regulatoria con debates sociales y éticos que persisten","Que todos los científicos y toda la sociedad están completamente de acuerdo sobre este tema","Que los alimentos transgénicos no requieren ninguna evaluación por parte de las autoridades"]', 3, 'Esta información refleja que el tema de los alimentos transgénicos combina evaluación científica regulatoria con debates sociales y éticos que persisten en distintos sectores de la sociedad.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Célula, Tecnología y Sociedad' and l.code = 'regular_4_medio' and lo.short_name = 'Alimentos transgénicos y seguridad alimentaria'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Célula, Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la reproducción asistida, en términos generales?', '["Un conjunto de técnicas médicas que ayudan a personas con dificultades para concebir de forma natural","Un procedimiento exclusivamente estético sin relación con la reproducción","Un tipo de terapia física sin relación con la salud reproductiva","Una técnica que no tiene ninguna aplicación médica"]', 0, 'La reproducción asistida es un conjunto de técnicas médicas que ayudan a personas con dificultades para concebir de forma natural.', 'inicial', 25),
  ('¿Qué distingue conceptualmente a la clonación de otras técnicas de reproducción asistida?', '["La clonación busca generar un organismo genéticamente idéntico a otro ya existente","La clonación es exactamente lo mismo que cualquier otra técnica de reproducción asistida","La clonación no tiene ninguna relación con la genética","La clonación solo se aplica en plantas, nunca en animales"]', 1, 'La clonación busca generar un organismo genéticamente idéntico a otro ya existente, a diferencia de otras técnicas de reproducción asistida.', 'intermedia', 35),
  ('¿Cuál de estos aspectos éticos se discute frecuentemente en relación con la clonación de seres vivos?', '["Las implicancias sobre la identidad, el bienestar del organismo clonado y los límites de su aplicación","Únicamente el costo económico del procedimiento","Ningún aspecto ético relevante, ya que no genera ningún debate","Solo aspectos relacionados con el color del organismo clonado"]', 2, 'Las implicancias sobre la identidad, el bienestar del organismo clonado y los límites de su aplicación son aspectos éticos discutidos frecuentemente sobre la clonación.', 'intermedia', 35),
  ('Un grupo de estudiantes analiza distintas técnicas: por un lado, técnicas de reproducción asistida usadas para ayudar a parejas con dificultades para concebir, y por otro, la clonación de animales con fines de investigación científica. Consideran los beneficios médicos de cada técnica, junto con los dilemas éticos que generan, especialmente en el caso de la clonación. ¿Qué habilidad ciudadana relacionada con la ciencia están desarrollando?', '["Ignorar cualquier consideración ética sobre estas técnicas","Aceptar sin ningún análisis cualquier aplicación de estas tecnologías","Analizar de forma crítica los aspectos científicos y éticos de distintas tecnologías reproductivas","Rechazar automáticamente cualquier avance en este ámbito, sin ningún análisis"]', 3, 'Los estudiantes están desarrollando la habilidad de analizar de forma crítica los aspectos científicos y éticos de distintas tecnologías reproductivas, como la reproducción asistida y la clonación.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Célula, Tecnología y Sociedad' and l.code = 'regular_4_medio' and lo.short_name = 'Reproducción asistida y clonación: aspectos científicos y éticos'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 4° Medio, módulo Célula, Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué rol cumple la evidencia científica en el diseño de políticas de salud pública, como campañas de vacunación?', '["Permite fundamentar decisiones sobre qué medidas son más efectivas para proteger la salud de la población","La evidencia científica no tiene ninguna relación con las políticas de salud pública","Las políticas de salud pública se diseñan sin ninguna consideración científica","La evidencia científica solo es relevante para la investigación, sin aplicación práctica"]', 0, 'La evidencia científica permite fundamentar decisiones sobre qué medidas son más efectivas para proteger la salud de la población.', 'inicial', 25),
  ('¿Por qué las autoridades de salud suelen basar sus recomendaciones, como el uso de mascarillas en un brote de enfermedad respiratoria, en estudios científicos?', '["Porque los estudios científicos aportan evidencia sobre la efectividad de las medidas para reducir el contagio","Porque los estudios científicos no aportan ninguna información relevante para la salud pública","Porque las recomendaciones de salud pública nunca se basan en evidencia","Porque la ciencia no tiene relación con las decisiones de salud pública"]', 1, 'Las autoridades basan sus recomendaciones en estudios científicos porque estos aportan evidencia sobre la efectividad de las medidas para reducir el contagio.', 'intermedia', 35),
  ('¿Cuál de estas situaciones muestra el rol de la ciencia en una política de salud pública?', '["Una campaña de vacunación diseñada a partir de estudios sobre la efectividad y seguridad de una vacuna","Una decisión de salud pública tomada sin ninguna base científica","Una política de salud que ignora por completo cualquier estudio disponible","Una decisión basada únicamente en rumores sin ninguna evidencia"]', 2, 'Una campaña de vacunación diseñada a partir de estudios sobre efectividad y seguridad es un ejemplo del rol de la ciencia en una política de salud pública.', 'intermedia', 35),
  ('Un país decide implementar una campaña de vacunación contra cierta enfermedad después de que estudios científicos rigurosos demostraran que la vacuna reduce significativamente los casos graves y las hospitalizaciones asociadas. ¿Qué relación general ilustra esta decisión entre la ciencia y las políticas de salud pública?', '["Que la ciencia no tiene ninguna influencia en las políticas de salud pública","Que las políticas de salud pública basadas en evidencia científica buscan proteger la salud de la población de forma más efectiva","Que las políticas de salud pública se diseñan sin considerar ningún estudio científico","Que la vacunación no tiene ninguna relación con la evidencia científica"]', 3, 'Esta decisión ilustra que las políticas de salud pública basadas en evidencia científica buscan proteger la salud de la población de forma más efectiva.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Célula, Tecnología y Sociedad' and l.code = 'regular_4_medio' and lo.short_name = 'Rol de la ciencia en políticas de salud pública'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
