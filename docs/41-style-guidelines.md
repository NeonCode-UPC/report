## 4.1. Style Guidelines
Un "Style Guideline" es un conjunto de directrices y normas que establecen los estándares y criterios a seguir en la redacción, diseño y presentación de documentos, contenido web, software y otros productos creativos. A continuación, se presentan las especificaciones detalladas de los parámetros implementados en la estructura de **Medical SmartBox**.

## 4.1.1. General Style Guidelines

### Branding
Para el desarrollo de la identidad de Medical SmartBox, hemos elegido un diseño que encapsula la esencia de la logística médica y la monitorización de precisión. El logotipo y la interfaz presentan una estética limpia y tecnológica, aportando modernidad y máxima legibilidad. La identidad visual fusiona la salud con la tecnología IoT, simbolizando el control total y la trazabilidad de la cadena de frío. La elección de colores, en una combinación de azul marino, verde cerceta (teal) y acentos en coral/rojo, transmite una sensación de confianza, estabilidad técnica y la capacidad de alerta inmediata frente a incidencias. 

![Medical SmartBox - Logo](./assets/chapter-4/logo.png)

### Typography
Para el diseño tipográfico de Medical SmartBox, se ha seleccionado una combinación de fuentes que refleja modernidad y claridad de datos, priorizando la lectura rápida en dashboards operativos.
*   **Bricolage Grotesque:** Fue elegida como la tipografía principal para nuestros encabezados (`h1`, `h2`, `h3`). Su estructura sólida y geométrica otorga al diseño un aire profesional, tecnológico y contemporáneo.
*   **Inter:** Para los párrafos, etiquetas de la interfaz y la visualización de datos numéricos (como telemetría y temperaturas), hemos optado por Inter, una fuente destacada por su altísima legibilidad en pantallas digitales e interfaces ricas en datos, favoreciendo una lectura ágil para los operadores logísticos y personal de salud.

![Bricolage Grotesque - Font](./assets/chapter-4/bricolage-font.png)
![Inter - Font](./assets/chapter-4/inter-font.png)

### Colors
La paleta de colores de Medical SmartBox fue seleccionada para reflejar los valores de seguridad, precisión técnica y prevención operativa.
*   **Verde Cerceta (Teal - `#0F7A70`) y Verde Claro (`#B9DDA0`):** Representan el estado óptimo, la salud y las operaciones estables ("En rango").
*   **Azul Marino (`#10312F` / `#1F3C77`):** Evocan profesionalismo, tecnología y la solidez institucional del sector médico.
*   **Coral / Rojo (`#E05A46`):** Utilizado estratégicamente como color de acento para alertas críticas (ej. "Temperatura fuera de rango" o "Batería baja"), garantizando que los incidentes destaquen inmediatamente visualmente.

![Paleta de Colores](./assets/chapter-4/paleta.png)

### Spacing
El espaciado en Medical SmartBox está cuidadosamente definido para garantizar una interfaz limpia, enfocada en la visualización de métricas. Se emplea un diseño modular con separaciones claras (paneles y tarjetas flotantes), lo que mejora la jerarquía de la telemetría en vivo, evita confusiones al monitorear múltiples transportes y aporta equilibrio visual en vistas saturadas de datos.

## 4.1.2. Web Style Guidelines

Medical SmartBox cuenta con un diseño web responsivo para garantizar una experiencia fluida en cualquier dispositivo, permitiendo su uso tanto en paneles de control (operadores logísticos) como en dispositivos móviles (centros de salud recibiendo despachos). Se utiliza un diseño lineal con un "Route Rail" (navegación vertical) que guía al usuario por la narrativa del producto. La barra de navegación superior (pegajosa) mantiene el logotipo a la izquierda, y los controles críticos como el cambio de idioma (ES/EN), el inicio de sesión y el llamado a la acción ("Ir a la Web App") a la derecha.

---

## 4.2. Information Architecture

### 4.2.1. Organization Systems

*   **Visual Organization:**

    Para facilitar la asimilación visual de la información crítica, la plataforma prioriza las tarjetas de telemetría y alertas. En el dashboard, la información más crítica (como alertas rojas de "Temperatura sobre el rango esperado" o desvíos de ETA) tiene el mayor peso visual mediante contrastes cromáticos y tipografía agrandada (clase `.tnum`). La información secundaria tiene colores neutros o silenciados.
*   **Organización Cronológica / Secuencial:**

    Se emplea intensivamente en el módulo de **Trazabilidad (Traceability)**. El historial de un transporte (ej. TR-0417) se divide en hitos secuenciales (Preparado -> Recogido -> En tránsito -> Llegando -> Entregado), permitiendo al usuario ver el ciclo de vida de un envío en orden lógico.
*   **Organización Matricial / Cruzada:**

    Se aplica en el Panel de Operaciones (Flota en ruta) y en el Inbox de Receptores. Los operadores visualizan listas cruzando identificadores de transporte (TR-0417) con métricas dinámicas (Temperatura, ETA, Batería del SmartBox, Estado de Puertas).