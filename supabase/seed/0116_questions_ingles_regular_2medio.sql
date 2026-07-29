-- Dominio: Contenido y preguntas
-- Banco de preguntas (selección múltiple) para Currículum Regular, Idioma
-- Extranjero: Inglés, 2° Medio. Cubre los 16 objetivos de aprendizaje de 2°
-- Medio cargados por
-- supabase/seed/0024_curriculum_ingles_regular_7basico_2medio.sql (4 ejes:
-- Comprensión Auditiva, Comprensión Lectora, Expresión Oral, Expresión
-- Escrita), con 4 preguntas por objetivo, total 64 preguntas en este
-- archivo.
--
-- Mismo estado editorial, criterio de idioma (ver encabezado completo de
-- supabase/seed/0113_questions_ingles_regular_7basico.sql), fuente,
-- validación mecánica e idempotencia que 0111-0115. `source` cita Decreto
-- Supremo N.° 614/2013 (esta banda cierra en 2° Medio, nivel B1 alto). Seed
-- SOLO local: no se ha ejecutado contra Supabase.

-- ============================================================================
-- EJE: COMPRENSIÓN AUDITIVA — 2° MEDIO
-- ============================================================================

-- Objetivo: Comprensión crítica de discursos sobre temas sociales
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''Income inequality remains one of the most pressing social issues of our time, affecting access to education and healthcare.'' What social issue is being discussed?', '["Income inequality and its effects on education and healthcare","A sports competition","A cooking technique","A weather phenomenon"]', 0, 'The discourse discusses income inequality and its effects on education and healthcare.', 'inicial', 25),
  ('Escuchas un discurso sobre la brecha digital entre zonas urbanas y rurales. ¿Qué tema social se está abordando?', '["Un tema de gastronomía","La desigualdad de acceso a la tecnología entre zonas urbanas y rurales","Un tema histórico antiguo","Un tema puramente deportivo"]', 1, 'El discurso aborda la desigualdad de acceso a la tecnología entre zonas urbanas y rurales.', 'intermedia', 30),
  ('Listen: ''While some praise globalization for economic growth, others criticize it for widening social inequalities between countries.'' What critical perspective is presented in this discourse?', '["Only positive views on globalization","Only negative views on globalization","Both positive and critical views on globalization","No opinion on globalization at all"]', 2, 'El discurso presenta tanto una visión positiva (crecimiento económico) como una crítica (desigualdad), reflejando un análisis crítico equilibrado.', 'intermedia', 30),
  ('Listen critically: ''Some argue that automation threatens jobs, but historically, technological change has also created new types of employment, even if the transition can be difficult for some workers.'' What critical nuance does this discourse present about automation and employment?', '["Que la automatización solo destruye empleos, sin ningún matiz","Que la automatización no tiene ningún efecto en el empleo","Que, aunque la automatización puede amenazar empleos, también históricamente ha creado nuevos, aunque la transición sea difícil para algunos","Que todos los trabajadores se benefician igualmente de la automatización"]', 2, 'El discurso presenta un análisis crítico y matizado: reconoce la amenaza pero también la creación histórica de empleo, con dificultad para algunos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_2_medio' and lo.short_name = 'Comprensión crítica de discursos sobre temas sociales'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Identificación de la postura del hablante frente a un tema
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''I firmly believe that renewable energy is the only sustainable path forward for our planet.'' What is the speaker''s position?', '["In favor of renewable energy as the sustainable path forward","Against renewable energy","Neutral about energy sources","Undecided about the topic"]', 0, 'El hablante expresa claramente una postura a favor de la energía renovable.', 'inicial', 25),
  ('Escuchas: ''Personalmente, no estoy de acuerdo con que se elimine el examen final; creo que es una herramienta útil de evaluación.'' ¿Cuál es la postura del hablante?', '["A favor de eliminar el examen final","En contra de eliminar el examen final","Sin ninguna opinión al respecto","A favor de eliminar todas las evaluaciones"]', 1, 'El hablante expresa estar en contra de eliminar el examen final.', 'intermedia', 30),
  ('Listen: ''While I understand the concerns about cost, I still support the new public transportation project because of its long-term benefits.'' What is the speaker''s overall position?', '["Completely against the project, with no support at all","Undecided, without any clear position","In support of the project, despite acknowledging a concern","Neutral, without mentioning any benefits"]', 2, 'El hablante reconoce una preocupación (el costo) pero mantiene una postura de apoyo al proyecto por sus beneficios a largo plazo.', 'intermedia', 30),
  ('Listen: ''It would be easy to simply say that social media is harmful and should be restricted, but the reality is more complex: it depends heavily on how, and how much, it is used.'' How would you characterize the speaker''s position on social media?', '["Una postura completamente negativa y sin matices","Una postura completamente positiva y sin matices","Una postura neutral e indecisa sobre el tema","Una postura matizada, que reconoce complejidad en vez de una condena simple"]', 3, 'El hablante evita una postura simplista y reconoce la complejidad del tema, mostrando una postura matizada.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_2_medio' and lo.short_name = 'Identificación de la postura del hablante frente a un tema'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comprensión de textos orales con vocabulario técnico simple
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''The hard drive stores data permanently, while RAM stores information temporarily while the computer is running.'' What is the difference explained in this audio?', '["The difference between permanent and temporary data storage","The difference between a keyboard and a mouse","The difference between two software programs","The difference between two operating systems"]', 0, 'El audio explica la diferencia entre almacenamiento permanente (disco duro) y temporal (RAM).', 'inicial', 25),
  ('Escuchas: ''El sistema circulatorio transporta sangre, oxígeno y nutrientes a través del cuerpo mediante el corazón y los vasos sanguíneos.'' ¿Qué función se describe en el audio?', '["La función del sistema digestivo","La función del sistema circulatorio","La función del sistema nervioso","La función del sistema respiratorio"]', 1, 'El audio describe la función del sistema circulatorio.', 'intermedia', 30),
  ('Listen: ''Photosynthesis is the process by which plants convert sunlight, water, and carbon dioxide into energy and oxygen.'' What technical process is described?', '["Digestion in animals","Photosynthesis in plants","Respiration in humans","Erosion of rocks"]', 1, 'El audio describe el proceso técnico de la fotosíntesis en las plantas.', 'intermedia', 30),
  ('Listen: ''In economics, supply refers to how much of a product is available, while demand refers to how much consumers want to buy; when supply is low and demand is high, prices tend to rise.'' Using this technical explanation, what would likely happen to prices if supply increases while demand stays the same?', '["Prices would likely increase further","Prices would likely decrease, following the same logic in reverse","Prices would remain completely unrelated to supply","There is no way to know based on this explanation"]', 1, 'Siguiendo la misma lógica inversa explicada (baja oferta y alta demanda sube precios), un aumento de la oferta con demanda constante tendería a bajar los precios.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_2_medio' and lo.short_name = 'Comprensión de textos orales con vocabulario técnico simple'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Toma de notas a partir de un texto oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Comprensión Auditiva. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Listen: ''The lecture covered three topics: the causes of the French Revolution, its main events, and its long-term consequences.'' If you are taking notes, which structure would be most useful?', '["Three separate sections: causes, events, consequences","One single paragraph with no divisions","Only writing down the date mentioned","Ignoring the structure and writing randomly"]', 0, 'Organizar las notas en tres secciones (causas, eventos, consecuencias) refleja la estructura del audio.', 'inicial', 25),
  ('Al tomar notas de un audio con muchos datos y fechas, ¿qué estrategia es más recomendable?', '["Transcribir el audio palabra por palabra","Anotar solo las palabras clave y los datos más relevantes","No tomar ninguna nota","Dibujar en vez de escribir palabras"]', 1, 'Anotar palabras clave y datos relevantes es más eficiente que transcribir todo el audio.', 'intermedia', 30),
  ('Listen: ''First, the study surveyed 500 participants. Then, researchers analyzed the data using statistical software. Finally, they published their findings in a journal.'' ¿Qué formato de notas sería más útil para registrar este proceso?', '["Una lista numerada con los tres pasos del proceso","Un dibujo sin palabras","Una sola palabra suelta","Ninguna nota, ya que no es necesario"]', 0, 'Una lista numerada refleja claramente la secuencia de tres pasos mencionada en el audio.', 'intermedia', 30),
  ('Listen: ''The presentation will cover four main areas: background information, methodology, key findings, and recommendations for future research. Each section will include specific data points.'' Al planificar tus notas antes de escuchar esta presentación, ¿qué estructura sería más eficiente?', '["Un párrafo único sin ninguna división por tema","Cuatro secciones tituladas según cada área mencionada, con espacio para datos específicos","Solo anotar el título de la presentación","Esperar a que termine para intentar recordarlo todo de memoria"]', 1, 'Preparar cuatro secciones según las áreas anunciadas permite organizar eficientemente la información mientras se escucha.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Auditiva' and l.code = 'regular_2_medio' and lo.short_name = 'Toma de notas a partir de un texto oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: COMPRENSIÓN LECTORA — 2° MEDIO
-- ============================================================================

-- Objetivo: Comprensión de textos argumentativos de mediana extensión
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Universities should reconsider the value of standardized testing. While it offers an objective measure, it often fails to capture creativity, critical thinking, and real-world problem-solving skills, which are equally important for success.'' What is the main claim of this text?', '["Standardized testing should be reconsidered because it doesn''t capture all important skills","Standardized testing perfectly measures all student abilities","Universities should eliminate all forms of evaluation","Creativity is not an important skill to evaluate"]', 0, 'El texto argumenta que la evaluación estandarizada debería reconsiderarse porque no captura todas las habilidades importantes.', 'inicial', 25),
  ('Texto: ''Aunque el teletrabajo ofrece flexibilidad, también puede generar aislamiento social; por ello, muchas empresas están adoptando modelos híbridos que combinan ambos beneficios.'' ¿Cuál es la conclusión implícita del texto?', '["El teletrabajo debe eliminarse completamente","Los modelos híbridos buscan combinar los beneficios de ambos enfoques","El aislamiento social no tiene relación con el trabajo","Las empresas deben volver completamente a la oficina"]', 1, 'El texto concluye implícitamente que los modelos híbridos buscan combinar los beneficios de la flexibilidad y evitar el aislamiento.', 'intermedia', 30),
  ('Text: ''Critics of fast fashion argue that it contributes to environmental damage and poor labor conditions. Supporters counter that it makes fashion accessible to lower-income consumers. A middle ground might involve stricter regulations without eliminating affordability.'' What is the structure of this argumentative text?', '["Presents only one side of the argument","Presents two opposing views and proposes a middle-ground solution","Is purely narrative with no argument","Only asks questions without any claims"]', 1, 'El texto presenta dos posturas opuestas (crítica y defensa de la moda rápida) y propone una solución intermedia.', 'intermedia', 30),
  ('Text: ''Although raising the minimum wage is often praised for reducing poverty, some economists warn it could lead to job losses in small businesses; however, recent studies in several regions show that moderate increases have had minimal negative impact on employment, while significantly improving workers'' quality of life.'' What overall conclusion does this text support, based on the evidence presented?', '["Que aumentar el salario mínimo siempre destruye empleos, sin excepciones","Que aumentar el salario mínimo no tiene ningún efecto en la economía","Que aumentos moderados del salario mínimo pueden mejorar la calidad de vida con un impacto negativo mínimo en el empleo, según la evidencia citada","Que el salario mínimo nunca debería cambiar"]', 2, 'El texto concluye, apoyado en evidencia citada, que los aumentos moderados pueden mejorar la calidad de vida con impacto negativo mínimo en el empleo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_2_medio' and lo.short_name = 'Comprensión de textos argumentativos de mediana extensión'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Análisis de la estructura argumentativa de un texto
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''Claim: Schools should offer more mental health resources. Evidence: Studies show rising anxiety levels among teenagers. Conclusion: Investing in mental health support could improve student wellbeing and academic performance.'' Identify the three structural elements present in this text.', '["Claim, evidence, and conclusion","Only a conclusion with no evidence","A story with characters and setting","A list with no argumentative structure"]', 0, 'El texto presenta claramente los tres elementos: afirmación, evidencia y conclusión.', 'inicial', 25),
  ('En un texto argumentativo, ¿qué función cumple la evidencia dentro de su estructura?', '["Reemplazar completamente la tesis","Respaldar o justificar la tesis presentada","No tiene ninguna función específica","Contradecir siempre la tesis presentada"]', 1, 'La evidencia cumple la función de respaldar o justificar la tesis presentada en el texto.', 'intermedia', 30),
  ('Text: ''Some might object that this policy is too expensive to implement. However, the long-term savings in healthcare costs would likely outweigh the initial investment.'' What structural element does this excerpt represent within an argumentative text?', '["The initial thesis of the text","A counterargument followed by a rebuttal","The concluding paragraph only","An unrelated narrative detail"]', 1, 'Este fragmento presenta un contraargumento (el costo) seguido de una refutación (el ahorro a largo plazo).', 'intermedia', 30),
  ('Text: ''Thesis: Cities should invest more in public parks. Argument 1: Parks improve public health by encouraging physical activity. Argument 2: Parks increase property values in surrounding areas. Counterargument: Some claim parks are costly to maintain. Rebuttal: Long-term health and economic benefits outweigh maintenance costs. Conclusion: Investing in parks is a wise use of public funds.'' Analyzing this structure, what makes this argumentative text particularly strong?', '["Que solo presenta una tesis sin ningún argumento","Que incluye tesis, múltiples argumentos, un contraargumento con su refutación, y una conclusión coherente","Que no considera ninguna objeción posible","Que se basa únicamente en opiniones personales sin evidencia"]', 1, 'La fortaleza de este texto radica en incluir tesis, múltiples argumentos, contraargumento con refutación y una conclusión coherente, una estructura argumentativa completa.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_2_medio' and lo.short_name = 'Análisis de la estructura argumentativa de un texto'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Comparación de puntos de vista en distintos textos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text A: ''Online learning offers flexibility and access to resources from anywhere.'' Text B: ''Online learning can lead to isolation and requires strong self-discipline.'' What is the main difference between these two texts?', '["Text A focuses on benefits; Text B focuses on challenges of online learning","Both texts say exactly the same thing","Neither text discusses online learning","Text A criticizes online learning completely"]', 0, 'El texto A se enfoca en los beneficios y el texto B en los desafíos del aprendizaje en línea.', 'inicial', 25),
  ('Texto A: ''La energía nuclear es una fuente de energía limpia y eficiente.'' Texto B: ''La energía nuclear conlleva riesgos de seguridad y manejo de residuos radiactivos.'' Al comparar ambos textos, ¿qué se puede concluir?', '["Ambos textos presentan exactamente la misma postura","Presentan posturas distintas: una destaca beneficios y la otra riesgos","Ninguno de los textos habla sobre energía nuclear","El texto B apoya completamente la energía nuclear"]', 1, 'Ambos textos presentan posturas distintas: uno destaca los beneficios y el otro los riesgos de la energía nuclear.', 'intermedia', 30),
  ('Text A: ''Genetic modification of crops can increase food production and resistance to pests.'' Text B: ''Genetic modification raises concerns about long-term health effects and biodiversity loss.'' When comparing both texts, what balanced conclusion could be drawn?', '["Genetic modification has no real benefits or risks","Genetic modification has potential benefits but also raises legitimate concerns that require careful consideration","Only Text A presents a valid argument","Only Text B presents a valid argument"]', 1, 'Comparando ambos textos, una conclusión equilibrada reconoce tanto los beneficios potenciales como las preocupaciones legítimas.', 'intermedia', 30),
  ('Text A: ''A recent government report states that public healthcare spending has increased efficiency by 20% over five years, based on internal audits.'' Text B: ''An opinion column argues that public healthcare has become less efficient, citing personal anecdotes from a few patients.'' When comparing the reliability and strength of the viewpoints in these two texts, which is more strongly supported, and why?', '["Text B, because personal stories are always more convincing than data","Both are equally strong since they discuss healthcare","Text A, because it is based on a government report with internal audit data, unlike Text B''s reliance on personal anecdotes","Neither text presents any viewpoint about healthcare"]', 2, 'El texto A se basa en un informe oficial con datos de auditoría, mientras que el texto B se basa en anécdotas personales, por lo que el texto A tiene un respaldo más sólido.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_2_medio' and lo.short_name = 'Comparación de puntos de vista en distintos textos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Ampliación de vocabulario académico
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Comprensión Lectora. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Text: ''The researchers analyzed the data to identify significant patterns and draw valid conclusions.'' In academic contexts, what does ''analyze'' most closely mean?', '["To examine something in detail to understand it better","To ignore something completely","To create something from scratch","To sell something to someone"]', 0, '''Analyze'' en contexto académico significa examinar algo en detalle para comprenderlo mejor.', 'inicial', 25),
  ('Texto: ''El estudio buscó determinar la correlación entre ambas variables mediante un análisis cuantitativo.'' Según el contexto, ¿qué significa ''cuantitativo'' en este texto académico?', '["Basado en opiniones personales sin datos","Basado en datos numéricos y medibles","Basado únicamente en historias","Basado en adivinanzas sin evidencia"]', 1, '''Cuantitativo'' se refiere a un análisis basado en datos numéricos y medibles.', 'intermedia', 30),
  ('Text: ''The report provides a comprehensive overview of the topic, covering historical, social, and economic dimensions.'' Based on context, what does ''comprehensive'' mean here?', '["Extremely short and incomplete","Focused on only one single aspect","Thorough and covering all relevant aspects","Irrelevant to the topic"]', 2, '''Comprehensive'' significa exhaustivo y que cubre todos los aspectos relevantes.', 'intermedia', 30),
  ('Text: ''While the initial findings suggested a strong correlation, subsequent replication studies failed to substantiate the original claim, raising questions about its validity.'' Based on this academic context, what does it mean that the studies ''failed to substantiate'' the claim?', '["Que los estudios confirmaron completamente la afirmación original","Que los estudios no pudieron respaldar o probar con evidencia la afirmación original","Que los estudios no tienen ninguna relación con la afirmación","Que la afirmación original nunca fue puesta a prueba"]', 1, '''Failed to substantiate'' significa que los estudios no lograron respaldar o probar con evidencia suficiente la afirmación original.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Comprensión Lectora' and l.code = 'regular_2_medio' and lo.short_name = 'Ampliación de vocabulario académico'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ORAL — 2° MEDIO
-- ============================================================================

-- Objetivo: Debate formal sobre un tema de relevancia social
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('En un debate formal, ¿cuál expresión es adecuada para presentar tu postura inicial?', '["In my opinion, and I will explain why, stricter environmental regulations are necessary.","Whatever, I don''t really care about this topic.","I don''t know, maybe, I guess so.","This topic, yes, no, whatever."]', 0, 'Esta expresión presenta claramente una postura inicial de forma formal y justificada.', 'inicial', 25),
  ('¿Cuál expresión es adecuada para refutar el argumento de un oponente en un debate formal?', '["You are completely wrong and don''t know anything.","While my opponent raises a valid concern, the evidence suggests a different conclusion.","I don''t want to respond to that.","That''s a silly point."]', 1, 'Esta expresión reconoce el punto del oponente de forma respetuosa antes de refutarlo con evidencia.', 'intermedia', 30),
  ('En un debate formal sobre el uso de energías renovables, ¿cuál cierre es adecuado para tu intervención?', '["That''s all, whatever, I''m done.","In conclusion, the evidence clearly supports a faster transition to renewable energy.","I forgot what I was going to say.","Renewable energy, the end, bye."]', 1, 'Este cierre resume la postura con base en la evidencia presentada, adecuado para un debate formal.', 'intermedia', 30),
  ('Debes participar en un debate formal sobre la obligatoriedad del servicio militar, presentando postura, evidencia y respondiendo a una objeción. ¿Cuál intervención cumple mejor con estos tres elementos en un registro formal?', '["Military service, yes, no, whatever, bye.","I think it''s fine, I guess, whatever people want.","I believe mandatory military service should be reconsidered, since studies show voluntary systems can be equally effective; while some argue it builds discipline, evidence suggests other programs achieve similar results.","Military service is bad. The end."]', 2, 'Esta intervención presenta postura, evidencia y una respuesta a una posible objeción, en un registro formal adecuado para un debate.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_2_medio' and lo.short_name = 'Debate formal sobre un tema de relevancia social'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de recursos persuasivos en el discurso oral
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál recurso persuasivo se usa en la frase ''Imagine a future where every child has access to quality education''?', '["Apelar a la imaginación del público para generar empatía","Presentar únicamente datos estadísticos","Usar un tono agresivo hacia el público","Ignorar completamente a la audiencia"]', 0, 'Esta frase apela a la imaginación del público para generar empatía, un recurso persuasivo común.', 'inicial', 25),
  ('¿Cuál de estas frases usa evidencia como recurso persuasivo?', '["I just feel like this is true.","According to recent studies, this approach reduces costs by 30%.","Everyone knows this, so it must be true.","This is obviously correct, no explanation needed."]', 1, 'Esta frase usa evidencia concreta (un estudio con un porcentaje) como recurso persuasivo.', 'intermedia', 30),
  ('¿Cuál recurso persuasivo se usa en la pregunta retórica ''Do we really want to leave this problem for future generations to solve?''?', '["Usar una pregunta retórica para hacer reflexionar a la audiencia","Presentar solo datos numéricos","Ignorar el tema completamente","Usar un insulto directo"]', 0, 'Esta es una pregunta retórica, un recurso persuasivo que invita a la audiencia a reflexionar.', 'intermedia', 30),
  ('Debes preparar un discurso persuasivo sobre la importancia de proteger los océanos, combinando evidencia, apelación emocional y una pregunta retórica. ¿Cuál fragmento combina mejor estos tres recursos?', '["Oceans are big. I like oceans. The end.","Studies show that ocean pollution kills millions of marine animals each year. Imagine a world without healthy oceans for future generations. Can we really afford to ignore this crisis?","Oceans, pollution, animals, whatever.","I don''t know much about oceans."]', 1, 'Este fragmento combina evidencia (estudios sobre contaminación), apelación emocional (imaginar un mundo sin océanos) y una pregunta retórica final.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_2_medio' and lo.short_name = 'Uso de recursos persuasivos en el discurso oral'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Análisis oral crítico de un texto o discurso
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al analizar críticamente un discurso, ¿qué aspecto es importante evaluar además del contenido?', '["La intención y los recursos persuasivos utilizados por el hablante","Solo la duración del discurso","El color de la ropa del hablante","La cantidad de personas presentes"]', 0, 'Analizar críticamente un discurso implica evaluar la intención y los recursos persuasivos utilizados, no solo el contenido superficial.', 'inicial', 25),
  ('Al analizar oralmente un discurso que usa solo apelaciones emocionales sin evidencia, ¿qué crítica sería pertinente hacer?', '["Elogiar el discurso sin ninguna observación","Señalar que el discurso carece de evidencia que respalde sus afirmaciones","Decir que el discurso es perfecto","No decir nada al respecto"]', 1, 'Una crítica pertinente sería señalar la falta de evidencia que respalde las afirmaciones basadas solo en emociones.', 'intermedia', 30),
  ('Al analizar críticamente un discurso, un estudiante nota que el hablante usa una generalización sin evidencia (''todos piensan que...''). ¿Qué tipo de observación crítica es más adecuada?', '["Aceptar la generalización sin cuestionarla","Cuestionar si esa generalización tiene evidencia que la respalde","Ignorar completamente esa parte del discurso","Repetir la generalización sin analizarla"]', 1, 'Es adecuado cuestionar si la generalización tiene evidencia que la respalde, un aspecto clave del análisis crítico.', 'intermedia', 30),
  ('Debes analizar oralmente un discurso que combina datos reales con una conclusión exagerada no respaldada por esos datos. ¿Cuál análisis crítico es más adecuado presentar?', '["El discurso es completamente válido sin ninguna objeción","Los datos presentados son reales, pero la conclusión exagerada no está completamente respaldada por esa evidencia","El discurso no tiene ningún dato real","No es posible analizar críticamente un discurso"]', 1, 'Un análisis crítico adecuado reconoce los datos reales pero cuestiona si la conclusión exagerada está realmente respaldada por ellos.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_2_medio' and lo.short_name = 'Análisis oral crítico de un texto o discurso'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Adecuación del discurso oral a distintas audiencias
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Expresión Oral. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Si presentas el mismo tema (el cambio climático) a un grupo de niños de primaria y a un grupo de científicos, ¿qué debería cambiar principalmente?', '["El nivel de vocabulario y la complejidad de las explicaciones","El tema completo de la presentación","Nada, la presentación debe ser idéntica","Solo el color de las diapositivas"]', 0, 'El nivel de vocabulario y la complejidad de las explicaciones deben adaptarse según la audiencia, aunque el tema sea el mismo.', 'inicial', 25),
  ('Al hablar frente a una audiencia internacional que no domina completamente el idioma local, ¿qué recomendación es más adecuada?', '["Usar un vocabulario extremadamente técnico y regionalismos","Hablar de forma clara, con vocabulario simple y evitando modismos locales","Hablar lo más rápido posible","No adaptar nada del discurso"]', 1, 'Hablar de forma clara y evitar modismos locales facilita la comprensión de una audiencia internacional.', 'intermedia', 30),
  ('Si presentas un proyecto escolar primero a tus compañeros y luego al director del colegio, ¿qué debería cambiar en tu discurso oral?', '["Nada, el discurso debe ser exactamente igual en ambos casos","El registro y el nivel de formalidad, adaptándolos a cada audiencia","Solo el tema de la presentación","El idioma completo de la presentación"]', 1, 'El registro y el nivel de formalidad deben adaptarse según la audiencia (compañeros vs. director).', 'intermedia', 30),
  ('Debes presentar el mismo proyecto de energías renovables a inversionistas (interesados en costos y beneficios económicos) y a estudiantes de colegio (interesados en aprender el concepto). ¿Cuál par de enfoques refleja mejor esta adecuación de audiencia?', '["Usar exactamente el mismo enfoque técnico y financiero para ambas audiencias","Enfocarse en costos y retorno de inversión para los inversionistas, y en conceptos básicos y ejemplos simples para los estudiantes","Usar solo ejemplos simples para ambas audiencias, ignorando a los inversionistas","No adaptar nada, ya que el tema es el mismo para ambos grupos"]', 1, 'Adaptar el enfoque (financiero para inversionistas, conceptual y simple para estudiantes) refleja una adecuación correcta a cada audiencia.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Oral' and l.code = 'regular_2_medio' and lo.short_name = 'Adecuación del discurso oral a distintas audiencias'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- ============================================================================
-- EJE: EXPRESIÓN ESCRITA — 2° MEDIO
-- ============================================================================

-- Objetivo: Redacción de un ensayo argumentativo breve
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración es adecuada como tesis de un ensayo argumentativo breve?', '["Governments should invest more in public education because it reduces long-term social inequality.","Education is a word. Governments exist. Inequality exists too.","I don''t know if education matters.","Education, governments, inequality, maybe."]', 0, 'Esta oración presenta una tesis clara con una razón que la justifica, adecuada para un ensayo argumentativo.', 'inicial', 25),
  ('¿Cuál oración funciona como un párrafo de desarrollo adecuado, con evidencia, para la tesis ''Exercise improves mental health''?', '["Exercise is a word with eight letters.","Studies show that regular physical activity reduces symptoms of anxiety and depression significantly.","Some people don''t like exercise.","Exercise, health, mental, word."]', 1, 'Esta oración presenta evidencia (estudios) que respalda la tesis sobre el ejercicio y la salud mental.', 'intermedia', 30),
  ('¿Cuál oración es adecuada para la conclusión de un ensayo argumentativo breve sobre la importancia de la educación ambiental?', '["In conclusion, integrating environmental education into school curricula is essential for a sustainable future.","Environmental education, the end, goodbye.","I don''t want to talk about the environment anymore.","Environment is a word with eleven letters."]', 0, 'Esta oración cierra el ensayo con una conclusión clara y coherente con la tesis planteada.', 'intermedia', 30),
  ('Debes redactar un ensayo argumentativo breve completo (tesis, desarrollo con evidencia, y conclusión) sobre la importancia de dormir bien. ¿Cuál secuencia cumple mejor esta estructura?', '["Sleep is good. I like sleeping. The end.","Getting enough sleep is essential for teenagers'' academic performance. Research shows that students who sleep eight hours perform better on cognitive tasks than those who sleep less. In conclusion, schools and families should prioritize healthy sleep habits.","Sleep, school, students, conclusion, sleep again.","I don''t know if sleep matters that much."]', 1, 'Esta secuencia presenta una tesis clara, evidencia concreta (investigación) y una conclusión coherente, cumpliendo la estructura de un ensayo argumentativo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_2_medio' and lo.short_name = 'Redacción de un ensayo argumentativo breve'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Uso de evidencia y ejemplos para sustentar una idea
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál oración usa evidencia específica para sustentar la idea de que ''reading benefits vocabulary development''?', '["A study of 500 students found that those who read daily scored 20% higher on vocabulary tests.","Reading is nice. I like books.","Some people read books sometimes.","Reading, vocabulary, development, word."]', 0, 'Esta oración presenta evidencia específica (un estudio con datos concretos) que sustenta la idea.', 'inicial', 25),
  ('¿Cuál oración usa un ejemplo concreto para sustentar la idea de que ''small actions can have a big environmental impact''?', '["The environment is important, I guess.","For example, if every household in a city recycled just one more item per week, it could reduce landfill waste significantly.","Environment, actions, impact, whatever.","I don''t know any examples about this."]', 1, 'Esta oración presenta un ejemplo concreto y específico que sustenta la idea general.', 'intermedia', 30),
  ('Al escribir un texto argumentativo, ¿por qué es importante incluir evidencia o ejemplos en vez de solo opiniones?', '["Porque hace el texto más largo sin ningún propósito","Porque da mayor credibilidad y respaldo a las ideas presentadas","Porque las opiniones nunca son válidas","Porque los ejemplos siempre son falsos"]', 1, 'La evidencia y los ejemplos dan mayor credibilidad y respaldo a las ideas presentadas en un texto argumentativo.', 'intermedia', 30),
  ('Debes sustentar la idea ''urban green spaces improve community wellbeing'' con evidencia y un ejemplo concreto en la misma oración o párrafo. ¿Cuál opción logra esto mejor?', '["Green spaces are nice for everyone, I think.","Studies show that access to parks reduces stress levels; for example, a study in Santiago found that residents near green spaces reported 15% lower stress scores.","Parks, wellbeing, community, good.","I don''t have any evidence about parks."]', 1, 'Esta opción combina evidencia general (estudios) con un ejemplo concreto y específico (Santiago, 15%), sustentando sólidamente la idea.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_2_medio' and lo.short_name = 'Uso de evidencia y ejemplos para sustentar una idea'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Revisión de un texto propio a partir de criterios explícitos
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('Al revisar un texto propio usando una rúbrica con el criterio ''argumentación sólida'', ¿qué deberías verificar?', '["Que los argumentos estén respaldados con evidencia o ejemplos claros","Que el texto tenga muchas páginas","Que el texto use palabras muy complejas sin importar el sentido","Que el texto no tenga ningún argumento"]', 0, 'El criterio de ''argumentación sólida'' requiere verificar que los argumentos estén respaldados con evidencia o ejemplos.', 'inicial', 25),
  ('Una rúbrica evalúa ''cohesión textual''. Al revisar tu ensayo, ¿qué deberías verificar según este criterio?', '["El color del papel utilizado","Que las ideas estén conectadas de forma lógica mediante conectores adecuados","La cantidad de palabras exactas","El tipo de letra utilizado"]', 1, 'El criterio de cohesión textual requiere verificar que las ideas estén conectadas lógicamente mediante conectores.', 'intermedia', 30),
  ('Al revisar tu ensayo con el criterio explícito ''registro formal'', notas que usaste la expresión ''yeah, totally'' en el desarrollo. ¿Qué deberías hacer?', '["Dejarlo igual, no importa el registro","Reemplazarla por una expresión más formal, como ''indeed'' o ''certainly''","Agregar más expresiones informales similares","Eliminar todo el párrafo sin revisar el resto"]', 1, 'Según el criterio de registro formal, se debe reemplazar la expresión informal por una más formal.', 'intermedia', 30),
  ('Debes revisar tu ensayo argumentativo aplicando tres criterios explícitos: tesis clara, evidencia suficiente y registro formal. Notas que tu tesis es clara y tu registro es formal, pero uno de tus argumentos no tiene ninguna evidencia. ¿Qué acción de revisión corresponde aplicar según estos criterios?', '["No hacer ningún cambio, ya que dos de tres criterios están cumplidos","Agregar evidencia o un ejemplo concreto que respalde ese argumento específico","Eliminar la tesis, ya que es innecesaria","Cambiar todo el ensayo a un registro informal"]', 1, 'Según los criterios, corresponde agregar evidencia o un ejemplo concreto al argumento que carece de respaldo.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_2_medio' and lo.short_name = 'Revisión de un texto propio a partir de criterios explícitos'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);

-- Objetivo: Escritura de un texto con estructura formal
insert into public.questions (
  subject_id, level_id, lesson_id, prompt, choices, correct_index, explanation,
  learning_objective_id, difficulty, question_type, points, estimated_seconds,
  review_status, validation_status, is_active, source_type, source, generated_by, generated_at
)
select lo.subject_id, lo.level_id, null, v.prompt, v.choices::jsonb, v.correct_index, v.explanation,
  lo.id, v.difficulty, 'seleccion_multiple', 1, v.estimated_seconds,
  'borrador', 'ai_generated_review_required', true, 'validapp_original',
  'Pregunta ValidApp (borrador), Inglés 2° Medio, eje Expresión Escrita. Basada en Bases Curriculares MINEDUC (Decreto Supremo N.° 614/2013); redacción original pendiente de revisión pedagógica.',
  'claude-sonnet-5', now()
from (values
  ('¿Cuál texto sigue correctamente una estructura formal con introducción, desarrollo y conclusión?', '["Introduction: This essay discusses renewable energy. Development: It explains benefits and challenges. Conclusion: Renewable energy is a key part of a sustainable future.","Renewable energy is good. I like it. The end.","Energy, renewable, good, bad, whatever.","I don''t know about renewable energy."]', 0, 'Este texto sigue claramente la estructura formal de introducción, desarrollo y conclusión.', 'inicial', 25),
  ('¿Cuál elemento es característico de un texto con estructura formal, a diferencia de un mensaje informal?', '["Uso de abreviaciones y emojis","Organización clara en párrafos con introducción, desarrollo y conclusión","Ausencia total de puntuación","Uso exclusivo de oraciones incompletas"]', 1, 'La organización clara en párrafos con introducción, desarrollo y conclusión es característica de un texto formal.', 'intermedia', 30),
  ('Al escribir un informe formal sobre un tema científico, ¿qué elemento debería incluir la introducción?', '["Una broma personal sin relación al tema","Una presentación general del tema y su relevancia","Una lista de emojis relacionados con el tema","Una despedida informal"]', 1, 'La introducción de un informe formal debe presentar de forma general el tema y su relevancia.', 'intermedia', 30),
  ('Debes redactar un texto con estructura formal completa (introducción, desarrollo con al menos un argumento, y conclusión) sobre la importancia de la lectura. ¿Cuál opción cumple mejor con esta estructura formal?', '["Reading is good, I like it, the end, bye.","Introduction: Reading plays a crucial role in personal development. Development: Studies show that regular readers develop stronger vocabulary and critical thinking skills. Conclusion: Therefore, fostering a reading habit should be a priority in education.","Reading, books, good, whatever, the end.","I don''t know if reading is important or not."]', 1, 'Esta opción presenta claramente una introducción, un desarrollo con evidencia y una conclusión, cumpliendo con una estructura formal completa.', 'avanzada', 40)
) as v(prompt, choices, correct_index, explanation, difficulty, estimated_seconds)
cross join (
  select (select id from public.subjects where name = 'Idioma Extranjero: Inglés') as subject_id, lo.id, lo.level_id
  from public.learning_objectives lo
  join public.units u on u.id = lo.unit_id
  join public.strands s on s.id = u.strand_id
  join public.levels l on l.id = lo.level_id
  where s.subject_id = (select id from public.subjects where name = 'Idioma Extranjero: Inglés')
    and s.name = 'Expresión Escrita' and l.code = 'regular_2_medio' and lo.short_name = 'Escritura de un texto con estructura formal'
) lo
where not exists (
  select 1 from public.questions q2 where q2.learning_objective_id = lo.id and q2.prompt = v.prompt
);
