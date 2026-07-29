-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Idioma
-- Extranjero: Inglés, 1° Medio. Cubre los 16 objetivos de aprendizaje de 1°
-- Medio cargados por
-- supabase/seed/0024_curriculum_ingles_regular_7basico_2medio.sql (4 ejes:
-- Comprensión Auditiva, Comprensión Lectora, Expresión Oral, Expresión
-- Escrita), con 4 preguntas por objetivo, total 64 preguntas en este
-- archivo.
--
-- Mismo estado editorial, criterio de idioma (ver encabezado completo de
-- supabase/seed/0113_questions_ingles_regular_7basico.sql: proporción alta
-- de inglés en estímulos y preguntas de contenido; nivel B1 en esta banda
-- implica textos y diálogos más largos y argumentativos), fuente,
-- validación mecánica e idempotencia que 0111-0114. `source` cita Decreto
-- Supremo N.° 614/2013. Seed SOLO local: no se ha ejecutado contra Supabase.

-- ============================================================================
-- EJE: COMPRENSIÓN AUDITIVA — 1° MEDIO
-- ============================================================================

-- Objetivo: Comprensión de discursos orales sobre temas variados
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''Today, I want to talk about the importance of protecting endangered species around the world.'' What is the general topic of this speech?', '["Protecting endangered species","Cooking traditional food","Learning a new language","Playing team sports"]', 0, 'The speech clearly states its topic in the opening sentence.', 'inicial', 25),
  ('Escuchas un discurso sobre los efectos del cambio climático en la agricultura. ¿Qué tipo de tema aborda este discurso?', '["Un tema deportivo","Un tema ambiental y de actualidad","Un tema de entretenimiento","Un tema de historia antigua"]', 1, 'El discurso aborda un tema ambiental y de actualidad relacionado con el cambio climático.', 'intermedia', 30),
  ('Listen: ''Many young people today face pressure from social media, which can affect their mental health.'' What is the speaker mainly discussing?', '["Sports achievements","The effects of social media on young people''s mental health","Traditional recipes","History of the internet"]', 1, 'The speaker focuses on the effects of social media on young people''s mental health.', 'intermedia', 30),
  ('Listen to this speech: ''While technology has transformed education by giving access to information, it has also created new challenges, such as digital distraction and unequal access in rural areas.'' What is the main message about technology and education, according to this discourse?', '["Technology in education has only positive effects","Technology in education has only negative effects","Technology has no relationship with education","Technology in education has both benefits and challenges"]', 3, 'El discurso presenta tanto beneficios (acceso a la información) como desafíos (distracción, desigualdad), reflejando una postura equilibrada.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_1_medio' and lo.short_name = 'Comprensión de discursos orales sobre temas variados'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Inferencia del propósito y la audiencia de un mensaje oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''Attention, students! Please proceed calmly to the nearest exit.'' What is the purpose of this message?', '["To give a safety instruction during an emergency","To advertise a product","To tell a joke","To share personal opinions"]', 0, 'The message clearly gives a safety instruction, likely during an emergency drill.', 'inicial', 25),
  ('Escuchas: ''Buy one, get one free! This offer ends this weekend.'' ¿Cuál es el propósito de este mensaje?', '["Dar una instrucción de seguridad","Anunciar una oferta comercial","Contar una historia personal","Explicar una regla gramatical"]', 1, 'El mensaje busca anunciar una oferta comercial para motivar la compra.', 'intermedia', 30),
  ('Listen: ''Parents, please remember that the meeting will take place in the school auditorium at seven p.m.'' Who is the intended audience of this message?', '["Young children","University professors","Parents of students","Store customers"]', 2, 'The message is directed specifically at parents, as stated at the beginning.', 'intermedia', 30),
  ('Listen: ''Investors should be aware that market volatility may increase in the coming months due to global economic uncertainty.'' Considering the vocabulary and content, who is the most likely intended audience of this message?', '["Young children learning to read","People with knowledge of finance and investment","Tourists visiting a new country","Athletes preparing for a competition"]', 1, 'El vocabulario especializado (''investors'', ''market volatility'') sugiere que la audiencia son personas con conocimiento en finanzas e inversión.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_1_medio' and lo.short_name = 'Inferencia del propósito y la audiencia de un mensaje oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de argumentos en un discurso oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''We should reduce plastic use because it pollutes the oceans and harms marine life.'' What is the main argument presented?', '["We should reduce plastic use because it harms the environment","Plastic is a useful and cheap material","The ocean is very large","Marine life doesn''t need protection"]', 0, 'El discurso presenta el argumento de que se debe reducir el uso del plástico porque contamina el océano y daña la vida marina.', 'inicial', 25),
  ('Escuchas un discurso: ''Public transportation should be free because it would reduce traffic and pollution, and it would help low-income families.'' ¿Cuántas razones distintas se presentan para apoyar el argumento principal?', '["Una razón","Dos razones","Tres razones","Ninguna razón"]', 2, 'Se presentan tres razones: reducir el tráfico, reducir la contaminación y ayudar a familias de bajos ingresos.', 'intermedia', 30),
  ('Listen: ''Some people argue that homework should be reduced because students need more time to rest and pursue other interests.'' What kind of statement is this?', '["A fact with no argument","An argument supporting less homework, based on rest and other interests","A question with no clear position","An argument in favor of more homework"]', 1, 'This is an argument in favor of reducing homework, supported by reasons (rest, other interests).', 'intermedia', 30),
  ('Listen: ''Although some believe that stricter laws alone can solve traffic accidents, evidence suggests that public education campaigns are equally important, since many accidents result from a lack of awareness, not just weak regulations.'' What is the main argument, and how is it supported?', '["Solo las leyes estrictas pueden resolver el problema, sin necesidad de otra evidencia","No existe ninguna solución posible para los accidentes de tránsito","Las campañas educativas son igual de importantes que las leyes, apoyado en que muchos accidentes se deben a falta de conciencia","Los accidentes de tránsito no tienen relación con la educación"]', 2, 'El argumento principal es que la educación es tan importante como las leyes, apoyado en evidencia sobre la falta de conciencia como causa de accidentes.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_1_medio' and lo.short_name = 'Identificación de argumentos en un discurso oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de entrevistas o conversaciones formales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen to this interview: ''Interviewer: What inspired you to become a scientist? Guest: I have always been curious about how nature works.'' What inspired the guest to become a scientist?', '["Curiosity about how nature works","A family tradition","Financial reasons","A school requirement"]', 0, 'The guest states that curiosity about how nature works was the inspiration.', 'inicial', 25),
  ('Entrevista: ''Entrevistador: ¿Cuál ha sido el mayor desafío en su carrera? Invitado: Sin duda, aprender a manejar el fracaso y seguir intentando.'' ¿Cuál fue el mayor desafío mencionado?', '["Encontrar empleo","Aprender a manejar el fracaso y seguir intentando","Viajar constantemente","Aprender un nuevo idioma"]', 1, 'El invitado menciona que el mayor desafío fue aprender a manejar el fracaso y seguir intentando.', 'intermedia', 30),
  ('Listen: ''Interviewer: How do you balance work and family life? Guest: It''s not always easy, but I try to set clear boundaries and prioritize what truly matters.'' What strategy does the guest mention for balancing work and family?', '["Working only on weekends","Setting clear boundaries and prioritizing what matters","Ignoring family responsibilities","Never taking a break"]', 1, 'The guest mentions setting clear boundaries and prioritizing what matters as their strategy.', 'intermedia', 30),
  ('Listen: ''Interviewer: Some critics say your policy will increase costs for small businesses. How do you respond? Guest: While there may be some initial costs, we believe the long-term benefits, such as improved worker conditions, will outweigh them.'' What rhetorical move does the guest make in this formal interview response?', '["El invitado ignora completamente la crítica sin responder","El invitado reconoce la crítica y luego presenta un contraargumento con beneficios a largo plazo","El invitado está completamente de acuerdo con la crítica sin matices","El invitado cambia de tema evitando la pregunta"]', 1, 'El invitado reconoce parcialmente la crítica (costos iniciales) pero contraargumenta con los beneficios a largo plazo, una estrategia retórica típica de entrevistas formales.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_1_medio' and lo.short_name = 'Comprensión de entrevistas o conversaciones formales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMPRENSIÓN LECTORA — 1° MEDIO
-- ============================================================================

-- Objetivo: Comprensión de textos informativos y argumentativos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Deforestation contributes significantly to climate change by reducing the number of trees that absorb carbon dioxide.'' What is the main idea of this text?', '["Deforestation contributes to climate change by reducing carbon absorption","Trees have no relationship with climate change","Climate change only affects animals","Deforestation is beneficial for the climate"]', 0, 'El texto explica que la deforestación contribuye al cambio climático al reducir la absorción de carbono.', 'inicial', 25),
  ('Texto: ''Aunque algunos piensan que el trabajo remoto reduce la productividad, varios estudios muestran que muchos empleados son igual de productivos o más, al eliminar el tiempo de traslado.'' ¿Qué tipo de texto es este?', '["Un texto narrativo sin argumento","Un texto argumentativo que presenta y responde a una postura contraria","Una receta de cocina","Un poema"]', 1, 'El texto presenta una postura contraria y la responde con evidencia, característica de un texto argumentativo.', 'intermedia', 30),
  ('Text: ''Renewable energy sources, such as solar and wind power, are becoming more affordable and efficient every year.'' What is the communicative purpose of this text?', '["To narrate a personal story","To inform about the development of renewable energy","To sell a specific product","To express a purely personal opinion with no evidence"]', 1, 'El texto informa sobre el desarrollo de las energías renovables, con un propósito informativo.', 'intermedia', 30),
  ('Text: ''Critics argue that social media platforms should be regulated more strictly to prevent the spread of misinformation. However, supporters of minimal regulation claim this could threaten freedom of expression. A balanced approach might include stricter fact-checking without limiting open debate.'' What type of text is this, and why?', '["Un texto puramente narrativo sin posturas","Un texto argumentativo que presenta dos posturas opuestas y propone una posible solución intermedia","Un texto informativo sin ninguna postura","Una instrucción técnica sin argumentos"]', 1, 'El texto presenta dos posturas opuestas (regulación estricta vs. mínima) y propone una solución intermedia, características de un texto argumentativo equilibrado.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_1_medio' and lo.short_name = 'Comprensión de textos informativos y argumentativos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de la tesis y los argumentos de un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Schools should teach financial literacy because many young adults struggle with managing money after graduation.'' What is the thesis of this text?', '["Schools should teach financial literacy","Young adults are always good with money","Financial literacy is not important","Graduation is difficult for everyone"]', 0, 'La tesis del texto es que las escuelas deberían enseñar educación financiera.', 'inicial', 25),
  ('Texto: ''El uso excesivo de pantallas afecta el sueño de los adolescentes. Por ejemplo, la luz azul retrasa la producción de melatonina, y muchos jóvenes reportan dificultad para dormir.'' ¿Cuál es el argumento de apoyo presentado en el texto?', '["Los adolescentes no usan pantallas","La luz azul retrasa la producción de melatonina","El sueño no tiene relación con las pantallas","Los adolescentes duermen muy bien"]', 1, 'El argumento de apoyo es que la luz azul retrasa la producción de melatonina, afectando el sueño.', 'intermedia', 30),
  ('Text: ''Public libraries should receive more funding. They provide free access to books and technology, and they offer safe spaces for community activities.'' How many supporting arguments are given for the thesis?', '["One argument","Two arguments","Three arguments","No arguments are given"]', 1, 'Se presentan dos argumentos de apoyo: el acceso gratuito a libros y tecnología, y los espacios seguros para actividades comunitarias.', 'intermedia', 30),
  ('Text: ''Although some argue that a four-day work week reduces productivity, evidence from several companies shows that employees are often more focused and motivated with an extra day of rest, which suggests the thesis that reduced work hours can improve, not harm, overall output.'' What is the thesis of this text, and how is it supported?', '["La semana laboral de cuatro días reduce la productividad, sin evidencia que lo respalde","La semana laboral de cuatro días puede mejorar la productividad, apoyada en evidencia de empleados más enfocados y motivados","No existe ninguna tesis en este texto","La semana laboral no tiene ninguna relación con la productividad"]', 1, 'La tesis es que la semana laboral reducida puede mejorar la productividad, apoyada en evidencia de empresas donde los empleados están más motivados.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_1_medio' and lo.short_name = 'Identificación de la tesis y los argumentos de un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Interpretación de vocabulario en contexto académico
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''The hypothesis was tested through a controlled experiment with a sample of one hundred participants.'' According to the context, what is a ''hypothesis''?', '["A proposed explanation that can be tested","A proven and final fact","A type of experiment equipment","A random guess with no basis"]', 0, 'En contexto académico, ''hypothesis'' es una explicación propuesta que puede ser puesta a prueba.', 'inicial', 25),
  ('Texto: ''Los datos obtenidos fueron analizados mediante un método estadístico para determinar su significancia.'' Según el contexto, ¿qué significa ''significancia'' en este texto académico?', '["El color de los datos","La importancia o relevancia estadística del resultado","El tamaño físico de la muestra","El nombre del investigador"]', 1, 'En contexto estadístico, ''significancia'' se refiere a la relevancia o importancia estadística de un resultado.', 'intermedia', 30),
  ('Text: ''The study''s methodology included surveys, interviews, and a review of existing literature.'' Based on context, what does ''methodology'' refer to?', '["The final conclusion of the study","The set of methods used to conduct the research","The name of the researcher","The location where the study took place"]', 1, '''Methodology'' se refiere al conjunto de métodos utilizados para realizar la investigación.', 'intermedia', 30),
  ('Text: ''Despite a robust methodology and a statistically significant sample, the researchers acknowledged that correlation does not necessarily imply causation.'' According to the academic context, what key distinction is the text making?', '["Que un método robusto siempre garantiza causalidad","Que una muestra significativa nunca es confiable","Que una relación entre dos variables (correlación) no prueba automáticamente que una cause la otra (causalidad)","Que la metodología no tiene ninguna importancia en la investigación"]', 2, 'El texto distingue entre correlación (relación entre variables) y causalidad (que una cause la otra), un concepto clave en investigación académica.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_1_medio' and lo.short_name = 'Interpretación de vocabulario en contexto académico'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Evaluación de la confiabilidad de una fuente escrita
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''According to a peer-reviewed study published in a scientific journal, the new treatment reduced symptoms in 80% of patients.'' What makes this source likely reliable?', '["It was published in a peer-reviewed scientific journal","It was posted anonymously on social media","It has no data or evidence","It is based only on one person''s opinion"]', 0, 'Una publicación revisada por pares en una revista científica es un indicador de confiabilidad.', 'inicial', 25),
  ('Texto: ''Un blog personal sin autor identificado afirma que cierto alimento cura enfermedades graves, sin citar ninguna fuente.'' ¿Por qué esta fuente sería poco confiable?', '["Porque está muy bien documentada","Porque no tiene autor identificado ni fuentes citadas","Porque fue publicada en una revista científica","Porque incluye estadísticas verificadas"]', 1, 'La falta de autor identificado y de fuentes citadas hace que esta fuente sea poco confiable.', 'intermedia', 30),
  ('Text: ''This article, written by a certified nutritionist and citing three university studies, explains the benefits of a balanced diet.'' What elements make this source more trustworthy?', '["The author''s certification and citation of university studies","The article''s length only","The number of images included","The color of the website"]', 0, 'La certificación del autor y la cita de estudios universitarios son elementos que aumentan la confiabilidad.', 'intermedia', 30),
  ('Text A: ''A government health agency reports, based on national data, that vaccination rates have increased by 15% this year.'' Text B: ''An anonymous social media post claims vaccination rates decreased dramatically, without citing any source.'' When evaluating both sources for reliability, which is more trustworthy, and why?', '["Text B, because social media is always more up to date","Both are equally reliable since they discuss the same topic","Neither is reliable because they discuss health topics","Text A, because it comes from an official agency and cites national data, unlike Text B''s anonymous, unsupported claim"]', 3, 'El texto A proviene de una fuente oficial con datos citados, mientras que el texto B es anónimo y sin respaldo, por lo que el texto A es más confiable.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_1_medio' and lo.short_name = 'Evaluación de la confiabilidad de una fuente escrita'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ORAL — 1° MEDIO
-- ============================================================================

-- Objetivo: Presentación oral organizada sobre un tema de interés
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración es adecuada para introducir una presentación oral organizada?', '["Today, I will talk about three main aspects of climate change: causes, effects, and solutions.","Climate change, yes, bad, very bad.","I don''t know what to say about climate change.","Climate is a word with seven letters."]', 0, 'Esta oración presenta claramente el tema y su organización en tres partes, un inicio adecuado.', 'inicial', 25),
  ('¿Qué elemento es recomendable incluir en el desarrollo de una presentación oral organizada?', '["Solo opiniones personales sin ningún dato","Evidencia, ejemplos o datos que respalden cada punto","Ninguna información adicional","Repetir la introducción varias veces"]', 1, 'Incluir evidencia y ejemplos que respalden cada punto es clave en el desarrollo de una presentación organizada.', 'intermedia', 30),
  ('¿Cuál oración es adecuada para el cierre de una presentación oral sobre un tema de interés?', '["That''s it, I guess, bye.","To conclude, addressing climate change requires both individual and collective action.","Climate change, the end, whatever.","I forgot what I wanted to say at the end."]', 1, 'Esta oración cierra la presentación con una conclusión clara y relevante al tema.', 'intermedia', 30),
  ('Debes organizar una presentación oral sobre el uso de la tecnología en la educación, con introducción, desarrollo (con evidencia) y cierre. ¿Cuál secuencia cumple mejor esta estructura?', '["Technology is good. I like technology. The end.","Today, I will discuss the impact of technology on education. Studies show it improves access to information, though it requires responsible use. In conclusion, technology can be a powerful tool when used wisely.","Technology, education, good, bad, conclusion.","I don''t want to talk about technology today."]', 1, 'Esta secuencia presenta una introducción clara, un desarrollo con evidencia (estudios) y una conclusión coherente.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_1_medio' and lo.short_name = 'Presentación oral organizada sobre un tema de interés'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Argumentación oral de una postura personal
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración presenta correctamente una postura personal con una razón?', '["I believe schools should teach coding because it prepares students for future careers.","Coding is a word. Schools exist. Careers exist too.","I don''t know if schools should teach coding.","Coding, schools, careers, maybe."]', 0, 'Esta oración presenta una postura clara (creo que las escuelas deberían enseñar programación) con una razón (prepara para el futuro).', 'inicial', 25),
  ('¿Cuál oración presenta correctamente un contraargumento dentro de una argumentación oral?', '["I agree completely with everything.","Some people might say this is expensive, but the long-term benefits outweigh the cost.","I have no opinion on this topic.","This is a topic. Topics exist."]', 1, 'Esta oración reconoce una posible objeción (el costo) y la responde con un contraargumento (beneficios a largo plazo).', 'intermedia', 30),
  ('¿Cuál oración usa evidencia para apoyar una postura personal de forma oral?', '["I think this is true because I feel like it.","According to a recent study, this approach has shown positive results in several schools.","This is true because everyone says so.","I don''t need any evidence to prove this."]', 1, 'Esta oración usa evidencia concreta (un estudio reciente) para apoyar la postura personal.', 'intermedia', 30),
  ('Debes argumentar oralmente tu postura sobre la obligatoriedad del uniforme escolar, incluyendo postura, razón, evidencia o ejemplo, y una respuesta a una posible objeción. ¿Cuál opción cumple con estos cuatro elementos?', '["Uniforms are good. I like them. The end.","I think uniforms should be optional, because they reduce individual expression; for example, many students feel less motivated when they can''t choose their clothes, and although some say uniforms reduce bullying, evidence suggests other factors matter more.","Uniforms, school, clothes, opinion.","I don''t have any opinion about uniforms."]', 1, 'Esta opción incluye postura, razón, ejemplo y una respuesta a una posible objeción, cumpliendo con una argumentación oral completa.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_1_medio' and lo.short_name = 'Argumentación oral de una postura personal'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Participación en discusiones grupales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una discusión grupal, ¿cuál es una forma adecuada de pedir la palabra respetuosamente?', '["Can I add something to that point?","Be quiet, it''s my turn now.","Stop talking, I want to speak.","Nobody cares what you think."]', 0, '''Can I add something to that point?'' es una forma respetuosa de pedir la palabra.', 'inicial', 25),
  ('¿Cuál expresión es adecuada para reconocer el punto de otra persona antes de agregar tu propia idea en una discusión grupal?', '["You are completely wrong about everything.","That''s a good point, and I would also like to add that...","I don''t care what you said.","Stop interrupting me."]', 1, 'Esta expresión reconoce el punto de la otra persona antes de agregar una idea propia, favoreciendo una discusión respetuosa.', 'intermedia', 30),
  ('Durante una discusión grupal sobre un proyecto, un compañero no ha participado. ¿Cuál es una forma adecuada de invitarlo a participar?', '["You never say anything useful.","What do you think about this, Javier? We''d like to hear your opinion.","Just stay quiet, it''s fine.","Nobody needs your opinion here."]', 1, 'Esta expresión invita respetuosamente a un compañero a participar y compartir su opinión.', 'intermedia', 30),
  ('En una discusión grupal, dos compañeros tienen opiniones opuestas y la conversación se está tensando. ¿Cuál intervención sería más adecuada para mantener un ambiente de respeto y avanzar en la discusión?', '["I think both of your points are valid; let''s find common ground before moving forward.","One of you is clearly wrong, so let''s just ignore that opinion.","This discussion is pointless, let''s stop talking.","Everyone should just agree with me."]', 0, 'Esta intervención reconoce ambas posturas y busca puntos en común, ayudando a mantener un ambiente respetuoso y productivo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_1_medio' and lo.short_name = 'Participación en discusiones grupales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de vocabulario más variado y preciso
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En vez de decir ''good'' repetidamente, ¿cuál palabra ofrece un vocabulario más preciso para describir una idea excelente?', '["Outstanding","Thing","Stuff","Okay"]', 0, '''Outstanding'' es una palabra más precisa y variada que ''good'' para describir algo excelente.', 'inicial', 25),
  ('En vez de decir ''bad'' repetidamente, ¿cuál palabra ofrece un vocabulario más preciso para describir una situación muy negativa?', '["Nice","Terrible","Fine","Okay"]', 1, '''Terrible'' es más preciso que ''bad'' para describir algo muy negativo.', 'intermedia', 30),
  ('En vez de decir ''big'' repetidamente para describir un problema serio, ¿cuál palabra ofrece un vocabulario más preciso y académico?', '["Small","Tiny","Significant","Little"]', 2, '''Significant'' es una palabra más precisa y de registro más académico que ''big'' para describir un problema serio.', 'intermedia', 30),
  ('Debes reemplazar la palabra ''very'' en la oración ''The results were very important and very surprising'' con vocabulario más variado y preciso. ¿Cuál opción logra esto mejor?', '["The results were very very important and surprising.","The results were quite important and quite surprising.","The results were crucial and remarkable.","The results were important and surprising and good."]', 2, '''Crucial'' y ''remarkable'' reemplazan ''very important'' y ''very surprising'' con vocabulario más variado y preciso.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_1_medio' and lo.short_name = 'Uso de vocabulario más variado y preciso'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ESCRITA — 1° MEDIO
-- ============================================================================

-- Objetivo: Redacción de un texto argumentativo simple
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración presenta correctamente una tesis para un texto argumentativo?', '["Schools should offer more physical education classes because it improves students'' health and focus.","Physical education is a class. Schools have classes.","I don''t know about physical education.","Physical education, classes, schools, maybe."]', 0, 'Esta oración presenta una tesis clara con una razón que la justifica.', 'inicial', 25),
  ('¿Cuál oración funciona como un argumento de apoyo adecuado para la tesis ''Reading should be encouraged in schools''?', '["Reading is a word with seven letters.","Studies show that regular reading improves vocabulary and critical thinking skills.","Some people don''t like reading.","Reading, schools, encouraged, word."]', 1, 'Esta oración presenta evidencia (estudios) que apoya la tesis sobre fomentar la lectura.', 'intermedia', 30),
  ('¿Cuál oración es adecuada para cerrar un texto argumentativo simple, resumiendo la postura?', '["In conclusion, encouraging reading in schools brings significant benefits to students'' development.","Reading, the end, goodbye forever.","I don''t want to talk about reading anymore.","Reading is a book. Books have pages."]', 0, 'Esta oración resume claramente la postura y cierra el texto argumentativo de forma coherente.', 'intermedia', 30),
  ('Debes redactar un texto argumentativo simple sobre la importancia del reciclaje, con tesis, un argumento con evidencia, y una conclusión. ¿Cuál secuencia cumple mejor esta estructura?', '["Recycling is good. I like recycling. The end.","Recycling should be a priority for everyone. For example, recycling one ton of paper saves about 17 trees, showing its clear environmental benefit. In conclusion, we must all commit to recycling more.","Recycling, environment, trees, conclusion, recycling again.","I don''t know if recycling matters."]', 1, 'Esta secuencia presenta una tesis clara, un argumento con evidencia concreta y una conclusión coherente.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_1_medio' and lo.short_name = 'Redacción de un texto argumentativo simple'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de conectores de contraste y consecuencia
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál conector expresa correctamente contraste, como en ''The plan was risky. ___, it was successful''?', '["However","Because","So","As a result"]', 0, '''However'' expresa correctamente un contraste entre dos ideas.', 'inicial', 25),
  ('¿Cuál conector expresa correctamente consecuencia, como en ''She studied every day. ___, she passed the exam easily''?', '["Although","Despite","As a result","In contrast"]', 2, '''As a result'' expresa correctamente una consecuencia de la acción mencionada anteriormente.', 'intermedia', 30),
  ('¿Cuál conector expresa correctamente contraste, como en ''___ the rain, they decided to go for a walk''?', '["Despite","Therefore","So","Because"]', 0, '''Despite'' expresa correctamente un contraste, indicando que hicieron algo a pesar de la lluvia.', 'intermedia', 30),
  ('Debes unir estas ideas con el conector más adecuado para expresar consecuencia: ''The company invested heavily in employee training. ___, productivity increased significantly over the following year.''', '["However","Although","In contrast","Consequently"]', 3, '''Consequently'' conecta adecuadamente la causa (invertir en capacitación) con su consecuencia (aumento de productividad).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_1_medio' and lo.short_name = 'Uso de conectores de contraste y consecuencia'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Aplicación de un proceso de escritura con planificación y revisión
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la primera etapa recomendada dentro de un proceso de escritura completo?', '["Planificación de las ideas principales","Publicación del texto final","Corrección de la versión final","Impresión del documento"]', 0, 'La planificación de las ideas principales es la primera etapa de un proceso de escritura completo.', 'inicial', 25),
  ('Después de escribir un primer borrador, ¿qué etapa corresponde aplicar antes de la versión final?', '["Publicar el borrador sin cambios","Revisión y corrección del borrador","Volver a planificar desde cero sin usar el borrador","Eliminar el borrador completo"]', 1, 'Revisar y corregir el borrador es la etapa que corresponde antes de la versión final.', 'intermedia', 30),
  ('Un estudiante escribió un texto completo, pero no realizó ninguna revisión antes de entregarlo. ¿Qué etapa del proceso de escritura no aplicó?', '["La planificación","La escritura del borrador","La revisión y corrección","Ninguna etapa, el proceso está completo"]', 2, 'No aplicó la etapa de revisión y corrección, que es esencial en un proceso de escritura completo.', 'intermedia', 30),
  ('Debes aplicar un proceso de escritura completo para un ensayo: planificación, borrador, revisión y versión final. Un estudiante planifica, escribe el borrador, pero publica esa misma versión sin cambios como final. ¿Qué etapa faltó aplicar correctamente?', '["La planificación, que nunca se hizo","El borrador, que nunca se escribió","La revisión y corrección antes de la versión final","Ninguna etapa faltó"]', 2, 'Faltó aplicar la revisión y corrección del borrador antes de considerarlo la versión final.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_1_medio' and lo.short_name = 'Aplicación de un proceso de escritura con planificación y revisión'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Adecuación del registro escrito a la situación comunicativa
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 1° Medio, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración usa un registro formal adecuado para una carta dirigida a una autoridad?', '["Dear Sir or Madam, I am writing to request information about the program.","Hey, what''s up, I need info about the program.","Yo, tell me about the program.","Gimme the info about the program now."]', 0, 'Esta oración usa un registro formal adecuado para una carta dirigida a una autoridad.', 'inicial', 25),
  ('¿Cuál oración usa un registro informal adecuado para un mensaje de texto a un amigo?', '["Dear friend, I would like to inform you that I cannot attend.","Hey, sorry, I can''t make it today!","To Whom It May Concern, I regret to inform you.","This letter serves to notify you of my absence."]', 1, 'Esta oración usa un registro informal adecuado para un mensaje de texto a un amigo.', 'intermedia', 30),
  ('¿Cuál oración es más adecuada para un correo formal solicitando información a una universidad?', '["Yo, send me info about your programs, thanks.","Hi, gimme the program details please.","I would like to kindly request further information regarding your academic programs.","Hey, what programs do you guys have?"]', 2, 'Esta oración usa un registro formal adecuado para una solicitud a una institución educativa.', 'intermedia', 30),
  ('Debes escribir dos mensajes distintos sobre el mismo tema (pedir información sobre un curso): uno a un amigo y otro a la institución educativa. ¿Cuál par de oraciones refleja mejor la adecuación de registro en cada caso?', '["Hey, what''s this course about? / Hey, what''s this course about?","I would like to kindly request information about this course. / I would like to kindly request information about this course.","Hey, what''s this course about? / I would like to kindly request information about this course, please.","Gimme info. / Gimme info please."]', 2, 'La primera oración usa un registro informal apropiado para un amigo, y la segunda un registro formal apropiado para una institución.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_1_medio' and lo.short_name = 'Adecuación del registro escrito a la situación comunicativa'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
