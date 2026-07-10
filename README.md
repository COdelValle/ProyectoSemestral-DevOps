# Proyecto Semestral DevOps - Sistema de Ventas y Despachos

Sistema de gestión de ventas y despachos con arquitectura de microservicios, contenedores Docker, despliegue local con Docker Compose y despliegue en AWS con Terraform y Kubernetes.

## Índice
- [Resumen ejecutivo](#resumen-ejecutivo)
- [Diagrama de arquitectura](#diagrama-de-arquitectura)
- [Tecnologías principales](#tecnologías-principales)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Levantamiento local](#levantamiento-local)
- [Levantamiento en AWS](#levantamiento-en-aws)
- [CI/CD](#cicd)
- [Seguridad, secretos y variables de entorno](#seguridad-secretos-y-variables-de-entorno)
- [Observabilidad](#observabilidad)
- [Endpoints y módulos](#endpoints-y-módulos)
- [Detalles técnicos del proyecto](#detalles-técnicos-del-proyecto)

## Resumen ejecutivo
El proyecto implementa dos microservicios Spring Boot, un frontend React y una capa de infraestructura como código para AWS. El flujo principal es usuario -> frontend -> backends -> base de datos MySQL.

En local la solución se levanta con Docker Compose. En AWS el despliegue se orienta a EKS con Terraform, ECR como registro de imágenes, Kubernetes para orquestación y CloudWatch como base de observabilidad.

## Diagrama de arquitectura

![Diagrama de arquitectura](docs/Diagrama%20topología%20AWS%20oscuro.png)

## Tecnologías principales
### Backend
- Spring Boot 3.4.4 para exponer APIs REST y estructurar la lógica de negocio.
- Java 17 como versión base del runtime.
- Maven para compilación, empaquetado y pruebas.
- JPA/Hibernate para persistencia relacional.
- MySQL 8 como base de datos principal.
- Swagger/OpenAPI para documentación de servicios.

### Frontend
- React 18.2.0 para la interfaz de usuario.
- Vite 5.2.0 para desarrollo y build rápido.
- Tailwind CSS 3.4.3 para estilos utilitarios.
- React Router DOM para navegación.
- Axios para consumo de APIs.
- React Hook Form para formularios.
- SweetAlert2 para retroalimentación visual.

### Infraestructura y operación
- Docker para contenerización.
- Docker Compose para entorno local.
- Terraform para infraestructura como código en AWS.
- Kubernetes en EKS para despliegue en clúster.
- ECR para almacenamiento privado de imágenes.
- CloudWatch para logs base y monitoreo operativo.

## Estructura del proyecto
### Backend de ventas
Microservicio REST para ventas, con CRUD, persistencia JPA y pruebas unitarias.
- Ubicación: [back-Ventas_SpringBoot/Springboot-API-REST](back-Ventas_SpringBoot/Springboot-API-REST)
- Puerto: 8080
- Swagger: `/swagger-ui.html`

### Backend de despachos
Microservicio REST para despachos, con CORS, documentación OpenAPI y pruebas.
- Ubicación: [back-Despachos_SpringBoot/Springboot-API-REST-DESPACHO](back-Despachos_SpringBoot/Springboot-API-REST-DESPACHO)
- Puerto: 8081
- Swagger: `/swagger-ui.html`

### Frontend de despacho
Aplicación React para consultar ventas, crear despachos y cerrar despachos.
- Ubicación: [front_despacho](front_despacho)
- En local se sirve en 3000 mediante Docker Compose.
- En contenedor se publica por Nginx en el puerto 80.

### Infraestructura
La carpeta `Infrastructure/` concentra Terraform y manifiestos Kubernetes.
- Terraform: red, clúster, ECR, SG, EBS y CloudWatch.
- Kubernetes: secreto, base de datos, deployments, services y HPA.

## Levantamiento local
### Video de referencia
[![Ver Video](https://img.youtube.com/vi/BlAY-dXupxo/0.jpg)](https://www.youtube.com/watch?v=BlAY-dXupxo)

### Qué levanta localmente
- MySQL 8 como contenedor.
- Backend de ventas en 8080.
- Backend de despachos en 8081.
- Frontend React servido por Nginx en 3000.

### Requisitos
- Docker Desktop instalado y activo.
- Git instalado.
- Archivo `.env` en la raíz del proyecto.

### Variables locales
```bash
MYSQL_ROOT_PASSWORD=password123
MYSQL_USERNAME=root
MYSQL_DATABASE_VENTAS=ventas_db
MYSQL_DATABASE_DESPACHOS=despachos_db
```

### Pasos de levantamiento local
1. Clonar el repositorio y ubicarse en la raíz del proyecto.
2. Verificar que el archivo `.env` exista con las variables anteriores.
3. Ejecutar `docker-compose up -d`.
4. Esperar a que MySQL termine su healthcheck.
5. Validar el acceso a los servicios en `http://localhost:3000`, `http://localhost:8080` y `http://localhost:8081`.
6. Revisar logs con `docker-compose logs -f`.
7. Detener todo con `docker-compose down`.

### Comandos útiles local
```bash
docker-compose up -d
docker-compose logs -f
docker-compose ps
docker-compose down
docker-compose down -v
```

## Levantamiento en AWS
### Video de referencia
[![Ver Video](https://img.youtube.com/vi/0nfRbB7lcHk/0.jpg)](https://www.youtube.com/watch?v=0nfRbB7lcHk)

### Qué se despliega en AWS
- VPC con subnets públicas y route table pública.
- EKS con node group administrado.
- ECR para almacenar imágenes.
- Deployments, Services, Secret, PVC y HPA en Kubernetes.
- MySQL como Deployment dentro del clúster, respaldado por EBS vía StorageClass.

### Requisitos
- AWS CLI configurado.
- Terraform instalado.
- Credenciales válidas para laboratorio AWS.

### Variables y parámetros relevantes
- `aws_region`: región AWS.
- `project_name`: prefijo de recursos.
- `db_password`: contraseña base del despliegue.
- `key_pair_name`: llave para acceso, si aplica.

### Pasos de levantamiento en AWS
1. Entrar al directorio `Infrastructure/terraform`.
2. Ejecutar `terraform init`.
3. Revisar el plan con `terraform plan`.
4. Aplicar con `terraform apply` usando las variables necesarias.
5. Obtener salidas con `terraform output`.
6. Actualizar los GitHub Secrets.
7. Re-run job Despliegue Continuo en Github Actions.
8. Verificar funcionamiento accediendo al Cluster en AWS, entrar a servicios, y entrar a la pagina a través del load balancer.

### Secuencia técnica sugerida
```bash
cd Infrastructure/terraform
terraform init
terraform plan
terraform apply
terraform output
```

## CI/CD
### Integración continua
El workflow de CI ejecuta pruebas del backend y del frontend al hacer push o pull request. Esto permite detectar fallos temprano y mantener una validación mínima antes del despliegue.

Archivo: [`.github/workflows/ci.yml`](.github/workflows/ci.yml)

### Despliegue continuo
El workflow de CD se activa en la rama `deploy`, construye imágenes Docker, las publica en ECR y aplica manifiestos a EKS. Después actualiza las imágenes de cada Deployment y valida el rollout.

Archivo: [`.github/workflows/cd.yml`](.github/workflows/cd.yml)

### Justificación de uso
- CI reduce errores de integración al compilar y testear antes de fusionar cambios.
- CD reduce trabajo manual y acelera la publicación de versiones.
- ECR funciona como registro privado y versionado de imágenes.

## Seguridad, secretos y variables de entorno
### Seguridad básica implementada
- Secretos de base de datos almacenados en Kubernetes Secret.
- Credenciales de AWS inyectadas por GitHub Secrets en el pipeline.
- Imágenes alojadas en repositorios privados de ECR.
- Reglas de red controladas por Security Groups y Services de Kubernetes.

### Observación importante
La configuración de seguridad es funcional para un entorno académico, pero no está endurecida como un entorno productivo. Por ejemplo, el Security Group tiene aperturas amplias y el Secret de Kubernetes está codificado en base64, no cifrado por sí mismo.

### Variables de entorno en local
- `MYSQL_ROOT_PASSWORD`
- `MYSQL_USERNAME`
- `MYSQL_DATABASE_VENTAS`
- `MYSQL_DATABASE_DESPACHOS`

### Variables de entorno en runtime de backend
- `DB_ENDPOINT`
- `DB_PORT`
- `DB_NAME`
- `DB_USERNAME`
- `DB_PASSWORD`

### Justificación de uso
- Las variables desacoplan configuración y código.
- Permiten usar la misma imagen en local, CI y AWS.
- Facilitan cambiar el entorno sin recompilar la aplicación.

## Observabilidad
### Estado actual
- Swagger/OpenAPI expone documentación funcional de ambos backends.
- CloudWatch está declarado como base de logs en Terraform.
- Kubernetes HPA escala según uso de CPU.
- Docker Compose permite revisar logs locales por servicio.

### Ruta de consulta de logs
- Local: `docker-compose logs -f`
- AWS: CloudWatch Log Group definido en Terraform.

## Endpoints y módulos
### Backend de ventas
- `GET /api/v1/ventas`
- `GET /api/v1/ventas/{id}`
- `POST /api/v1/ventas`
- `PUT /api/v1/ventas/{id}`
- `DELETE /api/v1/ventas/{id}`

### Backend de despachos
- `GET /api/v1/despachos`
- `GET /api/v1/despachos/{id}`
- `POST /api/v1/despachos`
- `PUT /api/v1/despachos/{id}`
- `DELETE /api/v1/despachos/{id}`

### Frontend
- Ruta principal: `/`
- El frontend contiene la vista de administración y componentes de formulario, tabla y modal.

## Detalles técnicos del proyecto
### Terraform usado en este repositorio
- `vpc.tf`: define la VPC principal.
- `subnets.tf`: crea dos subnets públicas.
- `igw.tf`: crea el Internet Gateway.
- `routeTable.tf`: define y asocia la ruta pública.
- `sg.tf`: define el Security Group principal.
- `eks.tf`: crea el clúster EKS y el node group.
- `ecr.tf`: crea los repositorios de imágenes.
- `ebs.tf`: define la StorageClass `ebs-gp3`.
- `cloudwatch.tf`: crea el log group.
- `iam.tf`: referencia el rol `LabRole`.

### Kubernetes usado en este repositorio
- `secret.yml`: secreto base para credenciales.
- `infra-db.yml`: PVC, MySQL y service interno.
- `apps-deployments.yml`: frontend, ventas y despachos.
- `apps-services.yml`: service LoadBalancer para frontend y ClusterIP para backends.
- `hpas.yml`: escalado horizontal por CPU.

### Patrones de implementación visibles
- Arquitectura por microservicios.
- Separación clara entre frontend, backends y base de datos.
- Contenerización multistage para reducir la imagen final.
- Exposición de APIs mediante rutas REST versionadas.

## Testing
### Backend de ventas
```bash
cd back-Ventas_SpringBoot/Springboot-API-REST
mvn test
```

### Backend de despachos
```bash
cd back-Despachos_SpringBoot/Springboot-API-REST-DESPACHO
mvn test
```

### Frontend
```bash
cd front_despacho
npm test
```

## Notas finales
- El archivo `.env` está versionado en este proyecto académico, pero en un entorno real debería excluirse del repositorio.

**Última actualización**: Julio 2026
