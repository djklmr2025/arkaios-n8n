# arkaios-n8n

Blueprint de Render para desplegar `n8n` con `Render Postgres`.

## Qué cambió

- Se reemplazó el despliegue con `Dockerfile` custom por la imagen oficial `docker.io/n8nio/n8n:1.83.2`.
- Se cambió `SQLite` por `Postgres`, porque Render recomienda esa ruta para Blueprint y plan free.
- El `render.yaml` ahora define:
  - un servicio web `arkaios-n8n`
  - una base `arkaios-n8n-db`

## Deploy en Render

1. Sube estos cambios a tu repo `djklmr2025/arkaios-n8n`
2. En Render entra a `New > Blueprint`
3. Conecta ese repo
4. Antes de desplegar, llena estos valores:
   - `N8N_HOST`
   - `WEBHOOK_URL`
   - `N8N_EDITOR_BASE_URL`
- `N8N_PUSH_BACKEND`: Needs to be set to `websocket` to allow UI live-updates and collaboration features on platforms that do not support Server-Sent Events easily (like some PaaS platforms). WebSocket push provides more stable connection for the n8n UI on Render.
5. Lanza el Blueprint

## Valores sugeridos

Si tu URL final queda, por ejemplo, en:

`https://arkaios-n8n.onrender.com`

usa:

- `N8N_HOST=arkaios-n8n.onrender.com`
- `WEBHOOK_URL=https://arkaios-n8n.onrender.com/`
- `N8N_EDITOR_BASE_URL=https://arkaios-n8n.onrender.com/`

## Nota importante

Render free tiene límites:

- el web service se duerme por inactividad
- la base Postgres free expira a los 30 días
- cada workspace suele tener límite de una base free

## Fuentes

- Render n8n docs: https://render.com/docs/deploy-n8n
- Render n8n template: https://github.com/render-examples/n8n
