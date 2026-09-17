# 4.1. Style Guidelines
Un "Style Guideline" es un conjunto de directrices y normas que establecen los estÃ¡ndares y criterios a seguir en la redacciÃ³n, diseÃ±o y presentaciÃ³n de documentos, contenido web, software y otros productos creativos. A continuaciÃ³n, se presentan las especificaciones detalladas de los parÃ¡metros implementados en la estructura de **Medical SmartBox**.

## 4.1.1. General Style Guidelines

### Branding
Para el desarrollo de la identidad de Medical SmartBox, hemos elegido un diseÃ±o que encapsula la esencia de la logÃ­stica mÃ©dica y la monitorizaciÃ³n de precisiÃ³n. El logotipo y la interfaz presentan una estÃ©tica limpia y tecnolÃ³gica, aportando modernidad y mÃ¡xima legibilidad. La identidad visual fusiona la salud con la tecnologÃ­a IoT, simbolizando el control total y la trazabilidad de la cadena de frÃ­o. La elecciÃ³n de colores, en una combinaciÃ³n de azul marino, verde cerceta (teal) y acentos en coral/rojo, transmite una sensaciÃ³n de confianza, estabilidad tÃ©cnica y la capacidad de alerta inmediata frente a incidencias. 

![Medical SmartBox - Logo](../assets/chapter-4/logo.png)

### Typography
Para el diseÃ±o tipogrÃ¡fico de Medical SmartBox, se ha seleccionado una combinaciÃ³n de fuentes que refleja modernidad y claridad de datos, priorizando la lectura rÃ¡pida en dashboards operativos.
*   **Bricolage Grotesque:** Fue elegida como la tipografÃ­a principal para nuestros encabezados (`h1`, `h2`, `h3`). Su estructura sÃ³lida y geomÃ©trica otorga al diseÃ±o un aire profesional, tecnolÃ³gico y contemporÃ¡neo.
*   **Inter:** Para los pÃ¡rrafos, etiquetas de la interfaz y la visualizaciÃ³n de datos numÃ©ricos (como telemetrÃ­a y temperaturas), hemos optado por Inter, una fuente destacada por su altÃ­sima legibilidad en pantallas digitales e interfaces ricas en datos, favoreciendo una lectura Ã¡gil para los operadores logÃ­sticos y personal de salud.

![Bricolage Grotesque - Font](../assets/chapter-4/bricolage-font.png)
![Inter - Font](../assets/chapter-4/inter-font.png)

### Colors
La paleta de colores de Medical SmartBox fue seleccionada para reflejar los valores de seguridad, precisiÃ³n tÃ©cnica y prevenciÃ³n operativa.
*   **Verde Cerceta (Teal - `#0F7A70`) y Verde Claro (`#B9DDA0`):** Representan el estado Ã³ptimo, la salud y las operaciones estables ("En rango").
*   **Azul Marino (`#10312F` / `#1F3C77`):** Evocan profesionalismo, tecnologÃ­a y la solidez institucional del sector mÃ©dico.
*   **Coral / Rojo (`#E05A46`):** Utilizado estratÃ©gicamente como color de acento para alertas crÃ­ticas (ej. "Temperatura fuera de rango" o "BaterÃ­a baja"), garantizando que los incidentes destaquen inmediatamente visualmente.

![Paleta de Colores](../assets/chapter-4/paleta.png)

### Spacing
El espaciado en Medical SmartBox estÃ¡ cuidadosamente definido para garantizar una interfaz limpia, enfocada en la visualizaciÃ³n de mÃ©tricas. Se emplea un diseÃ±o modular con separaciones claras (paneles y tarjetas flotantes), lo que mejora la jerarquÃ­a de la telemetrÃ­a en vivo, evita confusiones al monitorear mÃºltiples transportes y aporta equilibrio visual en vistas saturadas de datos.

# 4.1.2. Web Style Guidelines

Medical SmartBox cuenta con un diseÃ±o web responsivo para garantizar una experiencia fluida en cualquier dispositivo, permitiendo su uso tanto en paneles de control (operadores logÃ­sticos) como en dispositivos mÃ³viles (centros de salud recibiendo despachos). Se utiliza un diseÃ±o lineal con un "Route Rail" (navegaciÃ³n vertical) que guÃ­a al usuario por la narrativa del producto. La barra de navegaciÃ³n superior (pegajosa) mantiene el logotipo a la izquierda, y los controles crÃ­ticos como el cambio de idioma (ES/EN), el inicio de sesiÃ³n y el llamado a la acciÃ³n ("Ir a la Web App") a la derecha.

---

## 4.2. Information Architecture

### 4.2.1. Organization Systems

*   **Visual Organization:**

    Para facilitar la asimilaciÃ³n visual de la informaciÃ³n crÃ­tica, la plataforma prioriza las tarjetas de telemetrÃ­a y alertas. En el dashboard, la informaciÃ³n mÃ¡s crÃ­tica (como alertas rojas de "Temperatura sobre el rango esperado" o desvÃ­os de ETA) tiene el mayor peso visual mediante contrastes cromÃ¡ticos y tipografÃ­a agrandada (clase `.tnum`). La informaciÃ³n secundaria tiene colores neutros o silenciados.
*   **OrganizaciÃ³n CronolÃ³gica / Secuencial:**

    Se emplea intensivamente en el mÃ³dulo de **Trazabilidad (Traceability)**. El historial de un transporte (ej. TR-0417) se divide en hitos secuenciales (Preparado -> Recogido -> En trÃ¡nsito -> Llegando -> Entregado), permitiendo al usuario ver el ciclo de vida de un envÃ­o en orden lÃ³gico.
*   **OrganizaciÃ³n Matricial / Cruzada:**

    Se aplica en el Panel de Operaciones (Flota en ruta) y en el Inbox de Receptores. Los operadores visualizan listas cruzando identificadores de transporte (TR-0417) con mÃ©tricas dinÃ¡micas (Temperatura, ETA, BaterÃ­a del SmartBox, Estado de Puertas).

### 4.2.2. Labeling Systems

La aplicaciÃ³n utiliza un sistema de etiquetas y terminologÃ­a adaptado a los dos principales tipos de usuarios: Operadores logÃ­sticos y Centros Receptores.

*   **Para el visitante:** Botones directos como "Ir a la Web App" o "Iniciar sesiÃ³n".
*   **Para los Operadores de Transporte:** Se emplea terminologÃ­a tÃ©cnica de monitoreo y flota. Etiquetas como "ETA", "TelemetrÃ­a en vivo", "Combustible (%)", "BaterÃ­a (%)" y "Temperatura (Â°C)". Las alertas usan un lenguaje preciso: "Puerta abierta fuera de parada", "BaterÃ­a baja del SmartBox".
*   **Para los Centros Receptores (Hospitales/Farmacias):** El enfoque cambia hacia la recepciÃ³n de paquetes. Etiquetas enfocadas en el estado de llegada: "EnvÃ­os entrantes", "Llegan hoy", "Recibido", y confirmaciones como "Conforme".

### 4.2.3. SEO Tags and Meta Tags

Los SEO y meta tags implementados en Medical SmartBox estÃ¡n optimizados para el nicho de logÃ­stica mÃ©dica:

*   **Title Tag:**
    `<title>Medical SmartBox â€” Monitoreo y trazabilidad del transporte mÃ©dico</title>`
*   **Meta Description:**
    `<meta name="description" content="Medical SmartBox es una plataforma para monitorear transportes mÃ©dicos, detectar incidencias de temperatura en tiempo real y mantener cada envÃ­o y cadena de frÃ­o bajo control.">`
*   **Language tag:** (DinÃ¡mico vÃ­a script, base en inglÃ©s y espaÃ±ol)
    `<html lang="es">`
*   **Meta Viewport:** (Esencial para responsividad en mÃ³viles y paneles de campo)
    `<meta name="viewport" content="width=device-width, initial-scale=1">`
*   **Author tag:**
    `<meta name="author" content="Medical SmartBox Team">`
*   **Canonical Tag:**
    `<link rel="canonical" href="https://www.medicalsmartbox.com/">`

### 4.2.4. Searching Systems

Para asegurar que los usuarios encuentren la unidad o el dato exacto al instante:

*   **BÃºsqueda global y de flota:** Un input de bÃºsqueda con el placeholder *"Buscar transporte, SmartBox o destino"* y filtros dedicados *"Filtrar por ruta, estado o SmartBox"*.
*   **BÃºsqueda por Estados (Tabs):** Posibilidad de filtrar vistas rÃ¡pidamente mediante estados activos como "En trÃ¡nsito", "CrÃ­tica", o "Entregado".

### 4.2.5. Navigation Systems

*   **NavegaciÃ³n principal (Top Nav):** Enlaces ancla directos a secciones clave del producto: *Plataforma, CÃ³mo funciona, Soluciones, Trazabilidad*.
*   **NavegaciÃ³n Vertical de Seguimiento (Route Rail):** Un indicador de progreso visual en el lateral de la pantalla que funciona como un "scrollspy", ubicando al usuario en quÃ© secciÃ³n de la pÃ¡gina (Inicio, Monitoreo, Alertas, Capturas, Datos, etc.) se encuentra.
*   **Controles de AutenticaciÃ³n y DemostraciÃ³n:** Botones persistentes en el encabezado y menÃºs laterales (Drawer) para "Iniciar sesiÃ³n" o abrir la "Web App" completa.
*   **Selector de Idioma:** Un interruptor claro (Toggle ES/EN) que permite cambiar la internacionalizaciÃ³n de la plataforma sin recargar, crucial para equipos logÃ­sticos internacionales.

## 4.3. Landing Page UI Design
El diseÃ±o de la interfaz de usuario en la landing page de **Medical SmartBox** es clave para causar una primera impresiÃ³n positiva y transmitir la innovaciÃ³n tecnolÃ³gica y el rigor que respalda a nuestra soluciÃ³n de monitoreo de la cadena de frÃ­o mÃ©dica. Buscamos ofrecer una experiencia visual limpia, profesional y altamente funcional que inspire confianza e invite a los operadores logÃ­sticos, gerentes de distribuciÃ³n farmacÃ©utica y administradores de centros de salud a solicitar una demostraciÃ³n y explorar nuestro ecosistema de monitoreo IoT y trazabilidad en tiempo real.

### 4.3.1. Landing Page Wireframe

*   **Landing Page para Desktop Browser:**
    *   **Hero Section:** Boceto estructural de la secciÃ³n principal (Hero Section), definiendo un diseÃ±o de dos columnas para ubicar la propuesta de valor centrada en la protecciÃ³n de insumos mÃ©dicos a la izquierda, y un elemento visual destacado a la derecha (preview interactivo del contenedor SmartBox y su telemetrÃ­a).

![Hero - Wireframe](../assets/chapter-4/hero-wireframe.png)

*   **CaracterÃ­sticas de la Plataforma:** DiseÃ±o esquemÃ¡tico (layout) para la secciÃ³n de caracterÃ­sticas clave (*Monitoreo TÃ©rmico en Tiempo Real*, *Alertas Predictivas de Incidencias* y *Trazabilidad End-to-End*), utilizando un sistema de cuadrÃ­cula para distribuir equitativamente tres tarjetas informativas.

![Caracteristicas - Wireframe](../assets/chapter-4/caracteristicas-wireframe.png)

*   **PresentaciÃ³n de la Startup / QuiÃ©nes Somos:** Estructura conceptual para la presentaciÃ³n del equipo detrÃ¡s de Medical SmartBox. Define una cuadrÃ­cula adaptable (responsive grid) con cinco espacios reservados para las fotografÃ­as y perfiles del equipo desarrollador e ingenieros de software.

![Presentacion - Wireframe](../assets/chapter-4/presentacion-wireframe.png)

*   **Call to Action (CTA) y Footer:** MaquetaciÃ³n bÃ¡sica para la secciÃ³n de "Llamado a la AcciÃ³n", mostrando un formulario centralizado para la solicitud de demostraciones guiadas y el bloque del pie de pÃ¡gina con enlaces institucionales, legales y de cumplimiento normativo sanitario.

![CTA-footer - Wireframe](../assets/chapter-4/cta-footer-wireframe.png)

### 4.3.2. Landing Page Mock-up

*   **Hero Section:** Interfaz final del Hero Section. Destaca la integraciÃ³n de la paleta de colores corporativa (Azul Marino `#10312F`, Verde Cerceta `#0F7A70` y Verde Claro `#B9DDA0`), la tipografÃ­a moderna (**Bricolage Grotesque** para titulares e **Inter** para cuerpo de texto) y una composiciÃ³n visual de un operador logÃ­stico inspeccionando un envÃ­o mÃ©dico con telemetrÃ­a activa en un dispositivo SmartBox, logrando captar la atenciÃ³n del usuario inmediatamente.
  
* ![Hero - Mockup](../assets/chapter-4/hero-mockup.png)

*   **Tarjetas de Servicios:** ImplementaciÃ³n final de las tarjetas de servicio (*TelemetrÃ­a IoT en Vivo*, *Mapeo de Ruta TÃ©rmica* y *Alertas Predictivas de ExcursiÃ³n de Temperatura*). Se incorporaron imÃ¡genes fotogrÃ¡ficas de alta calidad y un diseÃ±o de tarjeta limpia (*Clean UI*) con sombras suaves y bordes redondeados para facilitar la lectura de mÃ©tricas clave.

![Servicios - Mockup](../assets/chapter-4/servicios-mockup.png)

*   **SecciÃ³n "QuiÃ©nes Somos":** Resultado visual de la secciÃ³n "QuiÃ©nes Somos". Presenta formalmente a los cinco ingenieros de software del equipo de Medical SmartBox, transmitiendo transparencia, profesionalismo, solvencia tÃ©cnica y compromiso con la seguridad en la salud digital.

![Presentacion - Mockup](../assets/chapter-4/presentacion-mockup.png)

*   **Formulario "Ãšnete a Medical SmartBox":** VersiÃ³n construida del formulario "Ir a la Web App". Utiliza el fondo azul marino oscuro de la marca para generar un alto contraste con los campos de entrada e incentivar la conversiÃ³n, cerrando la pÃ¡gina con un footer minimalista con polÃ­ticas de privacidad, certificaciones sanitarias y enlaces legales.

![CTA-footer - Mockup](../assets/chapter-4/cta-footer-mockup.png)
---

# 4.4. Web Applications UX/UI Design

El diseÃ±o de experiencia de usuario (UX) y diseÃ±o de interfaz de usuario (UI) en la plataforma web de **Medical SmartBox** busca crear una herramienta digital intuitiva, accesible y altamente funcional para operadores logÃ­sticos, conductores de transporte mÃ©dico y personal receptor en hospitales o farmacias. La UX se enfoca en comprender la urgencia y precisiÃ³n requeridas en la cadena de frÃ­o, diseÃ±ando flujos de interacciÃ³n eficientes para monitorear cargas tÃ©rmicamente sensibles, reaccionar ante desvÃ­os de temperatura y configurar sensores IoT sin fricciÃ³n.

Por su parte, la UI se encarga del aspecto visual, estructurando de manera clara componentes complejos como dashboards telemÃ©tricos en tiempo real, trazabilidad por hitos de envÃ­o, grÃ¡ficos de estabilidad tÃ©rmica y sistemas de alertas predictivas. Un diseÃ±o UX/UI exitoso en Medical SmartBox fusiona una estÃ©tica tecnolÃ³gica limpia con la practicidad operativa, ofreciendo una experiencia fluida que transforma datos IoT masivos en decisiones logÃ­sticas rÃ¡pidas que salvan vidas y evitan la merma de medicamentos.

### 4.4.1. Web Applications Wireframes
*   **Acceso y AutenticaciÃ³n Segura:** El flujo de inicio de sesiÃ³n presenta un diseÃ±o *desktop* de dos columnas ("auth-shell"). La izquierda actÃºa como un panel informativo destacando la propuesta de valor ("Cadena de frÃ­o bajo custodia digital") y estadÃ­sticas de la flota, mientras que la derecha contiene el formulario de acceso institucional que solicita RUC/Correo y ContraseÃ±a. A esto le sigue una pantalla obligatoria de VerificaciÃ³n en Dos Pasos (2FA) mediante un cÃ³digo OTP de 6 dÃ­gitos

![Autenticacion - Wireframe](../assets/chapter-4/autenticacion-wireframe.png)

*   **NÃºcleo Operativo - Dashboard Principal:** El Dashboard general organiza la vista del operador comenzando con una fila de KPIs (unidades en ruta, monitorizadas, alertas crÃ­ticas y cumplimiento DIGEMID). En el cuerpo central, se emplea una estructura de cuadrÃ­cula (`grid-2`) que muestra un mapa de "Flota en tiempo real" a la izquierda y un panel consolidado de "Alertas crÃ­ticas recientes" a la derecha, finalizando con una tabla inferior para los "Traslados en curso"

![Nucleo Operativo  - Wireframe](../assets/chapter-4/nucleo-wireframe.png)

*   **GestiÃ³n de EnvÃ­os y Tablero de Despacho:** El sistema incluye una lista maestra de "Ã“rdenes de traslado" y un formulario completo para crear una nueva orden validando ventana de isquemia frÃ­a y precooling. AdemÃ¡s, presenta un Tablero de Despacho en formato Kanban que categoriza los viajes en Pendientes, Despachados, En trÃ¡nsito y Entregados

![Gestion de Envios  - Wireframe](../assets/chapter-4/envios-wireframe.png)

*   **Vista Detallada de TelemetrÃ­a y Ruta:** La inspecciÃ³n individual de un envÃ­o presenta un *stepper* de estado en la parte superior. Debajo, se divide en dos mÃ³dulos: a la izquierda, el mapa de trazabilidad y ruta en vivo con cÃ¡lculo de ETA dinÃ¡mico; a la derecha, las tarjetas telemÃ©tricas y medidores (*gauges*) mostrando la temperatura interna en tiempo real (ej. 4.3Â°C), nivel de baterÃ­a, estado de cierre y lecturas recientes.

![Vista de Ruta  - Wireframe](../assets/chapter-4/ruta-wireframe.png)

*   **Monitoreo y Control de Smart Containers:** Se incluye un mÃ³dulo visual tipo *grid* para monitorear todos los contenedores de la flota y una vista de detalle por Smart Container que incluye una curva grÃ¡fica de temperatura de las Ãºltimas 24 horas. Complementariamente, el sistema permite enviar comandos de desbloqueo remoto de la tapa mediante interacciÃ³n electromecÃ¡nica y visualizar el historial completo de excursiones tÃ©rmicas.

![Monitoreo de Containers  - Wireframe](../assets/chapter-4/containers-wireframe.png)

*   **Centro de Alertas y Respuesta a Incidentes:** La plataforma cuenta con una bandeja centralizada para gestionar notificaciones. El detalle de una alerta crÃ­tica expone la magnitud de la excursiÃ³n tÃ©rmica (temperatura, duraciÃ³n, ubicaciÃ³n), el registro temporal del despacho de alertas (vÃ­a SMS y Push) y una secciÃ³n para que el operador documente las acciones correctivas.

![Centro de Alertas  - Wireframe](../assets/chapter-4/incidentes-wireframe.png)

*   **ConfiguraciÃ³n y Umbrales de Alerta:** Una pantalla de administraciÃ³n dedicada a "Canales de notificaciÃ³n" permite al usuario activar/desactivar notificaciones Push, SMS, Correo y alarmas acÃºsticas. AquÃ­ mismo, en el panel "Umbrales de severidad", se configuran manualmente los lÃ­mites mÃ¡ximos/mÃ­nimos de temperatura y los tiempos lÃ­mite (SLA) para el envÃ­o de alertas.

![Umbrales de Alerta  - Wireframe](../assets/chapter-4/alerta-wireframe.png)

*   **Cadena de Custodia, Manifiestos y Reportes:** El flujo de entrega garantiza la seguridad exigiendo la VerificaciÃ³n OTP en destino y trazando todos los eventos en una LÃ­nea de Tiempo de Cadena de Custodia. Administrativamente, se generan Manifiestos Digitales de AuditorÃ­a inmutables sellados con SHA-256 y se presenta un consolidado analÃ­tico para cumplimiento normativo DIGEMID/DIGDOT

![Cadena de Custodia  - Wireframe](../assets/chapter-4/custodia-wireframe.png)

*   **AdministraciÃ³n Institucional y B2B:** La plataforma incluye la gestiÃ³n integral de la suscripciÃ³n, facturaciÃ³n B2B, vinculaciÃ³n de unidades vehiculares y el control granular de usuarios organizados en roles operativos de logÃ­stica o perfiles clÃ­nicos.
   
![Administracion - Wireframe](../assets/chapter-4/administracion-wireframes.png)

### 4.4.3. Web Applications Mock-ups

Esta imagen presenta el diseÃ±o de interfaz de usuario (UI) en alta fidelidad para el flujo de acceso institucional a Medical SmartBox. La vista se divide en dos columnas: el panel izquierdo refuerza la propuesta de valor de la plataforma ("Cadena de frÃ­o bajo custodia digital") y muestra estadÃ­sticas clave de la flota. El panel derecho contiene el formulario de inicio de sesiÃ³n, seguido de un flujo obligatorio de VerificaciÃ³n en Dos Pasos (2FA), donde el operador debe ingresar un cÃ³digo OTP de 6 dÃ­gitos. Este diseÃ±o garantiza un acceso seguro restringido a personal autorizado, manteniendo una estÃ©tica corporativa e intuitiva.

![Mockup01 - Wireframe](../assets/chapter-4/mockup-1.png)

Esta imagen detalla el Dashboard General de Operaciones. La interfaz aprovecha el espacio horizontal para presentar una fila superior de indicadores clave de rendimiento (KPIs), como traslados activos, unidades monitorizadas, alertas crÃ­ticas y cumplimiento tÃ©rmico. El cuerpo central se divide en dos Ã¡reas principales: a la izquierda, un mapa interactivo que ubica la flota en tiempo real dentro de Lima Metropolitana; a la derecha, un panel que consolida las alertas crÃ­ticas mÃ¡s recientes. En la parte inferior, una tabla estructurada permite visualizar rÃ¡pidamente los traslados en curso, ofreciendo al operador logÃ­stico un centro de control integral en una sola vista.

![Mockup02 - Wireframe](../assets/chapter-4/mockup-2.png)

Esta imagen ilustra las interfaces dedicadas a la planificaciÃ³n y seguimiento logÃ­stico. El diseÃ±o incluye una lista navegable de Ã“rdenes de Traslado y un formulario de creaciÃ³n que integra validaciones automÃ¡ticas de isquemia frÃ­a y pre-enfriamiento del contenedor. Destaca el Tablero de Despacho en formato Kanban, que categoriza visualmente el estado de cada viaje (Pendiente, Despachado, En trÃ¡nsito, Entregado). AdemÃ¡s, la vista de detalle de un viaje especÃ­fico divide la pantalla para mostrar, simultÃ¡neamente, la ruta en vivo con el cÃ¡lculo de ETA dinÃ¡mico y la telemetrÃ­a en tiempo real del Smart Container asociado.

![Mockup03 - Wireframe](../assets/chapter-4/mockup-3.png)

Esta imagen presenta los mÃ³dulos de monitoreo y control a nivel de hardware IoT. La interfaz ofrece una vista en cuadrÃ­cula de todos los Smart Containers activos. Al inspeccionar una unidad individual (SB-0231), el usuario accede a un panel detallado que muestra medidores circulares (*gauges*) para la temperatura actual y el nivel de baterÃ­a, junto con un grÃ¡fico que traza la curva tÃ©rmica de las Ãºltimas 24 horas. Estos paneles tambiÃ©n incluyen herramientas para revisar el historial completo de excursiones tÃ©rmicas exportable para auditorÃ­a, y controles directos para accionar el bloqueo o desbloqueo electromecÃ¡nico de la tapa del contenedor mediante comandos MQTT.

![Mockup04 - Wireframe](../assets/chapter-4/mockup-4.png)

Esta imagen expone el Centro de Alertas CrÃ­ticas y la gestiÃ³n de incidentes. La bandeja principal clasifica las notificaciones por severidad, permitiendo al operador priorizar la atenciÃ³n. El detalle de un incidente (por ejemplo, una excursiÃ³n tÃ©rmica crÃ­tica) presenta una vista estructurada que documenta la temperatura registrada, la duraciÃ³n fuera del umbral, y un registro temporal (*timeline*) del despacho automÃ¡tico de notificaciones vÃ­a Push y SMS. La interfaz fomenta la resoluciÃ³n eficiente al incluir un campo de texto donde el operador puede registrar las acciones correctivas tomadas y un botÃ³n para marcar la alerta como resuelta.

![Mockup05 - Wireframe](../assets/chapter-4/mockup-5.png)

Esta imagen detalla el panel de Perfil, ConfiguraciÃ³n y roles de acceso. La interfaz de configuraciÃ³n permite al administrador gestionar los "Canales de notificaciÃ³n", activando o desactivando avisos vÃ­a SMS, Push, correo y alarma acÃºstica, asÃ­ como definir los umbrales de temperatura y SLA crÃ­ticos. Complementariamente, se incluyen vistas para la gestiÃ³n del personal, donde se listan los usuarios activos y se asignan permisos granulares a travÃ©s de perfiles especÃ­ficos, divididos entre el segmento operativo (Fleet Logistics Dispatcher) y el segmento clÃ­nico (Receiving Physician, Health Quality Auditor).

![Mockup06 - Wireframe](../assets/chapter-4/mockup-6.png)

Esta imagen muestra los mÃ³dulos orientados a la auditorÃ­a, la trazabilidad y el cumplimiento normativo. Destaca el flujo de entrega, que exige la validaciÃ³n de un cÃ³digo OTP en el punto de destino para desbloquear el contenedor, evento que queda registrado en la LÃ­nea de Tiempo de Cadena de Custodia. El sistema genera manifiestos digitales de cada traslado, los cuales son sellados criptogrÃ¡ficamente (SHA-256) para garantizar su inmutabilidad. Finalmente, un panel de reportes consolida el rendimiento tÃ©rmico mensual de las distintas sedes, facilitando la presentaciÃ³n de datos ante entidades regulatorias como DIGEMID.

![Mockup07 - Wireframe](../assets/chapter-4/mockup-7.png)

### 4.4.4. Web Applications User Flow Diagrams

El diagrama de flujo de usuario es una representaciÃ³n visual de las acciones secuenciales que un operador logÃ­stico, supervisor hospitalario o personal mÃ©dico realiza al interactuar con el ecosistema digital de NeonCode. A continuaciÃ³n se presentan tres diagramas de flujo clave adaptados a las historias de usuario de la plataforma, detallando el *Happy Path* (ruta ideal) y las ramificaciones alternativas (errores de validaciÃ³n, fallas de conectividad IoT y desviaciones en la cadena de frÃ­o).

**User Flow 1: AutenticaciÃ³n de Personal y Acceso al Panel**
*   **User Stories relacionadas:** US01, US02
*   **Flujos incluidos:** *Happy Path* (autenticaciÃ³n exitosa y acceso al panel), credenciales invÃ¡lidas, cuenta institucional no activada, campos incompletos y reintentos de sesiÃ³n.

![Primer User Flow](../assets/chapter-4/user-flow-1.png)

**User Flow 2: Alta de Ambulancia y VinculaciÃ³n de Contenedor Inteligente**
*   **User Stories relacionadas:** US07, US08
*   **Flujos incluidos:** *Happy Path* (registro de vehÃ­culo y asignaciÃ³n telemÃ©trica de contenedor), matrÃ­cula de ambulancia duplicada, ID de contenedor no encontrado, contenedor previamente asignado a otro vehÃ­culo y falla de enlace telemÃ©trico inicial.

![Segundo User Flow](../assets/chapter-4/user-flow-2.png)

**User Flow 3: Monitoreo TÃ©rmico en Ruta, GestiÃ³n de Alertas y Cierre de Custodia**
*   **User Stories relacionadas:** US10, US11, US13, US14, US17
*   **Flujos incluidos:** *Happy Path* (monitoreo en tiempo real, recepciÃ³n de alerta por variaciÃ³n tÃ©rmica, acciÃ³n correctiva y confirmaciÃ³n de entrega), pÃ©rdida de seÃ±al del contenedor, umbral tÃ©rmico no configurado, variaciÃ³n de stock por sensores de peso e incidencia no resuelta en ruta.

![Tercer User Flow](../assets/chapter-4/user-flow-3.png)

## 4.5. Web Applications Prototyping
El prototipo adjunta la representaciÃ³n visual de los mock-ups anteriormente mostrados y diseÃ±os interactivos, pero no cuenta con cÃ³digo real detrÃ¡s.

Para este proyecto usamos la herramienta de Figma. VÃ©ase el anexo 3 para mayor informaciÃ³n
