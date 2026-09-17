# 2.3. Needfinding

El proceso de Needfinding permitió identificar y representar las necesidades, objetivos y desafíos de los segmentos objetivo de **Medical SMARTBOX**. A partir del análisis del contexto del transporte de productos médicos sensibles y de los perfiles de usuarios involucrados en dichas operaciones en Lima Metropolitana, se elaboraron artefactos empáticos centrados en el usuario conforme a las pautas de diseño UX de la industria (Nielsen Norman Group, Interaction Design Foundation), los cuales constituyen el cimiento empírico de las especificaciones y el diseño de la solución.

---

## 2.3.1. User Personas

A continuación, se presentan las fichas de User Persona elaboradas para cada uno de los dos segmentos objetivo de Medical SMARTBOX, sintetizando arquetipos construidos con base en las entrevistas a profundidad y la investigación de campo.

### User Persona 1: Empresas de Transporte y Operadores Logísticos de Cadena de Frío
Representa al personal operativo y asistencial en cabina de ambulancia (SAMU / empresas privadas), cuyo día a día enfrenta el congestionamiento limeño, la fatiga por traslados y el riesgo de desconexión accidental del suministro eléctrico de los equipos médicos.

![User Persona - Paramédico Javier Soto](../assets/chapter-2/user-persona-logistics.png)
*Nota: Elaboración propia en UXPressia para el Segmento 1 (Operadores de Transporte Asistencial).*

### User Persona 2: Centros de Salud y Cadenas Farmacéuticas
Representa al personal médico y farmacéutico de destino (cirujanos de trasplante, patólogos, directores técnicos de farmacia hospitalaria y auditores de calidad), cuya máxima preocupación es la viabilidad biológica celular y el cumplimiento inexcusable de las directivas sanitarias de DIGEMID.

![User Persona - Dr. Carlos Mendoza](../assets/chapter-2/user-persona-healthcare.png)
*Nota: Elaboración propia en UXPressia para el Segmento 2 (Centros de Salud y Farmacéuticas).*

---

## 2.3.2. User Task Matrix

La **User Task Matrix** consolida y prioriza las tareas fundamentales que ejecutan los usuarios en el ecosistema de transporte médico, clasificándolas según su frecuencia de ejecución y su nivel de criticidad o impacto para la viabilidad de la carga y el paciente.

| # | Tarea Clave de Usuario | Segmento Principal | Frecuencia | Criticidad / Importancia | Dolor u Oportunidad Asociada |
| :-: | :--- | :--- | :---: | :---: | :--- |
| **T01** | **Monitoreo continuo de temperatura interna del contenedor** | Ambos Segmentos | Alta (Tiempo real) | **Crítica** | Evitar la pérdida irreversible de órganos y hemoderivados por excursiones térmicas inadvertidas. |
| **T02** | **Supervisión de nivel de batería interna y conexión a 12V DC** | Segmento 1 (Ambulancia) | Alta (En ruta) | **Alta** | Prevenir descargas no detectadas por baches o desconexión del cable de 12V en cabina vehicular. |
| **T03** | **Recepción y reconocimiento de alertas críticas en cabina** | Segmento 1 (Ambulancia) | Media / Por excepción | **Crítica** | Proveer alarmas audibles y visuales no intrusivas que permitan actuar sin distraer la conducción. |
| **T04** | **Monitoreo remoto de ruta y tiempo estimado de arribo (ETA)** | Segmento 2 (Hospital) | Alta (En tránsito) | **Alta** | Notificación anticipada (10 min antes) para despejar rampa de trauma shock y alistar quirófano. |
| **T05** | **Desbloqueo seguro de tapa mediante clave dinámica OTP** | Segmento 2 (Receptor) | Baja (Una vez por viaje) | **Crítica** | Garantizar que únicamente el personal médico autorizado acceda a la carga en destino. |
| **T06** | **Firma y validación del acta digital de transferencia de custodia** | Ambos Segmentos | Baja (Cierre de viaje) | **Crítica** | Sustituir actas en papel por registros inmutables con sellado criptográfico para DIGEMID/SUSALUD. |
| **T07** | **Consulta de reportes históricos de excursión térmica para auditoría** | Segmento 2 (Auditoría) | Media (Mensual / Semanal) | **Media-Alta** | Certificar trazabilidad técnica ante auditorías hospitalarias e inspecciones regulatorias. |

---

## 2.3.3. User Journey Mapping

El **User Journey Mapping** ilustra la secuencia de experiencias, emociones, puntos de dolor y oportunidades de interacción de los usuarios arquetípicos a lo largo de las fases de Antes (despacho y pre-enfriamiento), Durante (tránsito y telemetría activa) y Después (entrega asistencial y custodia final).

### User Journey Map 1: Operador de Transporte Asistencial (Paramédico Javier Soto)
Mapea el recorrido desde la recepción de la orden de emergencia, la conexión vehicular del contenedor, la navegación en el tráfico limeño asistido por telemetría IoT, hasta la entrega formal en rampa hospitalaria.

![User Journey Map - Operadores Logísticos](../assets/chapter-2/user-journey-medical.png)
*Nota: Elaboración propia en UXPressia comparando el flujo As-Is (manual con incertidumbre) vs. To-Be (asistido con Medical SMARTBOX).*

### User Journey Map 2: Director Médico / Químico Farmacéutico (Dr. Carlos Mendoza)
Mapea la experiencia desde la coordinación de la solicitud urgente, el seguimiento en tiempo real de la temperatura y el ETA en el portal web, hasta la validación de la carga con token OTP en quirófano.

![User Journey Map - Centros de Salud](../assets/chapter-2/user-journey-logistics-healthcare.png)
*Nota: Elaboración propia en UXPressia detallando los puntos de contacto clínicos y la mitigación de tiempos muertos.*

---

## 2.3.4. Empathy Mapping

El **Empathy Mapping** profundiza en el modelo mental, aspiraciones, sensaciones y presiones cotidianas de los dos perfiles de usuario, permitiendo diseñar interfaces y flujos de software acordes con su contexto real de trabajo.

### Mapa de Empatía 1: Segmento Transporte y Paramédicos (Javier Soto)

![Empathy Map - Paramédico Javier Soto](../assets/chapter-2/empathy-map-medical.png)
*Nota: Elaboración propia en UXPressia para el perfil operativo de ambulancias.*

* **¿Qué piensa y siente?** Necesidad de proteger la vida del paciente; preocupación constante por quedar atrapado en el tráfico de Javier Prado o la Vía Expresa mientras traslada insumos perecibles; temor a ser culpado si una muestra se degrada sin que él se entere.
* **¿Qué ve?** Congestión vehicular caótica, baches en pistas, conductores que no ceden el paso a la ambulancia, tableros de instrumentos complejos.
* **¿Qué oye?** Sirenas de emergencia, indicaciones por radio de la central 106, quejas de familiares y urgencia del personal médico receptor.
* **¿Qué dice y hace?** Conduce a la defensiva, verifica visualmente los cables cada vez que puede, intenta llegar en el menor tiempo posible sin comprometer la seguridad.
* **Dolores (Pains):** Falta de visibilidad de la temperatura interna sin abrir la tapa; estrés por desconexiones accidentales de 12V.
* **Necesidades (Gains):** Señalización sonora clara y automática en cabina; tranquilidad de saber que la carga se mantiene en rango de 2 °C a 8 °C.

### Mapa de Empatía 2: Segmento Salud y Farmacéutica (Dr. Carlos Mendoza)

![Empathy Map - Dr. Carlos Mendoza](../assets/chapter-2/empathy-map-logistics-healthcare.png)
*Nota: Elaboración propia en UXPressia para el perfil clínico de centros hospitalarios.*

* **¿Qué piensa y siente?** Rigor ético y clínico; angustia ante la posibilidad de implantar un tejido dañado; presión por auditorías de DIGEMID y SUSALUD.
* **¿Qué ve?** Pacientes esperando en lista de trasplante; quirófanos con alto costo por minuto; cajas de tecnopor tradicionales con hielo gel sin telemetría.
* **¿Qué oye?** Reclamos por retrasos en cirugías programadas; exigencias regulatorias de trazabilidad documental inmutable.
* **¿Qué dice y hace?** Exige reportes de temperatura antes de aceptar cualquier lote; supervisa personalmente la apertura de contenedores críticos.
* **Dolores (Pains):** Incertidumbre ("caja negra") sobre el trato térmico de la muestra durante el trayecto; pérdida de tiempo por actas manuscritas ilegibles.
* **Necesidades (Gains):** Certificación digital de que la temperatura nunca superó los 8 °C; apertura con token OTP exclusivo y acta PDF con firma criptográfica.
