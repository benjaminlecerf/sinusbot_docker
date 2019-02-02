cat > docker-compose.yml << 'EOF'
sinusbot-container:
  image: 'docker.io/galexrt/sinusbot'
  container_name: "APP_IDENTIFIER"
  hostname: "APP_HOSTNAME"
  restart: unless-stopped
  ports:
    - 'HOST_PORT:8087'
  volumes:
    - './data:/sinusbot/data'
    - './scripts:/sinusbot/scripts'
  environment:
    - SINUS_USER=3000
    - SINUS_GROUP=3000
EOF
docker-compose up -d
