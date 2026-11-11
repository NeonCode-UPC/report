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
