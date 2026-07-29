-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 1° Medio. Cubre los 14 objetivos de aprendizaje de 1° Medio
-- cargados por
-- supabase/seed/0018_curriculum_ciencias_regular_7basico_2medio.sql, con 4
-- preguntas por objetivo, total 56 preguntas en este archivo.
--
-- Mismo estado editorial, formato de pregunta, validación mecánica e
-- idempotencia documentados en el encabezado de
-- supabase/seed/0086_questions_ciencias_regular_1_basico.sql (no se repite
-- íntegro aquí).

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 1° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la homeostasis?', '["La capacidad del cuerpo de mantener un equilibrio interno estable","Un tipo de enfermedad del sistema nervioso","La producción de hormonas exclusivamente durante el sueño","Un proceso exclusivo de las plantas"]', 0, 'La homeostasis es la capacidad del cuerpo de mantener un equilibrio interno estable, a pesar de los cambios del ambiente.', 'inicial', 25),
  ('¿Qué función cumple el sistema endocrino en relación con la homeostasis?', '["Produce hormonas que ayudan a regular distintos procesos del cuerpo","Transporta oxígeno por la sangre","Filtra el aire que se respira","Produce el movimiento de los músculos exclusivamente"]', 1, 'El sistema endocrino produce hormonas que ayudan a regular distintos procesos del cuerpo, contribuyendo a la homeostasis.', 'intermedia', 35),
  ('¿Cómo colaboran el sistema nervioso y el sistema endocrino para mantener la homeostasis?', '["El sistema nervioso envía señales rápidas y el sistema endocrino libera hormonas para regular procesos, ambos en conjunto","Solo el sistema nervioso participa en la homeostasis","Solo el sistema endocrino participa en la homeostasis","Ninguno de los dos sistemas tiene relación con la homeostasis"]', 2, 'El sistema nervioso envía señales rápidas y el sistema endocrino libera hormonas para regular distintos procesos, ambos contribuyendo a la homeostasis.', 'intermedia', 35),
  ('Un estudiante explica que, cuando el cuerpo tiene mucho calor, el sistema nervioso detecta el cambio y activa mecanismos como la sudoración, mientras que ciertas hormonas ayudan a regular otros procesos internos para mantener una temperatura estable. ¿Qué concepto general ilustra esta descripción?', '["La ausencia de coordinación entre los sistemas del cuerpo","La homeostasis, lograda mediante la coordinación del sistema nervioso y el sistema endocrino","Un proceso exclusivo del sistema digestivo","Un fenómeno que no depende de ningún sistema del cuerpo"]', 3, 'Esta descripción ilustra la homeostasis, lograda mediante la coordinación del sistema nervioso y el sistema endocrino.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_1_medio' and lo.short_name = 'Sistemas nervioso y endocrino y homeostasis'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué organelo celular se encarga principalmente de producir energía para la célula?', '["La mitocondria","El núcleo","El ribosoma","La vacuola"]', 0, 'La mitocondria es el organelo celular encargado principalmente de producir energía para la célula.', 'inicial', 25),
  ('¿Cuál es la función principal del núcleo celular?', '["Producir energía para la célula","Contener el material genético y controlar las actividades de la célula","Producir sonidos para la célula","Eliminar toda la información genética"]', 1, 'El núcleo contiene el material genético y controla las actividades de la célula.', 'intermedia', 35),
  ('¿Qué diferencia principal existe entre una célula vegetal y una célula animal, en cuanto a organelos?', '["La célula vegetal tiene pared celular y cloroplastos, que la célula animal no tiene","Ambas células son exactamente iguales en todos sus organelos","La célula animal siempre tiene cloroplastos","La célula vegetal nunca tiene núcleo"]', 2, 'La célula vegetal presenta pared celular y cloroplastos, estructuras que la célula animal típica no posee.', 'intermedia', 35),
  ('Un estudiante observa al microscopio una célula con pared celular rígida y organelos verdes (cloroplastos), y otra célula sin pared celular ni cloroplastos, pero con una membrana flexible. ¿Qué tipo de célula es cada una, respectivamente?', '["Ambas son células animales","Ambas son células vegetales","Célula animal y célula vegetal","Célula vegetal y célula animal"]', 3, 'La primera célula, con pared celular y cloroplastos, es una célula vegetal; la segunda, sin esas estructuras, es una célula animal.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_1_medio' and lo.short_name = 'La célula y sus organelos'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una molécula orgánica presente en las células?', '["Las proteínas","El agua exclusivamente","La sal común","El oxígeno puro exclusivamente"]', 0, 'Las proteínas son moléculas orgánicas presentes en las células, con funciones estructurales y metabólicas.', 'inicial', 25),
  ('¿Cuál de estas es considerada una molécula inorgánica esencial para la célula?', '["Las proteínas","Los carbohidratos","El agua","Los lípidos"]', 1, 'El agua es una molécula inorgánica esencial para el funcionamiento de la célula.', 'intermedia', 35),
  ('¿Qué función cumplen los carbohidratos en la célula, generalmente?', '["Sirven principalmente como fuente de energía","Son exclusivamente inorgánicos","No cumplen ninguna función en la célula","Reemplazan al material genético"]', 2, 'Los carbohidratos sirven principalmente como fuente de energía para la célula.', 'intermedia', 35),
  ('Un estudiante analiza la composición química de una célula y encuentra agua, sales minerales, proteínas, carbohidratos y lípidos. Si debe separar estas moléculas en orgánicas e inorgánicas, ¿cuál de estas clasificaciones es correcta?', '["Orgánicas: agua y sales minerales. Inorgánicas: proteínas, carbohidratos y lípidos.","Orgánicas: proteínas, carbohidratos y lípidos. Inorgánicas: agua y sales minerales.","Todas son moléculas orgánicas por igual.","Todas son moléculas inorgánicas por igual."]', 3, 'Las proteínas, carbohidratos y lípidos son moléculas orgánicas; el agua y las sales minerales son moléculas inorgánicas.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_1_medio' and lo.short_name = 'Composición química de la célula'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué molécula contiene la información genética que se transmite de generación en generación?', '["El ADN","El agua","La glucosa","El oxígeno"]', 0, 'El ADN es la molécula que contiene la información genética que se transmite de generación en generación.', 'inicial', 25),
  ('¿Dónde se encuentra principalmente el ADN en una célula con núcleo?', '["En el núcleo celular","Fuera de la célula, en el ambiente","Solo en la membrana celular","En el aire que respira la célula"]', 1, 'El ADN se encuentra principalmente en el núcleo de las células que poseen esta estructura.', 'intermedia', 35),
  ('¿Cómo se transmite, a nivel introductorio, la información genética de los padres a los hijos?', '["A través del ADN heredado de ambos progenitores","Únicamente a través del ambiente en que vive el hijo","Sin ninguna relación con los padres","Solo a través de la alimentación"]', 2, 'La información genética se transmite a través del ADN heredado de ambos progenitores.', 'intermedia', 35),
  ('Un estudiante investiga que ciertas características físicas, como el color de ojos, pueden heredarse de generación en generación a través de la información contenida en el ADN de los padres. ¿Qué concepto general ilustra esta información?', '["Que las características físicas no tienen relación con la genética","Que la transmisión de la información genética explica la herencia de ciertas características entre generaciones","Que el ADN no participa en la herencia de características","Que las características físicas solo dependen del ambiente"]', 3, 'Esta información ilustra que la transmisión de la información genética, a través del ADN, explica la herencia de ciertas características entre generaciones.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_1_medio' and lo.short_name = 'Transmisión de la información genética a nivel introductorio'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 1° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué característica de una onda corresponde a la distancia entre dos crestas consecutivas?', '["La longitud de onda","La frecuencia","La amplitud","El volumen"]', 0, 'La longitud de onda corresponde a la distancia entre dos crestas consecutivas de una onda.', 'inicial', 25),
  ('¿Qué característica de una onda indica cuántas oscilaciones ocurren por unidad de tiempo?', '["La amplitud","La frecuencia","La longitud de onda","El color"]', 1, 'La frecuencia indica cuántas oscilaciones (ciclos) ocurren por unidad de tiempo.', 'intermedia', 35),
  ('¿Qué característica de una onda se relaciona con la altura máxima de una cresta respecto a su posición de equilibrio?', '["La frecuencia","La longitud de onda","La amplitud","La velocidad"]', 2, 'La amplitud se relaciona con la altura máxima de una cresta respecto a la posición de equilibrio de la onda.', 'intermedia', 35),
  ('Un estudiante compara dos ondas: la Onda A tiene una distancia mayor entre crestas consecutivas que la Onda B, y ambas se propagan a la misma velocidad. ¿Qué se puede afirmar sobre la frecuencia de ambas ondas, considerando la relación entre longitud de onda y frecuencia a una misma velocidad?', '["Ambas ondas tienen la misma frecuencia","La Onda A tiene mayor frecuencia que la Onda B","La Onda B tiene mayor frecuencia que la Onda A","No existe relación entre la longitud de onda y la frecuencia"]', 3, 'A una misma velocidad de propagación, una mayor longitud de onda (Onda A) corresponde a una menor frecuencia; por lo tanto, la Onda B, con menor longitud de onda, tiene mayor frecuencia.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_1_medio' and lo.short_name = 'Ondas y sus características'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué es la corriente eléctrica?', '["El flujo de cargas eléctricas a través de un conductor","El movimiento de un imán en el aire","La energía almacenada en una roca","El calor liberado por el Sol"]', 0, 'La corriente eléctrica es el flujo de cargas eléctricas a través de un conductor.', 'inicial', 25),
  ('¿Qué relación existe entre la electricidad y el magnetismo, según lo estudiado en el electromagnetismo básico?', '["No tienen ninguna relación entre sí","Una corriente eléctrica puede generar un campo magnético a su alrededor","El magnetismo solo existe en los imanes naturales","La electricidad y el magnetismo son exactamente el mismo fenómeno sin diferencias"]', 1, 'Una corriente eléctrica puede generar un campo magnético a su alrededor, mostrando la relación entre electricidad y magnetismo.', 'intermedia', 35),
  ('¿Qué instrumento simple demuestra la relación entre corriente eléctrica y magnetismo, al desviar una brújula cercana a un cable con corriente?', '["Un experimento con una bobina conectada a una pila y una brújula","Un experimento solo con dos imanes fijos, sin corriente eléctrica","Un experimento solo con agua y sal","Un experimento solo con luz solar"]', 2, 'Un experimento con una bobina conectada a una pila, cerca de una brújula, permite observar cómo la corriente eléctrica genera un efecto magnético.', 'intermedia', 35),
  ('Un estudiante realiza un experimento: enrolla un cable alrededor de un clavo de metal y lo conecta a una pila, formando un electroimán simple. Al acercar el clavo a pequeños clips metálicos, estos son atraídos solo mientras el circuito está conectado a la pila. ¿Qué principio del electromagnetismo demuestra este experimento?', '["Que el magnetismo no tiene relación con la electricidad","Que una corriente eléctrica puede generar un campo magnético capaz de atraer objetos metálicos","Que los clips metálicos generan electricidad por sí mismos","Que el clavo de metal es magnético sin necesidad de corriente eléctrica"]', 3, 'Este experimento demuestra que una corriente eléctrica puede generar un campo magnético capaz de atraer objetos metálicos, un principio básico del electromagnetismo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_1_medio' and lo.short_name = 'Electricidad y magnetismo básico'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cómo están organizados los elementos en la Tabla Periódica?', '["Según sus propiedades químicas y su número atómico","Según su color","Según el orden alfabético de su nombre en español","Según el año en que fueron descubiertos exclusivamente"]', 0, 'Los elementos en la Tabla Periódica están organizados según sus propiedades químicas y su número atómico.', 'inicial', 25),
  ('¿Qué agrupa una columna (grupo o familia) de la Tabla Periódica?', '["Elementos con propiedades químicas similares","Elementos que fueron descubiertos el mismo año","Elementos con el mismo color","Elementos que no tienen ninguna relación entre sí"]', 1, 'Una columna o grupo de la Tabla Periódica agrupa elementos con propiedades químicas similares.', 'intermedia', 35),
  ('¿Qué información aporta el número atómico de un elemento en la Tabla Periódica?', '["El número de protones que tiene un átomo de ese elemento","El color del elemento","El estado físico exclusivo del elemento a temperatura ambiente","El nombre del descubridor del elemento"]', 2, 'El número atómico indica la cantidad de protones que tiene un átomo de ese elemento.', 'intermedia', 35),
  ('Un estudiante observa que el sodio y el potasio, ubicados en la misma columna de la Tabla Periódica, presentan reacciones químicas similares al estar en contacto con el agua. ¿Qué explica mejor esta semejanza, considerando la organización de la Tabla Periódica?', '["Que ambos elementos fueron descubiertos el mismo año","Que ambos elementos tienen el mismo color","Que pertenecer a la misma columna (grupo) se relaciona con propiedades químicas similares","Que la Tabla Periódica no tiene relación con las propiedades químicas de los elementos"]', 3, 'Pertenecer a la misma columna (grupo) de la Tabla Periódica se relaciona con propiedades químicas similares, lo que explica la semejanza en sus reacciones.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_1_medio' and lo.short_name = 'Tabla periódica y organización de los elementos'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué propone el modelo atómico de Rutherford sobre la estructura del átomo?', '["Que el átomo tiene un núcleo pequeño y denso con carga positiva, rodeado de electrones","Que el átomo es una esfera maciza sin estructura interna","Que el átomo no tiene ninguna carga eléctrica","Que los electrones se encuentran dentro del núcleo"]', 0, 'El modelo de Rutherford propone que el átomo tiene un núcleo pequeño y denso con carga positiva, rodeado de electrones.', 'inicial', 25),
  ('¿En qué se diferencia principalmente el modelo atómico de Bohr del modelo de Rutherford?', '["Bohr propone que los electrones giran en órbitas definidas alrededor del núcleo","Bohr elimina por completo la existencia del núcleo","Bohr propone que el átomo no tiene electrones","Ambos modelos son exactamente iguales, sin ninguna diferencia"]', 1, 'El modelo de Bohr propone que los electrones giran en órbitas definidas (niveles de energía) alrededor del núcleo, a diferencia del modelo de Rutherford.', 'intermedia', 35),
  ('¿Por qué los modelos atómicos han cambiado a lo largo de la historia de la ciencia?', '["Porque nuevas evidencias experimentales han permitido mejorar la comprensión de la estructura del átomo","Porque los científicos cambian de opinión sin ninguna evidencia","Porque el átomo cambia físicamente con el tiempo","Porque no existe ningún modelo atómico aceptado actualmente"]', 2, 'Los modelos atómicos han evolucionado porque nuevas evidencias experimentales han permitido mejorar la comprensión de la estructura del átomo.', 'intermedia', 35),
  ('Un estudiante investiga la evolución histórica de los modelos atómicos: desde un modelo que consideraba al átomo como una esfera maciza, pasando por uno que incluye un núcleo con electrones alrededor, hasta modelos más recientes con niveles de energía definidos. ¿Qué idea general sobre la ciencia refleja esta evolución de modelos?', '["Que los modelos científicos nunca cambian una vez propuestos","Que los modelos científicos se ajustan y mejoran a partir de nueva evidencia experimental","Que el primer modelo propuesto siempre es el correcto","Que los modelos atómicos no tienen relación con la evidencia experimental"]', 3, 'Esta evolución refleja que los modelos científicos se ajustan y mejoran a partir de nueva evidencia experimental, un rasgo característico del conocimiento científico.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_1_medio' and lo.short_name = 'Modelos atómicos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 1° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos tipos de roca se forma a partir del enfriamiento del magma o la lava?', '["La roca ígnea","La roca sedimentaria","La roca metamórfica","La roca caliza exclusivamente"]', 0, 'La roca ígnea se forma a partir del enfriamiento del magma o la lava.', 'inicial', 25),
  ('¿Cómo se forma una roca sedimentaria?', '["Por el enfriamiento de magma en el interior de la Tierra","Por la acumulación y compactación de sedimentos a lo largo del tiempo","Por la transformación de otra roca debido a altas presiones y temperaturas","Por procesos exclusivamente relacionados con el agua de lluvia caliente"]', 1, 'La roca sedimentaria se forma por la acumulación y compactación de sedimentos a lo largo del tiempo.', 'intermedia', 35),
  ('¿Qué proceso transforma una roca ya existente en una roca metamórfica?', '["El enfriamiento directo del magma","La acumulación simple de sedimentos sin ningún cambio","La exposición a altas presiones y temperaturas que cambian su estructura interna","La evaporación del agua contenida en la roca"]', 2, 'Una roca metamórfica se forma cuando una roca existente se expone a altas presiones y temperaturas que cambian su estructura interna.', 'intermedia', 35),
  ('Un estudiante explica el ciclo de las rocas: el magma se enfría y forma roca ígnea, esta roca se erosiona formando sedimentos que se compactan en roca sedimentaria, y esta última puede transformarse en roca metamórfica bajo presión y calor, la cual puede fundirse nuevamente en magma. ¿Qué idea general representa esta descripción?', '["Que las rocas nunca cambian de un tipo a otro","Que existe un ciclo continuo de transformación entre los distintos tipos de rocas","Que solo existe un único tipo de roca en la Tierra","Que el ciclo de las rocas no tiene relación con el magma"]', 3, 'Esta descripción representa el ciclo de las rocas: un proceso continuo de transformación entre roca ígnea, sedimentaria y metamórfica, relacionado con el magma.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_1_medio' and lo.short_name = 'Formación de rocas y ciclo de las rocas'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué evidencia científica se relaciona con el cambio climático actual?', '["El aumento sostenido de la temperatura promedio del planeta en las últimas décadas","La ausencia total de variaciones climáticas registradas","La disminución constante de la temperatura del planeta desde hace un siglo","La falta de cualquier tipo de registro climático"]', 0, 'El aumento sostenido de la temperatura promedio del planeta en las últimas décadas es una evidencia relacionada con el cambio climático actual.', 'inicial', 25),
  ('¿Qué actividad humana está relacionada con el aumento de gases de efecto invernadero, según evidencia científica?', '["La quema de combustibles fósiles como el petróleo y el carbón","La observación de estrellas con telescopios","La lectura de libros","El uso de instrumentos musicales"]', 1, 'La quema de combustibles fósiles está relacionada con el aumento de gases de efecto invernadero en la atmósfera.', 'intermedia', 35),
  ('¿Cómo contribuyen los gases de efecto invernadero al cambio climático?', '["Atrapan calor en la atmósfera, contribuyendo al aumento de la temperatura global","Eliminan por completo el calor de la atmósfera","No tienen ninguna relación con la temperatura del planeta","Solo afectan la temperatura del océano, sin relación con la atmósfera"]', 2, 'Los gases de efecto invernadero atrapan calor en la atmósfera, contribuyendo al aumento de la temperatura global.', 'intermedia', 35),
  ('Un estudiante investiga que, desde la Revolución Industrial, la quema de combustibles fósiles ha aumentado significativamente la concentración de gases de efecto invernadero en la atmósfera, y que este período coincide con un aumento sostenido de la temperatura promedio del planeta. ¿Qué relación sugiere esta evidencia entre la actividad humana y el cambio climático?', '["No existe ninguna relación entre ambos fenómenos","La actividad humana relacionada con la quema de combustibles fósiles podría estar contribuyendo al cambio climático","El cambio climático se debe únicamente a causas naturales, sin relación con la actividad humana","La temperatura del planeta ha disminuido desde la Revolución Industrial"]', 3, 'Esta evidencia sugiere que la actividad humana, en particular la quema de combustibles fósiles, podría estar contribuyendo al cambio climático observado.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_1_medio' and lo.short_name = 'Cambio climático y actividad humana'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Dónde se encuentra la mayor parte del agua dulce disponible en el planeta, en estado sólido?', '["En los glaciares y casquetes polares","En el aire que respiramos","En el fondo de los océanos","En el núcleo de la Tierra"]', 0, 'La mayor parte del agua dulce disponible en el planeta, en estado sólido, se encuentra en los glaciares y casquetes polares.', 'inicial', 25),
  ('¿Por qué el agua de los océanos no se puede utilizar directamente para el consumo humano ni el riego agrícola?', '["Porque contiene una alta concentración de sal, no apta para esos usos sin tratamiento previo","Porque el agua de mar es completamente pura","Porque el agua de mar no contiene ningún mineral","Porque no existe suficiente agua en los océanos"]', 1, 'El agua de los océanos contiene una alta concentración de sal, por lo que no es apta para consumo humano ni riego sin un tratamiento previo.', 'intermedia', 35),
  ('¿Por qué la distribución de los recursos hídricos varía tanto entre distintas zonas de un país como Chile?', '["Por diferencias en el clima, la geografía y la disponibilidad de fuentes de agua en cada zona","Porque el agua se distribuye exactamente igual en todo el territorio","Porque la distribución del agua no depende de ningún factor geográfico","Porque todas las zonas de Chile tienen el mismo clima"]', 2, 'La distribución de los recursos hídricos varía debido a diferencias en el clima, la geografía y la disponibilidad de fuentes de agua en cada zona.', 'intermedia', 35),
  ('Un estudiante investiga que el norte de Chile, en el desierto de Atacama, presenta escasez de recursos hídricos, mientras que el sur del país cuenta con abundantes lagos, ríos y glaciares. ¿Qué relación explica mejor esta diferencia, considerando la distribución de los recursos hídricos?', '["No existe relación entre el clima y la disponibilidad de agua en distintas zonas","Las diferencias climáticas y geográficas entre el norte y el sur explican la distinta distribución de los recursos hídricos","El norte y el sur de Chile tienen exactamente la misma cantidad de agua disponible","La distribución de recursos hídricos es igual en todo el territorio chileno"]', 3, 'Las diferencias climáticas y geográficas entre el norte (desértico) y el sur (más lluvioso, con glaciares) explican la distinta distribución de los recursos hídricos en Chile.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_1_medio' and lo.short_name = 'Recursos hídricos y su distribución'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 1° MEDIO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué secciones debería incluir un informe de investigación científica completo?', '["Pregunta de investigación, hipótesis, procedimiento, resultados y conclusiones","Solo un título llamativo, sin ningún dato","Solo una opinión personal sobre el tema","Solo una lista de materiales, sin ningún otro dato"]', 0, 'Un informe de investigación completo debe incluir la pregunta de investigación, la hipótesis, el procedimiento, los resultados y las conclusiones.', 'inicial', 25),
  ('¿Por qué es importante incluir los resultados obtenidos, y no solo las conclusiones, en un informe de investigación?', '["Porque los resultados permiten que otras personas verifiquen si las conclusiones están bien fundamentadas","Porque las conclusiones no tienen relación con los resultados","Porque los resultados no aportan ninguna información relevante","Porque solo importa la opinión final del investigador"]', 1, 'Incluir los resultados permite que otras personas verifiquen si las conclusiones están bien fundamentadas en la evidencia obtenida.', 'intermedia', 35),
  ('Un estudiante entrega un informe que solo dice ''mi hipótesis era correcta'', sin mostrar los datos obtenidos ni el procedimiento realizado. ¿Qué problema tiene este informe de investigación?', '["Ningún problema, es un informe completo","Le falta mostrar el procedimiento y los datos que respaldan esa afirmación","Es un informe demasiado extenso","No necesita ninguna mejora"]', 2, 'Al informe le falta mostrar el procedimiento seguido y los datos obtenidos que respaldan la afirmación sobre la hipótesis.', 'intermedia', 35),
  ('Un estudiante elabora un informe de investigación que incluye: la pregunta de investigación, la hipótesis planteada, el procedimiento con materiales y pasos, una tabla con los datos obtenidos, un gráfico de los resultados y una conclusión que compara los resultados con la hipótesis inicial. ¿Qué característica de un buen informe de investigación cumple este trabajo?', '["No cumple con ninguna característica de un buen informe","Incluye todos los elementos necesarios para comunicar la investigación de forma completa y verificable","Solo incluye una opinión personal, sin ningún dato","Omite información relevante sobre los resultados obtenidos"]', 3, 'Este informe incluye todos los elementos necesarios (pregunta, hipótesis, procedimiento, datos, gráfico y conclusión) para comunicar la investigación de forma completa y verificable.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_1_medio' and lo.short_name = 'Elaboración de informes de investigación'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos criterios ayuda a evaluar si una fuente de información científica es confiable?', '["Que cite estudios, datos y referencias verificables","Que no mencione ningún dato ni autor","Que sea anónima y sin ninguna referencia","Que solo contenga opiniones personales sin evidencia"]', 0, 'Que una fuente cite estudios, datos y referencias verificables es un criterio que ayuda a evaluar su confiabilidad.', 'inicial', 25),
  ('¿Por qué es importante revisar si un artículo científico fue publicado por una institución reconocida o revisado por otros expertos (revisión por pares)?', '["Porque eso aumenta la probabilidad de que la información sea confiable y esté bien fundamentada","Porque cualquier publicación es igual de confiable sin importar su origen","Porque la revisión por pares no tiene ninguna utilidad","Porque solo importa que el artículo sea largo"]', 1, 'La revisión por pares y la publicación en instituciones reconocidas aumentan la probabilidad de que la información sea confiable y esté bien fundamentada.', 'intermedia', 35),
  ('Un estudiante encuentra dos fuentes sobre el mismo tema científico: una es un artículo revisado por expertos y publicado en una revista científica reconocida, y la otra es una publicación anónima en un foro sin ninguna referencia. ¿Cuál debería considerar más confiable?', '["Ambas son igual de confiables","La publicación del foro, porque es más fácil de encontrar","El artículo científico revisado por expertos y publicado en una revista reconocida","Ninguna de las dos, porque toda información científica es poco confiable"]', 2, 'El artículo científico revisado por expertos y publicado en una revista reconocida debería considerarse más confiable que una publicación anónima sin referencias.', 'intermedia', 35),
  ('Un estudiante encuentra una publicación en redes sociales que afirma, sin citar ninguna fuente ni dato, que cierto producto tiene un efecto extraordinario en la salud. ¿Qué acción refleja una evaluación adecuada de la validez de esta fuente de información?', '["Compartir la información de inmediato sin revisar nada más","Buscar si existen estudios científicos serios, revisados por expertos, que respalden esa afirmación","Rechazar automáticamente cualquier información encontrada en internet","Creer la información solo porque tiene muchas reacciones o comentarios"]', 3, 'Buscar si existen estudios científicos serios y revisados por expertos que respalden la afirmación es un ejemplo de evaluación adecuada de la validez de una fuente.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_1_medio' and lo.short_name = 'Evaluación de la validez de fuentes de información'
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
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Medio, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Para qué sirve un modelo científico, como una maqueta del Sistema Solar?', '["Para representar y explicar un fenómeno que puede ser difícil de observar directamente","Para reemplazar por completo la necesidad de estudiar el fenómeno real","Para decorar una sala de clases sin ningún propósito científico","Para ocultar información sobre un fenómeno natural"]', 0, 'Un modelo científico sirve para representar y explicar un fenómeno que puede ser difícil de observar directamente en su totalidad.', 'inicial', 25),
  ('¿Por qué los científicos usan modelos, como el modelo atómico, para explicar fenómenos que no se pueden ver directamente a simple vista?', '["Porque los modelos permiten representar de forma simplificada estructuras o procesos muy pequeños o complejos","Porque los modelos siempre son exactamente iguales a la realidad en todos sus detalles","Porque no es posible estudiar fenómenos que no se pueden ver a simple vista","Porque los modelos reemplazan la necesidad de la observación científica"]', 1, 'Los modelos permiten representar de forma simplificada estructuras o procesos muy pequeños o complejos, como los átomos, que no se pueden observar directamente a simple vista.', 'intermedia', 35),
  ('¿Qué limitación tienen los modelos científicos al representar un fenómeno real?', '["No representan absolutamente ningún aspecto real del fenómeno","Son siempre una simplificación y pueden no incluir todos los detalles del fenómeno real","Son una copia exacta del fenómeno en todos sus aspectos","No tienen ninguna limitación"]', 2, 'Los modelos científicos son siempre una simplificación de la realidad y pueden no incluir todos los detalles del fenómeno que representan.', 'intermedia', 35),
  ('Un estudiante usa un modelo de bolitas y palillos para representar cómo se unen los átomos en una molécula de agua, explicando que ese modelo ayuda a visualizar la estructura, aunque no representa exactamente el tamaño real de los átomos ni todas sus propiedades. ¿Qué idea general sobre los modelos científicos refleja esta explicación?', '["Que los modelos científicos deben ser una réplica exacta de la realidad en todos sus detalles","Que los modelos científicos son útiles para explicar fenómenos, aunque son una simplificación de la realidad","Que los modelos científicos no tienen ninguna utilidad para explicar fenómenos","Que los átomos tienen exactamente el tamaño y la forma de las bolitas usadas en el modelo"]', 3, 'Esta explicación refleja que los modelos científicos son útiles para explicar fenómenos, aunque son una simplificación de la realidad y no representan todos sus detalles exactos.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_1_medio' and lo.short_name = 'Uso de modelos para explicar fenómenos'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
