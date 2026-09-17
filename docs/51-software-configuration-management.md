# 5.1. Software Configuration Management

En esta sección se detallan la configuración del entorno de desarrollo, la estrategia de gestión del código fuente, las convenciones de estilo adoptadas por el equipo de desarrollo de **NeonCode** y la infraestructura empleada para el despliegue del sistema de supervisión de contenedores médicos inteligentes.

---

### 5.1.1. Software Development Environment Configuration

Para garantizar un flujo de trabajo uniforme y minimizar discrepancias entre las estaciones de trabajo de los miembros del equipo, se ha estandarizado la configuración del entorno de desarrollo:

* **Entornos de Desarrollo Integrados (IDE):**
    * **JetBrains WebStorm:** Entorno principal utilizado para el desarrollo, maquetación y pruebas del sitio web corporativo (Landing Page) y la aplicación web administrativa frontend. Se han configurado complementos como *GitFlowHelper*, *Prettier* y *ESLint*.
    * **Visual Studio Code / IntelliJ IDEA:** Utilizados para el desarrollo y depuración de los microservicios backend de la API RESTful.
* **Entorno de Ejecución (Runtime) y Lenguajes:**
    * **Node.js (v20.x LTS):** Entorno de ejecución JavaScript del lado del servidor para los servicios web de la API.
    * **TypeScript (v5.x):** Lenguaje tipado adoptado en el frontend para garantizar el control de tipos en la manipulación de estados y datos de telemetría.
    * **HTML5, CSS3 y TailwindCSS:** Estándares empleados para el diseño responsive y accesible de las aplicaciones web.
* **Gestor de Paquetes y Depósitos de Software:**
    * **npm (v10.x):** Gestor de paquetes utilizado para la administración, auditoría de seguridad e instalación de las bibliotecas del proyecto.

---

### 5.1.2. Source Code Management

La gestión del código fuente de **NeonCode** se realiza a través de **Git** como sistema de control de versiones distribuido, centralizado en la organización de **GitHub** (`NeonCode-UPC/report`).

#### Estrategia de Ramificación (GitFlow)

El equipo aplica la estrategia **GitFlow** para mantener un desarrollo aislado, seguro y estructurado:

* **`main`:** Rama de producción que almacena exclusivamente código estable, verificado y listo para el despliegue final.
* **`develop`:** Rama de integración continua donde se consolidan todas las funcionalidades completadas durante el desarrollo de los sprints.
* **`feature/<nombre-funcionalidad>`:** Ramas de trabajo temporal creadas a partir de `develop` para la construcción de historias de usuario o secciones específicas (ejemplo: `feature/us01-registro-institucion` o `feature/capitulo-1`).
* **`release/<version>`:** Ramas de preparación creadas antes de un despliegue importante para pruebas finales de integración.
* **`hotfix/<nombre-incidencia>`:** Ramas de emergencia creadas directamente desde `main` para solventar errores críticos en el entorno de producción.

#### Flujo de Comandos GitFlow

```bash
# Iniciar una rama de funcionalidad desde develop
git flow feature start us01-registro-institucion

# Publicar la rama en el repositorio remoto de GitHub
git flow feature publish us01-registro-institucion

# Finalizar la funcionalidad e integrar los cambios en develop
git flow feature finish us01-registro-institucion
```
## 5.1.3. Source Code Style Guide & Conventions

Para mantener la calidad, legibilidad y mantenibilidad del código fuente en el repositorio de **NeonCode**, el equipo de desarrollo sigue guías de estilo estandarizadas y convenciones de control de versiones.

### Guía de Estilo de Código Fuente

* **Estándar de Formato:** Se utiliza **Prettier** y **ESLint** para el análisis estático de código y formateo automático en la aplicación web frontend (React con TypeScript) y los servicios de la API RESTful.
* **Convenciones de Nomenclatura:**
    * **Variables y Funciones:** Se utiliza `camelCase` (ejemplo: `containerTemperature`, `calculateEstimatedArrival`).
    * **Componentes y Clases:** Se utiliza `PascalCase` (ejemplo: `TelemetryDashboard`, `ContainerService`).
    * **Archivos y Directorios:** Se utiliza `kebab-case` para nombres de archivos y carpetas (ejemplo: `container-monitoring.component.tsx`, `3.1-user-stories.md`).
    * **Constantes Globales:** Se utiliza `UPPER_SNAKE_CASE` (ejemplo: `MAX_CRITICAL_TEMPERATURE`, `DEFAULT_TIMEOUT`).
* **Terminología Normada (Anexo E):** Queda estrictamente prohibido el uso de *spanglish* o términos no reconocidos académicamente. Se debe emplear de manera exclusiva:
    * **Requisito** en lugar de "requerimiento".
    * **Biblioteca** en lugar de "librería".
    * **Aplicación** en lugar de "app".

### Convención de Mensajes de Confirmación (Conventional Commits)

Todas las confirmaciones de cambios (commits) realizadas en el repositorio de GitHub deben cumplir obligatoriamente con el estándar **Conventional Commits**:

**Estructura del Mensaje:**
`<tipo>(<alcance>): <descripción corta en tiempo presente>`

* **`feat`:** Incorporación de una nueva funcionalidad (ejemplo: `feat(auth): add JWT sign-in endpoint`).
* **`fix`:** Corrección de un fallo o error en el código (ejemplo: `fix(telemetry): correct temperature parser logic`).
* **`docs`:** Cambios o adiciones exclusivamente en archivos de documentación Markdown (ejemplo: `docs(ch5): add code conventions and deployment configuration`).
* **`style`:** Ajustes de formato, espacios o estilos CSS que no alteran la lógica de negocio (ejemplo: `style(landing): fix container card padding`).
* **`refactor`:** Reestructuración interna del código que no añade funcionalidades ni corrige errores (ejemplo: `refactor(api): optimize database connection pooling`).
* **`test`:** Adición o actualización de pruebas unitarias o de integración (ejemplo: `test(auth): add unit test for sign-in service`).

---

## 5.1.4. Software Deployment Configuration

El proceso de despliegue del sistema de supervisión de contenedores médicos inteligentes de **NeonCode** se organiza en tres entornos aislados para garantizar la estabilidad operativa de la plataforma.

### Entornos de Despliegue

| Entorno | Propósito | Plataforma / Hosting | Rama Git Asociada | Configuración y Acceso |
| :--- | :--- | :--- | :--- | :--- |
| **Local (Development)** | Entorno de desarrollo individual para codificación, depuración y pruebas unitarias. | Servidor local Vite / Node.js (`localhost:5173` / `localhost:3000`) | Rama de trabajo (`feature/*`) | Acceso exclusivo del equipo de desarrollo. |
| **Staging (Testing)** | Entorno de integración continua para pruebas de calidad (QA) y validación de entregables de sprint. | Vercel (Frontend) / Render (API RESTful Backend) | `develop` | Despliegue automático ante cada *pull request* integrado. |
| **Production (Live)** | Entorno final de alta disponibilidad donde opera la solución para supervisores hospitalarios y personal médico. | Vercel Production / AWS App Runner | `main` | Despliegue automatizado mediante pipelines de CI/CD tras la consolidación de entregas (*releases*). |

### Gestión de Variables de Entorno y Configuración

* **Archivos `.env`:** Todas las claves de API, cadenas de conexión a base de datos y tokens de autenticación se gestionan mediante variables de entorno en archivos `.env.local` y no se suben al repositorio.
* **Secretos en Plataforma:** Las claves de producción se configuran directamente en el panel de administración de Vercel y Render, garantizando la seguridad de la cadena de custodia de datos.