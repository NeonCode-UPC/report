# 5.2. Landing Page & Services Implementations

## 5.2.1. Sprint 1

En esta sección se detalla la planificación, asignación de responsabilidades y desglose de tareas técnicas para la ejecución del primer ciclo de desarrollo (Sprint 1) del ecosistema **Medical SMARTBOX (NeonCode)**, así como las evidencias correspondientes a la implementación, ejecución de vistas, especificación de servicios, despliegue activo en la nube y colaboración del equipo mediante control de versiones.

***

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

***

### 5.2.1.2. Aspect Leaders and Collaborators

En esta sección se presenta la matriz **Leadership-and-Collaboration Matrix (LACX)** del Sprint 1, detallando por cada aspecto funcional y técnico del alcance quién ejerce el liderazgo técnico (Leader - L) y quiénes actúan como colaboradores de desarrollo (Collaborator - C).

Los aspectos definidos para este primer ciclo corresponden a los módulos del Landing Page y las especificaciones arquitectónicas base:
* **Aspecto 1: Landing Page UI & Estructura:** Maquetación semántica HTML5/CSS3 y diseño responsive (US04).
* **Aspecto 2: Formulario Demo y Captura B2B:** Componentes interactivos de contacto institucional y validación en cliente (US05).
* **Aspecto 3: FAQ & Cumplimiento Normativo:** Acordeón interactivo de preguntas frecuentes y directivas sanitarias (US06).
* **Aspecto 4: Registro Institucional & Roles:** Modelado de entidades y flujos de registro de centros de salud (US01).
* **Aspecto 5: Acceso y Autenticación 2FA:** Especificación de políticas de seguridad, login y token OTP (US02).
* **Aspecto 6: Especificación API REST & DDD:** Contratos OpenAPI y arquitectura de capas en ASP.NET Core (.NET 10 LTS) (US03).

<div style="margin: 12px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 22%;" />
  <col style="width: 16%;" />
  <col style="width: 10.3%;" />
  <col style="width: 10.3%;" />
  <col style="width: 10.3%;" />
  <col style="width: 10.3%;" />
  <col style="width: 10.3%;" />
  <col style="width: 10.5%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Team Member<br>(Last Name, First Name)</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">GitHub Username</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Aspecto 1:<br>Landing UI<br>(L / C)</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Aspecto 2:<br>Form Demo<br>(L / C)</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Aspecto 3:<br>FAQ Norm.<br>(L / C)</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Aspecto 4:<br>Reg. Centros<br>(L / C)</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Aspecto 5:<br>Acceso 2FA<br>(L / C)</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Aspecto 6:<br>REST &amp; DDD<br>(L / C)</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><strong>Jaramillo Mayta, Jhon Jordy</strong></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><code>jhon409</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #ecfdf5; font-weight: bold; color: #047857;">L</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><strong>Espinoza Flores, Aaron André</strong></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><code>AaronEspinoza1</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #ecfdf5; font-weight: bold; color: #047857;">L</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><strong>Gargate Paredes, Santiago</strong></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><code>Santiago-Gargate</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #ecfdf5; font-weight: bold; color: #047857;">L</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #ecfdf5; font-weight: bold; color: #047857;">L</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><strong>Munayco Apolaya, Maria Luisa</strong></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><code>MunaycoMaria</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #ecfdf5; font-weight: bold; color: #047857;">L</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><strong>Santos Minaya, Renzo Piero</strong></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: middle;"><code>RenzoSantosUPC</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #f8fafc; font-weight: bold; color: #475569;">C</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; text-align: center; vertical-align: middle; background-color: #ecfdf5; font-weight: bold; color: #047857;">L</td>
</tr>
</tbody>
</table>
</div>

***

### 5.2.1.3. Sprint Backlog 1

El **Sprint Backlog 1** presenta el desglose detallado de tareas técnicas asociadas a las historias de usuario comprometidas para el Sprint 1. El objetivo principal de la iteración fue la construcción, validación responsive y despliegue del Landing Page institucional, junto con la definición de contratos y modelos para los servicios de autenticación y registro.

A continuación se presenta la tabla oficial de control de estado del Sprint 1:

<div style="margin: 12px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.5pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 7%;" />
  <col style="width: 18%;" />
  <col style="width: 8%;" />
  <col style="width: 16%;" />
  <col style="width: 27%;" />
  <col style="width: 6%;" />
  <col style="width: 11%;" />
  <col style="width: 7%;" />
</colgroup>
<thead>
<tr style="background-color: #0f172a; color: #ffffff;">
  <th colspan="2" style="border: 1px solid #334155; padding: 4px; text-align: left; font-weight: bold;">User Story</th>
  <th colspan="6" style="border: 1px solid #334155; padding: 4px; text-align: left; font-weight: bold;">Work-Item / Task (Sprint 1)</th>
</tr>
<tr style="background-color: #f1f5f9; color: #0f172a;">
  <th style="border: 1px solid #cbd5e1; padding: 3px; text-align: left; font-weight: bold;">Story Id</th>
  <th style="border: 1px solid #cbd5e1; padding: 3px; text-align: left; font-weight: bold;">Story Title</th>
  <th style="border: 1px solid #cbd5e1; padding: 3px; text-align: left; font-weight: bold;">Task Id</th>
  <th style="border: 1px solid #cbd5e1; padding: 3px; text-align: left; font-weight: bold;">Task Title</th>
  <th style="border: 1px solid #cbd5e1; padding: 3px; text-align: left; font-weight: bold;">Task Description</th>
  <th style="border: 1px solid #cbd5e1; padding: 3px; text-align: center; font-weight: bold;">Horas</th>
  <th style="border: 1px solid #cbd5e1; padding: 3px; text-align: left; font-weight: bold;">Assigned To</th>
  <th style="border: 1px solid #cbd5e1; padding: 3px; text-align: center; font-weight: bold;">Status</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US04</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Exploración de Propuesta de Valor Logística</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-04-01</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Maquetación HTML5/CSS3 de secciones Hero y Propuesta</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Estructuración semántica de Hero, badges térmicos y características de contenedores IoT.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">6 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Maria Munayco</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US04</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Exploración de Propuesta de Valor Logística</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-04-02</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Integración de diseño responsive mobile-first</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Adaptación de layout CSS Grid y Flexbox para viewports móviles (375px a 414px) y tablets.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">4 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Santiago Gargate</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US05</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Solicitud de Demostración Corporativa</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-05-01</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Maquetación de formulario B2B</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Estructura visual de captura de prospectos con inputs institucionales y estilos de marca.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">5 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Aaron Espinoza</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US05</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Solicitud de Demostración Corporativa</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-05-02</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Validación en cliente y retroalimentación</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Lógica JavaScript para validación de RUC, correo corporativo y feedback accesible.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">6 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Jhon Jaramillo</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US06</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Consulta de Preguntas Frecuentes</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-06-01</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Componente interactivo acordeón FAQ</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Maquetación y comportamiento toggle ARIA para preguntas sobre normativas DIGEMID y sensores.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">4 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Maria Munayco</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US01</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Registro de Institución de Salud</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-01-01</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Modelado entidad institución y base de datos</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Definición de esquema relacional `hospital_institutions` en MySQL 8.0 y reglas de RUC único.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">5 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Jhon Jaramillo</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US01</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Registro de Institución de Salud</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-01-02</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Especificación de endpoints de registro</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Diseño de contratos OpenAPI para recepción y validación de datos de centros hospitalarios.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">7 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Renzo Santos</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US02</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Autenticación de Personal de Emergencia</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-02-01</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Diseño de flujo de autenticación 2FA</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Especificación de protocolo de login para operadores y verificación por código OTP de 6 dígitos.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">5 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Santiago Gargate</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US03</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Endpoint de Autenticación de Usuarios (API)</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-03-01</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Diseño de contratos OpenAPI de sign-in</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Especificación de endpoint POST `/api/v1/authentication/sign-in` y esquemas JWT de sesión.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">6 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Renzo Santos</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: bold;">US03</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Endpoint de Autenticación de Usuarios (API)</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; font-weight: 600;">TSK-03-02</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Arquitectura de dominio para identidad (.NET 10)</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Modelado de clases de dominio, Value Objects y políticas de cifrado de credenciales en C# 14.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; font-weight: bold;">5 h</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top;">Aaron Espinoza</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px; vertical-align: top; text-align: center; background-color: #ecfdf5; color: #047857; font-weight: bold;">Done</td>
</tr>
</tbody>
</table>
</div>

**Resumen de Cierre del Sprint Backlog 1:**
* **Historias de Usuario Completadas:** 6 (100% de historias planificadas).
* **Story Points Entregados:** 16 SP / 16 SP comprometidos.
* **Horas de Ingeniería Ejecutadas:** 53 horas de desarrollo colaborativo.
* **Estado Final:** Sprint 1 cerrado satisfactoriamente con despliegue activo en la nube.

***

### 5.2.1.4. Development Evidence for Sprint Review

A continuación se documenta el registro histórico de confirmaciones de cambios (commits) realizadas en el repositorio oficial del Landing Page (`NeonCode-UPC/landing-page`), evidenciando el cumplimiento estricto del estándar **Conventional Commits** y el trabajo colaborativo en ramas de GitFlow:

<div style="margin: 12px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 14%;" />
  <col style="width: 11%;" />
  <col style="width: 11%;" />
  <col style="width: 25%;" />
  <col style="width: 27%;" />
  <col style="width: 12%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Repositorio</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Rama</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Commit ID</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Mensaje del Commit</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción / Cuerpo del Cambio</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Fecha</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>landing-page</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>main</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;"><code>bc109d7</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 500;">`feat(traceability): implement event milestones rendering and fleet selector interactivity`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Implementación de renderizado dinámico de hitos de cadena de custodia y selector interactivo de ambulancias.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;">16/09/2026</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>landing-page</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>develop</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;"><code>eee5cd8</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 500;">`style(alerts): add responsive layout and component styles for alerts and timeline`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Estilos CSS modulares, variables CSS y diseño responsive mobile-first para sección de alertas y timeline.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;">16/09/2026</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>landing-page</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>develop</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;"><code>9655aa2</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 500;">`feat(alerts): add critical alerts and traceability sections markup`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Estructuración HTML5 semántica de alertas críticas, métricas térmicas y custodia inmutable.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;">15/09/2026</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>landing-page</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>develop</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;"><code>a4f8fb1</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 500;">`chore: initialize js directory structure`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Configuración de arquitectura modular de scripts JavaScript para interactividad UI y eventos de interfaz.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;">14/09/2026</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>landing-page</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>main</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;"><code>b839d52</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 500;">`chore: initial project setup and base design tokens`</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Andamiaje base del repositorio, normalización CSS, tokens de color clínicos (Style Guidelines) y tipografías.</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center;">08/09/2026</td>
</tr>
</tbody>
</table>
</div>

***

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

<br />

![Landing Page - Sección Hero](assets/chapter-4/hero-mockup.png)
*Nota: Captura de ejecución del Landing Page institucional implementado.*

<br />

<img width="669" height="588" alt="Screenshot 2026-09-28 at 10 46 46 AM" src="https://github.com/user-attachments/assets/42d285c0-2ff3-48f9-b89f-d21dc15bc4ff" />

### Vista implementada: Formulario de Inicio de Sesión (Login)

**Descripción:** Interfaz correspondiente al módulo de autenticación para la Web Application de Medical SmartBox. Permite el acceso restringido y seguro al personal autorizado (operadores logísticos y centros de salud) mediante credenciales corporativas.

**Componentes Clave:** 
* **Campos de entrada validados:** Inputs específicos para Correo corporativo (`nombre@organizacion.com`) y Contraseña protegida de manera visual.
* **Botón de acción directa:** Botón estilizado con los colores de la marca para el envío y validación de las credenciales de usuario (*Iniciar sesión*).
* **Control de navegación:** Botón de cierre superior (X) para retornar a la Landing Page principal de manera intuitiva.

<br />

<img width="1061" height="894" alt="Screenshot 2026-09-28 at 11 06 33 AM" src="https://github.com/user-attachments/assets/22dc7b3b-5cc6-402a-b381-8ed8964b464b" />

### Vista implementada: Detalle de Monitoreo de Transporte en Tiempo Real

**Descripción:** Vista detallada de un transporte en tránsito activo. Centraliza todas las telemetrías críticas recopiladas por el hardware en una única interfaz unificada para el operador.

**Componentes Clave:**
* **Panel de Telemetría en Vivo:** Indicadores en tiempo real de Temperatura (5.2 °C), ETA, Nivel de Batería del SmartBox, Combustible, Peso y Estado de la Puerta.
* **Gráfico de Historial Térmico:** Gráfica lineal automatizada que contrasta las mediciones de las últimas 6 horas frente al rango seguro permitido (2 °C - 8 °C).
* **Metadatos de Operación:** Tarjetas informativas con los datos asignados del Conductor (M. Quispe) y la Placa del Vehículo (ABQ-742).

<br />

![Landing Page - Presentación de Características](assets/chapter-4/presentacion-mockup.png)
*Nota: Sección interactiva de propuesta tecnológica del Landing Page.*

<br />

<img width="1078" height="704" alt="Screenshot 2026-09-28 at 11 16 31 AM" src="https://github.com/user-attachments/assets/59b725c5-d856-4195-bddc-5b4af7790860" />

### Vista implementada: Módulo de Gestión de Alertas e Incidencias

**Descripción:** Interfaz de control en tiempo real orientada a la detección temprana de riesgos en la cadena de frío, permitiendo al equipo logístico tomar acciones de mitigación inmediatas antes de comprometer la integridad del producto médico.

**Componentes Clave:**
* **Tarjeta de Incidencia Crítica:** Bloque dinámico que detalla de forma matemática el desvío térmico (8.7 °C detectados frente al rango esperado de 2-8 °C), la ubicación exacta (Panamericana Sur) y la marca de tiempo (13:42).
* **Gráfico de Monitoreo Lineal:** Visualización de la fluctuación de temperatura de las últimas horas para evaluar la gravedad de la anomalía.
* **Acciones de Mitigación:** Botones interactivos de respuesta rápida (*Revisar transporte* y *Ver historial*).
* **Feed Cronológico Histórico:** Listado lateral estructurado por prioridad de eventos y estados logísticos anteriores (Puerta abierta, Batería baja, Desvío resuelto, Entrega confirmada).

<br />

![Landing Page - Footer y Conversión B2B](assets/chapter-4/cta-footer-mockup.png)
*Nota: Sección de conversión final y pie de página institucional.*

***

### 5.2.1.6. Services Documentation Evidence for Sprint Review

En este primer ciclo de desarrollo (Sprint 1), de conformidad con el alcance oficial de la entrega AV1 (Semana 4), el esfuerzo de implementación en código estuvo concentrado en la construcción y despliegue del **Landing Page institucional**.

La arquitectura de servicios backend (**RESTful Web API en ASP.NET Core 10.0 con C#**) y el servicio en segundo plano de ingesta IoT fueron formalizados exhaustivamente en los capítulos de diseño técnico:
* **Capítulo 4.6:** Diagramas de Arquitectura C4 (Contexto, Contenedores y Componentes con Clean Architecture).
* **Capítulo 4.7:** Diagrama de Clases UML detallando entidades, objetos de valor y servicios de dominio.
* **Capítulo 4.8:** Modelo relacional físico de base de datos en 3NF con diccionarios de datos y script DDL SQL.

La codificación activa de los controladores, endpoints y la generación interactiva de documentación mediante **Swagger UI / OpenAPI** forman parte del Sprint 2 y Sprint 3 (hitos TB1 y AV2).

***

### 5.2.1.7. Software Deployment Evidence for Sprint Review

En estricta observancia del requisito rector del hito AV1 (*"A nivel de implementación debe estar implementada y desplegada la primera versión del Landing Page"*), la solución se encuentra desplegada y públicamente accesible en la nube:

* **Organización en GitHub:** `NeonCode-UPC`
* **Repositorio del Landing Page:** [`https://github.com/NeonCode-UPC/landing-page`](https://github.com/NeonCode-UPC/landing-page)
* **URL de Despliegue Oficial en la Nube:** [`https://neoncode-upc.github.io/landing-page/`](https://neoncode-upc.github.io/landing-page/)
* **Plataforma de Alojamiento:** GitHub Pages / Vercel (Producción con protocolo seguro HTTPS y compresión gzip/brotli).
* **Estado de Disponibilidad:** Activo, con tiempo de carga inferior a 1.2 segundos y cumplimiento de accesibilidad WCAG.

***

### 5.2.1.8. Team Collaboration Insights during Sprint

Durante el Sprint 1, el equipo utilizó GitHub como herramienta centralizada de control de versiones y colaboración técnica. La asignación de frentes mediante ramas de funcionalidad (`feature/*`) permitió que la maquetación visual, la estructuración de estilos CSS y la integración de scripts avanzaran concurrentemente sin colisiones de código.

![Team Collaboration Insights during Sprint](assets/chapter-5/report-insights-av1.png)
*Nota: Analítica de colaboración, frecuencia de confirmaciones y contribuciones del equipo NeonCode durante el Sprint 1.*

## 5.2.2. Sprint 2

En esta sección se detalla nuestra organizacion para el segundo avance de este segundo entregable (TB1), asignación de responsabilidades y desglose de tareas técnicas para la ejecución del primer ciclo de desarrollo (Sprint 1) del ecosistema **Medical SMARTBOX (NeonCode)**, así como las evidencias correspondientes a la implementación, ejecución de vistas, especificación de servicios, despliegue activo en la nube y colaboración del equipo mediante control de versiones.

***

### 5.2.2.1. Sprint Planning 2

El Sprint Planning 2 tuvo como propósito establecer el objetivo, alcance y responsabilidades del segundo ciclo de desarrollo. El equipo priorizó las historias de usuario relacionadas con el registro de unidades de ambulancia, la vinculación de contenedores inteligentes y la gestión de información de telemetría.

| **Sprint #** | **Sprint 2** |
|---|---|
| **Sprint Planning Background** | **Sprint Planning 2** |
| **Date** | 2026-10-06 |
| **Time** | 20:30 PM |
| **Location** | Reunión virtual mediante Google Meet |
| **Prepared By** | Santiago Gargate |
| **Attendees (to planning meeting)** | Santiago Gargate / Maria Munayco / Aaron Espinoza / Jhon Jaramillo / Renzo Santos |
| **Sprint Goal & User Stories** | **Sprint 2 Goal:** Implementar e integrar las funcionalidades necesarias para registrar unidades de ambulancia, vincular contenedores inteligentes y gestionar la información de telemetría requerida para su monitoreo. |
| **Sprint 2 Velocity** | 29 Story Points |
| **Sum of Story Points** | 29 Story Points |

El Sprint 2 comprende las siguientes historias de usuario:

- **US07:** Alta de Unidades de Ambulancia — **3 SP**
- **US08:** Vinculación de Contenedor Inteligente — **5 SP**
- **US09:** Ingesta de Telemetría IoT (API) — **8 SP**
- **US10:** Monitoreo Térmico y de Apertura — **8 SP**
- **US12:** Consulta de Telemetría e Indicadores (API) — **5 SP**

**Total: 29 Story Points.**

### 5.2.2.2. Aspect Leaders and Collaborators

Para el Sprint 2 se estableció la matriz de liderazgo y colaboración considerando los cinco aspectos principales definidos para la solución. El integrante responsable de cada bounded context asume el rol de **Lead (L)**, mientras que los demás integrantes participan como **Collaborators (C)** en las actividades de desarrollo e integración.

**L = Lead / C = Collaborator**

| **Integrante** | **Aspecto 1:** Smart Container & Telemetry Monitoring **(L/C)** | **Aspecto 2:** Critical Alerting & Incident Response **(L/C)** | **Aspecto 3:** Identity, Access & Subscriptions **(L/C)** | **Aspecto 4:** Chain of Custody & Traceability **(L/C)** | **Aspecto 5:** Medical Transport Planning & Dispatching **(L/C)** |
|---|---|---|---|---|---|
| **Jhon Jaramillo** | **L** | C | C | C | C |
| **Aaron Espinoza** | C | **L** | C | C | C |
| **Santiago Gargate** | C | C | **L** | C | C |
| **Maria Munayco** | C | C | C | **L** | C |
| **Renzo Santos** | C | C | C | C | **L** |

La distribución permite mantener un responsable principal por aspecto y, al mismo tiempo, conservar el trabajo colaborativo entre los integrantes del equipo.

### 5.2.2.3. Sprint Backlog 2

El Sprint Backlog 2 descompone las historias de usuario seleccionadas para el Sprint en tareas técnicas que permiten organizar y controlar su implementación. El Sprint contempla **29 Story Points** distribuidos entre US07, US08, US09, US10 y US12.

**Board del Sprint 2:**
![Sprint 2 Board]<img width="1213" height="500" alt="Captura de pantalla 2026-10-06 222220" src="https://github.com/user-attachments/assets/5287c618-49ef-4306-951e-088e93da075a" />


**URL público del Board:** [VER BOARD DE TRELLO](https://trello.com/invite/b/6ac5b477b94c5d4caaf604c3/ATTI42608b792af85428b31c8bfdbc720edbAE48B8A5/neoncode-sprint-2)

<table>
  <tr>
    <td><strong>Sprint #</strong></td>
    <td colspan="7"><strong>Sprint 2</strong></td>
  </tr>
  <tr>
    <td colspan="2"><strong>User Story</strong></td>
    <td colspan="6"><strong>Work-Item / Task</strong></td>
  </tr>
  <tr>
    <th>Story Id</th>
    <th>Story Title</th>
    <th>Task Id</th>
    <th>Task Title</th>
    <th>Task Description</th>
    <th>Estimation<br>(Hours)</th>
    <th>Assigned To</th>
    <th>Status<br>(To-do / In Process / To Review / Done)</th>
  </tr>

  <tr>
    <td>US09</td>
    <td>Ingesta de Telemetría IoT</td>
    <td>TSK-09-01</td>
    <td>Implementación del endpoint de ingesta</td>
    <td>Implementación del endpoint POST para recibir datos de temperatura, peso, apertura y batería.</td>
    <td>8 h</td>
    <td>Jhon Jaramillo</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US09</td>
    <td>Ingesta de Telemetría IoT</td>
    <td>TSK-09-02</td>
    <td>Validación del payload y autenticación</td>
    <td>Validación de los datos recibidos y del token de autenticación del dispositivo IoT.</td>
    <td>6 h</td>
    <td>Jhon Jaramillo</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US09</td>
    <td>Ingesta de Telemetría IoT</td>
    <td>TSK-09-03</td>
    <td>Persistencia de lecturas</td>
    <td>Registro de las lecturas válidas de telemetría.</td>
    <td>6 h</td>
    <td>Jhon Jaramillo</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US07</td>
    <td>Alta de Unidades de Ambulancia</td>
    <td>TSK-07-01</td>
    <td>Creación del modelo de datos de Ambulancias</td>
    <td>Creación del modelo de datos de ambulancias.</td>
    <td>4 h</td>
    <td>Renzo Santos</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US07</td>
    <td>Alta de Unidades de Ambulancia</td>
    <td>TSK-07-02</td>
    <td>Desarrollo de endpoints CRUD</td>
    <td>Desarrollo de funcionalidades para el registro y consulta de vehículos.</td>
    <td>6 h</td>
    <td>Renzo Santos</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US07</td>
    <td>Alta de Unidades de Ambulancia</td>
    <td>TSK-07-03</td>
    <td>Interfaz web para registro</td>
    <td>Desarrollo del formulario y listado de unidades registradas.</td>
    <td>6 h</td>
    <td>Renzo Santos</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US08</td>
    <td>Vinculación de Contenedor Inteligente</td>
    <td>TSK-08-01</td>
    <td>Desarrollo del módulo de asignación</td>
    <td>Implementación de la relación entre ambulancia y contenedor IoT.</td>
    <td>8 h</td>
    <td>Renzo Santos</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US08</td>
    <td>Vinculación de Contenedor Inteligente</td>
    <td>TSK-08-02</td>
    <td>Validación de estados del dispositivo</td>
    <td>Validación para impedir la reasignación de un contenedor ocupado.</td>
    <td>5 h</td>
    <td>Renzo Santos</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US08</td>
    <td>Vinculación de Contenedor Inteligente</td>
    <td>TSK-08-03</td>
    <td>Interfaz web de vinculación</td>
    <td>Interfaz para vincular el contenedor mediante UUID/MAC.</td>
    <td>6 h</td>
    <td>Renzo Santos</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US12</td>
    <td>Consulta de Telemetría e Indicadores</td>
    <td>TSK-12-01</td>
    <td>Endpoint de consulta de métricas</td>
    <td>Consulta de las últimas mediciones de un contenedor.</td>
    <td>6 h</td>
    <td>Jhon Jaramillo</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US12</td>
    <td>Consulta de Telemetría e Indicadores</td>
    <td>TSK-12-02</td>
    <td>Métricas consolidadas</td>
    <td>Construcción de la respuesta con temperatura, batería, escotilla, peso y fecha/hora.</td>
    <td>4 h</td>
    <td>Jhon Jaramillo</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US10</td>
    <td>Monitoreo Térmico y de Apertura</td>
    <td>TSK-10-01</td>
    <td>Visualización de temperatura y escotilla</td>
    <td>Visualización de temperatura y estado de apertura del contenedor.</td>
    <td>6 h</td>
    <td>Jhon Jaramillo</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US10</td>
    <td>Monitoreo Térmico y de Apertura</td>
    <td>TSK-10-02</td>
    <td>Actualización de telemetría</td>
    <td>Actualización de las lecturas del panel.</td>
    <td>6 h</td>
    <td>Jhon Jaramillo</td>
    <td>Done</td>
  </tr>

  <tr>
    <td>US10</td>
    <td>Monitoreo Térmico y de Apertura</td>
    <td>TSK-10-03</td>
    <td>Gestión de pérdida de señal</td>
    <td>Representación del estado de desconexión cuando no se reciben lecturas.</td>
    <td>4 h</td>
    <td>Jhon Jaramillo</td>
    <td>Done</td>
  </tr>
</table>

### 5.2.2.4. Development Evidence for Sprint Review

Durante el Sprint 2 se realizaron avances en la implementación e integración de los principales módulos de la solución, incluyendo Identity & Access Management, Alerting, Medical Transport Planning, Chain of Custody y Smart Container & Telemetry. Estos avances se evidencian mediante los commits realizados en el repositorio del frontend durante el 06/10/2026.

| **Repository** | **Branch** | **Commit Message** | **Commit Message Body** | **Committed on (Date)** |
|---|---|---|---|---|
| frontend | develop | `feat(frontend): integrate custody, alerting, iam and transport` | Se integran los módulos de Chain of Custody, Alerting, IAM y Medical Transport Planning en la aplicación frontend. | 06/10/2026 |
| frontend | develop | `feat(iam): integrate identity and subscriptions` | Se integra el módulo de Identity & Access Management junto con la gestión de suscripciones. | 06/10/2026 |
| frontend | develop | `feat(alerting): integrate incident response` | Se integra la funcionalidad de respuesta ante incidentes en la aplicación. | 06/10/2026 |
| frontend | develop | `feat(transport): integrate medical transport planning` | Se integra el módulo de planificación de transporte médico en la aplicación. | 06/10/2026 |
| frontend | develop | `feat(custody): restore chain of custody feature` | Se restaura la funcionalidad correspondiente a la cadena de custodia y trazabilidad. | 06/10/2026 |
| frontend | develop | `feat(custody): restore chain of custody changes` | Se restauran los cambios realizados para la funcionalidad de Chain of Custody. | 06/10/2026 |
| frontend | develop | `feat(telemetry): implement smart container and telemetry monitoring views and ddd architecture` | Se implementan las vistas de Smart Container y monitoreo de telemetría, junto con la arquitectura DDD. | 06/10/2026 |
| frontend | develop | `feat(iam): build subscription management view` | Se implementa la vista para la administración de suscripciones. | 06/10/2026 |

### 5.2.2.5. Execution Evidence for Sprint Review

En el Sprint 2 se logró avanzar en la implementación e integración de las principales funcionalidades de la Web Application correspondientes a los Bounded Contexts definidos para la solución. Durante este Sprint se desarrollaron y consolidaron funcionalidades relacionadas con el monitoreo de contenedores inteligentes y telemetría, gestión de alertas e incidentes, identidad y suscripciones, trazabilidad de cadena de custodia y planificación de transporte médico.

**Video de Demostración de Navegación (Web Application):** [Ver video aquí](https://upcedupe-my.sharepoint.com/:v:/g/personal/u20211b556_upc_edu_pe/IQAX1igNY3mbRqGmWKucsjYmASJHJ3_4rrqXZmvxOTHGoaU?e=4wl9UP)

**Screenshots de Identity, Access & Subscriptions (IAM)**

> [Vista de Usuarios y Roles|500](PEGAR_AQUÍ_EL_LINK_DE_GITHUB_DE_LA_IMAGEN)

> *Vista de Usuarios y Roles*

> [Vista de Suscripción|500](PEGAR_AQUÍ_EL_LINK_DE_GITHUB_DE_LA_IMAGEN)

> *Vista de Suscripción*

### 5.2.2.6. Services Documentation Evidence for Sprint Review

Durante el Sprint 2 no se desarrollaron ni implementaron servicios web asociados al backend. El alcance de esta entrega estuvo enfocado principalmente en la implementación de la primera versión de las Frontend Web Applications, desarrolladas con Vue.js, PrimeVue y Pinia.

Por este motivo, no se presentan endpoints OpenAPI ni evidencias de interacción con servicios backend en esta sección. La implementación de los Web Services se encuentra contemplada para una etapa posterior del proyecto.

### 5.2.2.7. Software Deployment Evidence for Sprint Review

Durante el Sprint 2 se realizaron las actividades de despliegue correspondientes a los productos incluidos en el alcance de la entrega TB1. En esta etapa se consideró la nueva versión del Landing Page y la primera versión de las Frontend Web Applications.

#### Landing Page

Se realizó el despliegue de la nueva versión del Landing Page, incorporando las mejoras y correcciones desarrolladas durante los Sprints anteriores.

**URL del Landing Page:**  
[PEGAR AQUÍ EL LINK]

**Evidencia del despliegue:**

> [Insertar captura del Landing Page desplegado]

*Landing Page desplegado y disponible para su visualización.*

#### Frontend Web Application

Durante el Sprint 2 se implementó y desplegó la primera versión de la Frontend Web Application de Medical SmartBox. Esta versión integra las funcionalidades desarrolladas por los integrantes del equipo para los diferentes Bounded Contexts.

**URL de la Web Application:**  
[PEGAR AQUÍ EL LINK]

**Evidencia del despliegue:**

> [Insertar captura de la Web Application desplegada]

*Primera versión de la Frontend Web Application desplegada.*

#### Web Services

Los Web Services no forman parte del despliegue correspondiente a esta entrega, debido a que su primera versión se encuentra contemplada para una etapa posterior del proyecto.

### 5.2.2.8. Team Collaboration Insights during Sprint

Durante el Sprint 2, el equipo NeonCode trabajó de manera colaborativa en la implementación e integración de las funcionalidades correspondientes a los cinco Bounded Contexts de Medical SmartBox: Smart Container & Telemetry Monitoring, Critical Alerting & Incident Response, Identity, Access & Subscriptions, Chain of Custody & Traceability y Medical Transport Planning & Dispatching.

Cada integrante asumió responsabilidades sobre los diferentes Bounded Contexts, permitiendo desarrollar las funcionalidades en paralelo y avanzar de manera organizada. Se utilizó GitHub como herramienta principal de control de versiones, gestionando el trabajo mediante ramas de funcionalidad y commits individuales para registrar los avances realizados durante el Sprint.

La integración del trabajo se realizó progresivamente, consolidando las funcionalidades desarrolladas por los integrantes en la Web Application y permitiendo disponer de una versión integrada de los diferentes Bounded Contexts al finalizar el Sprint.

**Evidencia de colaboración del equipo**

[Team Collaboration Insights – Sprint 2|500]<img width="833" height="657" alt="Captura de pantalla 2026-10-06 223905" src="https://github.com/user-attachments/assets/38f09b67-f13a-4209-b42c-f9ddb2d2822c" />

*Nota: Evidencia de colaboración del equipo durante el Sprint 2, mostrando la actividad registrada en GitHub mediante commits y contribuciones de los integrantes.*
