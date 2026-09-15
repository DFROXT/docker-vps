#!/bin/bash
set -e
echo "⚡ DOCKER VPS STARTING ⚡"

# Ensure SSH
service ssh start || /usr/sbin/sshd

# ngrok config
mkdir -p /root/.config/ngrok
cat > /root/.config/ngrok/ngrok.yml << 'NGROK'
version: "2"
authtoken: 3JMMJhaOrnFLjzfjxED5lKtSDUC_6zU7PysQ7zihRCXpabUXs
tunnels:
  ssh:
    proto: tcp
    addr: 22
  web:
    proto: http
    addr: 8080
NGROK

ngrok start --all --config /root/.config/ngrok/ngrok.yml --log=stdout &
sleep 6
echo "📡 TUNNELS:"
curl -s http://localhost:4040/api/tunnels || true
echo ""
echo "🔥 READY - root:dev"
tail -f /dev/null
