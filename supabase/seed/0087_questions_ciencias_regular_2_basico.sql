-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 2° Básico. Cubre los 14 objetivos de aprendizaje de 2° Básico
-- cargados por supabase/seed/0017_curriculum_ciencias_regular_basica_1_6.sql,
-- con 4 preguntas por objetivo, total 56 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí): `review_status = 'borrador'`, `validation_status =
-- 'ai_generated_review_required'`, `is_active = true`, `source_type =
-- 'validapp_original'`, `generated_by = 'claude-sonnet-5'`; posición de la
-- respuesta correcta rotada round-robin 0-1-2-3 por objetivo; sin duplicados
-- ni casi-duplicados dentro del archivo; `learning_objective_id` resuelto por
-- (subject.name, strand.name, level.code, short_name); seed SOLO local.

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos animales nace de un huevo (es ovíparo)?', '["La gallina","El perro","El gato","La vaca"]', 0, 'La gallina es un animal ovíparo: nace de un huevo puesto fuera del cuerpo de la madre.', 'inicial', 25),
  ('¿Qué característica tiene un animal vivíparo?', '["Nace de un huevo puesto afuera","Nace directamente del cuerpo de la madre","No tiene ciclo de vida","Vive solo en el agua"]', 1, 'Un animal vivíparo nace directamente del cuerpo de la madre, sin pasar por un huevo externo.', 'intermedia', 35),
  ('¿Cuál de estos animales es vivíparo?', '["La tortuga","La gallina","El perro","La rana"]', 2, 'El perro es un animal vivíparo: nace directamente del cuerpo de su madre.', 'intermedia', 35),
  ('Un estudiante observa que un animal puso un huevo del cual, después de un tiempo, salió una cría. ¿Qué tipo de animal es, según su forma de nacimiento?', '["Vivíparo","Mamífero siempre","Terrestre siempre","Ovíparo"]', 3, 'Un animal que nace de un huevo puesto por su madre es un animal ovíparo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_2_basico' and lo.short_name = 'Ciclo de vida de animales ovíparos y vivíparos'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Por qué los pingüinos tienen una capa gruesa de grasa bajo la piel?', '["Para adaptarse al frío extremo","Para volar mejor","Para nadar más lento","Para cambiar de color"]', 0, 'La capa de grasa ayuda a los pingüinos a mantener el calor y adaptarse al frío extremo.', 'inicial', 25),
  ('¿Cuál de estas es una adaptación que ayuda a un cactus a vivir en el desierto?', '["Hojas grandes que pierden mucha agua","Almacenar agua en su tallo","Necesitar mucha lluvia diaria","Vivir siempre bajo el agua"]', 1, 'Los cactus almacenan agua en su tallo, lo que les permite sobrevivir en ambientes secos como el desierto.', 'intermedia', 35),
  ('¿Qué adaptación tienen los patos que les permite nadar con facilidad?', '["Pico curvo hacia abajo","Patas muy largas y delgadas","Membranas entre los dedos de sus patas","Plumas de color rojo"]', 2, 'Las membranas entre los dedos de las patas de los patos les ayudan a nadar con facilidad.', 'intermedia', 35),
  ('Un animal vive en un lugar con temperaturas muy bajas todo el año. ¿Cuál de estas características sería una adaptación útil para sobrevivir allí?', '["Piel muy delgada y sin pelaje","Necesitar mucha agua para refrescarse","Vivir expuesto sin refugio","Tener un pelaje grueso que lo abrigue"]', 3, 'Un pelaje grueso ayuda a un animal a mantener el calor corporal en ambientes muy fríos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_2_basico' and lo.short_name = 'Adaptaciones simples de los seres vivos al entorno'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas plantas es nativa de Chile?', '["El copihue","Un manzano de una variedad importada","El trigo","El arroz"]', 0, 'El copihue es una planta nativa de Chile y su flor nacional.', 'inicial', 25),
  ('¿Qué significa que una planta sea ''nativa'' de un lugar?', '["Que fue traída de otro país recientemente","Que creció de forma natural en ese lugar, sin ser traída por personas","Que solo crece en macetas","Que no necesita agua"]', 1, 'Una planta nativa es aquella que creció de forma natural en un lugar, sin haber sido introducida por personas.', 'intermedia', 35),
  ('¿En cuál de estos hábitats de Chile es más probable encontrar plantas nativas adaptadas a climas muy secos?', '["En un río caudaloso","En el fondo del mar","En el desierto de Atacama","En una ciudad con mucho cemento"]', 2, 'El desierto de Atacama es un hábitat seco donde existen plantas nativas adaptadas a la escasez de agua.', 'intermedia', 35),
  ('Un estudiante investiga sobre la araucaria, un árbol que crece de forma natural en el sur de Chile desde hace miles de años. ¿Qué tipo de planta es la araucaria según esta descripción?', '["Una planta introducida recientemente","Una planta que solo existe en otros países","Una planta artificial","Una planta nativa de Chile"]', 3, 'Una planta que crece de forma natural en un territorio desde hace mucho tiempo es una planta nativa.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_2_basico' and lo.short_name = 'Plantas nativas y su hábitat en Chile'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una fruta?', '["La manzana","El pan","El arroz","La carne"]', 0, 'La manzana es una fruta, un alimento de origen vegetal.', 'inicial', 25),
  ('¿Por qué es importante comer alimentos variados?', '["Porque solo importa comer dulces","Para obtener distintos nutrientes que el cuerpo necesita","Porque así se come más rápido","Porque no importa lo que se coma"]', 1, 'Comer alimentos variados permite obtener distintos nutrientes necesarios para el cuerpo.', 'intermedia', 35),
  ('¿Cuál de estos alimentos es de origen animal?', '["La lechuga","La zanahoria","El pescado","La manzana"]', 2, 'El pescado es un alimento de origen animal, a diferencia de la lechuga, la zanahoria y la manzana.', 'intermedia', 35),
  ('Un estudiante come todos los días muchas golosinas y muy pocas frutas y verduras. ¿Qué recomendación sería más adecuada para mejorar su alimentación?', '["Seguir comiendo solo golosinas","Dejar de comer por completo","Comer únicamente carne","Aumentar el consumo de frutas y verduras"]', 3, 'Aumentar el consumo de frutas y verduras ayuda a tener una alimentación más saludable y variada.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_2_basico' and lo.short_name = 'Alimentación saludable'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué ocurre cuando empujas una pelota que está quieta?', '["Se mueve","Desaparece","Cambia de color","Se vuelve más pesada"]', 0, 'Al aplicar una fuerza de empuje sobre la pelota, esta comienza a moverse.', 'inicial', 25),
  ('¿Cuál de estas acciones corresponde a aplicar una fuerza de tirar?', '["Empujar una puerta para cerrarla","Jalar una cuerda hacia ti","Soltar un objeto al aire","Dejar un objeto quieto"]', 1, 'Jalar una cuerda hacia ti es un ejemplo de aplicar una fuerza de tirar.', 'intermedia', 35),
  ('Si dos niños empujan un carro en direcciones opuestas con la misma fuerza, ¿qué es lo más probable que ocurra con el carro?', '["Se moverá muy rápido hacia un lado","Se moverá en círculos","El carro permanecerá quieto","Se moverá hacia arriba"]', 2, 'Cuando dos fuerzas iguales y opuestas actúan sobre un objeto, este permanece quieto.', 'intermedia', 35),
  ('Un estudiante patea suavemente una pelota y luego la patea con mucha más fuerza. ¿Qué se puede concluir sobre la relación entre la fuerza aplicada y el movimiento de la pelota?', '["La fuerza no afecta el movimiento","La pelota se mueve igual sin importar la fuerza","La pelota se detiene con cualquier fuerza","A mayor fuerza aplicada, mayor es el movimiento de la pelota"]', 3, 'A mayor fuerza aplicada sobre un objeto, generalmente mayor es el efecto sobre su movimiento.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_2_basico' and lo.short_name = 'Fuerzas y su efecto sobre el movimiento'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas opciones es un ejemplo de mezcla de materiales?', '["Arena y piedras juntas en un balde","Un vaso de agua sola","Una piedra sola","Un trozo de madera"]', 0, 'Arena y piedras juntas en un balde es un ejemplo de mezcla de materiales.', 'inicial', 25),
  ('¿Qué ocurre al mezclar agua con arena?', '["Se forma un solo material nuevo que no se puede separar","Ambos materiales se pueden separar porque no se combinan químicamente","El agua desaparece por completo","La arena se convierte en agua"]', 1, 'Al mezclar agua con arena, ambos materiales conservan sus propiedades y se pueden separar.', 'intermedia', 35),
  ('¿Cuál de estas es una mezcla de materiales sólidos?', '["Agua con sal disuelta","Aceite con agua","Botones y monedas juntos en una caja","Aire puro"]', 2, 'Botones y monedas juntos en una caja es un ejemplo de mezcla de materiales sólidos.', 'intermedia', 35),
  ('Un estudiante junta arroz y porotos en un mismo recipiente y luego los separa usando un colador, aprovechando que tienen tamaños distintos. ¿Qué característica de la mezcla permitió separarla de esta forma?', '["Que ambos materiales cambiaron de color","Que ambos materiales se disolvieron entre sí","Que ambos materiales desaparecieron","Que los materiales mantienen sus propiedades y tamaños distintos"]', 3, 'Al mantener sus propiedades y tamaños distintos, los materiales de una mezcla se pueden separar, por ejemplo con un colador.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_2_basico' and lo.short_name = 'Mezclas simples de materiales'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos materiales es atraído por un imán?', '["Un clavo de metal","Una hoja de papel","Un trozo de madera","Una goma de borrar"]', 0, 'Un clavo de metal, si es de un material como el hierro, es atraído por un imán.', 'inicial', 25),
  ('¿Qué ocurre al acercar dos imanes por sus polos opuestos?', '["Se repelen","Se atraen","No pasa nada","Cambian de color"]', 1, 'Al acercar dos imanes por sus polos opuestos, estos se atraen.', 'intermedia', 35),
  ('¿Cuál de estos materiales NO es atraído por un imán?', '["Un clavo","Una moneda de fierro","Un trozo de plástico","Un tornillo metálico"]', 2, 'El plástico no es atraído por un imán, a diferencia de los materiales metálicos como el fierro.', 'intermedia', 35),
  ('Un estudiante acerca un imán a una caja llena de objetos de distintos materiales (metal, plástico, madera y papel) para separarlos. ¿Qué objetos se pegarán al imán?', '["Los de madera","Los de plástico","Los de papel","Los de metal atraíble por imanes"]', 3, 'Solo los objetos de materiales atraíbles por imanes, como ciertos metales, se pegarán al imán.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_2_basico' and lo.short_name = 'Magnetismo básico'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas opciones es una fuente de energía que usamos en la vida cotidiana?', '["La electricidad","Un lápiz","Un libro","Una silla"]', 0, 'La electricidad es una forma de energía que usamos cotidianamente para muchos aparatos.', 'inicial', 25),
  ('¿Qué tipo de energía usa una lámpara para producir luz?', '["Energía sonora","Energía eléctrica","Energía del viento","Energía del agua"]', 1, 'Una lámpara usa energía eléctrica para producir luz.', 'intermedia', 35),
  ('¿Cuál de estas situaciones muestra energía en forma de movimiento?', '["Una vela encendida","Una radio apagada","Una bicicleta rodando","Un libro cerrado"]', 2, 'Una bicicleta rodando muestra energía en forma de movimiento.', 'intermedia', 35),
  ('Un estudiante enciende una radio que suena fuerte y, al mismo tiempo, se calienta un poco. ¿Qué formas de energía están presentes en este ejemplo?', '["Solo energía eléctrica","Solo energía sonora","Solo energía luminosa","Energía sonora y energía calórica, producidas a partir de la energía eléctrica"]', 3, 'La radio transforma la energía eléctrica en energía sonora y también libera algo de energía calórica.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_2_basico' and lo.short_name = 'Formas de energía en la vida cotidiana'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una fase de la Luna?', '["Luna llena","Luna caliente","Luna verde","Luna sólida"]', 0, 'Luna llena es una de las fases de la Luna, cuando se ve completamente iluminada.', 'inicial', 25),
  ('¿Qué ocurre con la forma en que vemos la Luna a lo largo de un mes?', '["Siempre se ve igual","Cambia su apariencia según la fase en que se encuentra","Desaparece para siempre","Cambia de tamaño real"]', 1, 'La apariencia de la Luna cambia a lo largo del mes según la fase en la que se encuentra, aunque su tamaño real no cambia.', 'intermedia', 35),
  ('¿Cuál de estas fases corresponde a cuando casi no se ve la Luna iluminada en el cielo?', '["Luna llena","Cuarto creciente","Luna nueva","Cuarto menguante"]', 2, 'En la fase de Luna nueva, la Luna casi no se ve iluminada desde la Tierra.', 'intermedia', 35),
  ('Un estudiante observa la Luna durante varias noches seguidas y nota que su forma iluminada va cambiando poco a poco. ¿Qué fenómeno está observando?', '["Un eclipse permanente","El ciclo de las estaciones","La rotación de la Tierra únicamente","Las fases de la Luna"]', 3, 'El cambio gradual en la forma iluminada de la Luna corresponde a sus fases.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_2_basico' and lo.short_name = 'Fases de la Luna'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas condiciones describe el clima de un lugar en un momento dado?', '["Si hace calor, frío, llueve o hay viento","El nombre de la ciudad","El color de las casas","La cantidad de autos en la calle"]', 0, 'El clima se describe según condiciones como la temperatura, la lluvia y el viento.', 'inicial', 25),
  ('¿Qué suele ocurrir con el clima de la localidad de un estudiante durante el invierno, en comparación con el verano?', '["Es igual todo el año","Suele ser más frío que en verano","Siempre hace más calor que en verano","No varía nunca"]', 1, 'En general, el clima durante el invierno suele ser más frío que durante el verano.', 'intermedia', 35),
  ('¿Cuál de estos es un instrumento simple para observar si hace viento?', '["Un termómetro","Un reloj","Una cinta o banderín que se mueve con el aire","Un lápiz"]', 2, 'Una cinta o banderín que se mueve permite observar de forma simple si hace viento.', 'intermedia', 35),
  ('Un estudiante registra durante un mes si cada día estuvo soleado, nublado o lluvioso. ¿Para qué le sirve este registro?', '["Para decorar su cuaderno","Para aprender a dibujar nubes","Para memorizar los días de la semana","Para observar cómo varía el clima de su localidad durante ese período"]', 3, 'Registrar el clima diario permite observar cómo varía a lo largo de un período de tiempo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_2_basico' and lo.short_name = 'El clima y su variación durante el año'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos es un tipo de suelo?', '["El suelo arenoso","El suelo de vidrio","El suelo de metal","El suelo de plástico"]', 0, 'El suelo arenoso es un tipo de suelo, compuesto principalmente por partículas de arena.', 'inicial', 25),
  ('¿Qué característica tiene un suelo arcilloso, en comparación con uno arenoso?', '["Deja pasar el agua muy rápido","Retiene más el agua","No retiene nada de agua","Es igual al suelo arenoso"]', 1, 'El suelo arcilloso retiene más el agua que el suelo arenoso, que deja pasar el agua con mayor rapidez.', 'intermedia', 35),
  ('¿Cuál de estas propiedades se puede observar al comparar distintos tipos de suelo?', '["Su precio en el mercado","Su nombre científico completo","Su color, textura y capacidad de retener agua","Su fecha de creación"]', 2, 'Al comparar tipos de suelo se pueden observar propiedades como su color, textura y capacidad de retener agua.', 'intermedia', 35),
  ('Un estudiante vierte la misma cantidad de agua sobre suelo arenoso y sobre suelo arcilloso, y observa que en el suelo arenoso el agua se filtra mucho más rápido. ¿Qué propiedad del suelo está comparando?', '["Su color","Su temperatura","Su peso","Su capacidad de retener agua"]', 3, 'El experimento compara la capacidad de retener agua de distintos tipos de suelo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_2_basico' and lo.short_name = 'Tipos de suelo'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 2° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Antes de soltar una pelota y una pluma desde la misma altura, un estudiante dice: ''Creo que la pelota llegará primero al suelo''. ¿Qué está haciendo?', '["Una predicción","Una conclusión final","Una medición exacta","Una clasificación"]', 0, 'Decir lo que se cree que ocurrirá antes de observar es hacer una predicción.', 'inicial', 25),
  ('¿Por qué es útil predecir antes de realizar una observación o experimento?', '["Porque siempre se debe acertar","Porque ayuda a pensar sobre lo que podría ocurrir y luego comparar con lo observado","Porque reemplaza la necesidad de observar","Porque hace que el experimento sea más lento"]', 1, 'Predecir ayuda a pensar sobre lo que podría ocurrir y luego comparar esa idea con lo que realmente se observa.', 'intermedia', 35),
  ('Antes de poner una planta bajo una caja oscura durante varios días, un estudiante predice qué le pasará. ¿Cuál sería una predicción razonable?', '["La planta se pondrá más verde","La planta crecerá más rápido","La planta se debilitará por falta de luz","No le pasará nada a la planta"]', 2, 'Una predicción razonable es que la planta se debilitará, ya que necesita luz para sus procesos vitales.', 'intermedia', 35),
  ('Un estudiante predijo que un cubo de hielo se derretiría más rápido al sol que a la sombra. Al realizar la observación, comprobó que efectivamente fue así. ¿Qué relación existe entre su predicción y lo observado?', '["No tienen ninguna relación","La predicción fue incorrecta","La observación reemplazó a la predicción","La predicción se confirmó con lo observado"]', 3, 'Cuando lo observado coincide con lo que se predijo, se dice que la predicción se confirmó.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_2_basico' and lo.short_name = 'Predicción simple antes de observar'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos instrumentos se usa para medir la longitud de un objeto?', '["Una regla","Un termómetro","Una balanza","Un reloj de arena"]', 0, 'Una regla es un instrumento simple que se usa para medir la longitud de un objeto.', 'inicial', 25),
  ('¿Para qué se utiliza una lupa en una actividad de exploración?', '["Para pesar objetos","Para observar detalles pequeños con más claridad","Para medir el tiempo","Para medir la temperatura"]', 1, 'Una lupa se utiliza para observar detalles pequeños de un objeto con mayor claridad.', 'intermedia', 35),
  ('¿Cuál de estos instrumentos se usaría para medir cuánto pesa un objeto?', '["Una regla","Una lupa","Una balanza","Un termómetro"]', 2, 'Una balanza es el instrumento adecuado para medir cuánto pesa un objeto.', 'intermedia', 35),
  ('Un estudiante quiere comparar el largo de dos lápices y decidir cuál es más largo. ¿Qué instrumento simple debería usar?', '["Una balanza","Un termómetro","Una lupa","Una regla"]', 3, 'Una regla permite medir y comparar el largo de distintos objetos, como dos lápices.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_2_basico' and lo.short_name = 'Uso de instrumentos simples de medición'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 2° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Después de realizar una actividad exploratoria, ¿qué acción corresponde a comunicar los resultados?', '["Contar o mostrar a otros lo que se observó y concluyó","Guardar todo en secreto","Olvidar lo realizado","Repetir la actividad sin decir nada a nadie"]', 0, 'Comunicar los resultados implica contar o mostrar a otras personas lo que se observó y concluyó.', 'inicial', 25),
  ('¿Cuál de estas formas es adecuada para comunicar el resultado de una actividad exploratoria en 2° Básico?', '["Escribir una fórmula matemática compleja","Contar oralmente o mostrar un dibujo con lo observado","No decir nada a nadie","Usar solo números sin ninguna explicación"]', 1, 'En este nivel, contar oralmente o mostrar un dibujo con lo observado es una forma adecuada de comunicar resultados.', 'intermedia', 35),
  ('Un grupo de estudiantes realizó una actividad sobre el crecimiento de una planta y debe presentar lo que descubrió al curso. ¿Qué deberían incluir en su presentación?', '["Solo su opinión sobre el clima","Un cuento inventado sin relación con la planta","Lo que observaron y lo que concluyeron sobre la planta","Ninguna información sobre la actividad"]', 2, 'La presentación debería incluir lo observado y las conclusiones sobre la actividad realizada.', 'intermedia', 35),
  ('Después de comparar cómo flotan distintos objetos en el agua, un estudiante prepara un afiche con dibujos y una breve explicación para mostrar al curso. ¿Qué habilidad científica está practicando?', '["Formulación de hipótesis avanzadas","Diseño experimental complejo","Medición con instrumentos de precisión","Comunicación de resultados de una actividad exploratoria"]', 3, 'Preparar un afiche con dibujos y una explicación para mostrar los resultados es un ejemplo de comunicación de resultados.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_2_basico' and lo.short_name = 'Comunicación de resultados de una actividad exploratoria'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
