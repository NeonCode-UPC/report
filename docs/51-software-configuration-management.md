# 5.1. Software Configuration Management

En esta sección se detallan la configuración del entorno de desarrollo, la estrategia de gestión del código fuente, las convenciones de estilo adoptadas por el equipo de desarrollo de **NeonCode** y la infraestructura empleada para el despliegue del sistema de supervisión de contenedores médicos inteligentes conforme a las exigencias oficiales de la asignatura.

---

### 5.1.1. Software Development Environment Configuration

Para garantizar un flujo de trabajo uniforme y minimizar discrepancias entre las estaciones de trabajo de los miembros del equipo, se ha estandarizado la configuración del entorno de desarrollo alineada estrictamente con el stack tecnológico normado por el curso:

* **Entornos de Desarrollo Integrados (IDE):**
    * **Visual Studio 2022 / JetBrains Rider / VS Code:** Entornos principales utilizados para el desarrollo, compilación y pruebas de los servicios backend en **ASP.NET Core 10.0 (.NET 10 LTS)** en lenguaje **C#**, con soporte para Entity Framework Core y Swagger UI.
    * **JetBrains WebStorm / VS Code:** Utilizados para el maquetado semántico del Landing Page corporativo (HTML5, CSS3, JavaScript) y el desarrollo de la aplicación web frontend en **Vue 3** con la biblioteca de componentes **PrimeVue**.
* **Entorno de Ejecución (Runtime), Frameworks y Lenguajes:**
    * **.NET 10 LTS (`net10.0`) y C#:** Framework y lenguaje oficial del lado del servidor para el desarrollo de los servicios web bajo estilo arquitectónico RESTful API y el servicio en segundo plano de ingesta telemática IoT (`BackgroundService`).
    * **Vue Framework (Vue 3) con PrimeVue:** Framework frontend y biblioteca de componentes basados en **Material Design** para la construcción de las Web Applications reactivas.
    * **HTML5 semántico, CSS3 modular y JavaScript (ES6+):** Estándares de la W3C empleados para el diseño responsive, accesible (WCAG) y optimizado para SEO del Landing Page institucional.
    * **Node.js (v20.x LTS) y Vite:** Entorno de soporte de herramientas para compilación rápida y empaquetado de assets frontend.
* **Gestor de Paquetes y Depósitos de Software:**
    * **NuGet:** Gestor oficial de dependencias y paquetes para la solución ASP.NET Core (`Microsoft.EntityFrameworkCore`, `Swashbuckle.AspNetCore`, `BCrypt.Net-Next`).
    * **npm (v10.x):** Gestor de paquetes empleado para la administración de bibliotecas y plugins de desarrollo frontend.

---

### 5.1.2. Source Code Management

La gestión del código fuente de **NeonCode** se realiza a través de **Git** como sistema de control de versiones distribuido, centralizado en la organización oficial de **GitHub** (`NeonCode-UPC`).

#### Estrategia de Ramificación (GitFlow)

El equipo aplica rigurosamente el modelo de ramificación **GitFlow** para asegurar un desarrollo ordenado y auditable:

* **`main`:** Rama de producción que almacena exclusivamente código estable, verificado y desplegado para las revisiones oficiales de hito.
* **`develop`:** Rama de integración continua donde se consolidan todas las funcionalidades completadas durante los sprints.
* **`feature/<nombre-funcionalidad>`:** Ramas de trabajo temporal creadas a partir de `develop` para el desarrollo de historias de usuario o módulos específicos (ejemplo: `feature/landing-alerts-section`).
* **`release/<version>`:** Ramas de preparación creadas antes de la entrega de un hito oficial para congelamiento de código y pruebas finales.
* **`hotfix/<incidencia>`:** Ramas creadas directamente desde `main` para resolver contingencias críticas.

#### Flujo de Comandos GitFlow

```bash
# Iniciar una rama de funcionalidad desde develop
git flow feature start landing-hero-section

# Publicar la rama en el repositorio remoto de GitHub
git flow feature publish landing-hero-section

# Finalizar la funcionalidad e integrar los cambios en develop
git flow feature finish landing-hero-section
```

---

## 5.1.3. Source Code Style Guide & Conventions

Para mantener la máxima calidad, legibilidad y mantenibilidad del código fuente, el equipo sigue guías de estilo estandarizadas en concordancia con las buenas prácticas de la industria:

### Guía de Estilo de Código Fuente

* **Estándar de Formato Backend (C# / .NET):** Se aplican las directrices oficiales *Microsoft C# Coding Conventions* y *ASP.NET Core Engineering Guidelines*. Análisis estático configurado mediante Roslyn Analyzers y editorconfig institucional:
    * Clases, interfaces, métodos y propiedades en `PascalCase` (ejemplo: `SmartContainer`, `ITelemetryService`, `RecordTelemetrySnapshot`).
    * Parámetros y variables locales en `camelCase` (ejemplo: `ambientTemperature`, `batteryLevel`).
    * Constantes en `PascalCase` según el estándar de Microsoft (ejemplo: `MaxCriticalTemperatureCelsius`).
* **Estándar de Formato Frontend (Vue.js / HTML / CSS / JS):** Se aplican *Prettier* y *ESLint* configurados bajo las reglas oficiales de la *Vue 3 Style Guide*:
    * Componentes Single-File (`.vue`) en `PascalCase` (ejemplo: `TelemetryCard.vue`, `AlertBanner.vue`).
    * Funciones y propiedades reactivas en `camelCase`.
    * Clases CSS bajo convención BEM simplificada y variables semánticas en `kebab-case`.
* **Terminología Normada (Anexo E de la Rúbrica):** Queda estrictamente prohibido el uso de traducciones erróneas o anglicismos mutados. Se utiliza rigurosamente:
    * **Requisito** en lugar de "requerimiento".
    * **Biblioteca** en lugar de "librería".
    * **Aplicación** en lugar de "aplicativo" o "app".
    * **Desplegar / Probar / Confirmar cambios** en lugar de "deployar", "testear" o "comitear".

### Convención de Mensajes de Confirmación (Conventional Commits)

Todos los commits en los repositorios de GitHub deben seguir obligatoriamente la especificación **Conventional Commits 1.0.0**:

`<tipo>(<alcance>): <descripción concisa en tiempo presente>`

* **`feat`:** Incorporación de una nueva funcionalidad visible para el usuario o API.
* **`fix`:** Corrección de un fallo o error funcional.
* **`docs`:** Cambios o adiciones exclusivamente en documentación o informes Markdown.
* **`style`:** Ajustes de formato, espaciado o estilos CSS sin alteración de lógica.
* **`refactor`:** Reestructuración interna de código sin cambio de comportamiento.
* **`test`:** Adición o actualización de pruebas unitarias o de integración.
* **`chore`:** Tareas de mantenimiento, configuración de build o dependencias.

---

## 5.1.4. Software Deployment Configuration

El despliegue de las soluciones de **NeonCode** se organiza en entornos aislados para asegurar la disponibilidad operativa y la integridad de las evidencias de revisión:

### Entornos de Despliegue

| Entorno | Propósito | Plataforma / Hosting | Rama Git Asociada | Configuración y Acceso |
| :--- | :--- | :--- | :--- | :--- |
| **Local (Development)** | Desarrollo individual, maquetado de vistas y pruebas de API. | Servidor local Vite (`localhost:5173`) / Kestrel .NET (`localhost:5000`) | `feature/*` | Acceso exclusivo de los integrantes de desarrollo. |
| **Staging (Testing / QA)** | Integración continua de funcionalidades completadas en sprint. | GitHub Pages / Vercel Preview | `develop` | Validación interna del equipo y revisión intermedia. |
| **Production (Live)** | Entorno oficial desplegado para evaluación académica y demostración B2B. | GitHub Pages / Vercel Production | `main` | Acceso público activo vía HTTPS: `https://neoncode-upc.github.io/landing-page/`. |

### Gestión de Variables de Entorno y Configuración

* **Archivos de Configuración:** En el backend se utiliza `appsettings.json` y `appsettings.Development.json` con sobreescritura mediante variables de entorno para cadenas de conexión seguras.
* **Variables Frontend:** Variables de configuración de endpoints (`VITE_API_BASE_URL`) centralizadas en archivos `.env` versionados como plantillas (`.env.example`), aislando tokens de producción.
