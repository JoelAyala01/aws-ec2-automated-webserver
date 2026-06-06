# Servidor Web Automatizado y Monitoreado en AWS EC2

Este proyecto demuestra el despliegue automático, seguro y monitoreado de una infraestructura web básica en Amazon Web Services (AWS), aplicando los conceptos esenciales del nivel AWS Certified Cloud Practitioner.

# Servicios de AWS Utilizados

**Amazon EC2:** Instancia virtual de cómputo (t2.micro bajo el marco de la capa gratuita) configurada con el sistema operativo corporativo Amazon Linux 2023.
**VPC Security Groups:** Actúa como firewall perimetral de la instancia, implementando el principio de menor privilegio técnico.
**Amazon CloudWatch:** Sistema centralizado de métricas encargado de supervisar el rendimiento del hardware virtual.
**Amazon SNS (Simple Notification Service):** Infraestructura de mensajería configurada bajo el modelo Pub/Sub para notificaciones de emergencia operativas.

## 🚀 Detalles de la Implementación
1. ## Políticas del Firewall (Security Group)

El tráfico entrante fue estrictamente limitado en el recurso web-server-sg:
- **Acceso Público:** Puerto 80 (HTTP) abierto globalmente (0.0.0.0/0) para garantizar la disponibilidad del servicio web.
- **Acceso de Gestión:** Puerto 22 (SSH) restringido explícitamente a una única dirección IP de administración, mitigando vectores de ataque externos.

2. ## Aprovisionamiento Automático (User Data)

Para evitar errores de configuración manual, el despliegue del servidor se automatizó inyectando lógica Bash directo en el arranque del hardware. El script completo se encuentra documentado en la raíz de este repositorio como install_server.sh.

3. ## Estrategia de Monitoreo Proactivo

Se estableció una condición de umbral crítico en CloudWatch: si el consumo de CPUUtilization supera o es igual al 80% en una ventana temporal continua de 5 minutos, se dispara una acción automática dirigida hacia un tópico de Amazon SNS que notifica vía correo electrónico de forma inmediata.

## 📊 Evidencias de Funcionamiento

- **Página de Inicio Web:** *(Sube y enlaza aquí una captura de tu navegador mostrando el mensaje "¡Hola Mundo!" junto a la IP pública).*
- **Estatus del Monitor:** *(Sube y enlaza aquí una captura de la consola de CloudWatch mostrando la alarma creada en estado OK).*

🔹 Competencias Validadas: Inicialización de servicios core de AWS, administración básica de sistemas Linux, automatización de software mediante User Data y configuración de eventos basados en métricas

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

