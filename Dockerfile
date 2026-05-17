FROM node:18-alpine

RUN apk add --no-cache python3 make g++ git curl tini

# Instalar n8n como root para que quede en /usr/local/bin
RUN npm install -g n8n@1.22.6 --omit=dev

# Verificar que el binario existe
RUN which n8n && n8n --version

# Crear directorio de datos
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

USER node
WORKDIR /home/node

ENV PATH="/usr/local/bin:$PATH"
ENV N8N_PORT=10000
ENV N8N_PROTOCOL=https
ENV N8N_HOST=arkaios-n8n.onrender.com
ENV WEBHOOK_URL=https://arkaios-n8n.onrender.com
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE_FILE=/home/node/.n8n/database.sqlite
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_HIRING_BANNER_ENABLED=false
ENV N8N_RUNNERS_ENABLED=false
ENV GENERIC_TIMEZONE=America/Mexico_City
ENV NODE_OPTIONS=--max-old-space-size=256
ENV N8N_USER_MANAGEMENT_DISABLED=true

EXPOSE 10000

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["n8n", "start"]
