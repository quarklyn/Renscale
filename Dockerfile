FROM python:alpine

WORKDIR /app

COPY /app/requirements.txt /app/app/

RUN pip install --no-cache-dir -r /app/app/requirements.txt

ENV TAILSCALE_VERSION "latest"
ENV TAILSCALE_HOSTNAME "Renscale"
ENV TAILSCALE_ADDITIONAL_ARGS ""

RUN wget https://pkgs.tailscale.com/stable/tailscale_${TAILSCALE_VERSION}_amd64.tgz && \
  tar xzf tailscale_${TAILSCALE_VERSION}_amd64.tgz --strip-components=1

RUN apk update && apk add ca-certificates iptables ip6tables && rm -rf /var/cache/apk/*

RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

COPY . .
CMD /app/app/start.sh