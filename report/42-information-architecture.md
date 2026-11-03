# 4.2. Information Architecture

### 4.2.1. Organization Systems

*   **Visual Organization:** Para facilitar la asimilación visual de la información crítica, la plataforma prioriza las tarjetas de telemetría y alertas. En el dashboard, la información más crítica (como alertas rojas de "Temperatura sobre el rango esperado" o desvíos de ETA) tiene el mayor peso visual mediante contrastes cromáticos y tipografía agrandada (clase `.tnum`). La información secundaria tiene colores neutros o silenciados.
*   **Organización Cronológica / Secuencial:** Se emplea intensivamente en el módulo de **Trazabilidad (Traceability)**. El historial de un transporte (ej. TR-0417) se divide en hitos secuenciales (Preparado -> Recogido -> En tránsito -> Llegando -> Entregado), permitiendo al usuario ver el ciclo de vida de un envío en orden lógico.
*   **Organización Matricial / Cruzada:** Se aplica en el Panel de Operaciones (Flota en ruta) y en el Inbox de Receptores. Los operadores visualizan listas cruzando identificadores de transporte (TR-0417) con métricas dinámicas (Temperatura, ETA, Batería del SmartBox, Estado de Puertas).

### 4.2.2. Labeling Systems

La aplicación utiliza un sistema de etiquetas y terminología adaptado a los dos principales segmentos de usuarios representados por nuestros *User Personas*:

*   **Para el Visitante Comercial Institucional (*Gianfranco Timoteo* evaluando la plataforma):** Botones directos como "Ir a la Web App", "Solicitar Demostración" o "Iniciar sesión".
*   **Para el Personal de Transporte Asistencial y Operadores en Ruta (*Aldair Lazaro* — Segmento 1):** Se emplea terminología técnica de monitoreo y flota. Etiquetas como "ETA", "Telemetría en vivo", "Combustible (%)", "Batería (%)" y "Temperatura (°C)". Las alertas usan un lenguaje preciso: "Puerta abierta fuera de parada", "Batería baja del SmartBox".
*   **Para los Centros Receptores y Supervisores Hospitalarios (*Gianfranco Timoteo* — Segmento 2: Hospitales/Clínicas):** El enfoque cambia hacia el despacho, auditoría y recepción de paquetes. Etiquetas enfocadas en el estado de llegada y custodia: "Envíos entrantes", "Llegan hoy", "Validar OTP de Recepción", "Recibido" y confirmaciones como "Acta SHA-256 Conforme".

### 4.2.3. SEO Tags and Meta Tags

Los SEO y meta tags implementados en el ecosistema **Medical SmartBox** están diferenciados y optimizados según el propósito de indexación del **Landing Page** público y de la **Web Application** operativa:

#### A. Meta Tags para el Landing Page Público (`NeonCode-UPC/landing-page`)

Orientados al posicionamiento orgánico (SEO) en motores de búsqueda para captar clínicas, hospitales, laboratorios y operadores de ambulancias:

```html
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Medical SmartBox — Monitoreo IoT y Trazabilidad de Cadena de Frío Médica</title>
  <meta name="description" content="Medical SmartBox de NeonCode es una plataforma IoT y SaaS para monitorear contenedores médicos inteligentes en ambulancias, detectar excursiones térmicas en tiempo real y certificar la cadena de custodia ante DIGEMID y SUSALUD." />
  <meta name="keywords" content="Medical SmartBox, NeonCode, cadena de frío médica, contenedor inteligente IoT, transporte de órganos, hemoderivados, vacunas, telemetría en ambulancias, trazabilidad hospitalaria, DIGEMID, SUSALUD, Perú" />
  <meta name="author" content="NeonCode Team — Medical SmartBox" />
  <meta name="robots" content="index, follow" />
  <link rel="canonical" href="https://neoncode-upc.github.io/landing-page/" />
  <!-- Open Graph / Social Sharing -->
  <meta property="og:type" content="website" />
  <meta property="og:title" content="Medical SmartBox — Custodia Digital para la Cadena de Frío Médica" />
  <meta property="og:description" content="Supervisión térmica, geolocalización GPS y sellado criptográfico SHA-256 para traslados médicos críticos en tiempo real." />
  <meta property="og:url" content="https://neoncode-upc.github.io/landing-page/" />
</head>
```

#### B. Meta Tags para la Web Application (`NeonCode-UPC/frontend`)

Orientados a la aplicación web SPA en Vue 3 para operación clínica autenticada, responsividad móvil en cabina y seguridad de sesión:

```html
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>Medical SmartBox Console — Panel de Monitoreo Telemétrico y Despacho</title>
  <meta name="description" content="Consola operativa de Medical SmartBox para la supervisión en tiempo real de contenedores IoT, despacho de ambulancias, gestión de alertas críticas y auditoría de cadena de custodia." />
  <meta name="keywords" content="dashboard telemetría médica, consola SmartBox, despacho de ambulancias, alertas cadena de frío, custodia OTP, auditoría médica" />
  <meta name="author" content="NeonCode Team — Medical SmartBox" />
  <meta name="robots" content="noindex, nofollow" />
  <meta name="theme-color" content="#10312F" />
  <link rel="canonical" href="https://neoncode-upc.github.io/frontend/home" />
</head>
```

### 4.2.4. Searching Systems

Para asegurar que los usuarios encuentren la unidad o el dato exacto al instante:

*   **Búsqueda global y de flota:** Un input de búsqueda con el placeholder *"Buscar transporte, SmartBox o destino"* y filtros dedicados *"Filtrar por ruta, estado o SmartBox"*.
*   **Búsqueda por Estados (Tabs):** Posibilidad de filtrar vistas rápidamente mediante estados activos como "En tránsito", "Crítica", o "Entregado".

### 4.2.5. Navigation Systems

*   **Navegación principal (Top Nav):** Enlaces ancla directos a secciones clave del producto: *Plataforma, Cómo funciona, Soluciones, Trazabilidad*.
*   **Navegación Vertical de Seguimiento (Route Rail):** Un indicador de progreso visual en el lateral de la pantalla que funciona como un "scrollspy", ubicando al usuario en qué sección de la página (Inicio, Monitoreo, Alertas, Capturas, Datos, etc.) se encuentra.
*   **Controles de Autenticación y Demostración:** Botones persistentes en el encabezado y menús laterales (Drawer) para "Iniciar sesión" o abrir la "Web App" completa.
*   **Selector de Idioma:** Un interruptor claro (Toggle ES/EN) que permite cambiar la internacionalización de la plataforma sin recargar, crucial para equipos logísticos internacionales.
