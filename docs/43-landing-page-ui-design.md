# 4.3. Landing Page UI Design

El diseño de la interfaz de usuario en la landing page de **Medical SMARTBOX** es clave para causar una primera impresión positiva y transmitir la innovación tecnológica y el rigor que respalda a nuestra solución de monitoreo de la cadena de frío médica. Buscamos ofrecer una experiencia visual limpia, profesional y altamente funcional que inspire confianza e invite a los operadores logísticos, gerentes de distribución farmacéutica y administradores de centros de salud a solicitar una demostración y explorar nuestro ecosistema de monitoreo IoT y trazabilidad en tiempo real.

### 4.3.1. Landing Page Wireframe

#### Diseño para Desktop Browser
*   **Hero Section:** Boceto estructural de la sección principal (Hero Section), definiendo un diseño de dos columnas para ubicar la propuesta de valor centrada en la protección de insumos médicos a la izquierda, y un elemento visual destacado a la derecha (preview interactivo del contenedor SmartBox y su telemetría).

![Hero - Wireframe](../assets/chapter-4/hero-wireframe.png)

*   **Características de la Plataforma:** Diseño esquemático (layout) para la sección de características clave (*Monitoreo Térmico en Tiempo Real*, *Alertas Predictivas de Incidencias* y *Trazabilidad End-to-End*), utilizando un sistema de cuadrícula para distribuir equitativamente tres tarjetas informativas.

![Caracteristicas - Wireframe](../assets/chapter-4/caracteristicas-wireframe.png)

*   **Presentación de la Startup / Quiénes Somos:** Estructura conceptual para la presentación del equipo detrás de Medical SMARTBOX. Define una cuadrícula adaptable (responsive grid) con cinco espacios reservados para las fotografías y perfiles del equipo desarrollador e ingenieros de software.

![Presentacion - Wireframe](../assets/chapter-4/presentacion-wireframe.png)

*   **Call to Action (CTA) y Footer:** Maquetación básica para la sección de "Llamado a la Acción", mostrando un formulario centralizado para la solicitud de demostraciones guiadas y el bloque del pie de página con enlaces institucionales, legales y de cumplimiento normativo sanitario.

![CTA-footer - Wireframe](../assets/chapter-4/cta-footer-wireframe.png)

#### Adaptabilidad para Mobile Browser
Para dispositivos móviles (viewports de 360px a 414px), la estructura de wireframe implementa una adaptación fluida de una columna:
*   **Navegación Móvil:** El menú horizontal superior se condensa en un botón de menú tipo hamburguesa ubicado en la esquina superior derecha, desplegando un panel Drawer lateral con los enlaces a Soluciones, Características, Equipo y Formulario de Contacto.
*   **Hero Section Vertical:** La disposición de dos columnas colapsa linealmente, colocando el titular persuasivo y el botón CTA prioritario en la parte superior, seguido del elemento gráfico representativo del SmartBox.
*   **Cuadrícula de Tarjetas Apiladas:** Las tarjetas de características y perfiles de equipo se reorganizan en una pila vertical (1 tarjeta por fila) con espaciado vertical de 16px, facilitando el desplazamiento vertical con el pulgar.
*   **Ergonomía Táctil:** Todos los botones de acción e inputs de formulario adoptan un ancho del 100% y una altura mínima de 48px con espaciado interactivo para evitar pulsaciones erróneas.

---

### 4.3.2. Landing Page Mock-up

#### Diseño de Alta Fidelidad para Desktop Browser
*   **Hero Section:** Interfaz final del Hero Section. Destaca la integración de la paleta de colores corporativa (Azul Marino `#10312F`, Verde Cerceta `#0F7A70` y Verde Claro `#B9DDA0`), la tipografía moderna (**Bricolage Grotesque** para titulares e **Inter** para cuerpo de texto) y una composición visual de un operador logístico inspeccionando un envío médico con telemetría activa en un dispositivo SmartBox, logrando captar la atención del usuario inmediatamente.
  
![Hero - Mockup](../assets/chapter-4/hero-mockup.png)

*   **Tarjetas de Servicios:** Implementación final de las tarjetas de servicio (*Telemetría IoT en Vivo*, *Mapeo de Ruta Térmica* y *Alertas Predictivas de Excursión de Temperatura*). Se incorporaron imágenes fotográficas de alta calidad y un diseño de tarjeta limpia (*Clean UI*) con sombras suaves y bordes redondeados para facilitar la lectura de métricas clave.

![Servicios - Mockup](../assets/chapter-4/servicios-mockup.png)

*   **Sección "Quiénes Somos":** Resultado visual de la sección "Quiénes Somos". Presenta formalmente a los cinco ingenieros de software del equipo de Medical SMARTBOX, transmitiendo transparencia, profesionalismo, solvencia técnica y compromiso con la seguridad en la salud digital.

![Presentacion - Mockup](../assets/chapter-4/presentacion-mockup.png)

*   **Formulario "Únete a Medical SmartBox":** Versión construida del formulario "Ir a la Web App". Utiliza el fondo azul marino oscuro de la marca para generar un alto contraste con los campos de entrada e incentivar la conversión, cerrando la página con un footer minimalista con políticas de privacidad, certificaciones sanitarias y enlaces legales.

![CTA-footer - Mockup](../assets/chapter-4/cta-footer-mockup.png)

#### Adaptabilidad de Alta Fidelidad para Mobile Browser
En la versión móvil de alta fidelidad, se aplican los estándares visuales de diseño responsivo definidos en las guías de estilo:
*   **Alineación Tipográfica y Tamaños Proporcionales:** Los encabezados `h1` reducen su tamaño de 48px a 32px con interlineado ajustado a 1.2, evitando desbordes horizontales y garantizando lectura cómoda sin zoom.
*   **Interacciones Táctiles y Controles:** Los formularios de contacto optimizan los campos de entrada para teclados virtuales nativos de iOS y Android (input types `email`, `tel`, `text`), y los botones principales disponen de microinteracciones activas táctiles (`active:scale-95`).
*   **Optimización de Carga y Recursos Gráficos:** Las imágenes de presentación y mockups emplean renderizado responsivo con densidades optimizadas, reduciendo el consumo de datos celulares en redes móviles de transporte asistencial.
