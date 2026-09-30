# 2.3. Needfinding

Los artefactos de esta secciÃ³n se construyen a partir de los dos patrones de comportamiento identificados en las entrevistas: **decisiÃ³n clÃ­nica-operativa inmediata** y **coordinaciÃ³n logÃ­stica trazable**. Las personas descritas son arquetipos compuestos; no representan literalmente a un entrevistado.

## 2.3.1. Criterios de agrupaciÃ³n y selecciÃ³n

Se evitÃ³ agrupar Ãºnicamente por edad o distrito. Los conjuntos se definieron por objetivos, tareas, responsabilidad y contexto de uso:

| Conjunto | Participantes que aportan evidencia | Comportamiento comÃºn | Arquetipo resultante |
|---|---|---|---|
| DecisiÃ³n clÃ­nica-operativa | Wilbert Toledo, Aldair Lazaro y Renato Calvo Yalan | Consulta informaciÃ³n crÃ­tica, verifica condiciones y necesita responder con rapidez. | Valeria, profesional de emergencias. |
| CoordinaciÃ³n logÃ­stica trazable | Humberto ArellÃ¡n, Gianfranco Timoteo y Karla Pacheco | Monitorea rutas y registros, coordina actores y necesita evidencia auditable. | Carlos, coordinador logÃ­stico de salud. |

## 2.3.2. User Persona 1: Valeria Ramos

| Campo | DescripciÃ³n |
|---|---|
| Arquetipo | Profesional de emergencias que recibe y utiliza carga mÃ©dica sensible. |
| Edad referencial | 29 aÃ±os. |
| OcupaciÃ³n | Enfermera de emergencia. |
| Contexto | Trabaja por turnos, con interrupciones frecuentes y decisiones de alta presiÃ³n. Consulta informaciÃ³n desde una estaciÃ³n clÃ­nica o un dispositivo mÃ³vil. |
| Objetivo principal | Confirmar rÃ¡pidamente que la carga llegÃ³ a tiempo y en condiciones seguras para usarla. |
| Objetivos secundarios | Anticipar demoras, priorizar alertas y saber quiÃ©n es responsable del traslado. |
| Tareas clave | Revisar ETA, verificar temperatura y estado, confirmar disponibilidad, responder alertas y aceptar o rechazar una entrega. |
| Necesidades | InformaciÃ³n legible, vigencia del dato, severidad de la alerta, acciÃ³n sugerida y constancia de recepciÃ³n. |
| Frustraciones | Datos tardÃ­os, llamadas repetidas, alertas ambiguas y ausencia de evidencia para decidir. |
| Motivaciones | Proteger al paciente, evitar pÃ©rdidas y reducir el tiempo entre llegada y atenciÃ³n. |
| Comportamiento digital | Prefiere resÃºmenes visuales, estados claros y acceso al detalle solo cuando es necesario. |
| Frase arquetÃ­pica (sÃ­ntesis, no cita textual) | â€œNecesito saber de inmediato si la carga es segura y quÃ© debo hacer si algo cambiÃ³.â€ |
| Escenario | Espera un medicamento refrigerado para una atenciÃ³n urgente; revisa ETA y temperatura, recibe una alerta, coordina la respuesta y registra la aceptaciÃ³n. |

## 2.3.3. User Persona 2: Carlos Mendoza

| Campo | DescripciÃ³n |
|---|---|
| Arquetipo | Coordinador de transporte mÃ©dico que supervisa mÃºltiples traslados. |
| Edad referencial | 41 aÃ±os. |
| OcupaciÃ³n | Coordinador logÃ­stico en una instituciÃ³n de salud. |
| Contexto | Alterna entre planificaciÃ³n, seguimiento, comunicaciÃ³n con conductores y cierre documental. Atiende varios traslados a la vez. |
| Objetivo principal | Completar cada traslado dentro del tiempo y las condiciones acordadas, conservando la cadena de custodia. |
| Objetivos secundarios | Detectar incidentes temprano, asignar responsables y producir reportes verificables. |
| Tareas clave | Crear traslados, asignar unidad y contenedor, monitorear ruta y sensores, gestionar incidentes y cerrar entregas. |
| Necesidades | Vista centralizada, filtros, estado de conectividad, historial cronolÃ³gico y exportaciÃ³n de evidencia. |
| Frustraciones | Registros dispersos, informaciÃ³n duplicada, llamadas para confirmar ubicaciÃ³n y dificultad para reconstruir incidentes. |
| Motivaciones | Cumplir protocolos, reducir pÃ©rdidas, coordinar mejor y demostrar la calidad de la operaciÃ³n. |
| Comportamiento digital | Trabaja principalmente en escritorio, compara varios casos y requiere detalle trazable. |
| Frase arquetÃ­pica (sÃ­ntesis, no cita textual) | â€œSi ocurre una incidencia, debo saber cuÃ¡ndo empezÃ³, quiÃ©n actuÃ³ y cÃ³mo terminÃ³.â€ |
| Escenario | Supervisa tres traslados; detecta una desviaciÃ³n tÃ©rmica, asigna una acciÃ³n, mantiene informada a la instituciÃ³n receptora y cierra el caso con evidencia. |

## 2.3.4. User Task Matrix

Frecuencia: **A** = alta, **M** = media, **B** = baja. Importancia: **C** = crÃ­tica, **I** = importante, **S** = secundaria.

| Tarea | Valeria: frecuencia | Valeria: importancia | Carlos: frecuencia | Carlos: importancia | InformaciÃ³n o evidencia requerida |
|---|:---:|:---:|:---:|:---:|---|
| Consultar estado del traslado | A | C | A | C | Estado, ubicaciÃ³n y Ãºltima actualizaciÃ³n. |
| Revisar ETA | A | C | A | I | Ruta, demora y hora estimada. |
| Verificar temperatura y condiciÃ³n | A | C | A | C | Lectura actual, rango permitido e historial. |
| Confirmar disponibilidad o stock | M | C | M | I | Cantidad estimada y variaciones. |
| Priorizar alertas | A | C | A | C | Severidad, carga afectada y tiempo transcurrido. |
| Coordinar respuesta a una incidencia | M | C | A | C | Responsable, acciÃ³n, canal y estado. |
| Registrar cadena de custodia | M | I | A | C | Entrega, recepciÃ³n, apertura y responsables. |
| Aceptar o rechazar entrega | M | C | M | C | CondiciÃ³n final, observaciÃ³n y firma/confirmaciÃ³n. |
| Consultar historial | B | I | A | C | LÃ­nea de tiempo inalterable. |
| Exportar reporte | B | S | M | C | Resumen, mediciones, incidentes y cierre. |

**PriorizaciÃ³n:** las funciones comunes y crÃ­ticas â€”estado, ETA, temperatura, alertas y cadena de custodiaâ€” deben formar el nÃºcleo del producto. Las vistas y permisos deben adaptarse a cada rol.

## 2.3.5. User Journey Map â€” Valeria

**Escenario:** recepciÃ³n de un medicamento refrigerado para una atenciÃ³n urgente.

| Etapa | AcciÃ³n | Pensamiento | EmociÃ³n | Dolor | Oportunidad |
|---|---|---|---|---|---|
| NotificaciÃ³n | Recibe aviso del traslado. | â€œÂ¿LlegarÃ¡ antes de que lo necesitemos?â€ | Expectativa y tensiÃ³n. | Aviso sin contexto suficiente. | Mostrar prioridad, carga y ETA desde la notificaciÃ³n. |
| Seguimiento | Consulta avance y condiciÃ³n. | â€œÂ¿El dato estÃ¡ actualizado?â€ | Vigilancia. | Debe llamar para confirmar. | UbicaciÃ³n, temperatura y sello de Ãºltima lectura. |
| Incidencia | Recibe alerta por desviaciÃ³n. | â€œÂ¿La carga sigue siendo utilizable?â€ | EstrÃ©s. | Alerta sin consecuencia ni responsable. | Severidad, rango, duraciÃ³n y acciÃ³n sugerida. |
| RecepciÃ³n | Revisa condiciÃ³n final. | â€œÂ¿Puedo aceptar esto con seguridad?â€ | Cautela. | Evidencia fragmentada. | Resumen de cumplimiento y excepciones. |
| ConfirmaciÃ³n | Acepta o rechaza y registra observaciÃ³n. | â€œDebe quedar constancia.â€ | Alivio si el cierre es claro. | Registro manual o duplicado. | Cierre guiado con responsable, hora y evidencia. |

## 2.3.6. User Journey Map â€” Carlos

**Escenario:** coordinaciÃ³n de un traslado con una incidencia tÃ©rmica.

| Etapa | AcciÃ³n | Pensamiento | EmociÃ³n | Dolor | Oportunidad |
|---|---|---|---|---|---|
| PlanificaciÃ³n | Registra carga, ruta y responsables. | â€œTodo debe estar asignado antes de salir.â€ | ConcentraciÃ³n. | Datos repartidos en varias fuentes. | Plantilla y validaciÃ³n previa a la salida. |
| Despacho | Confirma unidad y contenedor. | â€œÂ¿El equipo estÃ¡ conectado y listo?â€ | Control. | Falta de confirmaciÃ³n tÃ©cnica. | Lista de verificaciÃ³n y estado del sensor. |
| Monitoreo | Supervisa ubicaciÃ³n y condiciones. | â€œÂ¿QuÃ© traslado requiere atenciÃ³n?â€ | Vigilancia. | Sobrecarga de datos. | Dashboard por riesgo y filtros. |
| GestiÃ³n de incidente | Contacta responsables y registra acciones. | â€œNecesito contener el riesgo y dejar evidencia.â€ | EstrÃ©s. | ComunicaciÃ³n y bitÃ¡cora separadas. | Flujo de incidente con responsable y tiempos. |
| Cierre | Confirma entrega y genera reporte. | â€œÂ¿Puedo demostrar quÃ© ocurriÃ³?â€ | Alivio o preocupaciÃ³n. | ReconstrucciÃ³n manual. | LÃ­nea de tiempo y reporte automÃ¡tico. |

## 2.3.7. Empathy Map â€” Valeria

| Cuadrante | SÃ­ntesis |
|---|---|
| Dice | â€œNecesito informaciÃ³n claraâ€; â€œNo puedo perder tiempo buscando el datoâ€; â€œLa condiciÃ³n de la carga define mi decisiÃ³n.â€ |
| Piensa | Si el dato no estÃ¡ actualizado, no puede confiar plenamente; una demora puede afectar la atenciÃ³n. |
| Hace | Consulta el estado, confirma por otros canales, revisa condiciones y registra la recepciÃ³n. |
| Siente | Urgencia, incertidumbre y responsabilidad; alivio cuando la evidencia es clara. |
| Dolores | Alertas ambiguas, informaciÃ³n tardÃ­a, mÃºltiples llamadas y falta de trazabilidad inmediata. |
| Ganancias | Decidir rÃ¡pido, reducir riesgo clÃ­nico y contar con una constancia confiable. |

## 2.3.8. Empathy Map â€” Carlos

| Cuadrante | SÃ­ntesis |
|---|---|
| Dice | â€œDebo coordinar a todosâ€; â€œNecesito anticiparmeâ€; â€œLa operaciÃ³n tiene que quedar documentada.â€ |
| Piensa | Un incidente no gestionado puede causar pÃ©rdida de la carga y responsabilidad institucional. |
| Hace | Planifica, asigna, monitorea, llama, registra acciones y elabora reportes. |
| Siente | PresiÃ³n por el tiempo, frustraciÃ³n por datos dispersos y satisfacciÃ³n cuando el cierre es verificable. |
| Dolores | Duplicidad de registros, poca visibilidad, seguimiento manual y dificultad para auditar. |
| Ganancias | Control centralizado, respuesta temprana, responsables claros y evidencia exportable. |

## 2.3.9. Necesidades priorizadas

| Prioridad | Necesidad | Criterio de validaciÃ³n |
|:---:|---|---|
| 1 | Conocer condiciÃ³n y ubicaciÃ³n de la carga en tiempo casi real. | El usuario identifica estado, vigencia y riesgo sin recurrir a otro canal. |
| 2 | Recibir alertas accionables y priorizadas. | Cada alerta muestra severidad, causa, impacto, responsable y prÃ³ximo paso. |
| 3 | Mantener cadena de custodia verificable. | Cada evento registra fecha, hora, actor y evidencia. |
| 4 | Coordinar incidentes en un Ãºnico flujo. | Se asigna responsable, se registra acciÃ³n y se confirma resoluciÃ³n. |
| 5 | Cerrar y auditar el traslado. | Se obtiene una lÃ­nea de tiempo y un reporte de cumplimiento/excepciones. |

