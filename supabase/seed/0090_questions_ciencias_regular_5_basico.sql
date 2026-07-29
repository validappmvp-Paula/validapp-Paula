-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 5° Básico. Cubre los 14 objetivos de aprendizaje de 5° Básico
-- cargados por supabase/seed/0017_curriculum_ciencias_regular_basica_1_6.sql,
-- con 4 preguntas por objetivo, total 56 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí).

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la función principal del sistema digestivo?', '["Transformar los alimentos para que el cuerpo pueda usar sus nutrientes","Bombear la sangre por el cuerpo","Producir sonidos para hablar","Filtrar el aire que respiramos"]', 0, 'El sistema digestivo transforma los alimentos para que el cuerpo pueda absorber y usar sus nutrientes.', 'inicial', 25),
  ('¿Qué órgano del sistema digestivo comienza a descomponer los alimentos mediante la masticación?', '["El estómago","La boca","El intestino grueso","El hígado"]', 1, 'La boca inicia la digestión mediante la masticación y la mezcla con la saliva.', 'intermedia', 35),
  ('¿Qué relación existe entre el sistema digestivo y la nutrición?', '["No tienen relación entre sí","El sistema digestivo transforma los alimentos para obtener los nutrientes que el cuerpo necesita","La nutrición ocurre sin necesidad del sistema digestivo","El sistema digestivo solo elimina desechos, sin relación con los nutrientes"]', 2, 'El sistema digestivo transforma los alimentos, permitiendo que el cuerpo obtenga los nutrientes necesarios para la nutrición.', 'intermedia', 35),
  ('Un estudiante explica que, después de comer, los alimentos pasan por la boca, el esófago, el estómago y los intestinos, donde se obtienen los nutrientes que luego pasan a la sangre. ¿Qué proceso completo está describiendo?', '["El proceso de respiración","El proceso circulatorio exclusivamente","El proceso del sistema nervioso","El proceso de digestión y absorción de nutrientes"]', 3, 'La descripción corresponde al proceso de digestión y absorción de nutrientes, que involucra a varios órganos del sistema digestivo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_5_basico' and lo.short_name = 'Sistema digestivo y su relación con la nutrición'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué son los microorganismos?', '["Seres vivos tan pequeños que no se ven a simple vista","Objetos no vivos de gran tamaño","Solo un tipo de planta grande","Rocas muy pequeñas"]', 0, 'Los microorganismos son seres vivos tan pequeños que no se pueden ver a simple vista.', 'inicial', 25),
  ('¿Cuál de estas opciones muestra un efecto beneficioso de un microorganismo para la salud humana?', '["Una bacteria que ayuda a la digestión en el intestino","Un virus que causa una enfermedad respiratoria","Una bacteria que descompone un alimento hasta echarlo a perder","Un hongo que causa una infección en la piel"]', 1, 'Algunas bacterias que viven en el intestino ayudan a la digestión, mostrando un efecto beneficioso para la salud.', 'intermedia', 35),
  ('¿Cuál de estas acciones ayuda a prevenir enfermedades causadas por microorganismos dañinos?', '["Lavarse las manos frecuentemente","Comer alimentos en mal estado","Evitar lavarse las manos","No cocinar bien los alimentos"]', 2, 'Lavarse las manos frecuentemente ayuda a prevenir el contagio de microorganismos que pueden causar enfermedades.', 'intermedia', 35),
  ('Un estudiante investiga que algunos microorganismos, como ciertas bacterias, se usan para elaborar yogur, mientras que otros, como algunos virus, pueden causar resfríos. ¿Qué conclusión es correcta sobre el efecto de los microorganismos en la salud?', '["Todos los microorganismos son dañinos para la salud","Todos los microorganismos son beneficiosos para la salud","Los microorganismos pueden tener efectos beneficiosos o perjudiciales según el tipo","Los microorganismos no tienen ningún efecto en la salud"]', 3, 'Los microorganismos pueden tener efectos beneficiosos (como en la elaboración de yogur) o perjudiciales (como causar resfríos), según el tipo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_5_basico' and lo.short_name = 'Microorganismos y su efecto en la salud'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la fotosíntesis?', '["El proceso mediante el cual las plantas producen su propio alimento usando luz solar","El proceso mediante el cual los animales digieren alimentos","Un tipo de enfermedad de las plantas","El proceso de respiración de los animales"]', 0, 'La fotosíntesis es el proceso mediante el cual las plantas producen su propio alimento usando luz solar, agua y dióxido de carbono.', 'inicial', 25),
  ('¿Qué gas liberan las plantas como resultado de la fotosíntesis, que es esencial para la respiración de otros seres vivos?', '["Dióxido de carbono","Oxígeno","Nitrógeno puro","Vapor de agua exclusivamente"]', 1, 'Las plantas liberan oxígeno como resultado de la fotosíntesis, gas esencial para la respiración de muchos seres vivos.', 'intermedia', 35),
  ('¿Por qué la fotosíntesis es un proceso vital para las plantas?', '["Porque les permite moverse más rápido","Porque les permite producir su propio alimento para vivir y crecer","Porque hace que cambien de color constantemente","Porque evita que las plantas necesiten agua"]', 2, 'La fotosíntesis es vital porque permite a las plantas producir su propio alimento para vivir y crecer.', 'intermedia', 35),
  ('Un estudiante coloca una planta en un lugar completamente oscuro durante varias semanas y observa que se debilita y sus hojas amarillean. ¿Qué relación tiene esto con la fotosíntesis?', '["No existe ninguna relación entre la luz y la fotosíntesis","Sin luz solar, la planta no puede realizar la fotosíntesis y producir su alimento","La fotosíntesis solo depende del agua, no de la luz","La planta realiza fotosíntesis igual, sin luz"]', 3, 'Sin luz solar, la planta no puede realizar la fotosíntesis para producir su propio alimento, lo que explica su debilitamiento.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_5_basico' and lo.short_name = 'La fotosíntesis como proceso vital de las plantas'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué significa que Chile tenga una alta biodiversidad en algunas zonas?', '["Que existe una gran variedad de especies de seres vivos","Que solo hay un tipo de animal en el país","Que no existen plantas nativas","Que todos los ecosistemas son iguales"]', 0, 'La biodiversidad se refiere a la gran variedad de especies de seres vivos que existen en un lugar.', 'inicial', 25),
  ('¿Cuál de estos ejemplos representa biodiversidad en una zona de Chile?', '["Un huerto con un único tipo de planta","Un bosque con muchas especies distintas de árboles, aves e insectos","Una habitación con muebles de un solo color","Una calle con un único tipo de auto"]', 1, 'Un bosque con muchas especies distintas de árboles, aves e insectos es un ejemplo de biodiversidad.', 'intermedia', 35),
  ('¿Por qué es importante conservar la biodiversidad de Chile?', '["Porque no tiene ninguna importancia","Porque mantiene el equilibrio de los ecosistemas y muchas especies dependen entre sí","Porque así hay menos especies para cuidar","Porque reduce la cantidad de ecosistemas"]', 2, 'Conservar la biodiversidad es importante porque mantiene el equilibrio de los ecosistemas, donde muchas especies dependen entre sí.', 'intermedia', 35),
  ('Un estudiante investiga sobre el desierto de Atacama, la selva valdiviana y la estepa patagónica, y descubre que cada una tiene especies de plantas y animales muy distintas entre sí. ¿Qué muestra esta comparación sobre la biodiversidad de Chile?', '["Que Chile tiene poca variedad de ecosistemas y especies","Que todos los ecosistemas de Chile son iguales","Que Chile presenta una gran diversidad de ecosistemas y especies a lo largo de su territorio","Que la biodiversidad no varía según la zona geográfica"]', 3, 'La comparación muestra que Chile presenta una gran diversidad de ecosistemas y especies a lo largo de su territorio, desde el desierto hasta la Patagonia.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_5_basico' and lo.short_name = 'Biodiversidad de Chile'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué cambio de estado ocurre cuando el hielo se convierte en agua líquida al aumentar la temperatura?', '["Fusión","Evaporación","Condensación","Solidificación"]', 0, 'La fusión es el cambio de estado sólido a líquido, como cuando el hielo se derrite.', 'inicial', 25),
  ('¿Qué cambio de estado ocurre cuando el agua líquida se transforma en vapor al calentarse?', '["Solidificación","Evaporación","Fusión","Condensación"]', 1, 'La evaporación es el cambio de estado líquido a gaseoso, como cuando el agua hierve y se convierte en vapor.', 'intermedia', 35),
  ('¿Qué cambio de estado ocurre cuando el vapor de agua se enfría y se transforma en pequeñas gotas de agua?', '["Fusión","Evaporación","Condensación","Sublimación"]', 2, 'La condensación es el cambio de estado gaseoso a líquido, como cuando el vapor de agua forma gotas al enfriarse.', 'intermedia', 35),
  ('Un estudiante saca un cubo de hielo del congelador y lo deja sobre la mesa. Después de un rato, el hielo se convierte en agua, y luego, al calentarla en una olla, el agua se convierte en vapor. ¿Qué cambios de estado ocurrieron, en ese orden?', '["Evaporación y luego fusión","Condensación y luego solidificación","Fusión y luego evaporación","Sublimación y luego condensación"]', 3, 'Primero ocurrió la fusión (hielo a agua líquida) y luego la evaporación (agua líquida a vapor).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_5_basico' and lo.short_name = 'Cambios de estado de la materia'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué diferencia principal existe entre una mezcla y una solución?', '["En una solución, uno de los componentes se disuelve completamente en el otro; en una mezcla común, no necesariamente","Ambas son exactamente lo mismo","Una solución nunca contiene líquidos","Una mezcla nunca contiene sólidos"]', 0, 'En una solución, un componente (soluto) se disuelve completamente en otro (solvente); en una mezcla común esto no necesariamente ocurre.', 'inicial', 25),
  ('¿Cuál de estos ejemplos corresponde a una solución?', '["Agua con sal completamente disuelta","Agua con arena","Piedras y hojas juntas","Clips y monedas en una caja"]', 1, 'Agua con sal completamente disuelta es un ejemplo de solución, ya que la sal se disuelve por completo en el agua.', 'intermedia', 35),
  ('¿Cuál de estos ejemplos corresponde a una mezcla que NO es una solución?', '["Agua con azúcar disuelta","Agua con aceite (que no se disuelve)","Agua con sal disuelta","Jugo de fruta colado sin partículas"]', 2, 'Agua con aceite es una mezcla en la que el aceite no se disuelve en el agua, por lo que no forma una solución homogénea.', 'intermedia', 35),
  ('Un estudiante mezcla agua con azúcar y revuelve hasta que el azúcar ya no se ve como partículas separadas. Luego mezcla agua con arena y revuelve, pero la arena sigue siendo visible en el fondo. ¿Qué diferencia explica por qué la primera es una solución y la segunda no?', '["El azúcar se disolvió completamente en el agua, formando una mezcla homogénea; la arena no se disuelve","Ambas mezclas son soluciones iguales","La arena se disolvió mejor que el azúcar","No existe ninguna diferencia entre ambos casos"]', 3, 'El azúcar se disuelve completamente en el agua formando una solución homogénea, mientras que la arena no se disuelve y permanece visible.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_5_basico' and lo.short_name = 'Mezclas y soluciones'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una máquina simple?', '["La palanca","El televisor","El computador","El teléfono celular"]', 0, 'La palanca es una máquina simple que facilita el trabajo al mover o levantar objetos.', 'inicial', 25),
  ('¿Para qué se utiliza una polea?', '["Para facilitar levantar objetos cambiando la dirección de la fuerza","Para calentar alimentos","Para producir electricidad exclusivamente","Para medir el tiempo"]', 1, 'Una polea facilita levantar objetos, permitiendo cambiar la dirección de la fuerza aplicada.', 'intermedia', 35),
  ('¿Cuál de estas situaciones muestra el uso de un plano inclinado?', '["Subir una carga por una rampa en vez de levantarla directamente","Cortar papel con una tijera","Encender una ampolleta con un interruptor","Medir la temperatura con un termómetro"]', 2, 'Subir una carga por una rampa (plano inclinado) facilita el trabajo, en comparación con levantarla directamente.', 'intermedia', 35),
  ('Un estudiante observa que es más fácil mover una roca pesada usando una barra larga apoyada en un punto fijo (una palanca), en vez de empujarla directamente con las manos. ¿Qué función cumple la máquina simple en este caso?', '["Aumenta el peso de la roca","Elimina por completo la necesidad de aplicar fuerza","Facilita el trabajo, permitiendo mover la roca con menos esfuerzo","Hace que la roca desaparezca"]', 3, 'La palanca facilita el trabajo, permitiendo mover la roca con menos esfuerzo del que se necesitaría empujándola directamente.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_5_basico' and lo.short_name = 'Máquinas simples y su función'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos métodos se usa para separar arena de piedras grandes según su tamaño?', '["El tamizado","La evaporación","La disolución","La combustión"]', 0, 'El tamizado permite separar materiales según su tamaño, como la arena de piedras más grandes.', 'inicial', 25),
  ('¿Qué método permite recuperar la sal disuelta en agua, dejando que el agua se transforme en vapor?', '["El tamizado","La evaporación","La filtración con papel","El uso de un imán"]', 1, 'La evaporación permite recuperar la sal, ya que el agua se transforma en vapor y la sal queda en el recipiente.', 'intermedia', 35),
  ('¿Qué método de separación es más adecuado para separar un líquido de partículas sólidas que no se disuelven, usando un papel filtro?', '["El tamizado","La evaporación","La filtración","El uso de un imán"]', 2, 'La filtración permite separar un líquido de partículas sólidas no disueltas, haciendo pasar la mezcla por un papel filtro.', 'intermedia', 35),
  ('Un estudiante tiene una mezcla de agua, arena y limaduras de hierro, y debe separar los tres componentes. ¿Cuál sería un procedimiento adecuado?', '["Usar solo la evaporación para separar los tres componentes a la vez","Usar solo un tamiz sin ningún otro método","No es posible separar esta mezcla","Usar un imán para el hierro, luego filtrar la arena y finalmente evaporar el agua"]', 3, 'Un procedimiento adecuado sería usar un imán para retirar el hierro, filtrar para separar la arena, y evaporar el agua restante.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_5_basico' and lo.short_name = 'Métodos de separación de mezclas'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una de las capas de la atmósfera?', '["La troposfera","La litosfera","El núcleo","El manto"]', 0, 'La troposfera es una de las capas de la atmósfera, la más cercana a la superficie terrestre.', 'inicial', 25),
  ('¿Por qué es importante la atmósfera para la vida en la Tierra?', '["Porque contiene el aire que respiramos y regula la temperatura","Porque produce terremotos","Porque contiene solo agua líquida","Porque impide totalmente el paso de la luz solar"]', 1, 'La atmósfera contiene el aire que respiramos, regula la temperatura y protege de ciertas radiaciones.', 'intermedia', 35),
  ('¿Cuál de estas capas de la atmósfera se encuentra más alejada de la superficie terrestre?', '["La troposfera","La estratosfera","La exosfera","La corteza terrestre"]', 2, 'La exosfera es la capa más externa y alejada de la superficie terrestre, entre las opciones dadas.', 'intermedia', 35),
  ('Un estudiante investiga que la capa de ozono, que protege a los seres vivos de cierta radiación solar dañina, se encuentra en una de las capas de la atmósfera. ¿Qué importancia tiene esta información para comprender la atmósfera?', '["Muestra que la atmósfera no tiene ninguna función protectora","Muestra que las distintas capas de la atmósfera cumplen funciones importantes para la vida en la Tierra","Muestra que la atmósfera es igual en todas sus capas","Muestra que la atmósfera no tiene relación con la vida en la Tierra"]', 3, 'Esta información muestra que las distintas capas de la atmósfera, como la que contiene la capa de ozono, cumplen funciones importantes para proteger la vida en la Tierra.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_5_basico' and lo.short_name = 'Capas de la atmósfera'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué movimiento de la Tierra explica la existencia del día y la noche?', '["La rotación","La traslación","El movimiento de la Luna","La explosión de una estrella"]', 0, 'La rotación, el giro de la Tierra sobre su propio eje, explica la existencia del día y la noche.', 'inicial', 25),
  ('¿Qué movimiento de la Tierra explica la existencia de las estaciones del año?', '["La rotación","La traslación alrededor del Sol","El movimiento de las mareas","La formación de nubes"]', 1, 'La traslación, el movimiento de la Tierra alrededor del Sol, junto con la inclinación de su eje, explica las estaciones del año.', 'intermedia', 35),
  ('¿Cuánto tiempo demora aproximadamente la Tierra en completar una vuelta alrededor del Sol (traslación)?', '["Un día","Una semana","Un año","Una hora"]', 2, 'La Tierra demora aproximadamente un año en completar una vuelta alrededor del Sol.', 'intermedia', 35),
  ('Un estudiante explica que, mientras la Tierra gira sobre sí misma cada 24 horas, también se mueve alrededor del Sol en un recorrido que demora aproximadamente 365 días. ¿A qué dos movimientos se está refiriendo, en ese orden?', '["Traslación y rotación","Revolución lunar y rotación solar","Rotación y traslación","Órbita lunar y órbita solar"]', 3, 'Se refiere a la rotación (giro sobre su propio eje, 24 horas) y a la traslación (vuelta alrededor del Sol, aproximadamente 365 días).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_5_basico' and lo.short_name = 'Movimientos de rotación y traslación de la Tierra'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas propiedades tiene el aire, aunque no lo podamos ver?', '["Ocupa espacio y tiene peso","No existe realmente","Solo existe en el mar","Es un líquido"]', 0, 'Aunque no se ve, el aire ocupa espacio y tiene peso, propiedades que se pueden comprobar experimentalmente.', 'inicial', 25),
  ('¿Qué evidencia demuestra que el aire ocupa espacio?', '["Que al inflar un globo, este aumenta de tamaño con aire adentro","Que el aire nunca se mueve","Que el aire tiene color visible","Que el aire pesa lo mismo que el agua"]', 1, 'Al inflar un globo con aire, este aumenta de tamaño, demostrando que el aire ocupa espacio.', 'intermedia', 35),
  ('¿Cuál de estas situaciones demuestra que el aire en movimiento (viento) puede ejercer fuerza sobre los objetos?', '["Una cometa que se eleva y se mueve con el viento","Una piedra que no se mueve en el suelo","Un vaso de agua quieto sobre la mesa","Una pared de ladrillo"]', 2, 'Una cometa que se eleva y se mueve con el viento demuestra que el aire en movimiento ejerce fuerza sobre los objetos.', 'intermedia', 35),
  ('Un estudiante sumerge un vaso boca abajo en una tina con agua y observa que el agua no logra llenar completamente el vaso, porque queda algo de aire atrapado adentro. ¿Qué propiedad del aire demuestra este experimento?', '["Que el aire no existe dentro del vaso","Que el aire ocupa espacio, impidiendo que el agua llene completamente el vaso","Que el agua se transforma en aire","Que el vaso está roto"]', 3, 'Este experimento demuestra que el aire ocupa espacio, ya que impide que el agua llene completamente el vaso.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_5_basico' and lo.short_name = 'El aire y sus propiedades'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 5° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un estudiante quiere diseñar un procedimiento para saber si la cantidad de sal afecta la temperatura a la que el agua hierve. ¿Qué debería mantener constante en su diseño?', '["La cantidad de agua utilizada en cada prueba","El día de la semana en que hace la prueba","El color del recipiente","El nombre del experimento"]', 0, 'Para un diseño experimental adecuado, se debe mantener constante la cantidad de agua, variando solo la cantidad de sal.', 'inicial', 25),
  ('¿Qué elementos debería incluir el diseño de un procedimiento experimental con variables controladas?', '["Solo una lista de materiales, sin ningún control de variables","Materiales, pasos a seguir y control de las variables que no se están estudiando","Solo una predicción, sin materiales ni pasos","Solo un dibujo del resultado esperado"]', 1, 'Un buen diseño experimental incluye los materiales, los pasos a seguir y el control de las variables que no se están estudiando.', 'intermedia', 35),
  ('Un grupo diseña un experimento para comparar si las plantas crecen más con agua o con jugo de fruta, usando la misma cantidad de luz, tierra y líquido para cada planta, cambiando solo el tipo de líquido. ¿Por qué este diseño permite controlar variables de forma adecuada?', '["Porque usa el mismo tipo de líquido en todas las plantas","Porque mantiene todas las condiciones iguales excepto la variable en estudio (el tipo de líquido)","Porque no es necesario controlar ninguna variable","Porque cambia varias condiciones a la vez"]', 2, 'El diseño es adecuado porque mantiene todas las condiciones iguales, variando únicamente el tipo de líquido, que es la variable en estudio.', 'intermedia', 35),
  ('Un estudiante diseña un experimento para saber si la temperatura afecta la rapidez con la que se disuelve una pastilla efervescente, usando la misma cantidad de agua y la misma cantidad de pastilla en cada prueba, variando solo la temperatura del agua (fría, tibia, caliente). ¿Qué principio del diseño experimental está aplicando correctamente?', '["El de cambiar todas las variables a la vez para obtener más información","El de usar materiales distintos en cada prueba","El de mantener constantes todas las variables excepto la que se quiere estudiar","El de no registrar ningún dato durante el experimento"]', 3, 'El estudiante aplica correctamente el principio de mantener constantes todas las variables (cantidad de agua y de pastilla) excepto la que se quiere estudiar (la temperatura).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_5_basico' and lo.short_name = 'Diseño de un procedimiento experimental con variables controladas'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Un gráfico de barras muestra la altura de cuatro plantas distintas después de un mes. ¿Qué información se puede obtener al interpretar este gráfico?', '["Cuál planta creció más y cuál creció menos","El color de las flores de cada planta","El sabor de las hojas de cada planta","El nombre científico de cada planta"]', 0, 'Un gráfico de barras de altura permite comparar y determinar cuál planta creció más y cuál creció menos.', 'inicial', 25),
  ('Una tabla muestra la temperatura del agua medida cada 5 minutos mientras se calienta. ¿Qué permite observar esta tabla al interpretarla?', '["Cómo cambia la temperatura del agua con el paso del tiempo","El color exacto del agua","El precio del agua","El sabor del agua"]', 1, 'La tabla permite observar cómo cambia la temperatura del agua con el paso del tiempo mientras se calienta.', 'intermedia', 35),
  ('Un gráfico de barras muestra que la Planta A midió 20 cm y la Planta B midió 12 cm después de un mes, ambas regadas con la misma cantidad de agua pero distinta cantidad de luz. ¿Qué conclusión permite este gráfico, considerando además que se sabe cuál recibió más luz?', '["Que ambas plantas crecieron igual","Que el gráfico no aporta ninguna información","Que la planta con más luz probablemente creció más","Que la cantidad de luz no influyó en el crecimiento"]', 2, 'El gráfico permite concluir que la planta que recibió más luz probablemente creció más, si esa fue la variable comparada.', 'intermedia', 35),
  ('Una tabla registra el tiempo que demoran en derretirse cubos de hielo del mismo tamaño a distintas temperaturas ambientales: a 10°C demora 40 minutos, a 20°C demora 25 minutos y a 30°C demora 12 minutos. ¿Qué relación se puede interpretar a partir de estos datos?', '["El hielo demora lo mismo en derretirse sin importar la temperatura","No existe ninguna relación entre la temperatura y el tiempo de derretimiento","A menor temperatura ambiental, el hielo demora menos en derretirse","A mayor temperatura ambiental, el hielo demora menos en derretirse"]', 3, 'Los datos muestran que a mayor temperatura ambiental, el hielo demora menos tiempo en derretirse.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_5_basico' and lo.short_name = 'Interpretación de tablas y gráficos de resultados'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 5° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Después de comprobar que una planta regada diariamente creció más que una regada una vez por semana, ¿cuál sería una conclusión simple adecuada?', '["El riego más frecuente se relacionó con un mayor crecimiento de la planta en este experimento","El riego no tiene ninguna relación con el crecimiento","Las plantas crecen igual sin importar el riego","No se puede concluir nada de este experimento"]', 0, 'Una conclusión simple adecuada es que el riego más frecuente se relacionó con un mayor crecimiento en este experimento particular.', 'inicial', 25),
  ('¿Qué característica debe tener una buena conclusión científica?', '["Basarse en los datos y observaciones obtenidos en la investigación","Basarse solo en lo que uno cree sin evidencia","Ser igual siempre a la predicción inicial, sin importar los datos","No relacionarse con la pregunta de investigación"]', 1, 'Una buena conclusión debe basarse en los datos y observaciones reales obtenidos durante la investigación.', 'intermedia', 35),
  ('Un grupo de estudiantes investigó si el tipo de suelo afecta la germinación de semillas y encontró que, en su experimento, las semillas germinaron mejor en suelo arcilloso que en suelo arenoso. ¿Cuál es una conclusión adecuada para este resultado?', '["Todas las semillas del mundo germinan solo en suelo arcilloso","En este experimento, el suelo arcilloso se relacionó con una mejor germinación de las semillas utilizadas","El tipo de suelo nunca afecta la germinación","Los resultados no tienen relación con el tipo de suelo"]', 2, 'La conclusión debe reflejar específicamente lo observado en ese experimento, sin generalizar de forma absoluta a todas las semillas del mundo.', 'intermedia', 35),
  ('Un estudiante concluye, a partir de un solo experimento con dos plantas, que ''el agua de mar siempre hace crecer mejor a todas las plantas del mundo''. ¿Qué problema tiene esta conclusión?', '["Ninguno, es una conclusión perfectamente válida","Generaliza demasiado a partir de muy pocos datos (solo dos plantas)","Es una conclusión demasiado cautelosa","No tiene relación con el experimento realizado"]', 3, 'La conclusión generaliza demasiado a partir de muy pocos datos (solo dos plantas), lo cual no es una base suficiente para una afirmación tan amplia.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_5_basico' and lo.short_name = 'Formulación de conclusiones simples'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
