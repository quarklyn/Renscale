#!/bin/sh

/app/tailscaled \
    --state=/var/lib/tailscale/tailscaled.state \
    --socket=/var/run/tailscale/tailscaled.sock \
    --tun=userspace-networking \
    --socks5-server=localhost:1055 \
    --outbound-http-proxy-listen=localhost:1055 &

until /app/tailscale up \
    --authkey=${TAILSCALE_AUTHKEY} \
    --hostname=${TAILSCALE_HOSTNAME}-${PORT} \
    --advertise-exit-node \
    ${TAILSCALE_ADDITIONAL_ARGS}
do
    sleep 0.1
done

echo "Tailscale is running!"

gunicorn \
    --bind 0.0.0.0:${PORT} \
    --workers 1 \
    --threads 1 \
    app.wsgi:app
