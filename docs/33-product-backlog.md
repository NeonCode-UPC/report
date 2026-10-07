# 3.3. Product Backlog

En esta sección se presenta el **Product Backlog** priorizado para la plataforma **NeonCode**, estructurado a partir de las 18 historias de usuario definidas previamente. Las historias han sido estimadas utilizando la técnica de **Planning Poker** basada en la secuencia de Fibonacci (1, 2, 3, 5, 8, 13) para reflejar la complejidad, esfuerzo y nivel de incertidumbre de cada entregable.

El backlog se encuentra organizado secuencialmente para guiar el desarrollo de los Sprints del proyecto, priorizando la arquitectura base, autenticación y servicios de ingesta IoT antes de los paneles de visualización y reportes avanzados.

| Order / Priority | Epic ID | User Story ID | Título de la Historia | Story Points (Fibonacci) | Sprint Asignado |
| :---: | :---: | :---: | :--- | :---: | :---: |
| **01** | EP01 | **US03** | Endpoint de Autenticación de Usuarios (API) | 5 | Sprint 1 |
| **02** | EP01 | **US01** | Registro de Institución de Salud | 3 | Sprint 1 |
| **03** | EP01 | **US02** | Autenticación de Personal de Emergencia | 3 | Sprint 1 |
| **04** | EP02 | **US04** | Exploración de Propuesta de Valor Logística | 2 | Sprint 1 |
| **05** | EP02 | **US05** | Solicitud de Demostración Corporativa | 2 | Sprint 1 |
| **06** | EP02 | **US06** | Consulta de Preguntas Frecuentes | 1 | Sprint 1 |
| **07** | EP03 | **US09** | Ingesta de Telemetría IoT (API) | 8 | Sprint 2 |
| **08** | EP03 | **US07** | Alta de Unidades de Ambulancia | 3 | Sprint 2 |
| **09** | EP03 | **US08** | Vinculación de Contenedor Inteligente | 5 | Sprint 2 |
| **10** | EP04 | **US12** | Consulta de Telemetría e Indicadores (API) | 5 | Sprint 2 |
| **11** | EP04 | **US10** | Monitoreo Térmico y de Apertura | 8 | Sprint 2 |
| **12** | EP04 | **US11** | Control de Stock por Sensores de Peso | 8 | Sprint 3 |
| **13** | EP05 | **US13** | Configuración de Umbrales Térmicos Críticos | 3 | Sprint 3 |
| **14** | EP05 | **US15** | Servicio de Despacho de Alertas (API) | 5 | Sprint 3 |
| **15** | EP05 | **US14** | Visualización de Alertas en Ruta | 5 | Sprint 3 |
| **16** | EP06 | **US18** | Consulta de Historial de Traslados (API) | 5 | Sprint 4 |
| **17** | EP06 | **US16** | Generación de Reportes de Trazabilidad | 8 | Sprint 4 |
| **18** | EP06 | **US17** | Confirmación de Entrega y Cadena de Custodia | 3 | Sprint 4 |

***

### 3.3.1. Engineering Tasks

A continuación se detalla el desglose del **Sprint 1** (16 Story Points totales) en tareas de ingeniería (*Engineering Tasks*). Cada tarea ha sido acotada a una duración estimada de **entre 4 y 8 horas**, asegurando la manejabilidad técnica dentro de la iteración.

#### **US04: Exploración de Propuesta de Valor Logística (2 SP)**
* **TSK-04-01:** Maquetación responsive de la sección "Soluciones Logísticas" en el Landing Page (HTML5 / Tailwind CSS). **[6 Horas]**
* **TSK-04-02:** Integración de componentes visuales interactivos para especificaciones técnicas del contenedor inteligente. **[4 Horas]**

#### **US05: Solicitud de Demostración Corporativa (2 SP)**
* **TSK-05-01:** Desarrollo del formulario de contacto para clientes corporativos con validación de campos en cliente (JavaScript/TypeScript). **[5 Horas]**
* **TSK-05-02:** Configuración del servicio backend/mailing para la recepción y reenvío de prospectos a ventas. **[6 Horas]**

#### **US06: Consulta de Preguntas Frecuentes (1 SP)**
* **TSK-06-01:** Implementación del componente acordeón de FAQ y buscador por palabra clave en el Landing Page. **[4 Horas]**

#### **US01: Registro de Institución de Salud (3 SP)**
* **TSK-01-01:** Diseño y maquetación del formulario web de registro institucional hospitalario. **[5 Horas]**
* **TSK-01-02:** Creación de endpoints en API REST para recepción de datos de registro y validación de RUC duplicado. **[7 Horas]**
* **TSK-01-03:** Implementación del servicio de envío de correos electrónicos de confirmación de cuenta. **[4 Horas]**

#### **US07: Alta de Unidades de Ambulancia (3 SP)**
* **TSK-07-01:** Creación del modelo de datos de Ambulancias en la base de datos MySQL Server 8.0 (InnoDB) mediante Entity Framework Core 10.0. **[4 Horas]**
* **TSK-07-02:** Desarrollo de endpoints CRUD para el registro y consulta de vehículos de transporte. **[6 Horas]**
* **TSK-07-03:** Interfaz web para el formulario de registro y lista de unidades registradas. **[6 Horas]**

#### **US08: Vinculación de Contenedor Inteligente (5 SP)**
* **TSK-08-01:** Desarrollo del módulo backend de asignación física (relación 1:1 entre ambulancia y contenedor IoT). **[8 Horas]**
* **TSK-08-02:** Validación de estados del dispositivo (bloqueo de reasignación si está ocupado). **[5 Horas]**
* **TSK-08-03:** Interfaz web para vinculación mediante lectura o digitación del UUID/MAC del contenedor. **[6 Horas]**