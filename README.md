# Medical SMARTBOX — NeonCode Report

Repositorio documental bajo arquitectura **Docs-as-Code** del startup **NeonCode** y su solución **Medical SMARTBOX** para el curso `1ASI0730` Aplicaciones Web (NRC `8150`) — Ingeniería de Software, UPC.

El informe técnico modular está disponible en [`report/`](report/), los recursos gráficos y diagramas como código en [`assets/`](assets/), y el historial de versiones semánticas en [`CHANGELOG.md`](CHANGELOG.md).

## Estructura del Repositorio

```text
.
├── .github/workflows/build-report.yml       # CI/CD: compilación PDF y publicación automática en Releases
├── assets/                                  # Activos gráficos y fuentes de diagramas (.dsl, .puml, .mmd, .sql)
├── build/                                   # Salida local del PDF compilado (ignorada en Git)
├── config/                                  # Configuración declarativa de Pandoc
│   ├── build.yaml                           # Archivo Defaults principal (--file-scope, --resource-path)
│   ├── eisvogel.yaml                        # Perfil alternativo para plantilla Eisvogel + XeLaTeX
│   ├── filters/pagebreak-and-tables.lua     # Filtro AST Lua (saltos de página, enlaces e imágenes)
│   ├── styles/report.css                    # Hoja de estilos tipográfica A4
│   └── templates/eisvogel.latex             # Plantilla LaTeX Eisvogel
├── report/                                  # Secciones modulares en Pandoc Markdown puro
│   ├── front-matter/                        # Preliminares (01-cover a 05-student-outcome)
│   ├── 11-startup-profile.md ... 61-conclusions.md
│   ├── 99-bibliography.md                   # Bibliografía APA autogenerada con citeproc
│   └── annexes/                             # Anexos aislados (Anexo A, B y C)
├── metadata.yaml                            # Variables globales de portada y metadatos
├── bibtex.bib                               # Base de datos bibliográfica en formato BibTeX
├── Makefile                                 # Orquestador de compilación (make pdf / make clean)
└── CHANGELOG.md                             # Registro de versiones bajo Keep a Changelog y SemVer
```

## Requisitos e Instalación

La generación local del documento utiliza **Pandoc** y **WeasyPrint**:

```bash
# Ubuntu / Debian
sudo apt update && sudo apt install -y pandoc weasyprint make

# Windows (winget + pip)
winget install --source winget --exact --id JohnMacFarlane.Pandoc
py -m pip install weasyprint

# macOS (Homebrew)
brew install pandoc weasyprint
```

## Compilación a PDF

Desde la raíz del repositorio:

```bash
# Ejecución directa mediante archivo Defaults de Pandoc
pandoc --defaults=config/build.yaml

# O mediante GNU Make
make pdf
```

El documento compilado se genera en `build/upc-pre-202620-1asi0730-8150-neoncode-report-tb1.pdf`. Adicionalmente, cada etiqueta SemVer `v*` publicada en GitHub compila y adjunta automáticamente el PDF oficial en la sección **Releases** del repositorio.

## Flujo de Trabajo Git (GitFlow & SemVer)

- `main`: entregas estables y versiones etiquetadas con SemVer (`v1.0.0`, `v1.3.0`, `v2.0.0`, `v2.1.x`).
- `develop`: rama principal de integración continua de capítulos.
- `feature/*`: desarrollo aislado de nuevas secciones o artefactos.
- `release/*` y `hotfix/*`: preparación de entregas y correcciones puntuales sobre `main`.

## Índice Modular del Informe

### Secciones Preliminares (`report/front-matter/`)
- [Carátula Institucional](report/front-matter/01-cover.md)
- [Registro de Versiones del Informe](report/front-matter/02-version-history.md)
- [Project Report Collaboration Insights](report/front-matter/03-collaboration-insights.md)
- [Tabla de Contenido General](report/front-matter/04-table-of-contents.md)
- [ABET – EAC - Student Outcome 5](report/front-matter/05-student-outcome.md)

### Capítulo I: Introducción
- [1.1. Startup Profile](report/11-startup-profile.md#11-startup-profile)
  - [1.1.1. Descripción de la Startup](report/11-startup-profile.md#111-descripción-de-la-startup)
  - [1.1.2. Perfiles de integrantes del equipo](report/11-startup-profile.md#112-perfiles-de-integrantes-del-equipo)
- [1.2. Solution Profile](report/12-solution-profile.md#12-solution-profile)
  - [1.2.1. Antecedentes y problemática](report/12-solution-profile.md#121-antecedentes-y-problemática)
  - [1.2.2. Lean UX Process](report/12-solution-profile.md#122-lean-ux-process)
- [1.3. Segmentos objetivo](report/13-target-segments.md#13-segmentos-objetivo)

### Capítulo II: Requirements Elicitation & Analysis
- [2.1. Competidores](report/21-competitors.md#21-competidores)
  - [2.1.1. Análisis competitivo](report/21-competitors.md#211-análisis-competitivo)
  - [2.1.2. Estrategias y tácticas frente a competidores](report/21-competitors.md#212-estrategias-y-tácticas-frente-a-competidores)
- [2.2. Entrevistas](report/22-interviews.md#22-entrevistas)
  - [2.2.1. Diseño de entrevistas](report/22-interviews.md#221-diseño-de-entrevistas)
  - [2.2.2. Registro de entrevistas](report/22-interviews.md#222-registro-de-entrevistas)
  - [2.2.3. Análisis de entrevistas](report/22-interviews.md#223-análisis-de-entrevistas)
- [2.3. Needfinding](report/23-needfinding.md#23-needfinding)
  - [2.3.1. User Personas](report/23-needfinding.md#231-user-personas)
  - [2.3.2. User Task Matrix](report/23-needfinding.md#232-user-task-matrix)
  - [2.3.3. User Journey Mapping](report/23-needfinding.md#233-user-journey-mapping)
  - [2.3.4. Empathy Mapping](report/23-needfinding.md#234-empathy-mapping)
- [2.4. Big Picture EventStorming](report/24-big-picture-eventstorming.md#24-big-picture-eventstorming)
- [2.5. Ubiquitous Language](report/25-ubiquitous-language.md#25-ubiquitous-language)

### Capítulo III: Requirements Specification
- [3.1. User Stories](report/31-user-stories.md#31-user-stories)
- [3.2. Impact Mapping](report/32-impact-mapping.md#32-impact-mapping)
- [3.3. Product Backlog](report/33-product-backlog.md#33-product-backlog)

### Capítulo IV: Product Design
- [4.1. Style Guidelines](report/41-style-guidelines.md#41-style-guidelines)
- [4.2. Information Architecture](report/42-information-architecture.md#42-information-architecture)
- [4.3. Landing Page UI Design](report/43-landing-page-ui-design.md#43-landing-page-ui-design)
- [4.4. Web Applications UX/UI Design](report/44-web-application-uxui-design.md#44-web-applications-uxui-design)
- [4.5. Web Applications Prototyping](report/45-web-application-prototyping.md#45-web-applications-prototyping)
- [4.6. Domain-Driven Software Architecture (C4 Model & DLES)](report/46-dd-software-architecture.md#46-domain-driven-software-architecture)
- [4.7. Software Object-Oriented Design (UML Class Diagrams)](report/47-software-object-oriented-design.md#47-software-object-oriented-design)
- [4.8. Database Design (MySQL 8.0 InnoDB & UUIDv7)](report/48-database-design.md#48-database-design)

### Capítulo V: Product Implementation, Validation & Deployment
- [5.1. Software Configuration Management](report/51-software-configuration-management.md#51-software-configuration-management)
- [5.2. Landing Page, Services & Applications Implementation](report/52-landingpage-services-implementations.md#52-landing-page-services--applications-implementation)
  - [5.2.1. Sprint 1 (AV1)](report/52-landingpage-services-implementations.md#521-sprint-1)
  - [5.2.2. Sprint 2 (TB1)](report/52-landingpage-services-implementations.md#522-sprint-2)

- [5.3. Validation Interviews](report/53-validation-interviews.md#53-validation-interviews)

### Cierre y Anexos
- [Conclusiones y Recomendaciones](report/61-conclusions.md#conclusiones-y-recomendaciones)
- [Video About-the-Team](report/62-video-about-the-team.md#video-about-the-team)
- [Bibliografía (BibTeX / APA)](report/99-bibliography.md#bibliografía)
- [Anexo A. Repositorios Oficiales y Despliegues en la Nube](report/annexes/annex-a-repositories-and-deployments.md)
- [Anexo B. Tableros Digitales y Prototipos Interactivos](report/annexes/annex-b-collaborative-boards-and-prototypes.md)
- [Anexo C. Grabaciones Audiovisuales y Entrevistas a Profundidad](report/annexes/annex-c-audiovisual-records.md)
