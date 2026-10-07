# **4.6. Domain-Driven Software Architecture**

En este capítulo se formula la propuesta integral de arquitectura de software para la plataforma **Medical SMARTBOX**, articulando los hallazgos del modelado exploratorio preliminar con los patrones tácticos y estratégicos de **Domain-Driven Design (DDD)** concebidos por Eric Evans y Alberto Brandolini. A partir de los flujos identificados en el Big Picture EventStorming (Capítulo 2.4), se profundiza en la descomposición del dominio en Bounded Contexts, Agregados, Eventos de Dominio y Comandos, estableciendo fronteras de consistencia transaccional de alta cohesión y bajo acoplamiento.

Para representar la arquitectura de forma rigurosa, comprensible y estandarizada entre perfiles clínicos, operadores logísticos y equipos de desarrollo, se adopta el **C4 Model** propuesto por Simon Brown (2018). La arquitectura se organiza y documenta progresivamente a través de las siguientes secciones:
* **4.6.1. Design-Level EventStorming:** Descomposición táctica del dominio, identificación de invariantes y delimitación formal de Bounded Contexts.
* **4.6.2. Software Architecture Context Diagram:** Delimitación perimetral del sistema frente a los actores asistenciales y sistemas externos.
* **4.6.3. Software Architecture Container Diagrams:** Descomposición en unidades ejecutables independientes y tecnologías del stack oficial conforme a la topología canónica web.
* **4.6.4. Software Architecture Components Diagrams:** Descomposición modular interna del Backend RESTful Web API por Bounded Contexts y acceso a datos.

***

## **4.6.1. Design-Level EventStorming**

### **1. Introducción y Ficha Técnica del Taller Colaborativo**

A partir de la exploración macro realizada en el **Big Picture EventStorming (Capítulo 2.4)**, se ejecutó una sesión formal de **Design-Level EventStorming (DLES)** bajo los principios canónicos de Domain-Driven Design y las pautas tácticas de Nick Tune.

El objetivo primordial del Design-Level EventStorming es **cerrar la brecha entre la visión general del negocio y el diseño detallado de software**, descomponiendo los procesos asistenciales en sus componentes transaccionales: Comandos, Agregados con invariantes protegidas, Eventos de Dominio inmutables, Políticas reactivas (*Whenever-Then*) y puntos de integración ciberfísica IoT.

#### Ficha Técnica de la Sesión Colaborativa
* **Modalidad y Alcance:** Sesión estructurada de modelado colaborativo orientada a la descomposición táctica del dominio asistencial y logístico.
* **Entorno y Herramienta:** Pizarra digital en **Miro**, organizada por carriles transaccionales de Bounded Contexts.
* **Participantes y Roles:**
  * *Facilitador DDD y Arquitecto de Software:* Moderación del flujo temporal y preservación de fronteras transaccionales.
  * *Especialista en Hardware IoT y Firmware:* Definición de interacción con microcontrolador ESP32, sensores térmicos Peltier y celda HX711.
  * *Coordinador de Logística Asistencial (Segmento 1):* Modelado de rutas críticas, contingencias en el tráfico de Lima y alimentación de 12V.
  * *Director Farmacéutico y Auditor Sanitario (Segmento 2):* Definición de límites de isquemia fría, actas inmutables y normativas DIGEMID (R.M. N° 833-2015).

#### Convención Cromática Oficial de Post-its (Notación DDD Estándar)

| Tipo de Artefacto DDD | Color de Post-it | Notación y Sintaxis | Descripción y Propósito en el Dominio |
|---|---|---|---|
| **Domain Event** | Naranja (`#FFA500`) | Verbo en pasado participio (Inglés) | Hecho irreversible en el sistema (`ContainerLocked`, `ExcursionDetected`). |
| **Command** | Azul (`#2196F3`) | Verbo en imperativo / presente | Acción disparada por un actor o sistema (`LockContainer`, `DispatchTrip`). |
| **Aggregate Root** | Amarillo Ocre (`#FFF59D`) | Sustantivo en singular | Frontera de consistencia transaccional (`SmartContainer`, `TransportOrder`). |
| **Business Policy / Rule** | Lila / Morado (`#BA68C8`) | *"Whenever [Event] THEN [Command]"* | Regla reactiva o de orquestación de negocio. |
| **Read Model / UI View** | Verde Claro (`#81C784`) | Nombre de la proyección / vista | Información requerida en pantalla para que el actor decida (`ActiveTransportsView`). |
| **Actor / User Role** | Amarillo Pálido (`#FFF9C4`) | Rol formal del usuario | Representa a los actores de los 2 segmentos objetivo (`Driver`, `Pharmacist`). |
| **External System / IoT** | Rosa / Fucsia (`#F48FB1`) | Nombre del sistema / hardware | Entidad ajena a la plataforma (`ESP32 Hardware`, `TomTom API`, `Twilio SMS`). |
| **Hotspot / Risk / Exception** | Rojo / Magenta (`#E53935`) | Problema o riesgo crítico | Fricción operativa en ruta (`12V Socket Disconnect`, `Severe Traffic Delay`). |

***

### **2. Matriz Estratégica de Clasificación de Bounded Contexts**

Bajo los principios de Domain-Driven Design para arquitecturas SaaS en entornos asistenciales y logísticos, el dominio de **Medical SMARTBOX** se estructura en **cinco (5) Bounded Contexts**, balanceando subdominios estratégicos (*Core Domains*) y de soporte (*Supporting Subdomains*):

<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 7.2pt; border: 1px solid #cbd5e1; margin: 12px 0;">
<colgroup>
  <col style="width: 20%;" />
  <col style="width: 16%;" />
  <col style="width: 28%;" />
  <col style="width: 20%;" />
  <col style="width: 16%;" />
</colgroup>
<thead>
    <tr>
      <th>Bounded Context</th>
      <th>Clasificación Estratégica</th>
      <th>Responsabilidad Primaria en el Sistema</th>
      <th>Agregados Principales (Aggregate Roots)</th>
      <th>Segmento Atendido</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>1. Identity, Access &amp; Subscriptions (IAM)</strong></td>
      <td><em>Supporting Subdomain</em></td>
      <td>Autenticación multifactor (2FA), gestión de sesiones JWT, roles asistenciales (RBAC), registro institucional (RENIPRESS) y planes de suscripción B2B con cuotas de cajas (5L vs. 20L).</td>
      <td><code>HospitalInstitution</code>, <code>UserAccount</code>, <code>SubscriptionPlan</code></td>
      <td>Segmento 1 y Segmento 2 (Membresías B2B)</td>
    </tr>
    <tr>
      <td><strong>2. Smart Container &amp; Telemetry Monitoring</strong></td>
      <td><em>Core Domain (Diferenciador)</em></td>
      <td>Ingesta continua de telemetría IoT desde el ESP32: temperatura Peltier (+2°C a +8°C), tara/peso neto HX711, bloqueo solenoide, acelerómetro y alimentación vehicular 12V.</td>
      <td><code>SmartContainer</code>, <code>TelemetrySnapshot</code></td>
      <td>Segmento 1 (Energía) y Segmento 2 (Cadena de frío)</td>
    </tr>
    <tr>
      <td><strong>3. Medical Transport Planning &amp; Dispatching</strong></td>
      <td><em>Core Domain</em></td>
      <td>Programación de traslados de emergencia, control de límites de isquemia fría, selección de rutas anti-congestión en Lima y cálculo dinámico de tiempos de llegada (ETA).</td>
      <td><code>TransportOrder</code>, <code>DispatchTrip</code></td>
      <td>Segmento 1 (Conducción) y Segmento 2 (Quirófano)</td>
    </tr>
    <tr>
      <td><strong>4. Critical Alerting &amp; Incident Response</strong></td>
      <td><em>Core Domain</em></td>
      <td>Evaluación de umbrales clínicos en tiempo real, disparo omnicanal de alertas (Push/SMS), acuse de recibo acústico en cabina y mitigación de contingencias.</td>
      <td><code>AlertRule</code>, <code>CriticalIncident</code></td>
      <td>Segmento 1 (Cabina) y Segmento 2 (Supervisión)</td>
    </tr>
    <tr>
      <td><strong>5. Chain of Custody &amp; Traceability</strong></td>
      <td><em>Core Domain / Regulatorio</em></td>
      <td>Trazabilidad inmutable legal y sanitaria (DIGEMID R.M. 833-2015): despacho asistencial, apertura en destino mediante token OTP y generación del acta digital certificada con hash SHA-256.</td>
      <td><code>CustodyTransfer</code>, <code>DigitalAuditManifest</code></td>
      <td>Segmento 2 (Farmacia, Quirófano y DIGDOT)</td>
    </tr>
  </tbody>
</table>

#### Mapeo a la Taxonomía SaaS del Dominio

Para corroborar la cobertura integral del modelo respecto a los requisitos de plataformas SaaS para salud y movilidad, la siguiente matriz correlaciona los subdominios estándar con la partición arquitectónica adoptada:

<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 7.2pt; border: 1px solid #cbd5e1; margin: 12px 0;">
<colgroup>
  <col style="width: 25%;" />
  <col style="width: 25%;" />
  <col style="width: 18%;" />
  <col style="width: 32%;" />
</colgroup>
<thead>
    <tr>
      <th>Subdominio SaaS Estándar</th>
      <th>Bounded Context Asignado</th>
      <th>Tipo DDD</th>
      <th>Justificación de Cobertura Operativa</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>1. Autenticación y Autorización (IAM)</strong></td>
      <td>Identity, Access &amp; Subscriptions (IAM)</td>
      <td><em>Supporting</em></td>
      <td>Gobierna credenciales seguras JWT, control de acceso basado en roles (RBAC) y código RENIPRESS.</td>
    </tr>
    <tr>
      <td><strong>2. Facturación y Suscripciones B2B</strong></td>
      <td>Identity, Access &amp; Subscriptions (IAM)</td>
      <td><em>Supporting</em></td>
      <td>Gestiona planes institucionales mensuales y cuotas de aprovisionamiento de cajas (5L y 20L).</td>
    </tr>
    <tr>
      <td><strong>3. Planificación y Despacho Operativo</strong></td>
      <td>Medical Transport Planning &amp; Dispatching</td>
      <td><em>Core</em></td>
      <td>Asigna móviles sanitarios, calcula límites de isquemia y optimiza rutas ante el tráfico de Lima.</td>
    </tr>
    <tr>
      <td><strong>4. Monitoreo e Ingesta Telemática IoT</strong></td>
      <td>Smart Container &amp; Telemetry Monitoring</td>
      <td><em>Core</em></td>
      <td>Procesa flujos periódicos de temperatura, tara/peso y batería, y comanda el cerrojo solenoide.</td>
    </tr>
    <tr>
      <td><strong>5. Gestión de Contingencias y Alertas</strong></td>
      <td>Critical Alerting &amp; Incident Response</td>
      <td><em>Core</em></td>
      <td>Evalúa desviaciones térmicas en tiempo real y despacha alertas omnicanal de alta prioridad.</td>
    </tr>
    <tr>
      <td><strong>6. Auditoría, Custodia y Cumplimiento</strong></td>
      <td>Chain of Custody &amp; Traceability</td>
      <td><em>Core</em></td>
      <td>Garantiza inviolabilidad de entrega con token OTP y emite el acta digital inmutable (DIGEMID).</td>
    </tr>
  </tbody>
</table>

***

### **3. Diagrama Panorámico de Integración de Bounded Contexts**

El siguiente esquema general ilustra cómo interactúan los cinco contextos mediante el intercambio de eventos de dominio y comandos de orquestación, asegurando alto desacoplamiento y fronteras transaccionales autónomas:

![Figura 4.6.1.1 - Mapa de Integración entre Bounded Contexts (DLES)](../assets/chapter-4/4.6.1-dles-macro-context-map.jpg)  
*Nota: Elaboración propia en Miro según la técnica de modelado colaborativo Design-Level EventStorming para Medical SMARTBOX.*

***

### **4. Desglose Detallado por Bounded Contexts**

#### **4.6.1.1. Bounded Context 1: Identity, Access & Subscriptions (IAM)**
* **Clasificación:** *Supporting Subdomain*  
* **Alineación con Segmentos:** Centraliza la gobernanza de identidades, suscripciones SaaS y control de cuotas de flota para el **Segmento 1** (conductores de ambulancia, paramédicos y despachadores logísticos) y el **Segmento 2** (químicos farmacéuticos, médicos directores de IPRESS y auditores de calidad hospitalaria).

![Figura 4.6.1.2 - Design-Level EventStorming: Bounded Context Identity, Access & Subscriptions (IAM)](../assets/chapter-4/4.6.1-dles-iam-context.jpg)  
*Nota: Elaboración propia en Miro según la técnica Design-Level EventStorming para el Bounded Context de Identity, Access & Subscriptions (IAM).*

***

#### **4.6.1.2. Bounded Context 2: Medical Transport Planning & Dispatching**
* **Clasificación:** *Core Domain*  
* **Alineación con Segmentos:** Articula la necesidad médica del **Segmento 2** (solicitud urgente de insumo con rango térmico de +2.0 °C a +8.0 °C y tiempo de isquemia fría crítico) con la respuesta operativa del **Segmento 1** (asignación de ambulancia, cálculo de ruta anti-tráfico en Lima con TomTom y estimación dinámica de ETA).

![Figura 4.6.1.3 - Design-Level EventStorming: Bounded Context Medical Transport Planning & Dispatching](../assets/chapter-4/4.6.1-dles-transport-planning.jpg)  
*Nota: Elaboración propia en Miro según la técnica Design-Level EventStorming para el Bounded Context de Medical Transport Planning & Dispatching.*

***

#### **4.6.1.3. Bounded Context 3: Smart Container & Telemetry Monitoring**
* **Clasificación:** *Core Domain (Diferenciador Tecnológico)*  
* **Alineación con Segmentos:** Representa el corazón IoT del sistema. Para el **Segmento 1**, monitorea la integridad eléctrica en la toma de 12V y el nivel de batería interna. Para el **Segmento 2**, certifica la curva ininterrumpida de frío (+2.0 °C a +8.0 °C) y la estabilidad del peso neto del insumo mediante celda de carga HX711 (±5 g).

![Figura 4.6.1.4 - Design-Level EventStorming: Bounded Context Smart Container & Telemetry Monitoring](../assets/chapter-4/4.6.1-dles-smart-container.jpg)  
*Nota: Elaboración propia en Miro según la técnica Design-Level EventStorming para el Bounded Context de Smart Container & Telemetry Monitoring.*

***

#### **4.6.1.4. Bounded Context 4: Critical Alerting & Incident Response**
* **Clasificación:** *Core Domain*  
* **Alineación con Segmentos:** Garantiza que las incidencias en ruta se detecten y resuelvan en segundos. Para el **Segmento 1**, dispara alarmas audibles y visuales de alta prioridad en la cabina asistencial. Para el **Segmento 2**, alerta inmediatamente a farmacia y quirófano ante riesgos térmicos o demoras viales.

![Figura 4.6.1.5 - Design-Level EventStorming: Bounded Context Critical Alerting & Incident Response](../assets/chapter-4/4.6.1-dles-critical-alerting.jpg)  
*Nota: Elaboración propia en Miro según la técnica Design-Level EventStorming para el Bounded Context de Critical Alerting & Incident Response.*

***

#### **4.6.1.5. Bounded Context 5: Chain of Custody & Traceability**
* **Clasificación:** *Core Domain / Cumplimiento Normativo*  
* **Alineación con Segmentos:** Brinda la certeza sanitaria y legal que exige el **Segmento 2** ante auditorías de DIGEMID (R.M. N° 833-2015/MINSA) y DIGDOT (Directiva 152/MINSA). Controla la apertura en destino mediante código OTP de un solo uso y emite el acta digital inmutable con hash SHA-256.

![Figura 4.6.1.6 - Design-Level EventStorming: Bounded Context Chain of Custody & Traceability](../assets/chapter-4/4.6.1-dles-chain-of-custody.jpg)  
*Nota: Elaboración propia en Miro según la técnica Design-Level EventStorming para el Bounded Context de Chain of Custody & Traceability.*

***

## **4.6.2. Software Architecture Context Diagram**

### **1. Introducción y Fundamentos del Nivel 1 C4 Model**

Para representar la arquitectura del sistema se adoptó el **C4 Model** concebido por Simon Brown. En este nivel de abstracción inicial, el **System Context Diagram** establece las fronteras perimetrales de la plataforma mostrándola como una **caja negra central única** sin descender a detalles de frameworks o bases de datos.

### **2. Definición del Sistema Central (Subject System)**

* **Nombre Oficial:** `Medical SMARTBOX Platform` `[Software System]`
* **Descripción de Dominio:** Plataforma integral B2B SaaS de software y telemetría IoT para la monitorización activa de la cadena de frío (+2.0 °C a +8.0 °C), pesaje de alta precisión (±5 g), custodia electromecánica inmutable y trazabilidad de traslados asistenciales en ambulancias para Lima Metropolitana y el Callao.
* **Misión Operativa:** Garantizar el "Desperdicio Cero" de órganos, hemoderivados y vacunas durante el trayecto vial, asegurando el cumplimiento de la **R.M. N° 833-2015/MINSA** (Manual de BPDT - DIGEMID) y la **Directiva Sanitaria N° 152/MINSA** (DIGDOT).

***

### **3. Catálogo de Actores y Sistemas Externos**

Los actores y servicios conectados se consolidan formalmente en las siguientes tablas:

#### Actores del Dominio (Segmentos Objetivo)

<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 7.2pt; border: 1px solid #cbd5e1; margin: 12px 0;">
<colgroup>
  <col style="width: 25%;" />
  <col style="width: 20%;" />
  <col style="width: 30%;" />
  <col style="width: 25%;" />
</colgroup>
<thead>
    <tr>
      <th>Actor / Rol</th>
      <th>Segmento Objetivo</th>
      <th>Responsabilidad en el Dominio</th>
      <th>Canal / Interfaz</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Personal de Transporte Asistencial</strong><br><em>(Chofer / Paramédico / Despachador)</em></td>
      <td><strong>Segmento 1:</strong><br>Operadores de Transporte Sanitario</td>
      <td>Conduce la ambulancia, supervisa la conexión de alimentación de 12V vehicular, asigna unidades móviles y atiende alertas acústicas en cabina.</td>
      <td>Web App (PWA Mobile en tablet / Smartphone y Dashboard Desktop)</td>
    </tr>
    <tr>
      <td><strong>Personal Clínico y Farmacéutico</strong><br><em>(Químico Farmacéutico / Médico)</em></td>
      <td><strong>Segmento 2:</strong><br>Centros de Salud y Hospitales</td>
      <td>Acondiciona la carga biológica, tara insumos, autoriza el precinto, monitorea el ETA dinámico y valida la entrega en destino mediante código OTP.</td>
      <td>Web App (Portal Web Hospitalario y Tablet de Quirófano)</td>
    </tr>
    <tr>
      <td><strong>Auditor de Calidad y Regulador</strong><br><em>(Auditor Hospitalario / Inspector DIGEMID)</em></td>
      <td><strong>Segmento 2:</strong><br>Centros de Salud y Reguladores</td>
      <td>Fiscaliza la preservación legal de la cadena de frío y descarga actas digitales certificadas en PDF con hash SHA-256.</td>
      <td>Web App (Portal de Auditoría y Cumplimiento)</td>
    </tr>
  </tbody>
</table>

#### Sistemas Externos e Interfaces Periféricas

<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 7.2pt; border: 1px solid #cbd5e1; margin: 12px 0;">
<colgroup>
  <col style="width: 28%;" />
  <col style="width: 18%;" />
  <col style="width: 34%;" />
  <col style="width: 20%;" />
</colgroup>
<thead>
    <tr>
      <th>Sistema Externo</th>
      <th>Tipo de Entidad</th>
      <th>Propósito y Función Operativa</th>
      <th>Protocolo de Red</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Smart Container IoT Hardware</strong></td>
      <td>Hardware Embebido</td>
      <td>Microcontrolador ESP32 con sensores térmicos DS18B20, celda de pesaje HX711 y cerrojo solenoide de seguridad.</td>
      <td><code>HTTPS / JSON</code></td>
    </tr>
    <tr>
      <td><strong>Traffic &amp; Maps Gateway</strong></td>
      <td>Cloud Service API</td>
      <td>TomTom Traffic API / Mapbox. Provee cálculo dinámico de congestión vehicular y recálculo de ETA en Lima.</td>
      <td><code>HTTPS / REST</code></td>
    </tr>
    <tr>
      <td><strong>Notification Gateway</strong></td>
      <td>Cloud Messaging</td>
      <td>Twilio SMS y Firebase Cloud Messaging (FCM). Despacha alertas críticas inmediatas ante riesgo térmico (&lt;10s).</td>
      <td><code>HTTPS / REST</code></td>
    </tr>
    <tr>
      <td><strong>Cloud Document Storage</strong></td>
      <td>Object Storage</td>
      <td>Amazon Web Services S3. Custodia inmutable de actas digitales de entrega certificadas con sellado SHA-256.</td>
      <td><code>HTTPS / S3 API</code></td>
    </tr>
    <tr>
      <td><strong>B2B Payment Gateway</strong></td>
      <td>Pasarela de Pagos</td>
      <td>Culqi / Stripe API. Gestiona transacciones de cobro recurrente para suscripciones institucionales SaaS B2B.</td>
      <td><code>HTTPS / REST (TLS 1.3)</code></td>
    </tr>
  </tbody>
</table>

***

### **4. Diagrama de Contexto del Sistema (C4 Nivel 1)**

El diagrama de contexto sitúa a la plataforma en el centro del ecosistema, delimitando sus relaciones perimétricas:

![Figura 4.6.2.1 - C4 Model: System Context Diagram (Nivel 1)](../assets/chapter-4/4.6.2-c4-context-diagram.png)  
*Nota: Elaboración propia en Structurizr conforme a los estándares del modelo C4 para la arquitectura de software.*

***

## **4.6.3. Software Architecture Container Diagrams**

### **1. Introducción y Topología Canónica Web (C4 Nivel 2)**

En el **C4 Model** de Simon Brown, un **Contenedor** representa una **unidad de software ejecutable o almacén de datos desplegable y operable de manera independiente**.

Conforme a las disposiciones rectoras de la cátedra y la rúbrica ABET, la arquitectura de la solución se estructura formalmente en torno a **cuatro (4) contenedores canónicos**:
1. **Landing Page:** Sitio web estático institucional orientado a la difusión y captación de clientes B2B.
2. **Single-Page Application (SPA):** Aplicación cliente rica e interactiva ejecutada en el navegador web del usuario.
3. **Backend RESTful Web API:** Servidor central de aplicaciones que implementa la lógica de negocio DDD y expone endpoints REST.
4. **Database:** Motor de base de datos relacional para la persistencia transaccional del sistema.

***

### **2. Catálogo de Contenedores de Software**

<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 7.2pt; border: 1px solid #cbd5e1; margin: 12px 0;">
<colgroup>
  <col style="width: 20%;" />
  <col style="width: 18%;" />
  <col style="width: 22%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
    <tr>
      <th>Contenedor C4</th>
      <th>Tipo de Unidad</th>
      <th>Tecnología Oficial</th>
      <th>Responsabilidades Operativas y de Negocio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>1. Landing Page</strong></td>
      <td><em>Web Application (Static)</em></td>
      <td>HTML5, CSS3, JavaScript nativo</td>
      <td>Portal público de captación B2B, difusión de la propuesta de valor de cadena de frío y catálogo de suscripciones por tamaño de caja (5L vs. 20L). Provee redirección directa al inicio de sesión.</td>
    </tr>
    <tr>
      <td><strong>2. Single-Page Application (SPA)</strong></td>
      <td><em>Client-Side Application</em></td>
      <td><strong>Vue.js 3</strong> + <strong>PrimeVue</strong> (Material Design)</td>
      <td>Interfaz interactiva para usuarios de ambos segmentos: vistas de cabina para paramédicos (alertas audibles), paneles de despacho para coordinadores y portal clínico para médicos/farmacéuticos (OTP).</td>
    </tr>
    <tr>
      <td><strong>3. Backend RESTful Web API</strong></td>
      <td><em>Web API Service</em></td>
      <td><strong>ASP.NET Core (.NET 10 LTS, C#)</strong></td>
      <td>Servidor central de servicios que orquesta los 5 Bounded Contexts, gestiona autenticación JWT con 2FA, procesa la ingesta de telemetría sensorial, evalúa umbrales y gobierna transacciones.</td>
    </tr>
    <tr>
      <td><strong>4. Database</strong></td>
      <td><em>Relational DBMS</em></td>
      <td><strong>MySQL 8.0 Server (InnoDB)</strong></td>
      <td>Almacén relacional transaccional (ACID) gobernado por migraciones de Entity Framework Core 10.0. Persiste usuarios, suscripciones, flota, viajes, telemetría y actas de custodia.</td>
    </tr>
  </tbody>
</table>

***

### **3. Matriz de Protocolos de Comunicación Inter-Contenedor**

<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 7pt; border: 1px solid #cbd5e1; margin: 12px 0;">
<colgroup>
  <col style="width: 20%;" />
  <col style="width: 20%;" />
  <col style="width: 18%;" />
  <col style="width: 12%;" />
  <col style="width: 30%;" />
</colgroup>
<thead>
    <tr>
      <th>Origen</th>
      <th>Destino</th>
      <th>Protocolo</th>
      <th>Puerto</th>
      <th>Propósito de la Interacción</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Navegador Web</td>
      <td>Landing Page</td>
      <td><code>HTTPS (TLS 1.3)</code></td>
      <td>TCP 443</td>
      <td>Descarga de contenido estático y presentación pública.</td>
    </tr>
    <tr>
      <td>Landing Page</td>
      <td>SPA (Web App)</td>
      <td><code>HTTPS (Redirect)</code></td>
      <td>TCP 443</td>
      <td>Redirección de llamadas a la acción (CTA) hacia la app.</td>
    </tr>
    <tr>
      <td>SPA (Web App)</td>
      <td>Backend Web API</td>
      <td><code>JSON / HTTPS</code></td>
      <td>TCP 443</td>
      <td>Invocación de endpoints RESTful autenticados con Bearer JWT.</td>
    </tr>
    <tr>
      <td>Backend Web API</td>
      <td>Database</td>
      <td><code>TCP / SQL</code></td>
      <td>TCP 3306</td>
      <td>Consultas y persistencia relacional transaccional vía EF Core.</td>
    </tr>
    <tr>
      <td>Hardware ESP32</td>
      <td>Backend Web API</td>
      <td><code>JSON / HTTPS</code></td>
      <td>TCP 443</td>
      <td>Ingesta periódica de paquetes sensoriales de telemetría.</td>
    </tr>
  </tbody>
</table>

***

### **4. Diagrama de Contenedores de la Solución (C4 Nivel 2)**

El siguiente diagrama descompone la solución en sus unidades de software operativas:

![Figura 4.6.3.1 - C4 Model: Container Diagram (Nivel 2)](../assets/chapter-4/4.6.3-c4-container-diagram.png)  
*Nota: Elaboración propia en Structurizr conforme a los estándares del modelo C4 para la arquitectura de software.*

***

## **4.6.4. Software Architecture Components Diagrams**

### **1. Introducción y Organización del Nivel 3 de C4**

Conforme a los fundamentos del C4 Model de Simon Brown, un **Componente** es una agrupación modular y cohesiva de código (controladores, servicios e interfaces) que reside dentro de un contenedor ejecutable. En esta sección se realiza el *zoom in* sobre el contenedor central de la solución: el **Backend RESTful Web API en ASP.NET Core (C#)**.

La Web API estructura su lógica interna organizando sus módulos en correspondencia directa con los **cinco (5) Bounded Contexts** delimitados en el Design-Level EventStorming, garantizando alta cohesión, bajo acoplamiento y separación de responsabilidades:
* Cada módulo agrupa sus controladores REST, servicios de aplicación y contratos de dominio.
* El componente de acceso a datos centraliza la persistencia relacional con Entity Framework Core hacia MySQL.

***

### **2. Catálogo Modular de Componentes de la Web API**

Los componentes internos de la API se mapean directamente con los **cinco Bounded Contexts** más el módulo de persistencia:

<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 7.2pt; border: 1px solid #cbd5e1; margin: 12px 0;">
<colgroup>
  <col style="width: 25%;" />
  <col style="width: 20%;" />
  <col style="width: 35%;" />
  <col style="width: 20%;" />
</colgroup>
<thead>
    <tr>
      <th>Componente C4</th>
      <th>Tecnología / Tipo</th>
      <th>Responsabilidades Técnicas y de Negocio</th>
      <th>Dependencias Inyectadas</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>IAM &amp; Subscriptions Module</strong></td>
      <td>ASP.NET Core Controller &amp; Service</td>
      <td>Gestiona autenticación JWT, registro institucional con RENIPRESS, roles (RBAC) y planes de suscripción B2B.</td>
      <td><code>IUserRepository</code>, <code>IPaymentGateway</code></td>
    </tr>
    <tr>
      <td><strong>Smart Container &amp; Telemetry Module</strong></td>
      <td>ASP.NET Core Controller &amp; Service</td>
      <td>Procesa paquetes sensoriales de temperatura (+2°C a +8°C), pesaje con celda HX711 y control de cerrojo solenoide.</td>
      <td><code>ISmartContainerRepository</code></td>
    </tr>
    <tr>
      <td><strong>Medical Transport Module</strong></td>
      <td>ASP.NET Core Controller &amp; Service</td>
      <td>Coordina órdenes de traslado asistencial, vinculación vehicular y cálculo de rutas dinámicas con ETA.</td>
      <td><code>ITransportRepository</code>, <code>ITrafficRoutingService</code></td>
    </tr>
    <tr>
      <td><strong>Critical Alerting Module</strong></td>
      <td>ASP.NET Core Controller &amp; Service</td>
      <td>Evalúa umbrales clínicos en tiempo real y despacha notificaciones reactivas push y SMS de emergencia.</td>
      <td><code>IIncidentRepository</code>, <code>INotificationGateway</code></td>
    </tr>
    <tr>
      <td><strong>Chain of Custody Module</strong></td>
      <td>ASP.NET Core Controller &amp; Service</td>
      <td>Valida token OTP de apertura y genera actas digitales de entrega inmutables selladas con hash SHA-256.</td>
      <td><code>ICustodyRepository</code>, <code>ICloudStorageService</code></td>
    </tr>
    <tr>
      <td><strong>Data Access &amp; Persistence (EF Core)</strong></td>
      <td>Entity Framework Core 10.0</td>
      <td>Encapsula <code>AppDbContext</code>, mapeos relacionales Fluent API y transacciones ACID hacia MySQL 8.0.</td>
      <td>MySQL Database (Port 3306)</td>
    </tr>
  </tbody>
</table>

***

### **3. Diagrama de Componentes de la RESTful Web API (C4 Nivel 3)**

El siguiente diagrama detalla la estructura modular interna del servidor de aplicaciones:

![Figura 4.6.4.1 - C4 Model: Component Diagram (Nivel 3 - Backend RESTful Web API)](../assets/chapter-4/4.6.4-c4-component-backend-api.png)  
*Nota: Elaboración propia en Structurizr conforme a los estándares del modelo C4 para la arquitectura de software.*
