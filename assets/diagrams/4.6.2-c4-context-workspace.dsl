workspace "Medical SMARTBOX - System Context" "Diagrama de Contexto del Sistema Medical SMARTBOX (C4 Model Nivel 1 - Modo Manual Drag & Drop)" {

    model {
        // ==========================================
        // ACTORES DEL DOMINIO (ARRIBA)
        // ==========================================
        transportStaff = person "Personal de Transporte Asistencial" "Conductores de ambulancia y despachadores logísticos que gestionan el traslado, verifican 12V y responden a alertas. [Segmento 1]" "Person"
        clinicalStaff = person "Personal Clínico y Farmacéutico" "Químicos farmacéuticos y médicos en rampa/quirófano que acondicionan la carga, monitorean temperaturas y validan con OTP. [Segmento 2]" "Person"
        auditorStaff = person "Auditor de Calidad y Regulador" "Inspectores sanitarios (DIGEMID/DIGDOT) y auditores hospitalarios que fiscalizan actas y curvas térmicas. [Segmento 2]" "Person"

        // ==========================================
        // SISTEMA CENTRAL (CENTRO)
        // ==========================================
        smartboxSystem = softwareSystem "Medical SMARTBOX Platform" "Plataforma B2B SaaS de monitoreo térmico continuo (+2.0°C a +8.0°C), pesaje con celda HX711, custodia digital inmutable y trazabilidad asistencial." "MainSystem"

        // ==========================================
        // SISTEMAS EXTERNOS Y HARDWARE
        // ==========================================
        iotHardware = softwareSystem "Smart Container IoT Hardware" "Dispositivo físico embebido ESP32 (sensores DS18B20, celda HX711, cerrojo solenoide)." "ExternalHardware"
        trafficApi = softwareSystem "Traffic & Maps Gateway" "TomTom Traffic API / Mapbox. Cálculo dinámico de congestión y actualización de ETA en Lima." "ExternalApi"
        notificationService = softwareSystem "Notification Gateway" "Twilio SMS & Firebase FCM. Despacha alertas críticas inmediatas (<10s)." "ExternalService"
        cloudStorage = softwareSystem "Cloud Document Storage" "AWS S3 / Azure Blob Storage. Custodia inmutable de actas digitales selladas con SHA-256." "ExternalService"
        paymentGateway = softwareSystem "B2B Payment Gateway" "Pasarela de pagos en línea (Culqi / Stripe API) para suscripciones SaaS según cuotas de flota." "ExternalService"

        // ==========================================
        // RELACIONES (RELATIONSHIPS)
        // ==========================================
        transportStaff -> smartboxSystem "Supervisa rutas y alertas" "HTTPS"
        clinicalStaff -> smartboxSystem "Crea órdenes y valida entrega OTP" "HTTPS"
        auditorStaff -> smartboxSystem "Descarga actas digitales en PDF" "HTTPS"

        smartboxSystem -> iotHardware "Sincroniza telemetría y cerrojo" "HTTPS / JSON"
        smartboxSystem -> trafficApi "Consulta congestión vial y ETA" "HTTPS / REST"
        smartboxSystem -> notificationService "Despacha alertas por SMS y Push" "HTTPS / REST"
        smartboxSystem -> cloudStorage "Archiva manifiestos sellados SHA-256" "HTTPS / S3 API"
        smartboxSystem -> paymentGateway "Procesa cobros de suscripciones B2B" "HTTPS / REST"
    }

    views {
        systemContext smartboxSystem "SystemContext" "Diagrama de Contexto del Sistema Medical SMARTBOX (C4 Nivel 1)" {
            include *
        }

        styles {
            element "Element" {
                background #ffffff
                shape RoundedBox
            }
            element "Person" {
                shape Person
                background #ffffff
                color #00823b
                stroke #00823b
                strokeWidth 6
                fontSize 28
            }
            element "MainSystem" {
                shape RoundedBox
                background #ffffff
                color #0066cc
                stroke #0066cc
                strokeWidth 6
                fontSize 28
            }
            element "ExternalHardware" {
                shape RoundedBox
                background #ffffff
                color #e65100
                stroke #e65100
                strokeWidth 6
                fontSize 24
            }
            element "ExternalApi" {
                shape RoundedBox
                background #ffffff
                color #c62828
                stroke #c62828
                strokeWidth 6
                fontSize 24
            }
            element "ExternalService" {
                shape RoundedBox
                background #ffffff
                color #c62828
                stroke #c62828
                strokeWidth 6
                fontSize 24
            }
            relationship "Relationship" {
                dashed true
                thickness 4
                color #222222
                fontSize 22
            }
        }
    }
}
