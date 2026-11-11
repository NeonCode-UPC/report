# 4.4. Web Applications UX/UI Design

La Web Application es la interfaz de operación de Medical SmartBox. El showcase interactivo reúne 64 pantallas organizadas por tareas y roles de operador, personal médico y supervisor. Esta sección documenta su estructura, las transiciones entre pantallas y las vistas que se usarán como evidencia del diseño.

### 4.4.1. Web Applications Wireframes

Las vistas comparten una estructura que permite localizar el módulo actual y operar sobre su contenido.

| Zona | Contenido |
| --- | --- |
| Barra superior | Marca, filtro global, notificaciones, usuario, rol e institución. |
| Barra lateral | Módulos agrupados por tarea, según la sección 4.2.5. |
| Ruta y área de contenido | Breadcrumbs, título de vista, KPIs, paneles, formularios o listas según el módulo. |
| Adaptación mobile (≤ 700 px) | Contenido en una columna y navegación accesible mediante menú compacto. |

| Wireframe | Vista representada | User Stories relacionadas |
| --- | --- | --- |
| W01 | Inicio de sesión y verificación de identidad | US01, US02 |
| W02 | Panel del operador y lista de traslados | US14 |
| W03 | Ambulancias e inventario de SmartBox | US07, US08 |
| W04 | Monitoreo térmico y control de stock | US10, US11 |
| W05 | Umbrales y reglas de alerta | US13 |
| W06 | Cadena de custodia y reportes | US16, US17 |

**Wireframes desktop.** La lámina debe reunir las seis vistas W01–W06 y mostrar jerarquía, zonas de información, controles principales y navegación compartida en escala de grises. Ruta prevista: [webapp-wireframes-desktop.png](../assets/chapter-4/webapp-wireframes-desktop.png).

**Wireframes mobile.** La lámina debe adaptar esas mismas seis vistas a una columna, mostrar el menú compacto y conservar visibles las acciones operativas prioritarias. Ruta prevista: [webapp-wireframes-mobile.png](../assets/chapter-4/webapp-wireframes-mobile.png).

*Nota: Las láminas están pendientes de creación. Las rutas son destinos previstos dentro de `assets/chapter-4/`; no se han agregado archivos de imagen ficticios.*

### 4.4.2. Web Applications Wireflow Diagrams

Cada wireflow conecta wireframes mediante flechas que nombran la acción o condición que produce la transición. Los recorridos incluyen su resultado esperado y las alternativas relevantes.

| Wireflow | User Goal | Persona principal | User Stories |
| --- | --- | --- | --- |
| WF1 | Acceder a la cuenta y completar la verificación de identidad | Aldair Lazaro y Gianfranco Timoteo | US01, US02 |
| WF2 | Resolver una alerta térmica durante un traslado | Gianfranco Timoteo | US14 |
| WF3 | Vincular un SmartBox disponible a una ambulancia | Gianfranco Timoteo | US07, US08 |
| WF4 | Preparar y crear un traslado médico | Gianfranco Timoteo | US07 y US08 dan soporte parcial; no hay una historia específica de creación de traslado en 3.1 |
| WF5 | Confirmar la recepción y cerrar la cadena de custodia | Aldair Lazaro y Gianfranco Timoteo | US17 |
| WF6 | Configurar umbrales y generar un reporte de trazabilidad | Gianfranco Timoteo | US13, US16 |

**WF1 · Acceso e identidad.** Credenciales → validación → verificación en dos pasos → código válido → panel por rol. Las alternativas representan credenciales inválidas, código incorrecto y recuperación de contraseña. Archivo previsto: [webapp-wireflow-01-acceso.png](../assets/chapter-4/webapp-wireflow-01-acceso.png).

**WF2 · Incidente térmico.** Panel → traslado activo → detalle de alerta → registro de acción correctiva → estado actualizado. La rama alternativa conserva el caso sin alertas o con pérdida de conexión. Archivo previsto: [webapp-wireflow-02-incidente-termico.png](../assets/chapter-4/webapp-wireflow-02-incidente-termico.png).

**WF3 · Flota y SmartBox.** Inventario → alta o detalle de ambulancia → vincular contenedor → seleccionar SmartBox → confirmar asociación. Las ramas alternativas muestran matrícula duplicada o dispositivo ya vinculado. Archivo previsto: [webapp-wireflow-03-flota-smartbox.png](../assets/chapter-4/webapp-wireflow-03-flota-smartbox.png).

**WF4 · Nuevo traslado.** Traslados → nuevo traslado → completar datos → revisar → confirmar. Las alternativas incluyen cancelación y una ruta que supera el límite de isquemia fría. La relación de este objetivo con US07–US08 es parcial; 3.1 no especifica la creación de un traslado como una historia independiente. Archivo previsto: [webapp-wireflow-04-nuevo-traslado.png](../assets/chapter-4/webapp-wireflow-04-nuevo-traslado.png).

**WF5 · Recepción y custodia.** Detalle del traslado → confirmar recepción → verificar código → cerrar y consultar la custodia. Las ramas alternativas incluyen código incorrecto o excursión térmica pendiente. Archivo previsto: [webapp-wireflow-05-custodia.png](../assets/chapter-4/webapp-wireflow-05-custodia.png).

**WF6 · Umbrales y trazabilidad.** Configuración de umbrales → validar regla → guardar → consultar custodia → generar reporte. La alternativa muestra un umbral inválido. Archivo previsto: [webapp-wireflow-06-umbrales-reportes.png](../assets/chapter-4/webapp-wireflow-06-umbrales-reportes.png).

*Nota: Los seis diagramas están pendientes de creación. Cada imagen debe mostrar las pantallas esquemáticas como pasos y etiquetar sus flechas con la acción, decisión o resultado correspondiente.*

### 4.4.3. Web Applications Mock-ups

Los mock-ups se documentan mediante capturas del showcase interactivo. Las 64 pantallas se distribuyen por recorrido y área funcional:

| Grupo | Pantallas | Contenido principal |
| --- | ---: | --- |
| Acceso e identidad | 10 | Inicio de sesión, credenciales inválidas, verificación en dos pasos, recuperación de contraseña y registro de institución. |
| Recorrido 1 · Operador | 12 | Panel, traslados, ruta y ETA, alertas, incidentes, historial y estado sin alertas. |
| Recorrido 2 · Flota | 12 | Ambulancias, inventario de SmartBox, vincular o desvincular, y alta de ambulancia. |
| Recorrido 3 · Nuevo traslado | 6 | Formulario, revisión, creación, cancelación e historial. |
| Recorrido 4 · Personal médico | 8 | Monitoreo, excursión térmica, control de stock, telemetría, recepción y custodia. |
| Recorrido 5 · Supervisor | 9 | Umbrales, reglas de alerta, custodia, acta digital, reportes y auditoría. |
| Administración y cuenta | 7 | Usuarios, roles, suscripción, perfil y notificaciones. |
| **Total** | **64** | |

Las pantallas del showcase incluyen estados de carga, error con opción de reintento y estado vacío (“Sin alertas”). La interfaz de esta versión está en español.

Las siete capturas deben mostrar pantallas reales del showcase y sus estados representativos. No deben sustituirse por composiciones de alta fidelidad que no existan en el producto.

| Captura pendiente | Contenido que debe verse | Ruta prevista |
| --- | --- | --- |
| Mock-up 01 · Acceso | Inicio de sesión, credenciales inválidas y verificación en dos pasos. | [webapp-mockup-01-acceso.png](../assets/chapter-4/webapp-mockup-01-acceso.png) |
| Mock-up 02 · Operador | Panel, ruta y ETA, alerta crítica y estado vacío. | [webapp-mockup-02-operador.png](../assets/chapter-4/webapp-mockup-02-operador.png) |
| Mock-up 03 · Flota | Lista de ambulancias y SmartBox, alta y vinculación. | [webapp-mockup-03-flota.png](../assets/chapter-4/webapp-mockup-03-flota.png) |
| Mock-up 04 · Nuevo traslado | Formulario, revisión, confirmación y cancelación. | [webapp-mockup-04-nuevo-traslado.png](../assets/chapter-4/webapp-mockup-04-nuevo-traslado.png) |
| Mock-up 05 · Personal médico | Lectura térmica, telemetría, recepción y cierre de custodia. | [webapp-mockup-05-personal-medico.png](../assets/chapter-4/webapp-mockup-05-personal-medico.png) |
| Mock-up 06 · Supervisor | Umbrales, alerta, acta digital, reporte y auditoría. | [webapp-mockup-06-supervisor.png](../assets/chapter-4/webapp-mockup-06-supervisor.png) |
| Mock-up 07 · Administración | Usuarios y roles, suscripción, perfil y notificaciones. | [webapp-mockup-07-administracion.png](../assets/chapter-4/webapp-mockup-07-administracion.png) |

*Nota: Las capturas están pendientes. Cada ruta es un destino previsto dentro de `assets/chapter-4/`; no se han agregado archivos de imagen ficticios.*
