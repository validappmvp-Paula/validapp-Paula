-- Dominio: Contenido y preguntas
-- Banco de preguntas de selección múltiple -- Lengua y Literatura (Lengua
-- Castellana y Comunicación), Currículum Regular, 3° Medio (Formación
-- General), para los 17 objetivos de aprendizaje ya cargados por
-- supabase/seed/0016_curriculum_lenguaje_regular_3_4medio.sql (unit_id +
-- level_id + short_name, NUNCA ids hardcodeados).
--
-- ============================================================================
-- QUÉ CUBRE Y QUÉ NO
-- ============================================================================
-- 4 preguntas de selección múltiple (4 alternativas cada una) por cada uno de
-- los 17 objetivos de 3° Medio = 68 preguntas. Cubre los 4 ejes
-- (Lectura, Escritura, Comunicación Oral, Investigación) de la Formación
-- General de esta banda.
--
-- El contenido evalúa análisis literario, comprensión crítica de textos no
-- literarios, argumentación y retórica, proceso de escritura y revisión,
-- comunicación oral formal/persuasiva, y metodología de investigación --
-- adaptado al tipo de contenido real de 3°-4° Medio en Lengua y Literatura
-- (no se fuerza el formato numérico usado en Matemática). Ninguna pregunta
-- reproduce un texto literario real ni atribuye citas a autores reales: los
-- fragmentos usados como estímulo son breves y de autoría ValidApp, para
-- evitar tanto problemas de derechos de autor como atribuciones inventadas.
--
-- 0016 deja TODOS sus objetivos en `status = 'borrador'` (decreto 193/2019 y
-- nombre de asignatura verificados; texto literal del OA sin verificar línea
-- por línea contra el PDF oficial). Estas preguntas son contenido ORIGINAL
-- ValidApp inspirado en el objetivo tal como está descrito en 0016, no una
-- adaptación de un ítem oficial MINEDUC. `source_type = 'validapp_original'`
-- en todas las filas.
--
-- No agrega lecciones nuevas. No modifica `learning_objectives` (0016 no se
-- toca).
--
-- ============================================================================
-- ESTADO EDITORIAL Y DE VALIDACIÓN -- léase antes de usar en un ensayo
-- ============================================================================
-- Todas las preguntas de este archivo quedan:
--   - `review_status = 'borrador'`: ciclo editorial sin revisar. Un
--     administrador humano debe leer, corregir y aprobar cada pregunta desde
--     el panel antes de que pueda usarse.
--   - `validation_status = 'ai_generated_review_required'` (agregado en
--     supabase/migrations/0023_question_generation_pipeline.sql): describe
--     con precisión el origen real de estas preguntas -- generadas por un
--     agente (`generated_by`/`generated_at` quedan poblados), pendientes de
--     revisión humana. El trigger `prevent_ai_self_approval` (0023) impide
--     que salten directo a un estado de revisión humana sin pasar antes por
--     'automatically_validated'.
--   - `is_active = true`: no están ocultas del panel administrativo, pero
--     `lib/data/essays.ts` (`selectEssayQuestions`) solo toma preguntas con
--     `reviewStatus === 'aprobado'` para un ensayo real, y
--     `lib/data/essay-coverage.ts` exige además
--     `validation_status = 'approved_for_exam'` para el chequeo de
--     publicación. ESTAS PREGUNTAS NO SE MUESTRAN A NINGÚN ESTUDIANTE hasta
--     que un administrador las revise y apruebe una por una (o en lote) desde
--     `/admin`.
--
-- `framework_id` queda NULL: el Currículum Regular no usa
-- `curriculum_frameworks` (mismo criterio documentado en 0011-0016).
--
-- ============================================================================
-- VALIDACIÓN AUTOMÁTICA REAL EJECUTADA ANTES DE ESTE SEED
-- ============================================================================
-- Se ejecutó un script Node (tsx) que importa directamente
-- `lib/data/question-validators.ts` (`validateQuestion`, `computeContentHash`,
-- `textSimilarity`) contra las 68 preguntas de 3° Medio (y también
-- contra las 68 del otro curso de esta misma banda, para detectar
-- duplicados cruzados entre 3° y 4° Medio): 0 errores bloqueantes (respuesta
-- ambigua, alternativas vacías/duplicadas, vínculo curricular roto) y 0
-- duplicados exactos o casi-duplicados (umbral de similitud 0.7, Jaccard
-- sobre bigramas). Se detectaron inicialmente 87 advertencias `length_hint`
-- (heurística blanda: la alternativa correcta más larga/corta que el resto,
-- posible pista) en el conjunto de 3°-4° Medio combinado; se corrigieron a
-- mano los 23 casos más severos (razón de longitud > 2.5x o < 0.4x),
-- alargando distractores demasiado breves o acortando la alternativa
-- correcta cuando correspondía. Quedan advertencias `length_hint` moderadas
-- (razón entre 1.8x y 2.5x) sin corregir en algunas preguntas: son
-- heurísticas de revisión editorial, no errores estructurales, y quedan
-- documentadas para que la revisión pedagógica humana las evalúe caso a
-- caso antes de aprobar cada pregunta.
--
-- ============================================================================
-- CALIDAD DE ÍTEM
-- ============================================================================
-- 4 alternativas por pregunta, una única respuesta correcta, distractores
-- plausibles y no absurdos (errores conceptuales típicos sobre análisis
-- literario, argumentación, proceso de escritura, comunicación oral o
-- investigación -- no alternativas evidentemente falsas). Se evita "todas/
-- ninguna de las anteriores", pistas gramaticales hacia la respuesta,
-- alternativas superpuestas y negaciones innecesarias. Distribución de
-- dificultad por objetivo: 1 inicial + 2 intermedia + 1 avanzada.
--
-- ============================================================================
-- IDEMPOTENCIA
-- ============================================================================
-- Cada bloque por eje resuelve `learning_objective_id` mediante `short_name`
-- + `unit_id` + `level_id` (join, nunca ids hardcodeados). La inserción de
-- cada pregunta individual está protegida por
-- `where not exists (select 1 from public.questions q2 where
-- q2.learning_objective_id = lo.id and q2.prompt = v.prompt)`: reintentar
-- este script no duplica preguntas ya cargadas (idempotencia por
-- learning_objective_id + prompt, no por lote).
--
-- Seed SOLO local: no se ha ejecutado contra ningún Supabase (ni dev ni
-- producción). Requiere que supabase/seed/0016 ya se haya ejecutado antes.

-- ============================================================================
-- EJE: LECTURA — 3° MEDIO (5 objetivos x 4 preguntas = 20)
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
  ('Valor estético y contexto de producción de obras completas', '¿Qué se entiende por "contexto de producción" de una obra literaria?', '["El conjunto de condiciones históricas, sociales y culturales en que fue escrita","El precio de venta de la primera edición","El número de páginas que tiene la obra","El idioma al que fue traducida posteriormente"]', 0, 'El contexto de producción corresponde al marco histórico, social y cultural en el que un autor escribe una obra, e influye en sus temas y su forma.', 'inicial', 45),
  ('Valor estético y contexto de producción de obras completas', 'Una novela ambientada en una dictadura fue escrita mientras regía censura a la prensa. Al relacionar este dato con la obra, un lector está analizando principalmente:', '["La métrica de los versos de la obra","El contexto de producción de la obra","El precio actual del libro en librerías","La cantidad de personajes secundarios"]', 1, 'Vincular las condiciones históricas y políticas en que se escribió una obra con su contenido corresponde al análisis del contexto de producción.', 'intermedia', 60),
  ('Valor estético y contexto de producción de obras completas', '¿Cuál de las siguientes preguntas apunta mejor a evaluar el valor estético de una obra, más allá de su contexto histórico?', '["¿En qué año se publicó la obra?","¿Qué recursos de lenguaje y estructura logran un efecto expresivo particular en el lector?","¿Cuántas ediciones ha tenido el libro?","¿Qué edad tenía el autor al escribirla?"]', 1, 'El valor estético se centra en los recursos formales y expresivos -lenguaje, estructura, imágenes- que la obra despliega, independientemente de datos externos como fecha o tiraje.', 'intermedia', 65),
  ('Valor estético y contexto de producción de obras completas', 'Dos lecturas críticas de una misma novela histórica difieren: una se centra exclusivamente en cómo el lenguaje figurado construye la atmósfera del relato; la otra se centra exclusivamente en investigar los hechos históricos reales detrás de la trama. ¿Qué limitación comparten ambas lecturas si se aplican de forma aislada?', '["Ninguna: ambas son igualmente completas por separado","Cada una descuida una dimensión relevante del análisis literario: la primera el contexto, la segunda el valor estético","Ambas son inválidas porque solo importa la opinión personal del autor","Ambas son idénticas en su enfoque de análisis"]', 1, 'Un análisis literario completo integra tanto el valor estético (recursos formales) como el contexto de producción; centrarse solo en uno deja fuera una dimensión relevante de la obra.', 'avanzada', 90),
  ('Comprensión crítica de ensayos y artículos de opinión', 'En un artículo de opinión, la tesis del autor corresponde a:', '["La idea central que el autor defiende y busca argumentar","El titular llamativo usado para atraer lectores","La lista de fuentes bibliográficas al final del texto","El nombre del medio que publica el artículo"]', 0, 'La tesis es la postura o idea central que el autor sostiene y argumenta a lo largo del texto.', 'inicial', 45),
  ('Comprensión crítica de ensayos y artículos de opinión', 'Un artículo de opinión afirma: "Deberíamos reducir el uso de plástico porque, según datos de organismos internacionales, contamina los océanos durante siglos." ¿Qué función cumple esa referencia en el fragmento?', '["Es un dato decorativo sin ninguna función argumentativa","Funciona como fundamento que respalda la tesis planteada","Es la conclusión final del artículo","Contradice la tesis del propio autor"]', 1, 'Citar una fuente reconocida aporta evidencia que respalda o fundamenta la tesis planteada por el autor.', 'intermedia', 60),
  ('Comprensión crítica de ensayos y artículos de opinión', 'Al leer críticamente un ensayo, identificar si el autor generaliza a partir de un solo caso particular corresponde a evaluar:', '["La ortografía general del texto","La validez de su razonamiento argumentativo","La extensión de cada párrafo","El título elegido para el ensayo"]', 1, 'Detectar generalizaciones apresuradas a partir de un solo caso es parte de evaluar la validez del razonamiento argumentativo de un texto.', 'intermedia', 60),
  ('Comprensión crítica de ensayos y artículos de opinión', 'Un artículo de opinión combina estadísticas verificables con apelaciones emocionales fuertes para defender una política pública. ¿Qué evaluación crítica es más pertinente frente a este texto?', '["Aceptar la conclusión solo porque incluye estadísticas","Rechazar el texto completo por incluir apelaciones emocionales","Distinguir qué parte del argumento se sostiene en evidencia y cuál apela a la emoción, para evaluar su solidez global","Ignorar el texto porque los artículos de opinión no tienen valor argumentativo"]', 2, 'Una lectura crítica distingue los distintos recursos persuasivos usados -evidencia versus apelación emocional- para evaluar la solidez real del argumento, sin descartarlo ni aceptarlo automáticamente.', 'avanzada', 90),
  ('Voz narrativa, punto de vista y recursos estilísticos', 'Cuando un relato es narrado por un personaje que usa la primera persona y participa en los hechos, la voz narrativa corresponde a un:', '["Narrador omnisciente","Narrador protagonista, en primera persona","Narrador testigo en tercera persona","Narrador objetivo o cámara"]', 1, 'Un narrador que usa la primera persona y participa activamente en los hechos es un narrador protagonista.', 'inicial', 45),
  ('Voz narrativa, punto de vista y recursos estilísticos', '"Ana caminó hasta la ventana. No sabía que, en ese mismo instante, su hermano decidía marcharse para siempre." ¿Qué tipo de narrador permite conocer los pensamientos de dos personajes en momentos distintos, como en este fragmento?', '["Narrador omnisciente","Narrador protagonista","Narrador testigo","Narrador que solo describe diálogos"]', 0, 'El narrador omnisciente conoce los pensamientos y acciones de distintos personajes, incluso en momentos que ellos mismos no perciben simultáneamente.', 'intermedia', 60),
  ('Voz narrativa, punto de vista y recursos estilísticos', 'El recurso estilístico que consiste en atribuir cualidades o acciones humanas a seres inanimados o abstractos se denomina:', '["Metáfora","Personificación","Hipérbole","Antítesis"]', 1, 'La personificación atribuye características humanas a elementos no humanos, como "el viento susurraba".', 'intermedia', 55),
  ('Voz narrativa, punto de vista y recursos estilísticos', 'En un cuento, el punto de vista cambia de un narrador en tercera persona que solo describe hechos externos a fragmentos de un diario íntimo en primera persona. ¿Qué efecto es más probable que busque el autor con este cambio?', '["Confundir al lector sin ningún propósito narrativo","Contrastar la mirada externa de los hechos con la interioridad subjetiva del personaje","Indicar que el cuento tiene errores de edición","Eliminar cualquier posibilidad de interpretación del relato"]', 1, 'Alternar puntos de vista suele buscar contrastar la perspectiva externa y objetiva con la interioridad subjetiva de un personaje, enriqueciendo la interpretación del relato.', 'avanzada', 90),
  ('Interpretaciones propias contrastadas con otras', 'Formular una interpretación propia de una obra literaria implica principalmente:', '["Repetir textualmente lo que dice la contratapa del libro","Construir una lectura argumentada y personal, apoyada en evidencia del texto","Memorizar la biografía completa del autor","Aceptar sin cuestionar la primera opinión que se escuche"]', 1, 'Una interpretación propia es una lectura argumentada, basada en evidencia textual, no una repetición de opiniones ajenas ni datos biográficos sueltos.', 'inicial', 45),
  ('Interpretaciones propias contrastadas con otras', 'Un estudiante sostiene que el final de una novela es trágico, mientras que un crítico reconocido lo describe como esperanzador. ¿Qué debería hacer el estudiante para contrastar productivamente ambas lecturas?', '["Descartar automáticamente su propia interpretación por no ser un experto reconocido","Ignorar por completo la interpretación del crítico por no coincidir con la suya","Comparar la evidencia textual que sostiene cada interpretación y evaluar cuál se argumenta mejor","Elegir la interpretación redactada de forma más breve"]', 2, 'Contrastar interpretaciones implica comparar la evidencia y los argumentos que las sostienen, no descartar ni aceptar una automáticamente por autoridad o extensión.', 'intermedia', 65),
  ('Interpretaciones propias contrastadas con otras', '¿Cuál de las siguientes opciones corresponde a una interpretación argumentada sobre un personaje, y no solo a una opinión sin fundamento?', '["\"Ese personaje me cae mal, aunque no sabría explicar bien por qué\"","\"El personaje representa la corrupción del poder, pues traiciona a sus aliados a lo largo de la obra para mantener su cargo\"","\"Ese personaje tiene un nombre poco común, distinto al de otros personajes de la obra\"","\"No entendí bien esa parte del libro, así que prefiero no opinar sobre el personaje\""]', 1, 'Una interpretación argumentada explica una idea sobre el sentido del personaje y la respalda con evidencia concreta de sus acciones en la obra.', 'intermedia', 60),
  ('Interpretaciones propias contrastadas con otras', 'Al escribir un comentario que contrasta la propia interpretación de una obra con la de un crítico especializado, ¿qué estrategia demuestra mayor rigor?', '["Afirmar que la interpretación propia es la única correcta, sin dar razones","Reconocer los puntos de acuerdo y desacuerdo, explicando con evidencia textual por qué se sostiene o se matiza cada postura","Copiar la interpretación del crítico como si fuera propia","Evitar mencionar la interpretación del crítico para no generar conflicto"]', 1, 'El rigor interpretativo exige explicitar acuerdos y desacuerdos, sustentándolos con evidencia del texto, en vez de imponer una postura sin argumentos o evitar el contraste.', 'avanzada', 90),
  ('Pertinencia y validez de argumentos en textos diversos', 'Un argumento es pertinente cuando:', '["Se relaciona directamente con la tesis que pretende sostener","Está escrito con letra de mayor tamaño","Aparece ubicado al final del texto","Usa palabras poco frecuentes en el habla cotidiana"]', 0, 'La pertinencia de un argumento se refiere a que efectivamente aporte a sostener la tesis planteada, no a aspectos de formato o ubicación.', 'inicial', 45),
  ('Pertinencia y validez de argumentos en textos diversos', '"Debemos aprobar esta ley porque quien la propuso es una persona muy simpática." ¿Qué problema presenta este argumento?', '["Es válido porque apela a una cualidad positiva de la persona","Es una falacia: la simpatía de quien propone la ley no es pertinente para evaluar su contenido","Es el mejor tipo de argumento que existe","No presenta ningún problema lógico"]', 1, 'Apelar a una cualidad personal de quien propone una ley, sin referirse a su contenido, es un argumento irrelevante que no aporta evidencia pertinente sobre los efectos de la ley.', 'intermedia', 60),
  ('Pertinencia y validez de argumentos en textos diversos', '¿Cuál de las siguientes opciones constituye un argumento válido y pertinente para defender que "el ejercicio regular mejora la salud cardiovascular"?', '["\"Mi vecino hace ejercicio y es una persona simpática\"","\"Estudios médicos muestran que la actividad física reduce el riesgo de enfermedades cardíacas\"","\"El ejercicio se practica desde la antigüedad\"","\"Muchas personas famosas hacen ejercicio\""]', 1, 'La evidencia de estudios médicos es directamente pertinente para sostener una afirmación sobre salud cardiovascular, a diferencia de datos anecdóticos o irrelevantes.', 'intermedia', 65),
  ('Pertinencia y validez de argumentos en textos diversos', 'Un texto argumentativo razona así: "Si no reciclamos, el planeta se destruirá completamente en pocos años; por lo tanto, debemos reciclar." ¿Qué evaluación crítica corresponde hacer sobre la validez de este argumento?', '["Aceptarlo sin cuestionamientos porque concluye algo positivo","Identificar que exagera las consecuencias, lo que debilita la validez del argumento aunque la conclusión práctica pueda ser razonable","Rechazar por completo la conclusión de reciclar","Ignorar el argumento porque trata sobre medioambiente"]', 1, 'Aunque la conclusión práctica (reciclar) puede ser razonable, el argumento exagera las consecuencias de forma poco sustentada, lo que constituye una debilidad lógica que conviene identificar al evaluar su validez.', 'avanzada', 95)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación') and name = 'Lectura')
      and name = 'Lectura — 3° Medio'
  )
cross join (select id from public.levels where code = 'regular_3_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: ESCRITURA — 3° MEDIO (4 objetivos x 4 preguntas = 16)
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
  ('Ensayo con interpretación personal de una obra', 'En un ensayo literario, la interpretación personal del autor debe:', '["Basarse únicamente en gustos personales, sin evidencia","Estar respaldada con citas o referencias concretas de la obra analizada","Copiar la opinión de un crítico ya reconocido","Evitar mencionar directamente la obra analizada"]', 1, 'Toda interpretación personal en un ensayo literario debe sustentarse con evidencia textual concreta, no solo en gustos o en opiniones ajenas.', 'inicial', 45),
  ('Ensayo con interpretación personal de una obra', '¿Cuál de las siguientes oraciones corresponde mejor a una tesis interpretativa para un ensayo sobre una novela?', '["\"La novela tiene 300 páginas\"","\"En esta novela, el mar simboliza la libertad que el protagonista nunca alcanza\"","\"El autor de la novela nació en 1950\"","\"La novela se vende en varias librerías del país\""]', 1, 'Una tesis interpretativa propone una lectura sobre el sentido de la obra (el simbolismo del mar), a diferencia de datos externos como extensión, biografía o distribución.', 'intermedia', 60),
  ('Ensayo con interpretación personal de una obra', 'Al planificar un ensayo con interpretación personal, ¿qué paso es más pertinente realizar antes de escribir el primer borrador?', '["Elegir la tesis y seleccionar citas de la obra que la respalden","Elegir el tamaño de letra del documento final","Memorizar la obra completa palabra por palabra","Redactar la conclusión antes que cualquier otra parte"]', 0, 'Planificar un ensayo interpretativo requiere definir la tesis y reunir evidencia textual pertinente antes de redactar, para asegurar coherencia argumentativa.', 'intermedia', 65),
  ('Ensayo con interpretación personal de una obra', 'Un ensayo sostiene que un personaje representa la decadencia moral de su época, pero solo incluye una cita aislada sin explicar cómo esa cita respalda la idea. ¿Qué debilidad presenta este ensayo?', '["Ninguna: basta con incluir una cita de la obra para que la interpretación quede demostrada","Falta desarrollar el análisis: explicar cómo la evidencia citada sostiene efectivamente la interpretación propuesta","La tesis planteada es demasiado evidente y no necesita ningún desarrollo adicional","El ensayo está completo tal como está redactado y no requiere ninguna revisión"]', 1, 'Citar evidencia no basta; un ensayo interpretativo sólido debe explicar y argumentar cómo esa evidencia sostiene la tesis, conectando análisis y cita.', 'avanzada', 90),
  ('Textos que combinan distintos propósitos comunicativos', 'Un texto que informa sobre un hecho, pero además narra una anécdota personal y argumenta una postura, combina:', '["Un único propósito comunicativo: solo informar","Distintos propósitos comunicativos: informar, narrar y argumentar","Ningún propósito comunicativo identificable","Solo el propósito de entretener a la audiencia"]', 1, 'Un texto puede combinar varios propósitos comunicativos -informar, narrar, argumentar- según lo que busque lograr en cada parte.', 'inicial', 45),
  ('Textos que combinan distintos propósitos comunicativos', 'Una crónica periodística describe un terremoto, cuenta la experiencia personal de quien la escribe y concluye pidiendo mejoras en la infraestructura. ¿Qué propósitos comunicativos combina?', '["Informar, narrar y argumentar","Únicamente narrar los hechos","Únicamente informar sobre el terremoto","Únicamente describir imágenes del lugar"]', 0, 'La crónica combina información sobre el hecho, narración de la experiencia vivida y un llamado argumentativo final, integrando tres propósitos comunicativos.', 'intermedia', 60),
  ('Textos que combinan distintos propósitos comunicativos', 'Al planificar un texto que combine narrar y argumentar, ¿qué estrategia ayuda a mantener la coherencia entre ambos propósitos?', '["Separar completamente ambas partes sin ninguna conexión temática","Usar la anécdota narrada como evidencia o punto de partida para el argumento posterior","Eliminar la argumentación para simplificar el texto","Repetir la misma anécdota varias veces sin desarrollarla"]', 1, 'Un texto coherente que combina propósitos usa la narración como base o evidencia que conecta con el argumento, en vez de yuxtaponer ambas partes sin relación.', 'intermedia', 65),
  ('Textos que combinan distintos propósitos comunicativos', 'Un estudiante escribe un texto que comienza narrando una experiencia personal, luego informa datos estadísticos sobre el tema y finalmente argumenta una postura, pero cada parte usa un tono y vocabulario completamente distinto, sin transiciones. ¿Qué debería mejorar principalmente?', '["Eliminar dos de los tres propósitos comunicativos presentes","La cohesión y las transiciones entre las partes, para que los distintos propósitos se integren en un texto unificado","Escribir todo el texto en mayúsculas, para que las ideas parezcan más importantes","Reducir el texto a una sola oración que intente resumir todo lo que se quiere decir"]', 1, 'Combinar propósitos comunicativos distintos requiere cohesión y transiciones claras entre las partes, de modo que el texto se perciba como una unidad y no como fragmentos inconexos.', 'avanzada', 90),
  ('Proceso de escritura con foco en la voz propia', 'Que el proceso de escritura sea "recursivo" implica que un autor:', '["Escribe una sola vez y no vuelve a revisar el texto","Planifica, escribe, revisa y reescribe su texto en varias etapas, regresando sobre lo ya escrito","Solo corrige la ortografía al final del proceso","Copia un texto ya existente de otro autor"]', 1, 'Un proceso recursivo de escritura implica volver sobre etapas anteriores (planificación, borrador, revisión) las veces que sea necesario, no un único paso lineal.', 'inicial', 45),
  ('Proceso de escritura con foco en la voz propia', 'Desarrollar una "voz propia" al escribir se refiere principalmente a:', '["Usar siempre las mismas palabras que un autor admirado","Construir un estilo personal reconocible en las elecciones de vocabulario, tono y estructura","Escribir sin ningún criterio personal definido","Copiar literalmente un texto tomado como referencia"]', 1, 'La voz propia es el estilo personal y reconocible de un autor, que se construye a través de decisiones conscientes de vocabulario, tono y estructura.', 'intermedia', 60),
  ('Proceso de escritura con foco en la voz propia', 'Durante la etapa de borrador del proceso de escritura, el foco principal debería estar en:', '["La corrección exhaustiva de la ortografía y la puntuación","Desarrollar y organizar las ideas centrales del texto, aunque no estén perfectamente redactadas","Elegir la tipografía final del documento","Imprimir el texto para su revisión"]', 1, 'El borrador se centra en desarrollar y organizar las ideas; la corrección minuciosa de forma corresponde a etapas posteriores de revisión y edición.', 'intermedia', 60),
  ('Proceso de escritura con foco en la voz propia', 'Un escritor revisa su segundo borrador y nota que su texto suena genérico, como si lo hubiera escrito cualquier persona. ¿Qué acción es más pertinente para fortalecer su voz propia?', '["Copiar frases de un autor famoso para que el texto suene mejor","Revisar sus elecciones léxicas, ejemplos y estructura sintáctica para reflejar su propia perspectiva y estilo","Eliminar todas las opiniones personales del texto","Usar únicamente oraciones muy cortas sin variar el ritmo"]', 1, 'Fortalecer la voz propia implica revisar conscientemente las decisiones de lenguaje y estructura para que reflejen la perspectiva auténtica del autor, no copiar el estilo de otro ni despersonalizar el texto.', 'avanzada', 90),
  ('Revisión con criterios explícitos de calidad', 'Revisar un texto "con criterios explícitos" significa:', '["Leerlo una vez sin ningún propósito definido","Evaluar el texto según aspectos específicos y declarados, como coherencia, cohesión y pertinencia de la evidencia","Pedirle a otra persona que lo lea sin dar ninguna indicación","Cambiar solo el título del texto"]', 1, 'Revisar con criterios explícitos implica evaluar el texto según aspectos concretos y declarados de antemano (coherencia, cohesión, evidencia), no una lectura sin rumbo.', 'inicial', 45),
  ('Revisión con criterios explícitos de calidad', 'Al revisar la cohesión de un texto, un lector debe fijarse principalmente en:', '["El uso de conectores y referencias que enlazan las ideas entre oraciones y párrafos","El color de la tinta usada para escribirlo","La cantidad total de páginas del texto","El tamaño de letra elegido"]', 0, 'La cohesión se refiere a los mecanismos lingüísticos (conectores, pronombres, referencias) que enlazan las ideas dentro del texto.', 'intermedia', 55),
  ('Revisión con criterios explícitos de calidad', 'Un grupo de estudiantes usa una pauta con los criterios "tesis clara", "evidencia pertinente" y "conclusión coherente" para revisar los ensayos de sus compañeros. ¿Qué tipo de revisión están practicando?', '["Una revisión con criterios explícitos y compartidos","Una revisión completamente subjetiva, sin ningún criterio","Una revisión centrada solo en la ortografía","Una revisión que ignora por completo el contenido del texto"]', 0, 'Usar una pauta con criterios definidos y compartidos (tesis, evidencia, conclusión) es un ejemplo de revisión con criterios explícitos.', 'intermedia', 60),
  ('Revisión con criterios explícitos de calidad', 'Al revisar el ensayo de un compañero, un estudiante señala: "tu segundo párrafo no se conecta con tu tesis inicial; falta explicar por qué esta cita respalda tu argumento". ¿Qué criterio de calidad está aplicando principalmente esta observación?', '["La ortografía y la puntuación utilizadas en ese párrafo específico","La pertinencia y el desarrollo de la evidencia en relación con la tesis","La extensión total del párrafo, medida en número de líneas","El uso de mayúsculas en distintas partes del texto"]', 1, 'La observación evalúa si la evidencia citada realmente se conecta y desarrolla en relación con la tesis, lo que corresponde al criterio de pertinencia y desarrollo argumentativo, no a ortografía ni formato.', 'avanzada', 85)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación') and name = 'Escritura')
      and name = 'Escritura — 3° Medio'
  )
cross join (select id from public.levels where code = 'regular_3_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: COMUNICACIÓN ORAL — 3° MEDIO (4 objetivos x 4 preguntas = 16)
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
  ('Presentación oral formal sobre una obra o tema', 'En una presentación oral formal, el registro de habla que corresponde usar es:', '["Coloquial y con muletillas frecuentes","Formal, claro y adecuado a la audiencia académica","Lenguaje escrito leído palabra por palabra, sin ninguna pausa","Con groserías, para captar la atención del público"]', 1, 'Una presentación oral formal exige un registro formal, claro y adecuado al contexto académico, evitando coloquialismos excesivos.', 'inicial', 45),
  ('Presentación oral formal sobre una obra o tema', 'Al planificar una presentación oral sobre una obra literaria, ¿qué elemento es más importante organizar primero?', '["La ropa que se usará ese día, para causar una buena impresión visual","La estructura de las ideas: introducción, desarrollo y cierre con los puntos clave del análisis","El color de las diapositivas de apoyo que acompañarán la exposición","La hora exacta en que comenzará la actividad frente al curso"]', 1, 'Planificar la estructura de las ideas (introducción, desarrollo, cierre) es la base de una presentación oral efectiva, más allá de aspectos estéticos o logísticos.', 'intermedia', 60),
  ('Presentación oral formal sobre una obra o tema', 'Durante una presentación oral, mantener contacto visual con la audiencia y variar la entonación cumple principalmente la función de:', '["Distraer a quienes escuchan la exposición","Mantener el interés del público y reforzar la comprensión del mensaje","Terminar la presentación con mayor rapidez","Ocultar el contenido central de la presentación"]', 1, 'El contacto visual y la variación de entonación son recursos no verbales/paraverbales que ayudan a mantener el interés y reforzar la comprensión del público.', 'intermedia', 60),
  ('Presentación oral formal sobre una obra o tema', 'Un estudiante presenta un análisis oral sobre una novela, pero lee todo el tiempo desde una hoja sin mirar al público ni variar el tono. ¿Qué retroalimentación es más pertinente para mejorar su presentación?', '["Que agregue más páginas a su discurso escrito","Que practique para poder mirar a la audiencia, variar la entonación y depender menos de la lectura literal","Que hable lo más rápido posible","Que elimine por completo la introducción de su presentación"]', 1, 'La retroalimentación pertinente apunta a mejorar los aspectos paraverbales y no verbales (contacto visual, entonación) y la naturalidad, en vez de solo agregar contenido o cambiar la velocidad.', 'avanzada', 90),
  ('Discusiones literarias defendiendo interpretaciones', 'En una discusión literaria, defender una interpretación implica:', '["Repetir en voz alta la misma frase varias veces","Argumentar la propia lectura con evidencia del texto y responder a los argumentos de otros participantes","Imponer la opinión propia sin escuchar a los demás","Cambiar de tema de conversación constantemente"]', 1, 'Defender una interpretación en una discusión literaria requiere argumentar con evidencia y responder de forma pertinente a los argumentos de otros participantes.', 'inicial', 45),
  ('Discusiones literarias defendiendo interpretaciones', 'Durante una discusión literaria, un participante dice: "no estoy de acuerdo, porque en el capítulo 3 el protagonista muestra arrepentimiento, lo que contradice la idea de que es un personaje sin remordimientos". ¿Qué habilidad está demostrando?', '["Cambiar de tema para evitar el conflicto","Refutar con evidencia textual una interpretación distinta a la propia","Repetir la opinión de otro participante","Ignorar por completo el argumento anterior"]', 1, 'El participante refuta la interpretación contraria aportando evidencia concreta de la obra, lo que constituye una defensa argumentada de su propia lectura.', 'intermedia', 65),
  ('Discusiones literarias defendiendo interpretaciones', '¿Cuál de las siguientes actitudes favorece una discusión literaria productiva?', '["Escuchar las interpretaciones de otros y estar dispuesto a matizar la propia si la evidencia lo justifica","Hablar sin escuchar a los demás participantes","Repetir siempre la misma opinión sin considerar contraargumentos","Descalificar a quien sostiene una interpretación distinta"]', 0, 'Una discusión productiva requiere escucha activa y disposición a matizar la propia postura frente a evidencia y argumentos sólidos de otros participantes.', 'intermedia', 60),
  ('Discusiones literarias defendiendo interpretaciones', 'En un debate literario sobre el final de una novela, dos estudiantes sostienen interpretaciones opuestas, ambas con evidencia textual razonable. ¿Cuál es la conclusión más adecuada que el curso podría extraer de esta situación?', '["Una de las dos interpretaciones necesariamente está equivocada","Una obra literaria puede admitir más de una interpretación plausible si cada una se sostiene con evidencia coherente del texto","La discusión carece de valor si no existe una única respuesta correcta","Solo el profesor puede decidir cuál interpretación es válida"]', 1, 'La literatura frecuentemente admite múltiples interpretaciones plausibles; lo relevante es que cada una se sostenga con evidencia y argumentación coherente, no que exista una única respuesta correcta.', 'avanzada', 90),
  ('Análisis crítico de discursos públicos', 'Al analizar críticamente un discurso público, identificar la intención comunicativa de quien habla significa reconocer:', '["El color de la vestimenta que usa","El propósito que busca lograr, como persuadir, informar o movilizar","La duración exacta del discurso en minutos","El lugar físico donde se pronuncia el discurso"]', 1, 'La intención comunicativa corresponde al propósito que el hablante busca lograr con su discurso, como persuadir, informar o movilizar a la audiencia.', 'inicial', 45),
  ('Análisis crítico de discursos públicos', 'En un discurso público, alguien afirma: "todos los que se oponen a esta medida no aman a su país". ¿Qué recurso retórico problemático se está utilizando?', '["Una comparación objetiva y verificable","Una falacia que descalifica a quien piensa distinto en vez de responder a sus argumentos","Una cita textual de una fuente académica","Un dato estadístico verificable"]', 1, 'Descalificar a quienes piensan distinto, en vez de rebatir sus argumentos, es una falacia que debilita la solidez del discurso.', 'intermedia', 65),
  ('Análisis crítico de discursos públicos', 'Al comparar dos discursos sobre el mismo tema, uno que usa datos verificables y otro que solo apela al miedo del público, ¿qué aspecto es clave para evaluar críticamente ambos?', '["Cuál de los dos discursos es más extenso","Qué tipo de recursos usa cada uno para persuadir y qué tan sustentados están en evidencia","Quién de los dos oradores resulta más carismático","El volumen de voz utilizado por cada orador"]', 1, 'Evaluar críticamente un discurso implica analizar qué recursos persuasivos usa (evidencia versus apelación emocional) y su grado de sustento, más allá de la extensión o el carisma del hablante.', 'intermedia', 65),
  ('Análisis crítico de discursos públicos', 'Un discurso público combina cifras oficiales verificables con un llamado emocional final. ¿Qué evaluación crítica es más apropiada frente a este discurso?', '["Rechazar todo el discurso solo por incluir un llamado emocional, sin evaluar la evidencia presentada","Reconocer que la evidencia verificable sustenta parte del argumento, mientras que el llamado emocional busca reforzar la adhesión sin aportar evidencia adicional","Aceptar el discurso completo sin realizar ningún análisis crítico de sus argumentos ni de sus fuentes","Ignorar por completo las cifras presentadas, solo por tratarse de datos de origen oficial"]', 1, 'Un análisis crítico distingue entre los elementos sustentados en evidencia verificable y los recursos emocionales que refuerzan la persuasión sin aportar evidencia adicional, evaluando el discurso de forma matizada.', 'avanzada', 90),
  ('Registro formal en contextos académicos', '¿Cuál de las siguientes expresiones corresponde a un registro formal adecuado para una exposición académica?', '["\"Bueno, o sea, como que el tema es complicado, ¿cachan?\"","\"A continuación, se expondrán los principales argumentos que sustentan esta investigación\"","\"Ya po, esto es súper fome de explicar\"","\"No sé, denle no más\""]', 1, 'La opción que se marca como correcta usa un registro formal, con vocabulario preciso y estructura adecuada al contexto académico; las demás emplean coloquialismos inadecuados para ese contexto.', 'inicial', 50),
  ('Registro formal en contextos académicos', 'Usar un registro formal en un contexto académico implica principalmente:', '["Utilizar un vocabulario amplio de siglas y modismos juveniles","Adecuar el vocabulario, la sintaxis y el tono a las convenciones de la comunidad académica","Hablar en un volumen de voz muy bajo","Evitar por completo el contacto visual con la audiencia"]', 1, 'El registro formal implica ajustar vocabulario, sintaxis y tono a las convenciones esperadas en un contexto académico, no solo un aspecto de volumen o gestualidad.', 'intermedia', 60),
  ('Registro formal en contextos académicos', 'Un estudiante que presenta un trabajo de investigación frente al curso comienza diciendo: "weno, les voy a contar como que de qué se trata mi pega". ¿Qué aspecto debería corregir para adecuarse al registro esperado?', '["Ninguno: el registro es adecuado para cualquier contexto","Reemplazar las expresiones coloquiales por un vocabulario y una estructura más formal, propios del contexto académico","Hablar de forma más rápida","Usar únicamente palabras técnicas sin explicar su significado"]', 1, 'El registro debe ajustarse al contexto académico, reemplazando coloquialismos por un vocabulario y estructura más formal y precisa.', 'intermedia', 65),
  ('Registro formal en contextos académicos', 'Un estudiante debe presentar los mismos resultados de una investigación en dos contextos distintos: una charla informal con compañeros de curso y una defensa formal frente a un jurado académico. ¿Qué es lo más apropiado que debería variar entre ambas presentaciones?', '["El contenido central de los resultados obtenidos, que debería cambiar según la audiencia","El registro, el vocabulario y el grado de formalidad, adecuándolos a cada contexto, sin alterar la validez de los resultados","Nada debería cambiar entre ambos contextos","Únicamente el volumen de la voz utilizado"]', 1, 'Adecuar el registro y la formalidad según el contexto (charla informal versus defensa académica) es una habilidad comunicativa clave, sin que ello implique alterar el contenido o la validez de los resultados presentados.', 'avanzada', 90)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación') and name = 'Comunicación Oral')
      and name = 'Comunicación Oral — 3° Medio'
  )
cross join (select id from public.levels where code = 'regular_3_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

-- ============================================================================
-- EJE: INVESTIGACIÓN — 3° MEDIO (4 objetivos x 4 preguntas = 16)
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
  ('Tema y preguntas de investigación literaria o cultural', 'Una buena pregunta de investigación literaria debe ser, principalmente:', '["Tan amplia que abarque toda la historia de la literatura universal","Delimitada, clara y posible de responder con la evidencia disponible","Imposible de responder con ningún tipo de análisis","Idéntica al título de la obra estudiada"]', 1, 'Una pregunta de investigación efectiva debe estar delimitada y ser respondible con la evidencia disponible, ni demasiado amplia ni imposible de abordar.', 'inicial', 45),
  ('Tema y preguntas de investigación literaria o cultural', '¿Cuál de las siguientes preguntas está mejor delimitada para una investigación escolar sobre un tema cultural?', '["\"¿Qué es la cultura en general, considerando todas sus posibles manifestaciones?\"","\"¿Cómo ha influido la migración reciente en las tradiciones culinarias de una ciudad chilena específica en la última década?\"","\"¿Por qué existe la humanidad y cuál es el sentido último de su historia?\"","\"¿Es buena o mala la cultura en general, sin especificar ningún aspecto concreto?\""]', 1, 'Esta pregunta delimita un tema (migración y tradiciones culinarias), un lugar (una ciudad chilena) y un período (última década), lo que la hace investigable, a diferencia de las preguntas demasiado amplias o filosóficas de las otras opciones.', 'intermedia', 65),
  ('Tema y preguntas de investigación literaria o cultural', 'Al transformar un tema amplio como "la poesía chilena" en una pregunta de investigación viable, ¿qué paso es más adecuado seguir?', '["Mantener el tema tan amplio como sea posible","Acotar el tema a un aspecto específico, como un movimiento poético, autor o período determinado","Elegir un tema completamente distinto, sin relación con la literatura","Evitar formular cualquier pregunta y solo copiar información"]', 1, 'Acotar un tema amplio a un aspecto específico (movimiento, autor, período) permite formular una pregunta de investigación viable y manejable.', 'intermedia', 60),
  ('Tema y preguntas de investigación literaria o cultural', 'Un estudiante propone investigar cómo influyó el exilio en la obra de un grupo de escritores latinoamericanos durante un período histórico específico. ¿Qué característica de esta pregunta la hace apropiada para una investigación literaria o cultural?', '["Es demasiado vaga para poder investigarse con el tiempo y los recursos disponibles","Combina un fenómeno histórico-cultural delimitado con su relación específica con un corpus literario acotado, permitiendo un análisis fundamentado","No tiene ninguna relación real con la literatura ni con el análisis de obras concretas","Solo puede responderse a partir de opiniones personales, sin ningún respaldo en evidencia o fuentes"]', 1, 'La pregunta articula un fenómeno cultural delimitado (el exilio en un período específico) con su impacto en un corpus literario acotado, lo que permite un análisis investigativo fundamentado en fuentes.', 'avanzada', 90),
  ('Búsqueda y evaluación de fuentes especializadas', 'Una fuente especializada y confiable para una investigación académica se caracteriza principalmente por:', '["Ser anónima y sin ninguna referencia verificable","Provenir de autores o instituciones con reconocimiento en el área y estar respaldada por evidencia","Ser el primer resultado que aparece en un buscador","Tener un diseño llamativo, con muchos colores y animaciones"]', 1, 'Una fuente confiable proviene de autores o instituciones reconocidas en el área, con evidencia y respaldo verificable, no simplemente por su popularidad o formato.', 'inicial', 45),
  ('Búsqueda y evaluación de fuentes especializadas', 'Al evaluar una fuente encontrada en internet para una investigación literaria, ¿cuál de los siguientes criterios es más relevante?', '["La cantidad de anuncios publicitarios en la página","La autoría, la fecha de publicación y si la información está respaldada por evidencia o referencias verificables","El color del diseño del sitio web","La cantidad de reacciones que tiene la publicación en redes sociales"]', 1, 'Evaluar autoría, fecha y respaldo evidencial son criterios centrales para determinar la confiabilidad de una fuente, a diferencia de aspectos estéticos o de popularidad.', 'intermedia', 60),
  ('Búsqueda y evaluación de fuentes especializadas', 'Un estudiante encuentra dos fuentes sobre el mismo autor: un artículo académico revisado por pares y una entrada de un blog personal sin referencias. Para una investigación rigurosa, ¿qué debería hacer?', '["Usar solo el blog porque resulta más fácil de leer","Priorizar el artículo académico revisado por pares como fuente principal, y usar el blog con precaución, si acaso, como complemento","Usar ambas fuentes exactamente de la misma manera, sin ninguna distinción","Descartar ambas fuentes sin evaluarlas"]', 1, 'Un artículo revisado por pares ofrece mayor respaldo y confiabilidad que un blog sin referencias, por lo que debe priorizarse en una investigación rigurosa.', 'intermedia', 65),
  ('Búsqueda y evaluación de fuentes especializadas', 'Al buscar fuentes sobre un movimiento literario, un estudiante encuentra información contradictoria entre dos autores especializados. ¿Qué estrategia de investigación es más adecuada frente a esta situación?', '["Elegir al azar una de las dos fuentes, sin más análisis","Contrastar ambas posturas, identificar en qué se basan sus argumentos y explicitar en el trabajo que existe un debate académico al respecto","Ignorar el tema por completo debido a la contradicción","Combinar ambas fuentes sin mencionar que existe una discrepancia entre ellas"]', 1, 'Frente a fuentes especializadas contradictorias, lo riguroso es contrastar los argumentos de cada una y explicitar el debate existente, en vez de elegir arbitrariamente o silenciar la discrepancia.', 'avanzada', 90),
  ('Organización de la información evitando el plagio', 'Citar correctamente una fuente en un trabajo de investigación sirve principalmente para:', '["Aumentar artificialmente la extensión del texto","Reconocer la autoría original de las ideas y evitar el plagio","Confundir al lector sobre el origen real de la información","Cumplir un requisito formal sin ningún propósito real"]', 1, 'Citar correctamente reconoce la autoría original de las ideas utilizadas y evita presentar como propio el trabajo de otra persona, es decir, evita el plagio.', 'inicial', 45),
  ('Organización de la información evitando el plagio', 'Un estudiante copia un párrafo completo de un artículo académico y lo incluye en su ensayo sin comillas ni referencia, aunque cambia algunas palabras sueltas. ¿Qué está cometiendo?', '["Una correcta paráfrasis del texto original","Plagio, porque no reconoce la fuente original de las ideas ni el texto casi literal utilizado","Una cita textual perfectamente válida","Un resumen adecuado del texto original"]', 1, 'Copiar un texto casi literal sin comillas ni referencia, aunque se cambien algunas palabras, constituye plagio, ya que no reconoce la autoría original.', 'intermedia', 65),
  ('Organización de la información evitando el plagio', '¿Cuál de las siguientes acciones corresponde a una paráfrasis adecuada de una fuente, sin incurrir en plagio?', '["Copiar el texto original palabra por palabra sin ninguna referencia","Reformular la idea con las propias palabras del estudiante, manteniendo el sentido original, y citando la fuente","Cambiar solo una o dos palabras del texto original, sin citar la fuente","Presentar la idea como si fuera completamente propia, sin ninguna referencia"]', 1, 'Una paráfrasis adecuada reformula la idea con palabras propias, manteniendo el sentido original, y siempre cita la fuente de la que proviene la idea.', 'intermedia', 65),
  ('Organización de la información evitando el plagio', 'Un estudiante organiza su investigación integrando ideas de tres fuentes distintas en un texto propio, distinguiendo claramente cuáles ideas provienen de cada autor mediante citas y referencias, y agregando su propio análisis conector. ¿Qué demuestra esta forma de organizar la información?', '["Un plagio disimulado, por usar ideas de otros autores","Un manejo riguroso de fuentes, que evita el plagio al distinguir claramente la autoría de cada idea y aportar análisis propio","Una copia literal de las tres fuentes consultadas","Una falta de originalidad, sin ningún mérito académico"]', 1, 'Integrar ideas de múltiples fuentes con atribución clara y aportar análisis propio es precisamente la forma correcta de organizar información evitando el plagio, no una falta de originalidad.', 'avanzada', 90),
  ('Comunicación de resultados en formato académico simple', 'Un informe de investigación en formato académico simple debe incluir, como mínimo:', '["Solo una lista de fuentes, sin ningún desarrollo","Una introducción con el tema y la pregunta, un desarrollo con los hallazgos y una conclusión","Únicamente imágenes, sin texto","Solo la opinión personal de quien investiga, sin ninguna evidencia"]', 1, 'Un informe académico simple requiere al menos introducción (tema y pregunta), desarrollo (hallazgos con evidencia) y conclusión, no solo una lista de fuentes u opiniones sin sustento.', 'inicial', 45),
  ('Comunicación de resultados en formato académico simple', 'Al comunicar los resultados de una investigación sobre un tema cultural, ¿qué elemento es imprescindible incluir para dar sustento a las afirmaciones?', '["Las referencias a las fuentes consultadas","Un dibujo decorativo en cada página del informe","El horario exacto en que se realizó la investigación","La cantidad de borradores que se escribieron"]', 0, 'Las referencias a las fuentes consultadas son imprescindibles para sustentar académicamente las afirmaciones presentadas en el informe.', 'intermedia', 55),
  ('Comunicación de resultados en formato académico simple', 'Un estudiante presenta sus resultados de investigación mezclando hallazgos con opiniones personales, sin distinguir cuáles son cuáles. ¿Qué debería mejorar para lograr un formato académico adecuado?', '["Eliminar por completo su propio análisis, dejando solo los datos recopilados","Distinguir claramente los hallazgos respaldados por evidencia de las interpretaciones u opiniones personales de quien investiga","Agregar aún más opiniones personales al informe, sin aportar ninguna evidencia adicional","No es necesario realizar ningún cambio, porque el informe ya está bien organizado"]', 1, 'Un formato académico adecuado distingue claramente entre los hallazgos respaldados por evidencia y las interpretaciones u opiniones de quien investiga, sin eliminar el análisis propio ni confundir ambos planos.', 'intermedia', 65),
  ('Comunicación de resultados en formato académico simple', 'Al redactar la conclusión de un informe de investigación, ¿qué característica debe tener para ser coherente con el resto del trabajo?', '["Presentar hallazgos completamente nuevos que no fueron desarrollados antes en el informe","Sintetizar los hallazgos principales en relación directa con la pregunta de investigación planteada al inicio","Repetir textualmente la introducción, sin ningún cambio","Ser más extensa que el desarrollo completo del informe"]', 1, 'Una conclusión coherente sintetiza los hallazgos ya desarrollados en el informe, respondiendo directamente a la pregunta de investigación planteada al inicio, sin introducir información nueva no trabajada previamente.', 'avanzada', 90)
) as v(short_name, prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
join public.learning_objectives lo
  on lo.short_name = v.short_name
  and lo.unit_id = (
    select id from public.units
    where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Lengua Castellana y Comunicación') and name = 'Investigación')
      and name = 'Investigación — 3° Medio'
  )
cross join (select id from public.levels where code = 'regular_3_medio') as lv
where lo.level_id = lv.id
  and not exists (
    select 1 from public.questions q2
    where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
  );

