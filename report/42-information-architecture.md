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
