# 2.5. Ubiquitous Language

En esta sección se establece el glosario formal de términos y conceptos del dominio del negocio (*Smart Medical Container & Emergency Transport*), garantizando una comunicación unívoca, rigurosa y libre de ambigüedades entre los profesionales de la salud (médicos cirujanos de trasplante, paramédicos de emergencia, químicos farmacéuticos), los operadores logísticos de ambulancias, las entidades reguladoras peruanas (MINSA, DIGEMID, DIGDOT) y el equipo de desarrollo de software.

Conforme a las directrices de *Domain-Driven Design* (Eric Evans, Martin Fowler) y los criterios de la rúbrica ABET (Páginas 13 y 14 del documento rector), todos los términos se presentan en idioma inglés con su equivalente formal en español entre paréntesis. Cada definición ha sido redactada estrictamente desde la perspectiva clínica, operativa y legal del negocio asistencial en Lima Metropolitana, omitiendo con total rigurosidad tecnicismos de ingeniería de software (tales como tablas relacionales, llaves foráneas, APIs, endpoints o controladores).

Cada uno de los términos listados a continuación constituye la base semántica que da origen directo a los Agregados, Entidades, Objetos de Valor (*Value Objects*) y Eventos de Dominio que estructuran los Capítulos 4.6 (Arquitectura DDD), 4.7 (Diseño Orientado a Objetos) y 4.8 (Diseño de Base de Datos):

<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Ubiquitous Term</th>
      <th>Definition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Health Institution (Institución de Salud)</strong></td>
      <td>Establecimiento prestador de servicios de salud público o privado (hospital nacional, instituto especializado, clínica o banco de sangre) facultado legalmente para actuar como centro extractor, donante o receptor en la red asistencial metropolitana.</td>
    </tr>
    <tr>
      <td><strong>Emergency Ambulance Unit (Unidad de Ambulancia Asistencial)</strong></td>
      <td>Vehículo terrestre de emergencia médica (Tipo II o III) acondicionado para el transporte prehospitalario de pacientes críticos o insumos vitales, equipado con soporte eléctrico continuo de 12V en cabina y sistema telemático de navegación.</td>
    </tr>
    <tr>
      <td><strong>Smart Medical Container (Contenedor Médico Inteligente)</strong></td>
      <td>Unidad física móvil e isotérmica de grado clínico instalada en la ambulancia, dotada de aislamiento térmico de alta densidad, alimentación energética dual (red fija hospitalaria y toma vehicular de 12V), instrumentación de medición bioambiental continua y mecanismo de cierre electromecánico de seguridad.</td>
    </tr>
    <tr>
      <td><strong>Medical and Biological Payload (Carga Médica y Biológica)</strong></td>
      <td>Conjunto de insumos terapéuticos y biológicos altamente termosensibles y críticos trasladados en la unidad de transporte asistido, que comprende órganos sólidos para trasplante (corazón, riñón, hígado), tejidos humanos, componentes sanguíneos (paquetes globulares, plasma), vacunas e inmunobiológicos, y medicamentos de alto costo sujetos a rigurosos límites de supervivencia biológica.</td>
    </tr>
    <tr>
      <td><strong>Transport Mission (Misión de Transporte Asistido)</strong></td>
      <td>Operación asistencial protocolizada de traslado médico entre una institución de salud de origen y una de destino, gobernada por una ventana temporal crítica, una tripulación paramédica asignada y directivas estrictas de conservación bioambiental.</td>
    </tr>
    <tr>
      <td><strong>Cold Chain (Cadena de Frío)</strong></td>
      <td>Proceso logístico ininterrumpido de control y supervisión ambiental que asegura que los insumos biológicos y farmacéuticos se mantengan dentro de los intervalos térmicos normativos reglamentados por el MINSA y la DIGEMID (+2 °C a +4 °C para órganos; +2 °C a +8 °C para hemoderivados y vacunas) durante todas las etapas de custodia y desplazamiento en ambulancia.</td>
    </tr>
    <tr>
      <td><strong>Thermal Excursion (Excursión Térmica)</strong></td>
      <td>Incidente crítico originado cuando la temperatura interna de la cámara del contenedor traspasa los márgenes de seguridad normativos durante un tiempo mayor a la tolerancia asistencial permitida, comprometiendo la estabilidad fisicoquímica o viabilidad celular del insumo y tipificándose como una no conformidad sanitaria grave.</td>
    </tr>
    <tr>
      <td><strong>Cold Ischemia Time (Tiempo de Isquemia Fría)</strong></td>
      <td>Intervalo de tiempo fisiológico máximo que un órgano para trasplante puede permanecer sin irrigación sanguínea en preservación hipotérmica (desde el clampado aórtico en el hospital donante hasta su revascularización en quirófano) antes de sufrir necrosis tisular irreversible, gobernado por la Directiva Sanitaria N° 152/DIGDOT.</td>
    </tr>
    <tr>
      <td><strong>Weight-Based Medical Stock (Stock Médico Ponderal)</strong></td>
      <td>Estimación cuantitativa en tiempo real de la cantidad de medicamentos, ampollas o insumos almacenados dentro del compartimento, calculada a partir de las variaciones de masa registradas continuamente por la celda de carga de precisión, permitiendo prevenir desabastecimientos en ruta o sustracciones clandestinas.</td>
    </tr>
    <tr>
      <td><strong>Container Autonomy and Telemetry (Telemetría y Autonomía del Contenedor)</strong></td>
      <td>Flujo periódico de mediciones físicas directas (temperatura interna de cámara, peso en bandeja, estado del sensor magnético de tapa, voltaje y porcentaje de carga de la batería interna Li-Ion) transmitidas de forma continua para garantizar que el soporte térmico se mantenga activo aun ante desconexiones de la red de la ambulancia.</td>
    </tr>
    <tr>
      <td><strong>Vehicle Telematics and Fuel Level (Telemática Vehicular y Nivel de Combustible)</strong></td>
      <td>Parámetros operativos capturados desde la unidad móvil de emergencia (nivel de reserva de combustible, velocidad de desplazamiento y coordenadas geográficas) que permiten evaluar la autonomía del vehículo para completar la misión de transporte asistido sin riesgo de detención imprevista en ruta.</td>
    </tr>
    <tr>
      <td><strong>Hospital Geofence (Geocerca Hospitalaria)</strong></td>
      <td>Perímetro geográfico virtual delimitado alrededor de la institución de salud receptora (típicamente con un radio de 2 km), cuyo traspaso por la ambulancia activa automáticamente los protocolos de pre-arribo y habilita la autorización del desbloqueo digital.</td>
    </tr>
    <tr>
      <td><strong>Tamper-Evident Electronic Lock (Cierre Electrónico de Custodia)</strong></td>
      <td>Cerrojo electromecánico de alta seguridad que bloquea físicamente la apertura de la tapa superior del contenedor durante el viaje, habilitando su apertura únicamente cuando la ambulancia ingresa al perímetro geográfico del hospital receptor y el médico autorizado valida su identidad mediante un código de un solo uso (OTP).</td>
    </tr>
    <tr>
      <td><strong>Dynamic Route ETA (Tiempo Estimado de Llegada Dinámico)</strong></td>
      <td>Cálculo predictivo continuo de la duración remanente y la hora exacta de arribo de la ambulancia al hospital de destino, ajustado dinámicamente según las variaciones del flujo vehicular, congestión e incidentes de tránsito en los corredores hospitalarios de Lima Metropolitana.</td>
    </tr>
    <tr>
      <td><strong>Critical Operational Alert (Alerta Operativa Crítica)</strong></td>
      <td>Notificación de alta prioridad y respuesta inmediata que combina avisos acústico-visuales locales en la cabina de la ambulancia y avisos digitales a la central de despacho asistencial, detonada automáticamente ante excursiones térmicas, caídas en el nivel de combustible, apertura indebida o anomalías ponderales.</td>
    </tr>
    <tr>
      <td><strong>Hospital Pre-Arrival Notice (Aviso de Pre-Arribo Hospitalario)</strong></td>
      <td>Comunicación protocolar preventiva enviada automáticamente al equipo médico y quirúrgico del hospital receptor cuando la ambulancia se encuentra a una proximidad crítica (10 minutos de arribo o cruce de geocerca), facilitando el alistamiento de quirófano, esterilización de instrumental y despeje de rampas de trauma shock.</td>
    </tr>
    <tr>
      <td><strong>Chain of Custody (Cadena de Custodia Sanitaria)</strong></td>
      <td>Registro documental, físico y legal continuo e inalterable que certifica la tenencia, ubicación, trazabilidad horaria, eventos de manipulación y curvas bioambientales de la carga médica desde el centro donante o farmacia de origen hasta su recepción definitiva.</td>
    </tr>
    <tr>
      <td><strong>Custody Handover Act (Acta de Entrega y Trazabilidad de Custodia)</strong></td>
      <td>Documento protocolar formal generado al término del traslado asistencial, donde la tripulación paramédica y el equipo médico receptor rubrican mancomunadamente la conformidad del estado físico, el balance de stock y el dictamen de viabilidad biológica con el respaldo de la curva térmica completa del trayecto.</td>
    </tr>
  </tbody>
</table>
