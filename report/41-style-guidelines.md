# 4.1. Style Guidelines

Las Style Guidelines fijan los estándares visuales, de interacción y de comunicación de Medical SmartBox y aseguran coherencia entre el Landing Page y la Web Application. Toman como referencia **Material Design** y **PrimeVue**, con adaptaciones propias, y sus valores se extrajeron del código desplegado. El idioma por defecto es inglés (en_US) con español (es_419) como alternativa.

### 4.1.1. General Style Guidelines

### Branding

Identidad clínica, limpia y confiable: verde bosque profundo (`ink`) sobre marfil cálido, verde cerceta (`teal`) para acciones y estado “en rango”, y coral reservado a alertas. Logotipo: espacio libre igual a la altura del isotipo, tamaño mínimo de 24 px, versión blanca sobre fondos oscuros.

![Medical SMARTBOX - Logo](../assets/chapter-4/logo.png)

*Nota: Logotipo oficial de Medical SMARTBOX, representando la custodia térmica inteligente.*


### Tone of Communication

| Dimensión | Posición | Ejemplo |
| --- | --- | --- |
| Divertido / Serio | Serio, con calidez | “Temperature above range. Check the container.” |
| Formal / Casual | Casual formal | “Your shipment arrives in 12 min.” |
| Respetuoso / Irreverente | Respetuoso | “Delivery confirmed. The record was saved.” |
| Entusiasta / Sereno | Sereno | “No action needed. Temperature is in range.” |

### Design Principles

| Principio | Cómo se aplica |
| --- | --- |
| Jerarquía visual | Alertas y temperatura con mayor tamaño y contraste; lo secundario en neutros |
| Contraste y legibilidad | Texto de al menos 4.5:1 y cifras tabulares |
| Consistencia | Mismos tokens y componentes en Landing y Web App |
| Retroalimentación | Transiciones de 180 ms en botones y controles |
| Diseño inclusivo | El color nunca es la única señal: punto o ícono más texto |

### Iconography

Landing: **Font Awesome Free 6.5.1** (solid, regular, brands). Web App: iconos SVG en línea. No se usan emojis; los decorativos llevan `aria-hidden="true"`.

### Typography

El sistema tipográfico prioriza la jerarquía visual y la decodificación instantánea de telemetría numérica en entornos de alta exigencia cognitiva (ej. cabina de ambulancia o supervisión en central de emergencias). Se implementa una escala tipográfica modular basada en las siguientes fuentes de Google Fonts:

*   **Bricolage Grotesque:** Empleada como tipografía corporativa para encabezados primarios y secundarios (`h1`, `h2`, `h3`). Su estructura geométrica contemporánea con remates técnicos otorga autoridad visual, solidez institucional y modernidad tecnológica.
*   **Inter:** Empleada para textos de párrafo, microcopia de interfaz, tablas de auditoría y visualización de telemetría numérica. Su excelente renderizado subpíxel y variantes tabulares numéricas (`font-variant-numeric: tabular-nums`) garantizan una lectura nítida de decimales de temperatura y porcentajes de batería sin oscilaciones visuales.

![Bricolage Grotesque - Font](../assets/chapter-4/bricolage-font.png){.style-specimen-lg}
![Inter - Font](../assets/chapter-4/inter-font.png){.style-specimen-lg}
*Nota: Muestrarios tipográficos de Bricolage Grotesque (titulares) e Inter (cuerpo y datos numéricos).*

### Colors

La paleta cromática se seleccionó bajo criterios de contraste accesible (cumplimiento WCAG 2.1 [@w3c2018] Nivel AA) y codificación semántica para estados operativos clínicos:

*   **Azul Marino Corporativo (`#10312F` / `#1F3C77`):** Color dominante institucional que proyecta solidez, seriedad médica y rigor de ingeniería.
*   **Verde Cerceta / Teal (`#0F7A70`):** Color primario de acción y estado óptimo ("En Rango", carga refrigerada entre 2 °C y 8 °C, telemetría activa).
*   **Verde Menta (`#B9DDA0`):** Fondo suave de soporte para indicadores de éxito y tarjetas de estado estable.
*   **Coral / Rojo Alerta (`#E05A46`):** Tono semántico de alta prioridad reservado exclusivamente para situaciones críticas (temperatura fuera de umbral, desconexión de energía de 12V, batería residual < 15%, apertura no autorizada de tapa).
*   **Gris Neutro Frío (`#F4F7F6` / `#E2E8F0`):** Fondos de interfaz y delimitadores de paneles modulares para reducir la fatiga visual en turnos prolongados.

![Paleta de Colores](../assets/chapter-4/paleta.png){.style-specimen-sm}
*Nota: Muestra de la paleta de colores corporativa y semántica de Medical SMARTBOX.*

### Spacing

El espaciado se fundamenta en un sistema de rejilla base modular de **8 píxeles** (8-point grid system: 4px, 8px, 16px, 24px, 32px, 48px, 64px). Este estándar asegura consistencia entre paneles modulares, tarjetas de telemetría telemática (*telemetry cards*) y botones de acción rápida, previniendo el hacinamiento de información y reduciendo la tasa de error por toques accidentales en pantallas táctiles de cabina.

## 4.1.2. Web Style Guidelines

Las directrices web definen la estructura adaptativa, componentes interactivos y comportamiento responsivo de la plataforma:

*   **Estrategia Responsive y Adaptabilidad Multi-dispositivo:**
    *   **Desktop / Estaciones Hospitalarias (Viewport ≥ 1280px):** Disposición de cuadrícula fluida de 12 columnas. Aprovecha el ancho panorámico para mostrar simultáneamente el mapa de flota satelital en vivo, gráficos telemétricos continuos y panel lateral de incidentes activos.
    *   **Tablet / Terminales de Cabina (Viewport 768px a 1024px):** Cuadrícula adaptativa de 6 columnas. Los paneles secundarios se condensan en pestañas (*tabs*) o cajones laterales (*drawers*) accesibles mediante gestos táctiles.
    *   **Mobile Browser / Smartphones Médicos (Viewport 360px a 414px):** Colapso a una columna única fluida (1 columna, 100% de ancho con márgenes laterales de 16px). La barra de navegación superior colapsa en un menú tipo hamburguesa/drawer lateral; los mapas de ruta alternan a pantalla completa modal; las tarjetas de métricas telemétricas se apilan verticalmente; y los botones de acción rápida (ej. "Reconocer Alerta", "Solicitar OTP") cuentan con una altura mínima de **48px** para garantizar un área táctil ergonómica (*touch target*) según directrices de Google Material Design y Apple Human Interface Guidelines.
*   **Navegación y Patrones de Interacción:**
    *   **Sticky Header:** Barra de navegación superior fija que mantiene visible el logotipo institucional, estado de conexión en tiempo real (indicador verde de latencia de red), conmutador de idioma (ES/EN) y botón de acceso rápido al perfil de usuario.
    *   **Route Rail (Navegación Vertical de Seguimiento):** En el Landing Page, un indicador lateral animado (*scrollspy*) sitúa visualmente al visitante a lo largo de las secciones informativas del producto.
    *   **Retroalimentación Inmediata de Estados:** Cada microinteracción (hover en escritorio, active state en móvil) ofrece respuestas visuales no mayores a 150ms mediante transiciones CSS fluidas (`ease-in-out`), confirmando visualmente cada comando emitidoI.
