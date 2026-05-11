FROM n8nio/n8n:latest

USER root
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n
USER node

ENV N8N_PORT=10000
ENV N8N_PROTOCOL=https
ENV N8N_HOST=arkaios-n8n.onrender.com
ENV WEBHOOK_URL=https://arkaios-n8n.onrender.com
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE_FILE=/home/node/.n8n/database.sqlite
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_HIRING_BANNER_ENABLED=false
ENV N8N_RUNNERS_ENABLED=false

EXPOSE 10000

CMD ["n8n", "start"]
