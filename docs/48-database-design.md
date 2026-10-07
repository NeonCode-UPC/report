# **4.8. Database Design**

El diseño de la base de datos de **Medical SMARTBOX** establece la arquitectura de persistencia física que da soporte a los procesos transaccionales, telemétricos y de auditoría clínica de la plataforma. A diferencia del Diagrama de Clases de Software (Capítulo 4.7), cuyo foco es la encapsulación del comportamiento y la protección de invariantes en memoria mediante agregados de Domain-Driven Design (DDD), el modelo relacional se especializa en la integridad referencial estricta, la normalización formal, la indexación de alta velocidad para series temporales de IoT y la inmutabilidad jurídica de los registros de custodia requeridos por las entidades regulatorias peruanas (**DIGEMID** y **MINSA**).

La persistencia del sistema está gobernada por un enfoque **Code-First** a través de **Entity Framework Core 10.0 (.NET 10 LTS)** sobre el motor relacional **MySQL Server 8.0 (Enterprise / Community)** utilizando el motor de almacenamiento **InnoDB**. Siguiendo las convenciones oficiales de desarrollo para Microsoft .NET y ASP.NET Core Framework, la configuración de esquemas se desacopla mediante clases `IEntityTypeConfiguration<TEntity>` basadas en **Fluent API**, asegurando que el modelo de dominio permanezca limpio (*Persistence Ignorance*) mientras que la base de datos física explota al máximo las restricciones nativas del motor (`FOREIGN KEY`, `UNIQUE`, `CHECK`, `INDEX`).

### Decisiones Arquitectónicas de Persistencia Relacional:
1. **Motor de Almacenamiento y Conjunto de Caracteres:**  
   Se selecciona exclusivamente **InnoDB** por su soporte nativo de transacciones compatibles con **ACID**, bloqueo a nivel de fila (*row-level locking*) y soporte de claves foráneas con verificación en tiempo de ejecución. La base de datos opera bajo el conjunto de caracteres `utf8mb4` y la colación `utf8mb4_unicode_ci`, garantizando soporte pleno para caracteres especiales clínicos, acentos en español latinoamericano (`es_419`) y firmas criptográficas sin riesgo de truncamiento.
2. **Identificadores Universales Únicos Ordenables Cronológicamente (UUIDv7 / RFC 9562):**  
   Para desacoplar la generación de identificadores entre los nodos de borde (ESP32 en ambulancias), las capas de dominio y los microservicios sin colisiones ni dependencia de consultas previas a secuencias centrales, todas las entidades maestras y transaccionales utilizan **UUID versión 7 (RFC 9562)** mapeados nativamente en C# (.NET 10 LTS mediante `Guid.CreateVersion7()`) y persistidos como columnas `CHAR(36)` con formato canónico de guiones (`8-4-4-4-12`). La adopción de UUIDv7 frente a UUIDv4 radica en su naturaleza *k-sortable*: al incorporar una marca de tiempo UNIX de 48 bits con resolución de milisegundos en los bits más significativos, las inserciones en MySQL InnoDB se realizan de forma secuencial y monótona al final del árbol B+Tree, eliminando las costosas particiones de páginas (*page splits*) y preservando la eficiencia del *InnoDB Buffer Pool*. A su vez, se descarta el uso de claves puramente incrementales (`AUTO_INCREMENT`) en entidades de negocio para blindar la plataforma contra ataques de enumeración e IDOR en APIs clínicas, garantizar la inmutabilidad jurídica de los registros médicos y permitir la generación segura de identidades en operaciones desconectadas (*offline*) de las ambulancias. Como única excepción técnica, se preserva el tipo secuencial `BIGINT UNSIGNED AUTO_INCREMENT` exclusivamente en la tabla de series temporales de ultra-alta frecuencia (`telemetry_logs`), priorizando la máxima densidad de bytes por página en la persistencia masiva de lecturas IoT.
3. **Estrategia de Aplanamiento de Value Objects (*Flattening*):**  
   Conforme a los patrones de diseño de arquitectura orientada al dominio formulados por Nick Tune, los *Value Objects* del dominio carecen de identidad propia y representan atributos compuestos inmutables. Para evitar la sobrecarga de uniones relacionales (*JOINs*) en consultas críticas, se aplica la técnica de *Value Object Flattening*:
   * El Value Object `IschemiaTimeLimit` se aplana en las columnas `max_ischemia_hours` e `ischemia_warning_hours` dentro de `transport_orders`.
   * El Value Object `OtpToken` se aplana en las columnas `otp_code_hash`, `otp_expires_at` y `otp_attempt_count` dentro de `custody_transfers`.
   * Las coordenadas geográficas de telemetría se aplanan en `latitude` y `longitude` en `telemetry_logs`.
4. **Marcas Temporales UTC con Precisión de Microsegundos:**  
   Dado que los contenedores inteligentes registran desviaciones térmicas en milisegundos y las ambulancias se desplazan rápidamente por arterias viales, todas las fechas y horas se registran en formato universal coordinado (`DateTime.UtcNow`) utilizando el tipo `DATETIME(6)`. Esto elimina ambigüedades por husos horarios y garantiza orden estricto en el procesamiento reactivo de eventos.
5. **Estrategia de Persistencia de Entidades Internas de Agregados (*Entity Flattening*):**  
   En el modelo orientado a objetos (Capítulo 4.7), la raíz de agregado `SmartContainer` encapsula entidades subordinadas como `ElectromechanicalLock` (cerrojo de seguridad) y `BatteryUnit` (unidad de alimentación LiFePO4), mientras que la raíz `DispatchTrip` encapsula la entidad de ruta `TransportRoute`. En la base de datos física relacional, para evitar la proliferación innecesaria de tablas satélite 1 a 1 y maximizar la eficiencia en consultas operativas sin sobrecarga de operaciones `JOIN`, estas entidades subordinadas se integran y aplanan directamente como columnas dentro de sus tablas principales:
   * En `smart_containers`: se persisten atómicamente `lock_state` (estado del cerrojo), `battery_percentage` (porcentaje de carga) e `is_12v_connected` (alimentación auxiliar 12V).
   * En `dispatch_trips`: se persisten directamente los atributos de ruta calculados `distance_km`, `planned_duration_minutes`, `current_delay_minutes` y `polyline_coordinates`.  
   Esta decisión garantiza un esquema de almacenamiento de alto rendimiento para las consultas operativas en ruta sin comprometer la encapsulación conceptual definida en el diseño orientado a objetos.
6. **Conversión de Tipos Numéricos entre Dominio y Persistencia (`double` a `DECIMAL`):**  
   En el modelo de clases de dominio (Capítulo 4.7), las lecturas sensoriales y telemétricas (temperatura, peso neto y coordenadas geográficas) se representan como tipos numéricos en coma flotante para optimizar el rendimiento computacional de cálculos en memoria y procesamiento de flujos IoT. En la persistencia física en MySQL, estos valores se almacenan rigurosamente como tipos de coma fija `DECIMAL(p, s)` (`DECIMAL(4,2)` para temperatura, `DECIMAL(6,2)` para peso en gramos y `DECIMAL(10,8)` / `DECIMAL(11,8)` para latitud/longitud), eliminando cualquier riesgo de discrepancia por redondeo o imprecisión binaria en los registros médicos.
7. **Delimitación de Flota Vehicular y Activos Externos (Segmento 1):**  
   En el modelo SaaS, las ambulancias constituyen activos vehiculares de transporte sanitario operados por terceros (Segmento 1) identificados por su número de placa (`assigned_vehicle_plate`) en las órdenes de despacho (`dispatch_trips`). El control de cuotas comerciales de suscripción (`max_ambulances` en `subscription_plans`) se valida a nivel de servicio contra las unidades móviles simultáneamente activas, preservando el foco del software exclusivamente en la gestión del contenedor médico inteligente y evitando la sobreingeniería de tablas maestras vehiculares internas.
8. **Invariantes Térmicas de Firmware y Control de Celda Peltier:**  
   La celda termoeléctrica Peltier opera bajo un punto de consigna (*setpoint*) fijo y normado (+4.0 °C) implementado como invariante de control en el firmware autónomo del ESP32. Su estado no demanda columnas de configuración mutable en la tabla de catálogo `smart_containers`, sino que su modulación dinámica de potencia se audita y persiste históricamente mediante la columna `peltier_power_pct` en la tabla de series temporales de alta frecuencia `telemetry_logs`.
9. **Correspondencia de Nomenclatura entre Dominio y Esquema Físico:**  
   Para preservar la pureza del modelo conceptual de dominio (Capítulo 4.7) formulado bajo el lenguaje ubicuo (*PascalCase*) y garantizar total coherencia con las convenciones relacionales del esquema físico en MySQL 8.0 (*snake_case*), se formaliza la siguiente matriz de correspondencia:
   * `SubscriptionPlan.PlanCode` → `code` (tabla `subscription_plans`).
   * `SubscriptionPlan.MaxFleetBoxes` → `max_smartboxes` (tabla `subscription_plans`).
   * `SubscriptionPlan.MonthlyCostUsd` → `monthly_price_usd` (tabla `subscription_plans`).
   * `HospitalInstitution.OfficialName` → `name` (tabla `hospital_institutions`).
   * `UserAccount.ProfessionalLicenseNumber` → `medical_license_number` (tabla `users`).
   * `TransportOrder.Priority` → `clinical_priority` (tabla `transport_orders`).
   * `CustodyTransfer.TransferredAt` → `completed_at` (tabla `custody_transfers`).
   * `DigitalAuditManifest.GeneratedAt` → `sealed_at` (tabla `digital_audit_manifests`).
   * `DigitalAuditManifest.CloudStorageUrl` → `cloud_storage_pdf_url` (tabla `digital_audit_manifests`).

***

### **4.8.1. Database Diagrams**

#### **1. Justificación de Normalización y Desnormalización Controlada**

El modelo de datos relacional de Medical SMARTBOX ha sido diseñado bajo una estricta disciplina de normalización matemática para erradicar redundancias y anomalías de actualización, incorporando desnormalización controlada únicamente en puntos donde la seguridad clínica y el rendimiento de consulta lo justifican plenamente:

* **Primera Forma Normal (1NF):**  
  Todas las columnas contienen exclusivamente valores atómicos e indivisibles. No existen grupos repetitivos ni atributos multivaluados; por ejemplo, las coordenadas poligonales de rutas se representan mediante colecciones ordenadas o columnas específicas de latitud/longitud decimal, y la tripulación de la ambulancia se descompone en roles foráneos atómicos (`assigned_driver_user_id` y `assigned_paramedic_user_id`).
* **Segunda Forma Normal (2NF):**  
  El modelo se encuentra en 1NF y cada atributo no primario posee una dependencia funcional completa de la clave primaria. En ninguna tabla existen dependencias parciales, puesto que todas las tablas maestras emplean identificadores subrogados únicos (`id`), garantizando que cada columna describa íntegramente a dicha entidad.
* **Tercera Forma Normal (3NF):**  
  El modelo se encuentra en 2NF y ningún atributo no clave depende transitivamente de otra columna no clave. Por ejemplo, los datos del hospital de origen y destino (RUC, dirección, acreditación) no se duplican dentro de `transport_orders`, sino que se relacionan mediante claves foráneas normalizadas (`origin_hospital_id`, `destination_hospital_id`) hacia `hospital_institutions`.
* **Desnormalización Controlada Justificada por Criterio Clínico:**  
  En la tabla `digital_audit_manifests` (Contexto de Cadena de Custodia), se almacenan de manera precalculada las métricas `average_temperature_celsius`, `min_temperature_celsius`, `max_temperature_celsius` y `total_excursion_seconds`.  
  *Justificación Técnica y Legal:* Un traslado en ambulancia puede generar miles de lecturas de telemetría en `telemetry_logs`. Si un auditor de calidad de DIGEMID o un cirujano de trasplantes requiere verificar el acta de entrega durante una auditoría o minutos antes de implantar un corazón, calcular agregaciones dinámicas (`AVG`, `MIN`, `MAX`) sobre millones de filas degradaría la base de datos y retardaría la respuesta médica. Además, el acta digital constituye un documento médico-legal sellado criptográficamente con hash SHA-256 (`cryptographic_hash_sha256`); desnormalizar estas métricas en el momento exacto del cierre de custodia garantiza que las cifras auditadas permanezcan inmutables en el tiempo, protegidas de cualquier alteración histórica o depuración de logs sensoriales antiguos.
* **Principio de Custodia Unívoca y Ausencia de Tablas N:M:**  
  A diferencia de aplicaciones comerciales genéricas, el modelo relacional descarta de forma deliberada el uso de tablas intermedias de descomposición muchos a muchos (N:M). Bajo la normativa de DIGEMID (R.M. N° 833-2015/MINSA) y DIGDOT (Directiva Sanitaria N° 152), el transporte asistencial de órganos, hemoderivados y vacunas críticas opera bajo el **Principio de Custodia Unívoca (1 Orden de Traslado → 1 Despacho → 1 Contenedor Inteligente → 1 Custodio Receptor Acreditado)**. Establecer asignaciones múltiples concurrentes (N:M) introduciría vacíos de trazabilidad médico-legal y riesgo inaceptable de contaminación cruzada o confusión de muestras biológicas, por lo que el esquema relacional refuerza estrictamente relaciones 1:1 y 1:N con integridad referencial restrictiva.

***

#### **2. Diccionario de Datos Exhaustivo por Bounded Context**

A continuación se detalla la especificación formal de las 11 tablas del sistema relacional agrupadas por sus Bounded Contexts, cubriendo de forma estricta las necesidades operativas del **Segmento 1 (Ambulancias y Logística)** y el **Segmento 2 (Hospitales y Laboratorios B2B)**:

***

##### **4.8.1.1. Bounded Context 1: Identity, Access & Subscriptions (IAM) (Supporting Subdomain)**

Garantiza la autenticación, la asignación de roles médicos y la gestión de planes SaaS para clínicas y flotas de ambulancias.

###### **Tabla 1: `subscription_plans`**
Almacena los niveles de suscripción B2B que determinan la capacidad operativa de ambulancias y contenedores asignados a cada institución cliente.

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único del plan en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>name</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(50)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Nombre comercial del plan (ej. *Plan Red Hospitalaria Integral*).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>code</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(20)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Código alfanumérico único para facturación (ej. `HOSP-ENTERPRISE-01`).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>max_ambulances</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 5, CHECK (> 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Límite máximo de ambulancias autorizadas para operar en la red.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>max_smartboxes</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 10, CHECK (> 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Cupo de contenedores inteligentes IoT asignados a la flota.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>monthly_price_usd</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(10, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0.00, CHECK (>= 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Tarifa mensual en dólares americanos cobrada a la institución.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>support_sla_hours</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 24</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Tiempo máximo garantizado de respuesta técnica para incidentes.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>telemetry_data_retention_months</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 12, CHECK (> 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Período de retención de telemetría histórica conforme a normativa DIGEMID.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>is_active</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 1</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Indicador booleano de vigencia comercial del plan.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>created_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Fecha y hora UTC de registro del plan en la plataforma.</td>
</tr>
</tbody>
</table>
</div>

###### **Tabla 2: `hospital_institutions`**
Representa los centros de salud, redes hospitalarias, bancos de órganos y operadores logísticos (Segmento 2).

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único de la institución de salud en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>subscription_plan_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> subscription_plans(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Plan de suscripción contratado por la entidad hospitalaria.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>name</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(150)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Razón social o denominación del hospital/clínica (ej. *Hospital Rebagliati*).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>tax_id_ruc</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(11)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Registro Único de Contribuyentes (RUC) fiscal emitido por SUNAT.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>institution_type</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'PublicHospital'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Tipo: `PublicHospital`, `PrivateClinic`, `AmbulanceNetwork`, `PharmaceuticalLab`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>health_service_level</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(20)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'II-2'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Nivel o categoría de atención asistencial MINSA (I-4, II-2, III-1, III-E).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>address</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(255)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Dirección física donde operan los puntos de despacho o quirófanos.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>district</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(100)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Distrito de Lima Metropolitana o región sanitaria de ubicación.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>emergency_phone</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(20)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Teléfono de contacto de la central de emergencias hospitalarias.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>renipress_code</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(20)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Código único nacional del Registro Nacional de IPRESS (SUSALUD / MINSA).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>latitude</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(10, 8)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHECK (BETWEEN -90 AND 90)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Coordenada geográfica de latitud del helipuerto o rampa de urgencia.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>longitude</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(11, 8)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHECK (BETWEEN -180 AND 180)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Coordenada geográfica de longitud de la sede hospitalaria.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>geofence_radius_meters</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(6, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 2000.00, CHECK (> 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Radio perimétrico virtual (ej. 2 km) que dispara el preaviso y habilita OTP.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>is_active</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 1</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Estado de habilitación operativa para programar traslados.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>created_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Fecha y hora UTC de alta en el sistema.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>updated_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Marca temporal UTC de la última actualización de datos institucionales.</td>
</tr>
</tbody>
</table>
</div>

###### **Tabla 3: `users`**
Gestiona las credenciales y perfiles profesionales autorizados en ambos segmentos.

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único universal del usuario en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>institution_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> hospital_institutions(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Entidad sanitaria a la cual pertenece laboralmente el usuario.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>first_name</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(80)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Nombres del usuario.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>last_name</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(80)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Apellidos completos.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>email</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(120)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Correo electrónico corporativo utilizado para autenticación JWT.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>password_hash</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(255)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Contraseña protegida mediante algoritmo de hashing irreversible (BCrypt).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>role</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Rol: `FleetDispatcher`, `AmbulanceDriver`, `Paramedic`, `ClinicalPharmacist`, `ReceivingSurgeon`, `QualityAuditor`, `SystemAdministrator`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>phone_number</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(20)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Número móvil para recepción de alertas SMS de contingencia vía Twilio.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>medical_license_number</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(30)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Matrícula profesional (CMP para cirujanos, TEM para paramédicos).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>is_active</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 1</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Indicador de cuenta activa y habilitada para iniciar sesión.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>last_login_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Marca temporal UTC del último inicio de sesión autenticado.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>created_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Registro inicial de la cuenta de usuario.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>updated_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Timestamp de modificación de credenciales o perfil.</td>
</tr>
</tbody>
</table>
</div>

***

##### **4.8.1.2. Bounded Context 2: Smart Container & Telemetry Monitoring (Core Domain)**

Modela el contenedor físico inteligente, su estado electromecánico y el flujo continuo de lecturas sensoriales emitidas desde la ambulancia.

###### **Tabla 4: `smart_containers`**
Representa la unidad isotérmica física dotada de sensores, solenoide de tapa y refrigeración activa Peltier.

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único universal del contenedor inteligente en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>serial_number</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(30)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Número de serie impreso en chasis y quemado en firmware (ej. `SMB-BOX-2026-0042`).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>form_factor</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'StandardBox_20L'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Tamaño: `SmallBox_5L` (córneas, biopsias) o `StandardBox_20L` (corazones, riñones).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>status</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'Available'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Estado operativo: `Available`, `Precooling`, `LockedAndReady`, `InTransit`, `Delivered`, `MaintenanceRequired`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>lock_state</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'Unlocked'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Posición del cerrojo electromecánico: `Locked`, `Unlocked`, `Tampered`, `Error`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>current_temperature_celsius</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(4, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHECK (-20.00 TO 60.00)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Última lectura de temperatura interna (°C). Rango seguro: +2.00 a +8.00 °C.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>tare_weight_grams</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(8, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0.00, CHECK (>= 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Peso en vacío calibrado con celda de carga HX711 (tara en gramos).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>net_weight_grams</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(8, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0.00, CHECK (>= 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Peso neto actual del paquete biológico o hemoderivado transportado.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>battery_percentage</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(5, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHECK (0.00 TO 100.00)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Nivel remanente de la batería LiFePO4 interna del contenedor.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>is_12v_connected</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Flag de alimentación auxiliar desde la toma de 12V vehicular de la ambulancia.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>last_telemetry_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Marca de tiempo del último mensaje MQTT recibido desde el ESP32.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>created_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Fecha de fabricación o registro del contenedor en inventario.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>updated_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Timestamp de la última sincronización telemétrica o cambio de estado.</td>
</tr>
</tbody>
</table>
</div>

###### **Tabla 5: `telemetry_logs`**
Serie temporal de lecturas sensoriales emitidas en ráfagas cada 5 segundos durante el transporte de emergencia.

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>BIGINT UNSIGNED</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY, AUTO_INCREMENT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador numérico monótono para optimización de inserciones continuas.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>container_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> smart_containers(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Contenedor inteligente emisor de la trama sensorial.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>trip_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> dispatch_trips(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Viaje de ambulancia activo durante el registro telemétrico.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>timestamp_utc</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Marca temporal UTC provista por el reloj RTC del microcontrolador.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>temperature_celsius</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(4, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Temperatura en la cámara biológica medida por el sensor Dallas DS18B20.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>ambient_temperature_celsius</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(4, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Temperatura ambiente dentro de la cabina de la ambulancia.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>weight_grams</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(8, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Peso bruto medido por la celda HX711 (detecta aperturas o sustracciones).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>battery_percentage</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(5, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHECK (0.00 TO 100.00)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Carga porcentual de la batería interna en el instante de la muestra.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>is_12v_connected</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Estado del circuito de alimentación de 12V de la ambulancia.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>peltier_power_pct</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHECK (0 TO 100)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Potencia PWM aplicada a las celdas Peltier de enfriamiento.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>lid_lock_engaged</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 1</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Verificación de contacto magnético de tapa (1: sellado, 0: abierto).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>latitude</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(10, 8)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Coordenada GPS latitudinal transmitida por el módem SIM7600G.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>longitude</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(11, 8)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Coordenada GPS longitudinal del vehículo en ruta.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>firmware_signature</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(128)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Hash de validación criptográfica de la trama generada por el ESP32.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>is_thermal_excursion</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Flag de desvío: marcado con 1 si la temperatura sale de +2.0°C a +8.0°C.</td>
</tr>
</tbody>
</table>
</div>

***

##### **4.8.1.3. Bounded Context 3: Medical Transport Planning & Dispatching (Core Domain)**

Articula las órdenes de traslado clínico y su asignación a los recursos móviles (ambulancia, chofer y paramédico).

###### **Tabla 6: `transport_orders`**
Solicitudes clínicas de transporte emitidas por cirujanos o químicos farmacéuticos (Segmento 2).

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único universal de la orden clínica en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>order_code</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(20)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Código legible de seguimiento clínico (ej. `ORD-2026-TRP-001`).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>origin_hospital_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> hospital_institutions(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Centro hospitalario emisor de la carga médica (donante/banco).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>destination_hospital_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> hospital_institutions(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Centro hospitalario receptor (sala de operaciones de trasplante).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>cargo_type</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Carga: `HeartOrgan`, `LiverOrgan`, `KidneyOrgan`, `BloodPlasmaPack`, `ThermolabileVaccine`, `BiopsySample`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>cargo_description</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(255)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Especificación clínica detallada (ej. *Corazón en solución Custodiol*).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>max_ischemia_hours</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(4, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHECK (> 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Límite máximo de isquemia fría tolerable según Directiva 152/MINSA.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>ischemia_warning_hours</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(4, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHECK (> 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Umbral preventivo para disparo de alertas de tráfico severo.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>clinical_priority</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'StatEmergency'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Prioridad médica de despacho: `Routine`, `Urgent`, `StatEmergency`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>status</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'Pending'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Ciclo de vida: `Pending`, `Assigned`, `InTransit`, `Completed`, `Cancelled`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>created_by_user_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> users(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Cirujano de trasplante o coordinador médico emisor.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>created_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Timestamp de emisión de la orden de traslado.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>updated_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Marca temporal de última modificación o reasignación.</td>
</tr>
</tbody>
</table>
</div>

###### **Tabla 7: `dispatch_trips`**
Ejecución del traslado por la ambulancia, tripulación y contenedor asignados (Segmento 1).

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único universal del viaje de despacho en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>order_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE, FOREIGN KEY -> transport_orders(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Orden de transporte vinculada (relación 1 a 1 estricta).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>assigned_container_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> smart_containers(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Contenedor físico precriado asignado para el traslado.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>assigned_driver_user_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> users(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Chofer de ambulancia responsable del desplazamiento.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>assigned_paramedic_user_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> users(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Paramédico TEM a bordo encargado de la custodia del contenedor.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>assigned_vehicle_plate</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(10)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Placa oficial de rodaje de la ambulancia asignada (ej. `EUG-418`).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>status</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'Scheduled'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Estado: `Scheduled`, `ResourcesAssigned`, `PrecoolingVerified`, `InTransit`, `ArrivedAtDestination`, `Completed`, `Cancelled`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>scheduled_departure_time</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Hora programada de salida del hospital de origen.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>actual_departure_time</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Hora real de partida una vez validado el pre-enfriamiento a 4.0 °C.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>estimated_arrival_time</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">ETA inicial recalculado dinámicamente según TomTom Traffic API.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>actual_arrival_time</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Hora exacta de arribo físico a la puerta de emergencia hospitalaria.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>distance_km</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(6, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0.00</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Distancia total recorrida por la ambulancia en kilómetros.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>planned_duration_minutes</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Duración prevista calculada en el ruteo inicial.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>current_delay_minutes</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Retraso acumulado inducido por congestión vehicular en Lima.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>polyline_coordinates</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TEXT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Cadena codificada de la ruta geográfica recorrida.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>created_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Momento de creación de la hoja de despacho.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>updated_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Timestamp de la última actualización telemétrica o de ETA.</td>
</tr>
</tbody>
</table>
</div>

***

##### **4.8.1.4. Bounded Context 4: Critical Alerting & Incident Response (Core Domain)**

Registra y escala contingencias en ruta ante desvíos térmicos o fallas eléctricas de la ambulancia.

###### **Tabla 8: `critical_incidents`**
Incidencias generadas automáticamente ante violaciones térmicas o manipulaciones indebidas.

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único universal del incidente crítico en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>trip_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> dispatch_trips(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Viaje de ambulancia en el cual ocurrió la anomalía.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>container_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> smart_containers(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Contenedor que experimentó el desvío sensorial.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>severity</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'CriticalEmergency'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Nivel: `LowWarning`, `ModerateAlert`, `CriticalEmergency`, `CatastrophicFailure`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>incident_type</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Tipo: `ColdChainBreachHigh`, `ColdChainBreachLow`, `Auxiliary12VPowerLost`, `PayloadTamperingSuspected`, `SevereTrafficDelayExceeded`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>triggered_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Momento UTC exacto en que se detectó la violación del umbral.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>trigger_temperature_celsius</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(4, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Temperatura registrada al momento de la alarma (opcional si el incidente es por tráfico o manipulación).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>trigger_battery_percentage</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(5, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Nivel de batería al momento del incidente (opcional en contingencias no eléctricas).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>status</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'Triggered'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Estado: `Triggered`, `Acknowledged`, `Escalated`, `Resolved`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>escalation_level</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 1, CHECK (1 TO 3)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Nivel de escalamiento (1: Operador, 2: Paramédico, 3: Director Médico).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>acknowledged_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Timestamp en que el operador de flota confirmó la alerta.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>acknowledged_by_user_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> users(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Operador que tomó control del incidente.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>created_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Fecha de persistencia del incidente.</td>
</tr>
</tbody>
</table>
</div>

###### **Tabla 9: `contingency_resolutions`**
Medidas correctivas aplicadas y validadas para mitigar el incidente y proteger el tejido clínico.

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único universal de la resolución de contingencia en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>incident_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE, FOREIGN KEY -> critical_incidents(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Incidente mitigado (relación 1 a 1 estricta).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>mitigation_action</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(500)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Acción operativa (ej. *Reconexión de arnés 12V vehicular y refuerzo criogénico*).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>was_thermal_integrity_restored</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 1</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Certificación de retorno a la franja de +2.0 °C a +8.0 °C.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>quality_signoff_notes</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TEXT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Dictamen técnico obligatorio firmado por el especialista biomédico.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>resolved_by_user_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> users(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Profesional biomédico o médico de guardia responsable.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>resolved_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Marca temporal del cierre satisfactorio de la contingencia.</td>
</tr>
</tbody>
</table>
</div>

***

##### **4.8.1.5. Bounded Context 5: Chain of Custody & Traceability (Core Domain)**

Garantiza la inmutabilidad de la custodia médica mediante autenticación OTP y actas digitales para MINSA/DIGEMID.

###### **Tabla 10: `custody_transfers`**
Protocolo de entrega hospitalaria con autenticación de apertura mediante código OTP de un solo uso.

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único universal de la transferencia de custodia en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>trip_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE, FOREIGN KEY -> dispatch_trips(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Viaje de ambulancia culminado (relación 1 a 1 estricta).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>recipient_hospital_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> hospital_institutions(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Hospital de destino donde se realiza la entrega física.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>authorized_recipient_user_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>FOREIGN KEY -> users(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Cirujano o farmacéutico facultado para recibir el contenedor.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>handover_status</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>ENUM(...)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 'PendingOtpVerification'</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Estado: `PendingOtpVerification`, `OtpVerifiedLidUnlocked`, `CompletedAccepted`, `RejectedThermalExcursion`, `RejectedTampering`.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>otp_code_hash</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(128)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Hash HMAC-SHA256 del token OTP efímero de 6 dígitos generado por el sistema.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>otp_expires_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Límite temporal de vigencia del token (15 minutos tras el arribo).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>otp_attempt_count</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0, CHECK (0 TO 3)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Contador de intentos de digitación (bloqueo automático al 3er fallo).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>otp_verified_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Marca temporal exacta de la validación y liberación del solenoide.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>recipient_notes</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(500)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Observaciones clínicas del receptor en la mesa quirúrgica.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>created_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT CURRENT_TIMESTAMP(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Momento de generación del token OTP al llegar la ambulancia.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>completed_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #f8fafc; color: #475569; font-weight: bold;">NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Timestamp de aceptación y firma final de la custodia.</td>
</tr>
</tbody>
</table>
</div>

###### **Tabla 11: `digital_audit_manifests`**
Acta digital de entrega legal sellada criptográficamente con hash SHA-256 para auditorías de DIGEMID (R.M. 833-2015).

<div style="margin: 10px 0 16px 0; width: 100%;">
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 6.8pt; line-height: 1.25; border: 1px solid #cbd5e1;">
<colgroup>
  <col style="width: 17%;" />
  <col style="width: 15%;" />
  <col style="width: 9%;" />
  <col style="width: 19%;" />
  <col style="width: 40%;" />
</colgroup>
<thead>
<tr style="background-color: #f1f5f9;">
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Columna</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Tipo MySQL</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: center; font-weight: bold;">Nulo</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Restricciones</th>
  <th style="border: 1px solid #cbd5e1; padding: 4px; text-align: left; font-weight: bold;">Descripción y Regla de Negocio</th>
</tr>
</thead>
<tbody>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>PRIMARY KEY</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Identificador único universal del acta digital en formato UUIDv7 (RFC 9562).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>transfer_id</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(36)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE, FOREIGN KEY -> custody_transfers(id)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Transferencia de custodia certificada (relación 1 a 1 estricta).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>manifest_code</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(30)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>UNIQUE</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Código oficial del manifiesto clínico (ej. `MAN-2026-MINSA-0089`).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>cryptographic_hash_sha256</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>CHAR(64)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Hash SHA-256 del PDF y de la serie completa de telemetría del viaje.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>cloud_storage_pdf_url</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>VARCHAR(500)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Enlace inmutable hacia el repositorio S3 / Azure Blob Storage cifrado.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>is_sealed_and_immutable</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 1</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Bandera de inmutabilidad jurídica; impide modificaciones o reaperturas.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>average_temperature_celsius</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(4, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Temperatura promedio consolidada durante todo el traslado (°C).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>min_temperature_celsius</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(4, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Temperatura mínima registrada en la cámara durante el viaje.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>max_temperature_celsius</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DECIMAL(4, 2)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Temperatura máxima alcanzada en el contenedor.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>total_excursion_seconds</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>INT</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 0, CHECK (>= 0)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Tiempo acumulado en segundos fuera del rango regulatorio (+2°C a +8°C).</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>minsa_compliance_verified</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>TINYINT(1)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DEFAULT 1</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Certificación booleana de cumplimiento de la Directiva Sanitaria 152/MINSA.</td>
</tr>
<tr>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; font-weight: 600;"><code>sealed_at</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>DATETIME(6)</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top; text-align: center; background-color: #fef2f2; color: #dc2626; font-weight: bold;">NOT NULL</td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;"><code>—</code></td>
  <td style="border: 1px solid #cbd5e1; padding: 3px 4px; vertical-align: top;">Fecha y hora UTC del sellado criptográfico del acta.</td>
</tr>
</tbody>
</table>
</div>

***

#### **3. Políticas Globales de Integridad Referencial y Trazabilidad**

En lugar de redundar en las especificaciones de claves foráneas ya detalladas exhaustivamente en el diccionario de datos de las 11 tablas y en el diagrama físico ER, el motor relacional implementa las siguientes políticas unificadas de integridad referencial para garantizar la trazabilidad médica inmutable y el cumplimiento de las normativas de **DIGEMID** (R.M. N° 833-2015/MINSA) y **SUSALUD**:

| Regla de Integridad | Cláusula SQL / EF Core | Alcance de Aplicación en el Modelo | Justificación Clínica, Operativa y Legal |
|---|---|---|---|
| **Preservación Inmutable de Evidencia** | `ON DELETE RESTRICT` | 19 de las 20 relaciones foráneas (Instituciones, Usuarios, Órdenes, Contenedores, Incidentes, Custodias y Manifiestos). | Prohíbe de forma terminante el borrado en cascada de entidades maestras o transaccionales con histórico clínico asociado, previniendo vacíos probatorios ante litigios médicos o auditorías sanitarias. |
| **Desacoplamiento de Despachos Cancelados** | `ON DELETE SET NULL` | Relación `dispatch_trips(id)` → `telemetry_logs(trip_id)`. | Si un viaje preliminar es cancelado antes de partir, las muestras sensoriales emitidas por el hardware IoT se conservan intactas vinculadas al contenedor, desvinculando únicamente la referencia al traslado cancelado. |
| **Propagación Segura de Cambios** | `ON UPDATE CASCADE` | Claves primarias sustitutas basadas en identificadores UUIDv7 (`CHAR(36)`). | Garantiza sincronización referencial automática en capas de persistencia y cachés sin requerir operaciones manuales en la base de datos. |
| **Principio de Custodia Unívoca (Sin N:M)** | Restricciones `1:1` y `1:N` estrictas con `UNIQUE` | Asignación Orden → Despacho → Contenedor → Transferencia de Custodia. | Elimina tablas intermedias de cruce N:M; la normativa sanitaria exige un único custodio legal y un único contenedor responsable por cada traslado de órganos o hemoderivados. |
| **Inmutabilidad Criptográfica de Cierre** | Columna `is_sealed_and_immutable = 1` y hash SHA-256 | Tabla `digital_audit_manifests` (Manifiesto de Auditoría). | Bloquea a nivel de servicio y regla de base de datos cualquier mutación posterior al sellado de custodia asistencial en destino hospitalario. |

***

#### **4. Estrategia de Indexación y Optimización de Consultas IoT**

Para procesar ráfagas continuas de telemetría provenientes de múltiples ambulancias sin degradar los tiempos de respuesta del dashboard web en Vue.js ni la transmisión en tiempo real de WebSockets vía SignalR, se implementa una estrategia de **índices B-Tree compuestos**:

1. **`idx_telemetry_container_timestamp (container_id, timestamp_utc DESC)`:**  
   *Propósito:* Optimiza la consulta más frecuente del sistema: obtener la última lectura emitida por un contenedor específico para renderizar el termómetro digital, indicador de peso y estado de batería en el frontend. Al estar ordenado descendentemente, el motor MySQL resuelve la consulta en tiempo O(1) sin realizar un escaneo completo de tabla (*Full Table Scan*).
2. **`idx_telemetry_trip_timestamp (trip_id, timestamp_utc ASC)`:**  
   *Propósito:* Permite recuperar la curva térmica completa y las coordenadas del recorrido de una ambulancia para trazar el gráfico histórico de temperatura en el visor de auditoría clínica.
3. **`idx_dispatch_trips_status_departure (status, scheduled_departure_time)`:**  
   *Propósito:* Alimenta la vista en tiempo real del operador de despacho de flota (Segmento 1), filtrando instantáneamente todos los viajes con estado `InTransit` o `Scheduled` para calcular demoras por tráfico con TomTom API.
4. **`idx_critical_incidents_status_severity (status, severity)`:**  
   *Propósito:* Prioriza las alertas no resueltas (`Open`) de mayor severidad (`CriticalEmergency`, `CatastrophicFailure`) para despachar notificaciones inmediatas mediante push y SMS a la central médica.

***

<div style="page-break-before: always;"></div>

#### **5. Diagrama Físico de Base de Datos (Entity Relationship Diagram)**

<p align="center" style="text-align: center; margin: 4px 0 6px 0;">
  <img src="assets/chapter-4/4.8.1-database-diagram.png" alt="Figura 4.8.1 - Database Physical Data Model (Entity Relationship Diagram)" style="max-height: 228mm; width: auto; max-width: 98%; margin: 2px auto; display: block;" />
  <em style="font-size: 8pt;">Nota: Diagrama Relacional Físico de Base de Datos generado mediante Reverse Engineering en MySQL Workbench 8.0 bajo motor InnoDB.</em>
</p>

***

<div style="page-break-before: always;"></div>

#### **6. Conclusiones y Transición hacia el Capítulo V (Implementación y Validación)**

El diseño relacional presentado en esta sección concluye la fase arquitectónica del **Capítulo IV**, consolidando una base de datos que:
1. **Garantiza la Integridad Clínica y Legal:** El uso de restricciones `RESTRICT` en claves foráneas, sellos SHA-256 e inmutabilidad de actas previene la eliminación o alteración de evidencia requerida por DIGEMID y SUSALUD.
2. **Satisface las Necesidades de Ambos Segmentos:** Modela fielmente las variables dinámicas de las ambulancias en ruta (Segmento 1) y los requisitos de recepción estéril y tiempos de isquemia de los cirujanos y farmacéuticos (Segmento 2).
3. **Prepara el Terreno para el Capítulo V:** Con el esquema relacional formalizado y la estructura física de base de datos validada, el equipo técnico queda habilitado para proceder en el **Capítulo V (Product Implementation, Validation & Deployment)** con la configuración del entorno de desarrollo (.NET 10 SDK [net10.0], MySQL 8.0, Vue 3, GitFlow) y la ejecución de los Sprints de desarrollo con Entity Framework Core Code-First Migrations.
