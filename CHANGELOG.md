# Changelog

Todos los cambios notables en el repositorio documental de **Medical SMARTBOX (Equipo NeonCode)** se registran en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/) y este proyecto adhiere estrictamente a [Semantic Versioning 2.0.0](https://semver.org/lang/es/).

---

## [2.1.2] - 2026-11-02

### Added
- Publicación automatizada de **GitHub Releases** en [`.github/workflows/build-report.yml`](.github/workflows/build-report.yml) adjuntando directamente el PDF oficial compilado ante cada etiqueta SemVer `v*`.

### Changed
- Simplificación de [`README.md`](README.md) como guía técnica ejecutiva *Docs-as-Code* sin duplicar la carátula académica de [`01-cover.md`](report/front-matter/01-cover.md).
- Consolidación de la salida de compilación en un único entregable PDF oficial (`upc-pre-202620-1asi0730-8150-neoncode-report-tb1.pdf`) en [`Makefile`](Makefile) y GitHub Actions.

### Fixed
- Normalización determinista de rutas relativas de imágenes (`../` y `../../`) en [`config/filters/pagebreak-and-tables.lua`](config/filters/pagebreak-and-tables.lua) para incrustar las 77 imágenes sin errores en contenedores Linux de GitHub Actions.
- Orden de ejecución de `citeproc` posterior al filtro Lua en [`config/build.yaml`](config/build.yaml) y [`config/eisvogel.yaml`](config/eisvogel.yaml) eliminando la colisión de ancla duplicada `#refs`.

---

## [2.1.1] - 2026-11-02

### Fixed
- Compatibilidad retroactiva de [`config/build.yaml`](config/build.yaml) y [`config/eisvogel.yaml`](config/eisvogel.yaml) con versiones de Pandoc `3.1+` en entornos Linux CI/CD (`ubuntu-latest`), delegando el resaltado léxico al motor predeterminado de Pandoc.
- Optimización del target `make pdf` en [`Makefile`](Makefile) para generar `build/project-report.pdf` por copia directa sin duplicar la invocación al motor PDF.

---

## [2.1.0] - 2026-11-02

### Added
- Configuración declarativa de compilación con Pandoc mediante [`config/build.yaml`](config/build.yaml) y [`config/eisvogel.yaml`](config/eisvogel.yaml) aislando el árbol sintáctico de cada capítulo con `--file-scope` y resolviendo recursos con `--resource-path`.
- Metadatos editoriales desacoplados en [`metadata.yaml`](metadata.yaml) y base de datos bibliográfica en [`bibtex.bib`](bibtex.bib) procesada automáticamente en formato APA con `--citeproc` y citas nativas `[@clave]`.
- Filtro AST en Lua ([`config/filters/pagebreak-and-tables.lua`](config/filters/pagebreak-and-tables.lua)) para saltos de página agnósticos al motor (`latex`, `typst`, `html5`), normalización de rutas relativas `../assets/` y resolución cruzada de anclas `.md#seccion`.
- Orquestador multiplataforma [`Makefile`](Makefile) (`make pdf`, `make eisvogel`, `make clean`) y pipeline CI/CD en GitHub Actions ([`.github/workflows/build-report.yml`](.github/workflows/build-report.yml)).
- Fuentes versionables de Diagramas como Código en `assets/diagrams/` ([`telemetry-custody-sequence.puml`](assets/diagrams/telemetry-custody-sequence.puml) y [`telemetry-pipeline-flow.mmd`](assets/diagrams/telemetry-pipeline-flow.mmd)), plantilla [`eisvogel.latex`](config/templates/eisvogel.latex) y fondo vectorial [`cover-background.pdf`](assets/cover-background.pdf).
- Subcarpetas modulares normalizadas en inglés y `kebab-case`: `report/front-matter/` (`01` a `05`), `report/99-bibliography.md` y `report/annexes/` (`annex-a`, `annex-b`, `annex-c`).
- Registro histórico formal [`CHANGELOG.md`](CHANGELOG.md) bajo el estándar *Keep a Changelog*.

### Changed
- Reemplazo del `README.md` monolítico autogenerado (587 KB) por una portada ejecutiva del repositorio ([`README.md`](README.md)) con instrucciones de compilación e índice modular navegable.
- Conversión del 100 % del informe (31 archivos Markdown) a **Pandoc Markdown puro**, migrando las 40 tablas HTML (`<table>`), las 20 etiquetas `<img>` HTML y la carátula en `<div>` HTML hacia tablas GFM nativas, sintaxis `![alt](ruta){...}` y *fenced divs* (`::: {#carátula .cover-page}`).
- Descarga local en `assets/chapter-5/` de las 11 evidencias visuales del Capítulo V que dependían de enlaces externos `github.com/user-attachments` y renombrado integral de activos a `kebab-case`.
- Actualización de las 77 referencias gráficas y de los enlaces de la Tabla de Contenido a rutas relativas por archivo (`../assets/...`, `../../assets/...` y `archivo.md#ancla`) para visualización directa tanto en IDEs/GitHub como en el PDF compilado.

### Removed
- Eliminación de scripts locales con rutas absolutas (`compilar-pdf.bat`, `build-readme.ps1`), directorio antiguo `docs/`, artefactos PDF binarios en la raíz del repositorio y archivos de configuración de IDE (`.idea/`).

---

## [2.0.0] - 2026-10-06

### Added
- Documentación integral del **Sprint 2 (Hito TB1 — Semana 7)** en la sección 5.2.2: Sprint Planning 2, matriz de líderes y colaboradores, Sprint Backlog 2 desglosado en tareas técnicas, evidencias de desarrollo y ejecución del frontend en Vue 3 + PrimeVue + Pinia, despliegue continuo y métricas de colaboración.
- Actualización de acciones y conclusiones del **ABET EAC Student Outcome 5** correspondientes al hito TB1.

### Changed
- Levantamiento integral de observaciones docentes sobre el entregable AV1: estructuración de la matriz 5W2H en Solution Profile, sustento cuantitativo de segmentos objetivo, trazabilidad explícita de User Personas en User Stories, Impact Mapping y Product Backlog, e inclusión de metaetiquetas SEO y dimensiones NNg.
- Sincronización de nombres de agregados DDD entre Big Picture EventStorming, Design-Level EventStorming, Ubiquitous Language, Class Diagrams y Database Design (mapeo EF Core 10 + UUIDv7).

---

## [1.3.1] - 2026-10-06

### Changed
- Refactorización de la arquitectura de software (Sección 4.6) bajo la topología canónica del **C4 Model**: consolidación a 4 contenedores principales (Static Landing Page, Vue SPA, ASP.NET Core RESTful Web API y MySQL 8.0 Database) y descomposición modular por *Bounded Contexts* con Clean Architecture.

---

## [1.3.0] - 2026-09-16

### Added
- Capítulo V inicial: Gestión de Configuración de Software (5.1) cubriendo entorno de desarrollo (.NET 10 SDK, Node.js, Vite), flujo GitFlow + Conventional Commits + SemVer, guías de estilo y despliegue continuo en GitHub Pages.
- Ejecución completa del **Sprint 1 (Hito AV1 — Semana 4)** en la sección 5.2.1: Sprint Planning 1, matriz LACX, Sprint Backlog 1 y evidencias de implementación, validación responsive y despliegue de la Landing Page institucional.
- Conclusiones preliminares, referencias bibliográficas en formato APA 7 y anexos documentales.

---

## [1.2.5] - 2026-09-16

### Added
- Diseño de interfaz y experiencia de usuario (Secciones 4.3, 4.4 y 4.5): wireframes, wireflows, mockups de alta fidelidad y prototipo interactivo en Figma para Landing Page y Web Application.
- Arquitectura orientada al dominio (Sección 4.6): Design-Level EventStorming delimitando los 5 *Bounded Contexts* del sistema y diagramas C4 (Context, Container y Component).
- Diseño orientado a objetos con diagramas de clases UML por contexto (Sección 4.7) y diseño físico relacional en 3NF sobre MySQL 8.0 InnoDB con diccionario de datos e índices de telemetría IoT (Sección 4.8).

---

## [1.2.0] - 2026-09-14

### Added
- Needfinding completo (Sección 2.3): User Personas (*Aldair Lázaro* y *Gianfranco Timoteo*), User Task Matrix, User Journey Mapping As-Is y Empathy Maps.
- Modelado estratégico de dominio mediante Big Picture EventStorming (Sección 2.4) y glosario formal de Ubiquitous Language (Sección 2.5).
- Especificación ágil de requisitos (Capítulo III): historias de usuario y técnicas con criterios Gherkin Given-When-Then (3.1), Impact Mapping (3.2) y Product Backlog priorizado (3.3).
- Guías de estilo visual (Sección 4.1) y arquitectura de información (Sección 4.2).

---

## [1.1.0] - 2026-09-09

### Added
- Capítulo I completo: Startup Profile de **NeonCode** (1.1), Solution Profile de **Medical SMARTBOX** con proceso Lean UX (1.2) y delimitación de Segmentos Objetivo (1.3).
- Análisis competitivo frente a Sensitech, Tracklink Perú y Controlant (Sección 2.1) y diseño, registro y análisis de entrevistas semiestructuradas (Sección 2.2).

---

## [1.0.0] - 2026-09-08

### Added
- Inicialización del repositorio `NeonCode-UPC/report` bajo flujo de trabajo GitFlow (`main`, `develop`, `feature/*`) y convenciones *Conventional Commits*.
- Carátula institucional UPC conforme a los lineamientos del curso `1ASI0730` Aplicaciones Web y estructura base de capítulos del informe técnico.
