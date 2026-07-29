-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Idioma
-- Extranjero: Inglés, 6° Básico. Cubre los 16 objetivos de aprendizaje de
-- 6° Básico cargados por supabase/seed/0023_curriculum_ingles_regular_basica_5_6.sql
-- (4 ejes: Comprensión Auditiva, Comprensión Lectora, Expresión Oral,
-- Expresión Escrita), con 4 preguntas por objetivo, total 64 preguntas en
-- este archivo.
--
-- Mismo estado editorial, criterio de idioma (ver encabezado completo de
-- supabase/seed/0111_questions_ingles_regular_5basico.sql, mismo criterio
-- aplicado aquí sin repetirlo íntegro: instrucciones/preguntas ''meta'' en
-- español dado el nivel A1-A2 de 6° Básico, contenido evaluado siempre en
-- inglés, alternativas en español cuando se pide traducir/identificar
-- significado y en inglés cuando se pide reconocer/completar/producir texto
-- en inglés), fuente, validación mecánica e idempotencia que 0111. `source`
-- de cada objetivo cita Decreto Supremo N.° 439/2012 (misma banda 5°-6°
-- Básico). Seed SOLO local: no se ha ejecutado contra Supabase.

-- ============================================================================
-- EJE: COMPRENSIÓN AUDITIVA — 6° BÁSICO
-- ============================================================================

-- Objetivo: Comprensión de descripciones orales simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Escuchas: ''She has long black hair and blue eyes.'' ¿Qué describe el audio?', '["A una persona","Un lugar","Un animal","Una comida"]', 0, 'El audio describe las características físicas de una persona.', 'inicial', 25),
  ('Escuchas: ''The house is big and has a red roof.'' ¿Qué característica del techo se menciona?', '["Es pequeño","Es de color rojo","No tiene techo","Es de color azul"]', 1, 'El audio indica que el techo es de color rojo.', 'intermedia', 30),
  ('Escuchas: ''My cat is small, white, and very playful.'' ¿Qué palabra describe el comportamiento del gato?', '["Small","White","Playful","My"]', 2, '''Playful'' describe el comportamiento (juguetón) del gato.', 'intermedia', 30),
  ('Escuchas: ''The classroom is large, with big windows and green walls.'' ¿Cuáles son las tres características mencionadas sobre la sala?', '["Pequeña, ventanas chicas, paredes rojas","Grande, sin ventanas, paredes blancas","Pequeña, sin ventanas, paredes verdes","Grande, ventanas grandes, paredes verdes"]', 3, 'El audio menciona que la sala es grande, con ventanas grandes y paredes verdes.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_6_basico' and lo.short_name = 'Comprensión de descripciones orales simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Seguimiento de instrucciones de varios pasos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Escuchas: ''First, open your notebook. Then, write the date.'' ¿Qué se debe hacer primero?', '["Abrir el cuaderno","Escribir la fecha","Cerrar el cuaderno","Borrar la fecha"]', 0, 'La instrucción indica hacer primero (''first'') abrir el cuaderno.', 'inicial', 25),
  ('Escuchas: ''First, stand up. Then, take your bag. Finally, leave the room.'' ¿Cuál es el segundo paso?', '["Ponerse de pie","Tomar la mochila","Salir de la sala","Sentarse"]', 1, 'El segundo paso (''then'') es tomar la mochila.', 'intermedia', 30),
  ('Escuchas: ''First, wash your hands. Then, sit down. After that, open your book.'' ¿Cuál es el tercer paso?', '["Lavarse las manos","Sentarse","Abrir el libro","Cerrar el libro"]', 2, 'El tercer paso (''after that'') es abrir el libro.', 'intermedia', 30),
  ('Escuchas: ''First, listen to the question. Then, think about the answer. Finally, raise your hand before answering.'' ¿Cuál es el orden completo y correcto de los tres pasos?', '["Pensar, escuchar, levantar la mano","Levantar la mano, escuchar, pensar","Escuchar, levantar la mano, pensar","Escuchar, pensar, levantar la mano"]', 3, 'El orden correcto es escuchar la pregunta, pensar la respuesta y luego levantar la mano.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_6_basico' and lo.short_name = 'Seguimiento de instrucciones de varios pasos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de la idea general de un texto oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Escuchas un diálogo sobre dos amigos planeando ir al cine el sábado. ¿Cuál es la idea general del audio?', '["Dos amigos planean ir al cine","Dos amigos hablan de matemáticas","Un profesor da una clase","Una persona cocina una receta"]', 0, 'La idea general del audio es que dos amigos planean ir al cine.', 'inicial', 25),
  ('Escuchas un audio donde alguien describe su rutina diaria: se levanta, desayuna y va al colegio. ¿Cuál es la idea general?', '["Una receta de cocina","La rutina diaria de una persona","Un partido de fútbol","Una noticia del clima"]', 1, 'La idea general es la descripción de la rutina diaria de una persona.', 'intermedia', 30),
  ('Escuchas un audio sobre las vacaciones de una familia en la playa. ¿Cuál es la idea general?', '["Un examen de matemáticas","Una clase de historia","Las vacaciones de una familia en la playa","Una discusión entre amigos"]', 2, 'La idea general del audio son las vacaciones de una familia en la playa.', 'intermedia', 30),
  ('Escuchas un audio en el que se mencionan el clima, la comida y los juegos de un cumpleaños, pero el enfoque principal es la celebración misma. ¿Cuál es la idea general del texto oral, más allá de los detalles?', '["El clima del día","La comida servida","Los juegos realizados","La celebración de un cumpleaños"]', 3, 'Aunque se mencionan detalles como el clima, la comida y los juegos, la idea general es la celebración del cumpleaños.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_6_basico' and lo.short_name = 'Identificación de la idea general de un texto oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Reconocimiento de rutinas y horarios mencionados oralmente
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Escuchas: ''I wake up at seven o''clock every day.'' ¿A qué hora se despierta la persona?', '["A las siete","A las ocho","A las seis","A las nueve"]', 0, 'El audio indica que se despierta a las siete.', 'inicial', 25),
  ('Escuchas: ''I have lunch at one o''clock and dinner at eight o''clock.'' ¿A qué hora almuerza?', '["A las ocho","A la una","A las dos","A las siete"]', 1, 'El audio indica que almuerza a la una.', 'intermedia', 30),
  ('Escuchas: ''On Mondays, I go to school. On Saturdays, I play soccer.'' ¿Qué actividad realiza los sábados?', '["Ir al colegio","Estudiar en casa","Jugar fútbol","Dormir todo el día"]', 2, 'El audio indica que los sábados juega fútbol.', 'intermedia', 30),
  ('Escuchas: ''I wake up at seven, go to school at eight, and come back home at four.'' ¿Cuál es la secuencia correcta de horarios mencionados?', '["Ocho, siete, cuatro","Cuatro, siete, ocho","Ocho, cuatro, siete","Siete, ocho, cuatro"]', 3, 'El orden mencionado es despertar a las siete, ir al colegio a las ocho y volver a las cuatro.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_6_basico' and lo.short_name = 'Reconocimiento de rutinas y horarios mencionados oralmente'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMPRENSIÓN LECTORA — 6° BÁSICO
-- ============================================================================

-- Objetivo: Comprensión de textos breves sobre rutinas diarias
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''I wake up early and eat breakfast before school.'' ¿Qué hace la persona antes de ir al colegio?', '["Desayunar","Dormir","Jugar fútbol","Ver televisión"]', 0, 'El texto indica que desayuna antes de ir al colegio.', 'inicial', 25),
  ('Texto: ''After school, I do my homework and then play with my friends.'' ¿Qué hace primero después del colegio?', '["Jugar con amigos","Hacer las tareas","Dormir la siesta","Ver una película"]', 1, 'El texto indica que primero hace las tareas y luego juega con sus amigos.', 'intermedia', 30),
  ('Texto: ''Every night, I brush my teeth and go to bed at nine o''clock.'' ¿A qué hora se va a la cama?', '["A las ocho","A las diez","A las nueve","A las once"]', 2, 'El texto indica que se va a la cama a las nueve.', 'intermedia', 30),
  ('Texto: ''On weekdays, I study in the morning and play sports in the afternoon, but on weekends, I rest and visit my grandparents.'' ¿Qué diferencia principal se describe entre los días de semana y el fin de semana?', '["No hay ninguna diferencia","Los fines de semana estudia más","Entre semana estudia y hace deporte; el fin de semana descansa y visita a sus abuelos","Entre semana descansa; el fin de semana estudia"]', 3, 'El texto contrasta la rutina de estudio y deporte entre semana con el descanso y la visita a los abuelos el fin de semana.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_6_basico' and lo.short_name = 'Comprensión de textos breves sobre rutinas diarias'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de secuencia temporal en un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''First, I got dressed. Then, I had breakfast.'' ¿Qué ocurrió primero?', '["Vestirse","Desayunar","Ambos al mismo tiempo","No se puede saber"]', 0, 'El texto indica que primero se vistió y luego desayunó.', 'inicial', 25),
  ('Texto: ''Yesterday, I visited my grandmother. Today, I am doing homework.'' ¿Cuándo visitó a su abuela?', '["Hoy","Ayer","Mañana","La próxima semana"]', 1, 'El texto indica que visitó a su abuela ayer.', 'intermedia', 30),
  ('Texto: ''In the morning, we go to school. In the afternoon, we do sports. In the evening, we study.'' ¿Qué actividad ocurre al final del día?', '["Ir al colegio","Hacer deporte","Estudiar","Desayunar"]', 2, 'El texto indica que estudiar ocurre en la tarde-noche, al final del día.', 'intermedia', 30),
  ('Texto: ''Before lunch, I finished my homework. After lunch, I went to the park. In the evening, I watched a movie.'' ¿Cuál es el orden correcto de las tres actividades?', '["Ver película, ir al parque, hacer tarea","Ir al parque, hacer tarea, ver película","Hacer tarea, ver película, ir al parque","Hacer tarea, ir al parque, ver película"]', 3, 'El orden correcto según el texto es: terminar la tarea, ir al parque y luego ver una película.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_6_basico' and lo.short_name = 'Identificación de secuencia temporal en un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Inferencia de significado por contexto o imágenes
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Texto: ''It was raining, so she took her umbrella before leaving home.'' Según el contexto, ¿qué es un ''umbrella''?', '["Un paraguas","Un abrigo","Unos zapatos","Una mochila"]', 0, 'El contexto de lluvia indica que ''umbrella'' significa paraguas.', 'inicial', 25),
  ('Texto: ''The soup was too hot, so he waited before eating it.'' Según el contexto, ¿qué palabra indica que debía esperar?', '["Soup","Eating","Hot","Waited"]', 1, '''Waited'' indica que debía esperar antes de comer, debido a que estaba caliente.', 'intermedia', 30),
  ('Texto: ''She was shivering because it was very cold outside.'' Según el contexto, ¿qué significa ''shivering''?', '["Sudando por el calor","Riendo con fuerza","Temblando de frío","Durmiendo profundamente"]', 2, 'El contexto de frío indica que ''shivering'' significa temblar de frío.', 'intermedia', 30),
  ('Texto e imagen de una persona con mochila abordando un bus: ''He was running because he almost missed the bus.'' Según el contexto e imagen, ¿qué se puede inferir sobre la situación?', '["Que llegó muy temprano al paradero","Que perdió el bus por completo","Que no quería tomar el bus","Que estaba apurado porque casi pierde el bus"]', 3, 'El contexto y la imagen permiten inferir que estaba apurado porque casi pierde el bus.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_6_basico' and lo.short_name = 'Inferencia de significado por contexto o imágenes'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de mensajes y notas simples
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Nota: ''Meet me at the park at five.'' ¿Dónde se debe encontrar la persona?', '["En el parque","En el colegio","En su casa","En el cine"]', 0, 'La nota indica que el encuentro es en el parque.', 'inicial', 25),
  ('Mensaje: ''Don''t forget to bring your book tomorrow.'' ¿Qué se le pide a la persona?', '["Olvidar el libro","Traer el libro mañana","Comprar un libro nuevo","Prestar el libro a un amigo"]', 1, 'El mensaje pide no olvidar traer el libro mañana.', 'intermedia', 30),
  ('Nota: ''Call me when you arrive home.'' ¿Qué se le pide hacer a la persona?', '["Escribir una carta","Enviar un mensaje","Llamar al llegar a casa","No llamar a nadie"]', 2, 'La nota pide llamar cuando llegue a casa.', 'intermedia', 30),
  ('Mensaje: ''The meeting was moved from Monday to Wednesday. Please confirm your attendance by email.'' ¿Qué dos acciones se piden en el mensaje?', '["Cancelar la reunión y no responder","Confirmar la asistencia y cambiar el día a lunes","Llamar por teléfono y cancelar el correo","Tomar nota del nuevo día (miércoles) y confirmar asistencia por correo"]', 3, 'El mensaje pide tomar nota del cambio de día (a miércoles) y confirmar la asistencia por correo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_6_basico' and lo.short_name = 'Comprensión de mensajes y notas simples'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ORAL — 6° BÁSICO
-- ============================================================================

-- Objetivo: Descripción oral de personas y objetos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración describe correctamente la apariencia física de una persona?', '["She has brown eyes and long hair.","She goes to school by bus.","She likes to read books.","She lives in Santiago."]', 0, '''She has brown eyes and long hair'' describe la apariencia física.', 'inicial', 25),
  ('¿Cuál oración describe correctamente un objeto?', '["He is very tall.","The table is made of wood and is brown.","I like pizza.","She is my sister."]', 1, '''The table is made of wood and is brown'' describe un objeto.', 'intermedia', 30),
  ('Al describir oralmente a un compañero, ¿qué tipo de información es más adecuada incluir?', '["Su número de teléfono","Su dirección exacta","Su apariencia física y personalidad","Su contraseña de correo"]', 2, 'Al describir a una persona es adecuado mencionar su apariencia física y personalidad, no datos privados.', 'intermedia', 30),
  ('Debes describir oralmente tu mochila para que un compañero la identifique entre varias. ¿Cuál descripción es más útil y completa?', '["It is a bag.","I like my backpack.","My backpack is at school.","My backpack is blue, small, and has a yellow zipper."]', 3, 'Una descripción útil incluye detalles específicos como color, tamaño y características distintivas, como en la última opción.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_6_basico' and lo.short_name = 'Descripción oral de personas y objetos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Expresión de gustos y preferencias
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración expresa correctamente un gusto?', '["I like pizza.","I am ten years old.","I live in Chile.","I go to school by bus."]', 0, '''I like pizza'' expresa un gusto o preferencia.', 'inicial', 25),
  ('¿Cuál es una forma correcta de expresar una preferencia entre dos opciones?', '["I have two brothers.","I prefer soccer to basketball.","I am in sixth grade.","My name is Pablo."]', 1, '''I prefer soccer to basketball'' expresa una preferencia entre dos opciones.', 'intermedia', 30),
  ('Si te preguntan ''What is your favorite color?'', ¿cuál es una respuesta adecuada?', '["I am fine, thank you.","I live in Temuco.","My favorite color is blue.","I have a dog."]', 2, '''My favorite color is blue'' responde adecuadamente a la pregunta sobre el color favorito.', 'intermedia', 30),
  ('Un compañero dice: ''I don''t like vegetables, but I love fruit, especially apples.'' ¿Qué gustos y preferencias expresa, en orden?', '["Le gustan las verduras y no le gusta la fruta","Le gusta la fruta pero no las manzanas","No le gusta ninguna comida","No le gustan las verduras, pero le encanta la fruta, especialmente las manzanas"]', 3, 'El compañero expresa que no le gustan las verduras, pero le encanta la fruta, en especial las manzanas.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_6_basico' and lo.short_name = 'Expresión de gustos y preferencias'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Diálogos breves sobre situaciones cotidianas
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En una tienda, ¿cuál es una pregunta adecuada para saber el precio de algo?', '["How much is this?","What is your name?","Where do you live?","How old are you?"]', 0, '''How much is this?'' se usa para preguntar el precio en una tienda.', 'inicial', 25),
  ('En un restaurante, ¿cuál frase es adecuada para pedir comida?', '["Goodbye, see you later.","I would like a sandwich, please.","How old are you?","Where is the library?"]', 1, '''I would like a sandwich, please'' es adecuada para pedir comida en un restaurante.', 'intermedia', 30),
  ('Si te pierdes en la calle, ¿cuál pregunta es adecuada para pedir direcciones?', '["What is your favorite food?","How are you today?","Excuse me, where is the bus stop?","What time do you wake up?"]', 2, '''Excuse me, where is the bus stop?'' es adecuada para pedir direcciones.', 'intermedia', 30),
  ('Estás en una tienda y quieres comprar zapatos, pero no sabes si está disponible tu talla. ¿Cuál pregunta es la más adecuada para esta situación?', '["Goodbye. Thank you very much.","What is your name? I like shoes.","Excuse me, do you have this in size seven?","How old are you? I need shoes."]', 3, 'Preguntar por la talla disponible (''do you have this in size seven?'') es lo adecuado para esta situación de compra.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_6_basico' and lo.short_name = 'Diálogos breves sobre situaciones cotidianas'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de expresiones de cortesía
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál expresión se usa para pedir un favor de forma cortés?', '["Could you help me, please?","I don''t want to talk.","Go away.","Give me that now."]', 0, '''Could you help me, please?'' es una forma cortés de pedir un favor.', 'inicial', 25),
  ('Si alguien te ayuda, ¿cuál es una expresión de cortesía adecuada para responder?', '["Whatever.","Thank you so much.","I don''t care.","No, never."]', 1, '''Thank you so much'' es una expresión de cortesía adecuada para agradecer.', 'intermedia', 30),
  ('Si accidentalmente empujas a alguien, ¿qué expresión de cortesía deberías usar?', '["Be quiet.","Go away, please.","I''m sorry, excuse me.","That''s your fault."]', 2, '''I''m sorry, excuse me'' es la expresión adecuada para disculparse.', 'intermedia', 30),
  ('Entras a una tienda y necesitas ayuda, pero también quieres agradecer al final. ¿Cuál par de expresiones de cortesía es el más adecuado para el inicio y el final de la conversación?', '["Go away / Whatever","Give me that / I don''t care","Be quiet / No thanks","Excuse me, could you help me? / Thank you very much"]', 3, 'Al inicio se pide ayuda cortésmente y al final se agradece, como en la última opción.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_6_basico' and lo.short_name = 'Uso de expresiones de cortesía'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ESCRITA — 6° BÁSICO
-- ============================================================================

-- Objetivo: Escritura de oraciones sobre rutinas diarias
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración describe correctamente una rutina diaria, usando el modelo ''I ___ at seven''?', '["I wake up at seven.","Wake up I seven at.","At seven wake up I.","I at seven wake up."]', 0, '''I wake up at seven'' sigue el orden correcto en inglés.', 'inicial', 25),
  ('¿Cuál oración describe correctamente una rutina, usando el modelo ''I have breakfast ___''?', '["Breakfast I have every day.","I have breakfast every day.","Every day breakfast I have.","I every day have breakfast."]', 1, '''I have breakfast every day'' sigue el orden correcto.', 'intermedia', 30),
  ('¿Cuál oración describe correctamente el uso de ''before''?', '["I do my homework, before dinner.","Before dinner homework I do.","I do my homework before dinner.","My homework before I do dinner."]', 2, '''I do my homework before dinner'' usa correctamente el conector ''before''.', 'intermedia', 30),
  ('Debes escribir tres oraciones sobre tu rutina diaria en orden cronológico (mañana, tarde, noche). ¿Cuál secuencia respeta ese orden?', '["I go to bed at nine. I go to school at eight. I wake up at seven.","I go to school at eight. I go to bed at nine. I wake up at seven.","I wake up at seven. I go to bed at nine. I go to school at eight.","I wake up at seven. I go to school at eight. I go to bed at nine."]', 3, 'El orden cronológico correcto es despertar, ir al colegio y finalmente ir a la cama.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_6_basico' and lo.short_name = 'Escritura de oraciones sobre rutinas diarias'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso del presente simple en oraciones
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración usa correctamente el presente simple en tercera persona?', '["She likes chocolate.","She like chocolate.","She liking chocolate.","She to like chocolate."]', 0, '''She likes chocolate'' agrega correctamente la ''-s'' en tercera persona del presente simple.', 'inicial', 25),
  ('¿Cuál oración usa correctamente la forma negativa del presente simple?', '["She not likes coffee.","She doesn''t like coffee.","She don''t likes coffee.","She no like coffee."]', 1, '''She doesn''t like coffee'' usa correctamente ''doesn''t'' con el verbo en forma base.', 'intermedia', 30),
  ('¿Cuál oración usa correctamente la forma interrogativa del presente simple?', '["Does she likes tea?","She likes tea?","Do she like tea?","Does she like tea?"]', 2, '''Does she like tea?'' usa correctamente ''does'' seguido del verbo en forma base.', 'intermedia', 30),
  ('Debes elegir el conjunto que combina correctamente presente simple afirmativo, negativo e interrogativo sobre la misma persona (Juan). ¿Cuál conjunto es completamente correcto?', '["Juan like soccer. Juan doesn''t likes tennis. Does Juan like golf?","Juan likes soccer. Juan don''t like tennis. Do Juan likes golf?","Juan likes soccer. Juan doesn''t like tennis. Does Juan like golf?","Juan liking soccer. Juan not like tennis. Juan like golf?"]', 3, 'La opción correcta usa correctamente ''likes'' (afirmativo), ''doesn''t like'' (negativo) y ''Does Juan like...?'' (interrogativo).', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_6_basico' and lo.short_name = 'Uso del presente simple en oraciones'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Redacción de descripciones breves
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración es una descripción breve y correcta de una persona?', '["My friend is tall and friendly.","My friend school every day.","Friend my is tall.","Tall friendly my is friend."]', 0, '''My friend is tall and friendly'' es una descripción breve y gramaticalmente correcta.', 'inicial', 25),
  ('¿Cuál oración describe correctamente un lugar?', '["The park is green and it doing fun.","The park is big and green.","Big and green the park.","Park the is big green."]', 1, '''The park is big and green'' describe correctamente un lugar de forma breve.', 'intermedia', 30),
  ('¿Cuál oración describe correctamente un animal, incluyendo una característica y un color?', '["Dog my small is brown.","My dog small brown is.","My dog is small and brown.","Is my dog small brown."]', 2, '''My dog is small and brown'' describe correctamente al animal con orden gramatical adecuado.', 'intermedia', 30),
  ('Debes redactar una descripción breve de tu casa incluyendo tamaño, color y una característica adicional. ¿Cuál opción es la más completa y correcta?', '["My house is a house.","House my is big white and has garden.","My house big, white, garden.","My house is big, white, and has a garden."]', 3, 'La última opción incluye tamaño (big), color (white) y una característica adicional (garden) con orden gramatical correcto.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_6_basico' and lo.short_name = 'Redacción de descripciones breves'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Revisión de la ortografía de palabras frecuentes
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 6° Básico, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas palabras está escrita correctamente?', '["friend","frend","freind","friand"]', 0, '''Friend'' es la forma correctamente escrita de esta palabra frecuente.', 'inicial', 25),
  ('¿Cuál de estas palabras está escrita correctamente?', '["scool","school","shcool","schoool"]', 1, '''School'' es la forma correctamente escrita de esta palabra frecuente.', 'intermedia', 30),
  ('¿Cuál de estas palabras está escrita correctamente?', '["beacause","becuase","because","becaus"]', 2, '''Because'' es la forma correctamente escrita de esta palabra frecuente.', 'intermedia', 30),
  ('Un estudiante escribió: ''My freind and I go to shcool togheter.'' ¿Cuál es la versión con la ortografía corregida?', '["My freind and I go to school togheter.","My friend and I go to shcool together.","My friand and I go to school togheter.","My friend and I go to school together."]', 3, 'La versión correcta corrige las tres palabras mal escritas: ''friend'', ''school'' y ''together''.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_6_basico' and lo.short_name = 'Revisión de la ortografía de palabras frecuentes'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
