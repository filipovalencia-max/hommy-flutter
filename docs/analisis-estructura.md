# Análisis de Estructura - Web_Homyy (Next.js)

## 1. Estructura de Archivos

```
Web_Homyy/
├── src/
│   └── app/
│       ├── login/              # Autenticación
│       ├── register/           # Registro usuarios
│       ├── user/               # Panel de usuario
│       │   ├── dashboard/      # Dashboard principal
│       │   ├── perfil/         # Perfil usuario
│       │   ├── profesional/    # Perfil profesional
│       │   ├── profesionales/   # Buscar profesionales
│       │   ├── servicios/      # Gestión servicios
│       │   ├── crear-servicio/ # Crear nuevo servicio
│       │   ├── pagos/          # Pagos y escrow
│       │   ├── chats/          # Mensajería
│       │   ├── historial/     # Historial
│       │   └── notificaciones/
│       ├── admin/              # Panel admin
│       ├── auth/               # Auth (reset-password, callback)
│       ├── api/                # Endpoints API
│       │   ├── auth/
│       │   ├── services/
│       │   ├── notifications/
│       │   └── v2/
│       ├── test-supabase/
│       ├── test-modal/
│       ├── terminos-y-condiciones/
│       ├── layout.tsx
│       └── globals.css
├── supabase/
│   ├── schema-v2.sql
│   ├── schema-v2-complete.sql
│   └── schema-new.sql
├── scripts/                    # SQL scripts
├── public/                    # Assets estáticos
└── package.json
```

## 2. Módulos Funcionales

### 2.1 Autenticación
- **Login**: Email/password + Google OAuth
- **Registro**: Selección tipo usuario (cliente/trabajador)
- **Reset Password**: Via email
- **Phone Verify**: Verificación de teléfono

### 2.2 Usuario (Cliente)
- Dashboard principal
- Ver/Buscar profesionales
- Crear servicios
- Mis servicios publicados
- Historial de bookings
- Chats con trabajadores
- Notificaciones
- Perfil y configuración
- Pagos

### 2.3 Trabajador
- Perfil profesional (profesión, experiencia, tarifa)
- Postularse a servicios
- Aceptar/rechazar trabajos
- Chat con clientes
- Gestión de disponibilidad

### 2.4 Admin
- Dashboard admin
- Gestión de usuarios
- Estadísticas

## 3. API Endpoints

### Auth
- `POST /api/auth/register` - Registro
- `POST /api/auth/phone-verify/send` - Enviar código
- `POST /api/auth/phone-verify/verify` - Verificar código

### Servicios
- `GET/POST /api/services` - Listar/Crear servicios
- `GET/POST /api/v2/applications` - Postulaciones
- `GET/POST /api/v2/bookings` - Reservas

### Chat
- `GET/POST /api/v2/chat` - Mensajería

### Pagos
- Integración con escrow de Supabase

## 4. Base de Datos (Supabase)

### Tablas Principales
- `profiles_v2` - Perfiles de usuarios
- `worker_profiles_v2` - Perfiles profesionales
- `categories_v2` - Categorías de servicios
- `services_v2` - Servicios publicados
- `service_schedules_v2` - Horarios disponibles
- `applications_v2` - Postulaciones
- `bookings_v2` - Reservas
- `escrow_transactions_v2` - Transacciones de pago
- `chats` - Conversaciones
- `chat_messages` - Mensajes
- `notifications` - Notificaciones
- `notification_settings` - Configuración de notificaciones
- `terms` - Términos y condiciones

## 5. Tecnologías

- **Frontend**: Next.js 15, React 19, TypeScript, Tailwind CSS 4
- **Backend**: Supabase (Auth, Database, Realtime)
- **Estado**: React Context + Hooks
- **UI**: Componentes custom + Tailwind

## 6. Consideraciones para Flutter

### Mapear a Flutter
| Módulo Next.js | Equivalente Flutter |
|----------------|-------------------|
| Pages (app router) | Screens/Pages |
| Components | Widgets |
| API Routes | Servicios Dart |
| Supabase Client | Supabase Flutter SDK |
| Context API | Provider/Riverpod |
| Tailwind | Flutter widgets |

### Desafíos Identificados
1. **Auth**: Mantener sesión con Supabase Flutter
2. **Realtime**: Chat y notificaciones via Supabase Realtime
3. **OAuth Google**: Configurar SHA-1 en Firebase
4. **Navegación**: Adaptar patrones móvil vs web
5. **Estado**: Elegir solución de estado (Provider/Riverpod/BLoC)

## 7. Recomendaciones de Arquitectura Flutter

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── config/         # Configuración app
│   ├── constants/      # Constantes
│   ├── theme/          # Tema y estilos
│   └── utils/          # Utilidades
├── data/
│   ├── models/         # Modelos datos
│   ├── repositories/   # Repositorios
│   └── sources/        # Fuentes datos
├── domain/
│   ├── entities/       # Entidades
│   └── repositories/   # Contratos repositorios
├── presentation/
│   ├── pages/          # Pantallas
│   ├── widgets/        # Widgets reutilizables
│   └── providers/      # Estado
└── services/
    ├── auth/           # Autenticación
    ├── supabase/       # Cliente Supabase
    └── notifications/  # Notificaciones
```

---

**Analista**: Arquitecto de Solución  
**Fecha**: 2026-03-06  
**Estado**: Completado
