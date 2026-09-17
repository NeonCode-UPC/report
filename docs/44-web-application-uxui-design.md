# 4.4. Web Applications UX/UI Design

El diseÃ±o de experiencia de usuario (UX) y diseÃ±o de interfaz de usuario (UI) en la plataforma web de **Medical SmartBox** busca crear una herramienta digital intuitiva, accesible y altamente funcional para operadores logÃ­sticos, conductores de transporte mÃ©dico y personal receptor en hospitales o farmacias. La UX se enfoca en comprender la urgencia y precisiÃ³n requeridas en la cadena de frÃ­o, diseÃ±ando flujos de interacciÃ³n eficientes para monitorear cargas tÃ©rmicamente sensibles, reaccionar ante desvÃ­os de temperatura y configurar sensores IoT sin fricciÃ³n.

Por su parte, la UI se encarga del aspecto visual, estructurando de manera clara componentes complejos como dashboards telemÃ©tricos en tiempo real, trazabilidad por hitos de envÃ­o, grÃ¡ficos de estabilidad tÃ©rmica y sistemas de alertas predictivas. Un diseÃ±o UX/UI exitoso en Medical SmartBox fusiona una estÃ©tica tecnolÃ³gica limpia con la practicidad operativa, ofreciendo una experiencia fluida que transforma datos IoT masivos en decisiones logÃ­sticas rÃ¡pidas que salvan vidas y evitan la merma de medicamentos.

### 4.4.1. Web Applications Wireframes
*   **Acceso y AutenticaciÃ³n Segura:** El flujo de inicio de sesiÃ³n presenta un diseÃ±o *desktop* de dos columnas ("auth-shell"). La izquierda actÃºa como un panel informativo destacando la propuesta de valor ("Cadena de frÃ­o bajo custodia digital") y estadÃ­sticas de la flota, mientras que la derecha contiene el formulario de acceso institucional que solicita RUC/Correo y ContraseÃ±a. A esto le sigue una pantalla obligatoria de VerificaciÃ³n en Dos Pasos (2FA) mediante un cÃ³digo OTP de 6 dÃ­gitos

![Autenticacion - Wireframe](assets/chapter-4/autenticacion-wireframe.png)

*   **NÃºcleo Operativo - Dashboard Principal:** El Dashboard general organiza la vista del operador comenzando con una fila de KPIs (unidades en ruta, monitorizadas, alertas crÃ­ticas y cumplimiento DIGEMID). En el cuerpo central, se emplea una estructura de cuadrÃ­cula (`grid-2`) que muestra un mapa de "Flota en tiempo real" a la izquierda y un panel consolidado de "Alertas crÃ­ticas recientes" a la derecha, finalizando con una tabla inferior para los "Traslados en curso"

![Nucleo Operativo  - Wireframe](assets/chapter-4/nucleo-wireframe.png)

*   **GestiÃ³n de EnvÃ­os y Tablero de Despacho:** El sistema incluye una lista maestra de "Ã“rdenes de traslado" y un formulario completo para crear una nueva orden validando ventana de isquemia frÃ­a y precooling. AdemÃ¡s, presenta un Tablero de Despacho en formato Kanban que categoriza los viajes en Pendientes, Despachados, En trÃ¡nsito y Entregados

![Gestion de Envios  - Wireframe](assets/chapter-4/envios-wireframe.png)

*   **Vista Detallada de TelemetrÃ­a y Ruta:** La inspecciÃ³n individual de un envÃ­o presenta un *stepper* de estado en la parte superior. Debajo, se divide en dos mÃ³dulos: a la izquierda, el mapa de trazabilidad y ruta en vivo con cÃ¡lculo de ETA dinÃ¡mico; a la derecha, las tarjetas telemÃ©tricas y medidores (*gauges*) mostrando la temperatura interna en tiempo real (ej. 4.3Â°C), nivel de baterÃ­a, estado de cierre y lecturas recientes.

![Vista de Ruta  - Wireframe](assets/chapter-4/ruta-wireframe.png)

*   **Monitoreo y Control de Smart Containers:** Se incluye un mÃ³dulo visual tipo *grid* para monitorear todos los contenedores de la flota y una vista de detalle por Smart Container que incluye una curva grÃ¡fica de temperatura de las Ãºltimas 24 horas. Complementariamente, el sistema permite enviar comandos de desbloqueo remoto de la tapa mediante interacciÃ³n electromecÃ¡nica y visualizar el historial completo de excursiones tÃ©rmicas.

![Monitoreo de Containers  - Wireframe](assets/chapter-4/containers-wireframe.png)

*   **Centro de Alertas y Respuesta a Incidentes:** La plataforma cuenta con una bandeja centralizada para gestionar notificaciones. El detalle de una alerta crÃ­tica expone la magnitud de la excursiÃ³n tÃ©rmica (temperatura, duraciÃ³n, ubicaciÃ³n), el registro temporal del despacho de alertas (vÃ­a SMS y Push) y una secciÃ³n para que el operador documente las acciones correctivas.

![Centro de Alertas  - Wireframe](assets/chapter-4/incidentes-wireframe.png)

*   **ConfiguraciÃ³n y Umbrales de Alerta:** Una pantalla de administraciÃ³n dedicada a "Canales de notificaciÃ³n" permite al usuario activar/desactivar notificaciones Push, SMS, Correo y alarmas acÃºsticas. AquÃ­ mismo, en el panel "Umbrales de severidad", se configuran manualmente los lÃ­mites mÃ¡ximos/mÃ­nimos de temperatura y los tiempos lÃ­mite (SLA) para el envÃ­o de alertas.

![Umbrales de Alerta  - Wireframe](assets/chapter-4/alerta-wireframe.png)

*   **Cadena de Custodia, Manifiestos y Reportes:** El flujo de entrega garantiza la seguridad exigiendo la VerificaciÃ³n OTP en destino y trazando todos los eventos en una LÃ­nea de Tiempo de Cadena de Custodia. Administrativamente, se generan Manifiestos Digitales de AuditorÃ­a inmutables sellados con SHA-256 y se presenta un consolidado analÃ­tico para cumplimiento normativo DIGEMID/DIGDOT

![Cadena de Custodia  - Wireframe](assets/chapter-4/custodia-wireframe.png)

*   **AdministraciÃ³n Institucional y B2B:** La plataforma incluye la gestiÃ³n integral de la suscripciÃ³n, facturaciÃ³n B2B, vinculaciÃ³n de unidades vehiculares y el control granular de usuarios organizados en roles operativos de logÃ­stica o perfiles clÃ­nicos.
   
![Administracion - Wireframe](assets/chapter-4/administracion-wireframes.png)

### 4.4.2. Web Applications Wireflow Diagrams

Los diagramas de wireflow documentan el flujo de navegación pantalla a pantalla combinando la estructura esquemática de los wireframes con los conectores de decisión e interacción del usuario en la Web Application.

*Nota: Los flujos detallados de navegación de alta fidelidad y decisiones de usuario se formalizan en la sección 4.4.4 mediante los diagramas de User Flow.*

### 4.4.3. Web Applications Mock-ups

Esta imagen presenta el diseÃ±o de interfaz de usuario (UI) en alta fidelidad para el flujo de acceso institucional a Medical SmartBox. La vista se divide en dos columnas: el panel izquierdo refuerza la propuesta de valor de la plataforma ("Cadena de frÃ­o bajo custodia digital") y muestra estadÃ­sticas clave de la flota. El panel derecho contiene el formulario de inicio de sesiÃ³n, seguido de un flujo obligatorio de VerificaciÃ³n en Dos Pasos (2FA), donde el operador debe ingresar un cÃ³digo OTP de 6 dÃ­gitos. Este diseÃ±o garantiza un acceso seguro restringido a personal autorizado, manteniendo una estÃ©tica corporativa e intuitiva.

![Mockup01 - Wireframe](assets/chapter-4/mockup-1.png)

Esta imagen detalla el Dashboard General de Operaciones. La interfaz aprovecha el espacio horizontal para presentar una fila superior de indicadores clave de rendimiento (KPIs), como traslados activos, unidades monitorizadas, alertas crÃ­ticas y cumplimiento tÃ©rmico. El cuerpo central se divide en dos Ã¡reas principales: a la izquierda, un mapa interactivo que ubica la flota en tiempo real dentro de Lima Metropolitana; a la derecha, un panel que consolida las alertas crÃ­ticas mÃ¡s recientes. En la parte inferior, una tabla estructurada permite visualizar rÃ¡pidamente los traslados en curso, ofreciendo al operador logÃ­stico un centro de control integral en una sola vista.

![Mockup02 - Wireframe](assets/chapter-4/mockup-2.png)

Esta imagen ilustra las interfaces dedicadas a la planificaciÃ³n y seguimiento logÃ­stico. El diseÃ±o incluye una lista navegable de Ã“rdenes de Traslado y un formulario de creaciÃ³n que integra validaciones automÃ¡ticas de isquemia frÃ­a y pre-enfriamiento del contenedor. Destaca el Tablero de Despacho en formato Kanban, que categoriza visualmente el estado de cada viaje (Pendiente, Despachado, En trÃ¡nsito, Entregado). AdemÃ¡s, la vista de detalle de un viaje especÃ­fico divide la pantalla para mostrar, simultÃ¡neamente, la ruta en vivo con el cÃ¡lculo de ETA dinÃ¡mico y la telemetrÃ­a en tiempo real del Smart Container asociado.

![Mockup03 - Wireframe](assets/chapter-4/mockup-3.png)

Esta imagen presenta los mÃ³dulos de monitoreo y control a nivel de hardware IoT. La interfaz ofrece una vista en cuadrÃ­cula de todos los Smart Containers activos. Al inspeccionar una unidad individual (SB-0231), el usuario accede a un panel detallado que muestra medidores circulares (*gauges*) para la temperatura actual y el nivel de baterÃ­a, junto con un grÃ¡fico que traza la curva tÃ©rmica de las Ãºltimas 24 horas. Estos paneles tambiÃ©n incluyen herramientas para revisar el historial completo de excursiones tÃ©rmicas exportable para auditorÃ­a, y controles directos para accionar el bloqueo o desbloqueo electromecÃ¡nico de la tapa del contenedor mediante comandos MQTT.

![Mockup04 - Wireframe](assets/chapter-4/mockup-4.png)

Esta imagen expone el Centro de Alertas CrÃ­ticas y la gestiÃ³n de incidentes. La bandeja principal clasifica las notificaciones por severidad, permitiendo al operador priorizar la atenciÃ³n. El detalle de un incidente (por ejemplo, una excursiÃ³n tÃ©rmica crÃ­tica) presenta una vista estructurada que documenta la temperatura registrada, la duraciÃ³n fuera del umbral, y un registro temporal (*timeline*) del despacho automÃ¡tico de notificaciones vÃ­a Push y SMS. La interfaz fomenta la resoluciÃ³n eficiente al incluir un campo de texto donde el operador puede registrar las acciones correctivas tomadas y un botÃ³n para marcar la alerta como resuelta.

![Mockup05 - Wireframe](assets/chapter-4/mockup-5.png)

Esta imagen detalla el panel de Perfil, ConfiguraciÃ³n y roles de acceso. La interfaz de configuraciÃ³n permite al administrador gestionar los "Canales de notificaciÃ³n", activando o desactivando avisos vÃ­a SMS, Push, correo y alarma acÃºstica, asÃ­ como definir los umbrales de temperatura y SLA crÃ­ticos. Complementariamente, se incluyen vistas para la gestiÃ³n del personal, donde se listan los usuarios activos y se asignan permisos granulares a travÃ©s de perfiles especÃ­ficos, divididos entre el segmento operativo (Fleet Logistics Dispatcher) y el segmento clÃ­nico (Receiving Physician, Health Quality Auditor).

![Mockup06 - Wireframe](assets/chapter-4/mockup-6.png)

Esta imagen muestra los mÃ³dulos orientados a la auditorÃ­a, la trazabilidad y el cumplimiento normativo. Destaca el flujo de entrega, que exige la validaciÃ³n de un cÃ³digo OTP en el punto de destino para desbloquear el contenedor, evento que queda registrado en la LÃ­nea de Tiempo de Cadena de Custodia. El sistema genera manifiestos digitales de cada traslado, los cuales son sellados criptogrÃ¡ficamente (SHA-256) para garantizar su inmutabilidad. Finalmente, un panel de reportes consolida el rendimiento tÃ©rmico mensual de las distintas sedes, facilitando la presentaciÃ³n de datos ante entidades regulatorias como DIGEMID.

![Mockup07 - Wireframe](assets/chapter-4/mockup-7.png)

### 4.4.4. Web Applications User Flow Diagrams

El diagrama de flujo de usuario es una representaciÃ³n visual de las acciones secuenciales que un operador logÃ­stico, supervisor hospitalario o personal mÃ©dico realiza al interactuar con el ecosistema digital de NeonCode. A continuaciÃ³n se presentan tres diagramas de flujo clave adaptados a las historias de usuario de la plataforma, detallando el *Happy Path* (ruta ideal) y las ramificaciones alternativas (errores de validaciÃ³n, fallas de conectividad IoT y desviaciones en la cadena de frÃ­o).

**User Flow 1: AutenticaciÃ³n de Personal y Acceso al Panel**
*   **User Stories relacionadas:** US01, US02
*   **Flujos incluidos:** *Happy Path* (autenticaciÃ³n exitosa y acceso al panel), credenciales invÃ¡lidas, cuenta institucional no activada, campos incompletos y reintentos de sesiÃ³n.

![Primer User Flow](assets/chapter-4/user-flow-1.png)

**User Flow 2: Alta de Ambulancia y VinculaciÃ³n de Contenedor Inteligente**
*   **User Stories relacionadas:** US07, US08
*   **Flujos incluidos:** *Happy Path* (registro de vehÃ­culo y asignaciÃ³n telemÃ©trica de contenedor), matrÃ­cula de ambulancia duplicada, ID de contenedor no encontrado, contenedor previamente asignado a otro vehÃ­culo y falla de enlace telemÃ©trico inicial.

![Segundo User Flow](assets/chapter-4/user-flow-2.png)

**User Flow 3: Monitoreo TÃ©rmico en Ruta, GestiÃ³n de Alertas y Cierre de Custodia**
*   **User Stories relacionadas:** US10, US11, US13, US14, US17
*   **Flujos incluidos:** *Happy Path* (monitoreo en tiempo real, recepciÃ³n de alerta por variaciÃ³n tÃ©rmica, acciÃ³n correctiva y confirmaciÃ³n de entrega), pÃ©rdida de seÃ±al del contenedor, umbral tÃ©rmico no configurado, variaciÃ³n de stock por sensores de peso e incidencia no resuelta en ruta.

![Tercer User Flow](assets/chapter-4/user-flow-3.png)
