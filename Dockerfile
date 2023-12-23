FROM python:alpine

WORKDIR /app

COPY /app/requirements.txt /app/tailscale.d/

RUN pip install --no-cache-dir -r /app/tailscale.d/requirements.txt

ENV TAILSCALE_VERSION "latest"
ENV TAILSCALE_HOSTNAME "Renscale"
ENV TAILSCALE_ADDITIONAL_ARGS ""

RUN wget https://pkgs.tailscale.com/stable/tailscale_${TAILSCALE_VERSION}_amd64.tgz && \
  tar xzf tailscale_${TAILSCALE_VERSION}_amd64.tgz --strip-components=1

RUN apk update && apk add ca-certificates iptables ip6tables && rm -rf /var/cache/apk/*

RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

COPY . .
CMD /app/tailscale.d/start.sh