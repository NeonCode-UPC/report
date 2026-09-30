# 5.2. Landing Page & Services Implementations

## 5.2.1. Sprint 1

En este apartado se presentan las evidencias correspondientes al desarrollo realizado durante el Sprint 1, incluyendo los avances de implementación, ejecución de vistas, documentación de servicios, despliegue de la solución y colaboración del equipo mediante el control de versiones.

---

## 5.2.1.4. Development Evidence for Sprint Review

Durante el Sprint 1 se realizaron avances relacionados con la implementación de la solución web según el alcance definido. En esta sección se presentan los principales commits asociados al desarrollo del proyecto, evidenciando los cambios realizados por el equipo durante esta etapa.

| Repository | Branch | Commit ID | Commit Message | Commit Message Body | Committed on (Date) |
|---|---|---|---|---|---|
| landing-page-draft | main | a4f8fb1 | chore: initialize js directory structure | Se organizó la estructura inicial del directorio JavaScript para la implementación del Landing Page. | 17/09/2026 |
| landing-page-draft | main | b839d52 | chore: initial project setup and base design tokens | Se realizó la configuración inicial del proyecto y la definición de tokens base de diseño para establecer estilos reutilizables. | 17/09/2026 |

---

## 5.2.1.5. Execution Evidence for Sprint Review

Durante este Sprint se implementaron las principales vistas de la solución web, permitiendo validar la estructura visual y funcional de las interfaces desarrolladas.

A continuación, se presentan las capturas correspondientes a las vistas implementadas junto con el enlace de demostración del funcionamiento.

#### Video de Demostración de Navegación (Landing Page): [Ver video aquí](https://upcedupe-my.sharepoint.com/:v:/g/personal/u20211b556_upc_edu_pe/IQAX1igNY3mbRqGmWKucsjYmASJHJ3_4rrqXZmvxOTHGoaU?e=4wl9UP)

<img width="2028" height="1090" alt="Screenshot 2026-09-28 at 10 33 48 AM" src="https://github.com/user-attachments/assets/7c5733c4-086d-4fd7-8335-7a6b68b379a6" />

### Vista implementada: Landing Page Principal (Hero Section)

**Descripción:** Interfaz de inicio diseñada para captar la atención de empresas de transporte y operadores de cadena de frío. Presenta la propuesta de valor central de Medical SmartBox: el monitoreo, detección de incidencias y trazabilidad de transportes médicos en un solo lugar.
* 
**Componentes y Funcionalidades Clave:**
* **Barra de navegación funcional:** Menú interactivo con accesos directos a la plataforma, selector de idioma (ES/EN) y botones globales de autenticación (*Log in / Open the Web App*).
* **Propuesta de valor clara:** Título principal de alto impacto acompañado de una breve descripción del propósito del software.
* **Llamados a la acción (CTA):** Botones duales contrastados para redirigir rápidamente al usuario hacia la Web App o el formulario de ingreso.
<br>
<br>
<br>
<img width="669" height="588" alt="Screenshot 2026-09-28 at 10 46 46 AM" src="https://github.com/user-attachments/assets/42d285c0-2ff3-48f9-b89f-d21dc15bc4ff" /> 

### Vista implementada: Formulario de Inicio de Sesión (Login)

**Descripción:** Interfaz correspondiente al módulo de autenticación para la Web Application de Medical SmartBox. Permite el acceso restringido y seguro al personal autorizado (operadores logísticos y centros de salud) mediante credenciales corporativas corporativas.
* 
**Componentes Clave:** 
* **Campos de entrada validados:** Inputs específicos para Correo corporativo (`nombre@organizacion.com`) y Contraseña protegida de manera visual.
* **Botón de acción directa:** Botón estilizado con los colores de la marca para el envío y validación de las credenciales de usuario (*Iniciar sesión*).
* **Control de navegación:** Botón de cierre superior (X) para retornar a la Landing Page principal de manera intuitiva.
<br>
<br>
<br>
<img width="1061" height="894" alt="Screenshot 2026-09-28 at 11 06 33 AM" src="https://github.com/user-attachments/assets/22dc7b3b-5cc6-402a-b381-8ed8964b464b" />

### Vista implementada: Detalle de Monitoreo de Transporte en Tiempo Real

**Descripción:** Vista detallada de un transporte en tránsito activo. Centraliza todas las telemetrías críticas recopiladas por el hardware en una única interfaz unificada para el operador.
*
**Componentes Clave:**
* **Panel de Telemetría en Vivo:** Indicadores en tiempo real de Temperatura (5.2 °C), ETA, Nivel de Batería del SmartBox, Combustible, Peso y Estado de la Puerta.
* **Gráfico de Historial Térmico:** Gráfica lineal automatizada que contrasta las mediciones de las últimas 6 horas frente al rango seguro permitido (2 °C - 8 °C).
* **Metadatos de Operación:** Tarjetas informativas con los datos asignados del Conductor (M. Quispe) y la Placa del Vehículo (ABQ-742).
<br>
<br>
<br>

<img width="1078" height="704" alt="Screenshot 2026-09-28 at 11 16 31 AM" src="https://github.com/user-attachments/assets/59b725c5-d856-4195-bddc-5b4af7790860" />

### Vista implementada: Módulo de Gestión de Alertas e Incidencias
*(Arrastra aquí tu nueva imagen de alertas para que GitHub genere su propio enlace)*

**Descripción:** Interfaz de control en tiempo real orientada a la detección temprana de riesgos en la cadena de frío, permitiendo al equipo logístico tomar acciones de mitigación inmediatas antes de comprometer la integridad del producto médico.
*
* **Componentes Clave:**
* **Tarjeta de Incidencia Crítica:** Bloque dinámico que detalla de forma matemática el desvío térmico (8.7 °C detectados frente al rango esperado de 2-8 °C), la ubicación exacta (Panamericana Sur) y la marca de tiempo (13:42).
* **Gráfico de Monitoreo Lineal:** Visualización de la fluctuación de temperatura de las últimas horas para evaluar la gravedad de la anomalía.
* **Acciones de Mitigación:** Botones interactivos de respuesta rápida (*Revisar transporte* y *Ver historial*).
* **Feed Cronológico Histórico:** Listado lateral estructurado por prioridad de eventos y estados logísticos anteriores (Puerta abierta, Batería baja, Desvío resuelto, Entrega confirmada).
---

## 5.2.1.6. Services Documentation Evidence for Sprint Review

Durante este Sprint no se desarrollaron servicios web asociados al backend. La implementación estuvo enfocada en el desarrollo inicial del Landing Page frontend, mientras que la arquitectura de servicios fue definida como parte del diseño técnico del sistema en esta primera entrega.

---

## 5.2.1.7. Software Deployment Evidence for Sprint Review

Durante el Sprint 1 no se realizó un despliegue productivo de servicios backend ni aplicaciones web. La evidencia corresponde al entorno de desarrollo utilizado para validar los avances del Landing Page.

---

## 5.2.1.8. Team Collaboration Insights during Sprint

Durante el desarrollo del Sprint 1, el equipo utilizó GitHub como herramienta de control de versiones para organizar el trabajo mediante ramas y commits.

La gestión mediante ramas permitió separar los avances realizados por cada integrante, mientras que los commits facilitaron mantener un historial ordenado de los cambios realizados durante el desarrollo.

