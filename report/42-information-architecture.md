# 4.2. Information Architecture

La arquitectura de información organiza el contenido del Landing Page y de la Web Application para que cada persona encuentre lo que necesita según su objetivo. En el Landing, ordena la propuesta de valor hasta la solicitud comercial; en la aplicación, agrupa tareas operativas por módulo y rol.

### 4.2.1. Organization Systems

| Sistema | Aplicación en el producto | Ejemplos de contenido |
| --- | --- | --- |
| Visual | La jerarquía destaca la temperatura, el estado del traslado y las alertas; datos complementarios usan estilos secundarios. | Tarjetas de telemetría, KPI, chips de estado y alertas priorizadas. |
| Secuencial y cronológico | Los hitos se presentan en el orden en que ocurre un traslado y se registra su custodia. | Preparación, recojo, tránsito, llegada y entrega. |
| Matricial o cruzado | Las listas permiten comparar unidades y métricas en una misma vista. | Traslados con ruta, ETA, temperatura, batería y estado del SmartBox. |
| Por audiencia y tarea | Las secciones y módulos se agrupan según la tarea de visitantes, operadores, personal médico y supervisores. | Información comercial en el Landing; monitoreo, alertas, flota y trazabilidad en la Web Application. |

En el Landing Page, el recorrido empieza con la propuesta de valor y el funcionamiento del producto, presenta sus soluciones y termina en los planes y el formulario de contratación. En la Web Application, la organización prioriza las operaciones activas y permite pasar del resumen al detalle de una unidad, alerta o registro.

### 4.2.2. Labeling Systems

Las etiquetas usan términos breves y consistentes con el rol y la tarea. El Landing se dirige a visitantes comerciales institucionales; la aplicación emplea vocabulario operativo para el personal de transporte, los receptores y los supervisores.

| Audiencia | Etiquetas y términos de interfaz | Propósito |
| --- | --- | --- |
| Visitante comercial institucional (Gianfranco Timoteo) | “Open the Web App”, “Log in”, “Request hiring”, “Small Box” y “Standard Box”. | Evaluar la solución, acceder a la aplicación o consultar la contratación. |
| Operador logístico y personal de transporte (Gianfranco Timoteo y Aldair Lazaro) | “Traslados”, “Ruta y ETA”, “Telemetría”, “Temperatura (°C)”, “Batería (%)”, “Alertas” e “Incidentes”. | Consultar el estado de la flota y resolver tareas durante un traslado. |
| Personal receptor y supervisión hospitalaria (Gianfranco Timoteo) | “Recepción”, “Código de verificación”, “Cadena de custodia”, “Acta digital”, “Auditoría” y “Reportes”. | Confirmar la entrega y revisar sus registros. |

Las etiquetas de estado se acompañan de texto además del color, para que la condición del traslado o del contenedor no dependa únicamente de la señal cromática. Los CTA del Landing que abren la Web Application conducen al punto de acceso de la plataforma.

### 4.2.3. SEO Tags and Meta Tags

La tabla distingue los metadatos del sitio público de los títulos que la SPA actualiza al navegar. El estado describe lo que está implementado y deja explícito lo que requiere una actualización.

| Elemento | Landing Page público | Web Application | Estado |
| --- | --- | --- | --- |
| Idioma (`html lang`) | Español (`es`). | Español (`es`). | Implementado en ambos. |
| Título (`title`) | Título del producto en la pestaña del navegador. | `Medical SMARTBOX — Monitoreo y trazabilidad del transporte médico`; las vistas actualizan el título con el nombre de la sección. | Implementado; la SPA usa títulos por vista. |
| Descripción (`meta description`) | Descripción del producto en español. | Descripción de la plataforma, el monitoreo de traslados y las incidencias de temperatura. | Implementado en ambos. |
| Viewport | Configuración responsive para la ventana del navegador. | `width=device-width, initial-scale=1.0`. | Implementado en ambos. |
| Keywords | No existe una etiqueta `keywords` en la implementación revisada. | No existe una etiqueta `keywords` en `frontend/index.html`. | Pendiente de definir si se desea incluir. |
| Author | No existe una etiqueta `author` en la implementación revisada. | `NeonCode Team`. | Ausente en Landing; implementado en Web App. |
| Títulos por vista | No aplica. | La navegación establece títulos como “Panel”, “Reportes”, “Ajustes” y “Acerca de”, precedidos por “Medical SmartBox”. | Implementado en la SPA. |

Los metadatos del Landing se describen a partir de la implementación reportada para el sitio público. En la Web Application, el `title`, la descripción, el idioma, el viewport, el autor y los títulos por ruta se contrastan con `frontend/index.html` y el router de Vue. No se atribuyen al producto etiquetas de robots, canonical u Open Graph que no aparecen en esa implementación.

### 4.2.4. Searching Systems

La Web Application ofrece un filtro global para localizar información operativa y controles de estado para acotar las listas.

| Mecanismo | Qué permite encontrar o filtrar | Ejemplos |
| --- | --- | --- |
| Filtro global | Registros de operación disponibles desde la navegación principal. | Traslado, SmartBox o destino. |
| Búsqueda y filtros contextuales | Elementos de una lista según su ruta, estado o unidad asociada. | Ruta, “En tránsito”, “Crítica” o SmartBox. |
| Chips o pestañas de estado | Reducir los resultados a un estado operativo. | “En tránsito”, “Crítica” y “Entregado”. |

Los resultados mantienen visible su identificador y estado para facilitar la selección del registro correcto. Los estados vacíos y los mensajes de error orientan la recuperación cuando la búsqueda no devuelve resultados o la información no está disponible.

### 4.2.5. Navigation Systems

| Nivel | Elementos | Función |
| --- | --- | --- |
| Navegación del Landing | Enlaces a Plataforma, Cómo funciona, Soluciones y Trazabilidad; accesos a la Web Application y al inicio de sesión. | Recorrer la información del producto y llegar al acceso o contacto. |
| Encabezado de la Web Application | Marca, filtro global, notificaciones, usuario, rol e institución. | Mantener a mano las acciones transversales y el contexto de sesión. |
| Barra lateral | Panel; Operaciones (Traslados, Ruta y ETA); Flota (Ambulancias, SmartBox); Monitoreo (Telemetría); Alertas (Alertas, Incidentes); Trazabilidad (Cadena de custodia, Actas digitales, Auditoría); Reportes; Administración (Usuarios y roles, Suscripción); Cuenta (Ajustes). | Agrupar las pantallas por tarea y área funcional. |
| Breadcrumbs y navegación contextual | Ruta de la vista actual y acciones como “Ver detalle”, “Ver ruta y ETA” y “Volver a…”. | Ubicar al usuario y facilitar la navegación entre resumen y detalle. |
| Navegación móvil | Menú drawer y disposición adaptada al ancho disponible. | Conservar acceso a los módulos en pantallas estrechas. |

Los CTA de la página pública que abren la Web Application comparten el punto de entrada. Dentro de la aplicación, las rutas identifican las vistas y el título del navegador se actualiza con la sección seleccionada.
