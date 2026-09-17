# **4.7. Software Object-Oriented Design**

## **4.7.1. Class Diagrams**

### **1. Introducción y Fundamentación Técnica del Diseño OO**

El diseño estático del sistema se fundamenta en los estándares de la especificación oficial UML 2.5 y las referencias canónicas de ingeniería de software:
* **Notación de Modelado UML 2.5:** Estándares canónicos para la construcción de diagramas de clases orientados a objetos con tipado estricto y relaciones formales.
* **Convenciones Oficiales de Microsoft C# (.NET 10 LTS):** Tipado estricto, encapsulamiento mediante propiedades automáticas con mutabilidad controlada (`{ get; private set; }`) y diseño orientado al dominio.
* **Patrones de Arquitectura DDD (Nick Tune y Eric Evans):** Modelado de clases diferenciando estereotipos estratégicos de Domain-Driven Design (Agregados, Entidades, Objetos de Valor e Interfaces de Repositorio).

El diseño orientado a objetos del sistema **Medical SMARTBOX** trasciende la mera representación de estructuras de datos pasivas (modelos anémicos tipo CRUD) para modelar un **Dominio Rico (*Rich Domain Model*)**, donde las clases encapsulan tanto su estado como las **invariantes de negocio y reglas sanitarias** que garantizan la preservación de órganos, hemoderivados y vacunas durante el transporte de emergencia en Lima Metropolitana.

#### Estereotipos y Convenciones UML Aplicadas (Notación Formal OMG UML « »)
1. **«AggregateRoot» (Raíz de Agregado):** Entidad principal que define una frontera transaccional de consistencia. El acceso a los objetos internos del agregado se realiza exclusivamente a través de sus métodos públicos.
2. **«Entity» (Entidad):** Objeto con identidad única que perdura a través del tiempo y cuyos atributos pueden mutar.
3. **«ValueObject» (Objeto de Valor):** Objeto inmutable sin identidad conceptual, definido exclusivamente por sus atributos (`TemperatureReading`, `OtpToken`, `GeoLocation`).
4. **«Enumeration» (Enumeración):** Conjunto cerrado de constantes con significado semántico en el dominio.
5. **«Repository» (Abstracción de Persistencia DDD):** Define operaciones de persistencia de agregados desacoplando la lógica de negocio del motor de base de datos.
6. **«Service» (Abstracción de Servicio Externo / Integración):** Encapsula servicios de infraestructura externos (tráfico, notificaciones, almacenamiento).
7. **«DomainEvent» (Evento de Dominio):** Notificación inmutable de un hecho consumado relevante en el ciclo de vida del negocio.
8. **Modificadores de Acceso y Visibilidad:**  
   * `+` : Público (*public*)  
   * `-` : Privado (*private*)  
   * `#` : Protegido (*protected*)

#### Mapeo Objeto-Relacional con Entity Framework Core 10.0 y Convenciones Nominales
En estricta observancia de los patrones Domain-Driven Design (DDD), las clases del dominio adoptan nomenclatura de negocio en C# (*PascalCase*), mientras que el esquema relacional en MySQL 8.0 implementa estándares físicos de base de datos (*snake_case*). Las correspondencias específicas entre nombres de propiedades y columnas físicas se gobiernan declarativamente mediante la Fluent API de EF Core (`.HasColumnName(...)`):
* `SubscriptionPlan.PlanCode` → columna `code` (definida en tabla `subscription_plans`).
* `SubscriptionPlan.MaxFleetBoxes` → columna `max_smartboxes` (definida en tabla `subscription_plans`).
* `SubscriptionPlan.MonthlyCostUsd` → columna `monthly_price_usd` (definida en tabla `subscription_plans`).
* `HospitalInstitution.OfficialName` → columna `name` (definida en tabla `hospital_institutions`).
* `UserAccount.ProfessionalLicenseNumber` → columna `medical_license_number` (definida en tabla `users`).
* `TransportOrder.Priority` → columna `clinical_priority` (definida en tabla `transport_orders`).
* `CustodyTransfer.TransferredAt` → columna `completed_at` (definida en tabla `custody_transfers`).
* `DigitalAuditManifest.GeneratedAt` → columna `sealed_at` (definida en tabla `digital_audit_manifests`).
* `DigitalAuditManifest.CloudStorageUrl` → columna `cloud_storage_pdf_url` (definida en tabla `digital_audit_manifests`).
Esta separación formal preserva la expresividad del lenguaje ubicuo en el código fuente de dominio sin acoplarlo rígidamente a los identificadores físicos de almacenamiento.

---

### **2. Desglose Exhaustivo de Clases por Bounded Context**

A continuación se detalla la especificación estática de clases para los cinco Bounded Contexts del sistema que articulan el **Segmento 1 (Transporte y Flota Logística)** y el **Segmento 2 (Centros de Salud y Cadenas Farmacéuticas)**:

---

#### **4.7.1.0. Bounded Context: Identity, Access & Subscriptions (IAM)**

A nivel del diseño estático de clases de software, las entidades de identidad, roles institucionales y suscripción SaaS se consolidan en este módulo para garantizar consistencia transaccional inmediata en la validación de licencias y membresías activas. Este contexto centraliza la autenticación mediante tokens JWT, control de acceso basado en roles (RBAC) para los dos segmentos objetivo, registro formal de sedes hospitalarias con código RENIPRESS y gestión del modelo de suscripción SaaS para flotas de contenedores médicos.

<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  <thead>
    <tr>
      <th>Clase / Interfaz / Enum</th>
      <th>Estereotipo DDD</th>
      <th>Atributos (Visibilidad y Tipo)</th>
      <th>Métodos (Firma Completa y Retorno)</th>
      <th>Invariantes y Reglas Protegidas</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>SubscriptionPlan</code></td>
      <td><code>«AggregateRoot»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ PlanCode: string</code><br>
        <code>+ Name: string</code><br>
        <code>+ MaxAmbulances: int</code><br>
        <code>+ MaxFleetBoxes: int</code><br>
        <code>+ MonthlyCostUsd: decimal</code><br>
        <code>+ SupportSlaHours: int</code><br>
        <code>+ TelemetryDataRetentionMonths: int</code><br>
        <code>+ IsActive: bool</code>
      </td>
      <td>
        <code>+ CanProvisionBox(currentBoxes: int): bool</code><br>
        <code>+ CanProvisionAmbulance(currentAmbulances: int): bool</code><br>
        <code>+ UpdateBillingTerms(cost: decimal, maxBoxes: int, maxAmbulances: int): void</code>
      </td>
      <td>
        • El costo mensual debe ser mayor o igual a cero.<br>
        • No se permite aprovisionar boxes ni registrar ambulancias si la flota activa alcanza el límite del plan.
      </td>
    </tr>
    <tr>
      <td><code>HospitalInstitution</code></td>
      <td><code>«AggregateRoot»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ OfficialName: string</code><br>
        <code>+ TaxIdRuc: string</code><br>
        <code>+ InstitutionType: InstitutionTypeEnum</code><br>
        <code>+ RenipressCode: string</code><br>
        <code>+ HealthServiceLevel: string</code><br>
        <code>+ Address: string</code><br>
        <code>+ District: string</code><br>
        <code>+ EmergencyPhone: string</code><br>
        <code>+ Latitude: double</code><br>
        <code>+ Longitude: double</code><br>
        <code>+ GeofenceRadiusMeters: double</code><br>
        <code>+ SubscriptionPlanId: Guid</code><br>
        <code>+ IsActive: bool</code>
      </td>
      <td>
        <code>+ IsLocationInsideGeofence(lat: double, lon: double): bool</code><br>
        <code>+ UpdateGeofenceRadius(radiusMeters: double): void</code>
      </td>
      <td>
        • El RUC debe ser una cadena fiscal válida de 11 dígitos.<br>
        • El código RENIPRESS es de registro sanitario obligatorio ante SUSALUD/MINSA.<br>
        • El radio de geocerca no puede ser inferior a 500 metros ni superior a 5000 metros.
      </td>
    </tr>
    <tr>
      <td><code>UserAccount</code></td>
      <td><code>«AggregateRoot»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ InstitutionId: Guid</code><br>
        <code>+ FirstName: string</code><br>
        <code>+ LastName: string</code><br>
        <code>+ Email: string</code><br>
        <code>+ PasswordHash: string</code><br>
        <code>+ PhoneNumber: string</code><br>
        <code>+ ProfessionalLicenseNumber: string</code><br>
        <code>+ Role: UserRole</code><br>
        <code>+ IsActive: bool</code><br>
        <code>+ LastLoginAt: DateTime?</code>
      </td>
      <td>
        <code>+ VerifyPassword(plainPassword: string): bool</code><br>
        <code>+ ChangePassword(newHash: string): void</code><br>
        <code>+ DeactivateAccount(): void</code>
      </td>
      <td>
        • El correo electrónico debe poseer formato RFC válido y ser único en el sistema.<br>
        • Los usuarios con roles clínicos (médico, farmacéutico) deben registrar número de colegiatura profesional habilitada.<br>
        • Contraseñas protegidas mediante algoritmos de derivación de claves criptográficas seguras (BCrypt/Argon2).
      </td>
    </tr>
    <tr>
      <td><code>UserRole</code></td>
      <td><code>«Enumeration»</code></td>
      <td>
        <code>AmbulanceDriver</code><br>
        <code>Paramedic</code><br>
        <code>FleetDispatcher</code><br>
        <code>ClinicalPharmacist</code><br>
        <code>ReceivingSurgeon</code><br>
        <code>QualityAuditor</code><br>
        <code>SystemAdministrator</code>
      </td>
      <td>N/A (Constantes semánticas)</td>
      <td>Restringe los privilegios de navegación y permisos de comandos en la Web Application y API.</td>
    </tr>
    <tr>
      <td><code>InstitutionTypeEnum</code></td>
      <td><code>«Enumeration»</code></td>
      <td>
        <code>PublicHospital</code><br>
        <code>PrivateClinic</code><br>
        <code>AmbulanceNetwork</code><br>
        <code>PharmaceuticalLab</code>
      </td>
      <td>N/A (Constantes semánticas)</td>
      <td>Clasifica la naturaleza asistencial de la institución cliente registrada en la plataforma.</td>
    </tr>
    <tr>
      <td><code>IUserRepository</code></td>
      <td><code>«Repository»</code></td>
      <td>N/A (Contrato abstracto)</td>
      <td>
        <code>+ GetByIdAsync(id: Guid): Task&lt;UserAccount&gt;</code><br>
        <code>+ GetByEmailAsync(email: string): Task&lt;UserAccount&gt;</code><br>
        <code>+ SaveAsync(user: UserAccount): Task</code>
      </td>
      <td>Desacopla la persistencia de usuarios del motor MySQL.</td>
    </tr>
    <tr>
      <td><code>IInstitutionRepository</code></td>
      <td><code>«Repository»</code></td>
      <td>N/A (Contrato abstracto)</td>
      <td>
        <code>+ GetByIdAsync(id: Guid): Task&lt;HospitalInstitution&gt;</code><br>
        <code>+ GetByRenipressCodeAsync(code: string): Task&lt;HospitalInstitution&gt;</code><br>
        <code>+ SaveAsync(institution: HospitalInstitution): Task</code>
      </td>
      <td>Garantiza la inversión de dependencias para la gestión institucional.</td>
    </tr>
    <tr>
      <td><code>ISubscriptionRepository</code></td>
      <td><code>«Repository»</code></td>
      <td>N/A (Contrato abstracto)</td>
      <td>
        <code>+ GetByIdAsync(id: Guid): Task&lt;SubscriptionPlan&gt;</code><br>
        <code>+ GetByCodeAsync(code: string): Task&lt;SubscriptionPlan&gt;</code><br>
        <code>+ SaveAsync(plan: SubscriptionPlan): Task</code>
      </td>
      <td>Garantiza la persistencia e inversión de dependencias para los planes de suscripción B2B.</td>
    </tr>
  </tbody>
</table>

---

#### **4.7.1.1. Bounded Context A: Smart Container & Telemetry Monitoring (IoT)**

Representa el núcleo físico y sensorial del proyecto. Modela el control activo de frío (+2.0 °C a +8.0 °C) mediante celdas Peltier, el pesaje digital con celda HX711 (&plusmn;5 g), el solenoide electromecánico de la tapa y la supervisión de la toma de 12V vehicular.

<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  <thead>
    <tr>
      <th>Clase / Interfaz / Enum</th>
      <th>Estereotipo DDD</th>
      <th>Atributos (Visibilidad y Tipo)</th>
      <th>Métodos (Firma Completa y Retorno)</th>
      <th>Invariantes y Reglas Protegidas</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>SmartContainer</code></td>
      <td><code>«AggregateRoot»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ SerialNumber: string</code><br>
        <code>+ FormFactor: BoxFormFactor</code><br>
        <code>+ Status: ContainerStatus</code><br>
        <code>+ CurrentTemperature: double</code><br>
        <code>+ NetWeightGrams: double</code><br>
        <code>+ TareWeightGrams: double</code><br>
        <code>+ LastTelemetryAt: DateTime</code><br>
        <code>- _lock: ElectromechanicalLock</code><br>
        <code>- _cooler: PeltierCooler</code><br>
        <code>- _battery: BatteryUnit</code>
      </td>
      <td>
        <code>+ RecordTelemetry(snapshot: TelemetrySnapshot): Result</code><br>
        <code>+ CalibrateTare(tareGrams: double): void</code><br>
        <code>+ LoadPayload(grossWeightGrams: double): void</code><br>
        <code>+ EngageLock(): void</code><br>
        <code>+ UnlockWithVerifiedOtp(): void</code><br>
        <code>+ SwitchToAuxiliaryPower(): void</code>
      </td>
      <td>
        • La tapa electromecánica no puede abrirse si el estado es <code>InTransit</code> salvo autorización explícita.<br>
        • Variaciones de peso &gt; 15g en ruta disparan evento de presunta adulteración de carga.<br>
        • Desviación térmica fuera de [2.0 °C - 8.0 °C] dispara evento de excursión.
      </td>
    </tr>
    <tr>
      <td><code>ElectromechanicalLock</code></td>
      <td><code>«Entity»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ State: LockState</code><br>
        <code>+ LastEngagedAt: DateTime</code><br>
        <code>+ IsSecure: bool</code>
      </td>
      <td>
        <code>+ Engage(): void</code><br>
        <code>+ Release(): void</code><br>
        <code>+ VerifySecurityStatus(): bool</code>
      </td>
      <td>Encapsula y comanda el estado lógico de seguridad del cerrojo de la tapa del contenedor.</td>
    </tr>
    <tr>
      <td><code>PeltierCooler</code></td>
      <td><code>«Entity»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ PowerOutputPercentage: int</code><br>
        <code>+ TargetTemperature: double</code><br>
        <code>+ IsActive: bool</code>
      </td>
      <td>
        <code>+ SetTargetTemperature(targetCelsius: double): void</code><br>
        <code>+ Activate(): void</code><br>
        <code>+ Deactivate(): void</code>
      </td>
      <td>Comanda el punto de consigna térmico del sistema de enfriamiento activo para preservar el rango seguro de +4.0 °C.</td>
    </tr>
    <tr>
      <td><code>BatteryUnit</code></td>
      <td><code>«Entity»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ ChargePercentage: double</code><br>
        <code>+ IsChargingFrom12V: bool</code><br>
        <code>+ RemainingAutonomyHours: double</code>
      </td>
      <td>
        <code>+ UpdateLevel(chargePct: double, isCharging: bool): void</code><br>
        <code>+ HasSufficientAutonomy(minHours: double): bool</code>
      </td>
      <td>Supervisa la alimentación vehicular de 12V y la reserva de autonomía energética de la batería interna.</td>
    </tr>
    <tr>
      <td><code>TelemetrySnapshot</code></td>
      <td><code>«ValueObject»</code></td>
      <td>
        <code>+ TimestampUtc: DateTime</code><br>
        <code>+ TemperatureCelsius: double</code><br>
        <code>+ WeightGrams: double</code><br>
        <code>+ BatteryPercent: double</code><br>
        <code>+ Is12VConnected: bool</code><br>
        <code>+ Location: GeoLocation</code><br>
        <code>+ FirmwareSignature: string</code>
      </td>
      <td>
        <code>+ IsThermallyValid(): bool</code><br>
        <code>+ HasValidSignature(publicKey: string): bool</code>
      </td>
      <td>Inmutable. Representa un paquete atómico de telemetría emitido por el microcontrolador ESP32.</td>
    </tr>
    <tr>
      <td><code>ISmartContainerRepository</code></td>
      <td><code>«Repository»</code></td>
      <td>—</td>
      <td>
        <code>+ GetByIdAsync(id: Guid): Task&lt;SmartContainer&gt;</code><br>
        <code>+ GetBySerialNumberAsync(serial: string): Task&lt;SmartContainer&gt;</code><br>
        <code>+ SaveAsync(container: SmartContainer): Task</code>
      </td>
      <td>Contrato de persistencia desacoplado de Entity Framework Core.</td>
    </tr>
    <tr>
      <td><code>ContainerStatus</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>Available</code>, <code>Precooling</code>, <code>LockedAndReady</code>, <code>InTransit</code>, <code>Delivered</code>, <code>MaintenanceRequired</code></td>
      <td>—</td>
      <td>Ciclo de vida operativo del contenedor.</td>
    </tr>
    <tr>
      <td><code>BoxFormFactor</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>SmallBox_5L</code> (Vacunas/Biopsias), <code>StandardBox_20L</code> (Órganos/Sangre)</td>
      <td>—</td>
      <td>Factor de forma asociado a la suscripción B2B.</td>
    </tr>
    <tr>
      <td><code>TelemetryLog</code></td>
      <td><code>«Entity»</code></td>
      <td>
        <code>+ Id: long</code><br>
        <code>+ ContainerId: Guid</code><br>
        <code>+ TripId: Guid?</code><br>
        <code>+ TimestampUtc: DateTime</code><br>
        <code>+ TemperatureCelsius: decimal</code><br>
        <code>+ AmbientTemperatureCelsius: decimal</code><br>
        <code>+ WeightGrams: decimal</code><br>
        <code>+ BatteryPercentage: decimal</code><br>
        <code>+ Is12VConnected: bool</code><br>
        <code>+ PeltierPowerPct: int</code><br>
        <code>+ LidLockEngaged: bool</code><br>
        <code>+ Latitude: decimal?</code><br>
        <code>+ Longitude: decimal?</code><br>
        <code>+ FirmwareSignature: string</code><br>
        <code>+ IsThermalExcursion: bool</code>
      </td>
      <td>
        <code>+ IsExcursion(minTemp: decimal, maxTemp: decimal): bool</code><br>
        <code>+ ValidateIntegrity(): bool</code>
      </td>
      <td>
        • Registro transaccional inmutable que persiste cada lectura sensorial en MySQL (<code>telemetry_logs</code>) para auditoría de DIGEMID.<br>
        • Permite reconstruir la curva térmica continua y verificar alertas retrospectivas.
      </td>
    </tr>
    <tr>
      <td><code>ITelemetryRepository</code></td>
      <td><code>«Repository»</code></td>
      <td>—</td>
      <td>
        <code>+ AppendLogAsync(log: TelemetryLog): Task</code><br>
        <code>+ GetLogsByTripIdAsync(tripId: Guid): Task&lt;IReadOnlyCollection&lt;TelemetryLog&gt;&gt;</code><br>
        <code>+ GetLatestByContainerIdAsync(containerId: Guid): Task&lt;TelemetryLog&gt;</code>
      </td>
      <td>Contrato de persistencia de alta concurrencia para el flujo continuo de telemetría sensorial.</td>
    </tr>
    <tr>
      <td><code>LockState</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>Locked</code>, <code>Unlocked</code>, <code>Tampered</code>, <code>Error</code></td>
      <td>—</td>
      <td>Estado mecánico del solenoide.</td>
    </tr>
    <tr>
      <td><code>GeoLocation</code></td>
      <td><code>«ValueObject»</code></td>
      <td>
        <code>+ Latitude: double</code><br>
        <code>+ Longitude: double</code>
      </td>
      <td>
        <code>+ DistanceTo(other: GeoLocation): double</code><br>
        <code>+ IsWithinGeofence(center: GeoLocation, radiusMeters: double): bool</code>
      </td>
      <td>
        • Objeto de valor inmutable. Valida rangos de latitud [-90.0, 90.0] y longitud [-180.0, 180.0].<br>
        • Utilizado para calcular la distancia a geocercas hospitalarias de pre-arribo y el progreso de la ruta asistencial.
      </td>
    </tr>
  </tbody>
</table>

---

#### **4.7.1.2. Bounded Context B: Medical Transport Planning & Dispatching (Segmento 1)**

Modela la respuesta operativa del **Segmento 1 (Ambulancias y Despacho)** ante las emergencias: creación de órdenes, asignación de unidades móviles, control de tiempos de isquemia fría y cálculo dinámico de ETA ante el tráfico severo de Lima.

<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  <thead>
    <tr>
      <th>Clase / Interfaz / Enum</th>
      <th>Estereotipo DDD</th>
      <th>Atributos (Visibilidad y Tipo)</th>
      <th>Métodos (Firma Completa y Retorno)</th>
      <th>Invariantes y Reglas Protegidas</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>TransportOrder</code></td>
      <td><code>«AggregateRoot»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ OrderCode: string</code><br>
        <code>+ OriginHospitalId: Guid</code><br>
        <code>+ DestinationHospitalId: Guid</code><br>
        <code>+ CargoDescription: string</code><br>
        <code>+ CargoType: CargoType</code><br>
        <code>+ Priority: PriorityLevel</code><br>
        <code>+ Status: TransportOrderStatus</code><br>
        <code>+ MaxIschemiaLimit: IschemiaTimeLimit</code><br>
        <code>+ CreatedByUserId: Guid</code><br>
        <code>+ CreatedAt: DateTime</code>
      </td>
      <td>
        <code>+ ValidateIschemiaFeasibility(estimatedMinutes: int): bool</code><br>
        <code>+ CancelOrder(reason: string): void</code>
      </td>
      <td>
        • Requiere obligatoriamente un límite de isquemia fría conforme a la Directiva Sanitaria N° 152/MINSA.<br>
        • El hospital de origen y destino deben ser IPRESS verificadas con RENIPRESS.
      </td>
    </tr>
    <tr>
      <td><code>DispatchTrip</code></td>
      <td><code>«AggregateRoot»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ OrderId: Guid</code><br>
        <code>+ AssignedVehiclePlate: string</code><br>
        <code>+ AssignedContainerId: Guid</code><br>
        <code>+ AssignedDriverUserId: Guid</code><br>
        <code>+ AssignedParamedicUserId: Guid</code><br>
        <code>+ Status: TripStatus</code><br>
        <code>+ ScheduledDepartureTime: DateTime</code><br>
        <code>+ ActualDepartureTime: DateTime?</code><br>
        <code>+ EstimatedArrivalTime: DateTime</code><br>
        <code>+ ActualArrivalTime: DateTime?</code><br>
        <code>- _route: TransportRoute</code>
      </td>
      <td>
        <code>+ AssignCrewAndResources(vehiclePlate: string, boxId: Guid, driverId: Guid, paramedicId: Guid): void</code><br>
        <code>+ StartTrip(boxPrecooled: bool): Result</code><br>
        <code>+ UpdateDynamicEta(newEta: DateTime): void</code><br>
        <code>+ RegisterHospitalArrival(currentLoc: GeoLocation): Result</code>
      </td>
      <td>
        • No puede iniciar el viaje si el contenedor no alcanzó pre-enfriamiento (2°C-8°C).<br>
        • No puede marcar llegada si la ambulancia está fuera de la geocerca de 100m del hospital receptor.
      </td>
    </tr>
    <tr>
      <td><code>TransportRoute</code></td>
      <td><code>«Entity»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ DistanceKilometers: double</code><br>
        <code>+ PlannedDurationMinutes: int</code><br>
        <code>+ CurrentCongestionDelayMinutes: int</code><br>
        <code>+ PolylineCoordinates: string</code>
      </td>
      <td>
        <code>+ RecalculateRoute(congestionMinutes: int): void</code><br>
        <code>+ IsSeverelyDelayed(): bool</code>
      </td>
      <td>Gestiona los desvíos y demoras ocasionados por el tráfico en arterias viales de Lima.</td>
    </tr>
    <tr>
      <td><code>IschemiaTimeLimit</code></td>
      <td><code>«ValueObject»</code></td>
      <td>
        <code>+ MaxSafeHours: double</code><br>
        <code>+ WarningThresholdHours: double</code>
      </td>
      <td>
        <code>+ IsViolated(elapsedHours: double): bool</code><br>
        <code>+ IsApproachingLimit(elapsedHours: double): bool</code>
      </td>
      <td>Inmutable. Tiempos máximos de conservación celular (&lt;4h para corazón, &lt;8h para hígado).</td>
    </tr>
    <tr>
      <td><code>ITransportRepository</code></td>
      <td><code>«Repository»</code></td>
      <td>—</td>
      <td>
        <code>+ GetTripByIdAsync(id: Guid): Task&lt;DispatchTrip&gt;</code><br>
        <code>+ GetActiveTripsAsync(): Task&lt;List&lt;DispatchTrip&gt;&gt;</code><br>
        <code>+ SaveTripAsync(trip: DispatchTrip): Task</code>
      </td>
      <td>Contrato para persistencia de órdenes y viajes asistenciales.</td>
    </tr>
    <tr>
      <td><code>ITrafficRoutingService</code></td>
      <td><code>«Service»</code></td>
      <td>—</td>
      <td>
        <code>+ GetDynamicEtaAsync(origin: GeoLocation, dest: GeoLocation): Task&lt;DateTime&gt;</code><br>
        <code>+ CheckTrafficDelaysAsync(routePolyline: string): Task&lt;int&gt;</code>
      </td>
      <td>Abstracción para el cliente HTTP de la API de TomTom.</td>
    </tr>
    <tr>
      <td><code>TripStatus</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>Scheduled</code>, <code>ResourcesAssigned</code>, <code>PrecoolingVerified</code>, <code>InTransit</code>, <code>ArrivedAtDestination</code>, <code>Completed</code>, <code>Cancelled</code></td>
      <td>—</td>
      <td>Estados del viaje asistencial.</td>
    </tr>
    <tr>
      <td><code>CargoType</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>HeartOrgan</code>, <code>LiverOrgan</code>, <code>KidneyOrgan</code>, <code>BloodPlasmaPack</code>, <code>ThermolabileVaccine</code>, <code>BiopsySample</code></td>
      <td>—</td>
      <td>Tipo biológico de la carga transportada.</td>
    </tr>
    <tr>
      <td><code>PriorityLevel</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>Routine</code>, <code>Urgent</code>, <code>StatEmergency</code></td>
      <td>—</td>
      <td>Nivel de prioridad clínica de despacho conforme a <code>transport_orders.clinical_priority</code> en MySQL.</td>
    </tr>
    <tr>
      <td><code>TransportOrderStatus</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>Pending</code>, <code>Assigned</code>, <code>InTransit</code>, <code>Completed</code>, <code>Cancelled</code></td>
      <td>—</td>
      <td>Ciclo de vida transaccional de la orden de traslado conforme a <code>transport_orders.status</code> en MySQL.</td>
    </tr>
  </tbody>
</table>

---

#### **4.7.1.3. Bounded Context C: Critical Alerting & Incident Response (Segmentos 1 y 2)**

Modela la detección de contingencias, despacho de alarmas acústicas y visuales a la cabina de ambulancia (Segmento 1) y notificaciones push/SMS a los directores médicos y receptores (Segmento 2).

<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  <thead>
    <tr>
      <th>Clase / Interfaz / Enum</th>
      <th>Estereotipo DDD</th>
      <th>Atributos (Visibilidad y Tipo)</th>
      <th>Métodos (Firma Completa y Retorno)</th>
      <th>Invariantes y Reglas Protegidas</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>CriticalIncident</code></td>
      <td><code>«AggregateRoot»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ TripId: Guid</code><br>
        <code>+ ContainerId: Guid</code><br>
        <code>+ IncidentType: IncidentType</code><br>
        <code>+ Severity: IncidentSeverity</code><br>
        <code>+ Status: IncidentStatus</code><br>
        <code>+ TriggerTemperatureCelsius: decimal?</code><br>
        <code>+ TriggerBatteryPercentage: decimal?</code><br>
        <code>+ EscalationLevel: EscalationLevelEnum</code><br>
        <code>+ TriggeredAt: DateTime</code><br>
        <code>+ AcknowledgedAt: DateTime?</code><br>
        <code>+ AcknowledgedByUserId: Guid?</code><br>
        <code>- _resolution: ContingencyResolution?</code>
      </td>
      <td>
        <code>+ Acknowledge(operatorId: Guid): void</code><br>
        <code>+ EscalateToMedicalDirector(): void</code><br>
        <code>+ Resolve(actionDescription: string, resolvedBy: Guid): Result</code>
      </td>
      <td>
        • Alertas críticas deben despacharse en menos de 10 segundos.<br>
        • Un incidente no puede cerrarse como resuelto sin registrar obligatoriamente una acción de mitigación.<br>
        • Registra los valores sensoriales de disparo (temperatura y batería) conforme a <code>critical_incidents</code> en MySQL.
      </td>
    </tr>
    <tr>
      <td><code>ContingencyResolution</code></td>
      <td><code>«Entity»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ MitigationAction: string</code><br>
        <code>+ QualitySignoffNotes: string</code><br>
        <code>+ ResolvedAt: DateTime</code><br>
        <code>+ ResolvedByUserId: Guid</code><br>
        <code>+ WasThermalIntegrityRestored: bool</code>
      </td>
      <td>
        <code>+ ValidateResolution(): bool</code>
      </td>
      <td>Registra la intervención física en ruta (ej. reconexión de toma 12V, cambio de ruta) y el visto bueno de control de calidad.</td>
    </tr>
    <tr>
      <td><code>IIncidentRepository</code></td>
      <td><code>«Repository»</code></td>
      <td>—</td>
      <td>
        <code>+ GetActiveIncidentsAsync(): Task&lt;List&lt;CriticalIncident&gt;&gt;</code><br>
        <code>+ SaveAsync(incident: CriticalIncident): Task</code>
      </td>
      <td>Contrato de persistencia de alertas e incidentes.</td>
    </tr>
    <tr>
      <td><code>INotificationService</code></td>
      <td><code>«Service»</code></td>
      <td>—</td>
      <td>
        <code>+ SendCriticalPushAlertAsync(userId: Guid, msg: string): Task&lt;bool&gt;</code><br>
        <code>+ SendSmsAlertAsync(phone: string, msg: string): Task&lt;bool&gt;</code>
      </td>
      <td>Abstracción hacia Firebase Cloud Messaging y Twilio SMS.</td>
    </tr>
    <tr>
      <td><code>IncidentSeverity</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>LowWarning</code>, <code>ModerateAlert</code>, <code>CriticalEmergency</code>, <code>CatastrophicFailure</code></td>
      <td>—</td>
      <td>Nivel de severidad de la anomalía.</td>
    </tr>
    <tr>
      <td><code>IncidentType</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>ColdChainBreachHigh</code>, <code>ColdChainBreachLow</code>, <code>Auxiliary12VPowerLost</code>, <code>PayloadTamperingSuspected</code>, <code>SevereTrafficDelayExceeded</code></td>
      <td>—</td>
      <td>Tipo de falla operativa detectada.</td>
    </tr>
    <tr>
      <td><code>EscalationLevelEnum</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>OperationalCabAlert = 1</code>, <code>LogisticsSupervisorAlert = 2</code>, <code>MedicalDirectorEscalation = 3</code></td>
      <td>—</td>
      <td>Nivel de escalamiento jerárquico asistencial conforme a <code>critical_incidents.escalation_level</code> en MySQL (valores base 1 requeridos por la restricción CHECK 1..3).</td>
    </tr>
    <tr>
      <td><code>IncidentStatus</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>Triggered</code>, <code>Acknowledged</code>, <code>Escalated</code>, <code>Resolved</code></td>
      <td>—</td>
      <td>Ciclo de vida operativo de la contingencia conforme a <code>critical_incidents.status</code> en MySQL.</td>
    </tr>
  </tbody>
</table>

---

#### **4.7.1.4. Bounded Context D: Chain of Custody & Traceability (Segmento 2 - Clínico y Legal)**

Modela la seguridad de custodia en el hospital receptor (**Segmento 2**): validación del **código OTP de un solo uso**, desbloqueo seguro de la tapa y generación inmutable del acta digital con hash criptográfico SHA-256 para auditorías de DIGEMID y DIGDOT.

<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  <thead>
    <tr>
      <th>Clase / Interfaz / Enum</th>
      <th>Estereotipo DDD</th>
      <th>Atributos (Visibilidad y Tipo)</th>
      <th>Métodos (Firma Completa y Retorno)</th>
      <th>Invariantes y Reglas Protegidas</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>CustodyTransfer</code></td>
      <td><code>«AggregateRoot»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ TripId: Guid</code><br>
        <code>+ RecipientHospitalId: Guid</code><br>
        <code>+ AuthorizedRecipientUserId: Guid</code><br>
        <code>+ Status: HandoverStatus</code><br>
        <code>+ RecipientNotes: string?</code><br>
        <code>+ TransferredAt: DateTime?</code><br>
        <code>- _otpToken: OtpToken</code>
      </td>
      <td>
        <code>+ GenerateRecipientOtp(): string</code><br>
        <code>+ VerifyOtpAndAuthorizeOpening(enteredOtp: string): Result</code><br>
        <code>+ ConfirmCustodyAcceptance(inspectorNotes: string): Result</code><br>
        <code>+ RejectDeliveryDueToThermalDamage(reason: string): void</code><br>
        <code>+ RejectDeliveryDueToTampering(reason: string): void</code>
      </td>
      <td>
        • El contenedor solo se destraba si el código OTP coincide exactamente y no ha expirado (&lt;15 min).<br>
        • Si se detectó excursión térmica irreparable o alteración de peso &gt; 15g, no se puede confirmar entrega conforme.<br>
        • Genera de forma asociada el <code>DigitalAuditManifest</code> como raíz de agregado inmutable.<br>
        • Registra notas de recepción conforme a <code>custody_transfers.recipient_notes</code> en MySQL.
      </td>
    </tr>
    <tr>
      <td><code>DigitalAuditManifest</code></td>
      <td><code>«AggregateRoot»</code></td>
      <td>
        <code>+ Id: Guid</code><br>
        <code>+ TransferId: Guid</code><br>
        <code>+ ManifestCode: string</code><br>
        <code>+ GeneratedAt: DateTime</code><br>
        <code>+ CryptographicHashSha256: string</code><br>
        <code>+ CloudStorageUrl: string</code><br>
        <code>+ IsSealedAndImmutable: bool</code><br>
        <code>+ AverageTemperatureCelsius: double</code><br>
        <code>+ MinTemperatureCelsius: double</code><br>
        <code>+ MaxTemperatureCelsius: double</code><br>
        <code>+ TotalExcursionSeconds: int</code><br>
        <code>+ MinsaComplianceVerified: bool</code>
      </td>
      <td>
        <code>+ CalculateThermalCompliance(): bool</code><br>
        <code>+ SealManifest(pdfBytes: byte[]): void</code>
      </td>
      <td>
        • El acta es estrictamente inmutable una vez sellada con hash SHA-256.<br>
        • Contiene la curva térmica minuto a minuto, acumulación de segundos de excursión y verificación explícita de directivas sanitarias del MINSA para sustento legal ante DIGEMID.
      </td>
    </tr>
    <tr>
      <td><code>OtpToken</code></td>
      <td><code>«ValueObject»</code></td>
      <td>
        <code>+ HashedCode: string</code><br>
        <code>+ ExpiresAtUtc: DateTime</code><br>
        <code>+ MaxAttemptsAllowed: int</code><br>
        <code>+ CurrentAttempts: int</code>
      </td>
      <td>
        <code>+ ValidateCode(plainCode: string): bool</code><br>
        <code>+ IsExpired(): bool</code>
      </td>
      <td>Inmutable. Token temporal de un solo uso despachado al teléfono del médico receptor.</td>
    </tr>
    <tr>
      <td><code>ICustodyRepository</code></td>
      <td><code>«Repository»</code></td>
      <td>—</td>
      <td>
        <code>+ GetTransferByTripIdAsync(tripId: Guid): Task&lt;CustodyTransfer&gt;</code><br>
        <code>+ SaveTransferAsync(transfer: CustodyTransfer): Task</code><br>
        <code>+ SaveManifestAsync(manifest: DigitalAuditManifest): Task</code>
      </td>
      <td>Contrato de persistencia de transferencias de custodia y actas auditables.</td>
    </tr>
    <tr>
      <td><code>IStorageService</code></td>
      <td><code>«Service»</code></td>
      <td>—</td>
      <td>
        <code>+ UploadImmutablePdfAsync(fileName: string, stream: Stream): Task&lt;string&gt;</code>
      </td>
      <td>Abstracción hacia AWS S3 para almacenamiento WORM.</td>
    </tr>
    <tr>
      <td><code>HandoverStatus</code></td>
      <td><code>«Enumeration»</code></td>
      <td><code>PendingOtpVerification</code>, <code>OtpVerifiedLidUnlocked</code>, <code>CompletedAccepted</code>, <code>RejectedThermalExcursion</code>, <code>RejectedTampering</code></td>
      <td>—</td>
      <td>Estados de la entrega física y legal.</td>
    </tr>
  </tbody>
</table>

---

#### **4.7.1.5. Domain Events y Clases Transversales (Shared Kernel)**

Permiten propagar asíncronamente cambios de estado críticos entre los Bounded Contexts sin generar acoplamiento directo entre Agregados Raíz:

<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  <thead>
    <tr>
      <th>Clase / Estructura</th>
      <th>Estereotipo DDD</th>
      <th>Atributos / Propiedades Tipadas C#</th>
      <th>Métodos / Comportamiento</th>
      <th>Descripción y Propósito de Negocio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>IDomainEvent</code></td>
      <td><code>«Interface»</code></td>
      <td>
        <code>+ EventId: Guid</code><br>
        <code>+ OccurredOn: DateTime</code>
      </td>
      <td>—</td>
      <td>Contrato base inmutable para todos los eventos emitidos por Agregados.</td>
    </tr>
    <tr>
      <td><code>ThermalExcursionDetectedEvent</code></td>
      <td><code>«DomainEvent»</code></td>
      <td>
        <code>+ ContainerId: Guid</code><br>
        <code>+ CurrentTemperature: double</code><br>
        <code>+ OccurredOn: DateTime</code>
      </td>
      <td>—</td>
      <td>Emitido por <code>SmartContainer</code> al rebasar la franja térmica de 2°C a 8°C. Desencadena la creación del incidente crítico.</td>
    </tr>
    <tr>
      <td><code>ExternalPowerLostEvent</code></td>
      <td><code>«DomainEvent»</code></td>
      <td>
        <code>+ ContainerId: Guid</code><br>
        <code>+ BatteryPercentage: decimal</code><br>
        <code>+ OccurredOn: DateTime</code>
      </td>
      <td>—</td>
      <td>Emitido al desconectarse el arnés vehicular de 12V de la ambulancia. Conmuta a respaldo LiFePO4 y alerta a cabina.</td>
    </tr>
    <tr>
      <td><code>HospitalPreArrivalTriggeredEvent</code></td>
      <td><code>«DomainEvent»</code></td>
      <td>
        <code>+ TripId: Guid</code><br>
        <code>+ DestinationHospitalId: Guid</code><br>
        <code>+ EstimatedArrival: DateTime</code><br>
        <code>+ OccurredOn: DateTime</code>
      </td>
      <td>—</td>
      <td>Emitido por <code>DispatchTrip</code> al cruzar el radio de geocerca de 2 km. Despacha el token OTP hacia el médico receptor.</td>
    </tr>
    <tr>
      <td><code>CustodyAcceptedEvent</code></td>
      <td><code>«DomainEvent»</code></td>
      <td>
        <code>+ TransferId: Guid</code><br>
        <code>+ RecipientUserId: Guid</code><br>
        <code>+ OccurredOn: DateTime</code>
      </td>
      <td>—</td>
      <td>Emitido por <code>CustodyTransfer</code> tras validar el OTP y desbloquear la tapa. Dispara la generación del manifiesto digital SHA-256.</td>
    </tr>
    <tr>
      <td><code>Result</code></td>
      <td><code>«ValueObject»</code></td>
      <td>
        <code>+ IsSuccess: bool</code><br>
        <code>+ ErrorMessage: string</code><br>
        <code>+ IsFailure: bool</code>
      </td>
      <td>
        <code>+ Ok(): Result</code><br>
        <code>+ Fail(error: string): Result</code>
      </td>
      <td>Objeto de valor inmutable del Shared Kernel que encapsula el resultado exitoso o fallido de operaciones de negocio sin requerir excepciones no controladas.</td>
    </tr>
  </tbody>
</table>

---

### **3. Matriz de Relaciones y Cardinalidades del Modelo de Clases**

Para asegurar total rigurosidad en la implementación del diagrama UML, la siguiente tabla define todas las relaciones del ecosistema:

<table border="1" cellpadding="5" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  <thead>
    <tr>
      <th>Clase Origen</th>
      <th>Multiplicidad</th>
      <th>Tipo de Relación UML</th>
      <th>Multiplicidad</th>
      <th>Clase Destino</th>
      <th>Rol / Calificación de la Relación</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>SmartContainer</code></td>
      <td><code>1</code></td>
      <td>Composición (<code>*--</code>)</td>
      <td><code>1</code></td>
      <td><code>ElectromechanicalLock</code></td>
      <td><code>- _lock</code> (perno de seguridad)</td>
    </tr>
    <tr>
      <td><code>SmartContainer</code></td>
      <td><code>1</code></td>
      <td>Composición (<code>*--</code>)</td>
      <td><code>1</code></td>
      <td><code>PeltierCooler</code></td>
      <td><code>- _cooler</code> (celda de refrigeración)</td>
    </tr>
    <tr>
      <td><code>SmartContainer</code></td>
      <td><code>1</code></td>
      <td>Composición (<code>*--</code>)</td>
      <td><code>1</code></td>
      <td><code>BatteryUnit</code></td>
      <td><code>- _battery</code> (batería interna Li-Ion)</td>
    </tr>
    <tr>
      <td><code>SmartContainer</code></td>
      <td><code>1</code></td>
      <td>Dependencia (<code>..&gt;</code>)</td>
      <td><code>*</code></td>
      <td><code>TelemetrySnapshot</code></td>
      <td><code>processes &gt;</code> (lecturas periódicas)</td>
    </tr>
    <tr>
      <td><code>SmartContainer</code></td>
      <td><code>1</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>*</code></td>
      <td><code>TelemetryLog</code></td>
      <td><code>records &gt;</code> (histórico sensorial continuo persistido en MySQL)</td>
    </tr>
    <tr>
      <td><code>ITelemetryRepository</code></td>
      <td><code>1</code></td>
      <td>Dependencia (<code>..&gt;</code>)</td>
      <td><code>*</code></td>
      <td><code>TelemetryLog</code></td>
      <td><code>persists &gt;</code> (contrato de persistencia de series temporales)</td>
    </tr>
    <tr>
      <td><code>DispatchTrip</code></td>
      <td><code>1</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>1</code></td>
      <td><code>SmartContainer</code></td>
      <td><code>transports &gt;</code> (contenedor asignado)</td>
    </tr>
    <tr>
      <td><code>DispatchTrip</code></td>
      <td><code>1</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>1</code></td>
      <td><code>TransportOrder</code></td>
      <td><code>fulfills &gt;</code> (orden médica urgente)</td>
    </tr>
    <tr>
      <td><code>DispatchTrip</code></td>
      <td><code>1</code></td>
      <td>Composición (<code>*--</code>)</td>
      <td><code>1</code></td>
      <td><code>TransportRoute</code></td>
      <td><code>- _route</code> (ruta y tráfico)</td>
    </tr>
    <tr>
      <td><code>DispatchTrip</code></td>
      <td><code>1</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>1</code></td>
      <td><code>CustodyTransfer</code></td>
      <td><code>culminates in &gt;</code> (entrega hospitalaria)</td>
    </tr>
    <tr>
      <td><code>SmartContainer</code></td>
      <td><code>1</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>0..*</code></td>
      <td><code>CriticalIncident</code></td>
      <td><code>triggers &gt;</code> (alertas operativas)</td>
    </tr>
    <tr>
      <td><code>CriticalIncident</code></td>
      <td><code>1</code></td>
      <td>Composición (<code>*--</code>)</td>
      <td><code>0..1</code></td>
      <td><code>ContingencyResolution</code></td>
      <td><code>- _resolution</code> (mitigación registrada)</td>
    </tr>
    <tr>
      <td><code>CustodyTransfer</code></td>
      <td><code>1</code></td>
      <td>Composición (<code>*--</code>)</td>
      <td><code>1</code></td>
      <td><code>OtpToken</code></td>
      <td><code>- _otpToken</code> (código seguro de apertura)</td>
    </tr>
    <tr>
      <td><code>CustodyTransfer</code></td>
      <td><code>1</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>0..1</code></td>
      <td><code>DigitalAuditManifest</code></td>
      <td><code>generates &gt;</code> (acta legal inmutable, generada y sellada al validar OTP)</td>
    </tr>
    <tr>
      <td><code>HospitalInstitution</code></td>
      <td><code>*</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>1</code></td>
      <td><code>SubscriptionPlan</code></td>
      <td><code>subscribed to &gt;</code> (plan SaaS contratado)</td>
    </tr>
    <tr>
      <td><code>UserAccount</code></td>
      <td><code>*</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>1</code></td>
      <td><code>HospitalInstitution</code></td>
      <td><code>belongs to &gt;</code> (entidad empleadora)</td>
    </tr>
    <tr>
      <td><code>TransportOrder</code></td>
      <td><code>*</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>1</code></td>
      <td><code>HospitalInstitution</code></td>
      <td><code>origin &gt; / destination &gt;</code> (sedes remitente y receptora)</td>
    </tr>
    <tr>
      <td><code>DispatchTrip</code></td>
      <td><code>*</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>1</code></td>
      <td><code>UserAccount</code></td>
      <td><code>assigned crew &gt;</code> (chofer y paramédico asignados)</td>
    </tr>
    <tr>
      <td><code>CustodyTransfer</code></td>
      <td><code>*</code></td>
      <td>Asociación (<code>--&gt;</code>)</td>
      <td><code>1</code></td>
      <td><code>UserAccount</code></td>
      <td><code>recipient &gt;</code> (médico o farmacéutico que recibe con OTP)</td>
    </tr>
  </tbody>
</table>

---

### **4. Diagramas de Clases por Bounded Context**

A continuación, se presentan las especificaciones visuales del diseño orientado a objetos para cada uno de los Bounded Contexts de la plataforma, elaboradas bajo la notación formal de UML 2.5 y los patrones tácticos de Domain-Driven Design:

#### **4.1. Bounded Context: Identity, Access & Subscriptions (IAM)**

![Figura 4.7.1.1 - Diagrama de Clases: Identity, Access & Subscriptions (IAM)](../assets/chapter-4/4.7.1-class-diagram-iam.png)

*Nota: Elaboración propia en PlantUML conforme a los estándares de UML 2.5 y Domain-Driven Design para el Bounded Context de IAM y Suscripciones.*

---

#### **4.2. Bounded Context: Smart Container & Telemetry Monitoring**

![Figura 4.7.1.2 - Diagrama de Clases: Smart Container & Telemetry Monitoring](../assets/chapter-4/4.7.1-class-diagram-smart-container.png)

*Nota: Elaboración propia en PlantUML conforme a los estándares de UML 2.5 y Domain-Driven Design para el Bounded Context de Contenedores Inteligentes y Telemetría.*

---

#### **4.3. Bounded Context: Medical Transport Planning & Dispatching**

![Figura 4.7.1.3 - Diagrama de Clases: Medical Transport Planning & Dispatching](../assets/chapter-4/4.7.1-class-diagram-transport-planning.png)

*Nota: Elaboración propia en PlantUML conforme a los estándares de UML 2.5 y Domain-Driven Design para el Bounded Context de Transporte y Despacho.*

---

#### **4.4. Bounded Context: Critical Alerting & Incident Response**

![Figura 4.7.1.4 - Diagrama de Clases: Critical Alerting & Incident Response](../assets/chapter-4/4.7.1-class-diagram-critical-alerting.png)

*Nota: Elaboración propia en PlantUML conforme a los estándares de UML 2.5 y Domain-Driven Design para el Bounded Context de Alertas Críticas e Incidentes.*

---

#### **4.5. Bounded Context: Chain of Custody & Traceability**

![Figura 4.7.1.5 - Diagrama de Clases: Chain of Custody & Traceability](../assets/chapter-4/4.7.1-class-diagram-chain-of-custody.png)

*Nota: Elaboración propia en PlantUML conforme a los estándares de UML 2.5 y Domain-Driven Design para el Bounded Context de Cadena de Custodia y Trazabilidad.*
