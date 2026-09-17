# 4.2. Information Architecture

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
