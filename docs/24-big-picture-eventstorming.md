# 2.4. Big Picture EventStorming

El equipo llevó a cabo una sesión formal de **Big Picture EventStorming** con el objetivo de obtener una visión holística y compartida del dominio de negocio del **Contenedor Médico Inteligente (Smart Medical Container)** para el transporte asistencial de medicamentos termosensibles, hemoderivados, muestras biológicas y órganos en Lima Metropolitana. Bajo los principios y prácticas de *Domain-Driven Design* y la técnica de *EventStorming* propuesta por Alberto Brandolini, la dinámica integró activamente la perspectiva de los dos segmentos objetivo del negocio: **Empresas de Transporte y Operadores Logísticos de Cadena de Frío** (conductores y paramédicos de ambulancia) y **Centros de Salud y Cadenas Farmacéuticas** (coordinadores de despacho, farmacéuticos y médicos receptores), en conjunto con el equipo de ingeniería de software e IoT.

Siguiendo los principios de modelado colaborativo de Brandolini, el Big Picture EventStorming no se diseñó como un diagrama de flujo rígido de ingeniería ni como un BPMN con carriles estructurados, sino como un **lienzo colaborativo de notas adhesivas** en Miro donde el tiempo fluye de manera natural y orgánica de **izquierda a derecha**. A lo largo de la sesión, los participantes exploraron el ciclo de vida completo del transporte médico urgente: desde la solicitud inicial del traslado hasta la recepción conforme en el centro de salud receptor bajo estricta cadena de frío (2 °C a 8 °C según DIGEMID R.M. N° 833-2015/MINSA) y custodia electrónica inmutable.

El taller se desarrolló ejecutando rigurosamente los nueve (9) pasos estructurados del proceso canónico de Big Picture EventStorming documentado por Alberto Brandolini (*Step-by-Step Guide to Run Your Big Picture EventStorming*):

1. **Preparación del Espacio y Materiales (*Preparing the Room*):** Se estructuró un lienzo infinito colaborativo en Miro, eliminando barreras jerárquicas y configurando una superficie de modelado sin límites de anchura, provista de la agenda visual de la sesión y una paleta cromática estandarizada de notas adhesivas digitales.
2. **Dinámica de Activación (*Energizing the Audience*):** Se realizó una breve dinámica de desinhibición y alineación para predisponer activamente al equipo multidisciplinario, articulando la visión operativa de conductores y paramédicos de ambulancia (Segmento 1) con el criterio clínico de médicos cirujanos, químicos farmacéuticos y el equipo de ingeniería de software e IoT (Segmento 2).
3. **Presentación del Alcance, Objetivos y Reglas (*Briefing and Presenting the Plan*):** El facilitador presentó el propósito central del modelado: la preservación inviolable de la cadena de frío (+2 °C a +8 °C bajo normativa DIGEMID R.M. N° 833-2015) y la trazabilidad digital de órganos y hemoderivados frente a la congestión vehicular de Lima Metropolitana, estableciendo las reglas de interacción y respeto por el tiempo cronológico.
4. **Generación Caótica de Eventos de Dominio (*Generating Domain Events*):** Fase divergente de modelado silencioso e individual. Cada participante escribió y pegó de forma libre y masiva en notas adhesivas naranjas (`#FFA500`) todos los eventos relevantes del negocio expresados en tiempo verbal pasado (*Domain Events*), reflejando hitos significativos como `Pre-enfriamiento Peltier estabilizado`, `Excursión térmica incipiente detectada` o `Muestra aceptada formalmente como viable`.
5. **Ordenamiento Cronológico y Detección de Flujos Concurrentes (*Sorting Domain Events*):** Fase convergente de debate intenso. Los participantes organizaron cooperativamente las notas de izquierda a derecha en una línea temporal estricta de extremo a extremo, alineando verticalmente los procesos que ocurren en paralelo (por ejemplo, el control térmico autónomo Peltier ejecutándose concurrentemente mientras el vehículo avanza en el tráfico).
6. **Identificación de Actores y Sistemas Externos (*Adding Actors and External Systems*):** Se incorporaron los roles humanos responsables de gatillar o atender eventos mediante notas amarillas pequeñas (Conductor de Ambulancia, Paramédico TEM, Coordinador de Despacho, Cirujano Receptor), así como los sistemas externos interactuantes en notas azules (Firmware Autónomo ESP32 como nodo IoT Edge emisor, API de Tráfico TomTom, Pasarela SMS Twilio, Registro RENIPRESS / SUSALUD y Sistema HIS / Quirófano Hospitalario receptor).
7. **Narración Cronológica Hacia Adelante (*Storytelling*):** Un facilitador y representantes de ambos segmentos narraron oralmente la historia completa del flujo de negocio de izquierda a derecha. Esta lectura validó la consistencia global del proceso, esclareció supuestos implícitos y permitió identificar fricciones operativas y riesgos reales, señalizados de inmediato con notas magenta/rosa (*Hotspots*).
8. **Narración Inversa y Detección de Brechas (*Reverse Storytelling*):** Se ejecutó una lectura en sentido inverso, comenzando desde el evento final (`Muestra aceptada formalmente como viable` / `Acta final de entrega firmada digitalmente`) y preguntando repetidamente: *¿Qué condición previa tuvo que cumplirse para que ocurriera este hecho?* Este análisis retrospectivo descubrió eventos faltantes de bioseguridad, validaciones de pre-enfriamiento y protocolos de contingencia ante caídas de la toma vehicular de 12V.
9. **Cierre, Consenso y Síntesis de Oportunidades (*Closing and Synthesis*):** Se consolidó el entendimiento compartido del dominio, se extrajo el vocabulario fundamental para la construcción del Lenguaje Ubicuo (Sección 2.5) y se priorizaron en notas verdes las oportunidades de solución de software e IoT (tara automática con celda de carga HX711, algoritmo predictivo de desvíos de ETA y acta digital inmutable con firma QR).

***

![Figura 2.4 - Big Picture EventStorming: Fases de Origen, Tránsito y Destino](assets/chapter-2/smart-medical-container-eventstorming.jpg)  
*Nota: Elaboración propia en Miro según la técnica de modelado colaborativo de Alberto Brandolini para el transporte asistencial de muestras médicas y órganos en Lima Metropolitana.*

***

### **2.4.1. Análisis del Dominio y Hallazgos de la Sesión**

La sesión de Big Picture EventStorming permitió al equipo comprender la dinámica real del transporte médico en Lima Metropolitana y articular las necesidades clínicas con la arquitectura del sistema:

#### 1. Exploración Desestructurada, Línea de Tiempo y Eventos Pivote (Pivotal Events)
El mapeo de eventos evidenció que el transporte asistencial es un proceso altamente concurrente y sensible al tiempo. Mientras el vehículo se desplaza por arterias viales congestionadas de Lima Metropolitana, el hardware del contenedor inteligente ejecuta en paralelo un lazo cerrado autónomo de control térmico (manteniendo la carga entre +2.0 °C y +8.0 °C mediante celdas Peltier), registrando la estabilidad del peso y verificando el precinto de seguridad electromecánico.

Siguiendo el enfoque canónico de modelado colaborativo concebido por Alberto Brandolini, la línea de tiempo temporal se estructura a partir de tres **Eventos Pivote (*Pivotal Events*)** que demarcan formalmente los momentos críticos de quiebre y transición de responsabilidad entre las tres macrofases del sistema:
* **Pivotal Event 1 (Origen → Tránsito):** `Acta digital de salida generada y firmada digitalmente` junto con la `Conexión del contenedor a la toma 12V DC`. Marca la transferencia legal de custodia desde el hospital donante o farmacia central hacia el equipo asistencial móvil, activando el régimen de supervisión telemática en ruta.
* **Pivotal Event 2 (Tránsito → Destino):** `Geocerca de pre-arribo hospitalaria activada`. Disparo telemático automatizado al ingresar al radio de 2 km / 10 minutos del hospital receptor, habilitando la alerta temprana a la rampa de trauma shock y la preparación del equipo médico o farmacéutico receptor.
* **Pivotal Event 3 (Destino → Cierre Clínico):** `Muestra aceptada formalmente como viable`, `Acta final de entrega firmada digitalmente` y `Expediente PDF auditado exportado a DIGEMID`. Cierre definitivo de la cadena de custodia con generación del expediente digital sellado mediante hash criptográfico SHA-256 para auditoría sanitaria de DIGEMID.

#### 2. Matriz de Puntos Críticos (Hotspots) y Oportunidades de Solución

La pizarra colaborativa desarrollada en Miro articula el flujo de izquierda a derecha en tres macrofases espaciales (**1. Origen y Despacho**, **2. Tránsito y Monitoreo Asistencial**, **3. Destino, Custodia y Cierre Clínico**), integrando analíticamente sus seis (6) etapas operativas para brindar una granularidad técnica precisa.

La siguiente matriz sintetiza los problemas operativos reales identificados en la red hospitalaria de Lima y las soluciones de ingeniería de software e IoT implementadas:

<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 7pt; line-height: 1.25; border: 1px solid #cbd5e1; margin: 12px 0;">
<colgroup>
  <col style="width: 14%;" />
  <col style="width: 26%;" />
  <col style="width: 12%;" />
  <col style="width: 28%;" />
  <col style="width: 20%;" />
</colgroup>
  <thead>
    <tr>
      <th>Fase Operativa</th>
      <th>Punto Crítico / Hotspot (Problema Real en Lima)</th>
      <th>Severidad</th>
      <th>Oportunidad de Solución (Software / IoT)</th>
      <th>Subdominio DDD</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Despacho</strong></td>
      <td>Asignación de ambulancias sin visibilidad del estado de su toma de 12V ni del pre-enfriamiento del contenedor.</td>
      <td>Alta</td>
      <td><strong>Tablero IoT de Estado de Flota:</strong> Supervisión en tiempo real de batería, conexión eléctrica y temperatura previa.</td>
      <td><em>Medical Transport Planning & Dispatching</em></td>
    </tr>
    <tr>
      <td><strong>Carga y Custodia</strong></td>
      <td>Riesgo de sustitución de muestras o carga de paquetes no verificados en la rampa hospitalaria.</td>
      <td>Crítica</td>
      <td><strong>Tara Automática con Celda HX711:</strong> Registro de masa inicial (&plusmn;5 g) y bloqueo automático del solenoide.</td>
      <td><em>Smart Container & Telemetry Monitoring</em></td>
    </tr>
    <tr>
      <td><strong>Carga y Custodia</strong></td>
      <td>Actas en papel autocopiativo mojadas, extraviadas o ilegibles sin respaldo probatorio.</td>
      <td>Media</td>
      <td><strong>Acta Digital con Firma QR:</strong> Comprobante electrónico inalterable consultable en plataforma web.</td>
      <td><em>Chain of Custody & Traceability</em></td>
    </tr>
    <tr>
      <td><strong>Tránsito</strong></td>
      <td><strong>Congestión severa en Lima (TomTom: 34 min/10 km):</strong> Retrasos críticos en Av. Javier Prado o Vía Expresa.</td>
      <td>Crítica</td>
      <td><strong>Motor de ETA Dinámico:</strong> Recálculo de tiempos con TomTom Traffic API cada 60s y alertas de demora.</td>
      <td><em>Medical Transport Planning & Dispatching</em></td>
    </tr>
    <tr>
      <td><strong>Tránsito</strong></td>
      <td><strong>Golpe de calor en cabina (hasta 38.5 &deg;C):</strong> Rompe la cadena de frío en cajas convencionales en &lt;45 min.</td>
      <td>Catastrófica</td>
      <td><strong>Refrigeración Activa Peltier + Alarma Dual:</strong> Control PID (2&ndash;8 &deg;C), alarma sonora local y push a médicos.</td>
      <td><em>Critical Alerting & Incident Response</em></td>
    </tr>
    <tr>
      <td><strong>Tránsito</strong></td>
      <td><strong>Desconexión accidental de 12V:</strong> El enchufe del encendedor se zafa con baches o frenadas.</td>
      <td>Alta</td>
      <td><strong>Conmutación Automática a Batería LiFePO4:</strong> Pack interno LiFePO4 (4h de autonomía) con aviso en cabina.</td>
      <td><em>Smart Container & Telemetry Monitoring</em></td>
    </tr>
    <tr>
      <td><strong>Tránsito</strong></td>
      <td><strong>Pérdida de señal 4G en túneles (Línea Amarilla / zanjas):</strong> Provoca vacíos de datos durante el traslado.</td>
      <td>Alta</td>
      <td><strong>Búfer Flash Offline en ESP32:</strong> Almacenamiento local de 5,000 muestras y sincronización al reconectar.</td>
      <td><em>Smart Container & Telemetry Monitoring</em></td>
    </tr>
    <tr>
      <td><strong>Arribo</strong></td>
      <td>Quirófano o personal de guardia no preparado al llegar la ambulancia por falta de preaviso.</td>
      <td>Alta</td>
      <td><strong>Geocerca de Pre-Arribo (&le; 2 km / 10 min):</strong> Notificación automática al hospital receptor para alistar recepción.</td>
      <td><em>Medical Transport Planning & Dispatching</em></td>
    </tr>
    <tr>
      <td><strong>Entrega</strong></td>
      <td>Apertura indebida en pasillos o entrega a personal no facultado sin validación de identidad.</td>
      <td>Crítica</td>
      <td><strong>Doble Factor de Desbloqueo:</strong> Ubicación obligatoria en geocerca hospitalaria + código OTP temporal.</td>
      <td><em>Chain of Custody & Traceability</em></td>
    </tr>
    <tr>
      <td><strong>Cierre</strong></td>
      <td>Rechazo de lotes o litigios por falta de auditoría continua exigida por DIGEMID (R.M. 833-2015).</td>
      <td>Media</td>
      <td><strong>Expediente Digital con Hash SHA-256:</strong> Reporte PDF descargable con telemetría completa y firmas.</td>
      <td><em>Chain of Custody & Traceability</em></td>
    </tr>
  </tbody>
</table>

***

#### 3. Validación por Storytelling y Reverse Storytelling
La validación del recorrido de extremo a extremo confirmó la coherencia del ciclo asistencial entre ambos segmentos. Mediante la narrativa directa se verificó la transición sin fricciones de custodia entre el médico emisor, el paramédico y el cirujano receptor. Complementariamente, el análisis retrospectivo desde el hito `Muestra aceptada formalmente como viable` (`Acta final de entrega firmada digitalmente`) comprobó que ninguna entrega puede consumarse sin la confluencia de tres condiciones inviolables: desbloqueo por OTP dentro de la geocerca hospitalaria, preservación térmica continua (2 °C a 8 °C) garantizada por el respaldo LiFePO4, y descarga íntegra de la telemetría resguardada en el búfer flash local tras cruzar túneles.

#### 4. Delimitación de Contextos Delimitados (Bounded Contexts)
La sesión de Big Picture permitió delimitar cinco (5) Bounded Contexts de negocio, los cuales constituyen las fronteras transaccionales definitivas del sistema y se preservan de manera consistente a lo largo de toda la arquitectura y diseño de software:
1. **Identity, Access & Subscriptions (IAM):** Gestión de instituciones hospitalarias acreditadas (RENIPRESS), planes de suscripción SaaS B2B, autenticación JWT basada en roles y trazabilidad de licencias médicas.
2. **Medical Transport Planning & Dispatching:** Gestión de solicitudes de traslado urgente, asignación de unidades asistenciales/tripulación, cálculo dinámico de rutas anti-tráfico TomTom y geocercas de pre-arribo.
3. **Smart Container & Telemetry Monitoring:** Ingestión de telemetría continua (temperatura, peso neto HX711, batería LiFePO4), control electromecánico de tapa y alta física de dispositivos IoT.
4. **Critical Alerting & Incident Response:** Detección en tiempo real de excursiones térmicas, disparador de alarmas acústicas en cabina y notificación omnicanal de contingencias.
5. **Chain of Custody & Traceability:** Verificación de token OTP en geocerca hospitalaria, registro de actas de custodia y sellado inmutable con hash SHA-256 para DIGEMID (R.M. 833-2015).

***

### **2.4.2. Flujo Detallado de Comandos, Eventos y Políticas de Dominio**

Para complementar la visión macro del lienzo y facilitar la transición hacia el diseño táctico (DDD) y los contratos de software, a continuación se especifican los artefactos canónicos de la técnica:

#### Leyenda de Modelado

| Elemento | Significado | Ejemplo en el Dominio |
|---|---|---|
| **Actor** | Persona o rol que inicia una intención o toma una decisión. | Coordinador logístico, Paramédico TEM, Cirujano receptor. |
| **Comando** | Intención de acción que busca modificar el estado del sistema. | `AsignarRecursosTraslado`, `RegistrarLecturaTelemetria`. |
| **Evento de Dominio** | Hecho relevante consumado e inmutable expresado en tiempo pasado. | `TrasladoIniciado`, `ExcursionTermicaDetectada`. |
| **Política / Regla** | Reacción automática ante un evento (*Whenever [Event] Then [Action]*). | Si la temperatura supera 8.0 °C por >2 min, emitir alerta crítica. |
| **Read Model** | Proyección de datos optimizada para la toma de decisiones. | Tablero de telemetría en vivo, Línea de tiempo de custodia. |
| **Sistema Externo** | Plataforma de terceros fuera de la frontera transaccional. | GPS / TomTom API, Bróker MQTT, Pasarela Twilio SMS. |
| **Hotspot** | Riesgo operacional, vacío normativo o punto de fricción técnica. | Falla de señal celular 4G en zanjas viales o túneles de Lima. |

#### Flujo Secuencial de Eventos de Extremo a Extremo

<div style="margin: 12px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 6%;" />
  <col style="width: 20%;" />
  <col style="width: 24%;" />
  <col style="width: 25%;" />
  <col style="width: 25%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">N.°</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Actor / Sistema</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Comando</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Evento de Dominio Resultante</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Read Model o Evidencia Generada</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">1</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Institución de origen</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`SolicitarTraslado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`TrasladoSolicitado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Registro de solicitud con tipo de carga médica, origen, destino y prioridad clínica.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">2</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Coordinador de despacho</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`ValidarSolicitud`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`SolicitudValidada`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Verificación de viabilidad, disponibilidad horaria y requerimiento térmico (2 °C - 8 °C).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">3</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Coordinador de despacho</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`AsignarRecursosTraslado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`RecursosAsignados`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Asignación de unidad móvil, contenedor inteligente y tripulación asistencial.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">4</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Paramédico asistencial</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`VerificarPreparacion`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`PreparacionVerificada`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Lista de chequeo previa: estado de batería LiFePO4, calibración y conexión 12V.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">5</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Personal médico emisor</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`RegistrarCargaYSellar`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`CargaRegistrada` / `ContenedorSellado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Registro de masa inicial en celda HX711 (tara automática) y bloqueo electromecánico de solenoide.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">6</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Paramédico asistencial</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`IniciarTraslado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`TrasladoIniciado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Registro de hora exacta de salida, geocerca inicial y cálculo dinámico de ETA.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">7</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Contenedor IoT (ESP32)</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`PublicarTelemetria`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`TelemetriaRegistrada`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Ingesta de temperatura ambiente/interna, nivel de batería, estado de tapa y coordenadas GPS.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">8</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Motor de Reglas de Negocio</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`EvaluarCondiciones`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`CondicionEvaluada`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Validación de cumplimiento estricto del rango térmico e integridad de la ruta.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">9</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Coordinador de despacho</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`SupervisarMonitoreo`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`MonitoreoConfirmado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Tablero de control de flota en tiempo real con semaforización de riesgo.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">10</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Conductor de ambulancia</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`RegistrarArribo`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`UnidadArribadaADestino`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Activación de geocerca hospitalaria de pre-arribo (radio ≤ 2 km / 10 min).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">11</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Cirujano / Farmacéutico receptor</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`VerificarCarga`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`CondicionFinalVerificada`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Inspección de integridad celular, historial térmico continuo y balance de peso.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">12</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Cirujano / Farmacéutico receptor</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`AceptarORechazarEntrega`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`EntregaAceptada` / `EntregaRechazada`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Desbloqueo mediante token dinámico OTP en geocerca y registro de observaciones clínicas.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">13</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Coordinador de despacho</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`CerrarTraslado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`TrasladoCerrado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Sellado de la línea de tiempo inmutable de custodia.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; font-weight: bold;">14</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Plataforma Web</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; font-weight: 500;">`GenerarExpedienteAuditoria`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">`ExpedienteAuditoriaGenerado`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px;">Exportación de reporte técnico PDF sellado con hash criptográfico SHA-256 para DIGEMID.</td>
</tr>
</tbody>
</table>
</div>

#### Políticas y Rutas Alternativas de Contingencia

* **Desviación Térmica (Excursión Térmica):**
  * *Evento desencadenante:* `TemperaturaFueraDeRango`.
  * *Política reactiva:* Si la temperatura interna excede los 8.0 °C o desciende de 2.0 °C durante más de 120 segundos continuos, disparar de inmediato alerta acústica/visual en cabina vehicular y remitir notificación push de máxima severidad a los médicos del hospital receptor.
  * *Acción correctiva:* Paramédico verifica ventilación y suministro eléctrico del contenedor; se registra la intervención en la bitácora telemática.
* **Pérdida de Conectividad Celular (Túneles y Zonas de Sombra 4G):**
  * *Evento desencadenante:* `TelemetriaInterrumpida`.
  * *Política reactiva:* El microcontrolador ESP32 conmuta autónomamente al búfer de memoria flash interna no volátil (almacenando hasta 5,000 muestras con marca de tiempo del RTC), marcando el read model web con advertencia de última lectura conocida. Al reconectar la red celular 4G, se gatilla `TelemetriaRestablecida` y sincronización secuencial en bloque.
* **Retraso Crítico por Congestión Vehicular:**
  * *Evento desencadenante:* `ETAEscedido`.
  * *Política reactiva:* Reevaluación del tráfico en tiempo real mediante TomTom Traffic API. Si la demora supera los 15 minutos respecto a la ventana de viabilidad del órgano, notificar a la central de despacho para gestionar apoyo vial policial o advertir al equipo quirúrgico receptor.
* **Apertura No Autorizada de Escotilla:**
  * *Evento desencadenante:* `AperturaFueraDeGeocercaDetectada`.
  * *Política reactiva:* Si el sensor magnético detecta separación de la tapa fuera del radio hospitalario autorizado, marcar `CadenaDeCustodiaComprometida`, activar sirena local de seguridad y registrar el incidente con coordenadas geográficas inmediatas.

#### Agregados y Límites del Dominio

| Agregado | Responsabilidad Principal | Eventos de Dominio Clave |
|---|---|---|
| **MedicalTransport** | Orquestar el ciclo de vida del traslado, tripulación, ruta y tiempos comprometidos. | `TrasladoSolicitado`, `TrasladoIniciado`, `UnidadArribadaADestino`, `TrasladoCerrado`. |
| **SmartContainer** | Gestionar el estado operativo del hardware, precinto electromecánico y calibración de sensores. | `ContenedorSellado`, `TapaAperturada`, `SuministroConmutadoLiFePO4`. |
| **MedicalPayload** | Salvaguardar la identificación de la carga biológica, condiciones requeridas y verificación médica. | `CargaRegistrada`, `CondicionFinalVerificada`, `EntregaAceptada`. |
| **TelemetryMonitoring**| Ingestar series temporales de temperatura, humedad, peso neto HX711 y posicionamiento GPS. | `TelemetriaRegistrada`, `CondicionEvaluada`, `MuestraSincronizada`. |
| **IncidentAlert** | Gestionar el ciclo de vida de anomalías térmicas y operativas, asignación de responsables y mitigación. | `AlertaGenerada`, `AccionMitigacionRegistrada`, `IncidenteResuelto`. |
| **ChainOfCustody** | Preservar el registro inmutable de transferencias de custodia con firmas electrónicas y token OTP. | `CustodiaTransferida`, `EntregaConfirmada`, `ActaFirmada`. |
