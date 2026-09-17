# 2.4. Big Picture EventStorming

El equipo llevÃ³ a cabo una sesiÃ³n formal de **Big Picture EventStorming** con el objetivo de obtener una visiÃ³n holÃ­stica y compartida del dominio de negocio del **Contenedor MÃ©dico Inteligente (Smart Medical Container)** para el transporte asistencial de medicamentos termosensibles, hemoderivados, muestras biolÃ³gicas y Ã³rganos en Lima Metropolitana. Bajo los principios y prÃ¡cticas de *Domain-Driven Design* y la tÃ©cnica de *EventStorming* propuesta por Alberto Brandolini, la dinÃ¡mica integrÃ³ activamente la perspectiva de los dos segmentos objetivo del negocio: **Empresas de Transporte y Operadores LogÃ­sticos de Cadena de FrÃ­o** (conductores y paramÃ©dicos de ambulancia) y **Centros de Salud y Cadenas FarmacÃ©uticas** (coordinadores de despacho, farmacÃ©uticos y mÃ©dicos receptores), en conjunto con el equipo de ingenierÃ­a de software e IoT.

Siguiendo los principios de modelado colaborativo de Brandolini, el Big Picture EventStorming no se diseÃ±Ã³ como un diagrama de flujo rÃ­gido de ingenierÃ­a ni como un BPMN con carriles estructurados, sino como un **lienzo colaborativo de notas adhesivas** en Miro donde el tiempo fluye de manera natural y orgÃ¡nica de **izquierda a derecha**. A lo largo de la sesiÃ³n, los participantes exploraron el ciclo de vida completo del transporte mÃ©dico urgente: desde la solicitud inicial del traslado hasta la recepciÃ³n conforme en el centro de salud receptor bajo estricta cadena de frÃ­o (2 Â°C a 8 Â°C segÃºn DIGEMID R.M. NÂ° 833-2015/MINSA) y custodia electrÃ³nica inmutable.

El taller se desarrollÃ³ ejecutando rigurosamente los nueve (9) pasos estructurados del proceso canÃ³nico de Big Picture EventStorming documentado por Alberto Brandolini (*Step-by-Step Guide to Run Your Big Picture EventStorming*):

1. **PreparaciÃ³n del Espacio y Materiales (*Preparing the Room*):** Se estructurÃ³ un lienzo infinito colaborativo en Miro, eliminando barreras jerÃ¡rquicas y configurando una superficie de modelado sin lÃ­mites de anchura, provista de la agenda visual de la sesiÃ³n y una paleta cromÃ¡tica estandarizada de notas adhesivas digitales.
2. **DinÃ¡mica de ActivaciÃ³n (*Energizing the Audience*):** Se realizÃ³ una breve dinÃ¡mica de desinhibiciÃ³n y alineaciÃ³n para predisponer activamente al equipo multidisciplinario, articulando la visiÃ³n operativa de conductores y paramÃ©dicos de ambulancia (Segmento 1) con el criterio clÃ­nico de mÃ©dicos cirujanos, quÃ­micos farmacÃ©uticos y el equipo de ingenierÃ­a de software e IoT (Segmento 2).
3. **PresentaciÃ³n del Alcance, Objetivos y Reglas (*Briefing and Presenting the Plan*):** El facilitador presentÃ³ el propÃ³sito central del modelado: la preservaciÃ³n inviolable de la cadena de frÃ­o (+2 Â°C a +8 Â°C bajo normativa DIGEMID R.M. NÂ° 833-2015) y la trazabilidad digital de Ã³rganos y hemoderivados frente a la congestiÃ³n vehicular de Lima Metropolitana, estableciendo las reglas de interacciÃ³n y respeto por el tiempo cronolÃ³gico.
4. **GeneraciÃ³n CaÃ³tica de Eventos de Dominio (*Generating Domain Events*):** Fase divergente de modelado silencioso e individual. Cada participante escribiÃ³ y pegÃ³ de forma libre y masiva en notas adhesivas naranjas (`#FFA500`) todos los eventos relevantes del negocio expresados en tiempo verbal pasado (*Domain Events*), reflejando hitos significativos como `Pre-enfriamiento Peltier estabilizado`, `ExcursiÃ³n tÃ©rmica incipiente detectada` o `Muestra aceptada formalmente como viable`.
5. **Ordenamiento CronolÃ³gico y DetecciÃ³n de Flujos Concurrentes (*Sorting Domain Events*):** Fase convergente de debate intenso. Los participantes organizaron cooperativamente las notas de izquierda a derecha en una lÃ­nea temporal estricta de extremo a extremo, alineando verticalmente los procesos que ocurren en paralelo (por ejemplo, el control tÃ©rmico autÃ³nomo Peltier ejecutÃ¡ndose concurrentemente mientras el vehÃ­culo avanza en el trÃ¡fico).
6. **IdentificaciÃ³n de Actores y Sistemas Externos (*Adding Actors and External Systems*):** Se incorporaron los roles humanos responsables de gatillar o atender eventos mediante notas amarillas pequeÃ±as (Conductor de Ambulancia, ParamÃ©dico TEM, Coordinador de Despacho, Cirujano Receptor), asÃ­ como los sistemas externos interactuantes en notas azules (Firmware AutÃ³nomo ESP32 como nodo IoT Edge emisor, API de TrÃ¡fico TomTom, Pasarela SMS Twilio, Registro RENIPRESS / SUSALUD y Sistema HIS / QuirÃ³fano Hospitalario receptor).
7. **NarraciÃ³n CronolÃ³gica Hacia Adelante (*Storytelling*):** Un facilitador y representantes de ambos segmentos narraron oralmente la historia completa del flujo de negocio de izquierda a derecha. Esta lectura validÃ³ la consistencia global del proceso, esclareciÃ³ supuestos implÃ­citos y permitiÃ³ identificar fricciones operativas y riesgos reales, seÃ±alizados de inmediato con notas magenta/rosa (*Hotspots*).
8. **NarraciÃ³n Inversa y DetecciÃ³n de Brechas (*Reverse Storytelling*):** Se ejecutÃ³ una lectura en sentido inverso, comenzando desde el evento final (`Muestra aceptada formalmente como viable` / `Acta final de entrega firmada digitalmente`) y preguntando repetidamente: *Â¿QuÃ© condiciÃ³n previa tuvo que cumplirse para que ocurriera este hecho?* Este anÃ¡lisis retrospectivo descubriÃ³ eventos faltantes de bioseguridad, validaciones de pre-enfriamiento y protocolos de contingencia ante caÃ­das de la toma vehicular de 12V.
9. **Cierre, Consenso y SÃ­ntesis de Oportunidades (*Closing and Synthesis*):** Se consolidÃ³ el entendimiento compartido del dominio, se extrajo el vocabulario fundamental para la construcciÃ³n del Lenguaje Ubicuo (SecciÃ³n 2.5) y se priorizaron en notas verdes las oportunidades de soluciÃ³n de software e IoT (tara automÃ¡tica con celda de carga HX711, algoritmo predictivo de desvÃ­os de ETA y acta digital inmutable con firma QR).

---

![Figura 2.4 - Big Picture EventStorming: Fases de Origen, TrÃ¡nsito y Destino](../assets/chapter-2/smart-medical-container-eventstorming.jpg)  
*Nota: ElaboraciÃ³n propia en Miro segÃºn la tÃ©cnica de modelado colaborativo de Alberto Brandolini para el transporte asistencial de muestras mÃ©dicas y Ã³rganos en Lima Metropolitana.*

---

### **2.4.1. AnÃ¡lisis del Dominio y Hallazgos de la SesiÃ³n**

La sesiÃ³n de Big Picture EventStorming permitiÃ³ al equipo comprender la dinÃ¡mica real del transporte mÃ©dico en Lima Metropolitana y articular las necesidades clÃ­nicas con la arquitectura del sistema:

#### 1. ExploraciÃ³n Desestructurada, LÃ­nea de Tiempo y Eventos Pivote (Pivotal Events)
El mapeo de eventos evidenciÃ³ que el transporte asistencial es un proceso altamente concurrente y sensible al tiempo. Mientras el vehÃ­culo se desplaza por arterias viales congestionadas de Lima Metropolitana, el hardware del contenedor inteligente ejecuta en paralelo un lazo cerrado autÃ³nomo de control tÃ©rmico (manteniendo la carga entre +2.0 Â°C y +8.0 Â°C mediante celdas Peltier), registrando la estabilidad del peso y verificando el precinto de seguridad electromecÃ¡nico.

Siguiendo el enfoque canÃ³nico de modelado colaborativo concebido por Alberto Brandolini, la lÃ­nea de tiempo temporal se estructura a partir de tres **Eventos Pivote (*Pivotal Events*)** que demarcan formalmente los momentos crÃ­ticos de quiebre y transiciÃ³n de responsabilidad entre las tres macrofases del sistema:
* **Pivotal Event 1 (Origen â†’ TrÃ¡nsito):** `Acta digital de salida generada y firmada digitalmente` junto con la `ConexiÃ³n del contenedor a la toma 12V DC`. Marca la transferencia legal de custodia desde el hospital donante o farmacia central hacia el equipo asistencial mÃ³vil, activando el rÃ©gimen de supervisiÃ³n telemÃ¡tica en ruta.
* **Pivotal Event 2 (TrÃ¡nsito â†’ Destino):** `Geocerca de pre-arribo hospitalaria activada`. Disparo telemÃ¡tico automatizado al ingresar al radio de 2 km / 10 minutos del hospital receptor, habilitando la alerta temprana a la rampa de trauma shock y la preparaciÃ³n del equipo mÃ©dico o farmacÃ©utico receptor.
* **Pivotal Event 3 (Destino â†’ Cierre ClÃ­nico):** `Muestra aceptada formalmente como viable`, `Acta final de entrega firmada digitalmente` y `Expediente PDF auditado exportado a DIGEMID`. Cierre definitivo de la cadena de custodia con generaciÃ³n del expediente digital sellado mediante hash criptogrÃ¡fico SHA-256 para auditorÃ­a sanitaria de DIGEMID.

#### 2. Matriz de Puntos CrÃ­ticos (Hotspots) y Oportunidades de SoluciÃ³n

La pizarra colaborativa desarrollada en Miro articula el flujo de izquierda a derecha en tres macrofases espaciales (**1. Origen y Despacho**, **2. TrÃ¡nsito y Monitoreo Asistencial**, **3. Destino, Custodia y Cierre ClÃ­nico**), integrando analÃ­ticamente sus seis (6) etapas operativas para brindar una granularidad tÃ©cnica precisa.

La siguiente matriz sintetiza los problemas operativos reales identificados en la red hospitalaria de Lima y las soluciones de ingenierÃ­a de software e IoT implementadas:

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Fase Operativa</th>
      <th>Punto CrÃ­tico / Hotspot (Problema Real en Lima)</th>
      <th>Severidad</th>
      <th>Oportunidad de SoluciÃ³n (Software / IoT)</th>
      <th>Subdominio DDD</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Despacho</strong></td>
      <td>AsignaciÃ³n de ambulancias sin visibilidad del estado de su toma de 12V ni del pre-enfriamiento del contenedor.</td>
      <td>Alta</td>
      <td><strong>Tablero IoT de Estado de Flota:</strong> SupervisiÃ³n en tiempo real de baterÃ­a, conexiÃ³n elÃ©ctrica y temperatura previa.</td>
      <td><em>Medical Transport Planning & Dispatching</em></td>
    </tr>
    <tr>
      <td><strong>Carga y Custodia</strong></td>
      <td>Riesgo de sustituciÃ³n de muestras o carga de paquetes no verificados en la rampa hospitalaria.</td>
      <td>CrÃ­tica</td>
      <td><strong>Tara AutomÃ¡tica con Celda HX711:</strong> Registro de masa inicial (&plusmn;5 g) y bloqueo automÃ¡tico del solenoide.</td>
      <td><em>Smart Container & Telemetry Monitoring</em></td>
    </tr>
    <tr>
      <td><strong>Carga y Custodia</strong></td>
      <td>Actas en papel autocopiativo mojadas, extraviadas o ilegibles sin respaldo probatorio.</td>
      <td>Media</td>
      <td><strong>Acta Digital con Firma QR:</strong> Comprobante electrÃ³nico inalterable consultable en plataforma web.</td>
      <td><em>Chain of Custody & Traceability</em></td>
    </tr>
    <tr>
      <td><strong>TrÃ¡nsito</strong></td>
      <td><strong>CongestiÃ³n severa en Lima (TomTom: 34 min/10 km):</strong> Retrasos crÃ­ticos en Av. Javier Prado o VÃ­a Expresa.</td>
      <td>CrÃ­tica</td>
      <td><strong>Motor de ETA DinÃ¡mico:</strong> RecÃ¡lculo de tiempos con TomTom Traffic API cada 60s y alertas de demora.</td>
      <td><em>Medical Transport Planning & Dispatching</em></td>
    </tr>
    <tr>
      <td><strong>TrÃ¡nsito</strong></td>
      <td><strong>Golpe de calor en cabina (hasta 38.5 &deg;C):</strong> Rompe la cadena de frÃ­o en cajas convencionales en &lt;45 min.</td>
      <td>CatastrÃ³fica</td>
      <td><strong>RefrigeraciÃ³n Activa Peltier + Alarma Dual:</strong> Control PID (2&ndash;8 &deg;C), alarma sonora local y push a mÃ©dicos.</td>
      <td><em>Critical Alerting & Incident Response</em></td>
    </tr>
    <tr>
      <td><strong>TrÃ¡nsito</strong></td>
      <td><strong>DesconexiÃ³n accidental de 12V:</strong> El enchufe del encendedor se zafa con baches o frenadas.</td>
      <td>Alta</td>
      <td><strong>ConmutaciÃ³n AutomÃ¡tica a BaterÃ­a LiFePO4:</strong> Pack interno LiFePO4 (4h de autonomÃ­a) con aviso en cabina.</td>
      <td><em>Smart Container & Telemetry Monitoring</em></td>
    </tr>
    <tr>
      <td><strong>TrÃ¡nsito</strong></td>
      <td><strong>PÃ©rdida de seÃ±al 4G en tÃºneles (LÃ­nea Amarilla / zanjas):</strong> Provoca vacÃ­os de datos durante el traslado.</td>
      <td>Alta</td>
      <td><strong>BÃºfer Flash Offline en ESP32:</strong> Almacenamiento local de 5,000 muestras y sincronizaciÃ³n al reconectar.</td>
      <td><em>Smart Container & Telemetry Monitoring</em></td>
    </tr>
    <tr>
      <td><strong>Arribo</strong></td>
      <td>QuirÃ³fano o personal de guardia no preparado al llegar la ambulancia por falta de preaviso.</td>
      <td>Alta</td>
      <td><strong>Geocerca de Pre-Arribo (&le; 2 km / 10 min):</strong> NotificaciÃ³n automÃ¡tica al hospital receptor para alistar recepciÃ³n.</td>
      <td><em>Medical Transport Planning & Dispatching</em></td>
    </tr>
    <tr>
      <td><strong>Entrega</strong></td>
      <td>Apertura indebida en pasillos o entrega a personal no facultado sin validaciÃ³n de identidad.</td>
      <td>CrÃ­tica</td>
      <td><strong>Doble Factor de Desbloqueo:</strong> UbicaciÃ³n obligatoria en geocerca hospitalaria + cÃ³digo OTP temporal.</td>
      <td><em>Chain of Custody & Traceability</em></td>
    </tr>
    <tr>
      <td><strong>Cierre</strong></td>
      <td>Rechazo de lotes o litigios por falta de auditorÃ­a continua exigida por DIGEMID (R.M. 833-2015).</td>
      <td>Media</td>
      <td><strong>Expediente Digital con Hash SHA-256:</strong> Reporte PDF descargable con telemetrÃ­a completa y firmas.</td>
      <td><em>Chain of Custody & Traceability</em></td>
    </tr>
  </tbody>
</table>

---

#### 3. ValidaciÃ³n por Storytelling y Reverse Storytelling
La validaciÃ³n del recorrido de extremo a extremo confirmÃ³ la coherencia del ciclo asistencial entre ambos segmentos. Mediante la narrativa directa se verificÃ³ la transiciÃ³n sin fricciones de custodia entre el mÃ©dico emisor, el paramÃ©dico y el cirujano receptor. Complementariamente, el anÃ¡lisis retrospectivo desde el hito `Muestra aceptada formalmente como viable` (`Acta final de entrega firmada digitalmente`) comprobÃ³ que ninguna entrega puede consumarse sin la confluencia de tres condiciones inviolables: desbloqueo por OTP dentro de la geocerca hospitalaria, preservaciÃ³n tÃ©rmica continua (2 Â°C a 8 Â°C) garantizada por el respaldo LiFePO4, y descarga Ã­ntegra de la telemetrÃ­a resguardada en el bÃºfer flash local tras cruzar tÃºneles.

#### 4. DelimitaciÃ³n Preliminar de Contextos Acotados (Bounded Contexts)
La sesiÃ³n exploratoria preliminar del Big Picture permitiÃ³ delimitar cinco (5) macro-contextos de negocio, los cuales, durante la fase de descomposiciÃ³n tÃ¡ctica de Design-Level EventStorming (CapÃ­tulo 4.6.1), evolucionan naturalmente hacia seis (6) Bounded Contexts al independizar la gestiÃ³n de suscripciones comerciales y aprovisionamiento de flota (*Subscription & Fleet Provisioning*) del nÃºcleo de autenticaciÃ³n y organizaciones (*IAM*):
1. **Medical Transport Planning & Dispatching:** GestiÃ³n de solicitudes de traslado, asignaciÃ³n de unidades mÃ³viles/tripulaciÃ³n y cÃ¡lculo dinÃ¡mico de rutas anti-trÃ¡fico.
2. **Smart Container & Telemetry Monitoring:** IngestiÃ³n de telemetrÃ­a continua (temperatura, peso neto HX711, baterÃ­a Li-Ion) y control electromecÃ¡nico de tapa.
3. **Critical Alerting & Incident Response:** DetecciÃ³n en tiempo real de excursiones tÃ©rmicas, disparador de alarmas acÃºsticas en cabina y notificaciÃ³n de contingencias.
4. **Chain of Custody & Traceability:** VerificaciÃ³n de token OTP en geocerca, registro de actas de custodia y sellado inmutable con hash SHA-256 para DIGEMID (R.M. 833-2015).
5. **Identity, Access & Subscriptions (IAM):** GestiÃ³n de instituciones hospitalarias, planes SaaS B2B, autenticaciÃ³n JWT basada en roles y trazabilidad de licencias mÃ©dicas.

