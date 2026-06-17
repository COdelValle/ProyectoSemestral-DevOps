# Proyecto Semestral DevOps - Sistema de Ventas y Despachos

Sistema integral de gestión de ventas y despachos con arquitectura de microservicios, completamente containerizado y desplegable en AWS.

---

## 📋 Tabla de Contenidos

- [Con qué funciona (Stack Tecnológico)](#️-stack-tecnológico)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Cómo se levanta](#-cómo-se-levanta)
- [Infraestructura Creada](#️-infraestructura-creada)
- [Configuración](#️-configuración)
- [Endpoints Disponibles](#-endpoints-disponibles)
---

## 🏗️ Stack Tecnológico

### Backend
- **Spring Boot 3.4.4** - Framework de aplicaciones Java
- **Java 17** - Versión requerida
- **Maven** - Gestor de dependencias y compilación
- **JPA/Hibernate** - ORM para persistencia de datos
- **MySQL 8** - Base de datos relacional
- **Docker** - Contenedorización

### Frontend
- **React 18.2.0** - Librería de UI
- **Vite 5.2.0** - Constructor y servidor de desarrollo
- **Tailwind CSS 3.4.3** - Framework CSS utility-first
- **React Router DOM 6.24.1** - Enrutamiento
- **Axios 1.6.8** - Cliente HTTP
- **React Hook Form 7.52.1** - Gestión de formularios
- **SweetAlert2 11.11.0** - Alertas personalizadas

### Infraestructura
- **Docker Compose** - Orquestación local de contenedores
- **Terraform** - Infraestructura como código (IaC) para AWS
- **AWS Services**:
  - VPC - Red virtual privada
  - EC2 - Instancias de máquinas virtuales
  - ECS Fargate - Servicio de contenedores serverless
  - ECR - Registro de contenedores privado
  - CloudWatch - Monitoreo y logs

---

## 📁 Estructura del Proyecto

```
ProyectoSemestral-DevOps/
│
├── back-Ventas_SpringBoot/
│   └── Springboot-API-REST/                    # Microservicio de Ventas
│       ├── src/
│       │   ├── main/
│       │   │   ├── java/com/citt/
│       │   │   │   ├── SpringbootApiRestApplication.java
│       │   │   │   ├── controller/
│       │   │   │   │   └── VentaController.java
│       │   │   │   ├── persistence/
│       │   │   │   │   ├── entity/
│       │   │   │   │   ├── repository/
│       │   │   │   │   └── services/
│       │   │   │   ├── exceptions/
│       │   │   │   │   ├── VentaNotFoundException.java
│       │   │   │   │   └── RestResponseEntityExceptionHandler.java
│       │   │   │   ├── config/
│       │   │   │   │   └── OpenApiConfing.java
│       │   │   │   └── dto/
│       │   │   └── resources/
│       │   │       ├── application.properties
│       │   │       └── application-test.properties
│       │   └── test/java/com/citt/
│       │       ├── SpringbootApiRestApplicationTests.java
│       │       ├── persistence/services/
│       │       │   └── VentaServiceTest.java
│       │       └── controller/
│       ├── pom.xml
│       ├── Dockerfile
│       ├── entrypoint.sh
│       ├── mvnw
│       └── mvnw.cmd
│
├── back-Despachos_SpringBoot/
│   └── Springboot-API-REST-DESPACHO/           # Microservicio de Despachos
│       ├── src/
│       │   ├── main/
│       │   │   ├── java/com/citt/
│       │   │   │   ├── SpringbootApiRestDespachoApplication.java
│       │   │   │   ├── controller/
│       │   │   │   │   └── DespachoController.java
│       │   │   │   ├── persistence/
│       │   │   │   │   ├── entity/
│       │   │   │   │   ├── repository/
│       │   │   │   │   └── services/
│       │   │   │   ├── exceptions/
│       │   │   │   │   ├── DespachoNotFoundException.java
│       │   │   │   │   └── RestResponseEntityExceptionHandler.java
│       │   │   │   ├── config/
│       │   │   │   │   ├── CorsConfig.java
│       │   │   │   │   └── OpenApiConfig.java
│       │   │   │   └── dto/
│       │   │   └── resources/
│       │   │       └── application.properties
│       │   └── test/java/com/citt/
│       │       ├── SpringbootApiRestDespachoApplicationTests.java
│       │       └── controller/
│       │           └── DespachoControllerTest.java
│       ├── pom.xml
│       ├── Dockerfile
│       ├── entrypoint.sh
│       ├── mvnw
│       └── mvnw.cmd
│
├── front_despacho/                             # Frontend React
│   ├── src/
│   │   ├── main.jsx
│   │   ├── index.css
│   │   ├── Routes/
│   │   │   └── AppRoutes.jsx
│   │   ├── componentes/
│   │   │   ├── CrudAdmin.jsx
│   │   │   ├── CrudAdmin/
│   │   │   │   ├── CardComponent.jsx
│   │   │   │   ├── FormDespacho.jsx
│   │   │   │   ├── FormCierreDespacho.jsx
│   │   │   │   ├── Modal.jsx
│   │   │   │   ├── TableDespachos.jsx
│   │   │   │   ├── TableCompras.jsx
│   │   │   │   ├── SearchBar.jsx
│   │   │   │   └── PruebaCards.jsx
│   │   │   ├── Layouts/
│   │   │   │   ├── Navbar.jsx
│   │   │   │   ├── Footer.jsx
│   │   │   │   ├── Carrusel.jsx
│   │   │   │   └── Reviews.jsx
│   │   │   └── __tests__/
│   │   │       └── CrudAdmin.test.jsx
│   │   └── assets/
│   │       └── images/
│   ├── public/
│   ├── vite.config.js
│   ├── tailwind.config.js
│   ├── postcss.config.js
│   ├── package.json
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── db.json
│   ├── index.html
│   └── README.md
│
├── Infrastructure/                             # Infraestructura como Código
│   ├── main.tf                                 # Configuración principal de Terraform
│   ├── variables.tf                            # Variables y parámetros
│   └── outputs.tf                              # Salidas de Terraform
│
├── docker-compose.yml                          # Orquestación local
└── README.md                                   # Este archivo
```

### Descripción de Componentes

#### **back-Ventas_SpringBoot**
Microservicio REST para gestionar ventas. Expone endpoints CRUD y comunica con MySQL.
- Puerto: `8080`
- Base de datos: `ventas_db`

#### **back-Despachos_SpringBoot**
Microservicio REST para gestionar despachos. Implementa CORS y Swagger.
- Puerto: `8081`
- Base de datos: `despachos_db`

#### **front_despacho**
Aplicación React que consume ambos microservicios. Incluye formularios, tablas y componentes interactivos.
- Puerto: `3000` (local) / `80` (AWS)
- Construida con Vite, compilada a contenedor con Nginx

#### **Infrastructure**
Código Terraform que automatiza el despliegue en AWS, incluyendo redes, seguridad y servicios.

---

## 🚀 Cómo Se Levanta

### Prerequisitos

#### Local (Docker Compose)
- Docker Desktop instalado y ejecutándose
- Git
- Archivo `.env` con las siguientes variables (En ese caso no se necesita crear, ya que esta incluido en el proyecto, si embargo en casos formales, esto si tendria que crearse):
  ```
  MYSQL_ROOT_PASSWORD=tu_contraseña
  MYSQL_USERNAME=root
  MYSQL_DATABASE_VENTAS=ventas_db
  MYSQL_DATABASE_DESPACHOS=despachos_db
  ```

#### AWS (Terraform)
- AWS CLI configurado con credenciales
- Terraform >= 1.0
- Key pair creado en EC2

### Levantamiento Local con Docker Compose

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/ProyectoSemestral-DevOps.git
   cd ProyectoSemestral-DevOps
   ```

2. **Crear archivo `.env`**
Este paso no es necesario por el momento, ya que al ser un proyecto academico, ya esta subido el archivo `.env`. Sin embargo, el entornos profesionales, esto no es una buena practica, en cuyo caso, este paso SI seria necesario.
   ```bash
   cat > .env << EOF
   MYSQL_ROOT_PASSWORD=password123
   MYSQL_USERNAME=root
   MYSQL_DATABASE_VENTAS=ventas_db
   MYSQL_DATABASE_DESPACHOS=despachos_db
   EOF
   ```

3. **Construir e iniciar los servicios**
   ```bash
   docker-compose up -d
   ```

4. **Esperar a que los servicios se inicien**
   - MySQL: http://localhost:3306 (healthcheck: 10 segundos)
   - Backend Ventas: http://localhost:8080
   - Backend Despachos: http://localhost:8081
   - Frontend: http://localhost:3000

5. **Verificar que todo funciona**
   ```bash
   # Ver logs de los servicios
   docker-compose logs -f

   # Verificar servicios en ejecución
   docker-compose ps
   ```

6. **Detener los servicios**
   ```bash
   docker-compose down

   # Con eliminación de volúmenes
   docker-compose down -v
   ```

### Comandos Útiles Docker Compose

```bash
# Reconstruir imágenes sin caché
docker-compose build --no-cache

# Ver logs en tiempo real
docker-compose logs -f [servicio]

# Ejecutar comando en un contenedor
docker-compose exec [servicio] [comando]

# Escalar un servicio
docker-compose up -d --scale [servicio]=N

# Eliminar volúmenes
docker-compose down -v
```

### Despliegue en AWS con Terraform

1. **Navegar al directorio de infraestructura**
   ```bash
   cd Infrastructure
   ```

2. **Inicializar Terraform**
   ```bash
   terraform init
   ```

3. **Validar la configuración**
   ```bash
   terraform plan
   ```

4. **Aplicar la infraestructura**
   Para este paso, primero tenemos que acceder al laboratorio AWS y crear un par de llaves.
   ```bash
   terraform apply -var="key_pair_name=despacho" -var="db_password=Despacho2026."
   ```

5. **Obtener salidas**
   ```bash
   terraform output
   ```

### Comandos Útiles Terraform

```bash
# Mostrar el plan sin aplicar
terraform plan

# Destruir toda la infraestructura
terraform destroy

# Mostrar el estado actual
terraform show

# Refrescar el estado
terraform refresh

# Obtener una salida específica
terraform output db_instance_ip
```

---

## 🏛️ Infraestructura Creada

### Arquitectura AWS

```
┌─────────────────────────────────────────────────────────┐
│                   AWS VPC (10.0.0.0/16)                 │
│                                                         │
│  ┌────────────────────────────────────────────────────┐ │
│  │        Public Subnet (10.0.1.0/24)                 │ │
│  │                                                    │ │
│  │  ┌──────────────────────────────────────────────┐  │ │
│  │  │  ECS Cluster (Fargate)                       │  │ │
│  │  │  ├─ Ventas Backend (8080)                    │  │ │
│  │  │  ├─ Despacho Backend (8081)                  │  │ │
│  │  │  └─ Frontend (80)                            │  │ │
│  │  └──────────────────────────────────────────────┘  │ │
│  │                                                    │ │
│  │  ┌──────────────────────────────────────────────┐  │ │
│  │  │  EC2 Instance (MySQL)                        │  │ │
│  │  │  └─ MySQL 8 Docker Container                 │  │ │
│  │  └──────────────────────────────────────────────┘  │ │
│  │                                                    │ │
│  └────────────────────────────────────────────────────┘ │
│                 ↓ Internet Gateway ↓                    │
└─────────────────────────────────────────────────────────┘
              ↓ Route Table / NAT ↓
            ┌──────────────────────────┐
            │   Internet (0.0.0.0/0)   │
            └──────────────────────────┘
```

### Componentes Terraform

#### **1. Networking (VPC)**
- VPC principal: `10.0.0.0/16`
- Subnet pública: `10.0.1.0/24`
- Internet Gateway para acceso a internet
- Tabla de rutas pública
- DNS habilitado

#### **2. Security Groups**
```
Ingress Rules:
├─ Puerto 22 (SSH) - 0.0.0.0/0
├─ Puerto 80 (HTTP) - 0.0.0.0/0
├─ Puerto 8080 (Ventas) - 0.0.0.0/0
├─ Puerto 8081 (Despacho) - 0.0.0.0/0
└─ Puerto 3306 (MySQL) - Interno (security group)

Egress:
└─ Todo (0.0.0.0/0)
```

#### **3. Registros ECR (Elastic Container Registry)**
Se crean tres repositorios privados:
- `despacho-sistema-despacho-backend` - Imagen de backend Despacho
- `despacho-sistema-ventas-backend` - Imagen de backend Ventas
- `despacho-sistema-frontend` - Imagen de frontend React

#### **4. EC2 Instance - Base de Datos**
- **Instancia**: `t3.micro` (eligible para free tier)
- **AMI**: Amazon Linux 2023
- **Almacenamiento**: 20GB gp3
- **Software**: Docker preinstalado
- **Servicio**: MySQL 8 como contenedor Docker
- **User Data**: Script de inicialización que instala Docker y levanta MySQL

#### **5. ECS Cluster - Fargate**
- **Cluster**: `despacho-sistema-cluster`
- **Launch Type**: Fargate (serverless)
- **Especificaciones**:
  - CPU: 2048 (2 vCPU)
  - Memoria: 4096 MB (4 GB)
- **Servicios**:
  - Ventas Backend (puerto 8080)
  - Despacho Backend (puerto 8081)
  - Frontend (puerto 80)
- **Dependencias de contenedores**: Frontend espera a que backend esté disponible

#### **6. CloudWatch Logs**
- Grupo de logs: `/ecs/despacho-sistema`
- Retención: 7 días
- Streams por contenedor:
  - `ventas` - Logs del backend de ventas
  - `despacho` - Logs del backend de despacho
  - `frontend` - Logs del frontend

#### **7. IAM Roles**
- Rol de ejecución: `LabRole` (asumido desde laboratorio AWS)
- Permisos: Pull de ECR, Write en CloudWatch

### Variables Terraform

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `aws_region` | Región AWS | `us-east-1` |
| `project_name` | Nombre del proyecto | `despacho-sistema` |
| `key_pair_name` | Key pair para EC2 SSH | `mi-key-pair` |
| `db_password` | Contraseña de MySQL | `SecurePass123!` |

### Outputs Terraform

```hcl
ecr_ventas_repository_url   # URL del ECR de ventas
ecr_despacho_repository_url # URL del ECR de despacho
ecr_frontend_repository_url # URL del ECR de frontend
db_instance_ip              # IP privada de la instancia MySQL
```

---

## ⚙️ Configuración

### Variables de Entorno - Docker Compose

`.env` (raíz del proyecto):
```bash
MYSQL_ROOT_PASSWORD=password123
MYSQL_USERNAME=root
MYSQL_DATABASE_VENTAS=ventas_db
MYSQL_DATABASE_DESPACHOS=despachos_db
```

### Configuración Backend - Spring Boot

**application.properties** (ambos backends):
```properties
spring.datasource.url=jdbc:mysql://${DB_ENDPOINT}:${DB_PORT}/${DB_NAME}
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
spring.jpa.hibernate.ddl-auto=update
springdoc.swagger-ui.path=/swagger-ui.html
```

Variables inyectadas en runtime:
- `DB_ENDPOINT` - Host del servidor MySQL
- `DB_PORT` - Puerto MySQL (3306)
- `DB_NAME` - Nombre de la base de datos
- `DB_USERNAME` - Usuario de la BD
- `DB_PASSWORD` - Contraseña de la BD

### Configuración Frontend - React

**vite.config.js**:
- Puerto de desarrollo: `5173`
- Carpeta de salida: `dist`
- Soporte SWC para compilación rápida

**tailwind.config.js**:
- Temas y colores personalizados
- Plugins de extensión

---

## 📡 Endpoints Disponibles

### Backend Ventas (Puerto 8080)

#### OpenAPI/Swagger
- **URL**: `http://localhost:8080/swagger-ui.html`
- **Especificación**: `http://localhost:8080/v3/api-docs`

#### Endpoints Principales
```
GET    /api/ventas           # Listar todas las ventas
GET    /api/ventas/{id}      # Obtener venta por ID
POST   /api/ventas           # Crear nueva venta
PUT    /api/ventas/{id}      # Actualizar venta
DELETE /api/ventas/{id}      # Eliminar venta
```

### Backend Despacho (Puerto 8081)

#### OpenAPI/Swagger
- **URL**: `http://localhost:8081/swagger-ui.html`
- **Especificación**: `http://localhost:8081/v3/api-docs`

#### Endpoints Principales
```
GET    /api/despacho           # Listar todos los despachos
GET    /api/despacho/{id}      # Obtener despacho por ID
POST   /api/despacho           # Crear nuevo despacho
PUT    /api/despacho/{id}      # Actualizar despacho
DELETE /api/despacho/{id}      # Eliminar despacho
POST   /api/despacho/{id}/cierre  # Cerrar despacho
```

#### CORS Configuration
- Origen permitido: `*` (todos los orígenes)
- Métodos permitidos: `GET`, `POST`, `PUT`, `DELETE`, `OPTIONS`

### Frontend React (Puerto 3000)

- **URL**: `http://localhost:3000`
- **Rutas principales**:
  - `/` - Página principal
  - `/admin` - Panel CRUD de despachos
  - `/admin/compras` - Tabla de compras

---

## 🧪 Testing

### Backend - Unit Tests

**Ventas Backend**:
```bash
cd back-Ventas_SpringBoot/Springboot-API-REST
mvn test
```

**Despacho Backend**:
```bash
cd back-Despachos_SpringBoot/Springboot-API-REST-DESPACHO
mvn test
```

### Frontend - Vitest

```bash
cd front_despacho
npm test
```

---

## 📊 Monitoreo y Logs

### Local (Docker Compose)

```bash
# Ver logs de todos los servicios
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f mysql
docker-compose logs -f venta
docker-compose logs -f despacho
docker-compose logs -f frontend

# Ver últimas 100 líneas
docker-compose logs --tail 100
```

### AWS (CloudWatch)

1. Acceder a CloudWatch Console en AWS
2. Ir a Logs > Log Groups
3. Seleccionar `/ecs/despacho-sistema`
4. Ver streams por contenedor

### Healthchecks

- **MySQL**: `mysqladmin ping -h localhost`
  - Intervalo: 10 segundos
  - Timeout: 5 segundos
  - Reintentos: 5

---

**Última actualización**: Mayo 2026
**Versión**: 1.0.0
