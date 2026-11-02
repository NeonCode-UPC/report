# 1.2. Solution Profile

## 1.2.1. Antecedentes y problemática

El transporte de medicamentos termolábiles, vacunas, muestras biológicas, hemocomponentes y órganos para trasplante requiere condiciones estrictas de conservación térmica ($+2\,^\circ\text{C}$ a $+8\,^\circ\text{C}$), trazabilidad continua y control operativo. En los corredores asistenciales de Lima Metropolitana, estos elementos son trasladados en ambulancias o unidades especializadas donde una excursión de temperatura, una demora vial imprevista o la falta de visibilidad sobre la integridad física de la carga comprometen la viabilidad clínica del insumo y, en consecuencia, la vida del paciente receptor.

Actualmente, gran parte de este proceso depende de cajas térmicas pasivas (*coolers* de tecnopor con geles refrigerantes), registros manuales en hojas de papel, coordinación informal por mensajería instantánea y sistemas vehiculares aislados que no ofrecen una visión integrada del traslado. Esta fragmentación impide conocer en tiempo real la temperatura interna del contenedor, las variaciones de peso de la carga, el estado del cierre hermético, la autonomía energética y el Tiempo Estimado de Arribo (*ETA*) recalculado según el tráfico. La ausencia de información centralizada incrementa el riesgo de pérdida de bioderivados críticos, ruptura silenciosa de la cadena de frío, demoras en la preparación de quirófanos de destino y carencia de evidencia inmutable para auditorías ante **DIGEMID**, **MINSA** y **SUSALUD**.

La solución propuesta, **Medical SMARTBOX**, consiste en una plataforma web SaaS B2B integrada con contenedores médicos inteligentes basados en tecnología IoT (microcontrolador **ESP32**, refrigeración termoeléctrica activa por celdas **Peltier**, sensores térmicos **DS18B20**, celda de carga **HX711** y cerradura electromecánica de solenoide). Esta arquitectura permite a las instituciones de salud y operadores de transporte asistencial supervisar cada traslado en tiempo real, recibir alertas preventivas multicanal, recalcular rutas ante congestión vial y sellar digitalmente la cadena de custodia mediante validación criptográfica de doble factor (**Geocerca GPS + Token OTP**).

### Análisis Estructurado de la Problemática (Técnica 5W2H)

Para delimitar con precisión el alcance del problema y el perfil de la solución, se aplica la metodología **5W2H** (*What, Why, Who, Where, When, How, How Much*):

| Interrogante (5W2H) | Dimensión de Análisis | Descripción Fundamentada en el Dominio Asistencial |
| :--------------- | :--------------------- | :------------------------------------------------------------- |
| **What?** *(¿Qué ocurre?)* | Naturaleza del problema y propuesta tecnológica | Ruptura inadvertida de la cadena de frío ($+2\,^\circ\text{C}$ a $+8\,^\circ\text{C}$), manipulación sin control físico y ausencia de trazabilidad digital en el transporte móvil de muestras biológicas, hemocomponentes y órganos. Se resuelve mediante el ecosistema ciber-físico **Medical SMARTBOX** (contenedor IoT activo + plataforma web en Vue 3 y API RESTful en ASP.NET Core 10). |
| **Why?** *(¿Por qué ocurre?)* | Causas raíz y justificación normativa | Por el uso generalizado de contenedores isotérmicos pasivos sin telemetría en ruta, el llenado manual de actas en papel vulnerables a extravío o alteración post-facto, y la desconexión entre la ambulancia en tránsito y el equipo clínico receptor. Esto contraviene las exigencias de trazabilidad del **Manual de Buenas Prácticas de Distribución y Transporte (RM N.° 833-2015/MINSA — DIGEMID)**. |
| **Who?** *(¿Quiénes son los afectados?)* | Actores directos e indirectos | **Segmento 1:** Personal de transporte asistencial (conductores de ambulancia, paramédicos y técnicos del SAMU 106, EsSalud STAE y flotas privadas).<br>**Segmento 2:** Personal clínico receptor, coordinadores de procura de órganos, jefes de banco de sangre, farmacias hospitalarias y auditores de calidad de clínicas e IPRESS de nivel II y III. |
| **Where?** *(¿Dónde se origina?)* | Contexto geográfico y operativo | En los trayectos interhospitalarios de **Lima Metropolitana y el Callao**, caracterizados por alta congestión vehicular, temperaturas ambientales de cabina elevadas en verano (superiores a $35\,^\circ\text{C}$) y zonas de sombra celular (túneles, pasos a desnivel y sótanos hospitalarios). |
| **When?** *(¿Cuándo se manifiesta?)* | Momento crítico del flujo | Durante las tres fases críticas del traslado médico: (1) **Despacho en origen** (desconocimiento de pre-enfriamiento y carga de batería), (2) **Tránsito vehicular** (excursiones térmicas por desconexión de 12V o atascos viales sin aviso de pre-arribo) y (3) **Entrega en destino** (demoras en guardia y falta de validación formal de recepción). |
| **How?** *(¿Cómo funciona la solución?)* | Mecanismo técnico e integración | El contenedor inteligente regula activamente su cámara interna con celdas Peltier y transmite telemetría firmada (`HMAC-SHA256`) vía **HTTPS/REST** hacia el backend central. La plataforma web procesa las reglas de umbral térmico e isquemia, recalcula el ETA con **TomTom Traffic API**, dispara alertas con **Twilio/FCM**, exige desbloqueo por **Geocerca + OTP** y genera un manifiesto PDF inmutable en **AWS S3**. |
| **How Much?** *(¿Cuánto impacta y cuánto cuesta?)* | Impacto económico-clínico y modelo comercial | A nivel global y nacional, las fallas en la cadena de frío deterioran entre el **15% y el 25%** de los insumos biológicos termosensibles transportados sin control activo (OMS/OPS). **Medical SMARTBOX** opera bajo un esquema **SaaS B2B por suscripción mensual escalonada** (*Basic*, *Pro* y *Enterprise*, desde $\$199$ hasta $\$899\text{ USD/mes}$ según el tamaño de la flota de ambulancias y contenedores). |

## 1.2.2. Lean UX Process

El proceso Lean UX permite orientar la solución a partir de la comprensión del problema, la formulación de supuestos y la validación progresiva de hipótesis. Para este proyecto, el proceso se aplica sobre el dominio del transporte médico controlado, considerando la necesidad de mejorar la visibilidad del traslado, la conservación de productos sensibles y la coordinación entre personal médico, operadores logísticos y entidades de salud.

### 1.2.2.1. Lean UX Problem Statements

The current state of medical transport for medicines, biological supplies and organs has focused mainly on manual coordination, isolated temperature control devices and direct communication between health personnel and transport operators.

What existing products and services fail to address is the lack of integrated real-time visibility of container temperature, stock, location, vehicle status and estimated arrival time during critical medical transport operations.

Our product will address this gap by providing an IoT-enabled smart container platform connected to a responsive web application and a RESTful API, allowing authorized users to monitor environmental conditions, route progress, inventory and operational alerts from a centralized interface.

Our initial focus will be health institutions, emergency medical staff and medical logistics operators that need to transport sensitive medicines, organs or supplies under controlled conditions.

We will know we are successful when users can monitor active medical transports in real time, receive timely alerts for critical incidents, reduce uncertainty about arrival times and access traceability records for completed transfers.

### 1.2.2.2. Lean UX Assumptions

#### Business Assumptions

- We believe health institutions need a digital solution that improves traceability and control during medical transport operations.
- We believe hospitals, clinics and emergency service providers are willing to adopt IoT-based monitoring when it reduces operational risk.
- We believe the solution can generate value through subscription plans for institutions that manage multiple ambulances or medical containers.
- We believe reliable transport evidence can become a differentiating factor for institutions that handle sensitive medical products.

#### Business Outcome Assumptions

- We believe the platform can reduce incidents related to temperature deviation during transport.
- We believe real-time monitoring can reduce the time required to identify and respond to critical events.
- We believe digital traceability reports can improve audit readiness for health institutions.
- We believe route and vehicle visibility can improve coordination between dispatchers and medical teams.

#### User Assumptions

- We believe emergency medical staff need quick access to the status of the transported medical load.
- We believe logistics operators need to monitor multiple active transfers from a single dashboard.
- We believe hospital supervisors need historical evidence of transport conditions and delivery confirmation.
- We believe ambulance drivers need simple alerts that do not distract from their primary responsibility.

#### User Outcome and Benefit Assumptions

- We believe medical staff want to confirm that medicines or organs arrive in appropriate condition.
- We believe logistics operators want to reduce uncertainty about location, fuel level and estimated arrival time.
- We believe supervisors want to review incidents, responsibilities and timestamps after each transfer.
- We believe users benefit from early alerts that allow corrective action before the transported product is compromised.

#### Feature Assumptions

- We believe temperature monitoring and automatic alerts are essential features for sensitive medical transport.
- We believe weight-based stock detection can help estimate the quantity of medicines inside the container.
- We believe GPS tracking and route visualization can improve operational coordination.
- We believe vehicle fuel monitoring and estimated arrival time can support better decision-making during emergencies.
- We believe a traceability history can provide evidence for audits and process improvement.

### 1.2.2.3. Lean UX Hypothesis Statements

- We believe we will achieve improved control of temperature-sensitive medical transport if emergency medical staff and logistics operators attain early detection of temperature deviations with real-time temperature monitoring and critical alerts.
- We believe we will achieve better inventory visibility during transfers if medical staff attain updated information about available medicines with weight-based stock detection inside the smart container.
- We believe we will achieve more accurate operational coordination if logistics operators attain real-time route visibility with GPS tracking and estimated arrival time.
- We believe we will achieve better emergency planning if dispatchers and supervisors attain visibility of vehicle autonomy with fuel-level monitoring and vehicle status integration.
- We believe we will achieve stronger transport accountability if health institutions attain historical evidence of each transfer with traceability reports and chain-of-custody records.

### 1.2.2.4. Lean UX Canvas

| Sección | Descripción |
| :------------------------ | :--------------------------------------------------------------------------- |
| Business problem | Las instituciones de salud necesitan transportar medicamentos, órganos e insumos sensibles con mayor control, trazabilidad y capacidad de respuesta ante incidentes. |
| Business outcomes | Reducir incidentes de conservación, mejorar la visibilidad del traslado, disminuir incertidumbre sobre tiempos de llegada y generar evidencia histórica. |
| Users | Personal de transporte asistencial (conductores y paramédicos) y personal clínico/logístico de instituciones hospitalarias receptoras. |
| User outcomes | Conocer el estado de la carga, recibir alertas oportunas, confirmar disponibilidad de stock y revisar evidencia del traslado. |
| Solutions | Contenedor inteligente IoT, aplicación web responsive, RESTful API, alertas, GPS, monitoreo de temperatura, sensores de peso y reportes. |
| Hypotheses | Si los usuarios monitorean condiciones críticas en tiempo real, podrán reaccionar antes de que el traslado comprometa la seguridad del producto médico. |
| Most important thing to learn first | Validar si los usuarios consideran prioritario integrar temperatura, ubicación, stock y ETA en una sola plataforma. |
| Least amount of work to learn it | Prototipo navegable con dashboard de contenedores, alertas, detalle de traslado y registro histórico básico. |
