# Conclusiones y Recomendaciones

## Conclusiones del Avance 1 (Hito AV1)

1. **Rigor Arquitectónico Orientado al Dominio (DDD):**  
   Mediante la aplicación sistemática de *EventStorming* (Big Picture y Design-Level) se logró delimitar con absoluta claridad seis *Bounded Contexts* que estructuran el ecosistema de **Medical SMARTBOX**. La descomposición a través del Modelo C4 (Contexto, Contenedores y Componentes) demostró que la separación entre el núcleo transaccional clínico, el servicio de ingesta IoT asíncrono y la interfaz reactiva de usuario optimiza la escalabilidad y garantiza la consistencia eventual y ACID en los puntos críticos de custodia.

2. **Alineación Normativa con la Realidad Asistencial de Lima:**  
   El proceso de Needfinding y formulación de requisitos empíricos permitió anclar la solución a las directivas sanitarias peruanas (**R.M. N° 833-2015/MINSA** para cadena de frío entre +2.0 °C y +8.0 °C y **Directiva Sanitaria N° 152/MINSA** para tiempos de isquemia fría en trasplantes). La plataforma responde directamente a los desafíos de congestión vehicular limeña (índice TomTom: 34 min/10 km) mediante alertas de preaviso hospitalario (10 min) y protección frente a desconexiones eléctricas vehiculares de 12V.

3. **Gobernanza de Software y Cumplimiento del Sprint 1:**  
   Se estableció una disciplina de gestión de configuración de software (SCM) rigurosa, basada en GitFlow, versionado semántico (SemVer 2.0.0) y Conventional Commits. Este marco metodológico permitió implementar y desplegar exitosamente en la nube la primera versión del Landing Page institucional en HTML5, CSS3 y JavaScript bajo directrices *mobile-first*, cumpliendo al 100% con los compromisos técnicos exigidos para el hito AV1.

## Recomendaciones para Siguientes Hitos

1. **Sprint 2 (Hito TB1 - Frontend Web Applications):**  
   Iniciar la construcción de la aplicación web administrativa y operativa utilizando el framework reactivo **Vue 3** complementado con la biblioteca de componentes **PrimeVue** (Material Design). Priorizar los flujos de inicio de sesión seguro, verificación en dos pasos (2FA) y el tablero Kanban de despacho vehicular.

2. **Sprint 3 (Hito AV2 - Web Services & Telemetría IoT):**  
   Codificar los servicios RESTful en **ASP.NET Core 10.0 (.NET 10 LTS)** con C# y Entity Framework Core, conectando la persistencia relacional en MySQL. Implementar el worker en segundo plano para el procesamiento asíncrono de mensajes MQTT provenientes de los contenedores inteligentes y habilitar la documentación interactiva con Swagger UI.

3. **Sprint 4 (Hito TB2 - Release Review):**  
   Integrar la comunicación bidireccional en tiempo real con WebSockets (SignalR) para la actualización en vivo de telemetría y alarmas en cabina de ambulancia, ejecutando pruebas exhaustivas de usabilidad según las 10 heurísticas de Nielsen con personal de salud antes de la liberación final.
