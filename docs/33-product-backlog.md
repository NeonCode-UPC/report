# 3.3. Product Backlog

En esta sección se presenta el **Product Backlog** priorizado para la plataforma **NeonCode (Medical SmartBox)**, estructurado a partir de las 18 historias de usuario y técnicas definidas previamente. Las historias han sido estimadas utilizando la técnica de **Planning Poker** basada en la secuencia de Fibonacci (1, 2, 3, 5, 8, 13) para reflejar la complejidad, esfuerzo y nivel de incertidumbre de cada entregable.

El backlog se encuentra organizado secuencialmente bajo un criterio estricto de **valor de negocio para nuestros segmentos objetivo**, iniciando con la difusión comercial y captación de prospectos institucionales (*Landing Page*), seguido del onboarding hospitalario y los servicios de monitoreo IoT, aprovisionamiento, alertas críticas y cadena de custodia.

| Order / Priority | Epic ID | User Story ID | Título de la Historia | Descripción | Story Points (Fibonacci) | Sprint Asignado |
| :---: | :---: | :---: | :--- | :--- | :---: | :---: |
| **01** | EP02 | **US04** | Exploración de Propuesta de Valor Logística | Como visitante comercial institucional (Gianfranco Timoteo), deseo consultar las capacidades de los contenedores inteligentes en el Landing Page para evaluar su implementación. | 2 | Sprint 1 |
| **02** | EP02 | **US05** | Solicitud de Demostración Corporativa | Como visitante comercial institucional (Gianfranco Timoteo), deseo enviar un formulario de contacto para solicitar una demostración del sistema en mi centro hospitalario. | 2 | Sprint 1 |
| **03** | EP02 | **US06** | Consulta de Preguntas Frecuentes | Como visitante comercial institucional (Gianfranco Timoteo), deseo revisar la sección de FAQ en el Landing Page para resolver dudas sobre la integración IoT en ambulancias. | 1 | Sprint 1 |
| **04** | EP01 | **US01** | Registro de Institución de Salud | Como supervisor hospitalario (Gianfranco Timoteo), deseo registrar mi centro médico en la plataforma NeonCode para gestionar la flota de ambulancias y contenedores. | 3 | Sprint 1 |
| **05** | EP01 | **US02** | Autenticación de Personal de Emergencia | Como personal médico de emergencia (Aldair Lazaro), deseo autenticarme en la aplicación web para acceder al estado de la carga transportada en tiempo real. | 3 | Sprint 1 |
| **06** | EP01 | **US03** | Endpoint de Autenticación de Usuarios (API) | Como Developer, deseo disponer de un endpoint POST `/api/v1/authentication/sign-in` para validar credenciales y emitir tokens de sesión. | 5 | Sprint 1 |
| **07** | EP03 | **US07** | Alta de Unidades de Ambulancia | Como operador logístico de salud (Gianfranco Timoteo), deseo registrar y habilitar matrículas de vehículos de transporte en el sistema para asociarles contenedores de insumos en despachos activos. | 3 | Sprint 2 |
| **08** | EP03 | **US08** | Vinculación de Contenedor Inteligente | Como operador logístico de salud (Gianfranco Timoteo), deseo vincular un contenedor IoT (`SmartContainer`) a una ambulancia específica en un despacho médico (`DispatchTrip`) para iniciar la supervisión de la carga. | 5 | Sprint 2 |
| **09** | EP04 | **US10** | Monitoreo Térmico y de Apertura | Como personal médico de emergencia (Aldair Lazaro), deseo consultar la temperatura interna y el estado de apertura del contenedor para garantizar la cadena de frío. | 8 | Sprint 2 |
| **10** | EP03 | **US09** | Ingesta de Telemetría IoT (API) | Como Developer, deseo contar con un endpoint POST `/api/v1/containers/{containerId}/telemetry` para registrar datos térmicos y de estado. | 8 | Sprint 2 |
| **11** | EP04 | **US12** | Consulta de Telemetría e Indicadores (API) | Como Developer, deseo disponer de un endpoint GET `/api/v1/containers/{containerId}/metrics` para alimentar la vista del panel web. | 5 | Sprint 2 |
| **12** | EP04 | **US11** | Control de Stock por Sensores de Peso | Como personal médico de emergencia (Aldair Lazaro), deseo verificar la disponibilidad de insumos mediante sensores de peso para confirmar existencias. | 8 | Sprint 3 |
| **13** | EP05 | **US13** | Configuración de Umbrales Térmicos Críticos | Como supervisor hospitalario (Gianfranco Timoteo), deseo establecer rangos de temperatura permitidos para recibir avisos preventivos ante desviaciones. | 3 | Sprint 3 |
| **14** | EP05 | **US14** | Visualización de Alertas en Ruta | Como operador logístico de salud (Gianfranco Timoteo), deseo recibir avisos de variaciones térmicas o retrasos para tomar acciones correctivas inmediatas. | 5 | Sprint 3 |
| **15** | EP05 | **US15** | Servicio de Despacho de Alertas (API) | Como Developer, deseo contar con un endpoint POST `/api/v1/alerts/dispatch` para procesar notificaciones de emergencia. | 5 | Sprint 3 |
| **16** | EP06 | **US16** | Generación de Reportes de Trazabilidad | Como supervisor hospitalario (Gianfranco Timoteo), deseo exportar el informe del traslado médico para certificar el cumplimiento de la cadena de frío. | 8 | Sprint 4 |
| **17** | EP06 | **US17** | Confirmación de Entrega y Cadena de Custodia | Como personal médico de emergencia (Aldair Lazaro), deseo registrar la recepción del contenedor para cerrar la cadena de custodia del envío. | 3 | Sprint 4 |
| **18** | EP06 | **US18** | Consulta de Historial de Traslados (API) | Como Developer, deseo disponer de un endpoint GET `/api/v1/transfers/{transferId}/audit` para recuperar el registro de auditoría. | 5 | Sprint 4 |

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
