# 2.4. Big Picture EventStorming

El Big Picture EventStorming representa el proceso completo de un traslado médico sensible, desde la solicitud hasta el cierre y la auditoría. Se redacta en pasado para distinguir los **eventos de dominio** de las acciones o intenciones.

## 2.4.1. Leyenda

| Elemento | Significado | Ejemplo |
|---|---|---|
| Actor | Persona o sistema que participa. | Coordinador logístico. |
| Comando | Acción que intenta cambiar el estado. | Asignar unidad. |
| Evento de dominio | Hecho relevante que ya ocurrió. | Unidad asignada. |
| Política | Regla que reacciona ante un evento. | Si la temperatura sale de rango, generar alerta. |
| Read model | Información consultada para decidir. | Panel de traslados activos. |
| Sistema externo | Servicio fuera del dominio. | GPS o servicio de mapas. |
| Hotspot | Duda, riesgo o regla pendiente. | Definir tolerancia por tipo de carga. |

## 2.4.2. Actores y sistemas

**Actores:** solicitante de la institución de origen, coordinador logístico, conductor o transportista, personal médico receptor, supervisor y auditor.

**Sistemas externos:** sensor de temperatura, sensor de peso/stock, GPS, servicio de mapas y ETA, servicio de notificaciones y proveedor de identidad.

## 2.4.3. Flujo principal de eventos

| N.° | Actor / sistema | Comando | Evento de dominio | Read model o evidencia |
|---:|---|---|---|---|
| 1 | Institución de origen | Solicitar traslado | Traslado solicitado | Solicitud con carga, origen, destino y prioridad. |
| 2 | Coordinador | Validar solicitud | Solicitud validada | Requisitos y rango permitido. |
| 3 | Coordinador | Asignar unidad, contenedor y responsables | Recursos asignados | Disponibilidad de unidades y personal. |
| 4 | Transportista | Ejecutar lista de verificación | Preparación verificada | Checklist, conectividad y calibración. |
| 5 | Personal de origen | Registrar carga y sellar contenedor | Carga registrada / Contenedor sellado | Identificación, cantidad, condición y responsable. |
| 6 | Transportista | Iniciar traslado | Traslado iniciado | Hora de salida, ruta y ETA inicial. |
| 7 | GPS / sensores | Publicar mediciones | Ubicación actualizada / Temperatura registrada / Stock actualizado | Telemetría con fecha y hora. |
| 8 | Plataforma | Evaluar reglas | Condición evaluada | Rango permitido y vigencia del dato. |
| 9 | Coordinador | Confirmar seguimiento | Seguimiento confirmado | Dashboard de traslados activos. |
| 10 | Transportista | Registrar llegada | Unidad arribó al destino | Hora real de llegada. |
| 11 | Personal receptor | Verificar carga | Condición final verificada | Resumen térmico, aperturas e incidentes. |
| 12 | Personal receptor | Aceptar o rechazar entrega | Entrega aceptada / Entrega rechazada | Observación, responsable y sello de tiempo. |
| 13 | Coordinador | Cerrar traslado | Traslado cerrado | Línea de tiempo completa. |
| 14 | Plataforma | Generar reporte | Reporte de traslado generado | Evidencia exportable para auditoría. |

## 2.4.4. Políticas y rutas alternativas

### Desviación de temperatura

1. **Temperatura fuera de rango.**
2. Política: si la lectura supera el límite o la duración permitida, **generar alerta crítica**.
3. **Alerta generada.**
4. El coordinador asigna responsable y el personal médico evalúa la carga.
5. **Acción correctiva registrada.**
6. La condición se recupera y la alerta se resuelve, o se mantiene el riesgo y la entrega se rechaza.

### Pérdida de conectividad

1. **Telemetría interrumpida.**
2. Política: marcar el dato como desactualizado y notificar al coordinador.
3. El sistema conserva mediciones locales y reintenta sincronización.
4. **Telemetría restablecida** y **mediciones sincronizadas**.

### Demora de ruta

1. **ETA excedido.**
2. Política: recalcular ETA y notificar a coordinación y recepción según prioridad.
3. El coordinador confirma una ruta alterna o mantiene la ruta.
4. **Ruta actualizada** o **demora aceptada**.

### Apertura no autorizada

1. **Contenedor abierto fuera del punto autorizado.**
2. Política: generar alerta crítica y solicitar confirmación del transportista.
3. **Apertura justificada** con evidencia o **cadena de custodia comprometida**.
4. El receptor evalúa y acepta o rechaza la carga.

## 2.4.5. Agregados y límites del dominio

| Agregado | Responsabilidad | Eventos principales |
|---|---|---|
| Traslado | Mantener estado, prioridad, ruta, ETA y responsables. | Solicitado, iniciado, arribó, cerrado. |
| Carga médica | Mantener identificación, tipo, cantidad y condiciones permitidas. | Registrada, verificada, aceptada o rechazada. |
| Contenedor | Mantener sello, aperturas, sensor y estado operativo. | Sellado, abierto, conectividad interrumpida. |
| Monitoreo | Recibir y evaluar telemetría. | Temperatura registrada, ubicación actualizada, condición evaluada. |
| Incidente | Coordinar alertas, responsables, acciones y resolución. | Alerta generada, acción registrada, incidente resuelto. |
| Cadena de custodia | Registrar transferencias entre responsables. | Custodia transferida, entrega confirmada. |
| Reporte | Consolidar evidencia y excepciones. | Reporte generado. |

## 2.4.6. Hotspots y decisiones pendientes

| Hotspot | Pregunta pendiente | Próxima validación |
|---|---|---|
| Rangos por carga | ¿Quién configura temperatura y tolerancia para cada tipo de carga? | Entrevistar a responsables de cadena de frío y revisar protocolos. |
| Validez de lectura | ¿Cuánto tiempo puede pasar sin telemetría antes de bloquear una aceptación? | Probar reglas con coordinadores y personal receptor. |
| Stock por peso | ¿Qué precisión se requiere y cómo se resuelven variaciones por calibración? | Prueba técnica con distintos contenedores. |
| Apertura autorizada | ¿Qué roles y ubicaciones pueden abrir el contenedor? | Validar matriz de permisos. |
| Rechazo de carga | ¿Qué evidencia y aprobación exige una institución? | Entrevista de seguimiento con personal responsable. |
| Conservación de datos | ¿Durante cuánto tiempo deben almacenarse reportes y mediciones? | Revisión normativa e institucional. |
| Notificaciones | ¿Qué canal y tiempo de escalamiento corresponde a cada severidad? | Prueba de alertas con ambos arquetipos. |

## 2.4.7. Relación con los artefactos de needfinding

- El estado, la temperatura, el ETA y la vigencia del dato responden a las tareas críticas de Valeria.
- El dashboard, la gestión de incidentes, la cadena de custodia y los reportes responden a las tareas críticas de Carlos.
- Las rutas alternativas convierten los principales dolores de los Journey Maps en políticas y eventos verificables.
- Los hotspots evitan convertir supuestos en requisitos definitivos y orientan la siguiente ronda de entrevistas.
