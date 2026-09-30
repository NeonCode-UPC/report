# 5.2. Landing Page & Services Implementations

## 5.2.1. Sprint 1

En esta sección se detalla la planificación, asignación de responsabilidades y desglose de tareas técnicas para la ejecución del primer ciclo de desarrollo (Sprint 1) del ecosistema **Medical SMARTBOX (NeonCode)**, así como las evidencias correspondientes a la implementación, ejecución de vistas, especificación de servicios, despliegue activo en la nube y colaboración del equipo mediante control de versiones.

---

### 5.2.1.1. Sprint Planning 1

El **Sprint Planning 1** formaliza los aspectos principales de la reunión de planificación del primer ciclo de desarrollo (Sprint 1). Conforme a las consideraciones oficiales del hito AV1 (Semana 4), el foco prioritario consistió en diseñar, implementar y desplegar en la nube la primera versión oficial del **Landing Page institucional** responsive para capturar la demanda B2B de operadores logísticos y centros de salud, estableciendo simultáneamente los cimientos arquitectónicos del backend en ASP.NET Core 10.0 y la persistencia relacional en MySQL 8.0.

| Sprint # | Sprint 1 |
|---|---|
| **Sprint Planning Background** | **Sprint Planning Background** |
| Date | 2026-09-08 |
| Time | 19:00 - 21:30 |
| Location | Sesión virtual sincrónica vía Microsoft Teams / Discord |
| Prepared By | Jaramillo Peña, Jhon Alexander |
| Attendees (to planning meeting) | Jaramillo Peña, Jhon Alexander / Espinoza Rojas, Aaron / Gargate Lazo, Santiago / Munayco Pérez, Maria / Santos Sánchez, Renzo |
| **Sprint n – 1 Review Summary** | **Sprint 0 (Inception):** Se consolidaron las bases del proyecto, necesidad médica, análisis comparativo de competidores (Sensitech, Tracklink Perú, Controlant), investigación de campo con 6 entrevistas a profundidad, User Personas (Javier Soto, Dr. Carlos Mendoza), EventStorming y Style Guidelines. El Product Owner aprobó el alcance inicial del backlog. |
| **Sprint n – 1 Retrospective Summary** | **Sprint 0 Retrospective:** El equipo identificó una alta cohesión técnica y alineamiento en el dominio. Como oportunidad de mejora, se acordó formalizar el flujo de trabajo en GitFlow (`main`, `develop`, ramas `feature/*`), emplear Conventional Commits desde el primer commit y mantener paridad de versiones tecnológicas en todo el equipo (.NET 10 LTS, MySQL 8.0, Node.js 20+). |
| **Sprint Goal & User Stories** | **Sprint Goal & User Stories** |
| Sprint 1 Goal | **Our focus is on** designing, implementing, and deploying the responsive institutional Landing Page for Medical SMARTBOX and specifying the core architectural contracts.<br><br>**We believe it delivers** clear value proposition awareness and digital acquisition channels for medical logistics transport operators and healthcare centers.<br><br>**This will be confirmed when** the Landing Page is publicly deployed on GitHub Pages, visitors can explore smart container features across devices without visual overflow, and submit the B2B demonstration contact form successfully. |
| Sprint 1 Velocity | 16 Story Points |
| Sum of Story Points | 16 Story Points (US04: 2 SP, US05: 2 SP, US06: 1 SP, US01: 3 SP, US02: 3 SP, US03: 5 SP) |

---

### 5.2.1.2. Aspect Leaders and Collaborators

En esta sección se presenta la matriz **Leadership-and-Collaboration Matrix (LACX)** del Sprint 1, detallando por cada aspecto funcional y técnico del alcance quién ejerce el liderazgo técnico (Leader - L) y quiénes actúan como colaboradores de desarrollo (Collaborator - C).

Los aspectos definidos para este primer ciclo corresponden a los módulos del Landing Page y las especificaciones arquitectónicas base:
* **Aspecto 1: Landing Page UI & Estructura:** Maquetación semántica HTML5/CSS3 y diseño responsive (US04).
* **Aspecto 2: Formulario Demo y Captura B2B:** Componentes interactivos de contacto institucional y validación en cliente (US05).
* **Aspecto 3: FAQ & Cumplimiento Normativo:** Acordeón interactivo de preguntas frecuentes y directivas sanitarias (US06).
* **Aspecto 4: Registro Institucional & Roles:** Modelado de entidades y flujos de registro de centros de salud (US01).
* **Aspecto 5: Acceso y Autenticación 2FA:** Especificación de políticas de seguridad, login y token OTP (US02).
* **Aspecto 6: Especificación API REST & DDD:** Contratos OpenAPI y arquitectura de capas en ASP.NET Core (.NET 10 LTS) (US03).

| Team Member<br>(Last Name, First Name) | GitHub Username | Aspecto 1:<br>Landing Page UI<br>Leader (L) /<br>Collaborator (C) | Aspecto 2:<br>Formulario Demo<br>Leader (L) /<br>Collaborator (C) | Aspecto 3:<br>FAQ Normativo<br>Leader (L) /<br>Collaborator (C) | Aspecto 4:<br>Registro Centros<br>Leader (L) /<br>Collaborator (C) | Aspecto 5:<br>Acceso & 2FA<br>Leader (L) /<br>Collaborator (C) | Aspecto 6:<br>API REST & DDD<br>Leader (L) /<br>Collaborator (C) |
|---|---|:---:|:---:|:---:|:---:|:---:|:---:|
| Jaramillo Mayta, Jhon Jordy | `jhon409` | C | C | C | L | C | C |
| Espinoza Flores, Aaron André | `AaronEspinoza1` | C | L | C | C | C | C |
| Gargate Paredes, Santiago | `Santiago-Gargate` | C | C | L | C | L | C |
| Munayco Apolaya, Maria Luisa | `MunaycoMaria` | L | C | C | C | C | C |
| Santos Minaya, Renzo Piero | `RenzoSantosUPC` | C | C | C | C | C | L |

---

### 5.2.1.3. Sprint Backlog 1

El **Sprint Backlog 1** presenta el desglose detallado de tareas técnicas asociadas a las historias de usuario comprometidas para el Sprint 1. El objetivo principal de la iteración fue la construcción, validación responsive y despliegue del Landing Page institucional, junto con la definición de contratos y modelos para los servicios de autenticación y registro.

* **Herramienta de Gestión:** GitHub Projects / Trello.
* **URL Pública del Board:** [`https://github.com/orgs/NeonCode-UPC/projects/1`](https://github.com/orgs/NeonCode-UPC/projects/1)

A continuación se presenta la tabla oficial de control de estado del Sprint 1:

| Sprint # | Sprint 1 | | | | | | |
|---|---|---|---|---|---|---|---|
| **User Story** | **User Story** | **Work-Item / Task** | **Work-Item / Task** | **Work-Item / Task** | **Work-Item / Task** | **Work-Item / Task** | **Work-Item / Task** |
| **Story Id** | **Story Title** | **Task Id** | **Task Title** | **Task Description** | **Estimation (Hours)** | **Assigned To** | **Status** |
| US04 | Exploración de Propuesta de Valor Logística | TSK-04-01 | Maquetación HTML5/CSS3 de secciones Hero y Propuesta | Estructuración semántica de Hero, badges térmicos y características de contenedores IoT. | 6 h | Maria Munayco | Done |
| US04 | Exploración de Propuesta de Valor Logística | TSK-04-02 | Integración de diseño responsive mobile-first | Adaptación de layout CSS Grid y Flexbox para viewports móviles (375px a 414px) y tablets. | 4 h | Santiago Gargate | Done |
| US05 | Solicitud de Demostración Corporativa | TSK-05-01 | Maquetación de formulario B2B | Estructura visual de captura de prospectos con inputs institucionales y estilos de marca. | 5 h | Aaron Espinoza | Done |
| US05 | Solicitud de Demostración Corporativa | TSK-05-02 | Validación en cliente y retroalimentación | Lógica JavaScript para validación de RUC, correo corporativo y feedback accesible. | 6 h | Jhon Jaramillo | Done |
| US06 | Consulta de Preguntas Frecuentes | TSK-06-01 | Componente interactivo acordeón FAQ | Maquetación y comportamiento toggle ARIA para preguntas sobre normativas DIGEMID y sensores. | 4 h | Maria Munayco | Done |
| US01 | Registro de Institución de Salud | TSK-01-01 | Modelado entidad institución y base de datos | Definición de esquema relacional `hospital_institutions` en MySQL 8.0 y reglas de RUC único. | 5 h | Jhon Jaramillo | Done |
| US01 | Registro de Institución de Salud | TSK-01-02 | Especificación de endpoints de registro | Diseño de contratos OpenAPI para recepción y validación de datos de centros hospitalarios. | 7 h | Renzo Santos | Done |
| US02 | Autenticación de Personal de Emergencia | TSK-02-01 | Diseño de flujo de autenticación 2FA | Especificación de protocolo de login para operadores y verificación por código OTP de 6 dígitos. | 5 h | Santiago Gargate | Done |
| US03 | Endpoint de Autenticación de Usuarios (API) | TSK-03-01 | Diseño de contratos OpenAPI de sign-in | Especificación de endpoint POST `/api/v1/authentication/sign-in` y esquemas JWT de sesión. | 6 h | Renzo Santos | Done |
| US03 | Endpoint de Autenticación de Usuarios (API) | TSK-03-02 | Arquitectura de dominio para identidad (.NET 10) | Modelado de clases de dominio, Value Objects y políticas de cifrado de credenciales en C# 14. | 5 h | Aaron Espinoza | Done |

**Resumen de Cierre del Sprint Backlog 1:**
* **Historias de Usuario Completadas:** 6 (100% de historias planificadas).
* **Story Points Entregados:** 16 SP / 16 SP comprometidos.
* **Horas de Ingeniería Ejecutadas:** 53 horas de desarrollo colaborativo.
* **Estado Final:** Sprint 1 cerrado satisfactoriamente con despliegue activo en la nube.

---

### 5.2.1.4. Development Evidence for Sprint Review

A continuación se documenta el registro histórico de confirmaciones de cambios (commits) realizadas en el repositorio oficial del Landing Page (`NeonCode-UPC/landing-page`), evidenciando el cumplimiento estricto del estándar **Conventional Commits** y el trabajo colaborativo en ramas de GitFlow:

| Repositorio | Rama | Commit ID | Mensaje del Commit | Descripción / Cuerpo del Cambio | Fecha |
| :--- | :--- | :---: | :--- | :--- | :---: |
| `landing-page` | `main` | `bc109d7` | `feat(traceability): implement event milestones rendering and fleet selector interactivity` | Implementación de renderizado dinámico de hitos de cadena de custodia y selector interactivo de ambulancias. | 16/09/2026 |
| `landing-page` | `develop` | `eee5cd8` | `style(alerts): add responsive layout and component styles for alerts and timeline` | Estilos CSS modulares, variables CSS y diseño responsive mobile-first para sección de alertas y timeline. | 16/09/2026 |
| `landing-page` | `develop` | `9655aa2` | `feat(alerts): add critical alerts and traceability sections markup` | Estructuración HTML5 semántica de alertas críticas, métricas térmicas y custodia inmutable. | 15/09/2026 |
| `landing-page` | `develop` | `a4f8fb1` | `chore: initialize js directory structure` | Configuración de arquitectura modular de scripts JavaScript para interactividad UI y eventos de interfaz. | 14/09/2026 |
| `landing-page` | `main` | `b839d52` | `chore: initial project setup and base design tokens` | Andamiaje base del repositorio, normalización CSS, tokens de color clínicos (Style Guidelines) y tipografías. | 08/09/2026 |

---

### 5.2.1.5. Execution Evidence for Sprint Review

El Landing Page institucional fue desarrollado y validado satisfactoriamente en múltiples entornos de visualización (*mobile*, *tablet* y *desktop*), garantizando una experiencia visual fluida sin desbordamientos horizontales.

#### Video de Demostración de Navegación (Landing Page): [Ver video aquí](https://upcedupe-my.sharepoint.com/:v:/g/personal/u20211b556_upc_edu_pe/IQAX1igNY3mbRqGmWKucsjYmASJHJ3_4rrqXZmvxOTHGoaU?e=4wl9UP)

<img width="2028" height="1090" alt="Screenshot 2026-09-28 at 10 33 48 AM" src="https://github.com/user-attachments/assets/7c5733c4-086d-4fd7-8335-7a6b68b379a6" />

### Vista implementada: Landing Page Principal (Hero Section)

**Descripción:** Interfaz de inicio diseñada para captar la atención de empresas de transporte y operadores de cadena de frío. Presenta la propuesta de valor central de Medical SmartBox: el monitoreo, detección de incidencias y trazabilidad de transportes médicos en un solo lugar.

**Componentes y Funcionalidades Clave:**
* **Barra de navegación funcional:** Menú interactivo con accesos directos a la plataforma, selector de idioma (ES/EN) y botones globales de autenticación (*Log in / Open the Web App*).
* **Propuesta de valor clara:** Título principal de alto impacto acompañado de una breve descripción del propósito del software.
* **Llamados a la acción (CTA):** Botones duales contrastados para redirigir rápidamente al usuario hacia la Web App o el formulario de ingreso.

<br>

![Landing Page - Sección Hero](../assets/chapter-4/hero-mockup.png)
*Nota: Captura de ejecución del Landing Page institucional implementado.*

<br>

<img width="669" height="588" alt="Screenshot 2026-09-28 at 10 46 46 AM" src="https://github.com/user-attachments/assets/42d285c0-2ff3-48f9-b89f-d21dc15bc4ff" /> 

### Vista implementada: Formulario de Inicio de Sesión (Login)

**Descripción:** Interfaz correspondiente al módulo de autenticación para la Web Application de Medical SmartBox. Permite el acceso restringido y seguro al personal autorizado (operadores logísticos y centros de salud) mediante credenciales corporativas.

**Componentes Clave:** 
* **Campos de entrada validados:** Inputs específicos para Correo corporativo (`nombre@organizacion.com`) y Contraseña protegida de manera visual.
* **Botón de acción directa:** Botón estilizado con los colores de la marca para el envío y validación de las credenciales de usuario (*Iniciar sesión*).
* **Control de navegación:** Botón de cierre superior (X) para retornar a la Landing Page principal de manera intuitiva.

<br>

<img width="1061" height="894" alt="Screenshot 2026-09-28 at 11 06 33 AM" src="https://github.com/user-attachments/assets/22dc7b3b-5cc6-402a-b381-8ed8964b464b" />

### Vista implementada: Detalle de Monitoreo de Transporte en Tiempo Real

**Descripción:** Vista detallada de un transporte en tránsito activo. Centraliza todas las telemetrías críticas recopiladas por el hardware en una única interfaz unificada para el operador.

**Componentes Clave:**
* **Panel de Telemetría en Vivo:** Indicadores en tiempo real de Temperatura (5.2 °C), ETA, Nivel de Batería del SmartBox, Combustible, Peso y Estado de la Puerta.
* **Gráfico de Historial Térmico:** Gráfica lineal automatizada que contrasta las mediciones de las últimas 6 horas frente al rango seguro permitido (2 °C - 8 °C).
* **Metadatos de Operación:** Tarjetas informativas con los datos asignados del Conductor (M. Quispe) y la Placa del Vehículo (ABQ-742).

<br>

![Landing Page - Presentación de Características](../assets/chapter-4/presentacion-mockup.png)
*Nota: Sección interactiva de propuesta tecnológica del Landing Page.*

<br>

<img width="1078" height="704" alt="Screenshot 2026-09-28 at 11 16 31 AM" src="https://github.com/user-attachments/assets/59b725c5-d856-4195-bddc-5b4af7790860" />

### Vista implementada: Módulo de Gestión de Alertas e Incidencias

**Descripción:** Interfaz de control en tiempo real orientada a la detección temprana de riesgos en la cadena de frío, permitiendo al equipo logístico tomar acciones de mitigación inmediatas antes de comprometer la integridad del producto médico.

**Componentes Clave:**
* **Tarjeta de Incidencia Crítica:** Bloque dinámico que detalla de forma matemática el desvío térmico (8.7 °C detectados frente al rango esperado de 2-8 °C), la ubicación exacta (Panamericana Sur) y la marca de tiempo (13:42).
* **Gráfico de Monitoreo Lineal:** Visualización de la fluctuación de temperatura de las últimas horas para evaluar la gravedad de la anomalía.
* **Acciones de Mitigación:** Botones interactivos de respuesta rápida (*Revisar transporte* y *Ver historial*).
* **Feed Cronológico Histórico:** Listado lateral estructurado por prioridad de eventos y estados logísticos anteriores (Puerta abierta, Batería baja, Desvío resuelto, Entrega confirmada).

<br>

![Landing Page - Footer y Conversión B2B](../assets/chapter-4/cta-footer-mockup.png)
*Nota: Sección de conversión final y pie de página institucional.*

---

### 5.2.1.6. Services Documentation Evidence for Sprint Review

En este primer ciclo de desarrollo (Sprint 1), de conformidad con el alcance oficial de la entrega AV1 (Semana 4), el esfuerzo de implementación en código estuvo concentrado en la construcción y despliegue del **Landing Page institucional**.

La arquitectura de servicios backend (**RESTful Web API en ASP.NET Core 10.0 con C#**) y el servicio en segundo plano de ingesta IoT fueron formalizados exhaustivamente en los capítulos de diseño técnico:
* **Capítulo 4.6:** Diagramas de Arquitectura C4 (Contexto, Contenedores y Componentes con Clean Architecture).
* **Capítulo 4.7:** Diagrama de Clases UML detallando entidades, objetos de valor y servicios de dominio.
* **Capítulo 4.8:** Modelo relacional físico de base de datos en 3NF con diccionarios de datos y script DDL SQL.

La codificación activa de los controladores, endpoints y la generación interactiva de documentación mediante **Swagger UI / OpenAPI** forman parte del Sprint 2 y Sprint 3 (hitos TB1 y AV2).

---

### 5.2.1.7. Software Deployment Evidence for Sprint Review

En estricta observancia del requisito rector del hito AV1 (*"A nivel de implementación debe estar implementada y desplegada la primera versión del Landing Page"*), la solución se encuentra desplegada y públicamente accesible en la nube:

* **Organización en GitHub:** `NeonCode-UPC`
* **Repositorio del Landing Page:** [`https://github.com/NeonCode-UPC/landing-page`](https://github.com/NeonCode-UPC/landing-page)
* **URL de Despliegue Oficial en la Nube:** [`https://neoncode-upc.github.io/landing-page/`](https://neoncode-upc.github.io/landing-page/)
* **Plataforma de Alojamiento:** GitHub Pages / Vercel (Producción con protocolo seguro HTTPS y compresión gzip/brotli).
* **Estado de Disponibilidad:** Activo, con tiempo de carga inferior a 1.2 segundos y cumplimiento de accesibilidad WCAG.

---

### 5.2.1.8. Team Collaboration Insights during Sprint

Durante el Sprint 1, el equipo utilizó GitHub como herramienta centralizada de control de versiones y colaboración técnica. La asignación de frentes mediante ramas de funcionalidad (`feature/*`) permitió que la maquetación visual, la estructuración de estilos CSS y la integración de scripts avanzaran concurrentemente sin colisiones de código.

![Team Collaboration Insights during Sprint](../assets/chapter-5/report-insights-av1.png)
*Nota: Analítica de colaboración, frecuencia de confirmaciones y contribuciones del equipo NeonCode durante el Sprint 1.*
