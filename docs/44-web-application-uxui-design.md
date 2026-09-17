# 4.4. Web Applications UX/UI Design

El diseño de experiencia de usuario (UX) y diseño de interfaz de usuario (UI) en la plataforma web de **Medical SmartBox** busca crear una herramienta digital intuitiva, accesible y altamente funcional para operadores logísticos, conductores de transporte médico y personal receptor en hospitales o farmacias. La UX se enfoca en comprender la urgencia y precisión requeridas en la cadena de frío, diseñando flujos de interacción eficientes para monitorear cargas térmicamente sensibles, reaccionar ante desvíos de temperatura y configurar sensores IoT sin fricción.

Por su parte, la UI se encarga del aspecto visual, estructurando de manera clara componentes complejos como dashboards telemétricos en tiempo real, trazabilidad por hitos de envío, gráficos de estabilidad térmica y sistemas de alertas predictivas. Un diseño UX/UI exitoso en Medical SmartBox fusiona una estética tecnológica limpia con la practicidad operativa, ofreciendo una experiencia fluida que transforma datos IoT masivos en decisiones logísticas rápidas que salvan vidas y evitan la merma de medicamentos.

### 4.4.1. Web Applications Wireframes
*   **Acceso y Autenticación Segura:** El flujo de inicio de sesión presenta un diseño *desktop* de dos columnas ("auth-shell"). La izquierda actúa como un panel informativo destacando la propuesta de valor ("Cadena de frío bajo custodia digital") y estadísticas de la flota, mientras que la derecha contiene el formulario de acceso institucional que solicita RUC/Correo y Contraseña. A esto le sigue una pantalla obligatoria de Verificación en Dos Pasos (2FA) mediante un código OTP de 6 dígitos

![Autenticacion - Wireframe](assets/chapter-4/autenticacion-wireframe.png)

*   **Núcleo Operativo - Dashboard Principal:** El Dashboard general organiza la vista del operador comenzando con una fila de KPIs (unidades en ruta, monitorizadas, alertas críticas y cumplimiento DIGEMID). En el cuerpo central, se emplea una estructura de cuadrícula (`grid-2`) que muestra un mapa de "Flota en tiempo real" a la izquierda y un panel consolidado de "Alertas críticas recientes" a la derecha, finalizando con una tabla inferior para los "Traslados en curso"

![Nucleo Operativo  - Wireframe](assets/chapter-4/nucleo-wireframe.png)

*   **Gestión de Envíos y Tablero de Despacho:** El sistema incluye una lista maestra de "Órdenes de traslado" y un formulario completo para crear una nueva orden validando ventana de isquemia fría y precooling. Además, presenta un Tablero de Despacho en formato Kanban que categoriza los viajes en Pendientes, Despachados, En tránsito y Entregados

![Gestion de Envios  - Wireframe](assets/chapter-4/envios-wireframe.png)

*   **Vista Detallada de Telemetría y Ruta:** La inspección individual de un envío presenta un *stepper* de estado en la parte superior. Debajo, se divide en dos módulos: a la izquierda, el mapa de trazabilidad y ruta en vivo con cálculo de ETA dinámico; a la derecha, las tarjetas telemétricas y medidores (*gauges*) mostrando la temperatura interna en tiempo real (ej. 4.3°C), nivel de batería, estado de cierre y lecturas recientes.

![Vista de Ruta  - Wireframe](assets/chapter-4/ruta-wireframe.png)

*   **Monitoreo y Control de Smart Containers:** Se incluye un módulo visual tipo *grid* para monitorear todos los contenedores de la flota y una vista de detalle por Smart Container que incluye una curva gráfica de temperatura de las últimas 24 horas. Complementariamente, el sistema permite enviar comandos de desbloqueo remoto de la tapa mediante interacción electromecánica y visualizar el historial completo de excursiones térmicas.

![Monitoreo de Containers  - Wireframe](assets/chapter-4/containers-wireframe.png)

*   **Centro de Alertas y Respuesta a Incidentes:** La plataforma cuenta con una bandeja centralizada para gestionar notificaciones. El detalle de una alerta crítica expone la magnitud de la excursión térmica (temperatura, duración, ubicación), el registro temporal del despacho de alertas (vía SMS y Push) y una sección para que el operador documente las acciones correctivas.

![Centro de Alertas  - Wireframe](assets/chapter-4/incidentes-wireframe.png)

*   **Configuración y Umbrales de Alerta:** Una pantalla de administración dedicada a "Canales de notificación" permite al usuario activar/desactivar notificaciones Push, SMS, Correo y alarmas acústicas. Aquí mismo, en el panel "Umbrales de severidad", se configuran manualmente los límites máximos/mínimos de temperatura y los tiempos límite (SLA) para el envío de alertas.

![Umbrales de Alerta  - Wireframe](assets/chapter-4/alerta-wireframe.png)

*   **Cadena de Custodia, Manifiestos y Reportes:** El flujo de entrega garantiza la seguridad exigiendo la Verificación OTP en destino y trazando todos los eventos en una Línea de Tiempo de Cadena de Custodia. Administrativamente, se generan Manifiestos Digitales de Auditoría inmutables sellados con SHA-256 y se presenta un consolidado analítico para cumplimiento normativo DIGEMID/DIGDOT

![Cadena de Custodia  - Wireframe](assets/chapter-4/custodia-wireframe.png)

*   **Administración Institucional y B2B:** La plataforma incluye la gestión integral de la suscripción, facturación B2B, vinculación de unidades vehiculares y el control granular de usuarios organizados en roles operativos de logística o perfiles clínicos.
   
![Administracion - Wireframe](assets/chapter-4/administracion-wireframes.png)

### 4.4.2. Web Applications Wireflow Diagrams

Los diagramas de wireflow documentan el flujo de navegación pantalla a pantalla combinando la estructura esquemática de los wireframes con los conectores de decisión e interacción del usuario en la Web Application.

*Nota: Los flujos detallados de navegación de alta fidelidad y decisiones de usuario se formalizan en la sección 4.4.4 mediante los diagramas de User Flow.*

### 4.4.3. Web Applications Mock-ups

Esta imagen presenta el diseño de interfaz de usuario (UI) en alta fidelidad para el flujo de acceso institucional a Medical SmartBox. La vista se divide en dos columnas: el panel izquierdo refuerza la propuesta de valor de la plataforma ("Cadena de frío bajo custodia digital") y muestra estadísticas clave de la flota. El panel derecho contiene el formulario de inicio de sesión, seguido de un flujo obligatorio de Verificación en Dos Pasos (2FA), donde el operador debe ingresar un código OTP de 6 dígitos. Este diseño garantiza un acceso seguro restringido a personal autorizado, manteniendo una estética corporativa e intuitiva.

![Mockup01 - Wireframe](assets/chapter-4/mockup-1.png)

Esta imagen detalla el Dashboard General de Operaciones. La interfaz aprovecha el espacio horizontal para presentar una fila superior de indicadores clave de rendimiento (KPIs), como traslados activos, unidades monitorizadas, alertas críticas y cumplimiento térmico. El cuerpo central se divide en dos áreas principales: a la izquierda, un mapa interactivo que ubica la flota en tiempo real dentro de Lima Metropolitana; a la derecha, un panel que consolida las alertas críticas más recientes. En la parte inferior, una tabla estructurada permite visualizar rápidamente los traslados en curso, ofreciendo al operador logístico un centro de control integral en una sola vista.

![Mockup02 - Wireframe](assets/chapter-4/mockup-2.png)

Esta imagen ilustra las interfaces dedicadas a la planificación y seguimiento logístico. El diseño incluye una lista navegable de Órdenes de Traslado y un formulario de creación que integra validaciones automáticas de isquemia fría y pre-enfriamiento del contenedor. Destaca el Tablero de Despacho en formato Kanban, que categoriza visualmente el estado de cada viaje (Pendiente, Despachado, En tránsito, Entregado). Además, la vista de detalle de un viaje específico divide la pantalla para mostrar, simultáneamente, la ruta en vivo con el cálculo de ETA dinámico y la telemetría en tiempo real del Smart Container asociado.

![Mockup03 - Wireframe](assets/chapter-4/mockup-3.png)

Esta imagen presenta los módulos de monitoreo y control a nivel de hardware IoT. La interfaz ofrece una vista en cuadrícula de todos los Smart Containers activos. Al inspeccionar una unidad individual (SB-0231), el usuario accede a un panel detallado que muestra medidores circulares (*gauges*) para la temperatura actual y el nivel de batería, junto con un gráfico que traza la curva térmica de las últimas 24 horas. Estos paneles también incluyen herramientas para revisar el historial completo de excursiones térmicas exportable para auditoría, y controles directos para accionar el bloqueo o desbloqueo electromecánico de la tapa del contenedor mediante comandos MQTT.

![Mockup04 - Wireframe](assets/chapter-4/mockup-4.png)

Esta imagen expone el Centro de Alertas Críticas y la gestión de incidentes. La bandeja principal clasifica las notificaciones por severidad, permitiendo al operador priorizar la atención. El detalle de un incidente (por ejemplo, una excursión térmica crítica) presenta una vista estructurada que documenta la temperatura registrada, la duración fuera del umbral, y un registro temporal (*timeline*) del despacho automático de notificaciones vía Push y SMS. La interfaz fomenta la resolución eficiente al incluir un campo de texto donde el operador puede registrar las acciones correctivas tomadas y un botón para marcar la alerta como resuelta.

![Mockup05 - Wireframe](assets/chapter-4/mockup-5.png)

Esta imagen detalla el panel de Perfil, Configuración y roles de acceso. La interfaz de configuración permite al administrador gestionar los "Canales de notificación", activando o desactivando avisos vía SMS, Push, correo y alarma acústica, así como definir los umbrales de temperatura y SLA críticos. Complementariamente, se incluyen vistas para la gestión del personal, donde se listan los usuarios activos y se asignan permisos granulares a través de perfiles específicos, divididos entre el segmento operativo (Fleet Logistics Dispatcher) y el segmento clínico (Receiving Physician, Health Quality Auditor).

![Mockup06 - Wireframe](assets/chapter-4/mockup-6.png)

Esta imagen muestra los módulos orientados a la auditoría, la trazabilidad y el cumplimiento normativo. Destaca el flujo de entrega, que exige la validación de un código OTP en el punto de destino para desbloquear el contenedor, evento que queda registrado en la Línea de Tiempo de Cadena de Custodia. El sistema genera manifiestos digitales de cada traslado, los cuales son sellados criptográficamente (SHA-256) para garantizar su inmutabilidad. Finalmente, un panel de reportes consolida el rendimiento térmico mensual de las distintas sedes, facilitando la presentación de datos ante entidades regulatorias como DIGEMID.

![Mockup07 - Wireframe](assets/chapter-4/mockup-7.png)

### 4.4.4. Web Applications User Flow Diagrams

El diagrama de flujo de usuario es una representación visual de las acciones secuenciales que un operador logístico, supervisor hospitalario o personal médico realiza al interactuar con el ecosistema digital de NeonCode. A continuación se presentan tres diagramas de flujo clave adaptados a las historias de usuario de la plataforma, detallando el *Happy Path* (ruta ideal) y las ramificaciones alternativas (errores de validación, fallas de conectividad IoT y desviaciones en la cadena de frío).

**User Flow 1: Autenticación de Personal y Acceso al Panel**
*   **User Stories relacionadas:** US01, US02
*   **Flujos incluidos:** *Happy Path* (autenticación exitosa y acceso al panel), credenciales inválidas, cuenta institucional no activada, campos incompletos y reintentos de sesión.

![Primer User Flow](assets/chapter-4/user-flow-1.png)

**User Flow 2: Alta de Ambulancia y Vinculación de Contenedor Inteligente**
*   **User Stories relacionadas:** US07, US08
*   **Flujos incluidos:** *Happy Path* (registro de vehículo y asignación telemétrica de contenedor), matrícula de ambulancia duplicada, ID de contenedor no encontrado, contenedor previamente asignado a otro vehículo y falla de enlace telemétrico inicial.

![Segundo User Flow](assets/chapter-4/user-flow-2.png)

**User Flow 3: Monitoreo Térmico en Ruta, Gestión de Alertas y Cierre de Custodia**
*   **User Stories relacionadas:** US10, US11, US13, US14, US17
*   **Flujos incluidos:** *Happy Path* (monitoreo en tiempo real, recepción de alerta por variación térmica, acción correctiva y confirmación de entrega), pérdida de señal del contenedor, umbral térmico no configurado, variación de stock por sensores de peso e incidencia no resuelta en ruta.

![Tercer User Flow](assets/chapter-4/user-flow-3.png)
