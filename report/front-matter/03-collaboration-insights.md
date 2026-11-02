# Project Report Collaboration Insights

El informe del proyecto **Medical SMARTBOX** ha sido elaborado de manera estrictamente colaborativa y descentralizada a través de un repositorio público en la plataforma GitHub, administrado bajo la organización oficial de la startup (**NeonCode-UPC**), en cumplimiento con los estándares de ingeniería y gobernanza documental estipulados en el enunciado del curso **1ASI0730 Aplicaciones Web**.

**URL del Repositorio Oficial del Informe:**  
<https://github.com/NeonCode-UPC/report>

***

## 1. Gobernanza y Flujo de Trabajo en el Repositorio

Para garantizar la integridad estructural, la trazabilidad histórica de los cambios y la no colisión entre los colaboradores, el equipo implementó las siguientes políticas de ingeniería de software:

* **Modelo de Ramificación GitFlow:**  
  * `main`: Rama de producción documental que aloja exclusivamente las versiones estables consolidadas correspondientes a los hitos evaluativos institucionales (`V1.3.0` para AV1, `V2.0.0` para TB1, etc.).  
  * `develop`: Rama de integración continua donde convergen las contribuciones revisadas de cada capítulo.  
  * `feature/*`: Ramas de desarrollo temáticas aisladas (`feature/consolidate-5-bounded-contexts`, `feature/needfinding`, `feature/student-outcome`, `feature/tb1-report-delivery`, etc.), creadas individualmente por cada integrante según su asignación.
* **Estándar Conventional Commits 1.0.0:** Todos los registros de confirmación se estructuraron bajo prefijos canónicos (`docs(...)`, `feat(...)`, `fix(...)`, `refactor(...)`, `style(...)`), especificando el alcance del cambio y facilitando la auditoría cruzada.
* **Políticas de Pull Requests (PR) y Code/Doc Review:** La incorporación de contenido hacia `develop` y `main` requirió la revisión cruzada de al menos un miembro del equipo para verificar el cumplimiento de las guías de estilo Markdown y la integridad de los enlaces y tablas.

***

## 2. Participación del Equipo en el Informe Técnico (Hitos AV1 y TB1)

La siguiente matriz resume la distribución formal de responsabilidades y las aportaciones técnicas destacadas de cada miembro del equipo durante el desarrollo del primer avance (AV1) y de la primera entrega parcial (TB1):

| Integrante | Usuario GitHub | Rol Principal | Secciones y Capítulos Asignados (AV1 y TB1) | Aportaciones Técnicas Destacadas |
| :--------------- | :----------: | :--------------: | :--------------------------- | :--------------------------- |
| **Espinoza Flores, Aaron André** |    `@psure`    | Research & Entrevistas | **Capítulo I completo:**<br>• 1.1 Startup Profile<br>• 1.2 Solution Profile (5W2H, Lean UX)<br>• 1.3 Segmentos Objetivo<br>**Capítulo II:**<br>• 2.1 Competidores<br>• 2.2 Entrevistas<br>**Sprint 2 (TB1):**<br>• Bounded Contexts *Critical Alerting* e *IAM* | Formulación de la problemática clínica 5W2H sustentada en pérdidas de cadena de frío en ambulancias; elaboración del Lean UX Canvas; delimitación demográfica y cualitativa de los dos segmentos objetivo; diseño y análisis de entrevistas semiestructuradas; desarrollo de módulos de alertas e identidad en Sprint 2. |
| **Jaramillo Mayta, Jhon Jordy** |  `@Marklnz1`   | Arquitecto de Software | **Capítulo II:**<br>• 2.4 Big Picture EventStorming<br>• 2.5 Ubiquitous Language<br>**Capítulo IV:**<br>• 4.6 Domain-Driven Architecture (C4)<br>• 4.7 Software OO Design (UML)<br>• 4.8 Database Design (ERD)<br>**Sprint 2 (TB1):**<br>• Bounded Context *Smart Container & Telemetry* | Modelado colaborativo en Miro del Big Picture EventStorming; redacción del Ubiquitous Language; consolidación táctica en 5 Bounded Contexts; diagramas C4 canónicos (Contexto, Contenedores, Componentes); Diagramas de Clases UML con agregados ricos y diseño relacional en 3NF con UUIDv7 (RFC 9562). |
| **Munayco Apolaya, Maria Luisa** | `@malumunayco` | UX/UI Designer | **Capítulo II:**<br>• 2.3 Needfinding (Personas, Task Matrix, Journey Maps, Empathy)<br>**Capítulo IV:**<br>• 4.1 Style Guidelines<br>• 4.2 Information Architecture<br>• 4.3 a 4.5 UI/UX Wireframes & Mockups<br>**Sprint 2 (TB1):**<br>• Bounded Context *Chain of Custody* | Creación de User Personas (Aldair Lazaro y Gianfranco Timoteo), Journey Maps As-Is y mapas de empatía en UXPressia; definición del Design System clínico y Guías de Estilo; arquitectura de la información (SEO, taxonomía, navegación); diseño interactivo en Figma y módulo de custodia en Sprint 2. |
| **Santos Minaya, Renzo Piero** |   `@RSSint`    | Product Owner / Scrum Master | **Capítulo III completo:**<br>• 3.1 User Stories (Gherkin)<br>• 3.2 Impact Mapping<br>• 3.3 Product Backlog<br>**Capítulo V:**<br>• 5.1 SCM (5.1.1 a 5.1.4)<br>• 5.2.1 Sprint 1 y 5.2.2 Sprint 2<br>**Sprint 2 (TB1):**<br>• Bounded Context *Medical Transport Planning* | Redacción de User Stories con criterios de aceptación Gherkin (Given-When-Then); matriz de Impact Mapping y priorización de Backlog; documentación de gobernanza SCM (GitFlow, SemVer); facilitación del Sprint Planning 1 y 2, Matrices LACX, Sprint Backlogs y módulo de despacho médico. |

***

## 3. AV1 – Sprint Review (Semana 4)

### 3.1. Dinámica de Trabajo Colaborativo

Durante las cuatro semanas de desarrollo del avance **AV1**, el equipo sincronizó sus esfuerzos mediante una combinación de reuniones presenciales en campus y sesiones virtuales en Discord. La coordinación de tareas se apoyó en un tablero ágil donde cada sección del informe fue modelada como un entregable con criterios de aceptación verificables. 

Cada integrante trabajó en su respectiva rama `feature/*`, sometiendo sus avances a revisión antes de integrarlos en la rama `develop`. Para la entrega final, se consolidó la rama `main`, sincronizando todos los enlaces cruzados, asegurando que las imágenes referenciadas residan en `assets/` y validando la consistencia semántica entre los capítulos de diseño, arquitectura y gestión ágil.

### 3.2. Métricas de Colaboración y Commits en el Repositorio de Documentación (AV1)

Los datos cuantitativos extraídos del historial de Git para el repositorio de documentación (`NeonCode-UPC/report`) durante el hito **AV1** evidencian una participación activa y balanceada de todos los miembros:

| Integrante | Ramas Principales de Aporte | Commits Realizados | Líneas de Markdown Agregadas (aprox.) | Archivos Aportados / Editados |
| :----------------- | :------------------------- | :----------: | :----------: | :--------------------------- |
| **Aaron André Espinoza Flores** | `feature/ch1-startup-solution`, `feature/ch2-research` | 5 | ~1,200 | `11-startup-profile.md`, `12-solution-profile.md`, `13-target-segments.md`, `21-competitors.md`, `22-interviews.md` |
| **Jhon Jordy Jaramillo Mayta** | `feature/ch2-domain-modeling`, `feature/ch4-architecture` | 8 | ~4,800 | `24-big-picture-eventstorming.md`, `25-ubiquitous-language.md`, `46-dd-software-architecture.md`, `47-software-object-oriented-design.md`, `48-database-design.md` |
| **Maria Luisa Munayco Apolaya** | `feature/ch2-needfinding`, `feature/ch4-ux-ui` | 6 | ~1,950 | `23-needfinding.md`, `41-style-guidelines.md`, `42-information-architecture.md`, `43-landing-page-ui-design.md`, `44-web-application-uxui-design.md`, `45-web-application-prototyping.md` |
| **Renzo Piero Santos Minaya** | `feature/ch3-backlog`, `feature/ch5-scm-planning`, `feature/report-integration` | 7 | ~2,100 | `front-matter/01-cover.md`, `front-matter/02-version-history.md`, `front-matter/03-collaboration-insights.md`, `front-matter/04-table-of-contents.md`, `front-matter/05-student-outcome.md`, `31-user-stories.md`, `32-impact-mapping.md`, `33-product-backlog.md`, `51-software-configuration-management.md` |

> *Nota: Los commits registrados en esta sección corresponden estrictamente al repositorio del informe técnico (`NeonCode-UPC/report`). Los desarrollos de código fuente correspondientes al Landing Page (`NeonCode-UPC/landing-page`) y Frontend Web Application (`NeonCode-UPC/frontend`) se auditan de forma independiente en sus respectivos repositorios en la sección 5.2.*

### 3.3. Evidencias Gráficas de Colaboración en GitHub (GitHub Insights)

A continuación, se presentan las capturas oficiales de la analítica de colaboración del repositorio del informe en GitHub:


![Project Contributors Graph](assets/chapter-5/report-insights-av1.png)

*Figura 0.1 - Histograma de frecuencia de commits y distribución de aportes por colaborador en el repositorio de documentación (Fuente: GitHub Insights).*


#### Interpretación de las Métricas de Actividad:


* **Semana 1 (08/09/2026):** Pico inicial asociado a la configuración del andamiaje del repositorio, inicialización de plantillas y estructura de directorios.
* **Semana 2 (09/09/2026):** Incorporación intensiva de la investigación preliminar, análisis competitivo y entrevistas de necesidad.
* **Semana 3 (14/09/2026):** Consolidación de sesiones de modelado colaborativo de dominio (EventStorming) y especificación de historias de usuario.
* **Semana 4 (16/09/2026 - 17/09/2026):** Fase de máxima convergencia técnica: integración de arquitectura C4, modelo de clases, persistencia física de base de datos, evidencias de despliegue del Landing Page y auditoría final del informe AV1.

***

## 4. TB1 – Stage Review (Semana 7)

Durante las semanas 5 a 7 correspondientes al **Hito TB1 (Sprint 2)**, el equipo ejecutó el levantamiento integral de las observaciones formuladas en el primer avance y documentó la implementación del primer incremento funcional de la **Web Application** en **Vue 3** y **PrimeVue**:

* **Consolidación de Needfinding y Evidencia Empírica (`feature/needfinding`):** Reconstrucción de los perfiles de *User Personas* (**Aldair Lazaro** y **Gianfranco Timoteo**), *User Task Matrix*, *User Journey Maps As-Is* y *Empathy Maps* directamente fundamentados en las seis entrevistas de campo.
* **Estandarización Arquitectónica y Dominio (`feature/consolidate-5-bounded-contexts`):** Simplificación canónica del modelo C4 a 4 contenedores, unificación táctica de los 5 Bounded Contexts en diagramas DLES, clases UML y esquema relacional MySQL 8.0 con identificadores `UUIDv7` (RFC 9562).
* **Documentación de Ejecución del Sprint 2 (`feature/sprint-2-report`, `feature/student-outcome`, `feature/tb1-report-delivery`):** Incorporación de la sección `5.2.2. Sprint 2` completa, actualización de la matriz de *Student Outcome* ABET para TB1 y sincronización de conclusiones y anexos con el repositorio del Frontend desplegado.

***

## 5. Proyección de Colaboración para Siguientes Hitos

* **AV2 – Sprint Review (Semana 12):** Documentación del Sprint 3 (Backend RESTful API en ASP.NET Core 10.0 y persistencia en MySQL Server 8.0 [InnoDB] mediante EF Core 10.0), entrevistas de validación con usuarios clínicos y métricas de integración.
* **TB2 – Release Review (Semana 15):** Consolidación final del Sprint 4 (seguridad JWT, pruebas integradas, despliegue global en la nube), producción audiovisual y auditoría final de contribuciones.
