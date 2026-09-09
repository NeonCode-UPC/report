# 1.2. Solution Profile

## 1.2.1. Antecedentes y problemática

El transporte de medicamentos, vacunas, muestras biológicas, sangre y órganos requiere condiciones estrictas de conservación, trazabilidad y control operativo. En muchos escenarios de atención médica, estos elementos son trasladados en ambulancias o unidades especializadas, donde una variación de temperatura, una demora no prevista o una falta de información sobre el contenido transportado puede afectar la calidad del producto médico y, en consecuencia, la seguridad del paciente.

Actualmente, parte de este proceso puede depender de registros manuales, comunicación telefónica o sistemas aislados que no ofrecen una visión integrada del traslado. Esta situación dificulta conocer en tiempo real la ubicación del contenedor, la temperatura interna, el stock disponible, el estado de apertura, el nivel de combustible del vehículo y el tiempo estimado de llegada. La ausencia de información centralizada incrementa el riesgo de pérdida de medicamentos sensibles, ruptura de la cadena de frío, demoras en emergencias y falta de evidencia para auditorías internas.

La solución propuesta consiste en una plataforma web integrada con contenedores inteligentes basados en IoT, diseñados para el transporte médico en ambulancias. Cada contenedor contará con sensores para monitorear temperatura, peso, apertura, batería y ubicación. Además, la plataforma se conectará con información del vehículo para mostrar nivel de combustible y estimar el tiempo aproximado de llegada. Esta información permitirá a los usuarios autorizados supervisar el traslado, recibir alertas críticas y consultar el historial de cada operación.

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
|---|---|
| Business problem | Las instituciones de salud necesitan transportar medicamentos, órganos e insumos sensibles con mayor control, trazabilidad y capacidad de respuesta ante incidentes. |
| Business outcomes | Reducir incidentes de conservación, mejorar la visibilidad del traslado, disminuir incertidumbre sobre tiempos de llegada y generar evidencia histórica. |
| Users | Personal médico de emergencia, operadores logísticos de salud, supervisores hospitalarios y responsables de transporte médico. |
| User outcomes | Conocer el estado de la carga, recibir alertas oportunas, confirmar disponibilidad de stock y revisar evidencia del traslado. |
| Solutions | Contenedor inteligente IoT, aplicación web responsive, RESTful API, alertas, GPS, monitoreo de temperatura, sensores de peso y reportes. |
| Hypotheses | Si los usuarios monitorean condiciones críticas en tiempo real, podrán reaccionar antes de que el traslado comprometa la seguridad del producto médico. |
| Most important thing to learn first | Validar si los usuarios consideran prioritario integrar temperatura, ubicación, stock y ETA en una sola plataforma. |
| Least amount of work to learn it | Prototipo navegable con dashboard de contenedores, alertas, detalle de traslado y registro histórico básico. |
