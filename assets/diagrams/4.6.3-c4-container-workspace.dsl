workspace "Medical SMARTBOX - Containers" "Diagrama de Contenedores de la Plataforma Medical SMARTBOX (C4 Model Nivel 2 - Modo Manual Drag & Drop)" {

    model {
        // ==========================================
        // ACTORES DEL DOMINIO
        // ==========================================
        transportStaff = person "Personal de Transporte" "Conductores y despachadores logísticos. [Seg. 1]" "Person"
        clinicalStaff = person "Personal Clínico y Farmacéutico" "Químicos farmacéuticos y médicos en quirófano. [Seg. 2]" "Person"
        auditorStaff = person "Auditor de Calidad" "Inspectores sanitarios (DIGEMID/DIGDOT) y auditores. [Seg. 2]" "Person"

        // ==========================================
        // SISTEMA CENTRAL Y SUS 4 CONTENEDORES
        // ==========================================
        smartboxSystem = softwareSystem "Medical SMARTBOX Platform" "Plataforma B2B SaaS de monitoreo térmico activo, pesaje y custodia digital inmutable." {
            
            landingPage = container "Static Content (Landing Page)" "Sitio web estático institucional de presentación y captación B2B." "HTML5, CSS3, JavaScript" "WebFolder,Container"
            
            spa = container "UI (Web Application SPA)" "Single-page application reactiva para cabina de ambulancia y centros asistenciales." "Vue.js 3, PrimeVue" "WebBrowser,Container"
            
            api = container "Backend (RESTful Web API)" "Servicios REST centralizados que ejecutan la lógica de negocio DDD de los 5 Bounded Contexts." "ASP.NET Core (.NET 10 LTS), C#" "BackendApi,Container"
            
            database = container "Database" "Almacena usuarios, telemetría sensorial, órdenes asistenciales y actas digitales selladas." "MySQL 8.0 Relational DBMS" "Database,Container"
        }

        // ==========================================
        // SISTEMAS EXTERNOS
        // ==========================================
        iotHardware = softwareSystem "Smart Container IoT Hardware" "Dispositivo físico embebido ESP32 (sensores DS18B20, celda HX711, cerrojo)." "ExternalHardware"
        trafficApi = softwareSystem "Traffic & Maps Gateway" "TomTom Traffic API / Mapbox. Cálculo dinámico de congestión y ETA en Lima." "ExternalApi"
        notificationService = softwareSystem "Notification Gateway" "Twilio SMS & Firebase FCM. Alertas críticas inmediatas (<10s)." "ExternalService"
        cloudStorage = softwareSystem "Cloud Document Storage" "Amazon Web Services S3. Custodia inmutable de actas digitales selladas con hash SHA-256." "ExternalService"
        paymentGateway = softwareSystem "B2B Payment Gateway" "Culqi / Stripe API. Cobros recurrentes de suscripciones SaaS B2B." "ExternalService"

        // ==========================================
        // RELACIONES DE USUARIOS A FRONTENDS
        // ==========================================
        transportStaff -> landingPage "Visita sitio web" "HTTPS"
        clinicalStaff -> landingPage "Consulta catálogo" "HTTPS"
        auditorStaff -> landingPage "Visita portal" "HTTPS"
        
        landingPage -> spa "Redirige a web app" "HTTPS"
        
        transportStaff -> spa "Monitorea traslados" "HTTPS"
        clinicalStaff -> spa "Crea órdenes y valida OTP" "HTTPS"
        auditorStaff -> spa "Descarga actas digitales" "HTTPS"

        // ==========================================
        // COMUNICACIÓN FRONTEND -> BACKEND -> BD
        // ==========================================
        spa -> api "Peticiones REST" "JSON / HTTPS"
        api -> database "Lee y escribe datos" "TCP / SQL (Port 3306)"

        // ==========================================
        // INTEGRACIONES DEL BACKEND CON EXTERNOS
        // ==========================================
        api -> iotHardware "Telemetría y cerrojo" "JSON / HTTPS"
        api -> trafficApi "Consulta rutas y ETA" "HTTPS / REST"
        api -> notificationService "Despacha alertas críticas" "HTTPS / REST"
        api -> cloudStorage "Archiva actas PDF selladas" "HTTPS / S3 API"
        api -> paymentGateway "Cobro de suscripciones" "HTTPS / REST"
    }

    views {
        container smartboxSystem "Containers" "Diagrama de Contenedores de Medical SMARTBOX (C4 Nivel 2)" {
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
            element "Container" {
                shape RoundedBox
                background #ffffff
                color #0066cc
                stroke #0066cc
                strokeWidth 6
                fontSize 28
            }
            element "WebFolder" {
                shape Folder
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
                fontSize 28
            }
            element "BackendApi" {
                shape RoundedBox
                background #ffffff
                color #0066cc
                stroke #0066cc
                strokeWidth 6
                fontSize 28
            }
            element "Database" {
                shape Cylinder
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
