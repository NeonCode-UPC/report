-- =============================================================================
-- PROYECTO: Medical SMARTBOX - Plataforma IoT para Contenedores Médicos Inteligentes
-- CURSO: 1ASI0730 - Aplicaciones Web | Rúbrica ABET (UPC)
-- CAPÍTULO: 4.8 Database Design - 4.8.1 Database Diagrams
-- RDBMS: MySQL Server 8.0 (Storage Engine: InnoDB, Charset: utf8mb4)
-- =============================================================================

CREATE DATABASE IF NOT EXISTS `medical_smartbox_db`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE `medical_smartbox_db`;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `digital_audit_manifests`;
DROP TABLE IF EXISTS `contingency_resolutions`;
DROP TABLE IF EXISTS `critical_incidents`;
DROP TABLE IF EXISTS `custody_transfers`;
DROP TABLE IF EXISTS `telemetry_logs`;
DROP TABLE IF EXISTS `dispatch_trips`;
DROP TABLE IF EXISTS `transport_orders`;
DROP TABLE IF EXISTS `smart_containers`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `hospital_institutions`;
DROP TABLE IF EXISTS `subscription_plans`;

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- 1. BOUNDED CONTEXT: IAM & SUBSCRIPTIONS (Soporte B2B y Acceso)
-- =============================================================================

-- Tabla: subscription_plans
CREATE TABLE `subscription_plans` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `code` VARCHAR(20) NOT NULL,
    `max_ambulances` INT NOT NULL DEFAULT 5,
    `max_smartboxes` INT NOT NULL DEFAULT 10,
    `monthly_price_usd` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `support_sla_hours` INT NOT NULL DEFAULT 24,
    `telemetry_data_retention_months` INT NOT NULL DEFAULT 12,
    `is_active` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT `pk_subscription_plans` PRIMARY KEY (`id`),
    CONSTRAINT `uq_subscription_plans_code` UNIQUE (`code`),
    CONSTRAINT `chk_subscription_plans_max_amb` CHECK (`max_ambulances` > 0),
    CONSTRAINT `chk_subscription_plans_max_box` CHECK (`max_smartboxes` > 0),
    CONSTRAINT `chk_subscription_plans_price` CHECK (`monthly_price_usd` >= 0.00),
    CONSTRAINT `chk_subscription_plans_retention` CHECK (`telemetry_data_retention_months` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Planes de suscripción SaaS B2B para clínicas, hospitales y redes de ambulancias.';

-- Tabla: hospital_institutions
CREATE TABLE `hospital_institutions` (
    `id` CHAR(36) NOT NULL,
    `subscription_plan_id` CHAR(36) NOT NULL,
    `name` VARCHAR(150) NOT NULL,
    `tax_id_ruc` VARCHAR(11) NOT NULL,
    `institution_type` ENUM('PublicHospital', 'PrivateClinic', 'AmbulanceNetwork', 'PharmaceuticalLab') NOT NULL DEFAULT 'PublicHospital',
    `health_service_level` VARCHAR(20) NOT NULL DEFAULT 'II-2',
    `address` VARCHAR(255) NOT NULL,
    `district` VARCHAR(100) NOT NULL,
    `emergency_phone` VARCHAR(20) NOT NULL,
    `renipress_code` VARCHAR(20) NOT NULL,
    `latitude` DECIMAL(10, 8) NOT NULL,
    `longitude` DECIMAL(11, 8) NOT NULL,
    `geofence_radius_meters` DECIMAL(6, 2) NOT NULL DEFAULT 2000.00,
    `is_active` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updated_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT `pk_hospital_institutions` PRIMARY KEY (`id`),
    CONSTRAINT `uq_hospital_institutions_ruc` UNIQUE (`tax_id_ruc`),
    CONSTRAINT `uq_hospital_institutions_renipress` UNIQUE (`renipress_code`),
    CONSTRAINT `chk_institutions_lat` CHECK (`latitude` BETWEEN -90.00000000 AND 90.00000000),
    CONSTRAINT `chk_institutions_lon` CHECK (`longitude` BETWEEN -180.00000000 AND 180.00000000),
    CONSTRAINT `chk_institutions_geofence` CHECK (`geofence_radius_meters` > 0.00),
    CONSTRAINT `fk_institutions_subscription_plan` FOREIGN KEY (`subscription_plan_id`)
        REFERENCES `subscription_plans` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Centros hospitalarios, clínicas de trasplante y operadores de ambulancias registrados con geocerca.';

-- Tabla: users
CREATE TABLE `users` (
    `id` CHAR(36) NOT NULL,
    `institution_id` CHAR(36) NOT NULL,
    `first_name` VARCHAR(80) NOT NULL,
    `last_name` VARCHAR(80) NOT NULL,
    `email` VARCHAR(120) NOT NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `role` ENUM('FleetDispatcher', 'AmbulanceDriver', 'Paramedic', 'ClinicalPharmacist', 'ReceivingSurgeon', 'QualityAuditor', 'SystemAdministrator') NOT NULL,
    `phone_number` VARCHAR(20) NOT NULL,
    `medical_license_number` VARCHAR(30) NULL,
    `is_active` TINYINT(1) NOT NULL DEFAULT 1,
    `last_login_at` DATETIME(6) NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updated_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT `pk_users` PRIMARY KEY (`id`),
    CONSTRAINT `uq_users_email` UNIQUE (`email`),
    CONSTRAINT `fk_users_institution` FOREIGN KEY (`institution_id`)
        REFERENCES `hospital_institutions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Usuarios autenticados: choferes, paramédicos, cirujanos, operadores de despacho y auditores.';

-- =============================================================================
-- 2. BOUNDED CONTEXT: SMART CONTAINER & TELEMETRY MONITORING (Core IoT)
-- =============================================================================

-- Tabla: smart_containers
CREATE TABLE `smart_containers` (
    `id` CHAR(36) NOT NULL,
    `serial_number` VARCHAR(30) NOT NULL,
    `form_factor` ENUM('SmallBox_5L', 'StandardBox_20L') NOT NULL DEFAULT 'StandardBox_20L',
    `status` ENUM('Available', 'Precooling', 'LockedAndReady', 'InTransit', 'Delivered', 'MaintenanceRequired') NOT NULL DEFAULT 'Available',
    `lock_state` ENUM('Locked', 'Unlocked', 'Tampered', 'Error') NOT NULL DEFAULT 'Unlocked',
    `current_temperature_celsius` DECIMAL(4, 2) NOT NULL DEFAULT 4.00,
    `tare_weight_grams` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    `net_weight_grams` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    `battery_percentage` DECIMAL(5, 2) NOT NULL DEFAULT 100.00,
    `is_12v_connected` TINYINT(1) NOT NULL DEFAULT 0,
    `last_telemetry_at` DATETIME(6) NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updated_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT `pk_smart_containers` PRIMARY KEY (`id`),
    CONSTRAINT `uq_smart_containers_serial` UNIQUE (`serial_number`),
    CONSTRAINT `chk_containers_temp` CHECK (`current_temperature_celsius` BETWEEN -20.00 AND 60.00),
    CONSTRAINT `chk_containers_battery` CHECK (`battery_percentage` BETWEEN 0.00 AND 100.00),
    CONSTRAINT `chk_containers_tare` CHECK (`tare_weight_grams` >= 0.00),
    CONSTRAINT `chk_containers_net` CHECK (`net_weight_grams` >= 0.00)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Contenedores isotérmicos inteligentes equipados con celdas Peltier, solenoide y telemetría IoT.';

-- Tabla: telemetry_logs
CREATE TABLE `telemetry_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `container_id` CHAR(36) NOT NULL,
    `trip_id` CHAR(36) NULL,
    `timestamp_utc` DATETIME(6) NOT NULL,
    `temperature_celsius` DECIMAL(4, 2) NOT NULL,
    `ambient_temperature_celsius` DECIMAL(4, 2) NOT NULL,
    `weight_grams` DECIMAL(8, 2) NOT NULL,
    `battery_percentage` DECIMAL(5, 2) NOT NULL,
    `is_12v_connected` TINYINT(1) NOT NULL DEFAULT 0,
    `peltier_power_pct` INT NOT NULL DEFAULT 0,
    `lid_lock_engaged` TINYINT(1) NOT NULL DEFAULT 1,
    `latitude` DECIMAL(10, 8) NULL,
    `longitude` DECIMAL(11, 8) NULL,
    `firmware_signature` VARCHAR(128) NOT NULL,
    `is_thermal_excursion` TINYINT(1) NOT NULL DEFAULT 0,
    CONSTRAINT `pk_telemetry_logs` PRIMARY KEY (`id`),
    CONSTRAINT `fk_telemetry_container` FOREIGN KEY (`container_id`)
        REFERENCES `smart_containers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `chk_telemetry_power` CHECK (`peltier_power_pct` BETWEEN 0 AND 100),
    CONSTRAINT `chk_telemetry_battery` CHECK (`battery_percentage` BETWEEN 0.00 AND 100.00)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Muestras sensoriales de alta frecuencia emitidas cada 5s por el microcontrolador ESP32 vía MQTT.';

-- =============================================================================
-- 3. BOUNDED CONTEXT: MEDICAL TRANSPORT PLANNING & DISPATCHING (Core Operativo)
-- =============================================================================

-- Tabla: transport_orders
CREATE TABLE `transport_orders` (
    `id` CHAR(36) NOT NULL,
    `order_code` VARCHAR(20) NOT NULL,
    `origin_hospital_id` CHAR(36) NOT NULL,
    `destination_hospital_id` CHAR(36) NOT NULL,
    `cargo_type` ENUM('HeartOrgan', 'LiverOrgan', 'KidneyOrgan', 'BloodPlasmaPack', 'ThermolabileVaccine', 'BiopsySample') NOT NULL,
    `cargo_description` VARCHAR(255) NOT NULL,
    `max_ischemia_hours` DECIMAL(4, 2) NOT NULL,
    `ischemia_warning_hours` DECIMAL(4, 2) NOT NULL,
    `clinical_priority` ENUM('Routine', 'Urgent', 'StatEmergency') NOT NULL DEFAULT 'StatEmergency',
    `status` ENUM('Pending', 'Assigned', 'InTransit', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Pending',
    `created_by_user_id` CHAR(36) NOT NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updated_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT `pk_transport_orders` PRIMARY KEY (`id`),
    CONSTRAINT `uq_transport_orders_code` UNIQUE (`order_code`),
    CONSTRAINT `fk_orders_origin_hospital` FOREIGN KEY (`origin_hospital_id`)
        REFERENCES `hospital_institutions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_orders_dest_hospital` FOREIGN KEY (`destination_hospital_id`)
        REFERENCES `hospital_institutions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_orders_created_by` FOREIGN KEY (`created_by_user_id`)
        REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `chk_orders_ischemia_limits` CHECK (`max_ischemia_hours` > `ischemia_warning_hours` AND `ischemia_warning_hours` > 0.00)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Órdenes médicas de traslado de órganos y hemoderivados con restricciones de isquemia fría.';

-- Tabla: dispatch_trips
CREATE TABLE `dispatch_trips` (
    `id` CHAR(36) NOT NULL,
    `order_id` CHAR(36) NOT NULL,
    `assigned_container_id` CHAR(36) NOT NULL,
    `assigned_driver_user_id` CHAR(36) NOT NULL,
    `assigned_paramedic_user_id` CHAR(36) NOT NULL,
    `assigned_vehicle_plate` VARCHAR(10) NOT NULL,
    `status` ENUM('Scheduled', 'ResourcesAssigned', 'PrecoolingVerified', 'InTransit', 'ArrivedAtDestination', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    `scheduled_departure_time` DATETIME(6) NOT NULL,
    `actual_departure_time` DATETIME(6) NULL,
    `estimated_arrival_time` DATETIME(6) NOT NULL,
    `actual_arrival_time` DATETIME(6) NULL,
    `distance_km` DECIMAL(6, 2) NOT NULL DEFAULT 0.00,
    `planned_duration_minutes` INT NOT NULL DEFAULT 0,
    `current_delay_minutes` INT NOT NULL DEFAULT 0,
    `polyline_coordinates` TEXT NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updated_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT `pk_dispatch_trips` PRIMARY KEY (`id`),
    CONSTRAINT `uq_dispatch_trips_order` UNIQUE (`order_id`),
    CONSTRAINT `fk_trips_order` FOREIGN KEY (`order_id`)
        REFERENCES `transport_orders` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_trips_container` FOREIGN KEY (`assigned_container_id`)
        REFERENCES `smart_containers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_trips_driver` FOREIGN KEY (`assigned_driver_user_id`)
        REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_trips_paramedic` FOREIGN KEY (`assigned_paramedic_user_id`)
        REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Despachos operativos en ambulancias, vinculando tripulación, contenedor IoT y telemetría TomTom.';

-- Añadir FK diferida en telemetry_logs hacia dispatch_trips
ALTER TABLE `telemetry_logs`
    ADD CONSTRAINT `fk_telemetry_trip` FOREIGN KEY (`trip_id`)
        REFERENCES `dispatch_trips` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- =============================================================================
-- 4. BOUNDED CONTEXT: CRITICAL ALERTING & INCIDENT RESPONSE (Soporte Reactivo)
-- =============================================================================

-- Tabla: critical_incidents
CREATE TABLE `critical_incidents` (
    `id` CHAR(36) NOT NULL,
    `trip_id` CHAR(36) NOT NULL,
    `container_id` CHAR(36) NOT NULL,
    `severity` ENUM('LowWarning', 'ModerateAlert', 'CriticalEmergency', 'CatastrophicFailure') NOT NULL DEFAULT 'CriticalEmergency',
    `incident_type` ENUM('ColdChainBreachHigh', 'ColdChainBreachLow', 'Auxiliary12VPowerLost', 'PayloadTamperingSuspected', 'SevereTrafficDelayExceeded') NOT NULL,
    `triggered_at` DATETIME(6) NOT NULL,
    `trigger_temperature_celsius` DECIMAL(4, 2) NULL,
    `trigger_battery_percentage` DECIMAL(5, 2) NULL,
    `status` ENUM('Triggered', 'Acknowledged', 'Escalated', 'Resolved') NOT NULL DEFAULT 'Triggered',
    `escalation_level` INT NOT NULL DEFAULT 1,
    `acknowledged_at` DATETIME(6) NULL,
    `acknowledged_by_user_id` CHAR(36) NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT `pk_critical_incidents` PRIMARY KEY (`id`),
    CONSTRAINT `fk_incidents_trip` FOREIGN KEY (`trip_id`)
        REFERENCES `dispatch_trips` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_incidents_container` FOREIGN KEY (`container_id`)
        REFERENCES `smart_containers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_incidents_ack_user` FOREIGN KEY (`acknowledged_by_user_id`)
        REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `chk_incidents_escalation` CHECK (`escalation_level` BETWEEN 1 AND 3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Incidentes críticos de cadena de frío y contingencias energéticas en ruta.';

-- Tabla: contingency_resolutions
CREATE TABLE `contingency_resolutions` (
    `id` CHAR(36) NOT NULL,
    `incident_id` CHAR(36) NOT NULL,
    `mitigation_action` VARCHAR(500) NOT NULL,
    `was_thermal_integrity_restored` TINYINT(1) NOT NULL DEFAULT 1,
    `quality_signoff_notes` TEXT NOT NULL,
    `resolved_by_user_id` CHAR(36) NOT NULL,
    `resolved_at` DATETIME(6) NOT NULL,
    CONSTRAINT `pk_contingency_resolutions` PRIMARY KEY (`id`),
    CONSTRAINT `uq_contingency_incident` UNIQUE (`incident_id`),
    CONSTRAINT `fk_resolutions_incident` FOREIGN KEY (`incident_id`)
        REFERENCES `critical_incidents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_resolutions_user` FOREIGN KEY (`resolved_by_user_id`)
        REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Medidas correctivas aplicadas por el operador biomédico o cirujano para salvar la carga médica.';

-- =============================================================================
-- 5. BOUNDED CONTEXT: CHAIN OF CUSTODY & TRACEABILITY (Core Regulatorio)
-- =============================================================================

-- Tabla: custody_transfers
CREATE TABLE `custody_transfers` (
    `id` CHAR(36) NOT NULL,
    `trip_id` CHAR(36) NOT NULL,
    `recipient_hospital_id` CHAR(36) NOT NULL,
    `authorized_recipient_user_id` CHAR(36) NOT NULL,
    `handover_status` ENUM('PendingOtpVerification', 'OtpVerifiedLidUnlocked', 'CompletedAccepted', 'RejectedThermalExcursion', 'RejectedTampering') NOT NULL DEFAULT 'PendingOtpVerification',
    `otp_code_hash` VARCHAR(128) NOT NULL,
    `otp_expires_at` DATETIME(6) NOT NULL,
    `otp_attempt_count` INT NOT NULL DEFAULT 0,
    `otp_verified_at` DATETIME(6) NULL,
    `recipient_notes` VARCHAR(500) NULL,
    `created_at` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `completed_at` DATETIME(6) NULL,
    CONSTRAINT `pk_custody_transfers` PRIMARY KEY (`id`),
    CONSTRAINT `uq_custody_transfers_trip` UNIQUE (`trip_id`),
    CONSTRAINT `fk_transfers_trip` FOREIGN KEY (`trip_id`)
        REFERENCES `dispatch_trips` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_transfers_hospital` FOREIGN KEY (`recipient_hospital_id`)
        REFERENCES `hospital_institutions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_transfers_user` FOREIGN KEY (`authorized_recipient_user_id`)
        REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `chk_custody_otp_attempts` CHECK (`otp_attempt_count` BETWEEN 0 AND 3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Protocolo de entrega hospitalaria con autenticación de apertura mediante código OTP de un solo uso.';

-- Tabla: digital_audit_manifests
CREATE TABLE `digital_audit_manifests` (
    `id` CHAR(36) NOT NULL,
    `transfer_id` CHAR(36) NOT NULL,
    `manifest_code` VARCHAR(30) NOT NULL,
    `cryptographic_hash_sha256` CHAR(64) NOT NULL,
    `cloud_storage_pdf_url` VARCHAR(500) NOT NULL,
    `is_sealed_and_immutable` TINYINT(1) NOT NULL DEFAULT 1,
    `average_temperature_celsius` DECIMAL(4, 2) NOT NULL,
    `min_temperature_celsius` DECIMAL(4, 2) NOT NULL,
    `max_temperature_celsius` DECIMAL(4, 2) NOT NULL,
    `total_excursion_seconds` INT NOT NULL DEFAULT 0,
    `minsa_compliance_verified` TINYINT(1) NOT NULL DEFAULT 1,
    `sealed_at` DATETIME(6) NOT NULL,
    CONSTRAINT `pk_digital_audit_manifests` PRIMARY KEY (`id`),
    CONSTRAINT `uq_audit_manifests_transfer` UNIQUE (`transfer_id`),
    CONSTRAINT `uq_audit_manifests_code` UNIQUE (`manifest_code`),
    CONSTRAINT `fk_manifests_transfer` FOREIGN KEY (`transfer_id`)
        REFERENCES `custody_transfers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `chk_manifests_excursion` CHECK (`total_excursion_seconds` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Acta digital inmutable de entrega sellada con hash SHA-256 para auditorías DIGEMID (R.M. 833-2015).';

-- =============================================================================
-- 6. ÍNDICES DE ALTO RENDIMIENTO (OPTIMIZACIÓN B-TREE PARA TELEMETRÍA E IoT)
-- =============================================================================

-- Índice compuesto para consultas de telemetría en tiempo real (SignalR y Web App Vue.js)
CREATE INDEX `idx_telemetry_container_timestamp`
    ON `telemetry_logs` (`container_id`, `timestamp_utc` DESC);

-- Índice para recuperar toda la telemetría asociada a un viaje de ambulancia
CREATE INDEX `idx_telemetry_trip_timestamp`
    ON `telemetry_logs` (`trip_id`, `timestamp_utc` ASC);

-- Índice para filtrar viajes activos en el dashboard de despacho (Segmento 1)
CREATE INDEX `idx_dispatch_trips_status_departure`
    ON `dispatch_trips` (`status`, `scheduled_departure_time`);

-- Índice para despachos asignados a un chofer o paramédico específico
CREATE INDEX `idx_dispatch_trips_driver_status`
    ON `dispatch_trips` (`assigned_driver_user_id`, `status`);

-- Índice para filtrar órdenes clínicas por estado y prioridad médica (Segmento 2)
CREATE INDEX `idx_transport_orders_status_priority`
    ON `transport_orders` (`status`, `clinical_priority`);

-- Índice para monitoreo de incidentes críticos no resueltos
CREATE INDEX `idx_critical_incidents_status_severity`
    ON `critical_incidents` (`status`, `severity`);

-- Índice para validación de contenedores disponibles por factor de forma
CREATE INDEX `idx_smart_containers_status_form`
    ON `smart_containers` (`status`, `form_factor`);

-- =============================================================================
-- 7. DATOS SEMILLA DE PRUEBA (VALIDACIÓN DE CONSISTENCIA E INTEGRIDAD)
-- =============================================================================

START TRANSACTION;

-- Plan SaaS
INSERT INTO `subscription_plans` (`id`, `name`, `code`, `max_ambulances`, `max_smartboxes`, `monthly_price_usd`, `support_sla_hours`, `is_active`)
VALUES
    ('a0000001-0000-0000-0000-000000000001', 'Plan Red Hospitalaria Integral', 'HOSP-ENTERPRISE-01', 25, 50, 2490.00, 2, 1);

-- Hospitales (Origen y Destino)
INSERT INTO `hospital_institutions` (`id`, `subscription_plan_id`, `name`, `tax_id_ruc`, `institution_type`, `address`, `district`, `emergency_phone`, `renipress_code`, `latitude`, `longitude`, `geofence_radius_meters`, `is_active`)
VALUES
    ('b0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000001', 'Hospital Nacional Edgardo Rebagliati Martins', '20131257750', 'PublicHospital', 'Av. Edgardo Rebagliati 490', 'Jesús María', '+51 1 2654901', 'MINSA-REBAGLIATI-01', -12.07185000, -77.03348000, 2000.00, 1),
    ('b0000002-0000-0000-0000-000000000002', 'a0000001-0000-0000-0000-000000000001', 'Instituto Nacional Cardiovascular (INCOR)', '20131257751', 'PublicHospital', 'Jr. Coronel Zegarra 417', 'Jesús María', '+51 1 4111560', 'MINSA-INCOR-02', -12.07722000, -77.03889000, 2000.00, 1);

-- Usuarios
INSERT INTO `users` (`id`, `institution_id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `phone_number`, `medical_license_number`, `is_active`)
VALUES
    ('c0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Carlos', 'Mendoza', 'cmendoza@ambulanciaslima.pe', '$2a$12$e8Y...driverhash', 'AmbulanceDriver', '+51 987654321', NULL, 1),
    ('c0000002-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Elena', 'Ríos', 'erios@ambulanciaslima.pe', '$2a$12$x9Z...paramedichash', 'Paramedic', '+51 987654322', 'TEM-4521', 1),
    ('c0000003-0000-0000-0000-000000000002', 'b0000002-0000-0000-0000-000000000002', 'Dr. Roberto', 'Castillo', 'rcastillo@incor.minsa.gob.pe', '$2a$12$k1W...surgeonhash', 'ReceivingSurgeon', '+51 987654323', 'CMP-38491', 1),
    ('c0000004-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Marco', 'Valdivia', 'mvaldivia@despachosamu.pe', '$2a$12$j4Q...operatorhash', 'FleetDispatcher', '+51 987654324', NULL, 1),
    ('c0000005-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Dra. Lucía', 'Paredes', 'lparedes@rebagliati.minsa.gob.pe', '$2a$12$m7P...pharmhash', 'ClinicalPharmacist', '+51 987654325', 'CQFP-19482', 1);

-- Contenedor Inteligente IoT
INSERT INTO `smart_containers` (`id`, `serial_number`, `form_factor`, `status`, `lock_state`, `current_temperature_celsius`, `tare_weight_grams`, `net_weight_grams`, `battery_percentage`, `is_12v_connected`, `last_telemetry_at`)
VALUES
    ('d0000001-0000-0000-0000-000000000001', 'SMB-BOX-2026-0042', 'StandardBox_20L', 'Delivered', 'Locked', 3.85, 4250.00, 310.50, 94.50, 1, '2026-09-15 14:15:00.000000');

-- Orden de Transporte de Órgano (Corazón - Isquemia 4h)
INSERT INTO `transport_orders` (`id`, `order_code`, `origin_hospital_id`, `destination_hospital_id`, `cargo_type`, `cargo_description`, `max_ischemia_hours`, `ischemia_warning_hours`, `clinical_priority`, `status`, `created_by_user_id`)
VALUES
    ('e0000001-0000-0000-0000-000000000001', 'ORD-2026-TRP-001', 'b0000001-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000002', 'HeartOrgan', 'Corazón de donante cadavérico en solución Custodiol (+3.5 °C)', 4.00, 3.00, 'StatEmergency', 'Completed', 'c0000003-0000-0000-0000-000000000002');

-- Despacho Operativo de Ambulancia
INSERT INTO `dispatch_trips` (`id`, `order_id`, `assigned_container_id`, `assigned_driver_user_id`, `assigned_paramedic_user_id`, `assigned_vehicle_plate`, `status`, `scheduled_departure_time`, `actual_departure_time`, `estimated_arrival_time`, `actual_arrival_time`, `distance_km`, `planned_duration_minutes`, `current_delay_minutes`, `polyline_coordinates`)
VALUES
    ('f0000001-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'c0000001-0000-0000-0000-000000000001', 'c0000002-0000-0000-0000-000000000001', 'EUG-418', 'Completed', '2026-09-15 13:45:00.000000', '2026-09-15 13:50:00.000000', '2026-09-15 14:35:00.000000', '2026-09-15 14:55:00.000000', 14.80, 45, 8, '-12.071,-77.033;-12.078,-77.039');

-- Muestra de Telemetría
INSERT INTO `telemetry_logs` (`id`, `container_id`, `trip_id`, `timestamp_utc`, `temperature_celsius`, `ambient_temperature_celsius`, `weight_grams`, `battery_percentage`, `is_12v_connected`, `peltier_power_pct`, `lid_lock_engaged`, `latitude`, `longitude`, `firmware_signature`, `is_thermal_excursion`)
VALUES
    (1, 'd0000001-0000-0000-0000-000000000001', 'f0000001-0000-0000-0000-000000000001', '2026-09-15 14:15:00.000000', 3.85, 23.40, 4560.50, 94.50, 1, 35, 1, -12.07541200, -77.03612400, 'SHA256:ESP32_SIG_v2.4_9bf2a4', 0);

-- Transferencia de Custodia con Token OTP
INSERT INTO `custody_transfers` (`id`, `trip_id`, `recipient_hospital_id`, `authorized_recipient_user_id`, `handover_status`, `otp_code_hash`, `otp_expires_at`, `otp_attempt_count`, `otp_verified_at`, `recipient_notes`, `completed_at`)
VALUES
    ('10000001-0000-0000-0000-000000000001', 'f0000001-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000002', 'c0000003-0000-0000-0000-000000000002', 'CompletedAccepted', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', '2026-09-15 15:00:00.000000', 1, '2026-09-15 14:58:30.000000', 'Recepción conforme en quirófano de trasplantes. Órgano viable con temperatura dentro de rango normativo.', '2026-09-15 15:05:00.000000');

-- Incidente Crítico (Excursión Térmica en Tránsito)
INSERT INTO `critical_incidents` (`id`, `trip_id`, `container_id`, `severity`, `incident_type`, `triggered_at`, `trigger_temperature_celsius`, `trigger_battery_percentage`, `status`, `escalation_level`, `acknowledged_at`, `acknowledged_by_user_id`)
VALUES
    ('70000001-0000-0000-0000-000000000001', 'f0000001-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'ModerateAlert', 'ColdChainBreachHigh', '2026-09-15 14:10:00.000000', 7.65, 94.50, 'Resolved', 1, '2026-09-15 14:11:15.000000', 'c0000004-0000-0000-0000-000000000001');

-- Resolución de Contingencia Asistencial
INSERT INTO `contingency_resolutions` (`id`, `incident_id`, `mitigation_action`, `was_thermal_integrity_restored`, `quality_signoff_notes`, `resolved_by_user_id`, `resolved_at`)
VALUES
    ('80000001-0000-0000-0000-000000000001', '70000001-0000-0000-0000-000000000001', 'Ajuste de potencia Peltier al 100% y recálculo de ruta dinámica anti-tráfico TomTom', 1, 'Temperatura estabilizada a 3.85 °C en 4 minutos. Viabilidad celular de órgano preservada según Directiva 152/DIGDOT.', 'c0000002-0000-0000-0000-000000000001', '2026-09-15 14:14:30.000000');

-- Manifiesto Digital de Auditoría Legal DIGEMID
INSERT INTO `digital_audit_manifests` (`id`, `transfer_id`, `manifest_code`, `cryptographic_hash_sha256`, `cloud_storage_pdf_url`, `is_sealed_and_immutable`, `average_temperature_celsius`, `min_temperature_celsius`, `max_temperature_celsius`, `total_excursion_seconds`, `minsa_compliance_verified`, `sealed_at`)
VALUES
    ('90000001-0000-0000-0000-000000000001', '10000001-0000-0000-0000-000000000001', 'MAN-2026-MINSA-0042', 'a8f5f167f44f4964e6c998dee827110c0175b95d8208eb6cfbd3c3b0d238c352', 'https://s3.us-east-1.amazonaws.com/medical-smartbox-audit/manifests/2026/09/MAN-2026-MINSA-0042.pdf', 1, 3.80, 2.40, 7.65, 180, 1, '2026-09-15 15:05:00.000000');

COMMIT;
