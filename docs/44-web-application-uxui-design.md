# 4.4. Web Applications UX/UI Design

El diseño de experiencia de usuario (UX) y diseño de interfaz de usuario (UI) en la plataforma web de **Medical SMARTBOX** busca crear una herramienta digital intuitiva, accesible y altamente funcional para operadores logísticos, conductores de transporte médico y personal receptor en hospitales o farmacias. La UX se enfoca en comprender la urgencia y precisión requeridas en la cadena de frío, diseñando flujos de interacción eficientes para monitorear cargas térmicamente sensibles, reaccionar ante desvíos de temperatura y configurar sensores IoT sin fricción.

Por su parte, la UI se encarga del aspecto visual, estructurando de manera clara componentes complejos como dashboards telemétricos en tiempo real, trazabilidad por hitos de envío, gráficos de estabilidad térmica y sistemas de alertas predictivas. Un diseño UX/UI exitoso en Medical SMARTBOX fusiona una estética tecnológica limpia con la practicidad operativa, ofreciendo una experiencia fluida que transforma datos IoT masivos en decisiones logísticas rápidas que salvan vidas y evitan la merma de medicamentos.

---

### 4.4.1. Web Applications Wireframes

#### Wireframes para Desktop Browser
*   **Acceso y Autenticación Segura:** El flujo de inicio de sesión presenta un diseño *desktop* de dos columnas ("auth-shell"). La izquierda actúa como un panel informativo destacando la propuesta de valor ("Cadena de frío bajo custodia digital") y estadísticas de la flota, mientras que la derecha contiene el formulario de acceso institucional que solicita RUC/Correo y Contraseña. A esto le sigue una pantalla obligatoria de Verificación en Dos Pasos (2FA) mediante un código OTP de 6 dígitos.

![Autenticacion - Wireframe](../assets/chapter-4/autenticacion-wireframe.png)

*   **Núcleo Operativo - Dashboard Principal:** El Dashboard general organiza la vista del operador comenzando con una fila de KPIs (unidades en ruta, monitorizadas, alertas críticas y cumplimiento DIGEMID). En el cuerpo central, se emplea una estructura de cuadrícula (`grid-2`) que muestra un mapa de "Flota en tiempo real" a la izquierda y un panel consolidado de "Alertas críticas recientes" a la derecha, finalizando con una tabla inferior para los "Traslados en curso".

![Nucleo Operativo - Wireframe](../assets/chapter-4/nucleo-wireframe.png)

*   **Gestión de Envíos y Tablero de Despacho:** El sistema incluye una lista maestra de "Órdenes de traslado" y un formulario completo para crear una nueva orden validando ventana de isquemia fría y precooling. Además, presenta un Tablero de Despacho en formato Kanban que categoriza los viajes en Pendientes, Despachados, En tránsito y Entregados.

![Gestion de Envios - Wireframe](../assets/chapter-4/envios-wireframe.png)

*   **Vista Detallada de Telemetría y Ruta:** La inspección individual de un envío presenta un *stepper* de estado en la parte superior. Debajo, se divide en dos módulos: a la izquierda, el mapa de trazabilidad y ruta en vivo con cálculo de ETA dinámico; a la derecha, las tarjetas telemétricas y medidores (*gauges*) mostrando la temperatura interna en tiempo real (ej. 4.3°C), nivel de batería, estado de cierre y lecturas recientes.

![Vista de Ruta - Wireframe](../assets/chapter-4/ruta-wireframe.png)

*   **Monitoreo y Control de Smart Containers:** Se incluye un módulo visual tipo *grid* para monitorear todos los contenedores de la flota y una vista de detalle por Smart Container que incluye una curva gráfica de temperatura de las últimas 24 horas. Complementariamente, el sistema permite enviar comandos de desbloqueo remoto de la tapa mediante interacción electromecánica y visualizar el historial completo de excursiones térmicas.

![Monitoreo de Containers - Wireframe](../assets/chapter-4/containers-wireframe.png)

*   **Centro de Alertas y Respuesta a Incidentes:** La plataforma cuenta con una bandeja centralizada para gestionar notificaciones. El detalle de una alerta crítica expone la magnitud de la excursión térmica (temperatura, duración, ubicación), el registro temporal del despacho de alertas (vía SMS y Push) y una sección para que el operador documente las acciones correctivas.

![Centro de Alertas - Wireframe](../assets/chapter-4/incidentes-wireframe.png)

*   **Configuración y Umbrales de Alerta:** Una pantalla de administración dedicada a "Canales de notificación" permite al usuario activar/desactivar notificaciones Push, SMS, Correo y alarmas acústicas. Aquí mismo, en el panel "Umbrales de severidad", se configuran manualmente los límites máximos/mínimos de temperatura y los tiempos límite (SLA) para el envío de alertas.

![Umbrales de Alerta - Wireframe](../assets/chapter-4/alerta-wireframe.png)

*   **Cadena de Custodia, Manifiestos y Reportes:** El flujo de entrega garantiza la seguridad exigiendo la Verificación OTP en destino y trazando todos los eventos en una Línea de Tiempo de Cadena de Custodia. Administrativamente, se generan Manifiestos Digitales de Auditoría inmutables sellados con SHA-256 y se presenta un consolidado analítico para cumplimiento normativo DIGEMID/DIGDOT.

![Cadena de Custodia - Wireframe](../assets/chapter-4/custodia-wireframe.png)

*   **Administración Institucional y B2B:** La plataforma incluye la gestión integral de la suscripción, facturación B2B, vinculación de unidades vehiculares y el control granular de usuarios organizados en roles operativos de logística o perfiles clínicos.
   
![Administracion - Wireframe](../assets/chapter-4/administracion-wireframes.png)

#### Adaptabilidad de Wireframes para Mobile Browser
Para dispositivos móviles de campo (smartphones de personal asistencial y tabletas de ambulancia de 360px a 414px):
*   **Diseño de Columna Unificada (Single-Column Flow):** La disposición de dos columnas se transforma en un flujo vertical secuencial. En el detalle del traslado, el indicador de temperatura actual y la alerta de batería se colocan en la parte superior fija (*sticky banner*), seguidos del mapa simplificado y las lecturas telemétricas.
*   **Navegación Móvil por Barra Inferior (Bottom Navigation Bar):** Se reemplaza la barra lateral izquierda por una barra de navegación inferior de 5 accesos directos (*Dashboard*, *Ruta en Vivo*, *SmartBox*, *Alertas* y *Perfil*), facilitando la operación con una sola mano.
*   **Zona Táctil Aumentada para Emergencias:** Todos los controles críticos, en especial el botón de desbloqueo de emergencia y el teclado numérico en pantalla para validación de OTP, cuentan con dimensiones mínimas de 48x48px con alto contraste, permitiendo su uso rápido incluso con guantes clínicos.

---

### 4.4.2. Web Applications Wireflow Diagrams

El diagrama de wireflow documenta la navegación estructural y las transiciones pantalla a pantalla del sistema web, asociando las vistas esquemáticas con las decisiones del usuario y los eventos del sistema:

```mermaid
flowchart TD
    A[Inicio / Login Institucional] -->|Credenciales Válidas| B{2FA Requerido?}
    B -->|Sí| C[Pantalla Código OTP]
    C -->|OTP Correcto| D[Dashboard Operativo Principal]
    B -->|No| D
    
    D -->|Seleccionar Ambulancia / Envío| E[Vista Detalle de Traslado y Telemetría]
    D -->|Notificación Crítica| F[Centro de Alertas e Incidentes]
    D -->|Menú Administración| G[Gestión de Flota y Contenedores]
    
    E -->|Arribo a Destino| H[Pantalla de Desbloqueo OTP y Entrega]
    H -->|Firma Digital y OTP OK| I[Línea de Tiempo de Cadena de Custodia]
    I -->|Exportar Acta| J[Generación de Reporte PDF SHA-256]
    
    F -->|Documentar Acción Correctiva| E
```

*Nota: Las decisiones de interfaz y flujos alternativos detallados por cada historia de usuario se formalizan en la sección 4.4.4 mediante los diagramas de User Flow.*

---

### 4.4.3. Web Applications Mock-ups

#### Diseños de Alta Fidelidad para Desktop Browser
*   **Acceso Institucional y 2FA:** Interfaz de usuario de alta fidelidad para el flujo de acceso institucional. La vista se divide en dos columnas: el panel izquierdo refuerza la propuesta de valor corporativa y el panel derecho contiene el formulario de acceso seguido de la pantalla obligatoria de Verificación en Dos Pasos (2FA) mediante OTP de 6 dígitos.

![Mockup01 - Autenticacion](../assets/chapter-4/mockup-1.png)

*   **Dashboard General de Operaciones:** Interfaz del centro de control integral. Aprovecha el espacio horizontal para presentar la fila superior de KPIs (traslados activos, unidades monitoreadas, alertas y cumplimiento térmico), el mapa interactivo de Lima Metropolitana a la izquierda y el panel de alertas recientes a la derecha, con la tabla de traslados en curso en la parte inferior.

![Mockup02 - Dashboard](../assets/chapter-4/mockup-2.png)

*   **Planificación y Seguimiento Logístico:** Vista de Órdenes de Traslado y formulario de creación con validaciones de isquemia fría y pre-enfriamiento. Incluye el Tablero de Despacho Kanban (Pendiente, Despachado, En tránsito, Entregado) y la vista dividida de ruta en vivo con cálculo dinámico de ETA.

![Mockup03 - Despacho](../assets/chapter-4/mockup-3.png)

*   **Monitoreo y Control IoT de Smart Containers:** Vista en cuadrícula de todos los contenedores y panel individual (SB-0231) con medidores circulares de temperatura y batería, curva térmica continua de 24 horas y comando de desbloqueo electromecánico seguro vía MQTT.

![Mockup04 - Containers](../assets/chapter-4/mockup-4.png)

*   **Centro de Alertas Críticas e Incidentes:** Bandeja de notificaciones clasificada por severidad. Expone la magnitud de la excursión térmica (temperatura, duración, ubicación satelital), registro cronológico del despacho SMS/Push y registro interactivo de acciones correctivas tomadas por el operador.

![Mockup05 - Incidentes](../assets/chapter-4/mockup-5.png)

*   **Perfil, Configuración y Control de Roles:** Administración de canales de notificación (Push, SMS, correo, acústica), umbrales de severidad y asignación granular de permisos entre roles operativos (Fleet Logistics Dispatcher) y perfiles clínicos (Receiving Physician, Health Quality Auditor).

![Mockup06 - Configuracion](../assets/chapter-4/mockup-6.png)

*   **Auditoría, Cadena de Custodia y Reportes:** Flujo de validación OTP en destino, registro cronológico inmutable con firma SHA-256 en la cadena de custodia y generación automática de reportes certificados para DIGEMID/SUSALUD.

![Mockup07 - Custodia](../assets/chapter-4/mockup-7.png)

#### Adaptabilidad de Mock-ups para Mobile Browser
En pantallas móviles de smartphones asistenciales (360px a 414px):
*   **Diseño Modular en Tarjetas Verticales:** Los dashboards multipanel se reorganizan en tarjetas apiladas con scroll vertical fluido. La temperatura actual se resalta con tipografía agrandada (36px, `tabular-nums`) y código de color dinámico (verde para 2-8 °C, rojo parpadeante ante excursión térmica).
*   **Comandos de Acción en Barra Flotante:** La acción de "Confirmar Entrega y Solicitar OTP" permanece anclada como botón flotante (*sticky bottom*) visible en todo momento durante el trayecto, agilizando el traspaso en quirófano o rampa hospitalaria sin necesidad de desplazarse por menús complejos.
*   **Modo Nocturno / Alto Contraste para Cabina:** La paleta adopta un fondo oscuro de bajo brillo para no encandilar al paramédico ni al conductor en traslados nocturnos de emergencia.

---

### 4.4.4. Web Applications User Flow Diagrams

El diagrama de flujo de usuario es una representación visual de las acciones secuenciales que un operador logístico, supervisor hospitalario o personal médico realiza al interactuar con el ecosistema digital de NeonCode. A continuación se presentan tres diagramas de flujo clave adaptados a las historias de usuario de la plataforma, detallando el *Happy Path* (ruta ideal) y las ramificaciones alternativas (errores de validación, fallas de conectividad IoT y desviaciones en la cadena de frío).

**User Flow 1: Autenticación de Personal y Acceso al Panel**
*   **User Stories relacionadas:** US01, US02
*   **Flujos incluidos:** *Happy Path* (autenticación exitosa y acceso al panel), credenciales inválidas, cuenta institucional no activada, campos incompletos y reintentos de sesión.

![Primer User Flow](../assets/chapter-4/user-flow-1.png)

**User Flow 2: Alta de Ambulancia y Vinculación de Contenedor Inteligente**
*   **User Stories relacionadas:** US07, US08
*   **Flujos incluidos:** *Happy Path* (registro de vehículo y asignación telemétrica de contenedor), matrícula de ambulancia duplicada, ID de contenedor no encontrado, contenedor previamente asignado a otro vehículo y falla de enlace telemétrico inicial.

![Segundo User Flow](../assets/chapter-4/user-flow-2.png)

**User Flow 3: Monitoreo Térmico en Ruta, Gestión de Alertas y Cierre de Custodia**
*   **User Stories relacionadas:** US10, US11, US13, US14, US17
*   **Flujos incluidos:** *Happy Path* (monitoreo en tiempo real, recepción de alerta por variación térmica, acción correctiva y confirmación de entrega), pérdida de señal del contenedor, umbral térmico no configurado, variación de stock por sensores de peso e incidencia no resuelta en ruta.

![Tercer User Flow](../assets/chapter-4/user-flow-3.png)
