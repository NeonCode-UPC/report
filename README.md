# Medical SMARTBOX — NeonCode Report

Repositorio documental bajo arquitectura **Docs-as-Code** del startup **NeonCode** y su solución **Medical SMARTBOX** para el curso `1ASI0730` Aplicaciones Web (NRC `8150`) — Ingeniería de Software, UPC.

El informe técnico modular está disponible en [`report/`](report/), los recursos gráficos y diagramas como código en [`assets/`](assets/), y el historial de versiones semánticas en [`CHANGELOG.md`](CHANGELOG.md).

## Estructura del Repositorio

```text
.
├── .github/workflows/build-report.yml       # CI/CD: compilación PDF y publicación automática en Releases
├── assets/                                  # Activos gráficos y fuentes de diagramas (.puml, .mmd)
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

- **Preliminares (`report/front-matter/`):** [Carátula](report/front-matter/01-cover.md) · [Registro de Versiones](report/front-matter/02-version-history.md) · [Collaboration Insights](report/front-matter/03-collaboration-insights.md) · [Tabla de Contenido](report/front-matter/04-table-of-contents.md) · [Student Outcome 5](report/front-matter/05-student-outcome.md)
- **Capítulo I — Introducción:** [1.1 Startup Profile](report/11-startup-profile.md) · [1.2 Solution Profile](report/12-solution-profile.md) · [1.3 Target Segments](report/13-target-segments.md)
- **Capítulo II — Requirements Elicitation & Analysis:** [2.1 Competitors](report/21-competitors.md) · [2.2 Interviews](report/22-interviews.md) · [2.3 Needfinding](report/23-needfinding.md) · [2.4 Big Picture EventStorming](report/24-big-picture-eventstorming.md) · [2.5 Ubiquitous Language](report/25-ubiquitous-language.md)
- **Capítulo III — Requirements Specification:** [3.1 User Stories](report/31-user-stories.md) · [3.2 Impact Mapping](report/32-impact-mapping.md) · [3.3 Product Backlog](report/33-product-backlog.md)
- **Capítulo IV — Product Design:** [4.1 Style Guidelines](report/41-style-guidelines.md) · [4.2 Information Architecture](report/42-information-architecture.md) · [4.3 Landing Page UI](report/43-landing-page-ui-design.md) · [4.4 Web App UX/UI](report/44-web-application-uxui-design.md) · [4.5 Prototyping](report/45-web-application-prototyping.md) · [4.6 DDD & C4 Architecture](report/46-dd-software-architecture.md) · [4.7 OO Design](report/47-software-object-oriented-design.md) · [4.8 Database Design](report/48-database-design.md)
- **Capítulo V — Implementation, Validation & Deployment:** [5.1 Software Configuration Management](report/51-software-configuration-management.md) · [5.2 Landing Page, Services & Apps Implementation](report/52-landingpage-services-implementations.md)
- **Cierre y Anexos:** [Conclusiones](report/61-conclusions.md) · [Bibliografía](report/99-bibliography.md) · [Anexo A](report/annexes/annex-a-repositories-and-deployments.md) · [Anexo B](report/annexes/annex-b-collaborative-boards-and-prototypes.md) · [Anexo C](report/annexes/annex-c-audiovisual-records.md)
