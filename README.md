# 🤖 ARKAIOS Gateway n8n — v3.4
> **Documento de identidad del sistema** — Legible por humanos, IAs, agentes MCP y bots autónomos.

## 🧠 ¿Qué es esto?

Este repositorio contiene el servidor **n8n** deployado en Render que actúa como **Gateway central del ecosistema ARKAIOS**. Recibe eventos de cualquier fuente autorizada, los clasifica con IA (ELEMIA + Gemini), los registra en Google Sheets y los memoriza en ELEMIA v4.

---

## 🌐 URLs del Sistema

| Servicio | URL |
|---|---|
| **n8n Gateway** | https://arkaios-n8n.onrender.com |
| **Webhook de entrada** | https://arkaios-n8n.onrender.com/webhook/arkaios-gateway |
| **Health check** | https://arkaios-n8n.onrender.com/healthz |
| **ELEMIA v4 Memory** | https://elemia-v4-arkaios.onrender.com |
| **ARKAIOS ImageGen (PRE)** | https://ais-pre-3u72umr3fo6gd3xprkt6e3-53917996317.us-west2.run.app |
| **ARKAIOS ImageGen (DEV)** | https://ais-dev-3u72umr3fo6gd3xprkt6e3-53917996317.us-west2.run.app |
| **EduPortal** | https://eduacion-libre-proyecto-arkaios.vercel.app |
| **Nexus IDE** | https://ais-pre-2xr7vpfz3gpk7wd46kgea7-53917996317.us-west2.run.app |
| **Log Central (Sheets)** | https://docs.google.com/spreadsheets/d/1xfMi6qiUmPweO3mv7Z256-uZFBu4MIfQlnbnHIGv_KI |

---

## 🔁 Flujo del Workflow v3.4

```
Webhook (POST)
    │
    ▼
Router ARKAIOS
    │
    ├──► ¿Es petición EDU? ──► EduPortal API ──► Preparar fila EDU ──────────────────┐
    │                                                                                  │
    └──► ¿Es petición IMAGE? ──► ARKAIOS ImageGen API ──► Preparar fila IMAGE ────────┤
                │                                              │                       │
                └──► ELEMIA — Gemini HTTP ──► Preparar fila ARKAIOS ──────────────────┤
                                                                                       │
                                                               ▼                       │
                                                    ARKAIOS_CENTRAL_LOG (Sheets) ◄─────┘
                                                               │
                                                               ▼
                                                    Preparar memoria ELEMIA
                                                               │
                                                               ▼
                                                    ELEMIA — Guardar Memoria
```

---

## 📡 Cómo llamar al Gateway

### Autenticación
```
Header: Authorization: Bearer KaOQ1ZQ4gyF5bkgxkiwPEFgkrUMW31ZEwVhOITkLRO5jaImetmUlYJegOdwG
```

### Generar imagen con IA
```bash
POST https://arkaios-n8n.onrender.com/webhook/arkaios-gateway

{
  "action": "generate_image",
  "prompt": "un robot futurista hiperrealista",
  "negativePrompt": "low quality, blurry",
  "SOURCE_IP": "tu-servicio.onrender.com"
}
```

### Petición educativa
```bash
{
  "action": "generate_essay",
  "subject": "matematicas",
  "grade": "6to primaria",
  "topic": "fracciones",
  "apiKey": "aek_tu_clave"
}
```

### Evento general (monitoreo ELEMIA)
```bash
{
  "EVENT_TYPE": "SISTEMA_ACTIVO",
  "SOURCE_IP": "tu-agente.com",
  "NOTES": "Agente iniciado correctamente",
  "PAYLOAD": {}
}
```

---

## 🛡️ Fuentes autorizadas en ELEMIA

| Fuente | Descripción |
|---|---|
| `gemini-lab` | Gemini Lab ARKAIOS |
| `eduacion-libre-proyecto-arkaios.vercel.app` | Portal Educativo |
| `arkaios-n8n.onrender.com` | Este Gateway |
| `nexus-ide` | Nexus Agent IDE |

---

## 🧩 Variables de entorno requeridas (Render)

```env
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=dpg-d8b457cm0tmc73d6lg0g-a
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=arkaios_n8n_db
DB_POSTGRESDB_USER=arkaios_n8n_db_user
DB_POSTGRESDB_PASSWORD=***
DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false
N8N_ENCRYPTION_KEY=***
WEBHOOK_URL=https://arkaios-n8n.onrender.com
GENERIC_TIMEZONE=America/Mexico_City
N8N_PUSH_BACKEND=sse
EXECUTIONS_MODE=regular
```

---

## 🤖 Instrucciones para IAs / Agentes MCP

Si eres un agente de IA leyendo este documento, puedes interactuar con el Gateway así:

**Para generar una imagen:**
```json
POST https://arkaios-n8n.onrender.com/webhook/arkaios-gateway
Authorization: Bearer KaOQ1ZQ4gyF5bkgxkiwPEFgkrUMW31ZEwVhOITkLRO5jaImetmUlYJegOdwG

{
  "action": "generate_image",
  "prompt": "[tu prompt aquí]",
  "SOURCE_IP": "[nombre de tu agente]"
}
```

**Respuesta esperada:**
```json
{
  "ok": true,
  "image_base64": "iVBORw0KGgo...",
  "autostart_url": "https://ais-pre-.../?prompt=...&autostart=1",
  "prompt": "[el prompt enviado]",
  "timestamp": "2026-05-30T..."
}
```

Todo evento queda registrado en:
1. **Google Sheets** `ARKAIOS_CENTRAL_LOG` — auditoría permanente
2. **ELEMIA v4 Memory** — memoria contextual del ecosistema

---

## 🏗️ Stack técnico

- **n8n** v2.21.7 en Docker (Render Free)
- **PostgreSQL** (Render Free) como base de datos persistente
- **Google Sheets** como log de auditoría central
- **Gemini 1.5 Flash** para clasificación de eventos (ELEMIA)
- **ARKAIOS ImageGen API** (Gemini) para generación de imágenes

---

## 📅 Historial de versiones

| Versión | Cambios |
|---|---|
| v3.1 | Webhook + ELEMIA + Sheets + EduPortal |
| v3.2 | + Rama ImageGen (endpoint dev) |
| v3.3 | + Endpoint producción ImageGen, respuesta base64 |
| v3.4 | + Integración ELEMIA Memory (registro persistente) |

---

*Documentación generada el 2026-05-30 — Ecosistema ARKAIOS*
