workspace "Medical SMARTBOX - Components" "Diagrama de Componentes del Backend Web API (C4 Model Nivel 3 - Modo Manual Drag & Drop)" {

    model {
        smartboxSystem = softwareSystem "Medical SMARTBOX Platform" {
            spa = container "UI (Web Application SPA)" "Frontend web cliente en Vue.js 3 / PrimeVue." "WebBrowser,Container"
            database = container "Database" "Persistencia relacional MySQL 8.0." "MySQL 8.0" "Database,Container"

            api = container "Backend (RESTful Web API)" "Servicios REST centralizados en ASP.NET Core." "ASP.NET Core (.NET 10 LTS), C#" "Container" {
                
                iamComp = component "IAM & Subscriptions Module" "Autenticación JWT, roles asistenciales (RBAC), sedes hospitalarias y suscripciones SaaS B2B." "C# / ASP.NET Core" "Component"
                
                telemetryComp = component "Smart Container & Telemetry Module" "Ingesta de telemetría térmica (+2°C a +8°C), pesaje con celda HX711 y control de cerrojo." "C# / ASP.NET Core" "Component"
                
                transportComp = component "Medical Transport Module" "Órdenes de traslado asistencial, vinculación de ambulancias y cálculo de rutas dinámicas." "C# / ASP.NET Core" "Component"
                
                alertingComp = component "Critical Alerting Module" "Evaluación de umbrales clínicos y despacho reactivo de alarmas acústicas y push." "C# / ASP.NET Core" "Component"
                
                custodyComp = component "Chain of Custody Module" "Validación de token OTP de apertura y actas digitales inmutables con hash SHA-256." "C# / ASP.NET Core" "Component"
                
                dataAccessComp = component "Data Access & Persistence (EF Core)" "Encapsula AppDbContext, mapeos relacionales Fluent API y transacciones ACID." "Entity Framework Core 10.0" "Component"
            }
        }

        // Sistemas externos
        trafficApi = softwareSystem "TomTom Traffic API" "Servicio externo de tráfico" "ExternalApi"
        notificationService = softwareSystem "Notification Gateway" "Twilio SMS & Firebase FCM" "ExternalService"
        cloudStorage = softwareSystem "Cloud Document Storage" "Amazon Web Services S3" "ExternalService"
        paymentGateway = softwareSystem "B2B Payment Gateway" "Pasarela de pagos Culqi / Stripe API" "ExternalService"
        iotHardware = softwareSystem "Smart Container IoT Hardware" "Microcontrolador ESP32 con sensores" "ExternalHardware"

        // SPA consume los módulos de la API vía REST
        spa -> iamComp "Autenticación y perfil" "JSON / HTTPS"
        spa -> telemetryComp "Telemetría en vivo" "JSON / HTTPS"
        spa -> transportComp "Órdenes de traslado" "JSON / HTTPS"
        spa -> alertingComp "Gestión de alarmas" "JSON / HTTPS"
        spa -> custodyComp "Validación OTP y actas" "JSON / HTTPS"

        // Módulos de dominio interactúan con la capa de persistencia EF Core
        iamComp -> dataAccessComp "Persistencia de cuentas" "C# / DI"
        telemetryComp -> dataAccessComp "Persistencia de telemetría" "C# / DI"
        transportComp -> dataAccessComp "Persistencia de órdenes" "C# / DI"
        alertingComp -> dataAccessComp "Persistencia de incidentes" "C# / DI"
        custodyComp -> dataAccessComp "Persistencia de actas" "C# / DI"

        dataAccessComp -> database "Consultas y transacciones ACID" "TCP / SQL (Port 3306)"

        // Integraciones externas desde componentes
        iamComp -> paymentGateway "Cobro de suscripciones" "HTTPS / REST"
        telemetryComp -> iotHardware "Telemetría y cerrojo" "HTTPS / JSON"
        transportComp -> trafficApi "Cálculo de rutas y ETA" "HTTPS / REST"
        alertingComp -> notificationService "Despacho de alertas" "HTTPS / REST"
        custodyComp -> cloudStorage "Custodia de actas PDF" "HTTPS / S3 API"
    }

    views {
        component api "ComponentsAPI" "Diagrama de Componentes de la RESTful Web API (C4 Nivel 3)" {
            include *
        }

        styles {
            element "Element" {
                background #ffffff
                shape RoundedBox
            }
            element "Component" {
                shape Component
                background #ffffff
                color #0066cc
                stroke #0066cc
                strokeWidth 5
                fontSize 26
            }
            element "Container" {
                shape RoundedBox
                background #ffffff
                color #0066cc
                stroke #0066cc
                strokeWidth 6
                fontSize 28
            }
            element "WebBrowser" {
                shape WebBrowser
                background #ffffff
                color #0066cc
                stroke #0066cc
                strokeWidth 6
            }
            element "Database" {
                shape Cylinder
                background #ffffff
                color #0066cc
                stroke #0066cc
                strokeWidth 6
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
            element "Boundary" {
                stroke #0066cc
                color #0066cc
                strokeWidth 5
                fontSize 26
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
