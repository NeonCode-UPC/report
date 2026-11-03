# Conclusiones y Recomendaciones

## Conclusiones de la Entrega TB1 (Sprints 1 y 2)

1. **Rigor Arquitectónico Orientado al Dominio (DDD) y Topología Canónica C4:**  
   Mediante la aplicación sistemática de *EventStorming* (Big Picture y Design-Level) se consolidaron cinco *Bounded Contexts* autónomos (`Identity, Access & Subscriptions`, `Smart Container & Telemetry Monitoring`, `Medical Transport Planning & Dispatching`, `Critical Alerting & Incident Response` y `Chain of Custody & Traceability`) que estructuran el ecosistema **Medical SMARTBOX**. La descomposición a través del Modelo C4 en sus cuatro contenedores canónicos (*Landing Page*, *Single-Page Application en Vue 3*, *Backend RESTful Web API en ASP.NET Core 10.0* y *Database en MySQL 8.0*) garantiza el bajo acoplamiento, la trazabilidad de extremo a extremo y la consistencia transaccional ACID en los puntos críticos de custodia.

2. **Alineación Normativa con la Realidad Asistencial de Lima Metropolitana:**  
   El proceso de *Needfinding* con entrevistas reales y el modelado de nuestros *User Personas* (**Aldair Lazaro**, personal de transporte asistencial en ruta; y **Gianfranco Timoteo**, supervisor hospitalario y coordinador de cadena de frío) permitieron anclar la solución a las directivas sanitarias peruanas (**R.M. N° 833-2015/MINSA** de DIGEMID para cadena de frío entre +2.0 °C y +8.0 °C y **Directiva Sanitaria N° 152/MINSA** de DIGDOT para tiempos de isquemia fría). La plataforma responde directamente a la congestión vehicular de Lima (índice TomTom: 33 min 10 s por cada 10 km) mediante alertas de preaviso hospitalario, monitoreo de peso neto con celda HX711 y respaldo frente a desconexiones vehiculares de 12V.

3. **Implementación y Despliegue Exitoso del Landing Page y la Frontend Web Application (Sprints 1 y 2):**  
   Bajo una disciplina de gestión de configuración de software (SCM) basada en GitFlow, versionado semántico (SemVer 2.0.0) y Conventional Commits, el equipo completó satisfactoriamente los **16 Story Points del Sprint 1** (despliegue del Landing Page institucional responsive) y los **29 Story Points del Sprint 2** (construcción y despliegue en producción de la primera versión integrada de la Frontend Web Application en **Vue 3**, **PrimeVue** y **Pinia** estructurada por Bounded Contexts), cumpliendo integralmente los objetivos del hito **TB1**.

## Recomendaciones para Siguientes Hitos

1. **Sprint 3 (Hito AV2 - Backend RESTful Web Services & Persistencia Relacional):**  
   Implementar y desplegar los servicios RESTful en **ASP.NET Core 10.0 (.NET 10 LTS)** con C# y **Entity Framework Core 10.0**, ejecutando las migraciones Code-First sobre **MySQL 8.0 (InnoDB)**. Priorizar los endpoints de ingesta periódica de telemetría vía HTTPS/REST desde el nodo ESP32, la evaluación de umbrales térmicos críticos (`US13`, `US14`, `US15`) y la documentación interactiva de contratos OpenAPI con Swagger UI.

2. **Sprint 4 (Hito TB2 - Integración Full-Stack, Auditoría SHA-256 y Pruebas de Aceptación):**  
   Integrar de extremo a extremo la aplicación frontend en Vue 3 con el Backend RESTful Web API desplegado en la nube, habilitando el cierre criptográfico de cadena de custodia mediante token OTP y la exportación de manifiestos de auditoría inmutables sellados con hash SHA-256 (`US16`, `US17`, `US18`), así como la validación integral de los escenarios Gherkin con usuarios representativos de ambos segmentos objetivo.
