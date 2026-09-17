# 2.5. Ubiquitous Language

En esta secciÃ³n se establece el glosario formal de tÃ©rminos y conceptos del dominio del negocio (*Smart Medical Container*), garantizando una comunicaciÃ³n unÃ­voca, rigurosa y libre de ambigÃ¼edades entre los dos segmentos clave del negocio (las **empresas de transporte y operadores logÃ­sticos de cadena de frÃ­o**, y los **centros de salud y cadenas farmacÃ©uticas** receptoras), las entidades reguladoras peruanas (MINSA, DIGEMID, DIGDOT) y el equipo de desarrollo de software.

Conforme a las directrices fundamentales de *Domain-Driven Design* (Eric Evans, Martin Fowler), todos los tÃ©rminos se presentan en idioma inglÃ©s con su equivalente formal en espaÃ±ol entre parÃ©ntesis. Cada definiciÃ³n ha sido redactada rigurosamente desde la perspectiva clÃ­nica, operativa y legal del negocio asistencial en Lima Metropolitana, asegurando que el vocabulario permanezca libre de tecnicismos de implementaciÃ³n de software (tales como tablas relacionales, llaves forÃ¡neas, APIs, endpoints o controladores).

Cada uno de los 29 tÃ©rminos canÃ³nicos se encuentra formalmente circunscrito a su correspondiente *Bounded Context*, garantizando que cada concepto posea una semÃ¡ntica unÃ­voca y bien delimitada dentro de las fronteras transaccionales del dominio. Cabe precisar que la estructuraciÃ³n en cinco (5) Bounded Contexts dentro de este glosario refleja los macro-contextos delimitados durante la fase exploratoria de requisitos del Big Picture (CapÃ­tulo 2.4), los cuales evolucionan armÃ³nicamente hacia seis (6) Bounded Contexts durante la descomposiciÃ³n de diseÃ±o tÃ¡ctico (CapÃ­tulo 4.6.1) al independizarse modularmente el aprovisionamiento de flota y suscripciones B2B. A continuaciÃ³n, se presenta la tabla consolidada en orden alfabÃ©tico estricto (A-Z) como Ã­ndice lexicogrÃ¡fico de referencia rÃ¡pida, seguida del desglose analÃ­tico detallado por cada subdominio:

| # | Ubiquitous Term (English / EspaÃ±ol) | Bounded Context Asociado | Tipo de Artefacto DDD |
|:---:|:---|:---|:---|
| 1 | **Acceptable Temperature Range (Rango TÃ©rmico Aceptable)** | Medical Transport Planning & Dispatching | Value Object |
| 2 | **Audit Trail & Digital Manifest (Rastro de AuditorÃ­a y Manifiesto Digital)** | Chain of Custody & Traceability | Aggregate Root |
| 3 | **Automated Maintenance and Sensor Calibration (Mantenimiento y CalibraciÃ³n Automatizada)** | Smart Container & Telemetry Monitoring | Domain Policy |
| 4 | **Chain of Custody (Cadena de Custodia Sanitaria)** | Chain of Custody & Traceability | Core Domain / Aggregate Root |
| 5 | **Cold Chain (Cadena de FrÃ­o)** | Smart Container & Telemetry Monitoring | Domain Policy |
| 6 | **Cold Ischemia Time (Tiempo de Isquemia FrÃ­a)** | Medical Transport Planning & Dispatching | Value Object |
| 7 | **Cold-Chain Deviation Report (Informe de DesviaciÃ³n de Cadena de FrÃ­o)** | Critical Alerting & Incident Response | Read Model / Domain Report |
| 8 | **Container Autonomy and Telemetry (TelemetrÃ­a y AutonomÃ­a del Contenedor)** | Smart Container & Telemetry Monitoring | Entity / Value Object |
| 9 | **Container Lid Status & Tamper-Evident Lock (Estado de Tapa y Bloqueo ElectromecÃ¡nico de Custodia)** | Smart Container & Telemetry Monitoring | Entity |
| 10 | **Critical Operational Alert & Acknowledgment (Alerta Operativa CrÃ­tica y Acuse de Recibo)** | Critical Alerting & Incident Response | Aggregate Root / Entity |
| 11 | **Custody Handover Act (Acta de Entrega y Trazabilidad de Custodia)** | Chain of Custody & Traceability | Aggregate Root |
| 12 | **Dynamic Route ETA (Tiempo Estimado de Llegada DinÃ¡mico)** | Medical Transport Planning & Dispatching | Value Object |
| 13 | **Emergency Medical Crew (TripulaciÃ³n Asistencial y ParamÃ©dica)** | Medical Transport Planning & Dispatching | Entity |
| 14 | **Fleet Container Provisioning (Aprovisionamiento y VinculaciÃ³n de Flota)** | Identity, Access & Subscriptions (IAM) | Domain Policy / Entity |
| 15 | **Healthcare & Pharmaceutical Client (Centro de Salud y Cadena FarmacÃ©utica)** | Identity, Access & Subscriptions (IAM) | Aggregate Root |
| 16 | **Hospital Geofence (Geocerca Hospitalaria)** | Identity, Access & Subscriptions (IAM) | Value Object |
| 17 | **Hospital Pre-Arrival Notice (Aviso de Pre-Arribo Hospitalario)** | Critical Alerting & Incident Response | Domain Event |
| 18 | **Logistics Transport Unit (Unidad de Transporte y Ambulancia LogÃ­stica)** | Medical Transport Planning & Dispatching | Entity |
| 19 | **Medical and Biological Payload (Carga MÃ©dica y BiolÃ³gica)** | Medical Transport Planning & Dispatching | Value Object |
| 20 | **One-Time Password / Unlock Token (Clave OTP / Token de Desbloqueo Temporal)** | Chain of Custody & Traceability | Value Object |
| 21 | **Procurement & Dispatch Coordinator (Coordinador de Procura y Despacho Asistencial)** | Medical Transport Planning & Dispatching | Entity |
| 22 | **Receiving Medical Custodian (Custodio MÃ©dico Receptor)** | Chain of Custody & Traceability | Value Object |
| 23 | **SaaS Subscription Plan (Plan de SuscripciÃ³n SaaS B2B)** | Identity, Access & Subscriptions (IAM) | Aggregate Root |
| 24 | **Smart Medical Container (Contenedor MÃ©dico Inteligente)** | Smart Container & Telemetry Monitoring | Aggregate Root |
| 25 | **Tare Weight & Net Weight (Peso Tara y Peso Neto)** | Smart Container & Telemetry Monitoring | Value Object |
| 26 | **Thermal Excursion (ExcursiÃ³n TÃ©rmica)** | Critical Alerting & Incident Response | Domain Event / Aggregate Root |
| 27 | **Transport Mission / Emergency Transport Order (MisiÃ³n de Transporte Asistido / Orden de Traslado de Emergencia)** | Medical Transport Planning & Dispatching | Aggregate Root |
| 28 | **Vehicle Telematics and Auxiliary Power (TelemÃ¡tica Vehicular y AlimentaciÃ³n Auxiliar)** | Smart Container & Telemetry Monitoring | Value Object / Domain Event |
| 29 | **Weight-Based Medical Stock (Stock MÃ©dico Ponderal)** | Smart Container & Telemetry Monitoring | Value Object |

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
      <td><strong>Healthcare &amp; Pharmaceutical Client (Centro de Salud y Cadena FarmacÃ©utica)</strong></td>
      <td>Entidad pÃºblica o privada del sector salud o farmacÃ©utico (hospital nacional, clÃ­nica privada, instituto especializado, laboratorio clÃ­nico o cadena farmacÃ©utica) facultada legalmente para actuar como centro emisor o receptor de insumos mÃ©dicos crÃ­ticos, medicamentos termosensibles, hemoderivados u Ã³rganos bajo estricta cadena de frÃ­o.</td>
      <td><strong>Aggregate Root:</strong> <code>HospitalInstitution</code><br><em>Bounded Context:</em> Identity, Access &amp; Subscriptions (IAM)</td>
    </tr>
    <tr>
      <td><strong>Hospital Geofence (Geocerca Hospitalaria)</strong></td>
      <td>PerÃ­metro geogrÃ¡fico virtual delimitado alrededor de la instituciÃ³n de salud receptora (tÃ­picamente con un radio de 2 km / 10 min), cuyo traspaso por la ambulancia activa automÃ¡ticamente los protocolos de pre-arribo y habilita la autorizaciÃ³n del desbloqueo digital.</td>
      <td><strong>Value Object:</strong> <code>GeoFence</code> en <code>HospitalInstitution</code><br><em>Bounded Context:</em> Identity, Access &amp; Subscriptions (IAM)</td>
    </tr>
    <tr>
      <td><strong>SaaS Subscription Plan (Plan de SuscripciÃ³n SaaS B2B)</strong></td>
      <td>Acuerdo comercial formal y recurrente entre la plataforma Medical SMARTBOX y la instituciÃ³n de salud o empresa de ambulancias, que establece la cuota mÃ¡xima de contenedores mÃ©dicos autorizados en flota (Small Box de 5L vs. Standard Box de 20L), niveles de servicio de soporte y acceso multi-inquilino al portal de trazabilidad.</td>
      <td><strong>Aggregate Root:</strong> <code>SubscriptionPlan</code><br><em>Bounded Context:</em> Identity, Access &amp; Subscriptions (IAM)</td>
    </tr>
    <tr>
      <td><strong>Fleet Container Provisioning (Aprovisionamiento y VinculaciÃ³n de Flota)</strong></td>
      <td>Proceso tÃ©cnico y administrativo mediante el cual se activa, calibra y asocia un Contenedor MÃ©dico Inteligente a la flota de una instituciÃ³n acreditada, vinculando su nÃºmero de serie de fÃ¡brica a los lÃ­mites de membresÃ­a contratados.</td>
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
      <td><strong>Acceptable Temperature Range (Rango TÃ©rmico Aceptable)</strong></td>
      <td>Intervalo estricto de temperatura de preservaciÃ³n bioambiental fijado por las Buenas PrÃ¡cticas de Almacenamiento y Transporte de DIGEMID (+2.0 Â°C a +8.0 Â°C para medicamentos biolÃ³gicos, vacunas y hemoderivados; y +2.0 Â°C a +4.0 Â°C para Ã³rganos de donante cadavÃ©rico), dentro del cual se garantiza la estabilidad farmacolÃ³gica y viabilidad tisular de la carga.</td>
      <td><strong>Value Object:</strong> <code>TemperatureRange</code> en <code>TransportOrder</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Cold Ischemia Time (Tiempo de Isquemia FrÃ­a)</strong></td>
      <td>Intervalo de tiempo fisiolÃ³gico mÃ¡ximo que un Ã³rgano para trasplante puede permanecer sin irrigaciÃ³n sanguÃ­nea en preservaciÃ³n hipotÃ©rmica (desde el clampado aÃ³rtico en el hospital donante hasta su revascularizaciÃ³n en quirÃ³fano) antes de sufrir necrosis tisular irreversible, gobernado por la Directiva Sanitaria NÂ° 152/DIGDOT.</td>
      <td><strong>Value Object:</strong> <code>IschemiaTimeLimit</code> en <code>TransportOrder</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Dynamic Route ETA (Tiempo Estimado de Llegada DinÃ¡mico)</strong></td>
      <td>CÃ¡lculo predictivo continuo de la duraciÃ³n remanente y la hora exacta de arribo de la ambulancia al hospital de destino, ajustado dinÃ¡micamente segÃºn las variaciones del flujo vehicular, congestiÃ³n e incidentes de trÃ¡nsito en los corredores hospitalarios de Lima Metropolitana.</td>
      <td><strong>Value Object:</strong> <code>RouteProgress</code> en la Entidad <code>TransportRoute</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Emergency Medical Crew (TripulaciÃ³n Asistencial y ParamÃ©dica)</strong></td>
      <td>Personal asistencial calificado (paramÃ©dicos, enfermeros o conductores de emergencias mÃ©dicas) encargado de la operaciÃ³n en ruta, conexiÃ³n del contenedor a la toma 12V del vehÃ­culo asistencial y custodia fÃ­sica directa durante el traslado de urgencia.</td>
      <td><strong>Entity:</strong> <code>CrewMember</code> en <code>DispatchTrip</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Logistics Transport Unit (Unidad de Transporte y Ambulancia LogÃ­stica)</strong></td>
      <td>VehÃ­culo terrestre de transporte especializado (ambulancia asistencial Tipo II/III o furgÃ³n logÃ­stico climatizado) operado por empresas de transporte y operadores logÃ­sticos de cadena de frÃ­o, equipado con soporte elÃ©ctrico continuo de 12V en cabina y sistema telemÃ¡tico de navegaciÃ³n para el Contenedor MÃ©dico Inteligente.</td>
      <td><strong>Entity:</strong> <code>VehicleBinding</code> asociada al Agregado <code>DispatchTrip</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Medical and Biological Payload (Carga MÃ©dica y BiolÃ³gica)</strong></td>
      <td>Conjunto de insumos terapÃ©uticos y biolÃ³gicos altamente termosensibles y crÃ­ticos trasladados en la unidad de transporte asistido, que comprende Ã³rganos sÃ³lidos para trasplante (corazÃ³n, riÃ±Ã³n, hÃ­gado), tejidos humanos, componentes sanguÃ­neos (paquetes globulares, plasma), vacunas e inmunobiolÃ³gicos, y medicamentos de alto costo sujetos a rigurosos lÃ­mites de supervivencia biolÃ³gica.</td>
      <td><strong>Value Object:</strong> <code>BiologicalPayload</code> encapsulado en <code>TransportOrder</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Procurement &amp; Dispatch Coordinator (Coordinador de Procura y Despacho Asistencial)</strong></td>
      <td>Profesional asistencial o logÃ­stico (adscrito a DIGDOT, MINSA o a la central de despacho del operador de transporte) facultado para autorizar la misiÃ³n de traslado, evaluar la disponibilidad de unidades mÃ³viles climatizadas y emitir la orden formal de transporte de Ã³rganos o hemoderivados.</td>
      <td><strong>Entity:</strong> <code>DispatchCoordinator</code> en <code>TransportOrder</code><br><em>Bounded Context:</em> Medical Transport Planning &amp; Dispatching</td>
    </tr>
    <tr>
      <td><strong>Transport Mission / Emergency Transport Order (MisiÃ³n de Transporte Asistido / Orden de Traslado de Emergencia)</strong></td>
      <td>OperaciÃ³n asistencial protocolizada de traslado mÃ©dico entre un centro de salud o almacÃ©n farmacÃ©utico de origen y una instituciÃ³n de destino, gobernada por una ventana temporal crÃ­tica, una tripulaciÃ³n tÃ©cnica asignada y directivas estrictas de conservaciÃ³n bioambiental.</td>
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
      <td><strong>Automated Maintenance and Sensor Calibration (Mantenimiento y CalibraciÃ³n Automatizada)</strong></td>
      <td>Protocolo de diagnÃ³stico predictivo y continuo ejecutado de forma autÃ³noma por el contenedor inteligente y la plataforma de monitoreo asistencial para supervisar el desgaste de la celda Peltier, la deriva de calibraciÃ³n de la celda de carga HX711 y los ciclos de vida Ãºtil de la baterÃ­a interna LiFePO4, programando Ã³rdenes de servicio preventivo antes de que ocurra una falla operativa en ruta.</td>
      <td><strong>Domain Policy:</strong> <code>PreventiveMaintenancePolicy</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Cold Chain (Cadena de FrÃ­o)</strong></td>
      <td>Proceso logÃ­stico ininterrumpido de control y supervisiÃ³n ambiental que asegura que los insumos biolÃ³gicos y farmacÃ©uticos se mantengan dentro de los intervalos tÃ©rmicos normativos reglamentados por el MINSA y la DIGEMID (+2 Â°C a +4 Â°C para Ã³rganos; +2 Â°C a +8 Â°C para hemoderivados y vacunas) durante todas las etapas de custodia y desplazamiento en ambulancia.</td>
      <td><strong>Domain Policy:</strong> <code>ColdChainPreservationPolicy</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Container Autonomy and Telemetry (TelemetrÃ­a y AutonomÃ­a del Contenedor)</strong></td>
      <td>Flujo periÃ³dico de mediciones fÃ­sicas directas (temperatura interna de cÃ¡mara, peso en bandeja, estado del sensor magnÃ©tico de tapa, voltaje y porcentaje de carga de la baterÃ­a interna LiFePO4) transmitidas de forma continua para garantizar que el soporte tÃ©rmico se mantenga activo aun ante desconexiones de la red de la ambulancia.</td>
      <td><strong>Entity:</strong> <code>TelemetryLog</code> / <strong>Value Object:</strong> <code>TelemetrySnapshot</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Container Lid Status &amp; Tamper-Evident Lock (Estado de Tapa y Bloqueo ElectromecÃ¡nico de Custodia)</strong></td>
      <td>SupervisiÃ³n continua del sellado hermÃ©tico superior (contacto magnÃ©tico) y cerrojo electromecÃ¡nico de alta retenciÃ³n comandado por solenoide, que previene la apertura no autorizada de la tapa durante el trÃ¡nsito de la ambulancia y habilita su liberaciÃ³n fÃ­sica Ãºnicamente cuando el vehÃ­culo ingresa a la geocerca hospitalaria de destino y el personal facultado valida su identidad mediante un cÃ³digo OTP de un solo uso.</td>
      <td><strong>Entity:</strong> <code>ElectromechanicalLock</code> subordinada a <code>SmartContainer</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Smart Medical Container (Contenedor MÃ©dico Inteligente)</strong></td>
      <td>Unidad fÃ­sica mÃ³vil e isotÃ©rmica de grado clÃ­nico instalada en el transporte asistido, disponible en diversos factores de forma y capacidades volumÃ©tricas modulares segÃºn los requisitos de carga, dotada de aislamiento tÃ©rmico de alta densidad, alimentaciÃ³n energÃ©tica dual (red fija y toma vehicular de 12V), instrumentaciÃ³n de mediciÃ³n bioambiental continua y mecanismo de cierre electromecÃ¡nico de seguridad.</td>
      <td><strong>Aggregate Root:</strong> <code>SmartContainer</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Tare Weight &amp; Net Weight (Peso Tara y Peso Neto)</strong></td>
      <td>Procedimiento metrolÃ³gico de calibraciÃ³n en origen mediante el cual se descuenta la masa basal del contenedor vacÃ­o y sus componentes de fijaciÃ³n (tara), permitiendo cuantificar con precisiÃ³n (&plusmn;5 g) la masa neta de la carga biolÃ³gica para detectar variaciones por fugas, sustracciÃ³n o reemplazo clandestino durante el traslado.</td>
      <td><strong>Value Object:</strong> <code>ContainerWeightMetrics</code> en <code>SmartContainer</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Vehicle Telematics and Auxiliary Power (TelemÃ¡tica Vehicular y AlimentaciÃ³n Auxiliar)</strong></td>
      <td>ParÃ¡metros operativos capturados desde la unidad mÃ³vil de transporte asistencial (estado de suministro elÃ©ctrico continuo de 12V en cabina, velocidad de desplazamiento y coordenadas geogrÃ¡ficas en tiempo real) que permiten supervisar la estabilidad energÃ©tica del contenedor y predecir los tiempos de traslado en la red vial de Lima Metropolitana.</td>
      <td><strong>Value Object:</strong> <code>AuxiliaryPowerTelemetry</code> / <strong>Domain Event:</strong> <code>ExternalPowerLost</code><br><em>Bounded Context:</em> Smart Container &amp; Telemetry Monitoring</td>
    </tr>
    <tr>
      <td><strong>Weight-Based Medical Stock (Stock MÃ©dico Ponderal)</strong></td>
      <td>EstimaciÃ³n cuantitativa en tiempo real de la cantidad de medicamentos, ampollas o insumos almacenados dentro del compartimento, calculada a partir de las variaciones de masa registradas continuamente por la celda de carga de precisiÃ³n, permitiendo prevenir desabastecimientos en ruta o sustracciones clandestinas.</td>
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
      <td><strong>Cold-Chain Deviation Report (Informe de DesviaciÃ³n de Cadena de FrÃ­o)</strong></td>
      <td>Acta tÃ©cnico-sanitaria de notificaciÃ³n obligatoria emitida automÃ¡ticamente cuando se constata una excursiÃ³n tÃ©rmica no mitigada durante el traslado en ambulancia, documentando la integral tiempo-temperatura del evento para sustentar formalmente el descarte, reemplazo o cuarentena preventiva del lote mÃ©dico ante auditorÃ­as de DIGEMID y DIGDOT.</td>
      <td><strong>Read Model / Domain Report:</strong> <code>ColdChainDeviationReport</code><br><em>Bounded Context:</em> Critical Alerting &amp; Incident Response</td>
    </tr>
    <tr>
      <td><strong>Critical Operational Alert &amp; Acknowledgment (Alerta Operativa CrÃ­tica y Acuse de Recibo)</strong></td>
      <td>NotificaciÃ³n de alta prioridad y respuesta inmediata ante contingencias en ruta (excursiones tÃ©rmicas, desconexiÃ³n vehicular de 12V, apertura indebida o anomalÃ­as ponderales), que combina avisos acÃºstico-visuales en la cabina asistencial y alertas digitales a la central mÃ©dica, requiriendo que la tripulaciÃ³n confirme manualmente su recepciÃ³n en un plazo no mayor a 2 minutos para coordinar el plan de contingencia.</td>
      <td><strong>Aggregate Root:</strong> <code>CriticalIncident</code> / <strong>Entity:</strong> <code>ContingencyResolution</code><br><em>Bounded Context:</em> Critical Alerting &amp; Incident Response</td>
    </tr>
    <tr>
      <td><strong>Hospital Pre-Arrival Notice (Aviso de Pre-Arribo Hospitalario)</strong></td>
      <td>ComunicaciÃ³n protocolar preventiva enviada automÃ¡ticamente al equipo mÃ©dico y quirÃºrgico del hospital receptor cuando la ambulancia se encuentra a una proximidad crÃ­tica (10 minutos de arribo o cruce de geocerca), facilitando el alistamiento de quirÃ³fano, esterilizaciÃ³n de instrumental y despeje de rampas de trauma shock.</td>
      <td><strong>Domain Event:</strong> <code>HospitalPreArrivalTriggered</code><br><em>Bounded Context:</em> Critical Alerting &amp; Incident Response</td>
    </tr>
    <tr>
      <td><strong>Thermal Excursion (ExcursiÃ³n TÃ©rmica)</strong></td>
      <td>Incidente crÃ­tico originado cuando la temperatura interna de la cÃ¡mara del contenedor traspasa los mÃ¡rgenes de seguridad normativos durante un tiempo mayor a la tolerancia asistencial permitida, comprometiendo la estabilidad fisicoquÃ­mica o viabilidad celular del insumo y tipificÃ¡ndose como una no conformidad sanitaria grave.</td>
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
      <td><strong>Audit Trail &amp; Digital Manifest (Rastro de AuditorÃ­a y Manifiesto Digital)</strong></td>
      <td>Secuencia ininterrumpida y cronolÃ³gica de evidencias fÃ­sicas, temporales y ambientales registradas durante toda la misiÃ³n de transporte, compilada al cierre en un acta o expediente digital sellado criptogrÃ¡ficamente que acredita ante los auditores de DIGEMID, DIGDOT y SUSALUD que la custodia mÃ©dica nunca fue vulnerada.</td>
      <td><strong>Aggregate Root:</strong> <code>DigitalAuditManifest</code><br><em>Bounded Context:</em> Chain of Custody &amp; Traceability</td>
    </tr>
    <tr>
      <td><strong>Chain of Custody (Cadena de Custodia Sanitaria)</strong></td>
      <td>Registro documental, fÃ­sico y legal continuo e inalterable que certifica la tenencia, ubicaciÃ³n, trazabilidad horaria, eventos de manipulaciÃ³n y curvas bioambientales de la carga mÃ©dica desde el centro donante o farmacia de origen hasta su recepciÃ³n definitiva.</td>
      <td><strong>Core Bounded Context:</strong> Chain of Custody &amp; Traceability<br><em>Aggregate Root:</em> <code>CustodyTransfer</code></td>
    </tr>
    <tr>
      <td><strong>Custody Handover Act (Acta de Entrega y Trazabilidad de Custodia)</strong></td>
      <td>Documento protocolar formal generado al tÃ©rmino del traslado asistencial, donde la tripulaciÃ³n paramÃ©dica y el equipo mÃ©dico receptor rubrican mancomunadamente la conformidad del estado fÃ­sico, el balance de stock y el dictamen de viabilidad biolÃ³gica con el respaldo de la curva tÃ©rmica completa del trayecto.</td>
      <td><strong>Aggregate Root:</strong> <code>CustodyTransfer</code><br><em>Bounded Context:</em> Chain of Custody &amp; Traceability</td>
    </tr>
    <tr>
      <td><strong>One-Time Password / Unlock Token (Clave OTP / Token de Desbloqueo Temporal)</strong></td>
      <td>Clave numÃ©rica efÃ­mera de seguridad clÃ­nica generada dinÃ¡micamente por la plataforma y transmitida exclusivamente al mÃ©dico receptor facultado, cuya introducciÃ³n en el panel de control del contenedor condiciona la liberaciÃ³n del solenoide fÃ­sico de la tapa Ãºnicamente cuando la ambulancia se encuentra dentro de la geocerca hospitalaria autorizada de destino.</td>
      <td><strong>Value Object:</strong> <code>OtpToken</code> encapsulado en <code>CustodyTransfer</code><br><em>Bounded Context:</em> Chain of Custody &amp; Traceability</td>
    </tr>
    <tr>
      <td><strong>Receiving Medical Custodian (Custodio MÃ©dico Receptor)</strong></td>
      <td>Profesional de la salud facultado en el establecimiento hospitalario o farmacia de destino (cirujano de trasplantes, mÃ©dico de emergencia o quÃ­mico farmacÃ©utico responsable) habilitado para recibir la clave OTP, constatar la viabilidad clÃ­nica y formalizar el acta de conformidad.</td>
      <td><strong>Value Object:</strong> <code>ReceivingPhysician</code> en <code>CustodyTransfer</code><br><em>Bounded Context:</em> Chain of Custody &amp; Traceability</td>
    </tr>
  </tbody>
</table>
