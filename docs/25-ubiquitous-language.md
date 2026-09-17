# 2.5. Ubiquitous Language

En esta sección se establece el glosario formal de términos y conceptos del dominio del negocio (*Smart Medical Container*), garantizando una comunicación unívoca, rigurosa y libre de ambigüedades entre los dos segmentos clave del negocio (las **empresas de transporte y operadores logísticos de cadena de frío**, y los **centros de salud y cadenas farmacéuticas** receptoras), las entidades reguladoras peruanas (MINSA, DIGEMID, DIGDOT) y el equipo de desarrollo de software.

Conforme a las directrices fundamentales de *Domain-Driven Design* (Eric Evans, Martin Fowler), todos los términos se presentan en idioma inglés con su equivalente formal en español entre paréntesis. Cada definición ha sido redactada rigurosamente desde la perspectiva clínica, operativa y legal del negocio asistencial en Lima Metropolitana, asegurando que el vocabulario permanezca libre de tecnicismos de implementación de software (tales como tablas relacionales, llaves foráneas, APIs, endpoints o controladores).

Cada uno de los 29 términos canónicos se encuentra formalmente circunscrito a su correspondiente *Bounded Context*, garantizando que cada concepto posea una semántica unívoca y bien delimitada dentro de las fronteras transaccionales del dominio. Cabe precisar que la estructuración en cinco (5) Bounded Contexts dentro de este glosario refleja los macro-contextos delimitados durante la fase exploratoria de requisitos del Big Picture (Capítulo 2.4), los cuales evolucionan armónicamente hacia seis (6) Bounded Contexts durante la descomposición de diseño táctico (Capítulo 4.6.1) al independizarse modularmente el aprovisionamiento de flota y suscripciones B2B. A continuación, se presenta la tabla consolidada en orden alfabético estricto (A-Z) como índice lexicográfico de referencia rápida, seguida del desglose analítico detallado por cada subdominio:

| # | Ubiquitous Term (English / Español) | Bounded Context Asociado | Tipo de Artefacto DDD |
|:---:|:---|:---|:---|
| 1 | **Acceptable Temperature Range (Rango Térmico Aceptable)** | Medical Transport Planning & Dispatching | Value Object |
| 2 | **Audit Trail & Digital Manifest (Rastro de Auditoría y Manifiesto Digital)** | Chain of Custody & Traceability | Aggregate Root |
| 3 | **Automated Maintenance and Sensor Calibration (Mantenimiento y Calibración Automatizada)** | Smart Container & Telemetry Monitoring | Domain Policy |
| 4 | **Chain of Custody (Cadena de Custodia Sanitaria)** | Chain of Custody & Traceability | Core Domain / Aggregate Root |
| 5 | **Cold Chain (Cadena de Frío)** | Smart Container & Telemetry Monitoring | Domain Policy |
| 6 | **Cold Ischemia Time (Tiempo de Isquemia Fría)** | Medical Transport Planning & Dispatching | Value Object |
| 7 | **Cold-Chain Deviation Report (Informe de Desviación de Cadena de Frío)** | Critical Alerting & Incident Response | Read Model / Domain Report |
| 8 | **Container Autonomy and Telemetry (Telemetría y Autonomía del Contenedor)** | Smart Container & Telemetry Monitoring | Entity / Value Object |
| 9 | **Container Lid Status & Tamper-Evident Lock (Estado de Tapa y Bloqueo Electromecánico de Custodia)** | Smart Container & Telemetry Monitoring | Entity |
| 10 | **Critical Operational Alert & Acknowledgment (Alerta Operativa Crítica y Acuse de Recibo)** | Critical Alerting & Incident Response | Aggregate Root / Entity |
| 11 | **Custody Handover Act (Acta de Entrega y Trazabilidad de Custodia)** | Chain of Custody & Traceability | Aggregate Root |
| 12 | **Dynamic Route ETA (Tiempo Estimado de Llegada Dinámico)** | Medical Transport Planning & Dispatching | Value Object |
| 13 | **Emergency Medical Crew (Tripulación Asistencial y Paramédica)** | Medical Transport Planning & Dispatching | Entity |
| 14 | **Fleet Container Provisioning (Aprovisionamiento y Vinculación de Flota)** | Identity, Access & Subscriptions (IAM) | Domain Policy / Entity |
| 15 | **Healthcare & Pharmaceutical Client (Centro de Salud y Cadena Farmacéutica)** | Identity, Access & Subscriptions (IAM) | Aggregate Root |
| 16 | **Hospital Geofence (Geocerca Hospitalaria)** | Identity, Access & Subscriptions (IAM) | Value Object |
| 17 | **Hospital Pre-Arrival Notice (Aviso de Pre-Arribo Hospitalario)** | Critical Alerting & Incident Response | Domain Event |
| 18 | **Logistics Transport Unit (Unidad de Transporte y Ambulancia Logística)** | Medical Transport Planning & Dispatching | Entity |
| 19 | **Medical and Biological Payload (Carga Médica y Biológica)** | Medical Transport Planning & Dispatching | Value Object |
| 20 | **One-Time Password / Unlock Token (Clave OTP / Token de Desbloqueo Temporal)** | Chain of Custody & Traceability | Value Object |
| 21 | **Procurement & Dispatch Coordinator (Coordinador de Procura y Despacho Asistencial)** | Medical Transport Planning & Dispatching | Entity |
| 22 | **Receiving Medical Custodian (Custodio Médico Receptor)** | Chain of Custody & Traceability | Value Object |
| 23 | **SaaS Subscription Plan (Plan de Suscripción SaaS B2B)** | Identity, Access & Subscriptions (IAM) | Aggregate Root |
| 24 | **Smart Medical Container (Contenedor Médico Inteligente)** | Smart Container & Telemetry Monitoring | Aggregate Root |
| 25 | **Tare Weight & Net Weight (Peso Tara y Peso Neto)** | Smart Container & Telemetry Monitoring | Value Object |
| 26 | **Thermal Excursion (Excursión Térmica)** | Critical Alerting & Incident Response | Domain Event / Aggregate Root |
| 27 | **Transport Mission / Emergency Transport Order (Misión de Transporte Asistido / Orden de Traslado de Emergencia)** | Medical Transport Planning & Dispatching | Aggregate Root |
| 28 | **Vehicle Telematics and Auxiliary Power (Telemática Vehicular y Alimentación Auxiliar)** | Smart Container & Telemetry Monitoring | Value Object / Domain Event |
| 29 | **Weight-Based Medical Stock (Stock Médico Ponderal)** | Smart Container & Telemetry Monitoring | Value Object |

---

### **2.5.1. Bounded Context: Identity, Access & Subscriptions (IAM)**

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Ubiquitous Term</th>
      <th>Domain Definition</th>
      <th>Role in the System &amp; DDD Mapping</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Healthcare &amp; Pharmaceutical Client (Centro de Salud y Cadena Farmacéutica)</strong></td>
      <td>Entidad pública o privada del sector salud o farmacéutico (hospital nacional, clínica privada, instituto especializado, laboratorio clínico o cadena farmacéutica) facultada legalmente para actuar como centro emisor o receptor de insumos médicos críticos, medicamentos termosensibles, hemoderivados u órganos bajo estricta cadena de frío.</td>
      <td><strong>Aggregate Root:</strong> <code>HospitalInstitution</code><br><em>Bounded Context:</em> Identity, Access &amp; Subscriptions (IAM)</td>
    </tr>
    <tr>
      <td><strong>Hospital Geofence (Geocerca Hospitalaria)</strong></td>
      <td>Perímetro geográfico virtual delimitado alrededor de la institución de salud receptora (típicamente con un radio de 2 km / 10 min), cuyo traspaso por la ambulancia activa automáticamente los protocolos de pre-arribo y habilita la autorización del desbloqueo digital.</td>
      <td><strong>Value Object:</strong> <code>GeoFence</code> en <code>HospitalInstitution</code><br><em>Bounded Context:</em> Identity, Access &amp; Subscriptions (IAM)</td>
    </tr>
    <tr>
      <td><strong>SaaS Subscription Plan (Plan de Suscripción SaaS B2B)</strong></td>
      <td>Acuerdo comercial formal y recurrente entre la plataforma Medical SMARTBOX y la institución de salud o empresa de ambulancias, que establece la cuota máxima de contenedores médicos autorizados en flota (Small Box de 5L vs. Standard Box de 20L), niveles de servicio de soporte y acceso multi-inquilino al portal de trazabilidad.</td>
      <td><strong>Aggregate Root:</strong> <code>SubscriptionPlan</code><br><em>Bounded Context:</em> Identity, Access &amp; Subscriptions (IAM)</td>
    </tr>
    <tr>
      <td><strong>Fleet Container Provisioning (Aprovisionamiento y Vinculación de Flota)</strong></td>
      <td>Proceso técnico y administrativo mediante el cual se activa, calibra y asocia un Contenedor Médico Inteligente a la flota de una institución acreditada, vinculando su número de serie de fábrica a los límites de membresía contratados.</td>
      <td><strong>Domain Policy / Entity:</strong> <code>ContainerProvisioning</code> en <code>SmartContainer</code><br><em>Bounded Context:</em> Identity, Access &amp; Subscriptions (IAM)</td>
    </tr>
  </tbody>
</table>

---

### **2.5.2. Bounded Context: Medical Transport Planning & Dispatching**

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Ubiquitous Term</th>
      <th>Domain Definition</th>
      <th>Role in the System &amp; DDD Mapping</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Acceptable Temperature Range (Rango Térmico Aceptable)</strong></td>
      <td>Intervalo estricto de temperatura de preservación bioambiental fijado por las Buenas Prácticas de Almacenamiento y Transporte de DIGEMID (+2.0 °C a +8.0 °C para medicamentos biológicos, vacunas y hemoderivados; y +2.0 °C a +4.0 °C para órganos de donante cadavérico), dentro del cual se garantiza la estabilidad farmacológica y viabilidad tisular de la carga.</td>
      <td><strong>Value Object:</strong> <code>TemperatureRange</code> en <code>TransportOrder</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Cold Ischemia Time (Tiempo de Isquemia Fría)</strong></td>
      <td>Intervalo de tiempo fisiológico máximo que un órgano para trasplante puede permanecer sin irrigación sanguínea en preservación hipotérmica (desde el clampado aórtico en el hospital donante hasta su revascularización en quirófano) antes de sufrir necrosis tisular irreversible, gobernado por la Directiva Sanitaria N° 152/DIGDOT.</td>
      <td><strong>Value Object:</strong> <code>IschemiaTimeLimit</code> en <code>TransportOrder</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Dynamic Route ETA (Tiempo Estimado de Llegada Dinámico)</strong></td>
      <td>Cálculo predictivo continuo de la duración remanente y la hora exacta de arribo de la ambulancia al hospital de destino, ajustado dinámicamente según las variaciones del flujo vehicular, congestión e incidentes de tránsito en los corredores hospitalarios de Lima Metropolitana.</td>
      <td><strong>Value Object:</strong> <code>RouteProgress</code> en la Entidad <code>TransportRoute</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Emergency Medical Crew (Tripulación Asistencial y Paramédica)</strong></td>
      <td>Personal asistencial calificado (paramédicos, enfermeros o conductores de emergencias médicas) encargado de la operación en ruta, conexión del contenedor a la toma 12V del vehículo asistencial y custodia física directa durante el traslado de urgencia.</td>
      <td><strong>Entity:</strong> <code>CrewMember</code> en <code>DispatchTrip</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Logistics Transport Unit (Unidad de Transporte y Ambulancia Logística)</strong></td>
      <td>Vehículo terrestre de transporte especializado (ambulancia asistencial Tipo II/III o furgón logístico climatizado) operado por empresas de transporte y operadores logísticos de cadena de frío, equipado con soporte eléctrico continuo de 12V en cabina y sistema telemático de navegación para el Contenedor Médico Inteligente.</td>
      <td><strong>Entity:</strong> <code>VehicleBinding</code> asociada al Agregado <code>DispatchTrip</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Medical and Biological Payload (Carga Médica y Biológica)</strong></td>
      <td>Conjunto de insumos terapéuticos y biológicos altamente termosensibles y críticos trasladados en la unidad de transporte asistido, que comprende órganos sólidos para trasplante (corazón, riñón, hígado), tejidos humanos, componentes sanguíneos (paquetes globulares, plasma), vacunas e inmunobiológicos, y medicamentos de alto costo sujetos a rigurosos límites de supervivencia biológica.</td>
      <td><strong>Value Object:</strong> <code>BiologicalPayload</code> encapsulado en <code>TransportOrder</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Procurement &amp; Dispatch Coordinator (Coordinador de Procura y Despacho Asistencial)</strong></td>
      <td>Profesional asistencial o logístico (adscrito a DIGDOT, MINSA o a la central de despacho del operador de transporte) facultado para autorizar la misión de traslado, evaluar la disponibilidad de unidades móviles climatizadas y emitir la orden formal de transporte de órganos o hemoderivados.</td>
      <td><strong>Entity:</strong> <code>DispatchCoordinator</code> en <code>TransportOrder</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Transport Mission / Emergency Transport Order (Misión de Transporte Asistido / Orden de Traslado de Emergencia)</strong></td>
      <td>Operación asistencial protocolizada de traslado médico entre un centro de salud o almacén farmacéutico de origen y una institución de destino, gobernada por una ventana temporal crítica, una tripulación técnica asignada y directivas estrictas de conservación bioambiental.</td>
      <td><strong>Aggregate Root:</strong> <code>DispatchTrip</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
  </tbody>
</table>

---

### **2.5.3. Bounded Context: Smart Container & Telemetry Monitoring**

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Ubiquitous Term</th>
      <th>Domain Definition</th>
      <th>Role in the System &amp; DDD Mapping</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Automated Maintenance and Sensor Calibration (Mantenimiento y Calibración Automatizada)</strong></td>
      <td>Protocolo de diagnóstico predictivo y continuo ejecutado de forma autónoma por el contenedor inteligente y la plataforma de monitoreo asistencial para supervisar el desgaste de la celda Peltier, la deriva de calibración de la celda de carga HX711 y los ciclos de vida útil de la batería interna LiFePO4, programando órdenes de servicio preventivo antes de que ocurra una falla operativa en ruta.</td>
      <td><strong>Domain Policy:</strong> <code>PreventiveMaintenancePolicy</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Cold Chain (Cadena de Frío)</strong></td>
      <td>Proceso logístico ininterrumpido de control y supervisión ambiental que asegura que los insumos biológicos y farmacéuticos se mantengan dentro de los intervalos térmicos normativos reglamentados por el MINSA y la DIGEMID (+2 °C a +4 °C para órganos; +2 °C a +8 °C para hemoderivados y vacunas) durante todas las etapas de custodia y desplazamiento en ambulancia.</td>
      <td><strong>Domain Policy:</strong> <code>ColdChainPreservationPolicy</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Container Autonomy and Telemetry (Telemetría y Autonomía del Contenedor)</strong></td>
      <td>Flujo periódico de mediciones físicas directas (temperatura interna de cámara, peso en bandeja, estado del sensor magnético de tapa, voltaje y porcentaje de carga de la batería interna LiFePO4) transmitidas de forma continua para garantizar que el soporte térmico se mantenga activo aun ante desconexiones de la red de la ambulancia.</td>
      <td><strong>Entity:</strong> <code>TelemetryLog</code> / <strong>Value Object:</strong> <code>TelemetrySnapshot</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Container Lid Status &amp; Tamper-Evident Lock (Estado de Tapa y Bloqueo Electromecánico de Custodia)</strong></td>
      <td>Supervisión continua del sellado hermético superior (contacto magnético) y cerrojo electromecánico de alta retención comandado por solenoide, que previene la apertura no autorizada de la tapa durante el tránsito de la ambulancia y habilita su liberación física únicamente cuando el vehículo ingresa a la geocerca hospitalaria de destino y el personal facultado valida su identidad mediante un código OTP de un solo uso.</td>
      <td><strong>Entity:</strong> <code>ElectromechanicalLock</code> subordinada a <code>SmartContainer</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Smart Medical Container (Contenedor Médico Inteligente)</strong></td>
      <td>Unidad física móvil e isotérmica de grado clínico instalada en el transporte asistido, disponible en diversos factores de forma y capacidades volumétricas modulares según los requisitos de carga, dotada de aislamiento térmico de alta densidad, alimentación energética dual (red fija y toma vehicular de 12V), instrumentación de medición bioambiental continua y mecanismo de cierre electromecánico de seguridad.</td>
      <td><strong>Aggregate Root:</strong> <code>SmartContainer</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Tare Weight &amp; Net Weight (Peso Tara y Peso Neto)</strong></td>
      <td>Procedimiento metrológico de calibración en origen mediante el cual se descuenta la masa basal del contenedor vacío y sus componentes de fijación (tara), permitiendo cuantificar con precisión (&plusmn;5 g) la masa neta de la carga biológica para detectar variaciones por fugas, sustracción o reemplazo clandestino durante el traslado.</td>
      <td><strong>Value Object:</strong> <code>ContainerWeightMetrics</code> en <code>SmartContainer</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Vehicle Telematics and Auxiliary Power (Telemática Vehicular y Alimentación Auxiliar)</strong></td>
      <td>Parámetros operativos capturados desde la unidad móvil de transporte asistencial (estado de suministro eléctrico continuo de 12V en cabina, velocidad de desplazamiento y coordenadas geográficas en tiempo real) que permiten supervisar la estabilidad energética del contenedor y predecir los tiempos de traslado en la red vial de Lima Metropolitana.</td>
      <td><strong>Value Object:</strong> <code>AuxiliaryPowerTelemetry</code> / <strong>Domain Event:</strong> <code>ExternalPowerLost</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Weight-Based Medical Stock (Stock Médico Ponderal)</strong></td>
      <td>Estimación cuantitativa en tiempo real de la cantidad de medicamentos, ampollas o insumos almacenados dentro del compartimento, calculada a partir de las variaciones de masa registradas continuamente por la celda de carga de precisión, permitiendo prevenir desabastecimientos en ruta o sustracciones clandestinas.</td>
      <td><strong>Value Object:</strong> <code>PayloadWeight</code> (Invariante de peso en <code>SmartContainer</code>)<br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
  </tbody>
</table>

---

### **2.5.4. Bounded Context: Critical Alerting & Incident Response**

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Ubiquitous Term</th>
      <th>Domain Definition</th>
      <th>Role in the System &amp; DDD Mapping</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Cold-Chain Deviation Report (Informe de Desviación de Cadena de Frío)</strong></td>
      <td>Acta técnico-sanitaria de notificación obligatoria emitida automáticamente cuando se constata una excursión térmica no mitigada durante el traslado en ambulancia, documentando la integral tiempo-temperatura del evento para sustentar formalmente el descarte, reemplazo o cuarentena preventiva del lote médico ante auditorías de DIGEMID y DIGDOT.</td>
      <td><strong>Read Model / Domain Report:</strong> <code>ColdChainDeviationReport</code><br><em>Bounded Context:</em> Critical Alerting &amp; Incident Response</td>
    </tr>
    <tr>
      <td><strong>Critical Operational Alert &amp; Acknowledgment (Alerta Operativa Crítica y Acuse de Recibo)</strong></td>
      <td>Notificación de alta prioridad y respuesta inmediata ante contingencias en ruta (excursiones térmicas, desconexión vehicular de 12V, apertura indebida o anomalías ponderales), que combina avisos acústico-visuales en la cabina asistencial y alertas digitales a la central médica, requiriendo que la tripulación confirme manualmente su recepción en un plazo no mayor a 2 minutos para coordinar el plan de contingencia.</td>
      <td><strong>Aggregate Root:</strong> <code>CriticalIncident</code> / <strong>Entity:</strong> <code>ContingencyResolution</code><br><em>Bounded Context:</em> Critical Alerting &amp; Incident Response</td>
    </tr>
    <tr>
      <td><strong>Hospital Pre-Arrival Notice (Aviso de Pre-Arribo Hospitalario)</strong></td>
      <td>Comunicación protocolar preventiva enviada automáticamente al equipo médico y quirúrgico del hospital receptor cuando la ambulancia se encuentra a una proximidad crítica (10 minutos de arribo o cruce de geocerca), facilitando el alistamiento de quirófano, esterilización de instrumental y despeje de rampas de trauma shock.</td>
      <td><strong>Domain Event:</strong> <code>HospitalPreArrivalTriggered</code><br><em>Bounded Context:</em> Critical Alerting &amp; Incident Response</td>
    </tr>
    <tr>
      <td><strong>Thermal Excursion (Excursión Térmica)</strong></td>
      <td>Incidente crítico originado cuando la temperatura interna de la cámara del contenedor traspasa los márgenes de seguridad normativos durante un tiempo mayor a la tolerancia asistencial permitida, comprometiendo la estabilidad fisicoquímica o viabilidad celular del insumo y tipificándose como una no conformidad sanitaria grave.</td>
      <td><strong>Domain Event:</strong> <code>ThermalExcursionDetected</code> / <strong>Aggregate Root:</strong> <code>CriticalIncident</code><br><em>Bounded Context:</em> Critical Alerting &amp; Incident Response</td>
    </tr>
  </tbody>
</table>

---

### **2.5.5. Bounded Context: Chain of Custody & Traceability**

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Ubiquitous Term</th>
      <th>Domain Definition</th>
      <th>Role in the System &amp; DDD Mapping</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Audit Trail &amp; Digital Manifest (Rastro de Auditoría y Manifiesto Digital)</strong></td>
      <td>Secuencia ininterrumpida y cronológica de evidencias físicas, temporales y ambientales registradas durante toda la misión de transporte, compilada al cierre en un acta o expediente digital sellado criptográficamente que acredita ante los auditores de DIGEMID, DIGDOT y SUSALUD que la custodia médica nunca fue vulnerada.</td>
      <td><strong>Aggregate Root:</strong> <code>DigitalAuditManifest</code><br><em>Bounded Context:</em> Chain of Custody &amp; Traceability</td>
    </tr>
    <tr>
      <td><strong>Chain of Custody (Cadena de Custodia Sanitaria)</strong></td>
      <td>Registro documental, físico y legal continuo e inalterable que certifica la tenencia, ubicación, trazabilidad horaria, eventos de manipulación y curvas bioambientales de la carga médica desde el centro donante o farmacia de origen hasta su recepción definitiva.</td>
      <td><strong>Core Bounded Context:</strong> Chain of Custody &amp; Traceability<br><em>Aggregate Root:</em> <code>CustodyTransfer</code></td>
    </tr>
    <tr>
      <td><strong>Custody Handover Act (Acta de Entrega y Trazabilidad de Custodia)</strong></td>
      <td>Documento protocolar formal generado al término del traslado asistencial, donde la tripulación paramédica y el equipo médico receptor rubrican mancomunadamente la conformidad del estado físico, el balance de stock y el dictamen de viabilidad biológica con el respaldo de la curva térmica completa del trayecto.</td>
      <td><strong>Aggregate Root:</strong> <code>CustodyTransfer</code><br><em>Bounded Context:</em> Chain of Custody &amp; Traceability</td>
    </tr>
    <tr>
      <td><strong>One-Time Password / Unlock Token (Clave OTP / Token de Desbloqueo Temporal)</strong></td>
      <td>Clave numérica efímera de seguridad clínica generada dinámicamente por la plataforma y transmitida exclusivamente al médico receptor facultado, cuya introducción en el panel de control del contenedor condiciona la liberación del solenoide físico de la tapa únicamente cuando la ambulancia se encuentra dentro de la geocerca hospitalaria autorizada de destino.</td>
      <td><strong>Value Object:</strong> <code>OtpToken</code> encapsulado en <code>CustodyTransfer</code><br><em>Bounded Context:</em> Chain of Custody &amp; Traceability</td>
    </tr>
    <tr>
      <td><strong>Receiving Medical Custodian (Custodio Médico Receptor)</strong></td>
      <td>Profesional de la salud facultado en el establecimiento hospitalario o farmacia de destino (cirujano de trasplantes, médico de emergencia o químico farmacéutico responsable) habilitado para recibir la clave OTP, constatar la viabilidad clínica y formalizar el acta de conformidad.</td>
      <td><strong>Value Object:</strong> <code>ReceivingPhysician</code> en <code>CustodyTransfer</code><br><em>Bounded Context:</em> Chain of Custody &amp; Traceability</td>
    </tr>
  </tbody>
</table>
