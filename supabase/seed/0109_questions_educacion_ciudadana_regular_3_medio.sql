-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Educación
-- Ciudadana (Formación General, asignatura DISTINTA de Historia, Geografía y
-- Ciencias Sociales, ver decisión de modelado en el encabezado de
-- supabase/seed/0098_curriculum_educacion_ciudadana_regular_3_4medio.sql),
-- 3° Medio. Cubre los 16 objetivos de aprendizaje de 3° Medio cargados por
-- 0098 (4 ejes x 4 objetivos), con 4 preguntas por objetivo, total 64
-- preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'. IMPORTANTE: este
-- archivo usa `subject.name = 'Educación Ciudadana'` (canonical_code
-- 'civic_education'), NO 'Estudios Sociales' -- ver la decisión de modelado
-- documentada en 0098.

-- ============================================================================
-- EJE: DEMOCRACIA E INSTITUCIONALIDAD — 3° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Democracia e Institucionalidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa que un país se organice bajo un Estado de derecho?', '["Que tanto los ciudadanos como las autoridades deben someterse a la ley","Que solo los ciudadanos deben cumplir las leyes, sin ninguna obligación para las autoridades","Que las leyes pueden ser ignoradas libremente por cualquier autoridad","Que no existe ninguna norma que organice al país"]', 0, 'Un Estado de derecho significa que tanto los ciudadanos como las autoridades deben someterse a la ley.', 'inicial', 20),
  ('¿Cuál de estos es un elemento fundamental del Estado de derecho?', '["La existencia de leyes claras y conocidas, aplicadas de manera igualitaria","La posibilidad de que una autoridad actúe sin ningún límite legal","La ausencia total de cualquier norma jurídica","La aplicación de leyes distintas según el origen de cada persona"]', 0, 'La existencia de leyes claras y conocidas, aplicadas de manera igualitaria, es un elemento fundamental del Estado de derecho.', 'intermedia', 30),
  ('¿Por qué se dice que el Estado de derecho es una condición necesaria para la democracia?', '["Porque garantiza que el poder se ejerza dentro de límites legales conocidos por todos","Porque el Estado de derecho no tiene ninguna relación con la democracia","Porque en una democracia las autoridades deberían actuar sin ningún límite legal","Porque el Estado de derecho elimina por completo la necesidad de leyes"]', 0, 'El Estado de derecho es una condición necesaria para la democracia porque garantiza que el poder se ejerza dentro de límites legales conocidos por todos.', 'intermedia', 35),
  ('Un estudiante investiga que, en un país con Estado de derecho, un ciudadano puede recurrir a los tribunales si considera que una autoridad actuó fuera de sus atribuciones legales, y que dicha autoridad debe someterse a lo que resuelva el tribunal. ¿Qué principio del Estado de derecho refleja esta situación?', '["Que todas las personas, incluidas las autoridades, están sometidas a la ley y pueden ser sujetas a control judicial","Que las autoridades pueden actuar libremente sin ningún tipo de control","Que los tribunales no tienen ninguna función frente a las autoridades del Estado","Que solo los ciudadanos comunes deben responder ante la justicia"]', 0, 'Esta situación refleja que todas las personas, incluidas las autoridades, están sometidas a la ley y pueden ser sujetas a control judicial, un principio central del Estado de derecho.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Democracia e Institucionalidad' and l.code = 'regular_3_medio' and lo.short_name = 'Fundamentos del Estado de derecho'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Democracia e Institucionalidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos poderes del Estado tiene, entre sus funciones principales, gobernar y administrar el país?', '["El Poder Ejecutivo","El Poder Legislativo","El Poder Judicial","Ninguno de los tres poderes"]', 0, 'El Poder Ejecutivo tiene, entre sus funciones principales, gobernar y administrar el país.', 'inicial', 20),
  ('¿Cuál es la función principal del Poder Judicial dentro de la separación de poderes del Estado?', '["Resolver conflictos legales aplicando las leyes vigentes de forma independiente","Elaborar todas las leyes del país sin ninguna otra intervención","Gobernar directamente el país junto al Poder Ejecutivo","Reemplazar completamente al Congreso Nacional en sus funciones"]', 0, 'La función principal del Poder Judicial es resolver conflictos legales aplicando las leyes vigentes de forma independiente.', 'intermedia', 30),
  ('¿Por qué se considera importante que los tres poderes del Estado (Ejecutivo, Legislativo y Judicial) actúen de forma separada e independiente?', '["Porque esto ayuda a evitar que un solo poder concentre una autoridad excesiva sobre el país","Porque los tres poderes deberían depender completamente uno del otro","Porque la separación de poderes no aporta ningún beneficio al funcionamiento del Estado","Porque un solo poder debería controlar completamente a los otros dos"]', 0, 'Es importante que los tres poderes actúen de forma separada e independiente porque esto ayuda a evitar que un solo poder concentre una autoridad excesiva sobre el país.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, el Congreso Nacional aprueba una ley que regula un tema económico, el Poder Ejecutivo la implementa a través de un ministerio, y los tribunales resuelven un conflicto legal que surge de su aplicación, actuando cada poder de forma independiente. ¿Qué principio de la organización del Estado refleja esta situación?', '["La separación y las funciones específicas de los tres poderes del Estado","La concentración de todo el poder en una sola institución","La ausencia total de independencia entre los poderes del Estado","La eliminación de cualquier función legislativa dentro del Estado"]', 0, 'Esta situación refleja la separación y las funciones específicas de los tres poderes del Estado, actuando cada uno de forma independiente.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Democracia e Institucionalidad' and l.code = 'regular_3_medio' and lo.short_name = 'Separación y funciones de los poderes del Estado'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Democracia e Institucionalidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué rol cumple la Constitución dentro del ordenamiento jurídico de un país?', '["Es la norma fundamental que organiza el Estado y a la cual deben someterse las demás leyes","Es un documento sin ninguna relación con la organización del Estado","Es una norma que puede ser ignorada libremente por cualquier ley posterior","Es un reglamento aplicable solo a un grupo reducido de personas"]', 0, 'La Constitución es la norma fundamental que organiza el Estado y a la cual deben someterse las demás leyes.', 'inicial', 20),
  ('¿Cuál de estos elementos suele estar contenido en la Constitución de un país?', '["Los derechos fundamentales de las personas y la organización de los poderes del Estado","Únicamente normas sobre el tránsito vehicular","Únicamente reglas sobre actividades deportivas","Únicamente disposiciones sobre el comercio internacional"]', 0, 'Los derechos fundamentales de las personas y la organización de los poderes del Estado suelen estar contenidos en la Constitución de un país.', 'intermedia', 30),
  ('¿Por qué se afirma que la Constitución tiene una jerarquía superior a otras leyes del país?', '["Porque cualquier ley que la contradiga puede ser declarada inaplicable o inconstitucional","Porque la Constitución no tiene ninguna relación con las demás leyes del país","Porque cualquier ley puede modificar libremente el contenido de la Constitución","Porque la Constitución solo aplica a un grupo reducido de personas"]', 0, 'La Constitución tiene una jerarquía superior porque cualquier ley que la contradiga puede ser declarada inaplicable o inconstitucional.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, existe un tribunal encargado de revisar si una ley aprobada por el Congreso respeta lo establecido en la Constitución, pudiendo declararla inconstitucional si no la respeta. ¿Qué principio sobre la Constitución refleja esta información?', '["Que la Constitución, como norma fundamental, tiene mecanismos institucionales que aseguran su cumplimiento frente a otras leyes","Que la Constitución no tiene ninguna forma de hacerse cumplir frente a otras leyes","Que cualquier ley puede contradecir libremente a la Constitución sin ninguna consecuencia","Que no existe ningún tribunal encargado de revisar la constitucionalidad de las leyes"]', 0, 'Esta información refleja que la Constitución, como norma fundamental, tiene mecanismos institucionales que aseguran su cumplimiento frente a otras leyes.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Democracia e Institucionalidad' and l.code = 'regular_3_medio' and lo.short_name = 'La Constitución como norma fundamental'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Democracia e Institucionalidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se entiende por "transparencia" en el ejercicio del poder público?', '["Que la información sobre la gestión de las autoridades públicas sea accesible para la ciudadanía","Que las autoridades públicas puedan ocultar toda su gestión sin ninguna consecuencia","Que la ciudadanía no tenga acceso a ninguna información sobre la gestión pública","Que la información pública solo esté disponible para algunas personas"]', 0, 'La transparencia en el ejercicio del poder público significa que la información sobre la gestión de las autoridades públicas sea accesible para la ciudadanía.', 'inicial', 20),
  ('¿Cuál de estas es una institución de control del poder público en Chile?', '["La Contraloría General de la República","Una empresa privada de telecomunicaciones","Un club social sin fines de lucro","Una universidad privada"]', 0, 'La Contraloría General de la República es una institución de control del poder público en Chile.', 'intermedia', 30),
  ('¿Por qué se considera importante la existencia de mecanismos de transparencia y probidad en la administración pública?', '["Porque ayudan a prevenir el mal uso de recursos públicos y a fortalecer la confianza ciudadana en las instituciones","Porque estos mecanismos no tienen ninguna relación con el buen uso de los recursos públicos","Porque la transparencia dificulta el funcionamiento de las instituciones públicas","Porque la ciudadanía no debería conocer ninguna información sobre la gestión pública"]', 0, 'Los mecanismos de transparencia y probidad son importantes porque ayudan a prevenir el mal uso de recursos públicos y a fortalecer la confianza ciudadana en las instituciones.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, existe una ley de transparencia que permite a cualquier ciudadano solicitar información sobre el uso de recursos públicos por parte de un organismo del Estado, y que la Contraloría General de la República puede fiscalizar el uso de esos recursos. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que existen mecanismos institucionales que buscan garantizar la transparencia y el control del poder público en Chile","Que no existe ningún mecanismo de control sobre el uso de recursos públicos en Chile","Que la ciudadanía no puede solicitar ningún tipo de información pública","Que la Contraloría General de la República no tiene ninguna función de fiscalización"]', 0, 'Esta información es consistente con la idea de que existen mecanismos institucionales que buscan garantizar la transparencia y el control del poder público en Chile.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Democracia e Institucionalidad' and l.code = 'regular_3_medio' and lo.short_name = 'Mecanismos de transparencia y control del poder público'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: DERECHOS, DEBERES Y ESTADO DE DERECHO — 3° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Derechos, Deberes y Estado de Derecho. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un ejemplo de tratado internacional que reconoce derechos humanos y ha sido suscrito por Chile?', '["La Convención Americana sobre Derechos Humanos","Un tratado exclusivamente comercial entre dos empresas","Un acuerdo deportivo entre dos países","Un convenio sobre el uso de un idioma específico"]', 0, 'La Convención Americana sobre Derechos Humanos es un ejemplo de tratado internacional que reconoce derechos humanos y ha sido suscrito por Chile.', 'inicial', 20),
  ('¿Qué implica para un país haber ratificado un tratado internacional de derechos humanos?', '["Asumir el compromiso de respetar y garantizar esos derechos dentro de su territorio","No tener ninguna obligación relacionada con esos derechos","Poder ignorar libremente lo establecido en ese tratado","Aplicar esos derechos únicamente a un grupo reducido de personas"]', 0, 'Ratificar un tratado internacional de derechos humanos implica asumir el compromiso de respetar y garantizar esos derechos dentro del territorio del país.', 'intermedia', 30),
  ('¿Por qué se considera relevante que existan tratados internacionales de derechos humanos, además de las leyes internas de cada país?', '["Porque establecen estándares comunes que buscan proteger a las personas más allá de las decisiones de un solo gobierno","Porque los tratados internacionales no tienen ninguna relación con la protección de las personas","Porque las leyes internas de un país siempre son suficientes, sin necesidad de ningún tratado","Porque estos tratados solo protegen a las autoridades de un país"]', 0, 'Los tratados internacionales de derechos humanos son relevantes porque establecen estándares comunes que buscan proteger a las personas más allá de las decisiones de un solo gobierno.', 'intermedia', 35),
  ('Un estudiante investiga que Chile ha suscrito y ratificado distintos tratados internacionales de derechos humanos, y que estos tratados pueden ser invocados ante tribunales nacionales e internacionales si una persona considera que sus derechos han sido vulnerados. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los tratados internacionales de derechos humanos suscritos por Chile forman parte de un sistema de protección que puede exigirse ante distintas instancias","Que estos tratados no tienen ninguna aplicación práctica dentro de Chile","Que Chile no ha suscrito ningún tratado internacional de derechos humanos","Que las personas no pueden invocar ningún tratado internacional ante ningún tribunal"]', 0, 'Esta información es consistente con la idea de que los tratados internacionales de derechos humanos suscritos por Chile forman parte de un sistema de protección que puede exigirse ante distintas instancias.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Derechos, Deberes y Estado de Derecho' and l.code = 'regular_3_medio' and lo.short_name = 'Derechos humanos en tratados internacionales'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Derechos, Deberes y Estado de Derecho. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un derecho constitucional reconocido a las personas en Chile?', '["La libertad de expresión","El derecho a ignorar cualquier ley del país","El derecho a imponer la propia voluntad sobre los demás sin ningún límite","El derecho exclusivo de un solo grupo de personas"]', 0, 'La libertad de expresión es un derecho constitucional reconocido a las personas en Chile.', 'inicial', 20),
  ('¿Cuál de estos es un deber constitucional que corresponde a las personas en Chile?', '["Respetar la Constitución y las leyes del país","No tener ninguna obligación frente al Estado","Ignorar las normas legales cuando lo estime conveniente","Imponer sus propias reglas sin considerar la legislación vigente"]', 0, 'Respetar la Constitución y las leyes del país es un deber constitucional que corresponde a las personas en Chile.', 'intermedia', 30),
  ('¿Por qué se dice que los derechos y deberes constitucionales están relacionados entre sí?', '["Porque ejercer los propios derechos implica también respetar los derechos y deberes de los demás","Porque tener derechos constitucionales significa no tener ningún deber","Porque los deberes constitucionales no tienen ninguna relación con los derechos de las personas","Porque solo algunas personas tienen deberes constitucionales"]', 0, 'Los derechos y deberes constitucionales están relacionados porque ejercer los propios derechos implica también respetar los derechos y deberes de los demás.', 'intermedia', 35),
  ('Un estudiante investiga que la Constitución chilena reconoce el derecho a la libertad de expresión, pero también establece deberes, como el respeto a la honra de las demás personas, que deben considerarse al ejercer ese derecho. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los derechos constitucionales, como la libertad de expresión, deben ejercerse considerando también los deberes hacia los demás","Que la libertad de expresión no tiene ningún límite ni deber asociado","Que los deberes constitucionales no tienen ninguna relación con el ejercicio de derechos","Que solo las autoridades tienen deberes constitucionales, no los ciudadanos"]', 0, 'Esta información es consistente con la idea de que los derechos constitucionales deben ejercerse considerando también los deberes hacia los demás.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Derechos, Deberes y Estado de Derecho' and l.code = 'regular_3_medio' and lo.short_name = 'Derechos y deberes constitucionales'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Derechos, Deberes y Estado de Derecho. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa el principio de igualdad ante la ley?', '["Que todas las personas deben ser tratadas de la misma forma por la ley, sin distinciones arbitrarias","Que la ley se aplica de forma distinta según el origen de cada persona","Que solo un grupo de personas debe ser tratado con igualdad ante la ley","Que la ley no aplica de la misma forma a las autoridades y a los ciudadanos"]', 0, 'El principio de igualdad ante la ley significa que todas las personas deben ser tratadas de la misma forma por la ley, sin distinciones arbitrarias.', 'inicial', 20),
  ('¿Cuál de estas es una forma de discriminación que la ley busca prevenir?', '["Un trato desigual injustificado basado en características como el origen étnico o el género","Un trato igualitario ante situaciones idénticas","La aplicación de la misma ley a todas las personas","El reconocimiento de los mismos derechos para todas las personas"]', 0, 'Un trato desigual injustificado basado en características como el origen étnico o el género es una forma de discriminación que la ley busca prevenir.', 'intermedia', 30),
  ('¿Por qué se considera que la igualdad ante la ley y la no discriminación son principios fundamentales de un Estado de derecho?', '["Porque garantizan que ninguna persona reciba un trato arbitrario o injusto por parte del sistema legal","Porque estos principios no tienen ninguna relación con el Estado de derecho","Porque la ley debería tratar de forma diferente a las personas según su origen","Porque la igualdad ante la ley solo debería aplicarse a un grupo reducido de personas"]', 0, 'La igualdad ante la ley y la no discriminación son principios fundamentales porque garantizan que ninguna persona reciba un trato arbitrario o injusto por parte del sistema legal.', 'intermedia', 35),
  ('Un estudiante investiga un caso en que una persona fue objeto de un trato desigual injustificado en un proceso de contratación laboral, debido a su origen étnico, y que esta situación fue denunciada ante una institución encargada de velar por la no discriminación. ¿Qué principio se buscó proteger con esta denuncia?', '["La igualdad ante la ley y la no discriminación de las personas","La posibilidad de discriminar libremente en procesos de contratación laboral","La eliminación de cualquier ley relacionada con la no discriminación","La aplicación desigual de la ley según el origen de las personas"]', 0, 'Con esta denuncia se buscó proteger la igualdad ante la ley y la no discriminación de las personas, principios fundamentales del Estado de derecho.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Derechos, Deberes y Estado de Derecho' and l.code = 'regular_3_medio' and lo.short_name = 'Igualdad ante la ley y no discriminación'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Derechos, Deberes y Estado de Derecho. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un mecanismo institucional de protección de derechos disponible en Chile?', '["Los tribunales de justicia, ante los cuales una persona puede reclamar la vulneración de un derecho","Un club deportivo sin ninguna relación con la protección de derechos","Una empresa privada dedicada exclusivamente al comercio","Un organismo internacional sin ninguna representación en Chile"]', 0, 'Los tribunales de justicia, ante los cuales una persona puede reclamar la vulneración de un derecho, son un mecanismo institucional de protección de derechos en Chile.', 'inicial', 20),
  ('¿Cuál es la función del Instituto Nacional de Derechos Humanos en Chile?', '["Promover y proteger los derechos humanos, además de elaborar informes sobre su situación en el país","Reemplazar completamente al Poder Judicial","Administrar directamente los ministerios del gobierno","No tener ninguna función relacionada con los derechos humanos"]', 0, 'El Instituto Nacional de Derechos Humanos tiene como función promover y proteger los derechos humanos, además de elaborar informes sobre su situación en el país.', 'intermedia', 30),
  ('¿Por qué es importante que existan mecanismos institucionales de protección de derechos, y no solo el reconocimiento formal de esos derechos en la ley?', '["Porque permiten que las personas puedan exigir efectivamente el cumplimiento de sus derechos cuando son vulnerados","Porque el reconocimiento formal de un derecho siempre es suficiente para garantizar su cumplimiento","Porque estos mecanismos no tienen ninguna utilidad práctica para las personas","Porque las personas no deberían poder exigir el cumplimiento de sus derechos"]', 0, 'Es importante que existan mecanismos institucionales porque permiten que las personas puedan exigir efectivamente el cumplimiento de sus derechos cuando son vulnerados.', 'intermedia', 35),
  ('Un estudiante investiga que, cuando una persona considera que un derecho fundamental ha sido vulnerado por una autoridad, puede recurrir a los tribunales de justicia mediante acciones legales específicas, y que instituciones como el Instituto Nacional de Derechos Humanos pueden acompañar o documentar este tipo de situaciones. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que en Chile existen mecanismos institucionales concretos que permiten a las personas buscar protección frente a la vulneración de un derecho","Que no existe ningún mecanismo para proteger los derechos de las personas en Chile","Que las personas nunca pueden recurrir a los tribunales frente a la vulneración de un derecho","Que el Instituto Nacional de Derechos Humanos no cumple ninguna función en este ámbito"]', 0, 'Esta información es consistente con la idea de que en Chile existen mecanismos institucionales concretos que permiten a las personas buscar protección frente a la vulneración de un derecho.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Derechos, Deberes y Estado de Derecho' and l.code = 'regular_3_medio' and lo.short_name = 'Mecanismos de protección de derechos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: PARTICIPACIÓN CIUDADANA Y SOCIEDAD CIVIL — 3° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Participación Ciudadana y Sociedad Civil. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma de participación ciudadana individual?', '["Votar en una elección","Impedir que otras personas participen en una elección","Ignorar por completo cualquier proceso electoral","Anular intencionalmente el voto de otra persona"]', 0, 'Votar en una elección es una forma de participación ciudadana individual.', 'inicial', 20),
  ('¿Cuál de estas es una forma de participación ciudadana colectiva?', '["Integrarse a una organización social para representar intereses comunes","Actuar siempre de forma aislada, sin ninguna organización","Impedir que un grupo de personas se organice","Ignorar cualquier interés compartido con otras personas"]', 0, 'Integrarse a una organización social para representar intereses comunes es una forma de participación ciudadana colectiva.', 'intermedia', 30),
  ('¿Por qué se considera que existen distintas formas de participación ciudadana disponibles en una democracia?', '["Porque las personas pueden involucrarse en la vida pública de distintas maneras, según sus intereses y posibilidades","Porque solo existe una única forma válida de participación ciudadana","Porque la participación ciudadana no tiene ninguna relación con la vida pública","Porque en una democracia no debería existir ninguna forma de participación"]', 0, 'Existen distintas formas de participación ciudadana porque las personas pueden involucrarse en la vida pública de distintas maneras, según sus intereses y posibilidades.', 'intermedia', 35),
  ('Un estudiante investiga que, además de votar en elecciones, la ciudadanía puede participar informándose sobre temas públicos, integrándose a organizaciones sociales, comunicándose con sus representantes, o participando en instancias de consulta ciudadana. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que existen múltiples formas de participación ciudadana individual y colectiva disponibles en una democracia","Que votar en elecciones es la única forma de participación ciudadana existente","Que la ciudadanía no tiene ninguna forma de participar entre una elección y otra","Que participar en organizaciones sociales no tiene ninguna relación con la ciudadanía"]', 0, 'Esta información es consistente con la idea de que existen múltiples formas de participación ciudadana individual y colectiva disponibles en una democracia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Participación Ciudadana y Sociedad Civil' and l.code = 'regular_3_medio' and lo.short_name = 'Formas de participación ciudadana'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Participación Ciudadana y Sociedad Civil. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una organización de la sociedad civil?', '["Una organización no gubernamental (ONG) dedicada a una causa social","Un ministerio del gobierno","Un tribunal de justicia","Una empresa cuyo único fin es obtener ganancias"]', 0, 'Una organización no gubernamental (ONG) dedicada a una causa social es una organización de la sociedad civil.', 'inicial', 20),
  ('¿Cuál es el rol habitual de las organizaciones de la sociedad civil en la promoción de derechos?', '["Representar intereses de un grupo específico y visibilizar demandas ante la sociedad y el Estado","Reemplazar completamente al Estado en todas sus funciones","Impedir que otros grupos expresen sus demandas","No tener ninguna relación con la promoción de derechos"]', 0, 'El rol habitual de las organizaciones de la sociedad civil es representar intereses de un grupo específico y visibilizar demandas ante la sociedad y el Estado.', 'intermedia', 30),
  ('¿Por qué se considera importante la existencia de organizaciones de la sociedad civil dentro de una democracia?', '["Porque permiten canalizar demandas ciudadanas y fiscalizar la acción de las autoridades","Porque estas organizaciones no aportan ningún beneficio a la sociedad","Porque solo el Estado debería representar los intereses de las personas","Porque la existencia de estas organizaciones dificulta el funcionamiento de una democracia"]', 0, 'Es importante la existencia de organizaciones de la sociedad civil porque permiten canalizar demandas ciudadanas y fiscalizar la acción de las autoridades.', 'intermedia', 35),
  ('Un estudiante investiga que, en Chile, distintas organizaciones de la sociedad civil han impulsado demandas relacionadas con derechos humanos, medioambiente o protección al consumidor, generando cambios en políticas públicas y leyes. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que las organizaciones de la sociedad civil pueden influir en la promoción de derechos y en la formulación de políticas públicas","Que estas organizaciones no tienen ninguna influencia en las políticas públicas","Que solo el Estado puede impulsar cambios en la sociedad, sin ninguna participación civil","Que las organizaciones de la sociedad civil no existen en Chile"]', 0, 'Esta información es consistente con la idea de que las organizaciones de la sociedad civil pueden influir en la promoción de derechos y en la formulación de políticas públicas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Participación Ciudadana y Sociedad Civil' and l.code = 'regular_3_medio' and lo.short_name = 'Organizaciones de la sociedad civil'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Participación Ciudadana y Sociedad Civil. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un espacio de representación juvenil disponible en muchos colegios de Chile?', '["El Centro de Estudiantes","Un ministerio del gobierno","Un tribunal de justicia","Una empresa privada"]', 0, 'El Centro de Estudiantes es un espacio de representación juvenil disponible en muchos colegios de Chile.', 'inicial', 20),
  ('¿Por qué se considera valioso evaluar los espacios de participación y representación disponibles para adolescentes y jóvenes?', '["Porque permite identificar oportunidades concretas para que se involucren en decisiones que los afectan","Porque la participación juvenil no tiene ninguna relevancia social","Porque los jóvenes no deberían participar en ningún espacio de representación","Porque evaluar estos espacios no aporta ningún beneficio a los jóvenes"]', 0, 'Es valioso evaluar estos espacios porque permite identificar oportunidades concretas para que los adolescentes y jóvenes se involucren en decisiones que los afectan.', 'intermedia', 30),
  ('¿Cuál de estos es un ejemplo de participación juvenil más allá del ámbito escolar?', '["Integrarse a una organización juvenil de su comunidad","No participar nunca en ninguna actividad comunitaria","Impedir que otros jóvenes se organicen","Ignorar cualquier necesidad de su comunidad"]', 0, 'Integrarse a una organización juvenil de su comunidad es un ejemplo de participación juvenil más allá del ámbito escolar.', 'intermedia', 35),
  ('Un grupo de estudiantes, integrantes del Centro de Estudiantes de su colegio, organiza una consulta a sus compañeros sobre un cambio en el reglamento escolar y presenta una propuesta fundamentada a la dirección. ¿Qué principio de participación estudiantil se refleja en esta situación?', '["La organización estudiantil para representar la opinión de sus compañeros y proponer cambios ante la autoridad escolar","La imposición de una decisión sin ninguna consulta a los demás estudiantes","La ausencia total de participación estudiantil en el colegio","La imposibilidad de que los estudiantes influyan en decisiones escolares"]', 0, 'Esta situación refleja el principio de organización estudiantil para representar la opinión de sus compañeros y proponer cambios ante la autoridad escolar.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Participación Ciudadana y Sociedad Civil' and l.code = 'regular_3_medio' and lo.short_name = 'Participación estudiantil y espacios de representación juvenil'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Participación Ciudadana y Sociedad Civil. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es el rol habitual de los medios de comunicación en la participación ciudadana?', '["Informar a la ciudadanía sobre temas públicos y contribuir a la formación de opinión","Reemplazar completamente a las autoridades electas","Impedir que la ciudadanía se informe sobre temas públicos","No tener ninguna relación con la participación ciudadana"]', 0, 'El rol habitual de los medios de comunicación es informar a la ciudadanía sobre temas públicos y contribuir a la formación de opinión.', 'inicial', 20),
  ('¿Por qué se considera relevante que existan medios de comunicación diversos en una democracia?', '["Porque permiten que la ciudadanía acceda a distintas perspectivas antes de formarse una opinión","Porque tener medios diversos dificulta la participación ciudadana","Porque un único medio de comunicación siempre es suficiente para informar a toda la ciudadanía","Porque los medios de comunicación no tienen ninguna relación con la opinión pública"]', 0, 'Es relevante que existan medios diversos porque permiten que la ciudadanía acceda a distintas perspectivas antes de formarse una opinión.', 'intermedia', 30),
  ('¿Cuál de estas es una forma en que las redes sociales han cambiado la participación ciudadana en las últimas décadas?', '["Permitiendo que más personas expresen opiniones y organicen acciones colectivas de forma más rápida","Eliminando por completo cualquier forma de participación ciudadana","Impidiendo que la ciudadanía acceda a cualquier tipo de información","Reemplazando completamente a los medios de comunicación tradicionales"]', 0, 'Las redes sociales han cambiado la participación ciudadana permitiendo que más personas expresen opiniones y organicen acciones colectivas de forma más rápida.', 'intermedia', 35),
  ('Un estudiante investiga que, durante un debate público reciente, distintos medios de comunicación entregaron información y análisis que ayudaron a la ciudadanía a formarse una opinión, mientras que las redes sociales se transformaron en un espacio de discusión y organización ciudadana. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que los medios de comunicación, junto con las redes sociales, cumplen un rol relevante en la participación ciudadana actual","Que los medios de comunicación no tienen ninguna relación con la formación de opinión pública","Que las redes sociales no cumplen ningún rol en la participación ciudadana","Que solo un tipo de medio puede influir en la opinión pública"]', 0, 'Esta información es consistente con la idea de que los medios de comunicación, junto con las redes sociales, cumplen un rol relevante en la participación ciudadana actual.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Participación Ciudadana y Sociedad Civil' and l.code = 'regular_3_medio' and lo.short_name = 'Medios de comunicación y participación ciudadana'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIUDADANÍA, ECONOMÍA Y GLOBALIZACIÓN — 3° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Ciudadanía, Economía y Globalización. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una función que el Estado puede cumplir dentro de la economía de un país?', '["Regular ciertas actividades económicas mediante leyes y políticas públicas","Eliminar por completo cualquier actividad económica privada","No tener ninguna relación con la economía del país","Prohibir toda forma de comercio dentro del país"]', 0, 'Regular ciertas actividades económicas mediante leyes y políticas públicas es una función que el Estado puede cumplir dentro de la economía.', 'inicial', 20),
  ('¿Qué se entiende por "mercado" en el contexto de la economía de un país?', '["El espacio de intercambio de bienes y servicios entre oferentes y demandantes","Un edificio específico donde solo se venden alimentos","Una institución exclusivamente estatal","Un concepto sin ninguna relación con la economía"]', 0, 'El "mercado" se refiere al espacio de intercambio de bienes y servicios entre oferentes y demandantes.', 'intermedia', 30),
  ('¿Por qué han existido, a lo largo de la historia, distintas concepciones sobre el rol que debería tener el Estado frente al mercado?', '["Porque distintas corrientes de pensamiento económico proponen distintos niveles de intervención estatal en la economía","Porque el rol del Estado en la economía siempre ha sido exactamente el mismo en todo el mundo","Porque esta discusión no tiene ninguna relación con la organización económica de un país","Porque el Estado nunca ha tenido ninguna relación con el mercado"]', 0, 'Han existido distintas concepciones porque distintas corrientes de pensamiento económico proponen distintos niveles de intervención estatal en la economía.', 'intermedia', 35),
  ('Un estudiante investiga que, en distintos países, se aplican políticas económicas con mayor o menor participación del Estado en sectores como la salud, la educación o las pensiones, generando distintos efectos y debates sobre su conveniencia. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el rol del Estado frente al mercado ha sido y sigue siendo un tema de debate en distintas sociedades","Que el rol del Estado en la economía nunca genera ningún debate","Que el Estado nunca participa en sectores como la salud o la educación","Que las políticas económicas son exactamente iguales en todos los países del mundo"]', 0, 'Esta información es consistente con la idea de que el rol del Estado frente al mercado ha sido y sigue siendo un tema de debate en distintas sociedades.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Ciudadanía, Economía y Globalización' and l.code = 'regular_3_medio' and lo.short_name = 'Rol del Estado y el mercado en la economía'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Ciudadanía, Economía y Globalización. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una práctica de consumo responsable?', '["Informarse sobre un producto antes de comprarlo, considerando su necesidad real","Comprar productos sin ninguna consideración sobre su necesidad","Ignorar por completo cualquier información sobre un producto","Desechar productos en buen estado sin ninguna razón"]', 0, 'Informarse sobre un producto antes de comprarlo, considerando su necesidad real, es una práctica de consumo responsable.', 'inicial', 20),
  ('¿Cuál de estos es un derecho del consumidor reconocido en Chile?', '["El derecho a recibir información veraz sobre un producto o servicio","El derecho a que una empresa entregue información falsa sobre un producto","El derecho exclusivo de las empresas, sin ninguna protección para el consumidor","El derecho a que un producto nunca tenga ninguna garantía"]', 0, 'El derecho a recibir información veraz sobre un producto o servicio es un derecho del consumidor reconocido en Chile.', 'intermedia', 30),
  ('¿Por qué se considera importante conocer los derechos del consumidor al evaluar prácticas de consumo responsable?', '["Porque permite exigir información y condiciones justas al momento de adquirir un producto o servicio","Porque los derechos del consumidor no tienen ninguna relación con el consumo responsable","Porque las empresas nunca deben responder ante los consumidores","Porque conocer estos derechos dificulta las decisiones de consumo"]', 0, 'Conocer los derechos del consumidor es importante porque permite exigir información y condiciones justas al momento de adquirir un producto o servicio.', 'intermedia', 35),
  ('Un estudiante, antes de comprar un electrodoméstico, compara distintas marcas, revisa la información sobre su consumo energético y garantía, y verifica si la empresa cumple con la normativa de protección al consumidor. ¿Qué principio de consumo responsable y derechos del consumidor está aplicando?', '["Evaluar información relevante y ejercer sus derechos como consumidor antes de tomar una decisión de compra","Comprar sin ninguna consideración sobre la información disponible","Ignorar por completo los derechos del consumidor","Basar su decisión únicamente en la publicidad del producto"]', 0, 'El estudiante está evaluando información relevante y ejerciendo sus derechos como consumidor antes de tomar una decisión de compra, un principio clave del consumo responsable.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Ciudadanía, Economía y Globalización' and l.code = 'regular_3_medio' and lo.short_name = 'Consumo responsable y derechos del consumidor'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Ciudadanía, Economía y Globalización. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es un impuesto?', '["Un aporte obligatorio que las personas y empresas realizan al Estado para financiar el bien común","Un pago voluntario que las personas pueden decidir no realizar","Un beneficio que el Estado entrega directamente a las empresas","Un concepto sin ninguna relación con el financiamiento del Estado"]', 0, 'Un impuesto es un aporte obligatorio que las personas y empresas realizan al Estado para financiar el bien común.', 'inicial', 20),
  ('¿Cuál de estos servicios suele financiarse, en parte, mediante la recaudación de impuestos en Chile?', '["La educación pública","Un producto vendido exclusivamente por una empresa privada","Un servicio ofrecido únicamente en otro país","Un bien que no tiene relación con el gasto público"]', 0, 'La educación pública suele financiarse, en parte, mediante la recaudación de impuestos en Chile.', 'intermedia', 30),
  ('¿Por qué se relaciona el sistema tributario con el concepto de "bien común"?', '["Porque los recursos recaudados mediante impuestos suelen destinarse a servicios y bienes que benefician a la sociedad en su conjunto","Porque los impuestos no tienen ninguna relación con el bienestar de la sociedad","Porque el sistema tributario solo beneficia a un grupo reducido de personas","Porque el bien común no depende de ningún recurso económico"]', 0, 'El sistema tributario se relaciona con el bien común porque los recursos recaudados mediante impuestos suelen destinarse a servicios y bienes que benefician a la sociedad en su conjunto.', 'intermedia', 35),
  ('Un estudiante investiga que los impuestos recaudados en Chile financian, entre otros servicios, hospitales públicos, escuelas y programas sociales, y que existen debates sobre cómo debería distribuirse esa recaudación entre distintas necesidades del país. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que el sistema tributario cumple un rol importante en el financiamiento de servicios orientados al bien común, aunque su distribución puede generar debate","Que los impuestos no financian ningún servicio público en Chile","Que no existe ningún debate sobre la distribución de la recaudación tributaria","Que el sistema tributario no tiene ninguna relación con hospitales ni escuelas"]', 0, 'Esta información es consistente con la idea de que el sistema tributario cumple un rol importante en el financiamiento de servicios orientados al bien común, aunque su distribución puede generar debate.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Ciudadanía, Economía y Globalización' and l.code = 'regular_3_medio' and lo.short_name = 'Sistema tributario y bien común'
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
  'Pregunta ValidApp (borrador), Educación Ciudadana 3° Medio, eje Ciudadanía, Economía y Globalización. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un desafío ético relacionado con el uso de redes sociales?', '["La difusión de información falsa o no verificada","El acceso a información verificada de fuentes confiables","La comunicación respetuosa entre distintas personas","El uso de la tecnología para fines educativos"]', 0, 'La difusión de información falsa o no verificada es un desafío ético relacionado con el uso de redes sociales.', 'inicial', 20),
  ('¿Por qué se considera importante actuar de forma ética al usar tecnologías digitales, como las redes sociales?', '["Porque las acciones en el entorno digital pueden afectar a otras personas, igual que en la vida presencial","Porque las acciones realizadas en internet nunca tienen ninguna consecuencia","Porque la ética no tiene ninguna relación con el uso de tecnologías digitales","Porque en el entorno digital no existe ninguna responsabilidad personal"]', 0, 'Es importante actuar de forma ética en el entorno digital porque las acciones allí realizadas pueden afectar a otras personas, igual que en la vida presencial.', 'intermedia', 30),
  ('¿Cuál de estas es una acción que refleja ciudadanía digital responsable?', '["Verificar la veracidad de una información antes de compartirla en redes sociales","Compartir cualquier información sin verificar su origen","Difundir rumores sin ninguna base en evidencia","Ignorar el posible daño que puede causar una publicación falsa"]', 0, 'Verificar la veracidad de una información antes de compartirla en redes sociales es una acción que refleja ciudadanía digital responsable.', 'intermedia', 35),
  ('Un estudiante recibe un mensaje con información alarmante sobre un tema de salud pública, sin ninguna fuente que la respalde. Antes de compartirlo, decide verificar la información en fuentes oficiales, y al comprobar que es falsa, decide no reenviarlo y advertir a quien se lo envió. ¿Qué desafío ético de la ciudadanía digital está abordando el estudiante?', '["La responsabilidad frente a la difusión de información falsa en el entorno digital","La obligación de compartir cualquier información recibida, sin ninguna verificación","La imposibilidad de verificar información en el entorno digital","La irrelevancia de la veracidad de la información en redes sociales"]', 0, 'El estudiante está abordando la responsabilidad frente a la difusión de información falsa en el entorno digital, un desafío ético central de la ciudadanía digital.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Educación Ciudadana') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana')
    and s.name = 'Ciudadanía, Economía y Globalización' and l.code = 'regular_3_medio' and lo.short_name = 'Desafíos éticos de la ciudadanía digital'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
