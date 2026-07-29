-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- para la Ciudadanía (Formación General, asignatura DISTINTA de Ciencias
-- Naturales, ver decisión de modelado en el encabezado de
-- supabase/seed/0019_curriculum_ciencias_ciudadania_regular_3_4medio.sql),
-- 3° Medio. Cubre los 16 objetivos de aprendizaje de 3° Medio cargados por
-- 0019 (4 módulos x 4 objetivos), con 4 preguntas por objetivo, total 64
-- preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí). IMPORTANTE: este archivo usa `subject.name = 'Ciencias
-- para la Ciudadanía'` (canonical_code 'citizen_science'), NO 'Ciencias
-- Naturales' -- ver la decisión de modelado documentada en 0019.
--
-- NOTA PEDAGÓGICA ADICIONAL sobre el objetivo ''Salud reproductiva y sexual
-- con enfoque ciudadano'': las preguntas se redactaron con un enfoque
-- estrictamente preventivo/informativo (autocuidado, acceso a información
-- confiable, toma de decisiones), sin contenido explícito ni gráfico,
-- apropiado para 3° Medio. Se recomienda revisión pedagógica adicional
-- antes de su uso, dada la sensibilidad del tema.

-- ============================================================================
-- MÓDULO: SEGURIDAD, PREVENCIÓN Y AUTOCUIDADO — 3° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Seguridad, Prevención y Autocuidado. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos riesgos cotidianos puede analizarse con base en evidencia científica?', '["La exposición prolongada al ruido muy fuerte","El color de la ropa que uno usa","El sabor de un alimento","El nombre de una calle"]', 0, 'La exposición prolongada al ruido muy fuerte es un riesgo cotidiano que se puede analizar con evidencia científica sobre sus efectos en la audición.', 'inicial', 25),
  ('¿Por qué es útil usar evidencia científica, y no solo opiniones personales, al evaluar un riesgo cotidiano como el uso de productos de limpieza en el hogar?', '["Porque la evidencia científica permite conocer con mayor precisión los efectos reales del riesgo","Porque las opiniones personales siempre son más confiables que la evidencia científica","Porque no es necesario evaluar ningún riesgo cotidiano","Porque la ciencia no tiene relación con los riesgos del hogar"]', 1, 'La evidencia científica permite conocer con mayor precisión los efectos reales de un riesgo, en vez de basarse solo en opiniones personales.', 'intermedia', 35),
  ('¿Qué información es relevante buscar para analizar científicamente el riesgo de exponerse muchas horas al sol sin protección?', '["Datos científicos sobre los efectos de la radiación ultravioleta en la piel","Solo la opinión de una persona sin conocimiento del tema","El color de la ropa que se usará ese día","El precio de un bloqueador solar"]', 2, 'Los datos científicos sobre los efectos de la radiación ultravioleta en la piel son relevantes para analizar este riesgo cotidiano.', 'intermedia', 35),
  ('Un estudiante investiga estudios científicos sobre los efectos del uso prolongado de audífonos a alto volumen en la audición, y concluye que existe evidencia de que esta práctica puede dañar el oído con el tiempo. ¿Qué habilidad ciudadana relacionada con la ciencia está aplicando este estudiante?', '["Ignorar la evidencia científica disponible","Basar sus decisiones únicamente en modas o costumbres","Analizar un riesgo cotidiano con base en evidencia científica","Evitar cualquier tipo de análisis sobre riesgos cotidianos"]', 3, 'El estudiante está aplicando la habilidad de analizar un riesgo cotidiano con base en evidencia científica, un objetivo central de este módulo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Seguridad, Prevención y Autocuidado' and l.code = 'regular_3_medio' and lo.short_name = 'Análisis de riesgos cotidianos con base científica'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Seguridad, Prevención y Autocuidado. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas acciones corresponde a un procedimiento básico de primeros auxilios frente a una quemadura leve?', '["Enfriar la zona afectada con agua limpia y fresca","Aplicar hielo directamente sobre la piel quemada","Reventar cualquier ampolla que se forme","Ignorar la quemadura sin ninguna atención"]', 0, 'Enfriar la zona afectada con agua limpia y fresca es una medida básica recomendada frente a una quemadura leve.', 'inicial', 25),
  ('¿Qué se recomienda hacer primero al encontrar a una persona que se desmayó, antes de aplicar cualquier otra medida?', '["Verificar que el entorno sea seguro y comprobar si la persona responde","Moverla bruscamente de inmediato","Darle de comer o beber de inmediato","Dejarla sola en el lugar"]', 1, 'Antes de aplicar cualquier otra medida, se recomienda verificar que el entorno sea seguro y comprobar si la persona responde.', 'intermedia', 35),
  ('¿Por qué es importante pedir ayuda a un servicio de emergencia frente a una situación de primeros auxilios que supera lo que una persona sin formación médica puede resolver?', '["Porque el personal capacitado puede brindar la atención adecuada y oportuna","Porque nunca es necesario pedir ayuda profesional","Porque siempre es mejor no informar a nadie sobre la situación","Porque los primeros auxilios reemplazan por completo la atención médica profesional"]', 2, 'Pedir ayuda a un servicio de emergencia es importante porque el personal capacitado puede brindar la atención adecuada y oportuna que la situación requiere.', 'intermedia', 35),
  ('Un estudiante presencia un accidente menor en su colegio, donde un compañero se corta con un objeto y sangra levemente. Aplica presión con un paño limpio sobre la herida y avisa de inmediato a un adulto responsable. ¿Qué principio de primeros auxilios básicos está aplicando correctamente?', '["Ignorar la situación hasta que alguien más la note","Aplicar una medida básica de primeros auxilios y buscar ayuda de una persona con más experiencia o formación","Intentar curar la herida completamente por sí mismo, sin avisar a nadie","Mover a la persona lejos del lugar sin ninguna razón"]', 3, 'El estudiante aplica correctamente una medida básica de primeros auxilios (presión sobre la herida) y busca ayuda de un adulto con más experiencia, un principio clave de la prevención y el autocuidado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Seguridad, Prevención y Autocuidado' and l.code = 'regular_3_medio' and lo.short_name = 'Primeros auxilios básicos'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Seguridad, Prevención y Autocuidado. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos hábitos contribuye a la prevención de enfermedades cardiovasculares, según la evidencia científica disponible?', '["Realizar actividad física regular","Consumir grandes cantidades de sal y grasas saturadas todos los días","Fumar de forma habitual","No dormir lo suficiente de forma constante"]', 0, 'La actividad física regular contribuye a la prevención de enfermedades cardiovasculares, según evidencia científica.', 'inicial', 25),
  ('¿Por qué se recomienda una alimentación variada y con abundantes frutas y verduras como medida de prevención de enfermedades?', '["Porque aporta nutrientes y compuestos que se asocian a un menor riesgo de ciertas enfermedades","Porque no tiene ninguna relación con la salud a largo plazo","Porque solo influye en el sabor de las comidas","Porque reemplaza por completo la necesidad de actividad física"]', 1, 'Una alimentación variada, rica en frutas y verduras, aporta nutrientes asociados a un menor riesgo de ciertas enfermedades.', 'intermedia', 35),
  ('¿Qué relación existe entre el hábito de dormir suficientes horas y la prevención de enfermedades?', '["Dormir lo suficiente contribuye a un mejor funcionamiento del sistema inmunológico y a la salud en general","Dormir no tiene ninguna relación con la salud del cuerpo","Dormir muchas horas siempre perjudica la salud","Solo influye en el estado de ánimo, sin relación con enfermedades"]', 2, 'Dormir lo suficiente contribuye a un mejor funcionamiento del sistema inmunológico y a la salud general, ayudando a prevenir enfermedades.', 'intermedia', 35),
  ('Un estudio de salud pública compara a dos grupos de personas durante varios años: uno que mantiene hábitos como actividad física regular, alimentación variada y sueño adecuado, y otro con hábitos sedentarios, alimentación poco variada y sueño insuficiente. El primer grupo presenta menor incidencia de ciertas enfermedades crónicas. ¿Qué conclusión es más adecuada a partir de esta evidencia?', '["Los hábitos de vida no tienen ninguna relación con la prevención de enfermedades","Es indiferente mantener hábitos saludables o no, según esta evidencia","Esta evidencia contradice cualquier relación entre hábitos y salud","Esta evidencia es consistente con la idea de que ciertos hábitos saludables se asocian a un menor riesgo de enfermedades crónicas"]', 3, 'Esta evidencia es consistente con la idea de que hábitos saludables (actividad física, alimentación variada, sueño adecuado) se asocian a un menor riesgo de enfermedades crónicas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Seguridad, Prevención y Autocuidado' and l.code = 'regular_3_medio' and lo.short_name = 'Prevención de enfermedades mediante hábitos saludables'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Seguridad, Prevención y Autocuidado. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa tomar una decisión informada sobre autocuidado?', '["Basar la decisión en información confiable y en la evaluación de sus posibles consecuencias","Decidir sin buscar ninguna información previa","Seguir siempre lo que dicen las redes sociales sin verificar nada","Evitar cualquier tipo de decisión relacionada con la salud"]', 0, 'Tomar una decisión informada sobre autocuidado implica basarse en información confiable y evaluar sus posibles consecuencias.', 'inicial', 25),
  ('¿Por qué es importante consultar fuentes confiables, como profesionales de la salud, antes de tomar una decisión relevante sobre la propia salud?', '["Porque ayuda a tomar decisiones basadas en evidencia y no solo en rumores o modas","Porque las fuentes confiables nunca aportan información útil","Porque no es necesario informarse antes de tomar decisiones de salud","Porque toda la información encontrada en internet es igual de confiable"]', 1, 'Consultar fuentes confiables ayuda a tomar decisiones basadas en evidencia, en vez de basarse en rumores o modas sin sustento.', 'intermedia', 35),
  ('¿Cuál de estas situaciones representa una toma de decisión informada sobre autocuidado?', '["Investigar sobre los efectos de un hábito antes de adoptarlo, consultando fuentes confiables","Adoptar un hábito solo porque lo recomienda una persona sin ninguna formación en el tema","Decidir sin buscar ninguna información relevante","Ignorar cualquier consecuencia posible de una decisión de salud"]', 2, 'Investigar sobre los efectos de un hábito, consultando fuentes confiables, antes de adoptarlo, es un ejemplo de toma de decisión informada sobre autocuidado.', 'intermedia', 35),
  ('Un estudiante, antes de decidir si participar en una actividad física de riesgo, investiga sobre las medidas de seguridad recomendadas, consulta a un profesional y evalúa sus propias condiciones físicas antes de decidir. ¿Qué proceso de toma de decisiones está aplicando?', '["Una decisión impulsiva, sin ningún análisis previo","Una decisión basada únicamente en la opinión de otras personas sin evaluar información propia","Una decisión informada sobre autocuidado, basada en evidencia y en la evaluación de su propia situación","Una decisión que ignora por completo cualquier riesgo asociado a la actividad"]', 3, 'El estudiante está aplicando una decisión informada sobre autocuidado, basada en evidencia, consulta profesional y evaluación de su propia situación.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Seguridad, Prevención y Autocuidado' and l.code = 'regular_3_medio' and lo.short_name = 'Toma de decisiones informada sobre autocuidado'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- MÓDULO: TECNOLOGÍA Y SOCIEDAD — 3° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos ejemplos muestra un impacto social de la tecnología en la comunicación entre personas?', '["El uso masivo de aplicaciones de mensajería instantánea","El color de un teléfono celular","El precio de un cargador de batería","La forma física de una antena de celular"]', 0, 'El uso masivo de aplicaciones de mensajería instantánea es un ejemplo de impacto social de la tecnología en la comunicación.', 'inicial', 25),
  ('¿Qué efecto social puede tener el acceso desigual a internet entre distintos grupos de una sociedad?', '["Puede generar diferencias en el acceso a información, educación y oportunidades","No tiene ningún efecto en la sociedad","Solo afecta el entretenimiento, sin relación con la educación","Elimina automáticamente todas las diferencias sociales existentes"]', 1, 'El acceso desigual a internet puede generar diferencias en el acceso a información, educación y oportunidades entre distintos grupos.', 'intermedia', 35),
  ('¿Cómo ha afectado la tecnología a la forma en que las personas trabajan, según algunos cambios observados en las últimas décadas?', '["Ha permitido nuevas formas de trabajo, como el trabajo remoto mediante dispositivos conectados a internet","No ha tenido ningún efecto en la forma de trabajar","Ha eliminado por completo la necesidad de cualquier tipo de trabajo","Solo ha afectado a un tipo de trabajo, sin relación con otros sectores"]', 2, 'La tecnología ha permitido nuevas formas de trabajo, como el trabajo remoto mediante dispositivos conectados a internet.', 'intermedia', 35),
  ('Un estudiante investiga que la masificación de teléfonos inteligentes ha cambiado la forma en que las personas acceden a noticias, se comunican con otros y realizan trámites, pero también ha generado preocupaciones sobre el uso excesivo de pantallas y la desigualdad en el acceso a esta tecnología. ¿Qué idea general sobre el impacto social de la tecnología refleja esta información?', '["Que la tecnología no tiene ningún efecto en la sociedad","Que la tecnología solo tiene efectos negativos para la sociedad","Que el impacto social de la tecnología puede incluir tanto beneficios como desafíos que deben considerarse","Que la tecnología afecta únicamente a un pequeño grupo de personas"]', 3, 'Esta información refleja que el impacto social de la tecnología puede incluir tanto beneficios (comunicación, acceso a información) como desafíos (uso excesivo, desigualdad) que deben considerarse.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Tecnología y Sociedad' and l.code = 'regular_3_medio' and lo.short_name = 'Impacto social de la tecnología'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos dilemas es un ejemplo de dilema ético relacionado con el desarrollo científico y tecnológico?', '["Si es aceptable usar tecnología de vigilancia masiva sin el conocimiento de las personas","Qué color debería tener un nuevo modelo de celular","Qué marca de computador es más popular","Cuál es el precio de un producto tecnológico"]', 0, 'El uso de tecnología de vigilancia masiva sin el conocimiento de las personas es un ejemplo de dilema ético relacionado con la tecnología.', 'inicial', 25),
  ('¿Por qué se considera importante discutir los aspectos éticos del desarrollo de nuevas tecnologías, y no solo sus beneficios técnicos?', '["Porque las nuevas tecnologías pueden tener efectos en las personas y la sociedad que requieren ser evaluados cuidadosamente","Porque los aspectos éticos no tienen ninguna relación con la tecnología","Porque solo importan los beneficios económicos de una tecnología","Porque la ética no debería considerarse en el desarrollo científico"]', 1, 'Es importante discutir los aspectos éticos porque las nuevas tecnologías pueden tener efectos en las personas y la sociedad que requieren evaluación cuidadosa.', 'intermedia', 35),
  ('¿Cuál de estas preguntas refleja una reflexión ética sobre el desarrollo de la inteligencia artificial?', '["¿Qué responsabilidad tienen las empresas si un sistema de inteligencia artificial comete un error que afecta a una persona?","¿Qué color de pantalla prefieren los usuarios de un programa?","¿Cuántos programadores trabajan en una empresa de tecnología?","¿Qué tan rápido procesa datos un computador nuevo?"]', 2, 'La pregunta sobre la responsabilidad frente a errores de un sistema de inteligencia artificial refleja una reflexión ética sobre el desarrollo tecnológico.', 'intermedia', 35),
  ('Un grupo de estudiantes debate si es ético que una empresa recopile información personal de sus usuarios sin explicarles claramente cómo será utilizada. ¿Qué aspecto de la relación entre ciencia, tecnología y sociedad están discutiendo?', '["Un aspecto exclusivamente técnico, sin relación con la ética","Un dilema ético relacionado con el desarrollo y uso de la tecnología","Un tema que no tiene ninguna relevancia social","Una pregunta sobre el precio de un producto tecnológico"]', 3, 'Los estudiantes están discutiendo un dilema ético relacionado con el desarrollo y uso de la tecnología, específicamente sobre el manejo de información personal.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Tecnología y Sociedad' and l.code = 'regular_3_medio' and lo.short_name = 'Ética en el desarrollo científico y tecnológico'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué acción refleja una evaluación crítica de una noticia sobre un avance tecnológico difundida en redes sociales?', '["Verificar si existen fuentes confiables que respalden la información antes de creerla o compartirla","Compartir la noticia de inmediato sin revisar su origen","Creer la noticia solo porque tiene muchas reacciones","Ignorar cualquier verificación de la información"]', 0, 'Verificar si existen fuentes confiables que respalden la información es un ejemplo de evaluación crítica de una noticia tecnológica.', 'inicial', 25),
  ('¿Cuál de estas señales podría indicar que una información sobre tecnología difundida en internet es poco confiable?', '["Que no mencione ninguna fuente ni evidencia que respalde sus afirmaciones","Que cite estudios y datos verificables de instituciones reconocidas","Que haya sido revisada por especialistas en el tema","Que explique claramente el origen de la información"]', 1, 'Que una información no mencione ninguna fuente ni evidencia que la respalde es una señal de que podría ser poco confiable.', 'intermedia', 35),
  ('¿Por qué es importante distinguir entre información basada en evidencia y publicidad exagerada al conocer un nuevo producto tecnológico?', '["Para tomar decisiones de consumo más informadas y evitar expectativas poco realistas","Porque toda la publicidad tecnológica siempre es completamente objetiva","Porque no existe ninguna diferencia entre evidencia y publicidad","Porque la publicidad nunca influye en las decisiones de las personas"]', 2, 'Distinguir entre evidencia e información publicitaria exagerada permite tomar decisiones de consumo más informadas y realistas.', 'intermedia', 35),
  ('Un estudiante lee una publicación que afirma, sin citar ninguna fuente, que cierto dispositivo tecnológico ''cura enfermedades'' con solo usarlo unos minutos al día. ¿Qué acción refleja una evaluación crítica adecuada de esta información?', '["Comprar el producto de inmediato sin cuestionar la afirmación","Buscar si existe evidencia científica seria que respalde esa afirmación antes de creerla","Compartir la publicación con otras personas sin verificarla","Aceptar la afirmación solo porque suena innovadora"]', 3, 'Buscar evidencia científica seria que respalde la afirmación antes de creerla es un ejemplo de evaluación crítica adecuada de información tecnológica.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Tecnología y Sociedad' and l.code = 'regular_3_medio' and lo.short_name = 'Evaluación crítica de información tecnológica'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué aspecto es importante considerar al tomar una decisión informada sobre el consumo de un nuevo producto tecnológico?', '["Sus beneficios reales, su costo y su posible impacto ambiental o social","Solo el color o diseño del producto","Solo si es el producto más caro disponible","Solo la opinión de un anuncio publicitario"]', 0, 'Considerar los beneficios reales, el costo y el posible impacto ambiental o social es importante al tomar una decisión informada de consumo tecnológico.', 'inicial', 25),
  ('¿Por qué es relevante considerar el impacto ambiental al decidir la compra de un dispositivo tecnológico?', '["Porque la fabricación y desecho de dispositivos tecnológicos puede tener consecuencias ambientales significativas","Porque los dispositivos tecnológicos nunca tienen impacto ambiental","Porque el impacto ambiental no se relaciona con el consumo tecnológico","Porque solo importa el precio del dispositivo"]', 1, 'La fabricación y desecho de dispositivos tecnológicos puede tener consecuencias ambientales significativas, por lo que es relevante considerarlo al decidir su compra.', 'intermedia', 35),
  ('¿Cuál de estas acciones refleja una decisión de consumo tecnológico más responsable?', '["Reciclar o entregar a un punto de reciclaje electrónico un dispositivo que ya no se usa","Desechar cualquier dispositivo electrónico junto con la basura común","Comprar un dispositivo nuevo cada mes sin necesidad real","Ignorar por completo el impacto ambiental de los dispositivos electrónicos"]', 2, 'Reciclar o entregar a un punto de reciclaje electrónico un dispositivo en desuso refleja una decisión de consumo tecnológico más responsable.', 'intermedia', 35),
  ('Un estudiante, antes de comprar un nuevo teléfono, compara distintas marcas considerando su durabilidad, la posibilidad de repararlo en caso de fallas, su consumo energético y las opciones de reciclaje al final de su vida útil, en vez de basarse solo en la publicidad. ¿Qué característica de una decisión de consumo tecnológico responsable está aplicando?', '["Ninguna, esta decisión no considera ningún criterio relevante","Basar la decisión únicamente en la marca más popular","Evaluar distintos criterios relevantes (durabilidad, reparabilidad, impacto ambiental) antes de decidir","Ignorar cualquier información que no sea publicitaria"]', 3, 'El estudiante está evaluando distintos criterios relevantes (durabilidad, reparabilidad, consumo energético, impacto ambiental) antes de decidir, lo que refleja una decisión de consumo tecnológico responsable.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Tecnología y Sociedad' and l.code = 'regular_3_medio' and lo.short_name = 'Toma de decisiones sobre consumo tecnológico'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- MÓDULO: ECOSISTEMA, COMUNIDAD Y SUSTENTABILIDAD — 3° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Ecosistema, Comunidad y Sustentabilidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué tipo de evidencia científica se utiliza frecuentemente para estudiar el cambio climático?', '["El registro histórico de la temperatura global y la concentración de gases de efecto invernadero","La opinión de una sola persona sin ningún dato","El color del cielo en un solo día","El precio del combustible en un país"]', 0, 'El registro histórico de la temperatura global y la concentración de gases de efecto invernadero es una evidencia científica utilizada para estudiar el cambio climático.', 'inicial', 25),
  ('¿Qué muestra la evidencia científica sobre la relación entre la actividad humana y el cambio climático actual?', '["Que la actividad humana, en particular la quema de combustibles fósiles, ha contribuido al aumento de gases de efecto invernadero","Que la actividad humana no tiene ninguna relación con el clima","Que el clima del planeta nunca ha cambiado antes","Que no existe ninguna evidencia científica sobre este tema"]', 1, 'La evidencia científica muestra que la actividad humana, en particular la quema de combustibles fósiles, ha contribuido al aumento de gases de efecto invernadero.', 'intermedia', 35),
  ('¿Por qué es importante que las decisiones sobre políticas ambientales se basen en evidencia científica?', '["Porque permite tomar decisiones más informadas frente a un problema complejo como el cambio climático","Porque la evidencia científica no tiene ninguna utilidad en la política","Porque las decisiones políticas nunca deberían considerar la evidencia científica","Porque el cambio climático no requiere ninguna evidencia para ser abordado"]', 2, 'Basar las decisiones sobre políticas ambientales en evidencia científica permite tomar decisiones más informadas frente a un problema complejo.', 'intermedia', 35),
  ('Un estudiante analiza gráficos que muestran el aumento de la temperatura global promedio y de la concentración de dióxido de carbono en la atmósfera durante los últimos 100 años, coincidiendo con el aumento del uso de combustibles fósiles a nivel mundial. ¿Qué conclusión es más adecuada a partir de esta evidencia científica?', '["No existe ninguna relación entre estos datos","Esta evidencia es consistente con la idea de que la actividad humana ha influido en el cambio climático observado","Esta evidencia demuestra que el clima nunca cambia","Esta evidencia no tiene relación con el cambio climático"]', 3, 'Esta evidencia es consistente con la idea de que la actividad humana, mediante el uso de combustibles fósiles, ha influido en el cambio climático observado en el último siglo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Ecosistema, Comunidad y Sustentabilidad' and l.code = 'regular_3_medio' and lo.short_name = 'Cambio climático y evidencia científica'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Ecosistema, Comunidad y Sustentabilidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué representa el concepto de ''huella ecológica'' de una persona o comunidad?', '["La estimación del impacto que sus hábitos de consumo generan sobre los recursos naturales del planeta","El tamaño físico de los pies de una persona","El número de árboles que hay en su ciudad","La cantidad de dinero que gasta al mes"]', 0, 'La huella ecológica representa la estimación del impacto que los hábitos de consumo de una persona o comunidad generan sobre los recursos naturales.', 'inicial', 25),
  ('¿Cuál de estos hábitos contribuye a reducir la huella ecológica de una persona?', '["Reducir el consumo innecesario y reutilizar materiales cuando sea posible","Aumentar sin ningún control el consumo de productos desechables","Desechar todo tipo de material sin considerar el reciclaje","Ignorar por completo el impacto de sus decisiones de consumo"]', 1, 'Reducir el consumo innecesario y reutilizar materiales son hábitos que contribuyen a reducir la huella ecológica de una persona.', 'intermedia', 35),
  ('¿Por qué se dice que el consumo responsable está relacionado con la reducción de la huella ecológica?', '["Porque consumir de forma más consciente puede disminuir la presión sobre los recursos naturales y la generación de residuos","Porque el consumo responsable no tiene ninguna relación con el impacto ambiental","Porque consumir más productos siempre reduce la huella ecológica","Porque la huella ecológica no depende de los hábitos de consumo"]', 2, 'Consumir de forma más consciente puede disminuir la presión sobre los recursos naturales y la generación de residuos, reduciendo la huella ecológica.', 'intermedia', 35),
  ('Un estudiante compara dos comunidades: una que promueve el uso de transporte público, la reducción de residuos y el consumo de productos locales, y otra con un alto consumo de productos desechables y uso extendido de vehículos particulares. ¿Qué se puede afirmar sobre la huella ecológica de ambas comunidades?', '["Ambas comunidades tienen exactamente la misma huella ecológica","La huella ecológica no depende de estos hábitos de consumo","Es probable que la primera comunidad tenga una menor huella ecológica que la segunda, considerando estos hábitos","Es probable que la primera comunidad tenga una mayor huella ecológica que la segunda"]', 3, 'Considerando estos hábitos de consumo más responsables, es probable que la primera comunidad tenga una menor huella ecológica que la segunda.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Ecosistema, Comunidad y Sustentabilidad' and l.code = 'regular_3_medio' and lo.short_name = 'Huella ecológica y consumo responsable'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Ecosistema, Comunidad y Sustentabilidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Por qué es importante la biodiversidad para el equilibrio de los ecosistemas?', '["Porque una mayor variedad de especies contribuye a la estabilidad y funcionamiento del ecosistema","Porque la biodiversidad no tiene relación con el funcionamiento de un ecosistema","Porque menos especies siempre hacen a un ecosistema más estable","Porque la biodiversidad solo es relevante para los zoológicos"]', 0, 'Una mayor variedad de especies contribuye a la estabilidad y funcionamiento del ecosistema, por eso la biodiversidad es importante.', 'inicial', 25),
  ('¿Cuál de estas es una medida de conservación de la biodiversidad?', '["La creación de áreas protegidas donde se restringe ciertas actividades humanas","La tala indiscriminada de bosques nativos","La introducción sin control de especies exóticas en un ecosistema","La contaminación de ríos y lagos"]', 1, 'La creación de áreas protegidas es una medida de conservación que ayuda a proteger la biodiversidad de un territorio.', 'intermedia', 35),
  ('¿Qué relación existe entre la pérdida de biodiversidad y la actividad humana, según evidencia científica?', '["Ciertas actividades humanas, como la deforestación, pueden contribuir a la pérdida de biodiversidad","La actividad humana nunca afecta la biodiversidad de un territorio","La biodiversidad aumenta siempre con cualquier tipo de actividad humana","No existe ninguna relación entre ambos fenómenos"]', 2, 'Ciertas actividades humanas, como la deforestación, pueden contribuir a la pérdida de biodiversidad, según evidencia científica.', 'intermedia', 35),
  ('Un estudiante investiga que, en una zona donde se ha talado gran parte del bosque nativo para dar paso a actividades agrícolas, ha disminuido significativamente la cantidad de especies de aves y mamíferos registradas en las últimas décadas. ¿Qué relación explica mejor esta observación?', '["No existe ninguna relación entre la tala de bosques y la disminución de especies","La tala del bosque nativo probablemente contribuyó a la pérdida de hábitat y, con ello, a la disminución de biodiversidad en la zona","La disminución de especies se debe únicamente al clima, sin relación con la tala de bosques","La tala de bosques siempre aumenta la biodiversidad de una zona"]', 3, 'La tala del bosque nativo probablemente contribuyó a la pérdida de hábitat de las especies, lo que explica la disminución de biodiversidad observada en la zona.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Ecosistema, Comunidad y Sustentabilidad' and l.code = 'regular_3_medio' and lo.short_name = 'Biodiversidad y conservación'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Ecosistema, Comunidad y Sustentabilidad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas acciones representa un uso sustentable de un recurso natural, como el agua?', '["Utilizar el agua de forma eficiente, evitando el desperdicio en actividades cotidianas","Dejar llaves de agua abiertas sin necesidad durante horas","Usar toda el agua disponible sin ninguna consideración futura","Contaminar las fuentes de agua sin ningún control"]', 0, 'Utilizar el agua de forma eficiente, evitando el desperdicio, es un ejemplo de uso sustentable de este recurso natural.', 'inicial', 25),
  ('¿Qué significa que la extracción de un recurso natural sea sustentable a nivel comunitario?', '["Que se extrae en una cantidad que permite su renovación o disponibilidad futura","Que se extrae todo el recurso disponible sin ninguna consideración","Que no importa el ritmo de extracción del recurso","Que la sustentabilidad no tiene relación con la extracción de recursos"]', 1, 'La extracción sustentable de un recurso implica extraerlo en una cantidad que permita su renovación o disponibilidad futura.', 'intermedia', 35),
  ('¿Cuál de estas prácticas comunitarias contribuye al uso sustentable de los bosques?', '["La reforestación planificada después de la tala de árboles para uso maderero","La tala sin ningún plan de reforestación posterior","La quema descontrolada de zonas boscosas","La extracción de madera sin ningún límite ni control"]', 2, 'La reforestación planificada después de la tala contribuye al uso sustentable de los bosques, permitiendo su renovación.', 'intermedia', 35),
  ('Una comunidad de pescadores establece cuotas de pesca basadas en estudios científicos sobre la cantidad de peces que puede reproducirse cada año, evitando la sobreexplotación de la zona. ¿Qué principio de uso sustentable de recursos naturales está aplicando esta comunidad?', '["Ningún principio relevante de sustentabilidad","Extraer todos los recursos disponibles sin ninguna limitación","Basar la extracción de un recurso en su capacidad de renovación, según evidencia científica","Ignorar cualquier estudio científico al tomar decisiones sobre el recurso"]', 3, 'Esta comunidad está aplicando el principio de basar la extracción de un recurso en su capacidad de renovación, según evidencia científica, un componente clave del uso sustentable.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Ecosistema, Comunidad y Sustentabilidad' and l.code = 'regular_3_medio' and lo.short_name = 'Uso sustentable de recursos naturales'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- MÓDULO: CÉLULA, TECNOLOGÍA Y SOCIEDAD — 3° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Célula, Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una aplicación de la biotecnología en el área de la salud?', '["La producción de insulina mediante microorganismos modificados para tratar la diabetes","La fabricación de muebles de madera","La construcción de carreteras","La producción de energía eólica"]', 0, 'La producción de insulina mediante microorganismos modificados es una aplicación de la biotecnología en el área de la salud.', 'inicial', 25),
  ('¿Cuál de estas es una aplicación de la biotecnología en el área agrícola?', '["El desarrollo de semillas con mayor resistencia a ciertas plagas mediante técnicas biotecnológicas","La construcción de un puente","La fabricación de un teléfono celular","La instalación de un panel solar"]', 1, 'El desarrollo de semillas con mayor resistencia a plagas mediante técnicas biotecnológicas es una aplicación de la biotecnología en la agricultura.', 'intermedia', 35),
  ('¿Por qué se considera que la biotecnología puede tener un impacto relevante en la sociedad?', '["Porque sus aplicaciones pueden afectar áreas como la salud, la alimentación y la industria, con beneficios y también desafíos éticos","Porque la biotecnología no tiene ninguna aplicación práctica","Porque solo afecta a un grupo muy reducido de personas","Porque sus aplicaciones no tienen relación con la vida cotidiana"]', 2, 'La biotecnología puede tener un impacto relevante en la sociedad porque sus aplicaciones afectan áreas como la salud, la alimentación y la industria, con beneficios y desafíos éticos.', 'intermedia', 35),
  ('Un estudiante investiga que la biotecnología se usa para producir medicamentos como la insulina, mejorar la resistencia de cultivos agrícolas y desarrollar pruebas de diagnóstico médico más rápidas, pero que también genera debates éticos sobre la modificación genética de organismos. ¿Qué idea general sobre la biotecnología y la sociedad refleja esta información?', '["Que la biotecnología no tiene ninguna aplicación relevante","Que la biotecnología tiene aplicaciones beneficiosas en distintas áreas, aunque también plantea debates éticos que la sociedad debe abordar","Que la biotecnología solo genera problemas, sin ningún beneficio","Que la biotecnología no tiene relación con debates éticos"]', 3, 'Esta información refleja que la biotecnología tiene aplicaciones beneficiosas en distintas áreas, aunque también plantea debates éticos que la sociedad debe abordar.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Célula, Tecnología y Sociedad' and l.code = 'regular_3_medio' and lo.short_name = 'Biotecnología y sus aplicaciones'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Célula, Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se entiende por salud reproductiva y sexual desde un enfoque de autocuidado ciudadano?', '["El conjunto de conocimientos y decisiones informadas orientadas a cuidar la propia salud en estos ámbitos","Un tema que no requiere ninguna información científica","Solo un asunto médico sin relación con decisiones personales","Un tema que no debería tratarse en un contexto educativo"]', 0, 'La salud reproductiva y sexual, desde un enfoque de autocuidado ciudadano, se refiere al conjunto de conocimientos y decisiones informadas orientadas a cuidar la propia salud en estos ámbitos.', 'inicial', 25),
  ('¿Por qué se recomienda acceder a información confiable, como la entregada por centros de salud, sobre salud reproductiva y sexual?', '["Porque permite tomar decisiones informadas y basadas en evidencia sobre el autocuidado","Porque la información confiable no aporta ningún beneficio","Porque es preferible no informarse sobre estos temas","Porque toda la información disponible en internet es igual de confiable"]', 1, 'Acceder a información confiable permite tomar decisiones informadas y basadas en evidencia sobre el autocuidado en salud reproductiva y sexual.', 'intermedia', 35),
  ('¿Cuál de estas acciones refleja un enfoque de autocuidado ciudadano en salud reproductiva y sexual?', '["Buscar información en centros de salud y tomar decisiones informadas al respecto","Evitar cualquier tipo de información sobre el tema","Tomar decisiones basadas únicamente en rumores sin verificar su veracidad","Ignorar por completo cualquier recomendación de salud"]', 2, 'Buscar información en centros de salud y tomar decisiones informadas es un ejemplo de autocuidado ciudadano en salud reproductiva y sexual.', 'intermedia', 35),
  ('Una campaña de un centro de salud promueve el acceso a información confiable sobre salud reproductiva y sexual, junto con la posibilidad de realizar consultas médicas confidenciales para adolescentes que lo necesiten. ¿Qué objetivo ciudadano tiene esta campaña, considerando el enfoque de autocuidado?', '["Reducir el acceso de los adolescentes a información sobre salud","Contribuir a que los adolescentes puedan tomar decisiones informadas sobre su propia salud reproductiva y sexual","Aumentar la desinformación sobre este tema","No tiene relación con el autocuidado ciudadano"]', 3, 'Esta campaña busca contribuir a que los adolescentes puedan tomar decisiones informadas sobre su propia salud reproductiva y sexual, un objetivo central del enfoque de autocuidado ciudadano.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Célula, Tecnología y Sociedad' and l.code = 'regular_3_medio' and lo.short_name = 'Salud reproductiva y sexual con enfoque ciudadano'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Célula, Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué caracteriza a una enfermedad de origen genético?', '["Está asociada a alteraciones en el material genético de una persona","Se transmite exclusivamente por contacto directo con otra persona enferma","No tiene ninguna relación con la información genética","Solo afecta a los animales, no a las personas"]', 0, 'Una enfermedad de origen genético está asociada a alteraciones en el material genético de una persona.', 'inicial', 25),
  ('¿Por qué algunas enfermedades de origen genético pueden presentarse en varios miembros de una misma familia?', '["Porque el material genético, incluidas ciertas alteraciones, puede heredarse de generación en generación","Porque estas enfermedades siempre se contagian por el aire","Porque no existe ninguna relación entre la genética y estas enfermedades","Porque estas enfermedades solo dependen del estilo de vida, sin relación genética"]', 1, 'Algunas enfermedades de origen genético pueden presentarse en varios miembros de una familia porque el material genético, incluidas ciertas alteraciones, puede heredarse de generación en generación.', 'intermedia', 35),
  ('¿Qué impacto puede tener el acceso a pruebas genéticas para el diagnóstico de enfermedades de origen genético?', '["Puede permitir una detección más temprana y una mejor toma de decisiones sobre el cuidado de la salud","No tiene ninguna utilidad para la salud de las personas","Elimina por completo cualquier enfermedad de origen genético","Solo tiene relevancia para fines de entretenimiento"]', 2, 'El acceso a pruebas genéticas puede permitir una detección más temprana de ciertas enfermedades y una mejor toma de decisiones sobre el cuidado de la salud.', 'intermedia', 35),
  ('Un estudiante investiga que existen enfermedades genéticas que se presentan con mayor frecuencia en familias donde uno de los progenitores porta cierta alteración genética, y que el acceso a pruebas genéticas ha permitido a algunas familias tomar decisiones informadas sobre su salud reproductiva. ¿Qué relación general refleja esta información entre la genética, la tecnología y la sociedad?', '["Que la genética no tiene ninguna relación con las decisiones de salud de las familias","Que los avances tecnológicos en genética pueden aportar información relevante para la toma de decisiones de salud a nivel familiar y ciudadano","Que las pruebas genéticas no aportan ninguna información útil","Que las enfermedades genéticas nunca pueden detectarse con anticipación"]', 3, 'Esta información refleja que los avances tecnológicos en genética pueden aportar información relevante para la toma de decisiones de salud a nivel familiar y ciudadano.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Célula, Tecnología y Sociedad' and l.code = 'regular_3_medio' and lo.short_name = 'Enfermedades de origen genético'
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
  'Pregunta ValidApp (borrador), Ciencias para la Ciudadanía 3° Medio, módulo Célula, Tecnología y Sociedad. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 193/2019); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas preguntas refleja un dilema ético relacionado con la manipulación genética?', '["¿Hasta qué punto es aceptable modificar genéticamente a un organismo con fines determinados?","¿Qué color tiene una célula bajo el microscopio?","¿Cuántas células tiene el cuerpo humano aproximadamente?","¿Qué instrumento se usa para observar una célula?"]', 0, 'La pregunta sobre hasta qué punto es aceptable modificar genéticamente a un organismo refleja un dilema ético relacionado con la manipulación genética.', 'inicial', 25),
  ('¿Por qué la manipulación genética de alimentos genera debates éticos y sociales?', '["Porque involucra consideraciones sobre seguridad alimentaria, impacto ambiental y acceso equitativo a la tecnología","Porque no genera ningún tipo de debate en la sociedad","Porque no tiene ninguna relación con la alimentación de las personas","Porque solo es un tema exclusivamente técnico, sin relevancia social"]', 1, 'La manipulación genética de alimentos genera debates éticos y sociales porque involucra consideraciones sobre seguridad alimentaria, impacto ambiental y acceso equitativo a la tecnología.', 'intermedia', 35),
  ('¿Cuál de estos aspectos debería considerarse al evaluar éticamente el uso de la manipulación genética en la medicina, como la edición de genes para tratar enfermedades?', '["Los posibles beneficios para la salud y los riesgos o efectos no deseados de la técnica","Únicamente el costo económico de la tecnología","Únicamente la opinión de una sola persona, sin considerar evidencia científica","Ningún aspecto, ya que no existen consideraciones éticas relevantes en este tema"]', 2, 'Al evaluar éticamente el uso de la manipulación genética en medicina, es importante considerar tanto los posibles beneficios para la salud como los riesgos o efectos no deseados de la técnica.', 'intermedia', 35),
  ('Un grupo de estudiantes debate sobre la edición genética en seres humanos con fines terapéuticos (para tratar enfermedades) en comparación con fines no terapéuticos (para modificar características no relacionadas con la salud). Consideran los beneficios médicos, los riesgos, y las implicancias sociales de cada caso. ¿Qué habilidad ciudadana relacionada con la ciencia están desarrollando en este debate?', '["Ignorar cualquier consideración ética sobre la tecnología","Aceptar cualquier uso de la manipulación genética sin ningún análisis","Analizar de forma crítica y reflexiva los dilemas éticos asociados a la manipulación genética","Rechazar automáticamente cualquier avance científico en genética"]', 3, 'Los estudiantes están desarrollando la habilidad de analizar de forma crítica y reflexiva los dilemas éticos asociados a la manipulación genética, considerando distintos escenarios y sus implicancias.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias para la Ciudadanía') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias para la Ciudadanía')
    and s.name = 'Célula, Tecnología y Sociedad' and l.code = 'regular_3_medio' and lo.short_name = 'Dilemas éticos de la manipulación genética'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
