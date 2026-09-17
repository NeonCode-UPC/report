# Project Report Collaboration Insights

El informe del proyecto **Medical SMARTBOX** ha sido elaborado de manera estrictamente colaborativa y descentralizada a través de un repositorio público en la plataforma GitHub, administrado bajo la organización oficial de la startup (**NeonCode-UPC**), en cumplimiento con los estándares de ingeniería y gobernanza documental estipulados en el enunciado del curso **1ASI0730 Aplicaciones Web**.

**URL del Repositorio Oficial del Informe:**  
<https://github.com/NeonCode-UPC/report>

---

## 1. Gobernanza y Flujo de Trabajo en el Repositorio

Para garantizar la integridad estructural, la trazabilidad histórica de los cambios y la no colisión entre los colaboradores, el equipo implementó las siguientes políticas de ingeniería de software:

* **Modelo de Ramificación GitFlow:**  
  * `main`: Rama de producción documental que aloja exclusivamente las versiones estables consolidadas correspondientes a los hitos evaluativos institucionales (`V1.0.0` para AV1, `V2.0.0` para TB1, etc.).  
  * `develop`: Rama de integración continua donde convergen las contribuciones revisadas de cada capítulo.  
  * `feature/*`: Ramas de desarrollo temáticas aisladas (`feature/ch1-startup-solution`, `feature/ch2-needfinding-eventstorming`, `feature/ch3-requirements-backlog`, `feature/ch4-architecture-c4-class-db`, `feature/ch5-scm-sprint1`, `feature/report-management`), creadas individualmente por cada integrante según su asignación.
* **Estándar Conventional Commits 1.0.0:** Todos los registros de confirmación se estructuraron bajo prefijos canónicos (`docs(...)`, `feat(...)`, `fix(...)`, `chore(...)`), especificando el alcance del cambio y facilitando la auditoría cruzada.
* **Políticas de Pull Requests (PR) y Code/Doc Review:** La incorporación de contenido hacia `develop` y `main` requirió la revisión cruzada de al menos un miembro del equipo para verificar el cumplimiento de las guías de estilo Markdown y la integridad de los enlaces y tablas.

---

## 2. Participación del Equipo en el Informe Técnico (Hito AV1)

La siguiente matriz resume la distribución formal de responsabilidades y las aportaciones técnicas destacadas de cada miembro del equipo durante el desarrollo del primer avance:

| Integrante | Usuario GitHub | Rol Principal | Secciones y Capítulos Asignados (AV1) | Aportaciones Técnicas Destacadas |
| :--- | :---: | :---: | :--- | :--- |
| **Espinoza Flores, Aaron André** | `@psure` | Research & Entrevistas | **Capítulo I completo:**<br>• 1.1 Startup Profile<br>• 1.2 Solution Profile (5W2H, Lean UX)<br>• 1.3 Segmentos Objetivo<br>**Capítulo II:**<br>• 2.1 Competidores<br>• 2.2 Entrevistas | Formulación de la problemática clínica sustentada en pérdidas de cadena de frío en ambulancias; elaboración del Lean UX Canvas; delimitación cualitativa de los dos segmentos objetivo; diseño y análisis de entrevistas semiestructuradas a personal de salud y logística. |
| **Gargate Paredes, Santiago** | `@sssantiagoo` | Frontend Developer | **Capítulo V (Sprint 1):**<br>• 5.2.1.4 Development Evidence<br>• 5.2.1.5 Execution Evidence<br>• 5.2.1.7 Software Deployment Evidence<br>• 5.2.1.8 Collaboration Insights | Redacción y consolidación de evidencias del Sprint 1 para el Landing Page; documentación de pruebas de visualización responsive en múltiples viewports; registro de métricas de despliegue continuo en Vercel y métricas de desempeño web. |
| **Jaramillo Mayta, Jhon Jordy** | `@Marklnz1` | Arquitecto de Software | **Capítulo II:**<br>• 2.4 Big Picture EventStorming<br>• 2.5 Ubiquitous Language<br>**Capítulo IV:**<br>• 4.6 Domain-Driven Architecture (C4)<br>• 4.7 Software OO Design (UML)<br>• 4.8 Database Design (ERD) | Modelado colaborativo en Miro del Big Picture EventStorming; redacción de 30 términos canónicos del dominio; descomposición táctica en 6 Bounded Contexts; diagramas C4 (Contexto, Contenedores, Componentes); Diagrama de Clases UML con agregados ricos y diseño relacional en 3NF. |
| **Munayco Apolaya, Maria Luisa** | `@malumunayco` | UX/UI Designer | **Capítulo II:**<br>• 2.3 Needfinding (Personas, Task Matrix, Journey Maps, Empathy)<br>**Capítulo IV:**<br>• 4.1 Style Guidelines<br>• 4.2 Information Architecture<br>• 4.3 a 4.5 UI/UX Wireframes & Mockups | Creación de User Personas y mapas de empatía en UXPressia; definición del Design System clínico y Guías de Estilo; arquitectura de la información (SEO, taxonomía, navegación); diseño interactivo de wireframes y mockups de alta fidelidad en Figma. |
| **Santos Minaya, Renzo Piero** | `@psure` / `@pisure` | Product Owner / Scrum Master | **Capítulo III completo:**<br>• 3.1 User Stories (Gherkin)<br>• 3.2 Impact Mapping<br>• 3.3 Product Backlog<br>**Capítulo V:**<br>• 5.1 SCM (5.1.1 a 5.1.4)<br>• 5.2.1 Sprint 1 (5.2.1.1 a 5.2.1.3) | Redacción de User Stories con criterios de aceptación Gherkin (Given-When-Then); matriz de Impact Mapping y priorización de Backlog; documentación de gobernanza SCM (GitFlow, SemVer); facilitación del Sprint Planning 1, Matriz LACX y Sprint Backlog 1. |

---

## 3. AV1 – Sprint Review (Semana 4)

### 3.1. Dinámica de Trabajo Colaborativo

Durante las cuatro semanas de desarrollo del avance **AV1**, el equipo sincronizó sus esfuerzos mediante una combinación de reuniones presenciales en campus y sesiones virtuales en Discord. La coordinación de tareas se apoyó en un tablero ágil (Trello/Jira) donde cada sección del informe fue modelada como un entregable con criterios de aceptación verificables. 

Cada integrante trabajó en su respectiva rama `feature/*`, sometiendo sus avances a revisión antes de integrarlos en la rama `develop`. Para la entrega final, se consolidó la rama `main`, sincronizando todos los enlaces cruzados, asegurando que las imágenes referenciadas residan en `assets/` y validando la consistencia semántica entre los capítulos de diseño, arquitectura y gestión ágil.

### 3.2. Métricas de Colaboración y Commits en el Repositorio de Documentación

Los datos cuantitativos extraídos del historial de Git para el repositorio de documentación (`NeonCode-UPC/report`) durante el hito **AV1** evidencian una participación activa y balanceada de todos los miembros:

| Integrante | Ramas Principales de Aporte | Commits Realizados | Líneas de Markdown Agregadas (aprox.) | Archivos Aportados / Editados |
| :--- | :--- | :---: | :---: | :---: |
| **Aaron André Espinoza Flores** | `feature/ch1-startup-solution`, `feature/ch2-research` | 5 | ~1,200 | `11-startup-profile.md`, `12-solution-profile.md`, `13-segmentos-objetivos.md`, `21-competidores.md`, `22-entrevistas.md` |
| **Santiago Gargate Paredes** | `feature/ch5-landing-sprint1`, `feature/ch5-insights` | 4 | ~950 | `52-landingpage-services-implementations.md`, `54-video-about-the-product.md` |
| **Jhon Jordy Jaramillo Mayta** | `feature/ch2-domain-modeling`, `feature/ch4-architecture` | 8 | ~4,800 | `24-big-picture-eventstorming.md`, `25-ubiquitous-language.md`, `46-dd-software-architecture.md`, `47-software-object-oriented-design.md`, `48-database-design.md` |
| **Maria Luisa Munayco Apolaya** | `feature/ch2-needfinding`, `feature/ch4-ux-ui` | 6 | ~1,950 | `23-needfinding.md`, `41-style-guidelines.md`, `42-information-architecture.md`, `43-landing-page-ui-design.md`, `44-web-application-uxui-design.md`, `45-web-application-prototyping.md` |
| **Renzo Piero Santos Minaya** | `feature/ch3-backlog`, `feature/ch5-scm-planning`, `feature/report-integration` | 7 | ~2,100 | `01-caratula.md`, `02-registro-versiones.md`, `03-collaboration-insights.md`, `04-contenido.md`, `05-student-outcome.md`, `31-user-stories.md`, `32-impact-mapping.md`, `33-product-backlog.md`, `51-software-configuration-management.md` |

> *Nota: Los commits registrados en esta sección corresponden estrictamente al repositorio del informe técnico (`NeonCode-UPC/report`). Los desarrollos de código fuente correspondientes al Landing Page (`landing-page`), Frontend Web (`medical-smartbox-frontend`) y Backend RESTful API (`medical-smartbox-backend`) se auditan de forma independiente en sus respectivos repositorios.*

### 3.3. Evidencias Gráficas de Colaboración en GitHub (GitHub Insights)

A continuación, se presentan las capturas oficiales de la analítica de colaboración del repositorio del informe en GitHub:

<div align="center">

![Project Contributors Graph](../assets/chapter-5/report-insights-av1.png)

*Figura 0.1 - Histograma de frecuencia de commits y distribución de aportes por colaborador en el repositorio de documentación (Fuente: GitHub Insights).*

</div>

#### Interpretación de las Métricas de Actividad:
* **Semana 1 (08/09/2026):** Pico inicial asociado a la configuración del andamiaje del repositorio, inicialización de plantillas y estructura de directorios.
* **Semana 2 (09/09/2026):** Incorporación intensiva de la investigación preliminar, análisis competitivo y entrevistas de necesidad.
* **Semana 3 (14/09/2026):** Consolidación de sesiones de modelado colaborativo de dominio (EventStorming) y especificación de historias de usuario.
* **Semana 4 (16/09/2026 - 17/09/2026):** Fase de máxima convergencia técnica: integración de arquitectura C4, modelo de clases, persistencia física de base de datos, evidencias de despliegue del Landing Page y auditoría final del informe AV1.

---

## 4. Proyección de Colaboración para Siguientes Hitos

* **TB1 – Stage Review (Semana 7):** Incorporación de la documentación del Sprint 2 (Frontend Web Application en Vue.js / PrimeVue), levantamiento de observaciones del docente y actualización de métricas de contribución.
* **AV2 – Sprint Review (Semana 12):** Documentación del Sprint 3 (Backend RESTful API en ASP.NET Core y persistencia en PostgreSQL/SQL Server), entrevistas de validación con usuarios clínicos y métricas de integración.
* **TB2 – Release Review (Semana 15):** Consolidación final del Sprint 4 (seguridad JWT, pruebas integradas, despliegue global en la nube), producción audiovisual y auditoría final de contribuciones.
