# 2.4. Big Picture EventStorming

El Big Picture EventStorming permite representar de forma colaborativa los eventos principales del dominio del transporte médico controlado. Esta técnica facilita que el equipo comprenda el flujo general del negocio, identifique actores, procesos relevantes, problemas actuales y oportunidades para la solución.

En el contexto del proyecto, el dominio inicia cuando una institución de salud solicita el traslado de medicamentos, órganos, muestras biológicas o insumos sensibles. A partir de esa solicitud, se prepara la carga, se configura el contenedor según las condiciones requeridas, se asigna una ambulancia o unidad de transporte, se inicia el monitoreo y se realiza la entrega en el destino.

## Actores principales

- Personal médico solicitante.
- Operador logístico de salud.
- Conductor o paramédico responsable del traslado.
- Supervisor de institución de salud.
- Personal receptor en el destino.
- Sistema de contenedor inteligente IoT.
- Servicio externo de mapas y rutas.

## Eventos del dominio

| Evento | Descripción |
|---|---|
| Medical transport requested | Una institución solicita el traslado de productos médicos sensibles. |
| Medical load registered | Se registra la carga que será transportada en el contenedor. |
| Container configured | Se configura el rango de temperatura y reglas de monitoreo según el tipo de carga. |
| Vehicle assigned | Se asigna una ambulancia o unidad de transporte al traslado. |
| Container loaded | La carga es colocada dentro del contenedor inteligente. |
| Transport started | El traslado inicia y se activa el monitoreo en tiempo real. |
| Temperature measured | El sensor registra la temperatura interna del contenedor. |
| Stock weight measured | El sensor de peso estima la cantidad de productos transportados. |
| Location updated | El rastreador GPS actualiza la ubicación del contenedor. |
| Fuel level updated | El sistema registra el nivel de combustible del vehículo. |
| Estimated arrival updated | Se calcula o actualiza el tiempo estimado de llegada. |
| Critical alert triggered | Se genera una alerta por temperatura, apertura, stock, ruta, batería o combustible. |
| Incident reviewed | Un usuario autorizado revisa la incidencia y toma una acción. |
| Medical load delivered | La carga llega al destino y se confirma la entrega. |
| Traceability report generated | El sistema genera un registro histórico del traslado. |

## Problemas y oportunidades identificadas

Entre los principales problemas del dominio se encuentran la falta de visibilidad integrada, el registro manual de incidencias, la dificultad para verificar condiciones de conservación y la limitada capacidad de anticipar retrasos. Como oportunidades, se identifican la automatización del monitoreo, la generación de alertas tempranas, la integración con servicios de mapas y la disponibilidad de reportes de trazabilidad.
