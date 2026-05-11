FROM n8nio/n8n:latest

# Puerto que usa Render
ENV N8N_PORT=10000
ENV N8N_PROTOCOL=https
ENV N8N_HOST=arkaios-n8n.onrender.com
ENV WEBHOOK_URL=https://arkaios-n8n.onrender.com

EXPOSE 10000

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
