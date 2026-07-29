-- Dominio: Contenido y preguntas
-- Currículum Regular (menores de 18, examen libre curso por curso) —
-- Educación Ciudadana, 3° y 4° Medio, Formación General.
--
-- ============================================================================
-- POR QUÉ ESTE ARCHIVO EXISTE: EL HUECO DEJADO EXPLÍCITAMENTE POR 0022
-- ============================================================================
-- supabase/seed/0022_curriculum_historia_regular_7basico_2medio.sql (líneas
-- ~30-88) documentó que el Plan de Formación General de 3°-4° Medio
-- (Decreto Supremo N.° 193 de 2019) NO contiene una asignatura "Historia,
-- Geografía y Ciencias Sociales" que continúe la banda de 7° Básico a
-- 2° Medio. En su lugar, ese plan reemplaza esa asignatura obligatoria por
-- "Educación Ciudadana": formación cívica centrada en instituciones
-- democráticas, Constitución, derechos y deberes, y participación -- NO en
-- Historia ni Geografía como disciplinas. El contenido propiamente
-- historiográfico/geográfico migra a la Formación DIFERENCIADA (electiva),
-- que queda fuera de alcance de este archivo (mismo criterio ya aplicado a
-- Ciencias/Ciencias para la Ciudadanía en 0017-0019).
--
-- 0022 decidió explícitamente NO fabricar esta asignatura "sin el detalle de
-- los ejes/OA propios y verificados". Este archivo asume esa tarea pendiente,
-- de forma separada y explícita, como allí se recomendó.
--
-- ============================================================================
-- DECISIÓN CENTRAL: ASIGNATURA NUEVA, NO CONTINUACIÓN DE "Estudios Sociales"
-- ============================================================================
-- Mismo patrón de decisión que supabase/seed/0019 (Ciencias para la
-- Ciudadanía) frente a "Ciencias Naturales": "Educación Ciudadana" es un
-- OBJETO DE ESTUDIO distinto de "Estudios Sociales"/Historia, Geografía y
-- Ciencias Sociales (canonical_code = 'social_sciences', creada por
-- supabase/seed/0002 y reutilizada en 0021/0022) -- no un cambio de nombre de
-- la misma asignatura. Por eso este archivo:
--   1. Crea una fila NUEVA en `subjects` ("Educación Ciudadana"), en vez de
--      reutilizar "Estudios Sociales".
--   2. Crea ejes/strands PROPIOS, no reutiliza "Historia", "Geografía" ni
--      "Formación Ciudadana" (el eje homónimo dentro de Estudios Sociales,
--      ver 0021) -- son conceptualmente distintos: "Formación Ciudadana"
--      como EJE dentro de Historia (7° Básico-2° Medio) es un componente
--      parcial de esa asignatura; "Educación Ciudadana" en 3°-4° Medio es la
--      ASIGNATURA COMPLETA de Formación General, con mayor profundidad y
--      alcance propio.
--   3. Usa un `canonical_code` NUEVO que no colisiona con ninguno ya usado
--      (mathematics, language, natural_sciences, social_sciences, english,
--      citizen_science -- ver supabase/seed/0001/0002/0011-0019/0021-0025).
--      Se verificó que `subjects.canonical_code` tiene un índice único
--      PARCIAL (`subjects_canonical_code_key`, creado en
--      supabase/migrations/0016_curriculum_frameworks.sql, `where
--      canonical_code is not null`), por lo que el valor elegido aquí,
--      'civic_education', debe ser distinto de todos los anteriores --
--      confirmado que no lo repite (y deliberadamente distinto de
--      'citizen_science', que es una asignatura distinta: alfabetización
--      científica ciudadana, no formación cívica).
--
-- No se comparte `program_id` ni ninguna otra estructura con Historia: los
-- niveles `regular_3_medio` y `regular_4_medio` ya existen (creados junto con
-- el resto de niveles Regular, reutilizados también por 0013/0016/0019/0025)
-- y no requieren cambios; `subjects`/`strands`/`units`/`learning_objectives`
-- no tienen columna `program_id` propia (esa columna vive en `levels`, ver
-- supabase/migrations/0010 y 0031) -- por lo tanto no hay una decisión de
-- "compartir o no program_id" a nivel de asignatura: cualquier asignatura
-- nueva se asocia a los niveles Regular ya existentes vía `level_id`, sin
-- tocar `programs`/`program_levels`.
--
-- ============================================================================
-- FUENTE Y NIVEL DE CONFIANZA
-- ============================================================================
-- Fuente citada: Bases Curriculares de 3° y 4° Medio (Formación General),
-- MINEDUC, aprobadas por el DECRETO SUPREMO N.° 193 DE 2019 (mismo decreto ya
-- usado en supabase/seed/0013, 0016, 0019, 0025 para Matemática, Lengua y
-- Literatura, Ciencias para la Ciudadanía e Inglés en esta banda). Vigencia
-- progresiva desde 2020 (3° Medio) y 2021 (4° Medio).
--
-- DENOMINACIÓN OFICIAL DE LA ASIGNATURA: "Educación Ciudadana".
-- CONFIANZA ALTA en que esta asignatura existe con este nombre, que es de
-- Formación General obligatoria para todos los estudiantes de 3°-4° Medio, y
-- en su enfoque general (formación cívica: institucionalidad democrática,
-- Constitución, derechos y deberes, participación) -- esto ya estaba
-- documentado con este mismo nivel de confianza en el encabezado de
-- supabase/seed/0022 (líneas ~39-48), que este archivo hereda y no repite en
-- detalle.
--
-- CONFIANZA EN LA ESTRUCTURA DE EJES/MÓDULOS Y SUS NOMBRES EXACTOS:
-- MEDIA-BAJA -- igual que en 0019 con los módulos de Ciencias para la
-- Ciudadanía. Este agente NO tiene un PDF de las Bases Curriculares de
-- Educación Ciudadana cargado ni verificado letra por letra en este entorno.
-- Los 4 ejes usados aquí ("Democracia e Institucionalidad"; "Derechos,
-- Deberes y Estado de Derecho"; "Participación Ciudadana y Sociedad Civil";
-- "Ciudadanía, Economía y Globalización") son una organización RAZONABLE y
-- REPRESENTATIVA del enfoque conocido de la asignatura (institucionalidad,
-- derechos humanos, participación, y una dimensión económica/global que
-- Educación Ciudadana efectivamente incluye), pero NO son necesariamente los
-- nombres ni la cantidad exactos de unidades/ejes que usa el documento
-- oficial del Decreto 193/2019. Podría haber un número distinto de unidades,
-- nombres distintos, o una organización distinta (por ejemplo, por unidades
-- anuales en vez de ejes transversales).
--
-- Confianza en el TEXTO EXACTO y la NUMERACIÓN OFICIAL ("OA n") de cada
-- objetivo puntual: BAJA (mismo criterio que el resto de esta serie de
-- archivos, incluyendo 0021/0022). Por eso, igual que en 0011-0025:
--   - `official_text` y `code` quedan NULL en todas las filas.
--   - Todas las filas quedan `status = 'borrador'`.
--   - `pedagogical_notes` distingue, en cada fila, entre "el decreto y el
--     nombre de la asignatura están verificados con confianza ALTA" y "la
--     estructura de ejes y el texto de cada objetivo son de confianza
--     MEDIA-BAJA/BAJA, sin verificar contra el PDF oficial".
--
-- ANTES de promover cualquier fila de este archivo a `status = 'aprobado'`,
-- o de usar estos nombres de eje en una interfaz pública como si fueran
-- oficiales, se recomienda fuertemente que un humano (o un agente con acceso
-- de navegación web) confirme directamente contra las Bases Curriculares de
-- Educación Ciudadana (D.S. 193/2019) si estos 4 ejes, sus nombres y el
-- texto/numeración de cada OA son correctos.
--
-- ============================================================================
-- MODELADO: ejes en la tabla `strands`
-- ============================================================================
-- Se reutiliza la tabla `strands` (ligada a `subjects`) para los 4 ejes de
-- esta asignatura, dejando constancia explícita aquí (y en `description` de
-- cada fila de `strands`) del nivel de confianza MEDIA-BAJA en su nombre y
-- estructura -- para que quien lea el dato en el futuro no los confunda con
-- ejes verificados como los de Matemática o Lenguaje.
--
-- ============================================================================
-- QUÉ CUBRE Y QUÉ NO
-- ============================================================================
-- Cubre: 4 ejes x 2 cursos (3° y 4° Medio) = 8 combinaciones eje-curso, cada
-- una con 1 unidad y 4 objetivos de aprendizaje curados -- SOLO Formación
-- General. Representativos, NO exhaustivos.
--
-- NO cubre: el contenido de Historia y Geografía de la Formación
-- DIFERENCIADA de 3°-4° Medio (electivo), que queda fuera de alcance -- ver
-- razonamiento en el encabezado de 0022. Tampoco cubre banco de preguntas,
-- lecciones, ensayos, catálogo de habilidades (`skills`), actitudes (OAA),
-- Grandes ideas ni Conocimientos esenciales. El banco de preguntas para
-- completar los 12 niveles de "Historia" en ValidApp (incluyendo estos 2
-- niveles de Educación Ciudadana) queda explícitamente para una tarea
-- posterior separada.
--
-- ============================================================================
-- POR QUÉ NO SE USA curriculum_frameworks / framework_subjects
-- ============================================================================
-- Mismo motivo documentado en 0011-0025: `exam_period` NOT NULL en
-- `curriculum_frameworks` modela el problema específico de EPJA (varios
-- decretos por período de examinación), no el Currículum Regular.
--
-- ============================================================================
-- IDEMPOTENCIA
-- ============================================================================
-- `subjects.name` es único -- este archivo crea la fila "Educación
-- Ciudadana" con `on conflict (name) do nothing` (segura de reintentar).
-- `subjects.canonical_code` tiene índice único parcial: se usa
-- 'civic_education', verificado que no colisiona con ningún canonical_code ya
-- usado en el repositorio (ver decisión central arriba). `strands
-- (subject_id, name)` y `units (strand_id, name)` tienen restricción única
-- (0010): `on conflict do nothing`. `learning_objectives (unit_id, level_id,
-- short_name)` tiene restricción única (0021): `on conflict do update`
-- limitado a las columnas propias de este archivo. `level_id` se resuelve por
-- `levels.code` ('regular_3_medio', 'regular_4_medio', ya existentes), y
-- `subject_id` por `subjects.name`. Seed SOLO local: no se ha ejecutado
-- contra ningún proyecto Supabase (ni dev ni producción), ni se ha hecho
-- commit de este archivo.

-- ============================================================================
-- 1) Asignatura NUEVA: "Educación Ciudadana"
-- ============================================================================
insert into public.subjects (name, canonical_code)
values ('Educación Ciudadana', 'civic_education')
on conflict (name) do nothing;

-- ============================================================================
-- 2) Ejes temáticos (ver nota de confianza MEDIA-BAJA en el encabezado)
-- ============================================================================
insert into public.strands (subject_id, name, description, order_index)
values
  ((select id from public.subjects where name = 'Educación Ciudadana'),
   'Democracia e Institucionalidad', 'Eje sobre el Estado de derecho, la Constitución, la separación de poderes y las instituciones democráticas (nombre y estructura de eje de confianza MEDIA-BAJA; ver encabezado de este archivo).', 0)
on conflict (subject_id, name) do nothing;

insert into public.strands (subject_id, name, description, order_index)
values
  ((select id from public.subjects where name = 'Educación Ciudadana'),
   'Derechos, Deberes y Estado de Derecho', 'Eje sobre derechos humanos, derechos y deberes constitucionales, y mecanismos de protección de derechos (ver nota de confianza MEDIA-BAJA en el encabezado de este archivo).', 1)
on conflict (subject_id, name) do nothing;

insert into public.strands (subject_id, name, description, order_index)
values
  ((select id from public.subjects where name = 'Educación Ciudadana'),
   'Participación Ciudadana y Sociedad Civil', 'Eje sobre formas de participación ciudadana, organizaciones de la sociedad civil y movimientos sociales (ver nota de confianza MEDIA-BAJA en el encabezado de este archivo).', 2)
on conflict (subject_id, name) do nothing;

insert into public.strands (subject_id, name, description, order_index)
values
  ((select id from public.subjects where name = 'Educación Ciudadana'),
   'Ciudadanía, Economía y Globalización', 'Eje sobre el rol del Estado y el mercado, consumo responsable, ciudadanía digital y desafíos de la globalización (ver nota de confianza MEDIA-BAJA en el encabezado de este archivo).', 3)
on conflict (subject_id, name) do nothing;

-- ============================================================================
-- 3) Unidades y objetivos de aprendizaje, curso por curso
-- ============================================================================

-- ---------------------------------------------------------------------
-- 3° MEDIO (order_index de nivel = 111, mismo usado por 0019)
-- ---------------------------------------------------------------------
insert into public.units (strand_id, name, description, order_index)
select s.id, 'Democracia e Institucionalidad — 3° Medio', 'Objetivos de aprendizaje de Educación Ciudadana, eje Democracia e Institucionalidad, para 3° Medio (Formación General).', 111
from public.strands s where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and s.name = 'Democracia e Institucionalidad'
on conflict (strand_id, name) do nothing;

insert into public.learning_objectives (unit_id, level_id, short_name, description, status, curricular_source, reference_year, pedagogical_notes, order_index)
select u.id, l.id, v.short_name, v.description, 'borrador',
  'Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC, Decreto Supremo N.° 193 de 2019, asignatura "Educación Ciudadana" (decreto y nombre de asignatura verificados con confianza ALTA), eje "Democracia e Institucionalidad" (nombre de eje de confianza MEDIA-BAJA, sin verificar letra por letra -- ver encabezado de este archivo).',
  2019,
  'Paráfrasis ValidApp; confianza MEDIA-BAJA en la estructura y nombre del eje, BAJA en el texto y numeración OA específicos. No es cita textual del PDF oficial. Revisar contra la fuente antes de marcar como aprobado.',
  v.order_index
from (values
  ('Fundamentos del Estado de derecho', 'Explicar los fundamentos del Estado de derecho y su relación con la democracia como forma de gobierno.', 0),
  ('Separación y funciones de los poderes del Estado', 'Describir la separación y las funciones de los poderes Ejecutivo, Legislativo y Judicial en Chile.', 1),
  ('La Constitución como norma fundamental', 'Explicar el rol de la Constitución como norma fundamental que organiza el Estado y garantiza derechos.', 2),
  ('Mecanismos de transparencia y control del poder público', 'Analizar mecanismos de transparencia, probidad y control del poder público en Chile.', 3)
) as v(short_name, description, order_index)
cross join (select id from public.units where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and name = 'Democracia e Institucionalidad') and name = 'Democracia e Institucionalidad — 3° Medio') as u
cross join (select id from public.levels where code = 'regular_3_medio') as l
on conflict (unit_id, level_id, short_name) do update set
  description = excluded.description, curricular_source = excluded.curricular_source,
  reference_year = excluded.reference_year, pedagogical_notes = excluded.pedagogical_notes;

insert into public.units (strand_id, name, description, order_index)
select s.id, 'Derechos, Deberes y Estado de Derecho — 3° Medio', 'Objetivos de aprendizaje de Educación Ciudadana, eje Derechos, Deberes y Estado de Derecho, para 3° Medio (Formación General).', 111
from public.strands s where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and s.name = 'Derechos, Deberes y Estado de Derecho'
on conflict (strand_id, name) do nothing;

insert into public.learning_objectives (unit_id, level_id, short_name, description, status, curricular_source, reference_year, pedagogical_notes, order_index)
select u.id, l.id, v.short_name, v.description, 'borrador',
  'Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC, Decreto Supremo N.° 193 de 2019, asignatura "Educación Ciudadana" (decreto y nombre de asignatura verificados con confianza ALTA), eje "Derechos, Deberes y Estado de Derecho" (nombre de eje de confianza MEDIA-BAJA -- ver encabezado de este archivo).',
  2019,
  'Paráfrasis ValidApp; confianza MEDIA-BAJA en la estructura y nombre del eje, BAJA en el texto y numeración OA específicos. No es cita textual del PDF oficial. Revisar contra la fuente antes de marcar como aprobado.',
  v.order_index
from (values
  ('Derechos humanos en tratados internacionales', 'Analizar el reconocimiento de los derechos humanos en tratados internacionales suscritos y ratificados por Chile.', 0),
  ('Derechos y deberes constitucionales', 'Describir los principales derechos y deberes constitucionales de las personas en Chile.', 1),
  ('Igualdad ante la ley y no discriminación', 'Fundamentar la importancia del principio de igualdad ante la ley y la no discriminación en la convivencia democrática.', 2),
  ('Mecanismos de protección de derechos', 'Describir mecanismos institucionales de protección de derechos disponibles para las personas en Chile.', 3)
) as v(short_name, description, order_index)
cross join (select id from public.units where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and name = 'Derechos, Deberes y Estado de Derecho') and name = 'Derechos, Deberes y Estado de Derecho — 3° Medio') as u
cross join (select id from public.levels where code = 'regular_3_medio') as l
on conflict (unit_id, level_id, short_name) do update set
  description = excluded.description, curricular_source = excluded.curricular_source,
  reference_year = excluded.reference_year, pedagogical_notes = excluded.pedagogical_notes;

insert into public.units (strand_id, name, description, order_index)
select s.id, 'Participación Ciudadana y Sociedad Civil — 3° Medio', 'Objetivos de aprendizaje de Educación Ciudadana, eje Participación Ciudadana y Sociedad Civil, para 3° Medio (Formación General).', 111
from public.strands s where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and s.name = 'Participación Ciudadana y Sociedad Civil'
on conflict (strand_id, name) do nothing;

insert into public.learning_objectives (unit_id, level_id, short_name, description, status, curricular_source, reference_year, pedagogical_notes, order_index)
select u.id, l.id, v.short_name, v.description, 'borrador',
  'Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC, Decreto Supremo N.° 193 de 2019, asignatura "Educación Ciudadana" (decreto y nombre de asignatura verificados con confianza ALTA), eje "Participación Ciudadana y Sociedad Civil" (nombre de eje de confianza MEDIA-BAJA -- ver encabezado de este archivo).',
  2019,
  'Paráfrasis ValidApp; confianza MEDIA-BAJA en la estructura y nombre del eje, BAJA en el texto y numeración OA específicos. No es cita textual del PDF oficial. Revisar contra la fuente antes de marcar como aprobado.',
  v.order_index
from (values
  ('Formas de participación ciudadana', 'Analizar distintas formas de participación ciudadana individual y colectiva disponibles en democracia.', 0),
  ('Organizaciones de la sociedad civil', 'Describir el rol de organizaciones de la sociedad civil en la promoción de derechos y demandas sociales.', 1),
  ('Participación estudiantil y espacios de representación juvenil', 'Evaluar espacios de participación y representación disponibles para adolescentes y jóvenes.', 2),
  ('Medios de comunicación y participación ciudadana', 'Analizar el rol de los medios de comunicación en la formación de opinión pública y la participación ciudadana.', 3)
) as v(short_name, description, order_index)
cross join (select id from public.units where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and name = 'Participación Ciudadana y Sociedad Civil') and name = 'Participación Ciudadana y Sociedad Civil — 3° Medio') as u
cross join (select id from public.levels where code = 'regular_3_medio') as l
on conflict (unit_id, level_id, short_name) do update set
  description = excluded.description, curricular_source = excluded.curricular_source,
  reference_year = excluded.reference_year, pedagogical_notes = excluded.pedagogical_notes;

insert into public.units (strand_id, name, description, order_index)
select s.id, 'Ciudadanía, Economía y Globalización — 3° Medio', 'Objetivos de aprendizaje de Educación Ciudadana, eje Ciudadanía, Economía y Globalización, para 3° Medio (Formación General).', 111
from public.strands s where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and s.name = 'Ciudadanía, Economía y Globalización'
on conflict (strand_id, name) do nothing;

insert into public.learning_objectives (unit_id, level_id, short_name, description, status, curricular_source, reference_year, pedagogical_notes, order_index)
select u.id, l.id, v.short_name, v.description, 'borrador',
  'Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC, Decreto Supremo N.° 193 de 2019, asignatura "Educación Ciudadana" (decreto y nombre de asignatura verificados con confianza ALTA), eje "Ciudadanía, Economía y Globalización" (nombre de eje de confianza MEDIA-BAJA -- ver encabezado de este archivo).',
  2019,
  'Paráfrasis ValidApp; confianza MEDIA-BAJA en la estructura y nombre del eje, BAJA en el texto y numeración OA específicos. No es cita textual del PDF oficial. Revisar contra la fuente antes de marcar como aprobado.',
  v.order_index
from (values
  ('Rol del Estado y el mercado en la economía', 'Analizar distintas concepciones sobre el rol del Estado y del mercado en la economía chilena.', 0),
  ('Consumo responsable y derechos del consumidor', 'Evaluar prácticas de consumo responsable a partir del conocimiento de los derechos del consumidor.', 1),
  ('Sistema tributario y bien común', 'Explicar el funcionamiento general del sistema tributario chileno y su relación con el financiamiento del bien común.', 2),
  ('Desafíos éticos de la ciudadanía digital', 'Analizar desafíos éticos y cívicos asociados al uso de tecnologías digitales y redes sociales.', 3)
) as v(short_name, description, order_index)
cross join (select id from public.units where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and name = 'Ciudadanía, Economía y Globalización') and name = 'Ciudadanía, Economía y Globalización — 3° Medio') as u
cross join (select id from public.levels where code = 'regular_3_medio') as l
on conflict (unit_id, level_id, short_name) do update set
  description = excluded.description, curricular_source = excluded.curricular_source,
  reference_year = excluded.reference_year, pedagogical_notes = excluded.pedagogical_notes;

-- ---------------------------------------------------------------------
-- 4° MEDIO (order_index de nivel = 112, mismo usado por 0019)
-- ---------------------------------------------------------------------
insert into public.units (strand_id, name, description, order_index)
select s.id, 'Democracia e Institucionalidad — 4° Medio', 'Objetivos de aprendizaje de Educación Ciudadana, eje Democracia e Institucionalidad, para 4° Medio (Formación General).', 112
from public.strands s where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and s.name = 'Democracia e Institucionalidad'
on conflict (strand_id, name) do nothing;

insert into public.learning_objectives (unit_id, level_id, short_name, description, status, curricular_source, reference_year, pedagogical_notes, order_index)
select u.id, l.id, v.short_name, v.description, 'borrador',
  'Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC, Decreto Supremo N.° 193 de 2019, asignatura "Educación Ciudadana" (decreto y nombre de asignatura verificados con confianza ALTA), eje "Democracia e Institucionalidad" (nombre de eje de confianza MEDIA-BAJA -- ver encabezado de este archivo).',
  2019,
  'Paráfrasis ValidApp; confianza MEDIA-BAJA en la estructura y nombre del eje, BAJA en el texto y numeración OA específicos. No es cita textual del PDF oficial. Revisar contra la fuente antes de marcar como aprobado.',
  v.order_index
from (values
  ('Sistemas electorales y representación política', 'Analizar distintos sistemas electorales y sus efectos en la representación política.', 0),
  ('Partidos políticos y su rol en la democracia', 'Describir el rol de los partidos políticos en la articulación de intereses y la gobernabilidad democrática.', 1),
  ('Reformas institucionales recientes en Chile', 'Analizar reformas institucionales recientes que han modificado el funcionamiento del Estado chileno.', 2),
  ('Análisis comparado de sistemas democráticos', 'Comparar el sistema democrático chileno con otros sistemas democráticos del mundo.', 3)
) as v(short_name, description, order_index)
cross join (select id from public.units where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and name = 'Democracia e Institucionalidad') and name = 'Democracia e Institucionalidad — 4° Medio') as u
cross join (select id from public.levels where code = 'regular_4_medio') as l
on conflict (unit_id, level_id, short_name) do update set
  description = excluded.description, curricular_source = excluded.curricular_source,
  reference_year = excluded.reference_year, pedagogical_notes = excluded.pedagogical_notes;

insert into public.units (strand_id, name, description, order_index)
select s.id, 'Derechos, Deberes y Estado de Derecho — 4° Medio', 'Objetivos de aprendizaje de Educación Ciudadana, eje Derechos, Deberes y Estado de Derecho, para 4° Medio (Formación General).', 112
from public.strands s where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and s.name = 'Derechos, Deberes y Estado de Derecho'
on conflict (strand_id, name) do nothing;

insert into public.learning_objectives (unit_id, level_id, short_name, description, status, curricular_source, reference_year, pedagogical_notes, order_index)
select u.id, l.id, v.short_name, v.description, 'borrador',
  'Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC, Decreto Supremo N.° 193 de 2019, asignatura "Educación Ciudadana" (decreto y nombre de asignatura verificados con confianza ALTA), eje "Derechos, Deberes y Estado de Derecho" (nombre de eje de confianza MEDIA-BAJA -- ver encabezado de este archivo).',
  2019,
  'Paráfrasis ValidApp; confianza MEDIA-BAJA en la estructura y nombre del eje, BAJA en el texto y numeración OA específicos. No es cita textual del PDF oficial. Revisar contra la fuente antes de marcar como aprobado.',
  v.order_index
from (values
  ('Memoria histórica y derechos humanos en Chile', 'Analizar procesos de memoria histórica vinculados a violaciones de derechos humanos en Chile.', 0),
  ('Derechos de grupos históricamente vulnerados', 'Describir avances y desafíos pendientes en el reconocimiento de derechos de grupos históricamente vulnerados.', 1),
  ('Responsabilidad ciudadana y deberes cívicos', 'Fundamentar la importancia del cumplimiento de deberes cívicos para la convivencia democrática.', 2),
  ('Análisis crítico de casos de vulneración de derechos', 'Analizar críticamente casos actuales de vulneración de derechos y sus posibles vías de reparación.', 3)
) as v(short_name, description, order_index)
cross join (select id from public.units where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and name = 'Derechos, Deberes y Estado de Derecho') and name = 'Derechos, Deberes y Estado de Derecho — 4° Medio') as u
cross join (select id from public.levels where code = 'regular_4_medio') as l
on conflict (unit_id, level_id, short_name) do update set
  description = excluded.description, curricular_source = excluded.curricular_source,
  reference_year = excluded.reference_year, pedagogical_notes = excluded.pedagogical_notes;

insert into public.units (strand_id, name, description, order_index)
select s.id, 'Participación Ciudadana y Sociedad Civil — 4° Medio', 'Objetivos de aprendizaje de Educación Ciudadana, eje Participación Ciudadana y Sociedad Civil, para 4° Medio (Formación General).', 112
from public.strands s where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and s.name = 'Participación Ciudadana y Sociedad Civil'
on conflict (strand_id, name) do nothing;

insert into public.learning_objectives (unit_id, level_id, short_name, description, status, curricular_source, reference_year, pedagogical_notes, order_index)
select u.id, l.id, v.short_name, v.description, 'borrador',
  'Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC, Decreto Supremo N.° 193 de 2019, asignatura "Educación Ciudadana" (decreto y nombre de asignatura verificados con confianza ALTA), eje "Participación Ciudadana y Sociedad Civil" (nombre de eje de confianza MEDIA-BAJA -- ver encabezado de este archivo).',
  2019,
  'Paráfrasis ValidApp; confianza MEDIA-BAJA en la estructura y nombre del eje, BAJA en el texto y numeración OA específicos. No es cita textual del PDF oficial. Revisar contra la fuente antes de marcar como aprobado.',
  v.order_index
from (values
  ('Movimientos sociales en la historia reciente de Chile', 'Analizar el rol de movimientos sociales relevantes en la historia reciente de Chile.', 0),
  ('Participación electoral y abstención', 'Analizar tendencias de participación electoral y abstención en la democracia chilena actual.', 1),
  ('Redes sociales y nuevas formas de acción ciudadana', 'Evaluar el rol de las redes sociales en nuevas formas de organización y acción ciudadana.', 2),
  ('Diseño de proyectos de participación comunitaria', 'Diseñar un proyecto simple de participación ciudadana orientado a una necesidad comunitaria.', 3)
) as v(short_name, description, order_index)
cross join (select id from public.units where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and name = 'Participación Ciudadana y Sociedad Civil') and name = 'Participación Ciudadana y Sociedad Civil — 4° Medio') as u
cross join (select id from public.levels where code = 'regular_4_medio') as l
on conflict (unit_id, level_id, short_name) do update set
  description = excluded.description, curricular_source = excluded.curricular_source,
  reference_year = excluded.reference_year, pedagogical_notes = excluded.pedagogical_notes;

insert into public.units (strand_id, name, description, order_index)
select s.id, 'Ciudadanía, Economía y Globalización — 4° Medio', 'Objetivos de aprendizaje de Educación Ciudadana, eje Ciudadanía, Economía y Globalización, para 4° Medio (Formación General).', 112
from public.strands s where s.subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and s.name = 'Ciudadanía, Economía y Globalización'
on conflict (strand_id, name) do nothing;

insert into public.learning_objectives (unit_id, level_id, short_name, description, status, curricular_source, reference_year, pedagogical_notes, order_index)
select u.id, l.id, v.short_name, v.description, 'borrador',
  'Bases Curriculares de 3° y 4° Medio (Formación General), MINEDUC, Decreto Supremo N.° 193 de 2019, asignatura "Educación Ciudadana" (decreto y nombre de asignatura verificados con confianza ALTA), eje "Ciudadanía, Economía y Globalización" (nombre de eje de confianza MEDIA-BAJA -- ver encabezado de este archivo).',
  2019,
  'Paráfrasis ValidApp; confianza MEDIA-BAJA en la estructura y nombre del eje, BAJA en el texto y numeración OA específicos. No es cita textual del PDF oficial. Revisar contra la fuente antes de marcar como aprobado.',
  v.order_index
from (values
  ('Globalización y su impacto en la ciudadanía', 'Analizar el impacto de la globalización económica y cultural en el ejercicio de la ciudadanía.', 0),
  ('Migración y ciudadanía en un mundo globalizado', 'Analizar procesos migratorios recientes y sus implicancias para la ciudadanía y la convivencia.', 1),
  ('Desarrollo sostenible y responsabilidad ciudadana', 'Evaluar la relación entre desarrollo sostenible y responsabilidad ciudadana individual y colectiva.', 2),
  ('Desafíos ciudadanos frente al cambio climático', 'Analizar desafíos éticos y ciudadanos que plantea el cambio climático a nivel local y global.', 3)
) as v(short_name, description, order_index)
cross join (select id from public.units where strand_id = (select id from public.strands where subject_id = (select id from public.subjects where name = 'Educación Ciudadana') and name = 'Ciudadanía, Economía y Globalización') and name = 'Ciudadanía, Economía y Globalización — 4° Medio') as u
cross join (select id from public.levels where code = 'regular_4_medio') as l
on conflict (unit_id, level_id, short_name) do update set
  description = excluded.description, curricular_source = excluded.curricular_source,
  reference_year = excluded.reference_year, pedagogical_notes = excluded.pedagogical_notes;
