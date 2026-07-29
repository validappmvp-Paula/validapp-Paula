-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Historia,
-- Geografía y Ciencias Sociales, 3° Básico. Cubre los 12 objetivos de
-- aprendizaje de 3° Básico cargados por
-- supabase/seed/0021_curriculum_historia_regular_basica_1_6.sql (3 ejes:
-- Historia, Geografía, Formación Ciudadana; 4 objetivos por eje), con 4
-- preguntas por objetivo, total 48 preguntas en este archivo.
--
-- Mismo estado editorial documentado en supabase/seed/0099 (no se repite
-- íntegro aquí): review_status = 'borrador', validation_status =
-- 'ai_generated_review_required', is_active = true, source_type =
-- 'validapp_original', generated_by = 'claude-sonnet-5'.
--
-- NOTA PEDAGÓGICA IMPORTANTE (tema histórico sensible): este archivo incluye
-- los objetivos "Pueblos originarios de Chile: formas de vida", "Llegada de
-- los españoles y proceso de conquista" y "Mestizaje y sincretismo
-- cultural". Las preguntas sobre la conquista se redactaron con tono
-- factual y neutral, apropiado para 3° Básico: describen el proceso (llegada
-- de expedicionarios españoles, fundación de ciudades, resistencia de
-- pueblos originarios como el mapuche) sin glorificar ni demonizar a ningún
-- actor histórico, sin lenguaje gráfico ni valorativo, y reconociendo que
-- este encuentro implicó consecuencias graves para los pueblos originarios
-- (pérdida de tierras y autonomía, conflictos prolongados), ciñéndose a
-- hechos ampliamente documentados y sin emitir juicios de valor sobre
-- pueblos, países o grupos actuales. Se evitó cualquier estereotipo sobre
-- pueblos originarios o sobre España como país actual.

-- ============================================================================
-- EJE: HISTORIA — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas era una forma de vida de algunos pueblos originarios que habitaron el territorio de Chile, como el pueblo mapuche?', '["La agricultura, la caza y la organización en comunidades llamadas lof","Vivir exclusivamente en grandes ciudades con rascacielos","Desplazarse únicamente en avión","Comunicarse solo mediante internet"]', 0, 'La agricultura, la caza y la organización en comunidades (lof) eran parte de la forma de vida de pueblos como el mapuche.', 'inicial', 20),
  ('¿Por qué se dice que existió más de un pueblo originario en el territorio que hoy es Chile?', '["Porque distintos pueblos, como el mapuche, el aymara, el diaguita y el rapa nui, habitaron distintas zonas del territorio, cada uno con su propia forma de vida","Porque un solo pueblo vivió en todo el territorio, sin ninguna diferencia entre zonas","Porque no existió ningún pueblo originario antes de la llegada de los españoles","Porque todos los pueblos originarios tenían exactamente la misma forma de vida"]', 0, 'Existieron distintos pueblos originarios, como el mapuche, el aymara, el diaguita y el rapa nui, cada uno con su propia forma de vida, habitando distintas zonas del territorio.', 'intermedia', 30),
  ('¿Cuál de estas actividades se relaciona con la forma de vida del pueblo diaguita, que habitó el valle del Norte Chico?', '["La agricultura en valles, aprovechando el agua de los ríos","La caza de renos en climas polares","La navegación en grandes barcos oceánicos","La construcción de rascacielos"]', 0, 'La agricultura en valles, aprovechando el agua de los ríos, se relaciona con la forma de vida del pueblo diaguita.', 'intermedia', 35),
  ('Un estudiante investiga que el pueblo aymara, que habita el altiplano del norte de Chile, desarrolló el pastoreo de llamas y alpacas y el cultivo en terrazas adaptadas a la geografía de esa zona. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la forma de vida de un pueblo originario puede estar relacionada con las características geográficas de su territorio","Que todos los pueblos originarios de Chile tenían exactamente la misma forma de vida, sin relación con el territorio","Que el pueblo aymara no tuvo ninguna forma de organización propia","Que la geografía nunca influye en la forma de vida de un pueblo"]', 0, 'Esta información es consistente con la idea de que la forma de vida de un pueblo originario puede estar relacionada con las características geográficas de su territorio, como el altiplano en el caso aymara.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_3_basico' and lo.short_name = 'Pueblos originarios de Chile: formas de vida'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿En qué siglo llegaron los primeros expedicionarios españoles al territorio que hoy es Chile?', '["En el siglo XVI","En el siglo XX","En el siglo X","En el siglo XXV"]', 0, 'Los primeros expedicionarios españoles llegaron al territorio que hoy es Chile en el siglo XVI.', 'inicial', 20),
  ('¿Cuál de estas acciones fue parte del proceso de conquista española del territorio actual de Chile?', '["La fundación de ciudades, como Santiago, por parte de expedicionarios españoles","La construcción de aeropuertos modernos","La creación de internet","La fundación de universidades en el siglo XX"]', 0, 'La fundación de ciudades, como Santiago, por parte de expedicionarios españoles, fue parte del proceso de conquista.', 'intermedia', 30),
  ('¿Por qué se dice que el pueblo mapuche resistió de forma prolongada el avance de la conquista española hacia el sur del territorio?', '["Porque durante mucho tiempo se opuso militarmente al establecimiento de dominio español en su territorio","Porque nunca tuvo ningún contacto con los españoles","Porque aceptó de inmediato y sin ninguna resistencia el dominio español","Porque no existió ningún conflicto entre mapuches y españoles"]', 0, 'El pueblo mapuche resistió de forma prolongada y se opuso militarmente al establecimiento de dominio español en su territorio, durante un largo periodo conocido como la Guerra de Arauco.', 'intermedia', 35),
  ('Un estudiante lee que la llegada de los españoles al territorio de Chile trajo consigo la fundación de ciudades y nuevas formas de organización, pero también significó, para los pueblos originarios, la pérdida de tierras, cambios forzados en su forma de vida y, en algunos casos, epidemias que afectaron gravemente a la población indígena. ¿Qué idea general refleja mejor esta información?', '["Que el proceso de conquista tuvo consecuencias importantes y a la vez graves para los pueblos originarios del territorio","Que el proceso de conquista no tuvo ninguna consecuencia para los pueblos originarios","Que los pueblos originarios se beneficiaron por igual de todo el proceso, sin ninguna consecuencia negativa","Que este proceso histórico no puede analizarse a partir de ninguna evidencia"]', 0, 'Esta información refleja que el proceso de conquista tuvo consecuencias importantes, y a la vez graves, para los pueblos originarios del territorio, un hecho documentado en la historia de Chile.', 'avanzada', 45)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_3_basico' and lo.short_name = 'Llegada de los españoles y proceso de conquista'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Qué se entiende por "mestizaje" en el contexto del encuentro entre españoles y pueblos originarios de América?', '["La mezcla biológica y cultural entre personas de origen español e indígena","La construcción de nuevas ciudades sin ninguna relación con las personas","La desaparición completa de toda cultura indígena","Un tipo de vestimenta usada solo en la actualidad"]', 0, 'El mestizaje se refiere a la mezcla biológica y cultural entre personas de origen español e indígena, ocurrida a partir de la conquista de América.', 'inicial', 20),
  ('¿Cuál de estos es un ejemplo de sincretismo cultural, es decir, la mezcla de elementos de distintas culturas?', '["Una celebración religiosa que combina elementos católicos con tradiciones indígenas locales","Una celebración que no tiene ninguna influencia cultural","Un edificio construido sin ningún estilo arquitectónico","Un plato de comida que no incluye ningún ingrediente"]', 0, 'Una celebración religiosa que combina elementos católicos con tradiciones indígenas locales es un ejemplo de sincretismo cultural.', 'intermedia', 30),
  ('¿Por qué se dice que el mestizaje y el sincretismo cultural son resultado del encuentro entre españoles e indígenas en el proceso de conquista?', '["Porque durante ese proceso se mezclaron personas, costumbres y creencias de ambos orígenes, dando lugar a nuevas expresiones culturales","Porque españoles e indígenas nunca tuvieron ningún contacto entre sí","Porque el mestizaje ocurrió antes de la llegada de los españoles a América","Porque el sincretismo cultural no tiene ninguna relación con la historia"]', 0, 'El mestizaje y el sincretismo cultural surgieron porque, durante el proceso de conquista, se mezclaron personas, costumbres y creencias de origen español e indígena, dando lugar a nuevas expresiones culturales.', 'intermedia', 35),
  ('Un estudiante investiga que muchas palabras del español que se habla en Chile, como algunos nombres de lugares y de alimentos, provienen de lenguas indígenas como el mapudungun o el quechua, y que muchas tradiciones actuales combinan elementos de origen español e indígena. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que la cultura chilena actual refleja, en parte, el mestizaje y el sincretismo cultural ocurridos históricamente","Que la cultura chilena actual no tiene ninguna influencia indígena","Que la cultura chilena actual proviene únicamente de España, sin ninguna influencia indígena","Que el idioma español no tiene ninguna relación con las lenguas indígenas"]', 0, 'Esta información es consistente con la idea de que la cultura chilena actual refleja, en parte, el mestizaje y el sincretismo cultural ocurridos a lo largo de su historia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_3_basico' and lo.short_name = 'Mestizaje y sincretismo cultural'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Historia. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una fuente histórica simple que puede aportar información sobre el pasado?', '["Una fotografía antigua","Un juego de video actual","Una predicción sobre el futuro","Un dibujo imaginario sin ninguna relación con hechos reales"]', 0, 'Una fotografía antigua es una fuente histórica simple que puede aportar información sobre el pasado.', 'inicial', 20),
  ('¿Por qué es útil usar más de una fuente histórica para conocer un hecho del pasado?', '["Porque permite comparar la información y obtener una idea más completa del hecho","Porque una sola fuente siempre da toda la información posible","Porque las fuentes históricas nunca aportan información útil","Porque comparar fuentes hace más difícil entender el pasado"]', 0, 'Usar más de una fuente histórica permite comparar la información y obtener una idea más completa de un hecho del pasado.', 'intermedia', 30),
  ('¿Cuál de estas es una fuente histórica de tipo objeto, útil para conocer la vida cotidiana del pasado?', '["Una herramienta antigua usada para trabajar la tierra","Una noticia publicada hoy en internet","Una opinión personal sin ninguna evidencia","Un dibujo hecho por un estudiante sobre el futuro"]', 0, 'Una herramienta antigua usada para trabajar la tierra es una fuente histórica de tipo objeto, útil para conocer la vida cotidiana del pasado.', 'intermedia', 30),
  ('Un estudiante quiere investigar cómo era la vida en su comunidad hace 100 años. Para esto, revisa fotografías antiguas, entrevista a un adulto mayor sobre lo que recuerda, y observa objetos antiguos guardados en un museo local. ¿Qué habilidad está aplicando el estudiante?', '["Obtener información sobre el pasado a partir de distintas fuentes históricas simples","Inventar una historia sin ninguna base en evidencia","Predecir cómo será la vida en el futuro","Ignorar cualquier fuente de información disponible"]', 0, 'El estudiante está aplicando la habilidad de obtener información sobre el pasado a partir de distintas fuentes históricas simples, como fotografías, testimonios y objetos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Historia' and l.code = 'regular_3_basico' and lo.short_name = 'Uso de fuentes históricas simples'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: GEOGRAFÍA — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una de las grandes zonas geográficas en que se suele dividir Chile?', '["La zona Norte","La zona polar sur del planeta","La zona ecuatorial de África","La zona ártica"]', 0, 'La zona Norte es una de las grandes zonas geográficas en que se suele dividir el territorio de Chile.', 'inicial', 20),
  ('¿Por qué se afirma que Chile tiene una gran diversidad de paisajes a lo largo de su territorio?', '["Porque su extenso territorio incluye desde desiertos hasta glaciares, pasando por bosques y valles","Porque todo el territorio chileno tiene exactamente el mismo paisaje","Porque la diversidad de paisajes no depende de la extensión del territorio","Porque Chile no tiene ninguna variación de clima ni relieve"]', 0, 'Chile tiene una gran diversidad de paisajes porque su extenso territorio incluye desde desiertos hasta glaciares, pasando por bosques y valles.', 'intermedia', 30),
  ('¿Cuál de estas características corresponde a la zona Austral de Chile?', '["Presencia de glaciares, canales y un clima frío","Presencia de un desierto muy seco y cálido","Predominio de valles con clima mediterráneo","Ausencia total de agua en el territorio"]', 0, 'La presencia de glaciares, canales y un clima frío es una característica de la zona Austral de Chile.', 'intermedia', 30),
  ('Un estudiante compara el paisaje de la zona Norte de Chile, con su desierto y escasas lluvias, con el paisaje de la zona Sur, con sus bosques y abundantes lluvias. ¿Qué conclusión es más adecuada a partir de esta comparación?', '["Que las distintas zonas de Chile presentan paisajes y climas muy diferentes entre sí","Que todas las zonas de Chile tienen exactamente el mismo clima","Que el paisaje de Chile no varía según la zona geográfica","Que la zona Norte y la zona Sur tienen paisajes idénticos"]', 0, 'Esta comparación es consistente con la idea de que las distintas zonas de Chile presentan paisajes y climas muy diferentes entre sí.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_3_basico' and lo.short_name = 'Zonas y paisajes de Chile'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos recursos naturales se relaciona con la actividad minera en el norte de Chile?', '["El cobre","El salmón","La madera nativa del sur","El trigo cultivado en el valle central"]', 0, 'El cobre es un recurso natural que se relaciona con la actividad minera desarrollada en el norte de Chile.', 'inicial', 20),
  ('¿Por qué se relacionan los recursos naturales de una zona con las actividades económicas que allí se desarrollan?', '["Porque las personas aprovechan los recursos disponibles en su territorio para generar actividades productivas","Porque las actividades económicas no dependen de los recursos naturales del territorio","Porque todas las zonas de Chile tienen exactamente los mismos recursos naturales","Porque los recursos naturales nunca influyen en la economía de una zona"]', 0, 'Los recursos naturales de una zona se relacionan con sus actividades económicas porque las personas aprovechan los recursos disponibles en su territorio para generar actividades productivas.', 'intermedia', 30),
  ('¿Cuál de estas actividades económicas se relaciona con los recursos forestales de la zona Sur de Chile?', '["La explotación de bosques para la producción de madera","La extracción de cobre en alta montaña","La pesca en aguas polares","El cultivo de cactus en el desierto"]', 0, 'La explotación de bosques para la producción de madera se relaciona con los recursos forestales de la zona Sur de Chile.', 'intermedia', 30),
  ('Un estudiante investiga que, en la zona central de Chile, con suelos fértiles y clima mediterráneo, se desarrolla intensamente la agricultura y la producción de frutas, mientras que en el norte, con suelos ricos en minerales, se desarrolla la minería. ¿Qué conclusión es más adecuada a partir de esta información?', '["Que las actividades económicas de una zona suelen relacionarse con los recursos naturales disponibles en ella","Que las actividades económicas de una zona no tienen ninguna relación con sus recursos naturales","Que la minería y la agricultura se desarrollan exactamente igual en cualquier zona de Chile","Que los recursos naturales de Chile son idénticos en todas sus zonas"]', 0, 'Esta información es consistente con la idea de que las actividades económicas de una zona suelen relacionarse con los recursos naturales disponibles en ella.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_3_basico' and lo.short_name = 'Recursos naturales y actividades económicas asociadas'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos elementos se usa habitualmente en un mapa para representar una ciudad importante?', '["Un punto o símbolo específico, junto con su nombre","Un color elegido al azar sin ningún significado","Un número sin ninguna relación con el lugar","Una palabra escrita en un idioma inventado"]', 0, 'Un punto o símbolo específico, junto con su nombre, se usa habitualmente en un mapa para representar una ciudad importante.', 'inicial', 20),
  ('¿Por qué es útil conocer la simbología de un mapa antes de interpretarlo?', '["Porque permite entender qué representa cada símbolo, color o línea del mapa","Porque la simbología no tiene ninguna relación con la información del mapa","Porque todos los mapas del mundo usan exactamente los mismos símbolos sin explicación","Porque conocer la simbología dificulta la interpretación de un mapa"]', 0, 'Conocer la simbología de un mapa es útil porque permite entender qué representa cada símbolo, color o línea del mapa.', 'intermedia', 30),
  ('En un mapa de Chile, el color azul se usa para representar el mar y los ríos, y una línea punteada para representar los límites entre regiones. ¿Qué función cumple esta simbología cartográfica?', '["Ayudar a interpretar correctamente la información que el mapa representa","Decorar el mapa sin ningún propósito informativo","Reemplazar la necesidad de leer el nombre de los lugares","Confundir a quien observa el mapa"]', 0, 'Esta simbología cartográfica cumple la función de ayudar a interpretar correctamente la información que el mapa representa.', 'intermedia', 35),
  ('Un estudiante usa un mapa de su región para ubicar la capital regional, identificando el símbolo que representa una ciudad y leyendo su nombre junto al símbolo. Luego identifica, gracias al color del mapa, dónde se ubican las zonas montañosas de la región. ¿Qué habilidad está aplicando el estudiante?', '["Utilizar mapas y simbología cartográfica básica para ubicar lugares y elementos geográficos","Describir una costumbre de un pueblo originario","Comparar dos épocas históricas distintas","Explicar una norma de convivencia escolar"]', 0, 'El estudiante está aplicando la habilidad de utilizar mapas y simbología cartográfica básica para ubicar lugares y elementos geográficos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_3_basico' and lo.short_name = 'Uso de mapas y simbología cartográfica básica'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Geografía. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas acciones contribuye al cuidado del entorno natural cercano?', '["Depositar la basura en su lugar correspondiente","Botar basura en un río o parque","Cortar árboles sin ninguna necesidad","Contaminar una fuente de agua cercana"]', 0, 'Depositar la basura en su lugar correspondiente es una acción que contribuye al cuidado del entorno natural cercano.', 'inicial', 20),
  ('¿Por qué es importante que las comunidades propongan acciones para cuidar su entorno natural cercano, como una plaza o un parque?', '["Porque ayuda a mantener ese entorno en buen estado para el beneficio de todos","Porque el entorno natural no requiere ningún cuidado","Porque cuidar el entorno no tiene relación con el bienestar de la comunidad","Porque solo las autoridades deberían preocuparse por el entorno natural"]', 0, 'Es importante proponer acciones de cuidado porque ayudan a mantener el entorno natural cercano en buen estado para el beneficio de toda la comunidad.', 'intermedia', 30),
  ('¿Cuál de estas propuestas es una acción simple para el cuidado del entorno natural cercano a una escuela?', '["Organizar una jornada para regar las plantas y recoger basura del patio","Aumentar la cantidad de basura sin ningún control","Ignorar por completo el estado de las áreas verdes","Eliminar todas las plantas de la escuela"]', 0, 'Organizar una jornada para regar las plantas y recoger basura del patio es una acción simple para el cuidado del entorno natural cercano.', 'intermedia', 30),
  ('Un curso nota que un parque cercano a la escuela tiene basura acumulada y plantas sin cuidado. Deciden organizar, junto a la comunidad, una jornada de limpieza y plantación de árboles nativos. ¿Qué principio están aplicando con esta acción?', '["Proponer y llevar a cabo acciones simples para el cuidado del entorno natural cercano","Ignorar cualquier responsabilidad sobre el entorno natural","Aumentar el deterioro del entorno natural cercano","Trasladar el problema a otra comunidad sin resolverlo"]', 0, 'El curso está aplicando el principio de proponer y llevar a cabo acciones simples para el cuidado del entorno natural cercano.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Geografía' and l.code = 'regular_3_basico' and lo.short_name = 'Cuidado del entorno natural'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);

-- ============================================================================
-- EJE: FORMACIÓN CIUDADANA — 3° BÁSICO
-- ============================================================================

insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estos grupos forma parte de la diversidad cultural presente en Chile?', '["Los pueblos originarios y las comunidades de migrantes","Solo un único grupo cultural, igual en todo el país","Ningún grupo distinto entre sí","Personas que no tienen ninguna cultura"]', 0, 'Los pueblos originarios y las comunidades de migrantes forman parte de la diversidad cultural presente en Chile.', 'inicial', 20),
  ('¿Por qué es importante valorar la diversidad cultural presente en Chile?', '["Porque cada cultura aporta costumbres, conocimientos y tradiciones que enriquecen a la sociedad","Porque una sola cultura debería ser la única aceptada","Porque la diversidad cultural no tiene ningún valor para la sociedad","Porque valorar la diversidad cultural genera más conflictos que beneficios"]', 0, 'Es importante valorar la diversidad cultural porque cada cultura aporta costumbres, conocimientos y tradiciones que enriquecen a la sociedad.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra respeto por la diversidad cultural en una escuela?', '["Celebrar en el colegio tradiciones de distintos pueblos originarios y de comunidades migrantes","Burlarse de las costumbres de un compañero por ser distintas","Aceptar solo una forma de vestir y de hablar como válida","Impedir que se hable de otras culturas en la escuela"]', 0, 'Celebrar en el colegio tradiciones de distintos pueblos originarios y de comunidades migrantes es una forma de mostrar respeto por la diversidad cultural.', 'intermedia', 30),
  ('En un curso conviven estudiantes cuyas familias provienen de pueblos originarios, de otras regiones de Chile y de otros países. La profesora organiza una actividad para que cada estudiante comparta una costumbre de su familia, promoviendo el respeto por todas ellas. ¿Qué valor está fortaleciendo esta actividad?', '["El reconocimiento y valoración de la diversidad cultural presente en Chile","La idea de que solo una cultura es válida en el curso","La comparación de culturas para decidir cuál es superior","El rechazo de las costumbres distintas a las propias"]', 0, 'Esta actividad fortalece el reconocimiento y la valoración de la diversidad cultural presente en Chile.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_3_basico' and lo.short_name = 'Diversidad cultural de Chile'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una autoridad local elegida por votación en una comuna de Chile?', '["El alcalde o alcaldesa","El presidente de otro país","Un profesor de otra escuela","Un vecino elegido al azar sin votación"]', 0, 'El alcalde o alcaldesa es una autoridad local elegida por votación en una comuna de Chile.', 'inicial', 20),
  ('¿Cuál es una función habitual de la municipalidad en una comuna?', '["Administrar servicios locales, como el aseo de calles y algunos espacios públicos","Decidir las leyes de todo el país","Reemplazar al gobierno nacional en todas sus funciones","Fabricar productos para la exportación"]', 0, 'Administrar servicios locales, como el aseo de calles y algunos espacios públicos, es una función habitual de la municipalidad.', 'intermedia', 30),
  ('¿Por qué es importante que los vecinos conozcan a las autoridades e instituciones locales de su comuna?', '["Porque pueden acudir a ellas para plantear necesidades y participar en decisiones locales","Porque las autoridades locales no tienen ninguna relación con los vecinos","Porque conocerlas no aporta ningún beneficio a la comunidad","Porque solo el gobierno nacional puede resolver problemas locales"]', 0, 'Es importante conocer a las autoridades e instituciones locales porque los vecinos pueden acudir a ellas para plantear necesidades y participar en decisiones locales.', 'intermedia', 30),
  ('Un grupo de vecinos, preocupado porque una plaza de su barrio necesita reparaciones, se organiza y presenta su solicitud a la municipalidad, que finalmente destina recursos para arreglar la plaza. ¿Qué muestra esta situación sobre las instituciones y autoridades locales?', '["Que cumplen un rol importante para atender necesidades planteadas por la comunidad","Que no tienen ninguna relación con las necesidades de los vecinos","Que solo actúan sin ninguna solicitud previa de la comunidad","Que las autoridades locales no pueden destinar recursos a ningún proyecto"]', 0, 'Esta situación muestra que las instituciones y autoridades locales cumplen un rol importante para atender necesidades planteadas por la comunidad.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_3_basico' and lo.short_name = 'Instituciones y autoridades locales'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una forma de participar activamente en un trabajo en equipo?', '["Aportar ideas y escuchar las de los demás integrantes del grupo","Imponer siempre la propia opinión sin escuchar a nadie","No decir nada durante todo el trabajo","Trabajar por separado, sin ninguna coordinación con el grupo"]', 0, 'Aportar ideas y escuchar las de los demás integrantes del grupo es una forma de participar activamente en un trabajo en equipo.', 'inicial', 20),
  ('¿Por qué es valioso que, en un trabajo en equipo, se respeten opiniones distintas a la propia?', '["Porque permite considerar distintas ideas y llegar a mejores acuerdos para el grupo","Porque respetar otras opiniones no aporta nada al trabajo","Porque solo una opinión debería considerarse válida en el grupo","Porque las opiniones distintas siempre generan conflictos irresolubles"]', 0, 'Respetar opiniones distintas es valioso porque permite considerar distintas ideas y llegar a mejores acuerdos para el grupo.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra una participación adecuada en actividades grupales?', '["Un estudiante que propone una idea y luego escucha con atención las propuestas de sus compañeros","Un estudiante que impone su idea sin escuchar ninguna otra propuesta","Un estudiante que se queda callado durante toda la actividad","Un estudiante que se burla de las ideas de sus compañeros"]', 0, 'Un estudiante que propone una idea y luego escucha con atención las propuestas de sus compañeros muestra una participación adecuada en actividades grupales.', 'intermedia', 30),
  ('En una actividad grupal, cada integrante del equipo propone una idea para resolver un problema, se escuchan entre todos y finalmente eligen, en conjunto, la idea que consideran mejor para el grupo. ¿Qué principio de participación y trabajo en equipo se aplica en esta situación?', '["Aportar ideas propias y respetar las de los demás para llegar a un acuerdo grupal","Ignorar las ideas de los demás integrantes del equipo","Elegir siempre la idea de una sola persona sin considerar a los demás","Evitar cualquier tipo de acuerdo dentro del grupo"]', 0, 'Esta situación aplica el principio de aportar ideas propias y respetar las de los demás integrantes para llegar a un acuerdo grupal.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_3_basico' and lo.short_name = 'Participación y trabajo en equipo'
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
  'Pregunta ValidApp (borrador), Historia, Geografía y Ciencias Sociales 3° Básico, eje Formación Ciudadana. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 439/2012); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál de estas es una norma de convivencia habitual en un espacio público, como una biblioteca?', '["Mantener un tono de voz bajo para no molestar a otras personas","Gritar libremente sin ninguna consideración por los demás","Comer y ensuciar el espacio sin ningún cuidado","Ignorar por completo las indicaciones del lugar"]', 0, 'Mantener un tono de voz bajo para no molestar a otras personas es una norma de convivencia habitual en una biblioteca.', 'inicial', 20),
  ('¿Por qué las normas de convivencia pueden variar según el espacio en que nos encontramos, como la escuela, la casa o un lugar público?', '["Porque cada espacio tiene un propósito distinto y necesita normas adecuadas a ese propósito","Porque las normas de convivencia son exactamente iguales en todos los espacios","Porque las normas no tienen relación con el tipo de espacio","Porque no es necesario tener normas en ningún espacio"]', 0, 'Las normas de convivencia pueden variar según el espacio porque cada uno tiene un propósito distinto y necesita normas adecuadas a ese propósito.', 'intermedia', 30),
  ('¿Cuál de estas situaciones muestra el cumplimiento de una norma de convivencia en un espacio compartido, como un parque?', '["Recoger la basura propia y depositarla en un basurero","Dejar basura en el suelo del parque","Dañar los juegos infantiles del lugar","Impedir que otras personas usen el espacio"]', 0, 'Recoger la basura propia y depositarla en un basurero es una forma de cumplir una norma de convivencia en un espacio compartido.', 'intermedia', 30),
  ('Una familia visita un parque público y, antes de irse, recoge su basura, cuida los juegos infantiles y respeta a las demás personas que están en el lugar. Al llegar a su casa, siguen normas distintas, como ordenar sus propias cosas. ¿Qué conclusión es más adecuada a partir de esta situación?', '["Que las normas de convivencia se adaptan según el espacio, pero en todos los casos buscan el respeto y el bienestar común","Que las normas de convivencia son exactamente iguales en cualquier espacio","Que en los espacios públicos no es necesario respetar ninguna norma","Que las normas de convivencia solo existen dentro de la casa"]', 0, 'Esta situación es consistente con la idea de que las normas de convivencia se adaptan según el espacio, pero en todos los casos buscan el respeto y el bienestar común.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Estudios Sociales') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Estudios Sociales')
    and s.name = 'Formación Ciudadana' and l.code = 'regular_3_basico' and lo.short_name = 'Normas de convivencia en distintos espacios'
) lo
where not exists (select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt);
