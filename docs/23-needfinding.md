## 2.3. Needfinding

El proceso de Needfinding permitió identificar y representar las necesidades, objetivos y dificultades de los dos segmentos objetivo de Medical SmartBox. Se partió de las seis entrevistas registradas en la sección 2.2 y de su análisis. Con esa evidencia se construyeron los siguientes artefactos: User Personas, User Task Matrix, User Journey Mapping y Empathy Mapping, siguiendo las pautas de Nielsen Norman Group y de Interaction Design Foundation.

Los segmentos usados en todo el informe son los definidos en la sección 1.3:

- **Segmento 1: personal médico y de emergencias.** Incluye paramédicos, enfermeros, médicos de emergencia y técnicos que participan en el traslado o recepción de productos médicos.
- **Segmento 2: operadores logísticos e instituciones de salud.** Incluye coordinadores de ambulancias, responsables de transporte médico, supervisores de cadena de frío, hospitales, clínicas, bancos de sangre, laboratorios, centros quirúrgicos, áreas de farmacia hospitalaria y personal que planifica, supervisa o recibe traslados médicos entre instituciones de salud.

### Criterios de agrupación y selección

Se evitó agrupar únicamente por edad o distrito. Los conjuntos se definieron por objetivos, tareas, responsabilidad y contexto de uso.

| Segmento | Entrevistados | Comportamiento común | Persona resultante |
|---|---|---|---|
| Segmento 1: personal médico y de emergencias | E1 Wilbert Toledo, E2 Aldair Lazaro, E3 Renato Calvo Yalan | Trasladan productos médicos en ambulancia mientras atienden al paciente o conducen, y no pueden verificar con frecuencia el estado de la carga. | Aldair Lazaro |
| Segmento 2: operadores logísticos e instituciones de salud | E4 Humberto Arellán, E5 Gianfranco Timoteo, E6 Karla Pacheco | Coordinan, reciben y auditan traslados, y dependen de llamadas y registros manuales para conocer su estado. | Gianfranco Timoteo |

### 2.3.1. User Personas

Se elaboró una ficha de User Persona por segmento en UXPressia. Cada ficha se basa en un entrevistado representativo y en los patrones comunes de su segmento, que se resumen en la tabla de trazabilidad.

**User Persona 1: Aldair Lazaro (Segmento 1: personal médico y de emergencias)**

Aldair tiene 26 años, vive en San Martín de Porres y es paramédico rescatista de ambulancia con 3 años de experiencia en emergencias prehospitalarias. Realiza entre 3 y 6 traslados asistenciales por turno y vigila al paciente y los fármacos a la vez. Registra la entrega en planillas de papel y se comunica con el hospital receptor por llamadas y WhatsApp.

![User Persona - Aldair Lazaro](assets/chapter-2/user-persona-aldair.png)
*Nota: Elaboración propia en UXPressia para el Segmento 1.*

**User Persona 2: Gianfranco Timoteo (Segmento 2: operadores logísticos e instituciones de salud)**

Gianfranco tiene 21 años, vive en Chorrillos y es coordinador de soporte y supervisor de cadena de frío en un laboratorio clínico. Audita la recepción de muestras biológicas y reactivos, y consolida en Excel las actas recibidas en papel. Detecta discrepancias de temperatura en aproximadamente el 15 % de los envíos que recibe en horas punta.

![User Persona - Gianfranco Timoteo](assets/chapter-2/user-persona-gianfranco.png)
*Nota: Elaboración propia en UXPressia para el Segmento 2.*

**Trazabilidad entre las entrevistas y las personas**

Los porcentajes se calculan sobre las tres entrevistas de cada segmento (n = 3).

| Característica | Segmento 1 (E1, E2, E3) | Segmento 2 (E4, E5, E6) |
|---|---|---|
| Rango de edad | 21 a 26 años (3/3) | 21 a 49 años (3/3) |
| Distrito | Pueblo Libre, San Martín de Porres y San Isidro (33.3 % cada uno) | Chancay, Chorrillos y Breña (33.3 % cada uno) |
| Ocupación | Paramédico o asistente paramédico de ambulancia (100 %) | Coordinación, supervisión o monitoreo de logística, cadena de frío o rutas (100 %) |
| Smartphone | 100 % (Android 66.7 %, iPhone 33.3 %) | 100 % (Android) |
| Otros dispositivos | Laptop o tablet (100 %) | Laptop o PC (66.7 %) |
| Navegador | Chrome (66.7 %; un entrevistado no lo indicó) | Chrome (66.7 %; un entrevistado no lo indicó) |
| Canales de comunicación | WhatsApp (66.7 %), llamadas de voz (33.3 %), Waze y Google Maps (33.3 %) | Llamadas telefónicas (66.7 %), WhatsApp corporativo (33.3 %), Excel para consolidar registros (33.3 %) |
| Variable subjetiva común | Estrés, ansiedad o presión por el tráfico y los tiempos de llegada (100 %) | Preocupación, ansiedad o agotamiento por falta de visibilidad y trazabilidad (100 %) |
| Necesidad principal expresada | Aviso o indicador del estado de la carga sin abrir el contenedor (66.7 %) | Información digital de ubicación, hora de llegada y temperatura (100 %) |
| Marcas e influencias | Samsung, Xiaomi, iPhone, WhatsApp, Waze, Google Maps | Android, Excel, WhatsApp |
| Personalidad | No relevada en las entrevistas | No relevada en las entrevistas |
| Estado civil | No relevado en las entrevistas | No relevado en las entrevistas |

*Fuente: registro y resúmenes de entrevistas (sección 2.2.2).*

***

### 2.3.2. User Task Matrix

La User Task Matrix reúne las tareas que realizan las dos personas para cumplir sus objetivos en el traslado de productos médicos, **independientemente de la existencia de una solución de software**. Para cada tarea se indica la frecuencia con que se realiza y su importancia para el resultado del traslado. Las tareas se identificaron a partir de las entrevistas E1 a E6.

Escala: Alta, Media y Baja. El símbolo "—" indica que la persona no realiza la tarea.

| Tarea | Aldair Lazaro (Segmento 1): Frecuencia | Aldair Lazaro (Segmento 1): Importancia | Gianfranco Timoteo (Segmento 2): Frecuencia | Gianfranco Timoteo (Segmento 2): Importancia |
|---|---|---|---|---|
| T01. Verificar la temperatura del contenedor con termómetro | Media | Alta | Media | Alta |
| T02. Conectar y vigilar los equipos al tomacorriente de 12 V del vehículo | Media | Media | — | — |
| T03. Conducir o gestionar la ruta en el tráfico para cumplir la hora de llegada | Alta | Alta | Media | Alta |
| T04. Comunicarse por llamada o WhatsApp para informar o consultar ubicación y hora de llegada | Alta | Media | Alta | Alta |
| T05. Registrar la entrega en planillas o actas de papel | Alta | Alta | Alta | Alta |
| T06. Descargar y leer los datos del datalogger USB en destino | — | — | Media | Alta |
| T07. Consolidar las actas y registros en hojas de cálculo | — | — | Alta | Alta |
| T08. Auditar la recepción y las discrepancias de temperatura | — | — | Alta | Alta |
| T09. Gestionar reclamos por lotes rechazados o fuera de rango | Baja | Alta | Media | Alta |
| T10. Organizar la recepción (citas, quirófano o sala) según la hora de llegada | — | — | Media | Alta |

**Análisis de la matriz**

Para Aldair Lazaro destacan T03, T04 y T05: conducir en el tráfico limeño, comunicarse con el destino y registrar la entrega en papel. Para Gianfranco Timoteo destacan T04, T05, T07 y T08: coordinar la llegada, mantener los registros y auditar las discrepancias.

Ambas personas coinciden en T01, T04, T05 y T09. Es decir, hoy verifican la temperatura de forma manual, se comunican por llamada o mensaje y dependen de registros en papel. Esto concuerda con el hallazgo de la sección 2.2.3, donde 6 de 6 entrevistados dependen de registros manuales.

La diferencia principal es el momento en que actúan: el Segmento 1 se concentra en el tránsito y la entrega, y el Segmento 2 en la preparación de la recepción, la consolidación de registros y la auditoría posterior.
***

## 2.3.3. User Journey Mapping

El **User Journey Mapping** ilustra la secuencia de experiencias, emociones, puntos de dolor y oportunidades de interacción de los usuarios arquetípicos a lo largo de las fases de Antes (despacho y pre-enfriamiento), Durante (tránsito y telemetría activa) y Después (entrega asistencial y custodia final).

### User Journey Map 1: Operador de Transporte Asistencial (Paramédico Javier Soto)
Mapea el recorrido desde la recepción de la orden de emergencia, la conexión vehicular del contenedor, la navegación en el tráfico limeño asistido por telemetría IoT, hasta la entrega formal en rampa hospitalaria.

![User Journey Map - Operadores Logísticos](assets/chapter-2/user-journey-medical.png)
*Nota: Elaboración propia en UXPressia comparando el flujo As-Is (manual con incertidumbre) vs. To-Be (asistido con Medical SMARTBOX).*

### User Journey Map 2: Director Médico / Químico Farmacéutico (Dr. Carlos Mendoza)
Mapea la experiencia desde la coordinación de la solicitud urgente, el seguimiento en tiempo real de la temperatura y el ETA en el portal web, hasta la validación de la carga con token OTP en quirófano.

![User Journey Map - Centros de Salud](assets/chapter-2/user-journey-logistics-healthcare.png)
*Nota: Elaboración propia en UXPressia detallando los puntos de contacto clínicos y la mitigación de tiempos muertos.*

***

## 2.3.4. Empathy Mapping

El **Empathy Mapping** profundiza en el modelo mental, aspiraciones, sensaciones y presiones cotidianas de los dos perfiles de usuario, permitiendo diseñar interfaces y flujos de software acordes con su contexto real de trabajo.

### Mapa de Empatía 1: Segmento Transporte y Paramédicos (Javier Soto)

![Empathy Map - Paramédico Javier Soto](assets/chapter-2/empathy-map-medical.png)
*Nota: Elaboración propia en UXPressia para el perfil operativo de ambulancias.*

* **¿Qué piensa y siente?** Necesidad de proteger la vida del paciente; preocupación constante por quedar atrapado en el tráfico de Javier Prado o la Vía Expresa mientras traslada insumos perecibles; temor a ser culpado si una muestra se degrada sin que él se entere.
* **¿Qué ve?** Congestión vehicular caótica, baches en pistas, conductores que no ceden el paso a la ambulancia, tableros de instrumentos complejos.
* **¿Qué oye?** Sirenas de emergencia, indicaciones por radio de la central 106, quejas de familiares y urgencia del personal médico receptor.
* **¿Qué dice y hace?** Conduce a la defensiva, verifica visualmente los cables cada vez que puede, intenta llegar en el menor tiempo posible sin comprometer la seguridad.
* **Dolores (Pains):** Falta de visibilidad de la temperatura interna sin abrir la tapa; estrés por desconexiones accidentales de 12V.
* **Necesidades (Gains):** Señalización sonora clara y automática en cabina; tranquilidad de saber que la carga se mantiene en rango de 2 °C a 8 °C.

### Mapa de Empatía 2: Segmento Salud y Farmacéutica (Dr. Carlos Mendoza)

![Empathy Map - Dr. Carlos Mendoza](assets/chapter-2/empathy-map-logistics-healthcare.png)
*Nota: Elaboración propia en UXPressia para el perfil clínico de centros hospitalarios.*

* **¿Qué piensa y siente?** Rigor ético y clínico; angustia ante la posibilidad de implantar un tejido dañado; presión por auditorías de DIGEMID y SUSALUD.
* **¿Qué ve?** Pacientes esperando en lista de trasplante; quirófanos con alto costo por minuto; cajas de tecnopor tradicionales con hielo gel sin telemetría.
* **¿Qué oye?** Reclamos por retrasos en cirugías programadas; exigencias regulatorias de trazabilidad documental inmutable.
* **¿Qué dice y hace?** Exige reportes de temperatura antes de aceptar cualquier lote; supervisa personalmente la apertura de contenedores críticos.
* **Dolores (Pains):** Incertidumbre ("caja negra") sobre el trato térmico de la muestra durante el trayecto; pérdida de tiempo por actas manuscritas ilegibles.
* **Necesidades (Gains):** Certificación digital de que la temperatura nunca superó los 8 °C; apertura con token OTP exclusivo y acta PDF con firma criptográfica.

***

### Síntesis de Necesidades Priorizadas

| Prioridad | Necesidad | Criterio de validación |
|:---:|---|---|
| 1 | Conocer condición y ubicación de la carga en tiempo casi real. | El usuario identifica estado, vigencia y riesgo sin recurrir a otro canal. |
| 2 | Recibir alertas accionables y priorizadas. | Cada alerta muestra severidad, causa, impacto, responsable y próximo paso. |
| 3 | Mantener cadena de custodia verificable. | Cada evento registra fecha, hora, actor y evidencia. |
| 4 | Coordinar incidentes en un único flujo. | Se asigna responsable, se registra acción y se confirma resolución. |
| 5 | Cerrar y auditar el traslado. | Se obtiene una línea de tiempo y un reporte de cumplimiento/excepciones. |
