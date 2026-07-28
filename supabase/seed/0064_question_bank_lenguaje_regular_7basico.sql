-- Dominio: Contenido y preguntas
-- Banco de preguntas de selección múltiple para Lengua y Literatura,
-- Currículum Regular, 7° Básico (D.S. 614/2013), 4 ejes: Lectura, Escritura,
-- Comunicación Oral, Investigación. 4 preguntas por cada uno de los 17
-- objetivos de aprendizaje ya cargados en
-- supabase/seed/0015_curriculum_lenguaje_regular_7basico_2medio.sql
-- (unit_id + level_id + short_name, NUNCA ids hardcodeados).
--
-- ============================================================================
-- ESTADO EDITORIAL Y DE VALIDACIÓN (léase antes de usar en un ensayo)
-- ============================================================================
-- Todas las preguntas de este archivo quedan:
--   - `review_status = 'borrador'`: ciclo editorial sin revisar. Un
--     administrador humano debe leer, corregir y aprobar cada pregunta desde
--     el panel antes de que pueda usarse.
--   - `validation_status = 'ai_generated_review_required'`: mismo criterio
--     documentado en supabase/seed/0060_question_bank_matematica_regular_
--     7basico.sql -- describe con precisión el origen (generadas por un
--     agente, pendientes de revisión humana), y el trigger
--     `prevent_ai_self_approval` (0023) impide saltarse esa revisión.
--   - `is_active = true`: visibles en el panel administrativo, pero
--     `lib/data/essays.ts` solo toma preguntas con `review_status =
--     'aprobado'` + `validation_status = 'approved_for_exam'` para un ensayo
--     real. ESTAS PREGUNTAS NO SE MUESTRAN A NINGÚN ESTUDIANTE hasta revisión
--     y aprobación humana individual.
--
-- `source_type = 'validapp_original'`: enunciados de redacción ORIGINAL de
-- ValidApp (no citas de MINEDUC ni de terceros), escritos para evaluar el
-- objetivo de aprendizaje correspondiente. `framework_id` queda NULL: el
-- Currículum Regular no usa `curriculum_frameworks` (mismo criterio de 0012).
--
-- ============================================================================
-- ADAPTACIÓN DE FORMATO A LENGUAJE (a diferencia de Matemática)
-- ============================================================================
-- No se fuerza el formato numérico de Matemática. Cada objetivo recibe 4
-- preguntas que cubren ángulos distintos y adecuados al tipo de contenido:
--   1) reconocimiento directo de un concepto o ejemplo,
--   2) aplicación en un fragmento/situación comunicativa breve,
--   3) discriminación de un error conceptual típico o de una opción que NO
--      cumple el criterio pedido (formulada en positivo salvo cuando la
--      propia naturaleza del ítem exige identificar la excepción, en cuyo
--      caso la negación va en mayúscula/resaltada, ver enunciados con "NO"),
--   4) caso de mayor complejidad o análisis más fino.
-- Los fragmentos citados dentro de los enunciados (versos, oraciones,
-- diálogos de ejemplo) son creaciones originales de ValidApp para efectos
-- pedagógicos, no citas de obras literarias reales con derechos de autor.
--
-- ============================================================================
-- content_hash: limitación explícita
-- ============================================================================
-- Igual que en el banco de Matemática: `content_hash` se calcula en
-- TypeScript (`lib/data/question-validators.ts: computeContentHash`) y no se
-- reproduce en SQL puro para evitar hashes no coincidentes con el resto del
-- pipeline. Este archivo se validó localmente con un script Node ad-hoc que
-- replica `validateQuestion`/`computeContentHash`/`textSimilarity` contra las
-- 68 preguntas de este archivo antes de dejarlo en el repo (ver reporte del
-- agente en la conversación); `content_hash` queda NULL, pendiente de
-- poblarse por un proceso posterior antes de entrar al pipeline automático de
-- duplicados.
--
-- ============================================================================
-- IDEMPOTENCIA
-- ============================================================================
-- `questions` no tiene clave natural única. Se resuelve con
-- `where not exists (select 1 from public.questions q2 where
-- q2.learning_objective_id = lo.id and q2.prompt = v.prompt)` en cada
-- INSERT...SELECT: reintentar este script no duplica preguntas ya insertadas.
--
-- Seed SOLO local: no se ha ejecutado contra ningún Supabase (ni local ni
-- remoto).

-- ============================================================================
-- EJE: LECTURA — 7° BÁSICO (5 objetivos x 4 preguntas = 20)
-- ============================================================================
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by, generated_at
)
select
  (select id from public.subjects where name = 'Lengua Castellana y Comunicación'),
  lv.id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'claude-sonnet-5 (validapp-assessments)', now()
from (values
  ('Narrador, tiempo y espacio en textos literarios', 'En el fragmento "Recuerdo aquella tarde de invierno en que mi abuelo me contó la historia, sentados junto al fuego", ¿en qué persona narrativa está contado el relato?', '["Primera persona","Segunda persona","Tercera persona omnisciente","Tercera persona testigo"]', 0, 'El uso de "recuerdo" y "mi abuelo" indica que quien narra participa como personaje de la historia, es decir, narra en primera persona.', 'inicial', 60),
  ('Narrador, tiempo y espacio en textos literarios', 'Un cuento comienza así: "Era una noche de otoño en un pueblo costero de Chile, muchos años antes de que naciera el protagonista". ¿Qué elementos narrativos se reconocen en esta frase?', '["Solo el narrador","Tiempo y espacio","Solo el espacio","Solo el tiempo"]', 1, '"Noche de otoño... muchos años antes" corresponde al tiempo narrativo, y "un pueblo costero de Chile" corresponde al espacio.', 'intermedia', 90),
  ('Narrador, tiempo y espacio en textos literarios', '¿Cuál de las siguientes afirmaciones sobre un narrador en tercera persona omnisciente es correcta?', '["Conoce los pensamientos y sentimientos de todos los personajes","Solo conoce lo que piensa un personaje","Participa como personaje de la historia","Nunca puede describir el espacio en que ocurre la historia"]', 0, 'El narrador omnisciente se caracteriza por conocer y poder relatar los pensamientos y sentimientos de todos los personajes, sin ser parte de la historia.', 'intermedia', 90),
  ('Narrador, tiempo y espacio en textos literarios', 'En una novela, el relato alterna constantemente entre el presente del protagonista adulto y sus recuerdos de infancia en el campo. ¿Qué recurso relacionado con el tiempo narrativo se utiliza en este caso?', '["Narración estrictamente lineal","Analepsis o flashback","Narrador testigo","Diálogo directo"]', 1, 'Volver al pasado desde el presente del relato es un salto temporal hacia atrás, conocido como analepsis o flashback.', 'avanzada', 120),

  ('Hechos y opiniones en textos no literarios', '¿Cuál de las siguientes afirmaciones corresponde a un hecho comprobable?', '["El nuevo parque es el más bonito de la ciudad","El parque fue inaugurado el 3 de marzo de 2024","El parque debería tener más juegos","A mi parecer, el parque necesita más árboles"]', 1, 'Una fecha de inauguración es un dato verificable, a diferencia de las otras opciones, que expresan valoraciones u opiniones personales.', 'inicial', 60),
  ('Hechos y opiniones en textos no literarios', 'Un artículo afirma: "Según cifras del Ministerio de Salud, la cobertura de vacunación llegó al 85% este año, aunque en mi opinión debería exigirse un porcentaje mayor". ¿Qué parte de este enunciado corresponde a una opinión?', '["Según cifras del Ministerio de Salud","La cobertura de vacunación llegó al 85% este año","En mi opinión debería exigirse un porcentaje mayor","Todo el enunciado es un hecho comprobable"]', 2, 'La frase "en mi opinión debería exigirse" expresa una valoración personal del autor, no un dato verificable como el porcentaje citado.', 'intermedia', 90),
  ('Hechos y opiniones en textos no literarios', 'Al evaluar la confiabilidad de una fuente de información, ¿cuál de los siguientes criterios es menos relevante?', '["La actualidad de la información","El prestigio del autor o la institución que la publica","Que el texto esté escrito con un diseño gráfico llamativo","Si el texto cita datos verificables"]', 2, 'El diseño gráfico no aporta información sobre la veracidad o el rigor del contenido; la actualidad, el prestigio del autor y los datos verificables sí son criterios de confiabilidad.', 'intermedia', 90),
  ('Hechos y opiniones en textos no literarios', 'Un sitio web sin autor identificado afirma que cierto alimento cura enfermedades graves, sin citar estudios ni fuentes. ¿Qué debería hacer un lector crítico frente a esta información?', '["Aceptarla porque suena convincente","Compartirla de inmediato en redes sociales","Contrastarla con fuentes confiables antes de darla por válida","Ignorarla solo porque el tema no le interesa"]', 2, 'Ante información sin autor ni respaldo, la actitud crítica correcta es verificarla con fuentes confiables antes de aceptarla o difundirla.', 'avanzada', 120),

  ('Figuras literarias y su función expresiva', 'En el verso "sus ojos eran dos luceros", ¿qué figura literaria se utiliza?', '["Metáfora","Hipérbole","Personificación","Antítesis"]', 0, 'Se identifica una comparación implícita (sin nexo comparativo) entre los ojos y los luceros, lo que corresponde a una metáfora.', 'inicial', 60),
  ('Figuras literarias y su función expresiva', 'La frase "el viento susurraba secretos entre los árboles" es un ejemplo de:', '["Símil","Personificación","Hipérbole","Metáfora"]', 1, 'Atribuir una acción propiamente humana (susurrar) a un elemento no humano (el viento) es una personificación.', 'intermedia', 90),
  ('Figuras literarias y su función expresiva', '¿Cuál de las siguientes opciones es un símil, es decir, una comparación explícita con un nexo comparativo?', '["Sus lágrimas eran ríos","Corría como el viento","El tiempo vuela","La luna sonreía"]', 1, 'El símil requiere un nexo comparativo explícito, como "como": "corría como el viento" cumple esa condición, a diferencia de las otras opciones.', 'intermedia', 90),
  ('Figuras literarias y su función expresiva', 'En el fragmento "lloré mil ríos de dolor, un océano de tristeza", ¿qué figura literaria predomina y cuál es su función expresiva?', '["Personificación, para dar vida a objetos","Hipérbole, para exagerar la intensidad del sentimiento","Símil, para comparar dos elementos con un nexo","Antítesis, para contraponer ideas opuestas"]', 1, 'La exageración desmedida ("mil ríos", "un océano") busca intensificar expresivamente el sentimiento de tristeza, lo que es propio de la hipérbole.', 'avanzada', 120),

  ('Comparación de perspectivas sobre un tema', 'Al comparar dos textos que abordan un mismo tema desde perspectivas distintas, ¿qué se debe identificar en primer lugar?', '["El punto de vista o postura de cada autor","Solo la extensión de cada texto","El tipo de letra utilizado en cada texto","El precio de publicación de cada texto"]', 0, 'Comparar perspectivas exige primero reconocer la postura u opinión que defiende cada autor sobre el tema.', 'inicial', 60),
  ('Comparación de perspectivas sobre un tema', 'Dos columnas de opinión discuten el uso del celular en el aula: una lo defiende como herramienta educativa y otra lo critica por distraer a los estudiantes. ¿Qué estrategia de lectura permite comprender mejor ambas posturas?', '["Leer solo la columna que coincide con la propia opinión","Comparar los argumentos y evidencias que entrega cada autor","Memorizar cada texto sin analizar su contenido","Ignorar los ejemplos que entrega cada autor"]', 1, 'Comprender ambas posturas requiere comparar críticamente los argumentos y evidencias de cada texto, no descartar una de ellas de antemano.', 'intermedia', 90),
  ('Comparación de perspectivas sobre un tema', 'Al comparar dos textos sobre un mismo tema, ¿cuál de las siguientes afirmaciones es incorrecta?', '["Los textos pueden compartir el tema pero diferir en la conclusión","Comparar perspectivas ayuda a formar una opinión más informada","Si dos autores tratan el mismo tema, necesariamente tienen la misma opinión","Cada autor puede usar distinta evidencia para apoyar su postura"]', 2, 'Compartir un tema no implica compartir la opinión sobre él: dos autores pueden analizar el mismo tema y llegar a conclusiones opuestas.', 'intermedia', 90),
  ('Comparación de perspectivas sobre un tema', 'Un texto sostiene que la tecnología mejora el aprendizaje citando estudios internacionales; otro sostiene que lo perjudica, citando testimonios de profesores locales. ¿Qué conclusión es más apropiada tras comparar ambas perspectivas?', '["Una de las dos posturas es falsa por definición","El tema es complejo y la conclusión depende del contexto y del tipo de evidencia usada","Solo la evidencia con estudios internacionales es válida","Los testimonios de profesores no aportan ninguna información relevante"]', 1, 'Ante evidencia distinta y válida en ambos sentidos, lo más razonable es reconocer la complejidad del tema en vez de descartar una de las posturas sin análisis.', 'avanzada', 120),

  ('Interpretación propia apoyada en evidencia textual', 'Formular una interpretación propia de un texto significa:', '["Copiar la opinión del profesor sobre el texto","Dar una opinión sin relación con el contenido del texto","Elaborar una idea propia sustentada en el contenido del texto","Repetir literalmente lo que dice el texto, palabra por palabra"]', 2, 'Interpretar un texto implica construir una idea propia, pero siempre respaldada en evidencia extraída del mismo texto.', 'inicial', 60),
  ('Interpretación propia apoyada en evidencia textual', 'Un estudiante afirma que el protagonista de un cuento actúa por miedo. Para que esta interpretación sea válida, ¿qué debería hacer?', '["Basarse únicamente en su intuición personal","Citar o referirse a pasajes del texto que respalden esa idea","Consultar solo la opinión de sus compañeros","Evitar mencionar el texto en su respuesta"]', 1, 'Una interpretación válida debe apoyarse en evidencia textual concreta (acciones, diálogos, descripciones) que sustente la idea propuesta.', 'intermedia', 90),
  ('Interpretación propia apoyada en evidencia textual', '¿Cuál de las siguientes NO es una interpretación apoyada en evidencia textual?', '["El personaje parece triste porque el texto dice que lloraba en silencio","Creo que el personaje es malo, simplemente no me cae bien","El ambiente es tenso, pues el texto describe silencios prolongados","El final es abierto porque el texto no resuelve el conflicto principal"]', 1, 'Afirmar que un personaje "es malo" solo porque "no cae bien" no cita ni se apoya en ningún elemento del texto, a diferencia de las otras opciones.', 'intermedia', 90),
  ('Interpretación propia apoyada en evidencia textual', 'Al leer un poema ambiguo, dos estudiantes llegan a interpretaciones distintas, pero ambos citan versos del poema para justificarlas. ¿Qué se puede concluir de esta situación?', '["Solo una de las dos interpretaciones puede ser válida","Ambas interpretaciones pueden ser válidas si están fundamentadas en el texto","El poema está mal escrito por permitir varias lecturas","Las interpretaciones son igual de válidas sin importar si se fundamentan o no"]', 1, 'Un texto literario puede admitir más de una interpretación legítima siempre que cada una se apoye en evidencia textual concreta.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación') and name = 'Lectura')
      and name = 'Lectura — 7° Básico'
  )
cross join (select id from public.levels where code = 'regular_7_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: ESCRITURA — 7° BÁSICO (4 objetivos x 4 preguntas = 16)
-- ============================================================================
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by, generated_at
)
select
  (select id from public.subjects where name = 'Lengua Castellana y Comunicación'),
  lv.id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'claude-sonnet-5 (validapp-assessments)', now()
from (values
  ('Textos narrativos y líricos con recursos literarios', '¿Cuál de las siguientes opciones es un recurso literario que se puede aplicar al escribir un cuento?', '["Incorporar metáforas o comparaciones para enriquecer las descripciones","Usar solo oraciones cortas sin ningún propósito expresivo","Evitar cualquier descripción de personajes o ambiente","Escribir el texto completo sin puntuación"]', 0, 'Los recursos literarios como la metáfora enriquecen las descripciones y la expresividad de un texto narrativo o lírico.', 'inicial', 60),
  ('Textos narrativos y líricos con recursos literarios', 'Un estudiante quiere expresar en un poema que el tiempo pasa muy rápido. ¿Cuál de las siguientes opciones usa un recurso literario para lograrlo?', '["El tiempo voló como un suspiro","El tiempo pasó, fueron unos minutos","El tiempo avanzó de forma normal","Pasaron algunos minutos, nada más"]', 0, 'La comparación "voló como un suspiro" es un símil que transmite de forma expresiva la rapidez con la que pasa el tiempo.', 'intermedia', 90),
  ('Textos narrativos y líricos con recursos literarios', '¿Qué elemento NO es propio de un texto narrativo?', '["Personajes que participan en la historia","Un ambiente o espacio donde ocurre la acción","Tesis y contraargumentos sobre un tema","Un conflicto que se desarrolla a lo largo del relato"]', 2, 'La tesis y los contraargumentos son propios de un texto argumentativo, no de un texto narrativo, que se organiza en torno a personajes, ambiente y conflicto.', 'intermedia', 90),
  ('Textos narrativos y líricos con recursos literarios', 'Un estudiante escribe un cuento breve y quiere que el lector sienta la angustia del personaje sin decirlo explícitamente. ¿Qué estrategia sería más adecuada?', '["Describir gestos, sensaciones físicas y el ambiente para sugerir la angustia","Escribir \"el personaje estaba angustiado\" varias veces","Eliminar toda descripción del personaje","Usar únicamente diálogos, sin ninguna descripción"]', 0, 'Sugerir una emoción mediante gestos, sensaciones y ambiente (mostrar en vez de decir) es un recurso propio de la narrativa literaria.', 'avanzada', 120),

  ('Textos argumentativos breves', '¿Cuál es la estructura básica de un texto argumentativo breve?', '["Tesis, argumentos y conclusión","Introducción, nudo y desenlace","Una lista de opiniones sin ningún orden","Título, autor y fecha de publicación"]', 0, 'Un texto argumentativo se organiza en torno a una tesis, los argumentos que la sustentan y una conclusión que la retoma.', 'inicial', 60),
  ('Textos argumentativos breves', 'Un estudiante escribe: "El reciclaje debería ser obligatorio en los colegios, porque reduce la contaminación y enseña hábitos responsables". ¿Qué parte de esta oración corresponde a la tesis?', '["El reciclaje debería ser obligatorio en los colegios","Reduce la contaminación","Enseña hábitos responsables","Toda la oración es un argumento, no una tesis"]', 0, 'La tesis es la idea principal que se defiende; "reduce la contaminación" y "enseña hábitos responsables" son los argumentos que la sustentan.', 'intermedia', 90),
  ('Textos argumentativos breves', '¿Cuál de las siguientes opciones es un argumento válido para apoyar la tesis "se debería fomentar la lectura en el colegio"?', '["Leer mejora la comprensión de textos y amplía el vocabulario","A mí no me gusta leer","Los libros son caros","Algunos estudiantes prefieren ver películas"]', 0, 'Un argumento válido debe aportar una razón relacionada con la tesis; las demás opciones son opiniones personales o datos que no sustentan la tesis.', 'intermedia', 90),
  ('Textos argumentativos breves', 'Al revisar un texto argumentativo breve, un estudiante nota que su conclusión no retoma la tesis planteada al inicio. ¿Qué debería hacer para mejorar el texto?', '["Reescribir la conclusión para que refuerce la tesis con base en los argumentos entregados","Dejarlo igual, ya que no es un problema relevante","Eliminar la tesis inicial del texto","Agregar más argumentos sin relación con el tema"]', 0, 'La conclusión de un texto argumentativo debe retomar y reforzar la tesis a partir de los argumentos presentados, cerrando coherentemente el texto.', 'avanzada', 120),

  ('Proceso de escritura autónomo', '¿Cuál es el orden correcto de las etapas del proceso de escritura?', '["Planificación, escritura, revisión, edición","Revisión, planificación, escritura, edición","Edición, escritura, planificación, revisión","Escritura, edición, planificación, revisión"]', 0, 'El proceso de escritura sigue habitualmente el orden: planificar las ideas, escribir un primer borrador, revisarlo y luego editarlo.', 'inicial', 60),
  ('Proceso de escritura autónomo', 'Durante la etapa de planificación de un texto, ¿qué actividad es más adecuada?', '["Organizar las ideas principales en un esquema o borrador","Corregir la ortografía de las últimas oraciones escritas","Publicar el texto en su versión final","Buscar errores de puntuación en el texto terminado"]', 0, 'La planificación corresponde a organizar y ordenar las ideas antes de escribir, no a corregir un texto ya redactado.', 'intermedia', 90),
  ('Proceso de escritura autónomo', '¿Cuál de las siguientes acciones corresponde a la etapa de revisión, y no a la de planificación inicial?', '["Verificar que las ideas estén ordenadas y sean coherentes","Elegir el tema del texto que se va a escribir","Redactar el primer borrador del texto","Hacer una lluvia de ideas sobre el tema"]', 0, 'Revisar la coherencia y el orden de las ideas ocurre después de tener un borrador escrito, a diferencia de elegir el tema o hacer una lluvia de ideas, propias de la planificación.', 'intermedia', 90),
  ('Proceso de escritura autónomo', 'Un estudiante termina su primer borrador y lo entrega sin revisar. ¿Qué riesgo implica actuar así dentro de un proceso de escritura autónomo?', '["Puede dejar errores de coherencia, cohesión o ideas incompletas sin corregir","Ninguno, el primer borrador siempre corresponde al texto final","El texto mejora automáticamente sin necesidad de revisión","La revisión es un paso opcional que no afecta la calidad del texto"]', 0, 'Omitir la revisión implica no detectar ni corregir errores de coherencia, cohesión o ideas incompletas que suelen aparecer en un primer borrador.', 'avanzada', 120),

  ('Ortografía y gramática crecientes', '¿Cuál de las siguientes palabras está escrita correctamente?', '["Había","Havía","Abía","Havia"]', 0, 'La forma correcta del verbo haber en pretérito imperfecto es "había", con hache inicial y sin uve.', 'inicial', 60),
  ('Ortografía y gramática crecientes', 'En la oración "Los estudiante llegaron temprano", ¿qué error gramatical se observa?', '["Falta de concordancia de número entre el artículo y el sustantivo","Falta de concordancia entre sujeto y verbo","Uso incorrecto de mayúsculas","Falta de punto final en la oración"]', 0, 'El artículo "los" está en plural, pero el sustantivo "estudiante" está en singular; para concordar debería decir "Los estudiantes".', 'intermedia', 90),
  ('Ortografía y gramática crecientes', '¿Cuál de las siguientes oraciones utiliza correctamente la tilde diacrítica en "sé" y "él"?', '["Sé que él vendrá mañana","Se que el vendrá mañana","Sé qué el vendrá mañana","Se qué él vendrá mañana"]', 0, '"Sé" (del verbo saber) y "él" (pronombre personal) llevan tilde diacrítica para distinguirse de "se" (pronombre) y "el" (artículo); solo la primera opción los usa correctamente en ambos casos.', 'intermedia', 90),
  ('Ortografía y gramática crecientes', 'Un estudiante escribe: "Ayer, mi hermano y yo fuimos al cine, sin embargo no había entradas disponibles". ¿Qué error de puntuación debería corregirse?', '["Falta una coma antes de \"sin embargo\"","Sobra la coma que sigue a \"Ayer\"","Falta un punto después de \"cine\"","No hay ningún error de puntuación en la oración"]', 0, 'Los conectores como "sin embargo" que introducen un contraste dentro de una oración deben ir precedidos de una coma.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación') and name = 'Escritura')
      and name = 'Escritura — 7° Básico'
  )
cross join (select id from public.levels where code = 'regular_7_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: COMUNICACIÓN ORAL — 7° BÁSICO (4 objetivos x 4 preguntas = 16)
-- ============================================================================
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by, generated_at
)
select
  (select id from public.subjects where name = 'Lengua Castellana y Comunicación'),
  lv.id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'claude-sonnet-5 (validapp-assessments)', now()
from (values
  ('Exposición oral con apoyo audiovisual', '¿Cuál es la función principal del apoyo audiovisual (diapositivas, imágenes) en una exposición oral?', '["Reforzar y complementar visualmente el contenido expuesto","Reemplazar completamente el discurso del expositor","Distraer al público del tema central de la exposición","Ocupar todo el tiempo disponible de la exposición"]', 0, 'El material audiovisual debe apoyar y complementar la explicación oral del expositor, no reemplazarla ni distraer del contenido.', 'inicial', 60),
  ('Exposición oral con apoyo audiovisual', 'Un estudiante prepara diapositivas con párrafos extensos de texto que planea leer durante toda su exposición. ¿Qué recomendación sería más adecuada?', '["Usar frases breves o imágenes y explicar oralmente el contenido","Mantener el mismo formato, ya que es la mejor estrategia posible","Eliminar completamente el uso de diapositivas","Leer las diapositivas en voz muy baja durante la exposición"]', 0, 'Las diapositivas deben sintetizar ideas clave (frases breves o imágenes) para que el expositor las explique oralmente, en vez de leerlas textualmente.', 'intermedia', 90),
  ('Exposición oral con apoyo audiovisual', '¿Cuál de los siguientes elementos NO es relevante para una buena exposición oral con apoyo audiovisual?', '["El color exacto de la ropa que use el expositor","Mantener contacto visual con el público","La claridad y organización de las ideas expuestas","El uso adecuado del tiempo asignado para la exposición"]', 0, 'El color de la ropa no incide en la calidad de la exposición, a diferencia del contacto visual, la organización de ideas y el manejo del tiempo.', 'intermedia', 90),
  ('Exposición oral con apoyo audiovisual', 'Durante una exposición, a un estudiante se le acaba el tiempo antes de terminar todos sus puntos. ¿Qué estrategia de planificación habría evitado este problema?', '["Ensayar previamente la exposición cronometrando el tiempo por sección","No haber preparado ningún material previo a la exposición","Hablar lo más rápido posible sin haber practicado antes","Improvisar todo el contenido el mismo día de la presentación"]', 0, 'Ensayar y cronometrar cada sección permite ajustar el contenido al tiempo disponible antes de la exposición real.', 'avanzada', 120),

  ('Debates formales con respeto', 'En un debate formal, cuando un participante no está de acuerdo con un argumento, ¿qué actitud es la más adecuada?', '["Esperar su turno y refutar el argumento con respeto y evidencia","Interrumpir gritando al otro participante","Ignorar por completo lo que dice el otro participante","Insultar al participante que sostiene el argumento contrario"]', 0, 'En un debate formal se espera el turno de habla y se refutan los argumentos con evidencia y respeto, sin recurrir a interrupciones ni ataques.', 'inicial', 60),
  ('Debates formales con respeto', 'Un estudiante en un debate dice: "Tu argumento no tiene sentido porque tú siempre dices tonterías". ¿Qué problema tiene esta intervención?', '["Es un ataque personal (falacia ad hominem) que no refuta el argumento","Es un argumento válido y respetuoso hacia el otro participante","Está muy bien fundamentado con evidencia concreta","No tiene ningún problema como intervención en un debate"]', 0, 'Atacar a la persona en vez de responder al argumento es una falacia ad hominem: no aporta evidencia ni refuta el contenido de lo dicho.', 'intermedia', 90),
  ('Debates formales con respeto', '¿Cuál de las siguientes reglas corresponde a un debate formal?', '["Existen turnos de habla y un moderador que los regula","Se puede hablar en cualquier momento sin pedir la palabra","Ganar el debate depende de quién grite más fuerte","No es necesario presentar argumentos, basta con opinar"]', 0, 'Un debate formal se organiza con turnos de habla regulados por un moderador, a diferencia de una discusión espontánea sin reglas.', 'intermedia', 90),
  ('Debates formales con respeto', 'En un debate sobre el uso de uniformes escolares, un participante presenta datos de un estudio y otro solo repite su opinión personal sin evidencia. ¿Qué se puede afirmar sobre la calidad argumentativa de ambas intervenciones?', '["La que presenta evidencia tiene mayor solidez argumentativa","Ambas son igual de válidas porque son solo opiniones personales","La opinión personal siempre resulta más convincente que los datos","Ninguna de las dos intervenciones es válida en un debate formal"]', 0, 'Presentar evidencia (un estudio) otorga mayor solidez argumentativa que repetir una opinión sin ningún respaldo.', 'avanzada', 120),

  ('Escucha crítica de un discurso oral', 'Escuchar críticamente un discurso significa:', '["Analizar el contenido, identificar el punto de vista y evaluar los argumentos","Aceptar todo lo que dice el orador sin cuestionarlo","Distraerse mientras el orador expone su discurso","Memorizar el discurso palabra por palabra"]', 0, 'La escucha crítica implica analizar el contenido, reconocer el punto de vista del orador y evaluar la solidez de sus argumentos.', 'inicial', 60),
  ('Escucha crítica de un discurso oral', 'Mientras escucha un discurso político, un estudiante nota que el orador usa muchos adjetivos emocionales pero pocos datos concretos. ¿Qué debería hacer como oyente crítico?', '["Notar esta estrategia y buscar si existen datos que respalden lo dicho","Aceptar el discurso sin cuestionarlo por ser emotivo","Repetir el discurso completo sin analizar su contenido","Ignorar por completo el contenido del discurso"]', 0, 'Un oyente crítico identifica el uso de un lenguaje emotivo sin respaldo de datos y busca verificar si existe evidencia que sustente lo afirmado.', 'intermedia', 90),
  ('Escucha crítica de un discurso oral', '¿Cuál de las siguientes preguntas ayuda a la escucha crítica de un discurso oral?', '["¿Qué punto de vista defiende el orador y qué evidencia entrega?","¿De qué color es la corbata que usa el orador?","¿Cuánto dura el discurso en minutos exactamente?","¿En qué lugar físico se realizó el discurso?"]', 0, 'Identificar el punto de vista y la evidencia que respalda un discurso es central para una escucha crítica, a diferencia de detalles irrelevantes al contenido.', 'intermedia', 90),
  ('Escucha crítica de un discurso oral', 'Un discurso afirma que "todos están de acuerdo" con una medida, sin citar ninguna fuente ni dato. ¿Qué debilidad argumentativa identifica un oyente crítico?', '["Una generalización sin evidencia que la respalde","Es una afirmación completamente objetiva y verificable","Es un argumento basado en estadísticas confiables","Ninguna, la generalización es siempre una prueba válida"]', 0, 'Afirmar que "todos están de acuerdo" sin citar datos es una generalización no respaldada por evidencia, una debilidad argumentativa frecuente.', 'avanzada', 120),

  ('Registro formal e informal según la situación', '¿En cuál de las siguientes situaciones corresponde usar un registro formal?', '["Presentando un trabajo frente al curso y el profesor","Conversando con amigos durante el recreo","Enviando un mensaje de texto a un amigo cercano","Jugando con compañeros en el patio del colegio"]', 0, 'Presentar un trabajo frente al curso y el profesor es una situación formal que requiere un registro de lengua formal.', 'inicial', 60),
  ('Registro formal e informal según la situación', '¿Cuál de las siguientes expresiones corresponde a un registro informal?', '["¡Oye, préstame el cuaderno un toque!","Buenos días, quisiera solicitar información sobre el trámite","Estimado director, junto con saludar...","Se solicita la presencia de los apoderados el día viernes"]', 0, 'La expresión "¡Oye, préstame el cuaderno un toque!" usa un lenguaje coloquial propio de una conversación informal entre pares.', 'intermedia', 90),
  ('Registro formal e informal según la situación', '¿Cuál de las siguientes situaciones NO requiere necesariamente un registro formal?', '["Una conversación con amigos cercanos durante el recreo","Una entrevista de trabajo","Una conversación con el director del colegio","Una exposición oral frente al curso"]', 0, 'Una conversación entre amigos cercanos suele darse en un contexto informal, a diferencia de una entrevista de trabajo, una conversación con el director o una exposición formal.', 'intermedia', 90),
  ('Registro formal e informal según la situación', 'Un estudiante debe escribir un correo a su profesor para justificar una inasistencia. ¿Cuál de las siguientes opciones usa el registro más adecuado para esta situación?', '["Estimado profesor, le escribo para justificar mi inasistencia del día lunes por motivos de salud","Hola profe, no fui po, disculpe","oiga no pude ir el lunes","Profe disculpe no cache la clase"]', 0, 'Un correo formal dirigido a un profesor requiere un saludo, un propósito claro y un registro formal, como en la primera opción.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación') and name = 'Comunicación Oral')
      and name = 'Comunicación Oral — 7° Básico'
  )
cross join (select id from public.levels where code = 'regular_7_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: INVESTIGACIÓN — 7° BÁSICO (4 objetivos x 4 preguntas = 16)
-- ============================================================================
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, generated_by, generated_at
)
select
  (select id from public.subjects where name = 'Lengua Castellana y Comunicación'),
  lv.id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'claude-sonnet-5 (validapp-assessments)', now()
from (values
  ('Investigación guiada sobre un tema de interés', '¿Cuál es el primer paso al planificar una investigación guiada sobre un tema de interés?', '["Delimitar y definir claramente el tema a investigar","Escribir las conclusiones de la investigación","Presentar los resultados frente al curso","Citar las fuentes que se van a consultar"]', 0, 'Antes de buscar información o citar fuentes, es necesario delimitar y definir con claridad el tema que se investigará.', 'inicial', 60),
  ('Investigación guiada sobre un tema de interés', 'Un estudiante quiere investigar sobre "los animales". ¿Por qué este tema podría ser un problema para una investigación guiada?', '["Porque es un tema demasiado amplio y debería delimitarse, por ejemplo a \"animales en peligro de extinción en Chile\"","Porque los animales no son un tema válido para investigar","Porque no existen fuentes de información sobre animales","Porque no es un tema de interés para los estudiantes"]', 0, 'Un tema tan amplio como "los animales" dificulta una investigación manejable; delimitarlo permite enfocar la búsqueda y el análisis.', 'intermedia', 90),
  ('Investigación guiada sobre un tema de interés', '¿Cuál de las siguientes acciones corresponde a la etapa de planificación de una investigación, y no a la etapa de desarrollo?', '["Definir el tema y los objetivos de la investigación","Redactar el informe final de la investigación","Presentar los resultados al curso","Buscar información en distintas fuentes"]', 0, 'Definir el tema y los objetivos es el primer paso de la planificación, previo a la búsqueda de información, el desarrollo y la presentación de resultados.', 'intermedia', 90),
  ('Investigación guiada sobre un tema de interés', 'Durante una investigación guiada, un estudiante se da cuenta de que el tema elegido es demasiado amplio para el tiempo disponible. ¿Qué estrategia sería más adecuada?', '["Acotar el tema a un aspecto más específico y manejable","Abandonar por completo la investigación","Continuar igual, sin realizar ningún ajuste","Cambiar de tema sin ninguna relación con el original"]', 0, 'Acotar el tema permite mantener el foco y la profundidad de la investigación dentro del tiempo disponible, sin necesidad de abandonarla.', 'avanzada', 120),

  ('Selección y evaluación de fuentes', '¿Cuál de las siguientes es una fuente más confiable para una investigación escolar?', '["Un artículo de una institución académica o gubernamental reconocida","Un blog personal sin autor identificado","Un comentario anónimo publicado en redes sociales","Un meme compartido en internet sin fuente"]', 0, 'Las publicaciones de instituciones académicas o gubernamentales suelen tener mayor rigor y verificabilidad que fuentes anónimas o sin respaldo.', 'inicial', 60),
  ('Selección y evaluación de fuentes', 'Al buscar información sobre el cambio climático, un estudiante encuentra dos fuentes: un estudio publicado por una universidad y una publicación sin autor en un foro. ¿Cuál debería priorizar?', '["El estudio universitario, por su rigor y verificabilidad","El foro, porque su lenguaje es más fácil de leer","Ambas fuentes son igual de confiables para la investigación","Ninguna de las dos; debe usar solo su opinión personal"]', 0, 'Un estudio universitario, con autoría identificable y respaldo institucional, es más confiable que una publicación anónima en un foro.', 'intermedia', 90),
  ('Selección y evaluación de fuentes', '¿Cuál de los siguientes criterios NO es relevante para evaluar la confiabilidad de una fuente digital?', '["El diseño gráfico y los colores del sitio web","La fecha de publicación de la información","La identificación del autor o institución responsable","Si la información puede verificarse en otras fuentes"]', 0, 'El diseño gráfico no determina la confiabilidad de una fuente; sí lo hacen la fecha, la autoría identificable y la posibilidad de verificar los datos.', 'intermedia', 90),
  ('Selección y evaluación de fuentes', 'Un estudiante encuentra información contradictoria entre dos fuentes sobre el mismo tema. ¿Qué debería hacer para evaluar cuál es más confiable?', '["Comparar la fecha, el autor y buscar una tercera fuente que ayude a verificar los datos","Elegir la fuente que le resulte más simpática o fácil de leer","Usar ambas fuentes sin verificar ninguna de las dos","Ignorar el tema por completo ante la contradicción"]', 0, 'Comparar fecha, autoría y contrastar con una tercera fuente permite resolver de forma fundamentada una contradicción entre fuentes.', 'avanzada', 120),

  ('Organización de la información recopilada', '¿Cuál de las siguientes herramientas es útil para organizar la información recopilada en una investigación?', '["Un esquema o mapa conceptual con las ideas principales","Memorizar toda la información sin registrarla por escrito","Mezclar todas las fuentes consultadas sin distinguirlas","Borrar la información a medida que se va recopilando"]', 0, 'Un esquema o mapa conceptual permite ordenar visualmente las ideas principales recopiladas durante la investigación.', 'inicial', 60),
  ('Organización de la información recopilada', 'Después de recopilar información de cinco fuentes distintas sobre un mismo tema, ¿qué estrategia ayuda a organizarla mejor?', '["Clasificar la información en categorías o subtemas relacionados","Copiar y pegar todo el contenido sin ningún orden","Eliminar la información que no se entiende de inmediato","Usar solo una de las cinco fuentes e ignorar las demás"]', 0, 'Clasificar la información en categorías o subtemas facilita su comprensión y uso posterior en el informe o presentación.', 'intermedia', 90),
  ('Organización de la información recopilada', '¿Cuál de las siguientes opciones NO es una forma adecuada de organizar información recopilada?', '["Una lista desordenada de datos sin ninguna relación entre sí","Un resumen con las ideas principales de las fuentes consultadas","Un esquema con categorías y subcategorías","Una tabla comparativa entre distintas fuentes"]', 0, 'Una lista desordenada, sin relación entre los datos, no cumple la función de organizar la información recopilada, a diferencia de un resumen, un esquema o una tabla comparativa.', 'intermedia', 90),
  ('Organización de la información recopilada', 'Un estudiante organiza su información en un esquema, pero nota que algunos datos se repiten en distintas categorías. ¿Qué debería hacer?', '["Revisar el esquema y reubicar o eliminar la información redundante","Dejarlo así, ya que no afecta la calidad de la investigación","Eliminar todo el esquema y comenzar sin ninguna organización","Ignorar la repetición y seguir agregando más datos sin revisar"]', 0, 'Detectar y corregir la información redundante mejora la claridad y precisión del esquema de organización.', 'avanzada', 120),

  ('Comunicación de resultados de una investigación', '¿Cuál de las siguientes es una forma adecuada de comunicar los resultados de una investigación escolar?', '["Un informe escrito con introducción, desarrollo y conclusiones","Guardar los resultados sin compartirlos con nadie","Repetir de memoria todas las fuentes sin explicar el tema","Un comentario espontáneo sin ningún orden ni contenido"]', 0, 'Un informe escrito con introducción, desarrollo y conclusiones es una forma clara y adecuada de comunicar resultados de investigación.', 'inicial', 60),
  ('Comunicación de resultados de una investigación', 'Al presentar los resultados de una investigación frente al curso, ¿qué elemento es más importante incluir?', '["Las conclusiones principales, explicadas de forma clara y ordenada","Solo la lista de fuentes consultadas, sin explicar el tema","Un resumen de una película relacionada con el tema","La opinión de un familiar sobre el tema investigado"]', 0, 'Las conclusiones, explicadas con claridad, son el elemento central que el público necesita comprender al final de una presentación de resultados.', 'intermedia', 90),
  ('Comunicación de resultados de una investigación', '¿Cuál de las siguientes opciones NO corresponde a un formato válido para comunicar resultados de una investigación?', '["Una conversación informal sin ningún contenido de la investigación","Un informe escrito con los resultados de la investigación","Una presentación oral con apoyo visual","Un afiche o infografía con las conclusiones principales"]', 0, 'Una conversación informal sin contenido de la investigación no cumple la función de comunicar resultados, a diferencia de un informe, una presentación o una infografía.', 'intermedia', 90),
  ('Comunicación de resultados de una investigación', 'Un estudiante presenta los resultados de su investigación solo leyendo textualmente todas sus fuentes, sin explicar sus propias conclusiones. ¿Qué debería mejorar?', '["Sintetizar la información y expresar sus propias conclusiones fundamentadas","Nada, la presentación está correctamente realizada","Leer el contenido de las fuentes aún más rápido","Agregar más fuentes a su presentación sin analizarlas"]', 0, 'Comunicar resultados de una investigación implica sintetizar la información y presentar conclusiones propias, no solo leer las fuentes consultadas.', 'avanzada', 120)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación') and name = 'Investigación')
      and name = 'Investigación — 7° Básico'
  )
cross join (select id from public.levels where code = 'regular_7_basico') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );
