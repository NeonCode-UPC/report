# 2.3. Needfinding

Los artefactos de esta sección se construyen a partir de los dos patrones de comportamiento identificados en las entrevistas: **decisión clínica-operativa inmediata** y **coordinación logística trazable**. Las personas descritas son arquetipos compuestos; no representan literalmente a un entrevistado.

## 2.3.1. Criterios de agrupación y selección

Se evitó agrupar únicamente por edad o distrito. Los conjuntos se definieron por objetivos, tareas, responsabilidad y contexto de uso:

| Conjunto | Participantes que aportan evidencia | Comportamiento común | Arquetipo resultante |
|---|---|---|---|
| Decisión clínica-operativa | Wilbert Toledo, Aldair Lazaro y Renato Calvo Yalan | Consulta información crítica, verifica condiciones y necesita responder con rapidez. | Valeria, profesional de emergencias. |
| Coordinación logística trazable | Humberto Arellán, Gianfranco Timoteo y Karla Pacheco | Monitorea rutas y registros, coordina actores y necesita evidencia auditable. | Carlos, coordinador logístico de salud. |

## 2.3.2. User Persona 1: Valeria Ramos

| Campo | Descripción |
|---|---|
| Arquetipo | Profesional de emergencias que recibe y utiliza carga médica sensible. |
| Edad referencial | 29 años. |
| Ocupación | Enfermera de emergencia. |
| Contexto | Trabaja por turnos, con interrupciones frecuentes y decisiones de alta presión. Consulta información desde una estación clínica o un dispositivo móvil. |
| Objetivo principal | Confirmar rápidamente que la carga llegó a tiempo y en condiciones seguras para usarla. |
| Objetivos secundarios | Anticipar demoras, priorizar alertas y saber quién es responsable del traslado. |
| Tareas clave | Revisar ETA, verificar temperatura y estado, confirmar disponibilidad, responder alertas y aceptar o rechazar una entrega. |
| Necesidades | Información legible, vigencia del dato, severidad de la alerta, acción sugerida y constancia de recepción. |
| Frustraciones | Datos tardíos, llamadas repetidas, alertas ambiguas y ausencia de evidencia para decidir. |
| Motivaciones | Proteger al paciente, evitar pérdidas y reducir el tiempo entre llegada y atención. |
| Comportamiento digital | Prefiere resúmenes visuales, estados claros y acceso al detalle solo cuando es necesario. |
| Frase arquetípica (síntesis, no cita textual) | “Necesito saber de inmediato si la carga es segura y qué debo hacer si algo cambió.” |
| Escenario | Espera un medicamento refrigerado para una atención urgente; revisa ETA y temperatura, recibe una alerta, coordina la respuesta y registra la aceptación. |

## 2.3.3. User Persona 2: Carlos Mendoza

| Campo | Descripción |
|---|---|
| Arquetipo | Coordinador de transporte médico que supervisa múltiples traslados. |
| Edad referencial | 41 años. |
| Ocupación | Coordinador logístico en una institución de salud. |
| Contexto | Alterna entre planificación, seguimiento, comunicación con conductores y cierre documental. Atiende varios traslados a la vez. |
| Objetivo principal | Completar cada traslado dentro del tiempo y las condiciones acordadas, conservando la cadena de custodia. |
| Objetivos secundarios | Detectar incidentes temprano, asignar responsables y producir reportes verificables. |
| Tareas clave | Crear traslados, asignar unidad y contenedor, monitorear ruta y sensores, gestionar incidentes y cerrar entregas. |
| Necesidades | Vista centralizada, filtros, estado de conectividad, historial cronológico y exportación de evidencia. |
| Frustraciones | Registros dispersos, información duplicada, llamadas para confirmar ubicación y dificultad para reconstruir incidentes. |
| Motivaciones | Cumplir protocolos, reducir pérdidas, coordinar mejor y demostrar la calidad de la operación. |
| Comportamiento digital | Trabaja principalmente en escritorio, compara varios casos y requiere detalle trazable. |
| Frase arquetípica (síntesis, no cita textual) | “Si ocurre una incidencia, debo saber cuándo empezó, quién actuó y cómo terminó.” |
| Escenario | Supervisa tres traslados; detecta una desviación térmica, asigna una acción, mantiene informada a la institución receptora y cierra el caso con evidencia. |

## 2.3.4. User Task Matrix

Frecuencia: **A** = alta, **M** = media, **B** = baja. Importancia: **C** = crítica, **I** = importante, **S** = secundaria.

| Tarea | Valeria: frecuencia | Valeria: importancia | Carlos: frecuencia | Carlos: importancia | Información o evidencia requerida |
|---|:---:|:---:|:---:|:---:|---|
| Consultar estado del traslado | A | C | A | C | Estado, ubicación y última actualización. |
| Revisar ETA | A | C | A | I | Ruta, demora y hora estimada. |
| Verificar temperatura y condición | A | C | A | C | Lectura actual, rango permitido e historial. |
| Confirmar disponibilidad o stock | M | C | M | I | Cantidad estimada y variaciones. |
| Priorizar alertas | A | C | A | C | Severidad, carga afectada y tiempo transcurrido. |
| Coordinar respuesta a una incidencia | M | C | A | C | Responsable, acción, canal y estado. |
| Registrar cadena de custodia | M | I | A | C | Entrega, recepción, apertura y responsables. |
| Aceptar o rechazar entrega | M | C | M | C | Condición final, observación y firma/confirmación. |
| Consultar historial | B | I | A | C | Línea de tiempo inalterable. |
| Exportar reporte | B | S | M | C | Resumen, mediciones, incidentes y cierre. |

**Priorización:** las funciones comunes y críticas —estado, ETA, temperatura, alertas y cadena de custodia— deben formar el núcleo del producto. Las vistas y permisos deben adaptarse a cada rol.

## 2.3.5. User Journey Map — Valeria

**Escenario:** recepción de un medicamento refrigerado para una atención urgente.

| Etapa | Acción | Pensamiento | Emoción | Dolor | Oportunidad |
|---|---|---|---|---|---|
| Notificación | Recibe aviso del traslado. | “¿Llegará antes de que lo necesitemos?” | Expectativa y tensión. | Aviso sin contexto suficiente. | Mostrar prioridad, carga y ETA desde la notificación. |
| Seguimiento | Consulta avance y condición. | “¿El dato está actualizado?” | Vigilancia. | Debe llamar para confirmar. | Ubicación, temperatura y sello de última lectura. |
| Incidencia | Recibe alerta por desviación. | “¿La carga sigue siendo utilizable?” | Estrés. | Alerta sin consecuencia ni responsable. | Severidad, rango, duración y acción sugerida. |
| Recepción | Revisa condición final. | “¿Puedo aceptar esto con seguridad?” | Cautela. | Evidencia fragmentada. | Resumen de cumplimiento y excepciones. |
| Confirmación | Acepta o rechaza y registra observación. | “Debe quedar constancia.” | Alivio si el cierre es claro. | Registro manual o duplicado. | Cierre guiado con responsable, hora y evidencia. |

## 2.3.6. User Journey Map — Carlos

**Escenario:** coordinación de un traslado con una incidencia térmica.

| Etapa | Acción | Pensamiento | Emoción | Dolor | Oportunidad |
|---|---|---|---|---|---|
| Planificación | Registra carga, ruta y responsables. | “Todo debe estar asignado antes de salir.” | Concentración. | Datos repartidos en varias fuentes. | Plantilla y validación previa a la salida. |
| Despacho | Confirma unidad y contenedor. | “¿El equipo está conectado y listo?” | Control. | Falta de confirmación técnica. | Lista de verificación y estado del sensor. |
| Monitoreo | Supervisa ubicación y condiciones. | “¿Qué traslado requiere atención?” | Vigilancia. | Sobrecarga de datos. | Dashboard por riesgo y filtros. |
| Gestión de incidente | Contacta responsables y registra acciones. | “Necesito contener el riesgo y dejar evidencia.” | Estrés. | Comunicación y bitácora separadas. | Flujo de incidente con responsable y tiempos. |
| Cierre | Confirma entrega y genera reporte. | “¿Puedo demostrar qué ocurrió?” | Alivio o preocupación. | Reconstrucción manual. | Línea de tiempo y reporte automático. |

## 2.3.7. Empathy Map — Valeria

| Cuadrante | Síntesis |
|---|---|
| Dice | “Necesito información clara”; “No puedo perder tiempo buscando el dato”; “La condición de la carga define mi decisión.” |
| Piensa | Si el dato no está actualizado, no puede confiar plenamente; una demora puede afectar la atención. |
| Hace | Consulta el estado, confirma por otros canales, revisa condiciones y registra la recepción. |
| Siente | Urgencia, incertidumbre y responsabilidad; alivio cuando la evidencia es clara. |
| Dolores | Alertas ambiguas, información tardía, múltiples llamadas y falta de trazabilidad inmediata. |
| Ganancias | Decidir rápido, reducir riesgo clínico y contar con una constancia confiable. |

## 2.3.8. Empathy Map — Carlos

| Cuadrante | Síntesis |
|---|---|
| Dice | “Debo coordinar a todos”; “Necesito anticiparme”; “La operación tiene que quedar documentada.” |
| Piensa | Un incidente no gestionado puede causar pérdida de la carga y responsabilidad institucional. |
| Hace | Planifica, asigna, monitorea, llama, registra acciones y elabora reportes. |
| Siente | Presión por el tiempo, frustración por datos dispersos y satisfacción cuando el cierre es verificable. |
| Dolores | Duplicidad de registros, poca visibilidad, seguimiento manual y dificultad para auditar. |
| Ganancias | Control centralizado, respuesta temprana, responsables claros y evidencia exportable. |

## 2.3.9. Necesidades priorizadas

| Prioridad | Necesidad | Criterio de validación |
|:---:|---|---|
| 1 | Conocer condición y ubicación de la carga en tiempo casi real. | El usuario identifica estado, vigencia y riesgo sin recurrir a otro canal. |
| 2 | Recibir alertas accionables y priorizadas. | Cada alerta muestra severidad, causa, impacto, responsable y próximo paso. |
| 3 | Mantener cadena de custodia verificable. | Cada evento registra fecha, hora, actor y evidencia. |
| 4 | Coordinar incidentes en un único flujo. | Se asigna responsable, se registra acción y se confirma resolución. |
| 5 | Cerrar y auditar el traslado. | Se obtiene una línea de tiempo y un reporte de cumplimiento/excepciones. |

