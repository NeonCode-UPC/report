# 2.3. Needfinding

El proceso de Needfinding permitió identificar y representar las necesidades, objetivos y desafíos de los segmentos objetivo de Medical SmartBox. A partir del análisis del contexto del transporte de productos médicos sensibles y de los perfiles de usuarios involucrados en dichas operaciones, se elaboran los siguientes artefactos centrados en el usuario, los cuales servirán como base para el diseño de la solución.

## 2.3.1. User Personas

A continuación, se presentan las fichas de User Persona elaboradas para cada uno de los segmentos objetivo de Medical SmartBox. Cada ficha representa un arquetipo de usuario construido a partir de las características, responsabilidades, necesidades, objetivos y frustraciones identificadas dentro del dominio del transporte médico y la cadena de frío.

### User Persona 1: Personal médico y de emergencias

![User Persona - Personal médico y de emergencias](../assets/chapter-2/user-persona-logistics.png)

### User Persona 2: Operadores logísticos e instituciones de salud

![User Persona - Operadores logísticos e instituciones de salud](../assets/chapter-2/user-persona-healthcare.png)

## 2.3.2. User Task Matrix

La User Task Matrix permite visualizar y comparar las tareas que cada segmento objetivo realiza para cumplir sus objetivos dentro de los procesos de transporte y recepción de productos médicos, independientemente de la existencia de una solución tecnológica. A continuación, se presentan las principales tareas identificadas para cada segmento, junto con su frecuencia e importancia para los User Personas correspondientes.

| **Tarea** | **Personal médico y de emergencias (Frecuencia / Importancia)** | **Operadores logísticos e instituciones de salud (Frecuencia / Importancia)** |
| --- | --- | --- |
| **Supervisar el estado de los productos médicos durante el transporte** | Alta / Alta | Media / Alta |
| **Coordinar y dar seguimiento a los transportes en curso** | Alta / Alta | Alta / Alta |
| **Verificar que los productos se mantengan en condiciones adecuadas** | Alta / Alta | Alta / Alta |
| **Identificar y atender incidentes durante el transporte** | Alta / Alta | Media / Alta |
| **Consultar la ubicación y el tiempo estimado de llegada de los transportes** | Alta / Alta | Alta / Alta |
| **Coordinar acciones ante retrasos o cambios durante el traslado** | Alta / Alta | Alta / Alta |
| **Registrar información relacionada con el transporte y la entrega** | Alta / Media | Alta / Alta |
| **Verificar las condiciones de los productos al momento de la recepción** | Media / Alta | Alta / Alta |
| **Confirmar la recepción de medicamentos o productos médicos** | Media / Alta | Alta / Alta |
| **Revisar antecedentes de transportes y entregas anteriores** | Media / Alta | Media / Alta |
| **Generar o revisar evidencias de las condiciones del transporte** | Media / Alta | Media / Alta |
| **Investigar las causas de incidentes o problemas durante una entrega** | Media / Alta | Media / Alta |

**Análisis de la User Task Matrix:** Las empresas de transporte y los operadores logísticos presentan una alta frecuencia e importancia en tareas relacionadas con la supervisión y coordinación de los transportes, debido a que deben gestionar continuamente el traslado de productos médicos y responder ante posibles incidentes. Por su parte, los centros de salud y las cadenas farmacéuticas concentran sus actividades principalmente en el seguimiento de los envíos, la verificación de las condiciones de los productos y la confirmación de su recepción. Para ambos segmentos, las tareas relacionadas con el control de las condiciones del transporte, la ubicación de los envíos y la gestión de incidentes presentan una importancia elevada, debido al impacto que pueden tener sobre la seguridad y trazabilidad de los productos médicos.

## 2.3.3. User Journey Mapping

Los User Journey Maps representan el recorrido end-to-end que cada User Persona realiza actualmente (situación As-Is) para cumplir con sus objetivos dentro de los procesos relacionados con el traslado, monitoreo y recepción de productos médicos sensibles, sin la existencia de Medical SmartBox. Estos mapas permiten identificar los puntos de dolor (pains) y las oportunidades de mejora (gains) presentes en las actividades actuales de los usuarios.

- **Segmento 1: Personal médico y de emergencias**

El siguiente Journey Map representa el recorrido de Renato Calvo Yalan, integrante del personal médico y de emergencias, durante las actividades relacionadas con el traslado y recepción de medicamentos, órganos e insumos médicos sensibles. El recorrido comprende la coordinación previa del traslado, el seguimiento de las condiciones de los productos, la espera durante el transporte y la recepción de los insumos. Durante este proceso, el usuario necesita contar con información oportuna sobre las condiciones de conservación, el tiempo estimado de llegada y la disponibilidad de los productos para poder actuar ante posibles incidentes.

![User Journey Map - Personal médico y de emergencias](../assets/chapter-2/user-journey-medical.png)

- **Segmento 2: Operadores logísticos e instituciones de salud**

El siguiente Journey Map representa el recorrido de Karla Pacheco, auxiliar administrativa del área de salud encargada del monitoreo y registro de rutas de ambulancias y de la recolección de muestras o materiales médicos. El recorrido comprende la coordinación de las rutas, el registro de información, el seguimiento del transporte y la recepción de los materiales. Durante este proceso, la comunicación con los transportistas y la disponibilidad de información actualizada resultan importantes para mantener un seguimiento adecuado de las rutas y registrar correctamente el desarrollo de cada traslado.

![User Journey Map - Operadores logísticos e instituciones de salud](../assets/chapter-2/user-journey-logistics-healthcare.png)

## 2.3.4. Empathy Mapping

Los Empathy Maps permiten profundizar en la comprensión de cada User Persona, explorando lo que piensa, siente, ve, oye, dice y hace dentro de su contexto relacionado con el traslado y manejo de productos médicos sensibles. Estos mapas permiten identificar los principales pains y gains de cada segmento y comprender las necesidades que deben ser consideradas durante el diseño de Medical SmartBox.

- **Segmento 1: Personal médico y de emergencias**

El siguiente Mapa de Empatía profundiza en la experiencia de Aldair Lazaro, integrante del personal médico y de emergencias. Se identifican sus principales pensamientos y sentimientos relacionados con la responsabilidad de garantizar que los productos médicos sensibles lleguen en condiciones adecuadas, así como lo que observa durante el traslado, la información que recibe de otros participantes del proceso y las acciones que realiza para verificar las condiciones y disponibilidad de los productos. El mapa también permite identificar como principales pains la falta de información oportuna, la incertidumbre ante posibles incidentes y la dificultad para conocer el estado del traslado, mientras que entre los gains se encuentran una mayor visibilidad del proceso, información confiable y capacidad de respuesta ante situaciones críticas.

![Empathy Map - Personal médico y de emergencias](../assets/chapter-2/empathy-map-medical.png)

- **Segmento 2: Operadores logísticos e instituciones de salud**

El siguiente Mapa de Empatía profundiza en la experiencia de Gianfranco Timoteo, quien participa en actividades relacionadas con el soporte y registro dentro de una institución de salud. Se identifican sus principales pensamientos y sentimientos relacionados con la necesidad de mantener información organizada y disponible, así como lo que observa en el proceso de transporte, la información que recibe de otros participantes y las actividades que realiza para registrar y dar seguimiento a los traslados. El mapa permite identificar como principales pains las dificultades de comunicación, la información distribuida y el seguimiento de las rutas, mientras que entre los gains se encuentran una mejor coordinación, información centralizada y mayor facilidad para consultar el estado de los transportes.

![Empathy Map - Operadores logísticos e instituciones de salud](../assets/chapter-2/empathy-map-logistics-healthcare.png)
