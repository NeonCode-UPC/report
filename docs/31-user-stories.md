# 3.1. User Stories

En esta sección se detallan las 18 historias de usuario (User Stories) que estructuran el alcance funcional del ecosistema **NeonCode**. La especificación abarca la aplicación web responsive de monitoreo, el sitio web público (Landing Page) y la interfaz de servicios backend (RESTful API) para la supervisión en tiempo real de contenedores médicos inteligentes instalados en ambulancias.

Todos los criterios de aceptación siguen la especificación **Gherkin** (Dado que / Cuando / Entonces), redactados en tercera persona, tiempo presente y enfocados en las reglas de negocio del dominio de salud y logística médica, omitiendo referencias a elementos de interfaz de usuario.

| Epic / Story ID | Título | Descripción | Criterios de Aceptación | Relacionado con (Epic ID) |
| :--- | :--- | :--- | :--- | :--- |
| **EP01** | Identity & Access Management | Épica destinada a la gestión de accesos, roles, autenticación segura y perfiles de instituciones de salud. | N/A | N/A |
| **US01** | Registro de Institución de Salud | Como supervisor hospitalario, deseo registrar mi centro médico en la plataforma NeonCode para gestionar la flota de ambulancias y contenedores. | **Dado que** la institución de salud no cuenta con una cuenta activa,<br>**Cuando** proporciona el registro institucional y credenciales de acceso válidas,<br>**Entonces** el sistema genera la cuenta corporativa y notifica la activación del perfil. | EP01 |
| **US02** | Autenticación de Personal de Emergencia | Como personal médico de emergencia, deseo autenticarme en la aplicación web para acceder al estado de la carga transportada en tiempo real. | **Dado que** el usuario médico cuenta con credenciales activas,<br>**Cuando** ingresa sus datos de acceso autorizados,<br>**Entonces** el sistema valida la identidad y concede acceso al panel de supervisión. | EP01 |
| **US03** | Endpoint de Autenticación de Usuarios (API) | Como Developer, deseo disponer de un endpoint POST `/api/v1/authentication/sign-in` para validar credenciales y emitir tokens de sesión. | **Dado que** la aplicación cliente envía una solicitud POST con credenciales válidas,<br>**Cuando** la API procesa la autenticación,<br>**Entonces** responde con código HTTP 200 y el token JWT de sesión.<br><br>**Dado que** el cliente envía datos de acceso inválidos,<br>**Cuando** la API procesa la petición,<br>**Entonces** responde con un código HTTP 401 Unauthorized. | EP01 |
| **EP02** | Landing Page & Brand Awareness | Épica orientada a la difusión de la propuesta de valor y captura de prospectos del sector salud. | N/A | N/A |
| **US04** | Exploración de Propuesta de Valor Logística | Como visitante comercial, deseo consultar las capacidades de los contenedores inteligentes en el Landing Page para evaluar su implementación. | **Dado que** el visitante navega en el sitio principal de NeonCode,<br>**Cuando** explora la sección de soluciones para transporte médico,<br>**Entonces** el sistema despliega las especificaciones térmicas, de trazabilidad y planes de servicio. | EP02 |
| **US05** | Solicitud de Demostración Corporativa | Como visitante comercial, deseo enviar un formulario de contacto para solicitar una demostración del sistema en mi centro hospitalario. | **Dado que** el visitante completa sus datos institucionales de contacto,<br>**Cuando** efectúa el envío del formulario,<br>**Entonces** el sistema registra el prospecto y despacha un correo de confirmación al usuario. | EP02 |
| **US06** | Consulta de Preguntas Frecuentes | Como visitante comercial, deseo revisar la sección de FAQ en el Landing Page para resolver dudas sobre la integración IoT en ambulancias. | **Dado que** el visitante ingresa al centro de ayuda del sitio web,<br>**Cuando** selecciona la categoría de hardware y sensores IoT,<br>**Entonces** el sistema muestra las respuestas estructuradas sobre la cadena de frío y conectividad. | EP02 |
| **EP03** | Container & Ambulance Provisioning | Épica para el alta, configuración y vinculación de contenedores IoT y unidades de ambulancia. | N/A | N/A |
| **US07** | Alta de Unidades de Ambulancia | Como operador logístico de salud, deseo registrar vehículos de transporte en el sistema para asociarles contenedores de insumos. | **Dado que** el operador logístico ha iniciado sesión,<br>**Cuando** ingresa los datos de identificación y matrícula de la ambulancia,<br>**Entonces** el sistema registra el vehículo en el inventario activo de la institución. | EP03 |
| **US08** | Vinculación de Contenedor Inteligente | Como operador logístico de salud, deseo vincular un contenedor IoT a una ambulancia específica para iniciar la supervisión de la carga. | **Dado que** el operador selecciona una ambulancia disponible,<br>**Cuando** ingresa el identificador único del contenedor inteligente,<br>**Entonces** el sistema asigna el dispositivo al vehículo y habilita la recepción de telemetría. | EP03 |
| **US09** | Ingesta de Telemetría IoT (API) | Como Developer, deseo contar con un endpoint POST `/api/v1/containers/{containerId}/telemetry` para registrar datos térmicos y de estado. | **Dado que** el contenedor transmite un payload con temperatura, peso, apertura y batería,<br>**Cuando** la API valida y procesa la estructura de datos,<br>**Entonces** almacena la lectura en la base de datos y responde con HTTP 201 Created. | EP03 |
| **EP04** | Real-Time Environmental & Fleet Monitoring | Épica centrada en la supervisión continua de temperatura, inventario por peso, GPS, combustible y ETA. | N/A | N/A |
| **US10** | Monitoreo Térmico y de Apertura | Como personal médico de emergencia, deseo consultar la temperatura interna y el estado de apertura del contenedor para garantizar la cadena de frío. | **Dado que** la ambulancia se encuentra en ruta de traslado,<br>**Cuando** los sensores del contenedor registran cambios térmicos o de escotilla,<br>**Entonces** la plataforma actualiza de forma inmediata las lecturas en la vista de monitoreo. | EP04 |
| **US11** | Control de Stock por Sensores de Peso | Como personal médico de emergencia, deseo verificar la disponibilidad de insumos mediante sensores de peso para confirmar existencias. | **Dado que** el usuario médico consulta el detalle del contenedor,<br>**Cuando** se retira o ingresa un insumo médico,<br>**Entonces** el sistema calcula la diferencia de masa y actualiza el estimado de stock en la plataforma. | EP04 |
| **US12** | Consulta de Telemetría e Indicadores (API) | Como Developer, deseo disponer de un endpoint GET `/api/v1/containers/{containerId}/metrics` para alimentar la vista del panel web. | **Dado que** el cliente web solicita el estado actual de un contenedor,<br>**Cuando** la API procesa la petición con un identificador válido,<br>**Entonces** responde con código HTTP 200 y el objeto JSON con las últimas mediciones. | EP04 |
| **EP05** | Incident Alerts & Medical Dispatch | Épica para la gestión y notificación de incidentes críticos como variaciones térmicas o retrasos. | N/A | N/A |
| **US13** | Configuración de Umbrales Térmicos Críticos | Como supervisor hospitalario, deseo establecer rangos de temperatura permitidos para recibir avisos preventivos ante desviaciones. | **Dado que** el supervisor edita los parámetros de conservación de una carga sensible,<br>**Cuando** guarda los límites mínimos y máximos de temperatura,<br>**Entonces** el sistema registra la regla de negocio para la emisión de alertas. | EP05 |
| **US14** | Visualización de Alertas en Ruta | Como operador logístico de salud, deseo recibir avisos de variaciones térmicas o retrasos para tomar acciones correctivas inmediatas. | **Dado que** un sensor detecta una anomalía de temperatura o nivel crítico de batería,<br>**Cuando** el evento es registrado por el sistema,<br>**Entonces** la plataforma notifica la alerta priorizada en el panel del operador. | EP05 |
| **US15** | Servicio de Despacho de Alertas (API) | Como Developer, deseo contar con un endpoint POST `/api/v1/alerts/dispatch` para procesar notificaciones de emergencia. | **Dado que** la regla de negocio detecta la ruptura de la cadena de frío,<br>**Cuando** la API ejecuta el servicio de despacho,<br>**Entonces** genera la notificación correspondiente y retorna un código HTTP 202 Accepted. | EP05 |
| **EP06** | Chain of Custody & Audit Reports | Épica orientada al registro histórico, trazabilidad de la cadena de custodia y reportes de auditoría. | N/A | N/A |
| **US16** | Generación de Reportes de Trazabilidad | Como supervisor hospitalario, deseo exportar el informe del traslado médico para certificar el cumplimiento de la cadena de frío. | **Dado que** un traslado médico ha finalizado,<br>**Cuando** el supervisor solicita la consolidación del informe de auditoría,<br>**Entonces** el sistema genera un reporte con la gráfica de temperatura, aperturas y tiempos de traslado. | EP06 |
| **US17** | Confirmación de Entrega y Cadena de Custodia | Como personal médico de emergencia, deseo registrar la recepción del contenedor para cerrar la cadena de custodia del envío. | **Dado que** la ambulancia arriba a la institución de destino,<br>**Cuando** el profesional de salud confirma la recepción satisfactoria de la carga,<br>**Entonces** el sistema sella el registro histórico con fecha, hora y responsable de recepción. | EP06 |
| **US18** | Consulta de Historial de Traslados (API) | Como Developer, deseo disponer de un endpoint GET `/api/v1/transfers/{transferId}/audit` para recuperar el registro de auditoría. | **Dado que** se requiere auditar un traslado finalizado,<br>**Cuando** la API procesa la consulta con el identificador de traslado,<br>**Entonces** devuelve un código HTTP 200 con el historial de eventos y datos de telemetría. | EP06 |


En esta sección se especifican las 18 historias de usuario (User Stories) que definen el alcance funcional del ecosistema **NeonCode**. La arquitectura funcional abarca la plataforma web responsive para supervisión hospitalaria y logística, el sitio web público (Landing Page) orientado a la captación de clientes institucionales, y los servicios backend RESTful API para la ingesta y procesamiento de telemetría IoT de contenedores médicos inteligentes.

Todos los criterios de aceptación están redactados en español bajo el estándar **Gherkin** (Dado que / Cuando / Entonces), estructurados en modo orientado a escenarios (*scenario-oriented*), cubriendo flujos exitosos, excepciones y reglas del dominio de la salud.

***

### Epic 01: Identity & Access Management (EP01)

#### **US01: Registro de Institución de Salud**
* **Título:** Registro de Institución de Salud.
* **Descripción:** Como supervisor hospitalario, deseo registrar mi centro médico en la plataforma NeonCode para gestionar la flota de ambulancias y contenedores térmicos inteligentes.
* **Relacionado con:** EP01
* **Criterios de Aceptación:**
    * **Escenario 1: Registro exitoso de institución (Happy Path)**
        * **Dado que** la institución de salud no cuenta con una cuenta previa en el sistema.
        * **Cuando** el usuario ingresa una Razón Social válida, el número de identificación tributaria (RUC) activo, una dirección de correo institucional corporativo y establece una contraseña que cumpla con los estándares de seguridad (mínimo 8 caracteres, mayúscula, número y carácter especial).
        * **Entonces** el sistema crea la cuenta institucional en estado pendiente de verificación y despacha un correo electrónico con un enlace de confirmación al correo proporcionado.
    * **Escenario 2: Intento de registro con identificación tributaria duplicada**
        * **Dado que** ya existe un centro médico registrado con el mismo RUC en la base de datos.
        * **Cuando** el usuario intenta registrarse utilizando dicho número de RUC.
        * **Entonces** el sistema rechaza la solicitud, no genera registros nuevos y notifica que la institución ya se encuentra registrada en la plataforma.
    * **Escenario 3: Validación de formato de correo no corporativo**
        * **Dado que** el usuario ingresa un correo de un dominio público no permitido (ej. @gmail.com, @hotmail.com).
        * **Cuando** intenta enviar el formulario de registro.
        * **Entonces** el sistema bloquea el registro e indica que debe utilizar un dominio de correo institucional.

***

#### **US02: Autenticación de Personal de Emergencia**
* **Título:** Autenticación de Personal de Emergencia.
* **Descripción:** Como personal médico de emergencia, deseo autenticarme en la aplicación web para acceder al estado de la carga transportada en tiempo real durante un traslado.
* **Relacionado con:** EP01
* **Criterios de Aceptación:**
    * **Escenario 1: Inicio de sesión exitoso**
        * **Dado que** el usuario médico cuenta con credenciales activas y confirmadas.
        * **Cuando** ingresa su usuario registrado y contraseña correcta.
        * **Entonces** el sistema valida la identidad, inicia la sesión de usuario y concede acceso inmediato al panel de supervisión de unidades asignadas.
    * **Escenario 2: Intento de acceso con contraseña errónea**
        * **Dado que** el usuario ingresa una contraseña incorrecta para una cuenta existente.
        * **Cuando** solicita iniciar sesión.
        * **Entonces** el sistema deniega el acceso y muestra un mensaje genérico de credenciales inválidas.
    * **Escenario 3: Bloqueo de cuenta por intentos fallidos recurrentes**
        * **Dado que** un usuario acumula 5 intentos fallidos consecutivos de inicio de sesión.
        * **Cuando** realiza el quinto intento incorrecto.
        * **Entonces** el sistema bloquea temporalmente la cuenta por un periodo de 15 minutos y envía una alerta de seguridad al correo registrado.

***

#### **US03: Endpoint de Autenticación de Usuarios (API)**
* **Título:** Endpoint de Autenticación de Usuarios (API).
* **Descripción:** Como Developer, deseo disponer de un endpoint `POST /api/v1/authentication/sign-in` para validar credenciales y emitir tokens de sesión seguros para las aplicaciones clientes.
* **Relacionado con:** EP01
* **Criterios de Aceptación:**
    * **Escenario 1: Petición de autenticación válida**
        * **Dado que** la aplicación cliente envía una solicitud `POST /api/v1/authentication/sign-in` con un cuerpo JSON conteniendo `username` y `password` válidos.
        * **Cuando** la API procesa y verifica las credenciales en la base de datos.
        * **Entonces** responde con un código `HTTP 200 OK`, retornando en la respuesta un objeto JSON con el token JWT de sesión, la fecha de expiración y los roles asociados.
    * **Escenario 2: Credenciales inválidas o inexistentes**
        * **Dado que** el cuerpo de la solicitud contiene credenciales que no coinciden con ningún usuario activo.
        * **Cuando** la API procesa la petición.
        * **Entonces** responde con un código `HTTP 401 Unauthorized` y una estructura JSON estándar de error detallando la denegación de acceso.
    * **Escenario 3: Solicitud con estructura de payload malformada**
        * **Dado que** el cliente envía una petición omitiendo campos requeridos en el JSON.
        * **Cuando** la API ejecuta la validación de entrada.
        * **Entonces** responde con un código `HTTP 400 Bad Request` indicando las reglas de validación no cumplidas.

***

### Epic 02: Landing Page & Brand Awareness (EP02)

#### **US04: Exploración de Propuesta de Valor Logística**
* **Título:** Exploración de Propuesta de Valor Logística.
* **Descripción:** Como visitante comercial, deseo consultar las capacidades de los contenedores inteligentes en el Landing Page para evaluar su implementación en mi centro de salud.
* **Relacionado con:** EP02
* **Criterios de Aceptación:**
    * **Escenario 1: Despliegue de especificaciones técnicas e información de solución**
        * **Dado que** el visitante ingresa al portal público de NeonCode.
        * **Cuando** explora la sección de soluciones para transporte y conservación médica.
        * **Entonces** el sistema presenta la información sobre el rango de control térmico (-20°C a +8°C), autonomía energética, capacidad de sensores de masa/apertura y los planes de suscripción disponibles.
    * **Escenario 2: Disponibilidad y tiempo de respuesta del portal**
        * **Dado que** el visitante solicita la navegación dentro de la plataforma pública.
        * **Cuando** la página carga sus contenidos.
        * **Entonces** los activos de información sobre las características IoT deben renderizarse completamente en un tiempo no mayor a 2 segundos bajo conexiones estándar.

***

#### **US05: Solicitud de Demostración Corporativa**
* **Título:** Solicitud de Demostración Corporativa.
* **Descripción:** Como visitante comercial, deseo enviar un formulario de contacto para solicitar una demostración del sistema en mi centro hospitalario.
* **Relacionado con:** EP02
* **Criterios de Aceptación:**
    * **Escenario 1: Envío exitoso de solicitud de demo**
        * **Dado que** el visitante completa los campos obligatorios del formulario (Nombre, Cargo, Nombre de la Institución, Correo Corporativo, Teléfono y Tamaño de Flota).
        * **Cuando** ejecuta el envío del formulario.
        * **Entonces** el sistema almacena los datos en el módulo de prospectos y envía automáticamente un correo de confirmación de recepción al visitante y una notificación al equipo de ventas.
    * **Escenario 2: Intento de envío con datos incompletos**
        * **Dado que** el visitante omite llenar alguno de los campos obligatorios.
        * **Cuando** intenta enviar el formulario de contacto.
        * **Entonces** el sistema detiene el proceso de envío y notifica de manera específica cuáles campos deben ser completados.

***

#### **US06: Consulta de Preguntas Frecuentes (FAQ)**
* **Título:** Consulta de Preguntas Frecuentes.
* **Descripción:** Como visitante comercial, deseo revisar la sección de FAQ en el Landing Page para resolver dudas sobre la integración del hardware IoT en ambulancias.
* **Relacionado con:** EP02
* **Criterios de Aceptación:**
    * **Escenario 1: Filtrado y visualización de categorías de ayuda**
        * **Dado que** el visitante accede a la sección de soporte del Landing Page.
        * **Cuando** selecciona la categoría de "Hardware y Sensores IoT".
        * **Entonces** el sistema despliega las preguntas y respuestas vinculadas a la homologación de la batería, calibración de sensores de temperatura y soporte de conectividad móvil en ambulancias.
    * **Escenario 2: Búsqueda de palabras clave en el centro de ayuda**
        * **Dado que** el usuario ingresa un término de búsqueda (ej. "Cadena de frío").
        * **Cuando** procesa la consulta en la barra de búsqueda de FAQ.
        * **Entonces** el sistema filtra y expone únicamente aquellos elementos cuya pregunta o respuesta contengan la palabra clave consultada.

***

### Epic 03: Container & Ambulance Provisioning (EP03)

#### **US07: Alta de Unidades de Ambulancia**
* **Título:** Alta de Unidades de Ambulancia.
* **Descripción:** Como operador logístico de salud, deseo registrar vehículos de transporte en el sistema para asociarles posteriormente contenedores de insumos.
* **Relacionado con:** EP03
* **Criterios de Aceptación:**
    * **Escenario 1: Registro exitoso de ambulancia**
        * **Dado que** el operador logístico se encuentra autenticado con un rol con permisos de gestión de inventario.
        * **Cuando** registra el código de placa del vehículo, el tipo de unidad (SVA/SVB) y el modelo de la ambulancia.
        * **Entonces** el sistema valida que la placa no esté registrada previamente, guarda el nuevo vehículo y le asigna el estado "Disponible sin contenedor".
    * **Escenario 2: Intento de registro con placa duplicada**
        * **Dado que** la placa de la ambulancia ya se encuentra registrada para la misma institución.
        * **Cuando** el operador intenta guardar el registro.
        * **Entonces** el sistema impide la creación del duplicado y envía una alerta de conflicto de identificación del vehículo.

***

#### **US08: Vinculación de Contenedor Inteligente**
* **Título:** Vinculación de Contenedor Inteligente.
* **Descripción:** Como operador logístico de salud, deseo vincular un contenedor IoT a una ambulancia específica para iniciar la supervisión activa de la carga médica.
* **Relacionado con:** EP03
* **Criterios de Aceptación:**
    * **Escenario 1: Vinculación exitosa de contenedor a vehículo**
        * **Dado que** se dispone de una ambulancia registrada en estado "Disponible sin contenedor" y un contenedor inteligente en estado "Inactivo/Desvinculado".
        * **Cuando** el operador selecciona la unidad de ambulancia y digita el identificador físico (UUID/MAC) del contenedor IoT.
        * **Entonces** el sistema establece la relación entre ambos componentes, cambia el estado de la ambulancia a "Monitoreo Activo" y habilita la recepción de paquetes de telemetría para dicha combinación.
    * **Escenario 2: Intento de vinculación de un contenedor previamente asignado**
        * **Dado que** el contenedor IoT ya se encuentra asignado a otra unidad activa.
        * **Cuando** el operador intenta asociarlo a una nueva ambulancia.
        * **Entonces** el sistema rechaza la operación e indica que el contenedor debe ser desvinculado de su unidad origen antes de una nueva asignación.

***

#### **US09: Ingesta de Telemetría IoT (API)**
* **Título:** Ingesta de Telemetría IoT (API).
* **Descripción:** Como Developer, deseo contar con un endpoint `POST /api/v1/containers/{containerId}/telemetry` para registrar periódicamente datos térmicos, de peso y estado del contenedor.
* **Relacionado con:** EP03
* **Criterios de Aceptación:**
    * **Escenario 1: Recepción e ingesta de payload de telemetría válido**
        * **Dado que** un contenedor IoT autenticado transmite un `POST` al endpoint especificando un `{containerId}` válido y un payload con `temperature`, `weight`, `doorStatus`, `batteryLevel` y `timestamp`.
        * **Cuando** la API procesa y valida que los valores numéricos están dentro de rangos físicamente posibles.
        * **Entonces** registra la lectura en la base de datos de series temporales y responde con un código `HTTP 201 Created`.
    * **Escenario 2: Envío de lectura con identificador de contenedor inexistente**
        * **Dado que** el hardware transmite datos utilizando un `{containerId}` no registrado en la plataforma.
        * **Cuando** la API evalúa la solicitud.
        * **Entonces** descarta el registro y responde con un código `HTTP 404 Not Found`.
    * **Escenario 3: Petición sin token de autenticación de dispositivo**
        * **Dado que** la solicitud HTTP carece de la cabecera de autenticación del dispositivo IoT (`X-Device-Token`).
        * **Cuando** la API recibe la transmisión.
        * **Entonces** rechaza la conexión con un código `HTTP 401 Unauthorized`.

***

### Epic 04: Real-Time Environmental & Fleet Monitoring (EP04)

#### **US10: Monitoreo Térmico y de Apertura**
* **Título:** Monitoreo Térmico y de Apertura.
* **Descripción:** Como personal médico de emergencia, deseo consultar la temperatura interna y el estado de la escotilla del contenedor para garantizar la conservación del paquete médico durante el trayecto.
* **Relacionado con:** EP04
* **Criterios de Aceptación:**
    * **Escenario 1: Visualización en tiempo real de variables ambientales**
        * **Dado que** el contenedor inteligente está vinculado a una ambulancia en ruta.
        * **Cuando** los sensores del dispositivo emiten una nueva lectura de temperatura o detectan el cambio en la escotilla (abierta/cerrada).
        * **Entonces** el sistema procesa el evento y actualiza de manera inmediata la información expuesta en el panel de supervisión sin requerir la recarga manual de la página.
    * **Escenario 2: Indicación visual de pérdida de señal de telemetría**
        * **Dado que** un contenedor activo deja de transmitir telemetría durante más de 3 minutos debido a fallas de cobertura.
        * **Cuando** se cumple el tiempo límite de inactividad.
        * **Entonces** el sistema marca el estado de la conexión como "Sin Señal / Desconectado" y registra la hora de última lectura recibida.

***

#### **US11: Control de Stock por Sensores de Peso**
* **Título:** Control de Stock por Sensores de Peso.
* **Descripción:** Como personal médico de emergencia, deseo verificar la disponibilidad y retiro de insumos mediante sensores de peso para confirmar existencias en tiempo real.
* **Relacionado con:** EP04
* **Criterios de Aceptación:**
    * **Escenario 1: Detección y cálculo de retiro de insumo médico**
        * **Dado que** el contenedor tiene registrado un inventario con un peso base total de 5.00 kg.
        * **Cuando** el personal médico abre la escotilla y retira un paquete de insumos de 0.50 kg.
        * **Entonces** el sistema detecta la variación de peso tras el cierre de la escotilla, calcula la diferencia de masa y descuenta la unidad del inventario estimado.
    * **Escenario 2: Notificación por inconsistencia de masa no registrada**
        * **Dado que** la variación de peso registrada no coincide con el peso promedio de los insumos parametrizados.
        * **Cuando** se procesa la lectura.
        * **Entonces** el sistema genera una observación en la bitácora de la ruta indicando "Divergencia de peso no clasificada".

***

#### **US12: Consulta de Telemetría e Indicadores (API)**
* **Título:** Consulta de Telemetría e Indicadores (API).
* **Descripción:** Como Developer, deseo disponer de un endpoint `GET /api/v1/containers/{containerId}/metrics` para proveer las últimas mediciones consolidadas a la interfaz de usuario.
* **Relacionado con:** EP04
* **Criterios de Aceptación:**
    * **Escenario 1: Consulta exitosa de métricas actuales**
        * **Dado que** la aplicación de supervisión consulta la API con un `{containerId}` válido y activo.
        * **Cuando** la API procesa la petición de lectura.
        * **Entonces** responde con un código `HTTP 200 OK` retornando un objeto JSON con la última lectura de temperatura, nivel de batería, estado de escotilla, peso y fecha/hora de sincronización.
    * **Escenario 2: Consulta sobre contenedor sin lecturas previas**
        * **Dado que** el contenedor existe pero no ha registrado aún lecturas de telemetría.
        * **Cuando** se ejecuta la consulta GET al endpoint.
        * **Entonces** la API responde con un código `HTTP 200 OK` entregando la estructura con valores nulos y un indicador de estado "Sin datos registrados".

***

### Epic 05: Incident Alerts & Medical Dispatch (EP05)

#### **US13: Configuración de Umbrales Térmicos Críticos**
* **Título:** Configuración de Umbrales Térmicos Críticos.
* **Descripción:** Como supervisor hospitalario, deseo establecer rangos de temperatura permitidos (mínimo y máximo) para recibir avisos preventivos ante desviaciones en la cadena de frío.
* **Relacionado con:** EP05
* **Criterios de Aceptación:**
    * **Escenario 1: Guardado correcto de límites de tolerancia térmica**
        * **Dado que** el supervisor accede a la configuración de parámetros de conservación de una carga sensible (ej. Órganos o vacunas).
        * **Cuando** define una temperatura mínima de 2°C y una temperatura máxima de 8°C y solicita guardar la regla.
        * **Entonces** el sistema almacena la configuración de umbrales y la asocia a las evaluaciones en tiempo real del contenedor asignado.
    * **Escenario 2: Validación de rango térmico inconsistente**
        * **Dado que** el supervisor intenta ingresar un valor de temperatura mínima que es igual o mayor a la temperatura máxima definida.
        * **Cuando** procesa la solicitud de guardado.
        * **Entonces** el sistema rechaza la regla de negocio y notifica que la temperatura mínima debe ser strictly menor al límite máximo.

***

#### **US14: Visualización de Alertas en Ruta**
* **Título:** Visualización de Alertas en Ruta.
* **Descripción:** Como operador logístico de salud, deseo recibir avisos prioritarios de variaciones térmicas o apertura no autorizada para ejecutar acciones correctivas inmediatas.
* **Relacionado con:** EP05
* **Criterios de Aceptación:**
    * **Escenario 1: Generación de alerta por ruptura de la cadena de frío**
        * **Dado que** el contenedor tiene un rango configurado entre 2°C y 8°C.
        * **Cuando** la telemetría reporta una lectura de 9.5°C persistente durante más de 60 segundos.
        * **Entonces** el sistema genera una alerta de prioridad alta "Ruptura de Cadena de Frío", la registra en la bitácora del traslado y la notifica en el panel del operador.
    * **Escenario 2: Generación de alerta por apertura prolongada de escotilla**
        * **Dado que** el contenedor se encuentra en traslado con la escotilla en estado "Abierta".
        * **Cuando** el tiempo de apertura continua excede los 120 segundos.
        * **Entonces** el sistema emite una alerta de advertencia "Escotilla Abierta Prolongada" dirigida al personal médico de la unidad.

***

#### **US15: Servicio de Despacho de Alertas (API)**
* **Título:** Servicio de Despacho de Alertas (API).
* **Descripción:** Como Developer, deseo contar con un endpoint `POST /api/v1/alerts/dispatch` para procesar y canalizar notificaciones de eventos críticos hacia servicios externos.
* **Relacionado con:** EP05
* **Criterios de Aceptación:**
    * **Escenario 1: Procesamiento y despacho exitoso de evento de alerta**
        * **Dado que** el motor de reglas detecta un evento anómalo y envía la estructura JSON de la alerta con el nivel de severidad, ID de contenedor y tipo de anomalía.
        * **Cuando** la API procesa la solicitud de despacho.
        * **Entonces** registra la incidencia en la base de datos, encola el envío de correo/SMS y responde con un código `HTTP 202 Accepted`.
    * **Escenario 2: Petición de despacho con campos obligatorios faltantes**
        * **Dado que** la solicitud omitió el nivel de severidad (`severityLevel`) o el identificador del evento (`eventId`).
        * **Cuando** la API evalúa la estructura del mensaje.
        * **Entonces** detiene la ejecución y devuelve un código `HTTP 400 Bad Request`.

***

### Epic 06: Chain of Custody & Audit Reports (EP06)

#### **US16: Generación de Reportes de Trazabilidad**
* **Título:** Generación de Reportes de Trazabilidad.
* **Descripción:** Como supervisor hospitalario, deseo exportar el informe consolidado del traslado médico para certificar el cumplimiento normativo de la cadena de frío.
* **Relacionado con:** EP06
* **Criterios de Aceptación:**
    * **Escenario 1: Exportación exitosa de informe de trazabilidad**
        * **Dado que** un traslado médico ha sido marcado como "Finalizado".
        * **Cuando** el supervisor solicita la generación del reporte consolidado de trazabilidad en formato PDF.
        * **Entonces** el sistema compila la gráfica temporal de variaciones de temperatura, el registro de apertura de escotillas, el historial de peso y el resumen de alertas emitidas durante la ruta.
    * **Escenario 2: Intento de generación de reporte en traslado en curso**
        * **Dado que** el traslado aún se encuentra en estado "En Ruta / Activo".
        * **Cuando** el supervisor intenta consolidar el reporte final de auditoría.
        * **Entonces** el sistema bloquea la emisión final e indica que únicamente se pueden generar reportes parciales o preliminares mientras el traslado siga abierto.

***

#### **US17: Confirmación de Entrega y Cadena de Custodia**
* **Título:** Confirmación de Entrega y Cadena de Custodia.
* **Descripción:** Como personal médico de emergencia, deseo registrar la recepción del contenedor en el punto de destino para cerrar formalmente la cadena de custodia del envío.
* **Relacionado con:** EP06
* **Criterios de Aceptación:**
    * **Escenario 1: Cierre exitoso y sellado de cadena de custodia**
        * **Dado que** la ambulancia ha arribado al centro hospitalario de destino.
        * **Cuando** el profesional médico receptor valida el paquete, firma digitalmente la recepción y confirma la entrega en el sistema.
        * **Entonces** la plataforma actualiza el estado del traslado a "Entregado", sella el registro histórico inmutable con la fecha, hora exacta y la identidad del receptor, liberando el contenedor para una nueva asignación.
    * **Escenario 2: Cierre de traslado con alertas no resueltas**
        * **Dado que** el traslado cuenta con alertas de temperatura críticas sin justificación o resolución previa.
        * **Cuando** se intenta cerrar la cadena de custodia.
        * **Entonces** el sistema exige al usuario ingresar una observación de cierre obligatoria detallando las condiciones en las que se recibe la carga antes de permitir la finalización del servicio.

***

#### **US18: Consulta de Historial de Traslados (API)**
* **Título:** Consulta de Historial de Traslados (API).
* **Descripción:** Como Developer, deseo disponer de un endpoint `GET /api/v1/transfers/{transferId}/audit` para recuperar el registro completo de auditoría y eventos de un traslado.
* **Relacionado con:** EP06
* **Criterios de Aceptación:**
    * **Escenario 1: Recuperación de registro de auditoría completo**
        * **Dado que** se requiere auditar un traslado con un `{transferId}` existente.
        * **Cuando** la API procesa la solicitud `GET /api/v1/transfers/{transferId}/audit` con credenciales de auditor o supervisor.
        * **Entonces** devuelve un código `HTTP 200 OK` con un objeto JSON conteniendo el resumen del trayecto, tiempos de inicio y fin, datos del receptor y la serie temporal completa de la telemetría registrada.
    * **Escenario 2: Intento de consulta de auditoría con identificador inexistente**
        * **Dado que** la solicitud utiliza un `{transferId}` que no existe en el registro histórico.
        * **Cuando** la API busca el expediente.
        * **Entonces** responde con un código `HTTP 404 Not Found` notificando la inexistencia del registro.
