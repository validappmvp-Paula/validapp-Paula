-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Ciencias
-- Naturales, 1° Básico. Cubre los 14 objetivos de aprendizaje de 1° Básico
-- cargados por supabase/seed/0017_curriculum_ciencias_regular_basica_1_6.sql
-- (4 ejes: Ciencias de la Vida, Ciencias Físicas y Químicas, Ciencias de la
-- Tierra y el Universo, Habilidades de Investigación Científica), con 4
-- preguntas por objetivo (dentro del rango 3-5 pedido), total 56 preguntas
-- en este archivo.
--
-- ============================================================================
-- ESTADO EDITORIAL Y DE VALIDACIÓN (léase antes de aprobar cualquier fila)
-- ============================================================================
-- Mismo patrón que los bancos de Matemática (supabase/seed/0026-0031/0050-
-- 0051/0060-0063) y Lenguaje (supabase/seed/0052-0053/0064-0067/0080-0085):
-- `review_status = 'borrador'`, `validation_status =
-- 'ai_generated_review_required'`, `is_active = true`, `source_type =
-- 'validapp_original'`, `generated_by = 'claude-sonnet-5'`. Ninguna fila
-- cumple `validation_status = 'approved_for_exam'` + `review_status =
-- 'aprobado'`, por lo que ninguna pregunta de este archivo es usable todavía
-- en un ensayo o diagnóstico real. Requieren revisión pedagógica humana antes
-- de cualquier cambio de estado (y ese cambio, por el trigger
-- `questions_prevent_ai_self_approval` de 0025, solo lo puede hacer un
-- administrador real, nunca un agente).
--
-- ============================================================================
-- FORMATO DE PREGUNTA
-- ============================================================================
-- A diferencia de Lenguaje (que usa estímulos de lectura embebidos) y de
-- Matemática (formato de cálculo), las preguntas de Ciencias Naturales de
-- este tramo son mayoritariamente de identificación, comparación y
-- aplicación de conceptos concretos y observables (seres vivos vs. objetos
-- no vivos, estados de la materia, fuentes de luz/sonido, ciclo día-noche,
-- habilidades de indagación), con algunas preguntas situacionales breves
-- ("¿qué pasaría si...?", "un estudiante observa que...") para evaluar
-- aplicación, no solo memorización. Ningún distractor depende de
-- estereotipos ni de vocabulario fuera del nivel; los distractores buscan
-- representar errores conceptuales típicos (p. ej. confundir un objeto no
-- vivo con un ser vivo, no distinguir sólido de líquido), no opciones
-- absurdas. `framework_id` y `source_id` quedan NULL (el Currículum Regular
-- no usa `curriculum_frameworks`, mismo motivo documentado en Matemática/
-- Lenguaje). `content_hash` queda NULL, pendiente de cálculo posterior con
-- `computeContentHash` (`lib/data/question-validators.ts`).
--
-- ============================================================================
-- VALIDACIÓN MECÁNICA REALIZADA (por este agente, antes de este commit)
-- ============================================================================
-- Se revisó manualmente cada pregunta contra los criterios de
-- `lib/data/question-validators.ts` (`validateQuestion`): exactamente 4
-- alternativas no vacías y no duplicadas, índice de respuesta válido, sin
-- "todas/ninguna de las anteriores", enunciado con longitud suficiente, y
-- vínculo curricular por (subject, strand, level, short_name) resuelto en
-- tiempo de inserción (nunca id hardcodeado). Se rotó la posición de la
-- respuesta correcta de forma determinística (round-robin 0-1-2-3) dentro de
-- cada objetivo, para evitar el patrón "la respuesta correcta siempre es la
-- alternativa A". No se detectaron duplicados ni casi-duplicados dentro de
-- este archivo.
--
-- ============================================================================
-- IDEMPOTENCIA
-- ============================================================================
-- Mismo patrón que Matemática/Lenguaje: cada INSERT ... SELECT filtra con
-- `where not exists (select 1 from questions q2 where q2.learning_objective_id
-- = lo.id and q2.prompt = v.prompt)`. `learning_objective_id` se resuelve
-- siempre por (subject.name, strand.name, level.code,
-- learning_objective.short_name) -- nunca por id hardcodeado.
--
-- Seed SOLO local: NO se ha ejecutado contra ningún proyecto Supabase (ni
-- dev ni producción). No modifica Supabase por sí solo.

-- ============================================================================
-- EJE: CIENCIAS DE LA VIDA — 1° BÁSICO
-- ============================================================================

-- Objetivo: Características de los seres vivos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de las siguientes opciones corresponde a un ser vivo?', '["Un árbol","Una piedra","Una silla","Un lápiz"]', 0, 'Un árbol es un ser vivo porque nace, crece, se alimenta y se reproduce; los otros objetos no lo son.', 'inicial', 25),
  ('¿Cuál de estas características tienen en común todos los seres vivos?', '["Estar hechos de metal","Nacer, crecer, alimentarse y reproducirse","Tener ruedas","Ser fabricados por personas"]', 1, 'Todos los seres vivos nacen, crecen, se alimentan, se relacionan con el entorno y se reproducen.', 'intermedia', 35),
  ('Observa estos cuatro elementos: un gato, una mesa, un pez y una nube. ¿Cuáles son seres vivos?', '["La mesa y la nube","El gato y la mesa","El gato y el pez","El pez y la nube"]', 2, 'El gato y el pez son seres vivos porque se alimentan, crecen y se reproducen; la mesa y la nube no lo son.', 'intermedia', 35),
  ('Un objeto no necesita alimento, no crece por sí mismo y no se reproduce. ¿A qué categoría pertenece?', '["Ser vivo vegetal","Ser vivo animal","Ser vivo microscópico","Objeto no vivo"]', 3, 'Un objeto que no se alimenta, no crece ni se reproduce corresponde a un objeto no vivo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_1_basico' and lo.short_name = 'Características de los seres vivos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Necesidades básicas de plantas y animales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué necesita una planta para poder crecer sana?', '["Agua, luz y aire","Solo agua","Solo tierra","Ropa y zapatos"]', 0, 'Las plantas necesitan agua, luz y aire, además de nutrientes del suelo, para crecer sanas.', 'inicial', 25),
  ('¿Cuál de estas opciones es una necesidad básica de los animales?', '["Tener un nombre","Alimentarse y respirar","Usar juguetes","Tener un color de pelo"]', 1, 'Los animales necesitan alimentarse, respirar, tomar agua y tener un espacio adecuado para vivir.', 'intermedia', 35),
  ('Si una planta no recibe luz solar durante mucho tiempo, ¿qué es lo más probable que ocurra?', '["Crecerá más rápido","Cambiará de color a azul","Se debilitará y podría morir","No le pasará nada"]', 2, 'Sin luz solar, la planta no puede realizar sus procesos vitales y se debilita, pudiendo morir.', 'intermedia', 35),
  ('Un perro recién adoptado necesita agua, alimento y espacio para moverse. Si no recibe agua por varios días, ¿qué es lo más probable que ocurra?', '["Se pondría más juguetón","Crecería más rápido","No pasaría nada","Su salud se vería gravemente afectada"]', 3, 'El agua es una necesidad básica; sin ella por varios días, la salud del animal se vería gravemente afectada.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_1_basico' and lo.short_name = 'Necesidades básicas de plantas y animales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Partes del cuerpo humano y sus funciones
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué parte del cuerpo usamos principalmente para ver?', '["Los ojos","Los oídos","La nariz","La boca"]', 0, 'Los ojos son el órgano que usamos principalmente para ver.', 'inicial', 25),
  ('¿Cuál es la función principal de las piernas?', '["Escuchar sonidos","Caminar y desplazarnos","Oler los alimentos","Hablar"]', 1, 'Las piernas cumplen la función de caminar y desplazarnos de un lugar a otro.', 'intermedia', 35),
  ('¿Qué parte del cuerpo usamos para escuchar un cuento que nos leen?', '["Los pies","La nariz","Los oídos","Los brazos"]', 2, 'Los oídos son la parte del cuerpo que usamos para escuchar.', 'intermedia', 35),
  ('Un niño se tapa la nariz mientras come algo con mal olor. ¿Qué función del cuerpo está evitando usar?', '["El tacto de las manos","El movimiento de las piernas","La visión de los ojos","El olfato de la nariz"]', 3, 'Al taparse la nariz, el niño evita usar el sentido del olfato.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_1_basico' and lo.short_name = 'Partes del cuerpo humano y sus funciones'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Hábitos de higiene y vida saludable
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias de la Vida. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una acción de higiene diaria?', '["Lavarse las manos antes de comer","Comer sin lavarse las manos","No cepillarse los dientes","Dormir con la ropa de la calle"]', 0, 'Lavarse las manos antes de comer es un hábito de higiene importante para prevenir enfermedades.', 'inicial', 25),
  ('¿Por qué es importante cepillarse los dientes todos los días?', '["Porque lo dice la publicidad","Para cuidar la salud de los dientes y encías","Para que los dientes cambien de color","Porque ocupa mucho tiempo"]', 1, 'Cepillarse los dientes ayuda a prevenir caries y mantener la salud bucal.', 'intermedia', 35),
  ('¿Cuál de estas rutinas ayuda a tener una vida saludable?', '["Comer solo dulces","No dormir nunca","Dormir suficientes horas, comer variado y asearse","Ver pantallas todo el día"]', 2, 'Dormir lo suficiente, alimentarse de forma variada y asearse contribuyen a una vida saludable.', 'intermedia', 35),
  ('Un niño llega de jugar en el patio con las manos sucias antes de almorzar. ¿Qué debería hacer antes de comer?', '["Sentarse a comer de inmediato","Secarse las manos con la ropa","Comer con las manos sucias","Lavarse las manos con agua y jabón"]', 3, 'Antes de comer, se deben lavar las manos con agua y jabón para evitar enfermedades.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Vida' and l.code = 'regular_1_basico' and lo.short_name = 'Hábitos de higiene y vida saludable'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: CIENCIAS FÍSICAS Y QUÍMICAS — 1° BÁSICO
-- ============================================================================

-- Objetivo: Propiedades de los materiales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos materiales es duro?', '["La piedra","La esponja","El algodón","La plastilina blanda"]', 0, 'La piedra es un material duro, a diferencia de la esponja, el algodón o la plastilina blanda.', 'inicial', 25),
  ('¿Qué propiedad tiene una goma elástica cuando la estiras y vuelve a su forma?', '["Dureza","Flexibilidad","Transparencia","Peso"]', 1, 'La flexibilidad permite que un material se estire y regrese a su forma original.', 'intermedia', 35),
  ('¿Cuál de estos materiales tiene una textura suave al tacto?', '["Una lija","Una roca","El algodón","Un clavo"]', 2, 'El algodón tiene una textura suave al tacto, a diferencia de la lija, la roca o el clavo.', 'intermedia', 35),
  ('Quieres construir una torre alta con bloques. ¿Qué propiedad del material es más importante para que la torre no se caiga?', '["El color de los bloques","El olor de los bloques","Que sean transparentes","Que sean rígidos y estables"]', 3, 'Para construir una torre estable, es importante que el material sea rígido y estable.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_1_basico' and lo.short_name = 'Propiedades de los materiales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Estados sólido y líquido de la materia
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos se encuentra en estado líquido?', '["El agua de un vaso","Una piedra","Un lápiz","Una silla"]', 0, 'El agua de un vaso se encuentra en estado líquido porque toma la forma del recipiente.', 'inicial', 25),
  ('¿Qué característica tiene un objeto en estado sólido?', '["Se derrama fácilmente","Mantiene su forma propia","Cambia de forma según el recipiente","No se puede tocar"]', 1, 'Los sólidos mantienen su forma propia, a diferencia de los líquidos.', 'intermedia', 35),
  ('¿Cuál de estos ejemplos corresponde a un material en estado líquido?', '["Un cubo de madera","Una piedra","El jugo en un vaso","Una goma de borrar"]', 2, 'El jugo en un vaso es un ejemplo de material en estado líquido, ya que toma la forma del recipiente.', 'intermedia', 35),
  ('Si viertes agua en un vaso y luego en un plato, ¿qué ocurre con su forma?', '["El agua mantiene siempre la misma forma","El agua desaparece","El agua se transforma en sólido","El agua cambia de forma según el recipiente"]', 3, 'El agua, al ser líquida, cambia de forma según el recipiente que la contiene.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_1_basico' and lo.short_name = 'Estados sólido y líquido de la materia'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Fuentes de luz y de sonido
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos es una fuente de luz?', '["El Sol","Una piedra","Un libro","Una silla"]', 0, 'El Sol es una fuente natural de luz.', 'inicial', 25),
  ('¿Cuál de estos objetos produce sonido al ser golpeado?', '["Una almohada","Una campana","Una manta","Un cojín"]', 1, 'Una campana produce sonido al ser golpeada o agitada.', 'intermedia', 35),
  ('¿Cuál de estas opciones corresponde a una fuente de luz artificial, creada por las personas?', '["El Sol","Una estrella","Una linterna","La Luna"]', 2, 'Una linterna es una fuente de luz artificial, creada por las personas.', 'intermedia', 35),
  ('En una sala oscura, un estudiante enciende una vela y luego toca una campana. ¿Cuáles son, respectivamente, la fuente de luz y la fuente de sonido?', '["La campana y la vela","La vela y la mesa","La sala y la campana","La vela y la campana"]', 3, 'La vela es la fuente de luz y la campana es la fuente de sonido.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_1_basico' and lo.short_name = 'Fuentes de luz y de sonido'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Efecto de la luz sobre los objetos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias Físicas y Químicas. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se forma cuando la luz choca contra un objeto opaco?', '["Una sombra","Un arcoíris","Un sonido","Un olor"]', 0, 'Cuando la luz choca contra un objeto opaco, se forma una sombra detrás de él.', 'inicial', 25),
  ('¿Cuál de estos materiales deja pasar la luz completamente?', '["Una madera gruesa","Un vidrio transparente","Una piedra","Una manta gruesa"]', 1, 'Un vidrio transparente permite que la luz pase completamente a través de él.', 'intermedia', 35),
  ('¿Cuál de estos materiales es translúcido, es decir, deja pasar la luz de forma parcial?', '["Un espejo","Una piedra","Un papel de calcar","Una tapa metálica"]', 2, 'El papel de calcar es translúcido: deja pasar parte de la luz, pero no se ve con claridad a través de él.', 'intermedia', 35),
  ('Un estudiante coloca una piedra frente a una linterna encendida y observa qué pasa detrás de la piedra. ¿Qué es lo más probable que observe?', '["Que la luz atraviese la piedra sin cambios","Que aparezca un color nuevo","Que la piedra emita su propia luz","Que se forme una sombra detrás de la piedra"]', 3, 'Como la piedra es un material opaco, bloquea el paso de la luz y se forma una sombra detrás de ella.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias Físicas y Químicas' and l.code = 'regular_1_basico' and lo.short_name = 'Efecto de la luz sobre los objetos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: CIENCIAS DE LA TIERRA Y EL UNIVERSO — 1° BÁSICO
-- ============================================================================

-- Objetivo: El día y la noche
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué ocurre durante el día?', '["Hay luz solar","Solo se ve la Luna","Siempre está oscuro","No hay luz"]', 0, 'Durante el día hay luz solar porque el Sol ilumina esa parte de la Tierra.', 'inicial', 25),
  ('¿Qué se observa generalmente en el cielo durante la noche?', '["El Sol brillando fuerte","La Luna y las estrellas","El arcoíris","Nubes de tormenta siempre"]', 1, 'Durante la noche se observan generalmente la Luna y las estrellas en el cielo.', 'intermedia', 35),
  ('¿Por qué existen el día y la noche?', '["Porque el Sol se apaga y se enciende","Porque las nubes tapan el Sol","Por el movimiento de la Tierra que gira sobre sí misma","Porque la Luna bloquea el Sol cada noche"]', 2, 'El día y la noche existen porque la Tierra gira sobre sí misma, exponiendo distintas zonas al Sol.', 'intermedia', 35),
  ('Si en tu ciudad es de noche, ¿qué se puede afirmar sobre esa parte de la Tierra en ese momento?', '["Está recibiendo luz solar directa","Es mediodía en ese lugar","El Sol está más cerca de la Tierra","No está orientada hacia el Sol en ese momento"]', 3, 'Cuando es de noche en un lugar, esa parte de la Tierra no está orientada hacia el Sol en ese momento.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_1_basico' and lo.short_name = 'El día y la noche'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: El Sol como fuente de luz y calor
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué nos entrega el Sol además de luz?', '["Calor","Sonido","Agua","Viento"]', 0, 'El Sol nos entrega luz y también calor.', 'inicial', 25),
  ('¿Qué efecto tiene el Sol sobre la ropa mojada que se cuelga afuera?', '["La moja más","Ayuda a secarla","La congela","No tiene ningún efecto"]', 1, 'El calor del Sol ayuda a evaporar el agua y secar la ropa.', 'intermedia', 35),
  ('¿Por qué en un día muy soleado se siente más calor que en un día nublado?', '["Porque hay más viento","Porque hace más frío el Sol","Porque el Sol calienta directamente sin que las nubes lo bloqueen","Porque las nubes producen calor"]', 2, 'En un día soleado, la luz y el calor del Sol llegan de forma más directa, sin ser bloqueados por las nubes.', 'intermedia', 35),
  ('Un estudiante deja dos vasos con agua, uno bajo el Sol y otro en un lugar con sombra, durante toda la mañana. ¿Qué es lo más probable que ocurra?', '["Ambos vasos tendrán la misma temperatura","El vaso en la sombra estará más caliente","No habrá ninguna diferencia entre los vasos","El vaso bajo el Sol estará más caliente que el de la sombra"]', 3, 'El calor del Sol calienta más el agua expuesta directamente a él que el agua que está en la sombra.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_1_basico' and lo.short_name = 'El Sol como fuente de luz y calor'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Cambios del entorno según la estación del año
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Ciencias de la Tierra y el Universo. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué suele ocurrir con muchas plantas durante el otoño?', '["Pierden sus hojas","Florecen todas al mismo tiempo","Crecen más rápido que en verano","No cambian nunca"]', 0, 'Durante el otoño, muchas plantas pierden sus hojas como parte de su ciclo estacional.', 'inicial', 25),
  ('¿Qué tipo de ropa es más adecuada usar durante el invierno?', '["Ropa muy liviana","Ropa abrigada","Traje de baño","Ropa mojada"]', 1, 'Durante el invierno, al hacer más frío, es adecuado usar ropa abrigada.', 'intermedia', 35),
  ('¿Cuál de estos cambios se relaciona con la llegada del verano?', '["Días más cortos y fríos","Caída de nieve constante","Días más largos y calurosos","Oscuridad todo el día"]', 2, 'En verano, los días suelen ser más largos y calurosos.', 'intermedia', 35),
  ('Un estudiante observa que los árboles de su barrio están floreciendo y que hace más calor que antes. ¿En qué estación del año probablemente se encuentra?', '["Invierno","Otoño","Verano avanzado","Primavera"]', 3, 'La floración de árboles y el aumento de la temperatura son característicos de la primavera.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Ciencias de la Tierra y el Universo' and l.code = 'regular_1_basico' and lo.short_name = 'Cambios del entorno según la estación del año'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: HABILIDADES DE INVESTIGACIÓN CIENTÍFICA — 1° BÁSICO
-- ============================================================================

-- Objetivo: Observación guiada del entorno
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Cuando un estudiante mira con atención una hoja para describir su color y forma, ¿qué habilidad científica está usando?', '["Observación","Predicción","Experimentación","Clasificación numérica"]', 0, 'Mirar con atención y describir características es un ejemplo de la habilidad de observación.', 'inicial', 25),
  ('¿Cuál de estas acciones corresponde a una observación guiada por el docente?', '["Inventar un resultado sin mirar nada","Mirar con atención un objeto siguiendo las indicaciones del profesor","Adivinar sin mirar","Copiar lo que dice un compañero"]', 1, 'Una observación guiada implica mirar con atención un objeto o fenómeno siguiendo las indicaciones del docente.', 'intermedia', 35),
  ('El profesor pide observar una planta durante una semana. ¿Qué se debe hacer cada día?', '["Ignorar la planta","Regarla con jugo","Mirarla con atención y notar los cambios","Cambiarla de maceta cada día"]', 2, 'Observar durante varios días implica mirar con atención y notar los cambios que ocurren.', 'intermedia', 35),
  ('Un grupo de estudiantes observa un insecto en el patio y anota que tiene seis patas y alas. ¿Qué tipo de habilidad científica están practicando?', '["Formulación de hipótesis complejas","Comunicación escrita avanzada","Diseño experimental","Observación guiada del entorno"]', 3, 'Mirar con atención un insecto y anotar sus características es un ejemplo de observación guiada del entorno.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_1_basico' and lo.short_name = 'Observación guiada del entorno'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Descripción oral de observaciones
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Después de observar una manzana, ¿qué acción corresponde a describirla oralmente?', '["Decir en voz alta cómo es la manzana (color, forma, tamaño)","Comerse la manzana sin decir nada","Dibujar la manzana en silencio","Guardar la manzana en la mochila"]', 0, 'Describir oralmente significa decir en voz alta las características observadas, como color, forma y tamaño.', 'inicial', 25),
  ('Un estudiante dice: ''La piedra es gris, dura y pesada''. ¿Qué está haciendo?', '["Prediciendo un resultado","Describiendo oralmente lo que observó","Inventando una historia","Haciendo un experimento"]', 1, 'El estudiante está describiendo oralmente las características que observó en la piedra.', 'intermedia', 35),
  ('¿Por qué es importante usar palabras claras al describir oralmente una observación?', '["Para que nadie entienda","Para que la descripción sea más larga","Para que otras personas comprendan lo que se observó","Para terminar rápido"]', 2, 'Usar palabras claras permite que otras personas comprendan lo que se observó.', 'intermedia', 35),
  ('Dos estudiantes observaron la misma flor. Uno dice solo ''es bonita'' y el otro dice que tiene pétalos rojos y un centro amarillo. ¿Cuál descripción es más útil para la ciencia?', '["La de ''es bonita'', porque es más corta","Ambas son igual de útiles","Ninguna es útil","La que describe pétalos rojos y centro amarillo, porque da información concreta"]', 3, 'Una descripción con información concreta y observable es más útil para la ciencia que una opinión general.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_1_basico' and lo.short_name = 'Descripción oral de observaciones'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Registro de observaciones en dibujos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Ciencias Naturales 1° Básico, eje Habilidades de Investigación Científica. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Después de observar una planta, ¿qué acción corresponde a registrar la observación mediante un dibujo?', '["Dibujar la planta tal como se observó","Ignorar lo observado","Contar un cuento distinto","Borrar el cuaderno"]', 0, 'Registrar mediante un dibujo significa representar gráficamente lo que se observó.', 'inicial', 25),
  ('¿Por qué es útil dibujar lo que se observa en una actividad científica?', '["Porque ocupa menos tiempo que hablar","Porque permite guardar un registro visual de la observación","Porque no se necesita mirar el objeto","Porque reemplaza la necesidad de observar"]', 1, 'Dibujar permite guardar un registro visual de lo observado para revisarlo después.', 'intermedia', 35),
  ('Un estudiante dibuja una hoja marcando sus bordes y color. ¿Qué habilidad científica está practicando?', '["Formulación de hipótesis","Diseño de experimentos","Registro de observaciones en dibujos","Análisis estadístico"]', 2, 'Dibujar una hoja marcando sus características observadas es un ejemplo de registro de observaciones en dibujos.', 'intermedia', 35),
  ('Al comparar el dibujo de una planta hecho hace una semana con uno hecho hoy, un estudiante nota que la planta creció. ¿Para qué sirvió en este caso el registro en dibujos?', '["Para decorar el cuaderno","Para reemplazar la observación directa","Para evitar mirar la planta","Para comparar cambios ocurridos en el tiempo"]', 3, 'El registro en dibujos permite comparar cómo cambió la planta a lo largo del tiempo.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Ciencias Naturales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Ciencias Naturales')
    and s.name = 'Habilidades de Investigación Científica' and l.code = 'regular_1_basico' and lo.short_name = 'Registro de observaciones en dibujos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
