# Servidor Web Automatizado y Monitoreado en AWS EC2

Este proyecto demuestra el despliegue automático, seguro y monitoreado de una infraestructura web básica en Amazon Web Services (AWS), aplicando los conceptos esenciales del nivel AWS Certified Cloud Practitioner.

## 📌 Arquitectura de la Solución

GitHub renderiza el siguiente diagrama automáticamente para ilustrar el flujo del tráfico y los componentes de observabilidad:

```mermaid
graph TD
    User([👤 Cliente / Internet]) -->|HTTP: Puerto 80| SG{🛡️ Security Group}
    Admin([💻 Administrador]) -->|SSH: Puerto 22<br>Solo Mi IP| SG
    
    subgraph AWS Cloud [☁️ Nube de AWS]
        subgraph VPC [🌐 Virtual Private Cloud]
            SG -->|Filtra Tráfico| EC2[🖥️ Instancia EC2<br>Amazon Linux 2023]
            
            subgraph Servidor [Aprovisionamiento]
                EC2 -->|Ejecuta| UD[📄 Script User Data]
                UD -->|Instala y Activa| Apache[🌐 Servidor Web Apache]
            end
        end
        
        subgraph Observabilidad [📊 Monitoreo y Alertas]
            EC2 -.->|Métrica: CPUUtilization| CW[📈 Amazon CloudWatch]
            CW -.->|Si CPU >= 80%| SNS[🔔 Amazon SNS]
            SNS -.->|Envía Alerta| Email([📧 Correo Electrónico])
        end
    end

    style AWS Cloud fill:#f9f9f9,stroke:#ff9900,stroke-width:2px
    style VPC fill:#fff,stroke:#1473e6,stroke-width:1px
    style EC2 fill:#ff9900,stroke:#fff,stroke-width:1px
    style SG fill:#cc0000,stroke:#fff,stroke-width:1px
