# 5.2. Landing Page & Services Implementations

## 5.2.1. Sprint 1

En este apartado se detalla la planificación, asignación de responsabilidades y desglose de tareas técnicas para la ejecución del primer ciclo de desarrollo (Sprint 1) del ecosistema **NeonCode**.

---

### 5.2.1.1. Sprint Planning 1

El **Sprint Planning 1** define los objetivos tácticos, el alcance y la velocidad comprometida por el equipo para el primer ciclo de desarrollo. El foco principal de este sprint consiste en establecer la arquitectura base, implementar la autenticación segura en la API RESTful, habilitar el registro de instituciones de salud y construir el sitio web corporativo (Landing Page).

* **Objetivo del Sprint (Sprint Goal):** Construir la infraestructura base de servicios de autenticación e identidad de la API RESTful, habilitar el registro de instituciones de salud en la aplicación web administrativa y desplegar el sitio web corporativo (Landing Page) para presentar la propuesta de valor y capturar prospectos.
* **Duración:** 2 semanas.
* **Velocidad Planificada:** 16 Story Points.
* **Historias de Usuario Seleccionadas:** `US01`, `US02`, `US03`, `US04`, `US05`, `US06`.

---

### 5.2.1.2. Matriz LACX del Sprint 1

La matriz **LACX** (Lead, Assignee, Complexity, eXpense) define los roles de liderazgo, ejecución técnica, complejidad estimada y esfuerzo relativo asignado a cada integrante del equipo para el cumplimiento de las historias de usuario del Sprint 1.

* **L (Lead):** Integrante responsable de liderar la revisión técnica, arquitectura y calidad del entregable.
* **A (Assignee):** Integrante encargado de la codificación, implementación y ejecución de las pruebas.
* **C (Complexity):** Complejidad técnica atribuida al desarrollo de la historia (Baja, Media, Alta).
* **X (eXpense):** Esfuerzo relativo expresado en Story Points según la escala de Fibonacci (1, 2, 3, 5).

| User Story ID | Título de la Historia | Lead (L) | Assignee (A) | Complexity (C) | eXpense / Points (X) |
| :---: | :--- | :--- | :--- | :---: | :---: |
| **US03** | Endpoint de Autenticación de Usuarios (API) | Renzo Santos | Aaron Espinoza | Media | 5 |
| **US01** | Registro de Institución de Salud | Jhon Jaramillo | Renzo Santos | Media | 3 |
| **US02** | Autenticación de Personal de Emergencia | Santiago Gargate | Maria Munayco | Baja | 3 |
| **US04** | Exploración de Propuesta de Valor Logística | Maria Munayco | Santiago Gargate | Baja | 2 |
| **US05** | Solicitud de Demostración Corporativa | Aaron Espinoza | Jhon Jaramillo | Baja | 2 |
| **US06** | Consulta de Preguntas Frecuentes | Santiago Gargate | Maria Munayco | Baja | 1 |

---

### 5.2.1.3. Sprint Backlog 1

El **Sprint Backlog 1** presenta el desglose detallado de tareas técnicas necesarias para completar los criterios de aceptación de cada historia de usuario, incluyendo las estimaciones en horas de esfuerzo individual y el estado de desarrollo inicial.

| User Story ID | Tareas Técnicas (Technical Tasks) | Estimación (Horas) | Estado Inicial |
| :---: | :--- | :---: | :---: |
| **US03** | • Configuración inicial del proyecto Node.js/Express con TypeScript.<br>• Creación del modelo de datos de usuario e institución con cifrado de clave mediante la biblioteca `bcrypt`.<br>• Implementación del servicio y controlador para el endpoint POST `/api/v1/authentication/sign-in`.<br>• Implementación de la generación y validación de tokens JWT para el manejo de sesiones.<br>• Redacción de pruebas unitarias para validar respuestas HTTP 200 y 401. | 14 h | To Do |
| **US01** | • Diseño y maquetación del formulario de registro institucional en la aplicación web frontend.<br>• Implementación de validaciones en el cliente para los campos de datos corporativos.<br>• Integración con la API RESTful para el envío del formulario de registro. | 10 h | To Do |
| **US02** | • Diseño y maquetación de la vista de inicio de sesión para el personal médico de emergencias.<br>• Manejo del estado global de autenticación en el frontend y almacenamiento seguro del token JWT.<br>• Configuración de rutas protegidas y redirección al panel de monitoreo. | 8 h | To Do |
| **US04** | • Maquetación HTML5/CSS3 con TailwindCSS del sitio web principal (Landing Page).<br>• Diseño de la sección de propuesta de valor sobre la conservación de la cadena de frío.<br>• Optimización de diseño responsive para dispositivos móviles y de escritorio. | 6 h | To Do |
| **US05** | • Maquetación del formulario interactivo de solicitud de demostración corporativa.<br>• Validación de requisitos de entrada en los campos de datos de contacto.<br>• Conexión con servicio backend para el despacho de correos de confirmación. | 6 h | To Do |
| **US06** | • Maquetación de la sección acordeón de preguntas frecuentes (FAQ) en el Landing Page.<br>• Integración de las respuestas informativas sobre especificaciones del contenedor inteligente y conectividad IoT. | 4 h | To Do |

**Resumen del Sprint Backlog 1:**
* **Total de Historias de Usuario:** 6 historias.
* **Puntos de Historia Totales (Story Points):** 16 SP.
* **Horas Totales Estimadas:** 48 horas de trabajo técnico.
