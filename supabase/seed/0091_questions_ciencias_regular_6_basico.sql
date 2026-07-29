-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 6° Básico. Cubre los 14 objetivos de aprendizaje de 6° Básico
-- cargados por supabase/seed/0017_curriculum_ciencias_regular_basica_1_6.sql,
-- con 4 preguntas por objetivo, total 56 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí).

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál es la función principal del sistema respiratorio?', '["Permitir el intercambio de oxígeno y dióxido de carbono","Bombear la sangre por el cuerpo","Digerir los alimentos","Producir movimiento en las piernas"]', 0, 'El sistema respiratorio permite el intercambio de oxígeno y dióxido de carbono con el ambiente.', 'inicial', 25),
  ('¿Cuál es la función principal del sistema circulatorio?', '["Transportar oxígeno y nutrientes por el cuerpo mediante la sangre","Producir sonidos para hablar","Filtrar el aire antes de llegar a los pulmones","Sostener el cuerpo con huesos"]', 1, 'El sistema circulatorio transporta oxígeno y nutrientes por el cuerpo a través de la sangre.', 'intermedia', 35),
  ('¿Qué relación existe entre el sistema respiratorio y el sistema circulatorio?', '["No tienen ninguna relación entre sí","El sistema respiratorio capta oxígeno, que el sistema circulatorio transporta por el cuerpo","El sistema circulatorio capta el oxígeno directamente del aire","El sistema respiratorio reemplaza al sistema circulatorio"]', 2, 'El sistema respiratorio capta el oxígeno del aire, y el sistema circulatorio lo transporta a través de la sangre por todo el cuerpo.', 'intermedia', 35),
  ('Un estudiante explica que, al inhalar aire, los pulmones captan oxígeno, el cual pasa a la sangre y es transportado por el corazón hacia todas las células del cuerpo. ¿Qué dos sistemas están trabajando juntos en este proceso?', '["El sistema digestivo y el sistema nervioso","El sistema esquelético y el sistema muscular","El sistema respiratorio y el sistema circulatorio","El sistema nervioso y el sistema circulatorio"]', 3, 'El proceso descrito involucra al sistema respiratorio (captación de oxígeno) y al sistema circulatorio (transporte del oxígeno por la sangre).', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_6_basico' and lo.short_name = 'Sistemas respiratorio y circulatorio'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la pubertad?', '["Una etapa de cambios físicos y emocionales en el desarrollo de las personas","Una enfermedad que afecta solo a los adultos","Un tipo de examen médico","Una actividad deportiva"]', 0, 'La pubertad es una etapa de cambios físicos y emocionales que ocurre en el desarrollo de las personas.', 'inicial', 25),
  ('¿Cuál de estos es un cambio físico común durante la pubertad?', '["El crecimiento acelerado de estatura","La pérdida total de los dientes","La aparición de canas en el cabello","La disminución del tamaño del cuerpo"]', 1, 'El crecimiento acelerado de estatura es un cambio físico común durante la pubertad.', 'intermedia', 35),
  ('¿Cuál de estos es un cambio emocional que puede ocurrir durante la pubertad?', '["Cambios en el estado de ánimo con mayor frecuencia","La incapacidad total de sentir emociones","La ausencia completa de cambios emocionales","La pérdida de la memoria"]', 2, 'Durante la pubertad son comunes los cambios en el estado de ánimo, debido a distintos factores del desarrollo.', 'intermedia', 35),
  ('Un estudiante nota que, junto con el crecimiento acelerado de su cuerpo, también experimenta cambios en su estado de ánimo y en su forma de relacionarse con otras personas. ¿Cómo se puede interpretar esta situación considerando lo que ocurre en la pubertad?', '["Son cambios anormales que no tienen relación con la pubertad","Son cambios físicos y emocionales típicos del proceso de pubertad","Son señales de una enfermedad grave","No tienen relación con el desarrollo del cuerpo"]', 3, 'Estos cambios físicos y emocionales son típicos del proceso de pubertad, una etapa normal del desarrollo humano.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_6_basico' and lo.short_name = 'Cambios de la pubertad'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué diferencia principal existe entre una cadena trófica y una red trófica?', '["Una red trófica muestra varias cadenas alimentarias conectadas entre sí, no solo una","Son exactamente lo mismo","Una cadena trófica muestra más relaciones que una red trófica","Una red trófica solo incluye plantas"]', 0, 'Una red trófica muestra varias cadenas alimentarias conectadas entre sí, representando relaciones más complejas que una sola cadena.', 'inicial', 25),
  ('En una red trófica, ¿qué ocurre si un mismo animal se alimenta de varias especies distintas?', '["Eso no puede representarse en una red trófica","Ese animal se conecta con varias cadenas alimentarias, formando parte de una red","Ese animal deja de ser parte del ecosistema","Ese animal se convierte automáticamente en productor"]', 1, 'Cuando un animal se alimenta de varias especies, se conecta con varias cadenas alimentarias, formando parte de una red trófica más compleja.', 'intermedia', 35),
  ('¿Qué representa el flujo de materia y energía en una red trófica?', '["El paso de nutrientes y energía de un ser vivo a otro a través de la alimentación","El movimiento de las nubes en el cielo","El ciclo del agua exclusivamente","El crecimiento de las rocas"]', 2, 'El flujo de materia y energía en una red trófica representa el paso de nutrientes y energía de un ser vivo a otro mediante la alimentación.', 'intermedia', 35),
  ('En un ecosistema, el zorro se alimenta de conejos y de aves; a su vez, los conejos y las aves se alimentan de plantas distintas. Si desaparecieran todos los conejos de este ecosistema, ¿qué es lo más probable que ocurra en la red trófica?', '["No pasaría nada, porque el zorro no se ve afectado","El zorro dependería más de otras fuentes de alimento, como las aves","Las plantas que comían los conejos desaparecerían de inmediato","El ecosistema completo desaparecería sin ningún cambio previo"]', 3, 'Al desaparecer los conejos, el zorro dependería más de otras fuentes de alimento disponibles en la red trófica, como las aves.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_6_basico' and lo.short_name = 'Cadenas y redes tróficas en un ecosistema'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una actividad humana que puede afectar el equilibrio de un ecosistema local?', '["La tala excesiva de árboles de un bosque","Observar aves con binoculares desde lejos","Caminar por un sendero señalizado","Leer un libro sobre la naturaleza"]', 0, 'La tala excesiva de árboles puede afectar gravemente el equilibrio de un ecosistema local.', 'inicial', 25),
  ('¿Qué efecto puede tener la contaminación de un río sobre los seres vivos que dependen de él?', '["Ningún efecto en absoluto","Puede afectar negativamente la salud y supervivencia de esos seres vivos","Siempre mejora la calidad del agua","Aumenta automáticamente la biodiversidad"]', 1, 'La contaminación de un río puede afectar negativamente la salud y la supervivencia de los seres vivos que dependen de él.', 'intermedia', 35),
  ('¿Cuál de estas acciones humanas podría ayudar a reducir el impacto negativo sobre un ecosistema?', '["Aumentar la tala de árboles sin ningún control","Reforestar zonas taladas anteriormente","Verter desechos directamente en los ríos","Extraer más agua de la que el ecosistema puede reponer"]', 2, 'Reforestar zonas taladas anteriormente es una acción que ayuda a reducir el impacto negativo sobre un ecosistema.', 'intermedia', 35),
  ('Un estudiante investiga que, tras la construcción de una fábrica cerca de un río, la cantidad de peces disminuyó notablemente en pocos años. ¿Qué relación es más razonable establecer entre estos hechos?', '["No existe ninguna relación posible entre ambos hechos","La disminución de peces es una coincidencia sin relación con la fábrica","Es posible que la actividad de la fábrica haya afectado la calidad del agua y, con ello, a los peces","La cantidad de peces siempre disminuye sin ninguna causa"]', 3, 'Es razonable considerar que la actividad de la fábrica pudo afectar la calidad del agua del río, lo que a su vez afectó a la población de peces.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_6_basico' and lo.short_name = 'Efectos de la actividad humana en un ecosistema'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿En qué dirección se transfiere naturalmente el calor entre dos objetos a distinta temperatura?', '["Del objeto más caliente al objeto más frío","Del objeto más frío al objeto más caliente","No se transfiere calor entre objetos","En ambas direcciones por igual siempre"]', 0, 'El calor se transfiere naturalmente del objeto más caliente al objeto más frío, hasta alcanzar el equilibrio térmico.', 'inicial', 25),
  ('¿Qué ocurre con la temperatura de una taza de té caliente colocada sobre una mesa a temperatura ambiente, con el paso del tiempo?', '["Aumenta cada vez más","Disminuye hasta acercarse a la temperatura ambiente","Se mantiene siempre igual","Sube y baja al azar"]', 1, 'La taza de té transfiere calor al ambiente, por lo que su temperatura disminuye hasta acercarse a la temperatura ambiente.', 'intermedia', 35),
  ('¿Cuál de estos materiales es un buen conductor de calor?', '["El metal","La madera","La lana","El plumón"]', 2, 'El metal es un buen conductor de calor, por eso se calienta rápidamente al estar en contacto con una fuente de calor.', 'intermedia', 35),
  ('Un estudiante coloca una cuchara de metal y una cuchara de madera dentro de una olla con agua caliente. Después de un rato, la cuchara de metal está mucho más caliente al tacto que la de madera. ¿Qué explica esta diferencia?', '["La madera transfiere el calor más rápido que el metal","El metal es mejor conductor de calor que la madera","El agua transfiere calor solo al metal","La cuchara de madera no estuvo en contacto con el agua"]', 3, 'El metal es mejor conductor de calor que la madera, por lo que transfiere el calor del agua caliente más rápidamente hacia la cuchara.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_6_basico' and lo.short_name = 'Transferencia de calor'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la masa de un objeto?', '["La cantidad de materia que contiene un objeto","El espacio que ocupa un objeto","El color de un objeto","La temperatura de un objeto"]', 0, 'La masa es la cantidad de materia que contiene un objeto, y se mide generalmente en gramos o kilogramos.', 'inicial', 25),
  ('¿Qué es el volumen de un objeto?', '["El sonido que produce un objeto","El espacio que ocupa un objeto","La cantidad de materia de un objeto","El peso exacto de un objeto"]', 1, 'El volumen es el espacio que ocupa un objeto, y se puede medir en unidades como centímetros cúbicos o litros.', 'intermedia', 35),
  ('¿Cuál de estos instrumentos se usa para medir la masa de un objeto?', '["Una regla","Un termómetro","Una balanza","Un cronómetro"]', 2, 'Una balanza es el instrumento que se usa para medir la masa de un objeto.', 'intermedia', 35),
  ('Un estudiante mide el volumen de una piedra sumergiéndola en una probeta con agua y observando cuánto sube el nivel del agua, y luego mide su masa con una balanza. ¿Qué dos propiedades de la materia está midiendo, en ese orden?', '["Temperatura y masa","Volumen y masa","Masa y volumen","Densidad y temperatura"]', 3, 'Al sumergir la piedra en agua para medir cuánto sube el nivel, mide el volumen; al usar la balanza, mide la masa.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_6_basico' and lo.short_name = 'Propiedades de la materia: masa y volumen'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos ejemplos corresponde a una reacción química de la vida cotidiana?', '["La combustión de una vela","El derretimiento del hielo","La mezcla de agua con arena","El estiramiento de una goma elástica"]', 0, 'La combustión de una vela es una reacción química, ya que se transforma la cera en otras sustancias liberando luz y calor.', 'inicial', 25),
  ('¿Qué ocurre durante la reacción química de oxidación de un clavo de fierro expuesto al aire húmedo?', '["El fierro se transforma en óxido, formando una nueva sustancia","El fierro se derrite","El fierro cambia de estado a gas","El fierro no sufre ningún cambio"]', 1, 'Durante la oxidación, el fierro reacciona con el oxígeno del aire y forma óxido, una nueva sustancia.', 'intermedia', 35),
  ('¿Cuál de estos cambios corresponde a un cambio químico (formación de una nueva sustancia) y no solo a un cambio físico?', '["Cortar una hoja de papel en pedazos","Quemar un trozo de papel hasta convertirlo en cenizas","Doblar una lámina de metal","Derretir un cubo de hielo"]', 2, 'Quemar papel hasta convertirlo en cenizas es un cambio químico, ya que se forman nuevas sustancias (cenizas, gases) distintas al papel original.', 'intermedia', 35),
  ('Un estudiante mezcla bicarbonato de sodio con vinagre y observa que se forman burbujas y espuma de inmediato. ¿Qué evidencia sugiere que ocurrió una reacción química y no solo un cambio físico?', '["Que ambos líquidos se mezclaron sin cambios","Que la formación de burbujas indica la producción de un nuevo gas a partir de la reacción","Que el vinagre cambió de color únicamente","Que el bicarbonato se disolvió sin ninguna reacción"]', 3, 'La formación de burbujas indica la producción de un nuevo gas (dióxido de carbono) a partir de la reacción química entre el bicarbonato y el vinagre.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_6_basico' and lo.short_name = 'Reacciones químicas simples de la vida cotidiana'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una acción de uso responsable de la energía en el hogar?', '["Apagar los aparatos electrónicos que no se están usando","Dejar todas las luces encendidas todo el día","Usar todos los electrodomésticos al mismo tiempo sin necesidad","Dejar la puerta del refrigerador abierta"]', 0, 'Apagar los aparatos electrónicos que no se están usando es una acción de uso responsable de la energía.', 'inicial', 25),
  ('¿Por qué es importante usar la energía de forma responsable?', '["Porque las fuentes de energía y su generación pueden tener un costo ambiental o económico","Porque la energía nunca se agota y no importa cómo se use","Porque no tiene relación con el medioambiente","Porque usar más energía siempre es mejor"]', 1, 'Usar la energía de forma responsable es importante porque su generación puede tener un costo ambiental o económico.', 'intermedia', 35),
  ('¿Cuál de estas acciones ayuda a reducir el consumo innecesario de energía eléctrica en una escuela?', '["Aprovechar la luz natural durante el día en vez de encender luces artificiales","Mantener encendidas todas las luces aunque haya suficiente luz natural","Dejar los computadores encendidos toda la noche sin usarlos","Usar aire acondicionado con las ventanas y puertas abiertas"]', 2, 'Aprovechar la luz natural durante el día ayuda a reducir el consumo innecesario de energía eléctrica.', 'intermedia', 35),
  ('Un colegio decide reemplazar sus ampolletas antiguas por ampolletas de bajo consumo y apagar los equipos electrónicos que no se usan durante el recreo. ¿Qué relación tienen estas medidas con el uso responsable de la energía?', '["No tienen ninguna relación con el uso de energía","Aumentan el consumo de energía del colegio","Contribuyen a reducir el consumo innecesario de energía eléctrica","Solo afectan la estética del colegio, sin relación con la energía"]', 3, 'Estas medidas contribuyen a reducir el consumo innecesario de energía eléctrica del colegio.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_6_basico' and lo.short_name = 'Uso responsable de la energía'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué son las placas tectónicas?', '["Grandes bloques rígidos que forman parte de la capa externa de la Tierra y se mueven lentamente","Pequeñas piedras de la superficie de la Tierra","Capas de la atmósfera","Un tipo de nube"]', 0, 'Las placas tectónicas son grandes bloques rígidos que forman parte de la capa externa de la Tierra y se mueven lentamente.', 'inicial', 25),
  ('¿Qué fenómeno se relaciona frecuentemente con el movimiento de las placas tectónicas?', '["Los terremotos","La formación de nubes","El ciclo del agua exclusivamente","El cambio de estaciones"]', 1, 'Los terremotos se relacionan frecuentemente con el movimiento de las placas tectónicas.', 'intermedia', 35),
  ('¿Por qué Chile presenta una alta actividad sísmica y volcánica?', '["Porque se ubica en una zona donde se encuentran y interactúan placas tectónicas","Porque está muy cerca del Ecuador","Porque tiene muchos ríos","Porque tiene un clima muy frío en todo su territorio"]', 2, 'Chile presenta alta actividad sísmica y volcánica porque se ubica en una zona de interacción entre placas tectónicas.', 'intermedia', 35),
  ('Un estudiante investiga que, en los bordes donde interactúan dos placas tectónicas, es común encontrar cadenas de volcanes y una alta frecuencia de terremotos. ¿Qué relación explica mejor esta información sobre las capas internas de la Tierra?', '["El movimiento de las placas tectónicas no tiene relación con volcanes ni terremotos","Los volcanes y terremotos ocurren al azar, sin relación con la estructura de la Tierra","El movimiento y la interacción de las placas tectónicas explican la formación de volcanes y la ocurrencia de terremotos en esas zonas","Las placas tectónicas solo existen en el océano"]', 3, 'El movimiento y la interacción de las placas tectónicas explican por qué en sus bordes es común encontrar volcanes y una alta frecuencia de terremotos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_6_basico' and lo.short_name = 'Capas internas de la Tierra y placas tectónicas'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es una galaxia?', '["Un enorme conjunto de estrellas, planetas y otros cuerpos celestes unidos por la gravedad","Un tipo de nube en la atmósfera terrestre","Un solo planeta muy grande","Un instrumento para observar el cielo"]', 0, 'Una galaxia es un enorme conjunto de estrellas, planetas y otros cuerpos celestes unidos por la gravedad.', 'inicial', 25),
  ('¿A qué galaxia pertenece nuestro Sistema Solar?', '["A la Vía Láctea","A una galaxia sin nombre conocido","A ninguna galaxia","A la galaxia de Andrómeda exclusivamente"]', 1, 'Nuestro Sistema Solar pertenece a la galaxia conocida como Vía Láctea.', 'intermedia', 35),
  ('¿Cuál de estos cuerpos celestes produce luz propia?', '["Una estrella","Un planeta","Un satélite natural como la Luna","Un asteroide"]', 2, 'Una estrella, como el Sol, produce su propia luz, a diferencia de los planetas o satélites, que reflejan la luz que reciben.', 'intermedia', 35),
  ('Un estudiante investiga que el universo contiene una enorme cantidad de galaxias, y que cada galaxia puede contener millones o miles de millones de estrellas, muchas de ellas con sus propios sistemas planetarios. ¿Qué idea sobre la escala del universo refleja mejor esta información?', '["El universo es muy pequeño y contiene solo nuestro Sistema Solar","El universo contiene una enorme cantidad de cuerpos celestes organizados en galaxias","El universo contiene solo una galaxia con pocas estrellas","El Sistema Solar contiene todas las galaxias del universo"]', 3, 'Esta información refleja que el universo contiene una enorme cantidad de cuerpos celestes organizados en galaxias, cada una con muchas estrellas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_6_basico' and lo.short_name = 'El universo y los cuerpos celestes'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos recursos energéticos es no renovable?', '["El carbón","La energía solar","La energía eólica","La energía hidráulica"]', 0, 'El carbón es un recurso energético no renovable, ya que tarda millones de años en formarse y se agota con su uso.', 'inicial', 25),
  ('¿Cuál de estos recursos energéticos es renovable?', '["El petróleo","El gas natural","La energía solar","El carbón"]', 1, 'La energía solar es un recurso renovable, ya que no se agota con su uso.', 'intermedia', 35),
  ('¿Qué impacto ambiental está asociado principalmente al uso de combustibles fósiles como el petróleo y el carbón?', '["La emisión de gases contaminantes que contribuyen al cambio climático","La ausencia total de impacto ambiental","La disminución de la contaminación del aire","La eliminación completa de gases de efecto invernadero"]', 2, 'El uso de combustibles fósiles está asociado a la emisión de gases contaminantes que contribuyen al cambio climático.', 'intermedia', 35),
  ('Un país decide reemplazar progresivamente sus centrales a carbón por parques solares y eólicos para generar electricidad. ¿Qué relación tiene esta decisión con el impacto ambiental de los recursos energéticos?', '["No tiene ninguna relación con el impacto ambiental","Busca reducir el impacto ambiental asociado al uso de recursos no renovables como el carbón","Aumenta el uso de recursos no renovables","Elimina por completo la necesidad de cuidar el medioambiente"]', 3, 'Esta decisión busca reducir el impacto ambiental asociado al uso de recursos no renovables como el carbón, reemplazándolos por fuentes renovables.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_6_basico' and lo.short_name = 'Recursos energéticos y su impacto ambiental'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 6° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas preguntas de investigación identifica claramente una variable a estudiar?', '["¿Afecta la cantidad de luz solar al crecimiento de una planta?","¿Te gustan las plantas?","¿Qué planta es más bonita?","¿Cuántas plantas hay en el patio del colegio?"]', 0, '¿Afecta la cantidad de luz solar al crecimiento de una planta? identifica claramente una variable a estudiar: la cantidad de luz solar.', 'inicial', 25),
  ('¿Por qué es importante que una pregunta de investigación identifique una variable específica?', '["Porque así se puede diseñar un experimento centrado en esa variable","Porque las preguntas sin variable son más fáciles de responder","Porque no es necesario identificar variables en ciencia","Porque toda pregunta debe ser una opinión personal"]', 1, 'Identificar una variable específica permite diseñar un experimento centrado en estudiar esa variable de forma controlada.', 'intermedia', 35),
  ('Un estudiante formula la pregunta: ¿La temperatura del agua afecta la rapidez con que se disuelve la sal? ¿Cuál es la variable que se está estudiando en esta pregunta?', '["La cantidad de sal","La temperatura del agua","El color del agua","El tamaño del recipiente"]', 2, 'La variable que se está estudiando en esta pregunta es la temperatura del agua.', 'intermedia', 35),
  ('Un grupo de estudiantes quiere investigar si el tipo de superficie (lisa o rugosa) afecta la distancia que recorre un carro de juguete al soltarlo desde una rampa. ¿Cuál de estas preguntas identifica correctamente la variable de este estudio?', '["¿Cuál es el carro de juguete más bonito?", "¿Recorre más distancia el carro de juguete en una superficie lisa que en una rugosa?", "¿Cuántos carros de juguete hay en la sala?", "¿Qué color tiene la rampa?"]', 3, 'Esta pregunta identifica correctamente la variable en estudio: el tipo de superficie (lisa o rugosa) y su efecto en la distancia recorrida.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_6_basico' and lo.short_name = 'Formulación de preguntas de investigación con variables'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Por qué es importante analizar de manera crítica una noticia científica antes de creerla por completo?', '["Porque toda información encontrada en internet es siempre verdadera","Porque no todas las fuentes de información son igual de confiables o precisas","Porque las noticias científicas nunca contienen errores","Porque no es necesario revisar de dónde proviene la información"]', 0, 'No todas las fuentes de información son igual de confiables o precisas, por lo que es importante analizarlas de forma crítica.', 'inicial', 25),
  ('¿Cuál de estas es una señal de que una fuente de información científica podría ser poco confiable?', '["Que cite estudios y datos verificables de instituciones reconocidas","Que no mencione ninguna fuente ni evidencia para sus afirmaciones","Que haya sido revisada por varios científicos expertos","Que explique claramente cómo se obtuvieron los datos"]', 1, 'Que una fuente no mencione ninguna evidencia ni fuente para sus afirmaciones es una señal de que podría ser poco confiable.', 'intermedia', 35),
  ('Un estudiante encuentra dos artículos sobre el mismo tema científico: uno publicado por una universidad con datos y referencias, y otro publicado en una red social sin autor ni fuentes. ¿Cuál debería considerar más confiable y por qué?', '["El de la red social, porque es más fácil de leer","Ambos son igual de confiables","El de la universidad, porque incluye datos y referencias verificables","Ninguno de los dos, porque la ciencia no se puede confiar"]', 2, 'El artículo de la universidad debería considerarse más confiable, ya que incluye datos y referencias verificables.', 'intermedia', 35),
  ('Un estudiante lee una publicación en redes sociales que afirma, sin citar ninguna fuente, que cierto alimento cura todas las enfermedades. ¿Qué acción refleja un análisis crítico adecuado de esta información?', '["Creer la información de inmediato y compartirla sin revisar nada","Ignorar por completo cualquier información científica en el futuro","Buscar si existen estudios científicos serios que respalden esa afirmación antes de creerla","Rechazar la información solo porque suena interesante"]', 3, 'Buscar si existen estudios científicos serios que respalden la afirmación es un ejemplo de análisis crítico adecuado de la información.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_6_basico' and lo.short_name = 'Análisis crítico de fuentes de información científica'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 6° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué elementos debería incluir la comunicación de las conclusiones de una investigación científica?', '["Lo que se observó, los datos obtenidos y la conclusión basada en ellos","Solo una opinión personal, sin datos","Solo un dibujo sin ninguna explicación","Información inventada que no se relaciona con la investigación"]', 0, 'La comunicación de conclusiones debe incluir lo observado, los datos obtenidos y la conclusión basada en esa evidencia.', 'inicial', 25),
  ('¿Por qué es importante comunicar con claridad las conclusiones de una investigación a otras personas?', '["Para que otros puedan entender y evaluar lo que se investigó","Porque las conclusiones no necesitan explicarse","Para que nadie pueda revisar el trabajo realizado","Porque comunicar conclusiones no tiene ninguna utilidad"]', 1, 'Comunicar con claridad las conclusiones permite que otras personas entiendan y evalúen lo investigado.', 'intermedia', 35),
  ('Un grupo de estudiantes investigó el efecto de la luz en el crecimiento de una planta y debe presentar sus conclusiones al curso. ¿Cuál de estas formas de comunicación sería más adecuada?', '["Decir solo ''nos fue bien'', sin más detalles","Presentar los datos obtenidos, el gráfico de crecimiento y la conclusión relacionada con la luz","Mostrar un dibujo sin relación con el experimento","No comunicar nada al curso"]', 2, 'Presentar los datos obtenidos, un gráfico y la conclusión relacionada con la variable estudiada es la forma más adecuada de comunicar resultados.', 'intermedia', 35),
  ('Un estudiante concluye su investigación diciendo: ''Las plantas con más luz crecieron en promedio 5 cm más que las plantas con menos luz, según los datos registrados durante un mes''. ¿Qué característica de una buena comunicación de conclusiones cumple esta afirmación?', '["No cumple ninguna característica de una buena comunicación","Se basa en datos concretos obtenidos durante la investigación","Es una opinión personal sin relación con los datos","Es una afirmación inventada sin ninguna base"]', 3, 'Esta afirmación se basa en datos concretos obtenidos durante la investigación, lo que la hace una comunicación de conclusiones clara y fundamentada.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_6_basico' and lo.short_name = 'Comunicación de conclusiones de una investigación'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
