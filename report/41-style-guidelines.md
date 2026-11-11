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

**Bricolage Grotesque** (encabezados) e **Inter** (cuerpo y telemetría, con `tabular-nums`). Tamaños fluidos con `clamp()`.

| Nivel | Familia | Tamaño | Peso |
| --- | --- | --- | --- |
| Hero | Bricolage | 43 a 90 px | 600 |
| Título de sección | Bricolage | 32 a 54 px | 600 |
| Lead | Inter | 16 a 19 px | 400 |
| Body | Inter | 16 px / 1.6 | 400 |
| Micro / Label | Inter | 12 a 12.5 px | 400 y 500 |

### Colors

| Token | Hex | Rol |
| --- | --- | --- |
| `ink` | #10312F | Texto principal y botón primario |
| `ink-2` / `ink-3` | #2E4A47 / #6B827F | Texto secundario y de apoyo |
| `ivory` / `warm` / `mist` | #F7F4EE / #FFFDF9 / #EDF1EE | Fondos y superficies |
| `teal` / `teal-deep` | #0F7A70 / #0B4F4A | Acción, enlaces y estado “en rango” |
| `blue` | #1F3C77 | Alertas informativas |
| `mint` / `lime` | #CDE7DC / #B9DDA0 | Apoyo suave y foco sobre oscuro |
| `coral` / `coral-pale` | #E05A46 / #FBE6E1 | Alertas críticas |
| `ok` / `warn` | #2E9E6B / #D99B2B | Estados correcto y advertencia |

**Verificación de contraste (WCAG 2.1)**

| Texto sobre fondo | Ratio | Resultado |
| --- | --- | --- |
| `ink` / `ivory` | 12.73:1 | AAA |
| `ink-2` / `ivory` | 8.75:1 | AAA |
| `teal` / `ivory` | 4.74:1 | AA |
| Blanco / `teal` | 5.20:1 | AA |
| Badge crítico #A93321 / `coral-pale` | 5.50:1 | AA |
| Alerta crítica #7A2417 / #FEF3F1 | 9.23:1 | AAA |
| `ink-3` / `ivory` | 3.73:1 | Solo apoyo o texto grande |
| `ink-3` / `mist` | 3.59:1 | Solo apoyo o texto grande |
| `coral` / `warm` | 3.61:1 | Solo elementos no textuales |

El `ink-3` se oscurecerá a #5A706D (4.81:1) en la siguiente iteración.

### Spacing, bordes y sombras

| Token | Valor |
| --- | --- |
| `--pad` / `--maxw` | `clamp(20px, 5vw, 72px)` / 1240 px |
| Espaciado de sección | `clamp(64px, 9vw, 120px)` |
| Radios `--r-s` a `--r-xl` | 10, 16, 24 y 34 px; píldora 999 px |
| Sombras `--sh-1` a `--sh-3` | Reposo, botones y chips, modales |


### 4.1.2. Web Style Guidelines

| Dispositivo | Ancho | Comportamiento |
| --- | --- | --- |
| Desktop | ≥ 1081 px | Contenido de hasta 1240 px, varias columnas |
| Tablet | 721 a 1080 px | Cuadrículas reducidas, paneles apilados |
| Mobile | ≤ 720 px | Una columna y menú drawer (la Web App adapta desde 700 px) |

| Componente | Variantes | Estados |
| --- | --- | --- |
| Button | Primary, accent, ghost, light, outline; sm, base, lg | Default, hover (sube 2 px), focus-visible |
| Input | Texto y contraseña | Default, focus (borde `teal`) |
| Badge | ok, info, warn, crit, mute | Punto de color más texto |
| Alert (Web App) | Informativa, correcta, advertencia, crítica | Ícono, título y descripción |
| KPI, panel y fila | Valor y etiqueta; listas | Normal, crítico |
| Modal y Language toggle | Login, privacidad, términos; ES / EN | Abierto/cerrado; `role="switch"` |

| Accesibilidad e i18n | Estado actual |
| --- | --- |
| Foco visible | Anillo de 2.5 px en `teal`, separación de 3 px |
| Movimiento reducido | `prefers-reduced-motion` desactiva animaciones |
| ARIA | Landing: `aria-label`, `aria-live`, `aria-expanded`; Web App: `aria-label` y `aria-live` en elementos clave |
| Idioma | Landing en inglés con conmutador a español; Web App en español |

**Limitaciones conocidas y mejoras planificadas**

| Limitación | Mejora planificada |
| --- | --- |
| `ink-3` con 3.6 a 4.0:1 | Oscurecerlo a #5A706D |
| Botones `btn-sm` de unos 38 px | Alto mínimo de 44 px en punteros táctiles |
| Web App en español, sin conmutador | Inglés por defecto con ES/EN |
| Poca cobertura ARIA en la Web App | `role="alert"` en alertas críticas |
| Sin modo nocturno | Evaluarlo en el roadmap |